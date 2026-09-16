import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

export 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';

part 'pdf_document_provider.g.dart';

/// Provider for managing PDF document loading and state.
///
/// Handles document loading, continuous zoom, and page navigation.
@Riverpod(keepAlive: true)
class PdfDocument extends _$PdfDocument {
  @override
  PdfViewerState build() {
    return const PdfViewerState.initial();
  }

  /// Opens a PDF document from the given file path.
  ///
  /// If [initialPage] is provided, the document will open at that page
  /// (clamped to valid range). Otherwise opens at page 1.
  Future<void> openDocument(String filePath, {int? initialPage}) async {
    // Clear page cache before loading new document
    // (old renders may be stale, especially after Save As)
    ref.read(pdfPageCacheProvider).clear();

    state = PdfViewerState.loading(filePath: filePath);

    final repository = ref.read(pdfDocumentRepositoryProvider);
    final result = await repository.openDocument(filePath);

    result.fold(
      (failure) => _reportFailure(failure, filePath),
      (document) {
        // Use initialPage if provided, otherwise default to 1
        final page = initialPage != null
            ? initialPage.clamp(1, document.pageCount)
            : 1;

        state = PdfViewerState.loaded(
          document: document,
          scale: 1.0,
          isFitWidth: true,
          fitWidthScale: 1.0,
          currentPage: page,
          viewportWidth: 0,
          viewportHeight: 0,
        );
      },
    );
  }

  /// Opens a password-protected PDF document.
  Future<void> openProtectedDocument(String filePath, String password) async {
    state = PdfViewerState.loading(filePath: filePath);

    final repository = ref.read(pdfDocumentRepositoryProvider);
    final result = await repository.openProtectedDocument(filePath, password);

    result.fold(
      (failure) => _reportFailure(failure, filePath),
      (document) {
        state = PdfViewerState.loaded(
          document: document,
          scale: 1.0,
          isFitWidth: true,
          fitWidthScale: 1.0,
          currentPage: 1,
          viewportWidth: 0,
          viewportHeight: 0,
        );
      },
    );
  }

  /// Puts a failed open on screen.
  ///
  /// A document that wants a password and one that turned a password down are
  /// the same screen: the reader is being asked for the password either way,
  /// and the difference is only whether to say the last one was wrong.
  void _reportFailure(Failure failure, String filePath) {
    state = switch (failure) {
      PasswordRequiredFailure() =>
        PdfViewerState.passwordRequired(filePath: filePath),
      PasswordIncorrectFailure() =>
        PdfViewerState.passwordRequired(filePath: filePath, wasWrong: true),
      _ => PdfViewerState.error(
          message: failure.message,
          filePath: filePath,
          code: failure.code,
        ),
    };
  }

  /// Closes the current document.
  Future<void> closeDocument() async {
    final repository = ref.read(pdfDocumentRepositoryProvider);
    await repository.closeDocument();
    state = const PdfViewerState.initial();
  }

  /// Reloads the current document, preserving the current page.
  ///
  /// Sets the scale to a specific value (continuous zoom).
  /// Returns true if scale was changed, false if already at limit.
  bool setScale(double newScale) {
    var changed = false;
    state.maybeMap(
      loaded: (current) {
        final clampedScale = newScale.clamp(
          ZoomConstraints.minScale,
          ZoomConstraints.maxScale,
        );
        // Skip if scale didn't change (already at limit)
        if ((clampedScale - current.scale).abs() < 0.001) {
          return;
        }
        state = current.copyWith(
          scale: clampedScale,
          isFitWidth: false,
        );
        changed = true;
      },
      orElse: () {},
    );
    return changed;
  }

  /// Multiplies the current scale by a factor (for pinch-to-zoom).
  void multiplyScale(double factor) {
    state.maybeMap(
      loaded: (current) {
        final newScale = current.scale * factor;
        final clampedScale = newScale.clamp(
          ZoomConstraints.minScale,
          ZoomConstraints.maxScale,
        );
        state = current.copyWith(
          scale: clampedScale,
          isFitWidth: false,
        );
      },
      orElse: () {},
    );
  }

  /// Zooms to fit width mode.
  void fitToWidth() {
    state.maybeMap(
      loaded: (current) {
        state = current.copyWith(
          scale: current.fitWidthScale,
          isFitWidth: true,
        );
      },
      orElse: () {},
    );
  }

  /// Zooms in to the next preset level (for Cmd+).
  /// Does nothing if already at max scale.
  void zoomInStep() {
    state.maybeMap(
      loaded: (current) {
        // Skip if already at max scale
        if (current.scale >= ZoomConstraints.maxScale - 0.001) {
          return;
        }
        final nextPreset = ZoomPreset.nextPresetAbove(current.scale);
        if (nextPreset != null && nextPreset.scale != null) {
          state = current.copyWith(
            scale: nextPreset.scale!,
            isFitWidth: false,
          );
        } else {
          // At max preset, increase by step
          final newScale = (current.scale + ZoomConstraints.zoomStep)
              .clamp(ZoomConstraints.minScale, ZoomConstraints.maxScale);
          state = current.copyWith(
            scale: newScale,
            isFitWidth: false,
          );
        }
      },
      orElse: () {},
    );
  }

  /// Zooms out to the previous preset level (for Cmd-).
  /// Does nothing if already at min scale.
  void zoomOutStep() {
    state.maybeMap(
      loaded: (current) {
        // Skip if already at min scale
        if (current.scale <= ZoomConstraints.minScale + 0.001) {
          return;
        }
        final prevPreset = ZoomPreset.nextPresetBelow(current.scale);
        if (prevPreset != null && prevPreset.scale != null) {
          state = current.copyWith(
            scale: prevPreset.scale!,
            isFitWidth: false,
          );
        } else {
          // At min preset, decrease by step
          final newScale = (current.scale - ZoomConstraints.zoomStep)
              .clamp(ZoomConstraints.minScale, ZoomConstraints.maxScale);
          state = current.copyWith(
            scale: newScale,
            isFitWidth: false,
          );
        }
      },
      orElse: () {},
    );
  }

  /// Turns one page by [quarterTurns] quarter turns clockwise.
  ///
  /// Only the page's own description changes; the rendered bitmap is left
  /// alone, because the renderer works from the file and the difference is
  /// applied when the page is drawn. Turning a page therefore costs no
  /// re-render and no cache eviction.
  void rotatePage(int pageNumber, int quarterTurns) {
    state.maybeMap(
      loaded: (current) {
        final index = pageNumber - 1;
        final pages = current.document.pages;
        if (index < 0 || index >= pages.length || quarterTurns % 4 == 0) {
          return;
        }

        final rotated = [...pages];
        rotated[index] = pages[index].rotated(quarterTurns);
        state = current.copyWith(
          document: current.document.copyWith(pages: rotated),
        );
      },
      orElse: () {},
    );
  }

  /// Records the pages as written, which makes their rotation clean again.
  ///
  /// Called after a save to the same file, where the document is not reloaded
  /// and so nothing else would tell the pages that the file has caught up.
  void markRotationsSaved() {
    state.maybeMap(
      loaded: (current) {
        final pages = current.document.pages;
        if (!pages.any((page) => page.isRotatedFromFile)) {
          return;
        }
        state = current.copyWith(
          document: current.document.copyWith(
            pages: [
              for (final page in pages)
                page.copyWith(fileRotation: page.rotation),
            ],
          ),
        );
      },
      orElse: () {},
    );
  }

  /// Sets the current page number (1-based).
  void setCurrentPage(int pageNumber) {
    state.maybeMap(
      loaded: (current) {
        final clampedPage = pageNumber.clamp(1, current.document.pageCount);
        if (clampedPage != current.currentPage) {
          state = current.copyWith(currentPage: clampedPage);
        }
      },
      orElse: () {},
    );
  }

  /// Goes to the next page.
  void nextPage() {
    state.maybeMap(
      loaded: (current) {
        if (current.currentPage < current.document.pageCount) {
          state = current.copyWith(currentPage: current.currentPage + 1);
        }
      },
      orElse: () {},
    );
  }

  /// Goes to the previous page.
  void previousPage() {
    state.maybeMap(
      loaded: (current) {
        if (current.currentPage > 1) {
          state = current.copyWith(currentPage: current.currentPage - 1);
        }
      },
      orElse: () {},
    );
  }

  /// Updates the viewport dimensions.
  void updateViewport(double width, double height) {
    state.maybeMap(
      loaded: (current) {
        if (width != current.viewportWidth ||
            height != current.viewportHeight) {
          final fitWidthScale = _calculateFitWidthScale(width, current.document);
          final newScale = current.isFitWidth ? fitWidthScale : current.scale;

          state = current.copyWith(
            viewportWidth: width,
            viewportHeight: height,
            fitWidthScale: fitWidthScale,
            scale: newScale,
          );
        }
      },
      orElse: () {},
    );
  }

  double _calculateFitWidthScale(double viewportWidth, PdfDocumentInfo document) {
    if (viewportWidth <= 0 || document.pages.isEmpty) {
      return 1.0;
    }

    // Find the widest page
    double maxPageWidth = 0;
    for (final page in document.pages) {
      if (page.width > maxPageWidth) {
        maxPageWidth = page.width;
      }
    }

    if (maxPageWidth <= 0) {
      return 1.0;
    }

    // Account for horizontal padding (40px on each side)
    const horizontalPadding = 80.0;
    final availableWidth = viewportWidth - horizontalPadding;

    return availableWidth / maxPageWidth;
  }
}
