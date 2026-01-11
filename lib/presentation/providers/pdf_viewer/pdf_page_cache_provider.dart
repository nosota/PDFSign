import 'dart:collection';
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/presentation/providers/repository_providers.dart';

part 'pdf_page_cache_provider.g.dart';

/// Cache entry for a rendered PDF page.
class PageCacheEntry {
  PageCacheEntry({
    required this.pageNumber,
    required this.scale,
    required this.bytes,
  }) : timestamp = DateTime.now();

  final int pageNumber;
  final double scale;
  final Uint8List bytes;
  final DateTime timestamp;

  /// Cache key combining page number and scale.
  String get key => '${pageNumber}_$scale';
}

/// LRU cache for rendered PDF pages.
///
/// Keeps up to [maxCacheSize] pages in memory, evicting least recently
/// used entries when the limit is exceeded.
class PdfPageCache {
  PdfPageCache({this.maxCacheSize = 10});

  final int maxCacheSize;
  final LinkedHashMap<String, PageCacheEntry> _cache = LinkedHashMap();

  /// Gets a cached page, or null if not found.
  /// Updates LRU order if found.
  PageCacheEntry? get(int pageNumber, double scale) {
    final key = '${pageNumber}_$scale';
    final entry = _cache.remove(key);
    if (entry != null) {
      // Re-insert to update LRU order
      _cache[key] = entry;
    }
    return entry;
  }

  /// Adds or updates a page in the cache.
  void put(PageCacheEntry entry) {
    final key = entry.key;

    // Remove existing entry if present
    _cache.remove(key);

    // Evict oldest entries if at capacity
    while (_cache.length >= maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }

    _cache[key] = entry;
  }

  /// Removes a specific page from the cache.
  void remove(int pageNumber, double scale) {
    final key = '${pageNumber}_$scale';
    _cache.remove(key);
  }

  /// Removes all entries for a specific page (all scales).
  void removeAllForPage(int pageNumber) {
    _cache.removeWhere((key, _) => key.startsWith('${pageNumber}_'));
  }

  /// Clears all cached pages.
  void clear() {
    _cache.clear();
  }

  /// Returns true if the page is cached at the given scale.
  bool contains(int pageNumber, double scale) {
    final key = '${pageNumber}_$scale';
    return _cache.containsKey(key);
  }

  /// Number of entries in the cache.
  int get length => _cache.length;
}

/// Provider for the PDF page cache.
@Riverpod(keepAlive: true)
PdfPageCache pdfPageCache(PdfPageCacheRef ref) {
  return PdfPageCache();
}

/// Provider for rendering a PDF page with caching.
///
/// Returns the rendered page bytes, using cache if available.
/// The [pageNumber] parameter is 1-based.
@riverpod
Future<Uint8List?> pdfPageImage(
  PdfPageImageRef ref, {
  required int pageNumber,
  required double scale,
}) async {
  final cache = ref.watch(pdfPageCacheProvider);
  final repository = ref.watch(pdfDocumentRepositoryProvider);

  // Check cache first
  final cached = cache.get(pageNumber, scale);
  if (cached != null) {
    return cached.bytes;
  }

  // Render the page
  final result = await repository.renderPage(
    pageNumber: pageNumber,
    scale: scale,
  );

  return result.fold(
    (failure) {
      // Don't cache failures
      return null;
    },
    (bytes) {
      // Cache the result
      cache.put(PageCacheEntry(
        pageNumber: pageNumber,
        scale: scale,
        bytes: bytes,
      ));
      return bytes;
    },
  );
}

/// Provider for tracking which pages should be rendered.
///
/// Pages within the visible range plus buffer are rendered,
/// others are cancelled.
@riverpod
class VisiblePages extends _$VisiblePages {
  static const int _bufferSize = 2;

  @override
  Set<int> build() {
    return {};
  }

  /// Updates the visible page range based on scroll position.
  void updateVisibleRange({
    required int firstVisible,
    required int lastVisible,
    required int totalPages,
  }) {
    final start = (firstVisible - _bufferSize).clamp(1, totalPages);
    final end = (lastVisible + _bufferSize).clamp(1, totalPages);

    final newVisible = <int>{};
    for (int i = start; i <= end; i++) {
      newVisible.add(i);
    }

    // Cancel renders for pages no longer in range
    final repository = ref.read(pdfDocumentRepositoryProvider);
    for (final pageNumber in state) {
      if (!newVisible.contains(pageNumber)) {
        repository.cancelRender(pageNumber);
      }
    }

    state = newVisible;
  }

  /// Checks if a page should be rendered.
  bool shouldRender(int pageNumber) {
    return state.contains(pageNumber);
  }
}
