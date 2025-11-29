import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/domain/entities/placed_object.dart';
import 'package:pdfsign/presentation/providers/infrastructure/repository_providers.dart';

part 'pdf_viewer_provider.g.dart';

/// PDF document state
class PdfDocumentState {
  final String? filePath;
  final int? pageCount;
  final bool isLoading;
  final String? error;

  const PdfDocumentState({
    this.filePath,
    this.pageCount,
    this.isLoading = false,
    this.error,
  });

  PdfDocumentState copyWith({
    String? filePath,
    int? pageCount,
    bool? isLoading,
    String? error,
  }) {
    return PdfDocumentState(
      filePath: filePath ?? this.filePath,
      pageCount: pageCount ?? this.pageCount,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// State notifier for PDF document
@riverpod
class PdfDocument extends _$PdfDocument {
  @override
  PdfDocumentState build() => const PdfDocumentState();

  /// Open PDF file
  Future<void> openPdf({required String path, String? password}) async {
    state = state.copyWith(isLoading: true, error: null);

    final repository = ref.read(pdfRepositoryProvider);
    final result = await repository.openPdf(path: path, password: password);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (pageCount) {
        state = PdfDocumentState(
          filePath: path,
          pageCount: pageCount,
          isLoading: false,
        );
      },
    );
  }

  /// Close PDF
  Future<void> closePdf() async {
    final repository = ref.read(pdfRepositoryProvider);
    await repository.closePdf();
    state = const PdfDocumentState();
  }

  /// Render page
  Future<Uint8List?> renderPage({required int pageNumber, int dpi = 150}) async {
    final repository = ref.read(pdfRepositoryProvider);
    final result = await repository.renderPage(pageNumber: pageNumber, dpi: dpi);

    return result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
        return null;
      },
      (imageData) => imageData,
    );
  }

  /// Get page size
  Future<Size?> getPageSize(int pageNumber) async {
    final repository = ref.read(pdfRepositoryProvider);
    final result = await repository.getPageSize(pageNumber);

    return result.fold(
      (failure) => null,
      (size) => size,
    );
  }
}

/// Current zoom level provider
@riverpod
class ZoomLevel extends _$ZoomLevel {
  @override
  double build() => 1.0; // 100%

  void setZoom(double zoom) {
    state = zoom.clamp(0.1, 5.0);
  }

  void zoomIn() {
    state = (state + 0.1).clamp(0.1, 5.0);
  }

  void zoomOut() {
    state = (state - 0.1).clamp(0.1, 5.0);
  }

  void resetZoom() {
    state = 1.0;
  }
}

/// Current page number provider (0-indexed)
@riverpod
class CurrentPage extends _$CurrentPage {
  @override
  int build() => 0;

  void setPage(int page) {
    final docState = ref.read(pdfDocumentProvider);
    if (docState.pageCount != null) {
      state = page.clamp(0, docState.pageCount! - 1);
    }
  }

  void nextPage() {
    final docState = ref.read(pdfDocumentProvider);
    if (docState.pageCount != null && state < docState.pageCount! - 1) {
      state++;
    }
  }

  void previousPage() {
    if (state > 0) {
      state--;
    }
  }
}
