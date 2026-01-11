import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';

part 'pdf_viewer_state.freezed.dart';

/// Available zoom levels for PDF viewing.
enum ZoomLevel {
  fitWidth('Fit Width', null),
  percent50('50%', 0.5),
  percent75('75%', 0.75),
  percent100('100%', 1.0),
  percent125('125%', 1.25),
  percent150('150%', 1.5),
  percent200('200%', 2.0);

  const ZoomLevel(this.label, this.scale);

  /// Display label for the zoom level.
  final String label;

  /// Scale factor, or null for fitWidth (calculated dynamically).
  final double? scale;

  /// Returns the next zoom level (for zoom in).
  ZoomLevel? get next {
    final index = ZoomLevel.values.indexOf(this);
    if (index < ZoomLevel.values.length - 1) {
      return ZoomLevel.values[index + 1];
    }
    return null;
  }

  /// Returns the previous zoom level (for zoom out).
  ZoomLevel? get previous {
    final index = ZoomLevel.values.indexOf(this);
    if (index > 0) {
      return ZoomLevel.values[index - 1];
    }
    return null;
  }
}

/// State for the PDF viewer.
@freezed
class PdfViewerState with _$PdfViewerState {
  const factory PdfViewerState.initial() = PdfViewerInitial;

  const factory PdfViewerState.loading({
    required String filePath,
  }) = PdfViewerLoading;

  const factory PdfViewerState.loaded({
    required PdfDocumentInfo document,
    required ZoomLevel zoomLevel,
    required double effectiveScale,
    required int currentPage,
    required double viewportWidth,
  }) = PdfViewerLoaded;

  const factory PdfViewerState.error({
    required String message,
    String? filePath,
  }) = PdfViewerError;

  const factory PdfViewerState.passwordRequired({
    required String filePath,
  }) = PdfViewerPasswordRequired;
}

/// Extension to add convenience methods to PdfViewerState.
extension PdfViewerStateX on PdfViewerState {
  /// Returns the current document info if loaded.
  PdfDocumentInfo? get documentOrNull => maybeMap(
        loaded: (state) => state.document,
        orElse: () => null,
      );

  /// Returns whether a document is loaded.
  bool get isLoaded => this is PdfViewerLoaded;

  /// Returns whether the viewer is in loading state.
  bool get isLoading => this is PdfViewerLoading;

  /// Returns whether there's an error.
  bool get hasError => this is PdfViewerError;
}
