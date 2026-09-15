import 'dart:math' as math;
import 'dart:ui';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer_constants.dart';

/// Geometry of the continuous page column shown by the PDF viewer.
///
/// This is the single source of truth for where pages sit. Both the widget
/// that lays the pages out and the drop target that hit-tests them derive
/// positions from here, so the two can never drift apart.
///
/// All coordinates are **content coordinates**: the scrollable content's own
/// space, with the origin at the top-left of the scroll extent. Subtract the
/// scroll offset to get viewport coordinates.
///
/// Construction is O(page count) and allocates one list of page offsets;
/// lookups are then O(log n). Callers that query per scroll tick should hold
/// on to an instance rather than rebuilding it.
class PdfPageLayout {
  /// Builds the layout for [document] rendered at [scale] inside a viewport
  /// of [viewportWidth] logical pixels.
  factory PdfPageLayout({
    required PdfDocumentInfo document,
    required double scale,
    required double viewportWidth,
  }) {
    assert(scale > 0, 'scale must be positive');
    return PdfPageLayout._(
      document: document,
      scale: scale,
      viewportWidth: viewportWidth,
      contentWidth: _contentWidthFor(document, scale),
      totalHeight: totalHeightFor(document, scale),
      pageTops: _pageTopsFor(document, scale),
    );
  }

  PdfPageLayout._({
    required this.document,
    required this.scale,
    required this.viewportWidth,
    required this.contentWidth,
    required this.totalHeight,
    required List<double> pageTops,
  }) : _pageTops = pageTops;

  /// The document being laid out.
  final PdfDocumentInfo document;

  /// Render scale (1.0 = 100%).
  final double scale;

  /// Width of the viewport the column is measured against.
  final double viewportWidth;

  /// Width of the widest page at [scale].
  final double contentWidth;

  /// Height of the whole scrollable column, including top and bottom padding.
  final double totalHeight;

  /// Content-space top edge of each page, in document order.
  final List<double> _pageTops;

  /// Number of pages.
  int get pageCount => _pageTops.length;

  /// Whether the column is wider than the viewport and scrolls sideways.
  bool get needsHorizontalScroll => contentWidth > viewportWidth;

  /// Padding on each side of the column. Only present while scrolling
  /// horizontally, where it produces the "floating page" inset.
  double get horizontalPadding =>
      needsHorizontalScroll ? PdfViewerConstants.horizontalPadding : 0;

  /// Total width of the scrollable content.
  double get effectiveWidth => needsHorizontalScroll
      ? contentWidth + PdfViewerConstants.horizontalPadding * 2
      : math.max(contentWidth, viewportWidth);

  /// Width of the band the pages are centred within.
  double get columnWidth => effectiveWidth - horizontalPadding * 2;

  /// Size of page [index] at [scale].
  Size scaledPageSize(int index) {
    final page = document.pages[index];
    return Size(page.width * scale, page.height * scale);
  }

  /// Content-space top edge of page [index].
  double pageTop(int index) => _pageTops[index];

  /// Content-space rectangle occupied by page [index].
  Rect pageRect(int index) {
    final size = scaledPageSize(index);
    final left = horizontalPadding + (columnWidth - size.width) / 2;
    return Rect.fromLTWH(left, _pageTops[index], size.width, size.height);
  }

  /// Index of the page containing [point], or null if it falls in a gap, in
  /// the side margin, or outside the column entirely.
  int? pageIndexAt(Offset point) {
    final index = _pageStartingAtOrBefore(point.dy);
    if (index < 0) {
      return null;
    }
    return pageRect(index).contains(point) ? index : null;
  }

  /// Index of the page closest to [point], measured to the page rectangle.
  ///
  /// Used to resolve a drop that lands off-page. Ties resolve to the earlier
  /// page. Linear in page count, which is fine for a once-per-gesture call.
  ///
  /// Returns null for a document with no pages.
  int? nearestPageIndex(Offset point) {
    if (pageCount == 0) {
      return null;
    }
    var best = 0;
    var bestDistance = double.infinity;
    for (var i = 0; i < pageCount; i++) {
      final distance = _squaredDistanceToRect(pageRect(i), point);
      if (distance < bestDistance) {
        bestDistance = distance;
        best = i;
      }
    }
    return best;
  }

  /// Range of 1-based page numbers intersecting the viewport, or null when
  /// the document has no pages.
  ({int first, int last})? visiblePageNumbers({
    required double scrollOffset,
    required double viewportHeight,
  }) {
    if (pageCount == 0) {
      return null;
    }
    final viewportBottom = scrollOffset + viewportHeight;

    var first = _pageStartingAtOrBefore(scrollOffset);
    if (first < 0) {
      first = 0;
    }
    // The search lands on the page above when the offset sits in a gap.
    while (first < pageCount - 1 &&
        _pageTops[first] + scaledPageSize(first).height < scrollOffset) {
      first++;
    }
    if (_pageTops[first] > viewportBottom) {
      return null;
    }

    var last = first;
    while (last + 1 < pageCount && _pageTops[last + 1] <= viewportBottom) {
      last++;
    }
    return (first: first + 1, last: last + 1);
  }

  /// 1-based number of the page under [centerY], counting the first half of
  /// the gap below a page as still belonging to it.
  int pageNumberAtCenter(double centerY) {
    if (pageCount == 0) {
      return 1;
    }
    final index = _pageStartingAtOrBefore(centerY);
    if (index < 0) {
      return 1;
    }
    final bottom = _pageTops[index] + scaledPageSize(index).height;
    if (centerY < bottom + PdfViewerConstants.pageGap / 2) {
      return index + 1;
    }
    return math.min(index + 2, pageCount);
  }

  /// Scroll offset that brings the 1-based [pageNumber] into view, centring it
  /// vertically when it is shorter than the viewport.
  ///
  /// The result is unclamped; callers clamp it to the scroll extent.
  double scrollOffsetForPage(
    int pageNumber, {
    required double viewportHeight,
  }) {
    if (pageCount == 0) {
      return 0;
    }
    final index = (pageNumber - 1).clamp(0, pageCount - 1);
    final height = scaledPageSize(index).height;
    final offset = _pageTops[index];
    if (height >= viewportHeight) {
      return offset;
    }
    return offset - (viewportHeight - height) / 2;
  }

  /// Height of the whole column for [document] at [scale], without needing a
  /// viewport width. Used when comparing two scales during a zoom.
  static double totalHeightFor(PdfDocumentInfo document, double scale) {
    final pages = document.pages;
    var total = PdfViewerConstants.verticalPadding * 2;
    if (pages.isEmpty) {
      return total;
    }
    for (final page in pages) {
      total += page.height * scale;
    }
    return total + PdfViewerConstants.pageGap * (pages.length - 1);
  }

  /// Greatest page index whose top edge is at or above [y], or -1 if [y] sits
  /// above the first page.
  int _pageStartingAtOrBefore(double y) {
    var low = 0;
    var high = _pageTops.length - 1;
    var result = -1;
    while (low <= high) {
      final mid = (low + high) >> 1;
      if (_pageTops[mid] <= y) {
        result = mid;
        low = mid + 1;
      } else {
        high = mid - 1;
      }
    }
    return result;
  }

  static double _squaredDistanceToRect(Rect rect, Offset point) {
    double dx = 0;
    if (point.dx < rect.left) {
      dx = rect.left - point.dx;
    } else if (point.dx > rect.right) {
      dx = point.dx - rect.right;
    }

    double dy = 0;
    if (point.dy < rect.top) {
      dy = rect.top - point.dy;
    } else if (point.dy > rect.bottom) {
      dy = point.dy - rect.bottom;
    }

    return dx * dx + dy * dy;
  }

  static double _contentWidthFor(PdfDocumentInfo document, double scale) {
    var maxWidth = 0.0;
    for (final page in document.pages) {
      final width = page.width * scale;
      if (width > maxWidth) {
        maxWidth = width;
      }
    }
    return maxWidth;
  }

  static List<double> _pageTopsFor(PdfDocumentInfo document, double scale) {
    final tops = <double>[];
    var y = PdfViewerConstants.verticalPadding;
    for (final page in document.pages) {
      tops.add(y);
      y += page.height * scale + PdfViewerConstants.pageGap;
    }
    return List.unmodifiable(tops);
  }
}

/// Keeps the most recent [PdfPageLayout] alive so repeated queries during a
/// scroll or a drag do not rebuild the page offsets on every event.
///
/// Rebuilds only when the document, scale or viewport width changes.
class PdfPageLayoutCache {
  PdfPageLayout? _layout;

  /// The layout built by the last [of] call, or null before the first one.
  PdfPageLayout? get current => _layout;

  /// Returns the layout for these inputs, reusing the cached one when it
  /// still applies.
  PdfPageLayout of({
    required PdfDocumentInfo document,
    required double scale,
    required double viewportWidth,
  }) {
    final cached = _layout;
    if (cached != null &&
        cached.scale == scale &&
        cached.viewportWidth == viewportWidth &&
        identical(cached.document, document)) {
      return cached;
    }
    return _layout = PdfPageLayout(
      document: document,
      scale: scale,
      viewportWidth: viewportWidth,
    );
  }
}
