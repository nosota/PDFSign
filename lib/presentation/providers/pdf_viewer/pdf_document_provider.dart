import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

export 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';

part 'pdf_document_provider.g.dart';

/// Provider for managing PDF document loading and state.
///
/// This is the main provider for PDF viewer state management.
/// It handles document loading, zoom level changes, and page navigation.
@Riverpod(keepAlive: true)
class PdfDocument extends _$PdfDocument {
  @override
  PdfViewerState build() {
    return const PdfViewerState.initial();
  }

  /// Opens a PDF document from the given file path.
  Future<void> openDocument(String filePath) async {
    state = PdfViewerState.loading(filePath: filePath);

    final repository = ref.read(pdfDocumentRepositoryProvider);
    final result = await repository.openDocument(filePath);

    result.fold(
      (failure) {
        if (failure is PasswordRequiredFailure) {
          state = PdfViewerState.passwordRequired(filePath: filePath);
        } else {
          state = PdfViewerState.error(
            message: failure.message,
            filePath: filePath,
          );
        }
      },
      (document) {
        state = PdfViewerState.loaded(
          document: document,
          zoomLevel: ZoomLevel.fitWidth,
          effectiveScale: 1.0,
          currentPage: 1,
          viewportWidth: 0,
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
      (failure) {
        if (failure is PasswordIncorrectFailure) {
          state = PdfViewerState.error(
            message: 'Incorrect password',
            filePath: filePath,
          );
        } else {
          state = PdfViewerState.error(
            message: failure.message,
            filePath: filePath,
          );
        }
      },
      (document) {
        state = PdfViewerState.loaded(
          document: document,
          zoomLevel: ZoomLevel.fitWidth,
          effectiveScale: 1.0,
          currentPage: 1,
          viewportWidth: 0,
        );
      },
    );
  }

  /// Closes the current document.
  Future<void> closeDocument() async {
    final repository = ref.read(pdfDocumentRepositoryProvider);
    await repository.closeDocument();
    state = const PdfViewerState.initial();
  }

  /// Sets the zoom level.
  void setZoomLevel(ZoomLevel zoomLevel) {
    state.maybeMap(
      loaded: (current) {
        final effectiveScale = _calculateEffectiveScale(
          zoomLevel,
          current.viewportWidth,
          current.document,
        );
        state = current.copyWith(
          zoomLevel: zoomLevel,
          effectiveScale: effectiveScale,
        );
      },
      orElse: () {},
    );
  }

  /// Zooms in to the next zoom level.
  void zoomIn() {
    state.maybeMap(
      loaded: (current) {
        final nextLevel = current.zoomLevel.next;
        if (nextLevel != null) {
          setZoomLevel(nextLevel);
        }
      },
      orElse: () {},
    );
  }

  /// Zooms out to the previous zoom level.
  void zoomOut() {
    state.maybeMap(
      loaded: (current) {
        final previousLevel = current.zoomLevel.previous;
        if (previousLevel != null) {
          setZoomLevel(previousLevel);
        }
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

  /// Updates the viewport width for fitWidth calculation.
  void updateViewportWidth(double width) {
    state.maybeMap(
      loaded: (current) {
        if (width != current.viewportWidth && width > 0) {
          final effectiveScale = _calculateEffectiveScale(
            current.zoomLevel,
            width,
            current.document,
          );
          state = current.copyWith(
            viewportWidth: width,
            effectiveScale: effectiveScale,
          );
        }
      },
      orElse: () {},
    );
  }

  double _calculateEffectiveScale(
    ZoomLevel zoomLevel,
    double viewportWidth,
    PdfDocumentInfo document,
  ) {
    if (zoomLevel.scale != null) {
      return zoomLevel.scale!;
    }

    // fitWidth: calculate scale based on viewport width
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

    // Account for padding (40px on each side)
    const horizontalPadding = 80.0;
    final availableWidth = viewportWidth - horizontalPadding;

    return availableWidth / maxPageWidth;
  }
}
