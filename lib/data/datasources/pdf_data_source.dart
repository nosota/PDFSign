import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;

import 'package:pdfsign/core/utils/page_rotation_transform.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';

/// Data source interface for PDF operations.
abstract class PdfDataSource {
  /// Opens a PDF document from the given file path.
  Future<PdfDocumentInfo> openDocument(String filePath);

  /// Opens a password-protected PDF document.
  Future<PdfDocumentInfo> openProtectedDocument(
    String filePath,
    String password,
  );

  /// Renders a page at the specified scale.
  ///
  /// [pageNumber] is 1-based.
  /// [scale] is the zoom factor (1.0 = 100%).
  Future<Uint8List> renderPage({
    required int pageNumber,
    required double scale,
  });

  /// Cancels any pending render operation for the specified page.
  void cancelRender(int pageNumber);

  /// Closes the currently opened document.
  Future<void> closeDocument();

  /// Whether a document is currently loaded.
  bool get isDocumentLoaded;

  /// The currently loaded document info, or null if none.
  PdfDocumentInfo? get currentDocument;
}

/// Implementation of [PdfDataSource] using pdfx library.
class PdfDataSourceImpl implements PdfDataSource {
  PdfDocument? _document;
  PdfDocumentInfo? _documentInfo;

  /// Counter for generating unique render IDs.
  int _renderIdCounter = 0;

  /// Maps page number to the current active render ID.
  /// Only the render with this ID should complete successfully.
  final Map<int, int> _activeRenderIds = {};

  /// Maps render ID to its completer.
  final Map<int, Completer<Uint8List>> _pendingRenders = {};

  @override
  bool get isDocumentLoaded => _document != null;

  @override
  PdfDocumentInfo? get currentDocument => _documentInfo;

  @override
  Future<PdfDocumentInfo> openDocument(String filePath) async {
    await closeDocument();

    _document = await PdfDocument.openFile(filePath);
    _documentInfo = await _extractDocumentInfo(filePath, _document!);

    return _documentInfo!;
  }

  @override
  Future<PdfDocumentInfo> openProtectedDocument(
    String filePath,
    String password,
  ) async {
    await closeDocument();

    _document = await PdfDocument.openFile(filePath, password: password);
    _documentInfo = await _extractDocumentInfo(filePath, _document!);

    return _documentInfo!;
  }

  Future<PdfDocumentInfo> _extractDocumentInfo(
    String filePath,
    PdfDocument document,
  ) async {
    final fileName = filePath.split('/').last;
    final pageCount = document.pagesCount;
    final rotations = await _readPageRotations(filePath, pageCount);
    final pages = <PdfPageInfo>[];

    for (int i = 1; i <= pageCount; i++) {
      final page = await document.getPage(i);
      // pdfx reports the media box, which is the page before `/Rotate` is
      // applied, while it renders the page with `/Rotate` applied. Reporting
      // the displayed size here is what keeps the page column and the image
      // inside it the same shape.
      final rotation = rotations[i - 1];
      final displayed = PageRotationTransform.displaySize(
        Size(page.width, page.height),
        rotation,
      );
      pages.add(PdfPageInfo(
        pageNumber: i,
        width: displayed.width,
        height: displayed.height,
        rotation: rotation,
        fileRotation: rotation,
      ));
      await page.close();
    }

    return PdfDocumentInfo(
      filePath: filePath,
      fileName: fileName,
      pageCount: pageCount,
      pages: pages,
    );
  }

  /// Reads each page's `/Rotate` from the file.
  ///
  /// pdfx knows the rotation internally but does not expose it, so the file is
  /// read a second time with the PDF writer this app already depends on.
  /// Measured at 77 ms for a 300-page document, and the bytes are still in the
  /// operating system's cache from opening it.
  ///
  /// A file this fails on is shown unrotated rather than not at all: a wrong
  /// orientation is a visible annoyance, a refusal to open is a lost document.
  Future<List<int>> _readPageRotations(String filePath, int pageCount) async {
    try {
      final bytes = await File(filePath).readAsBytes();
      final document = sf.PdfDocument(inputBytes: bytes);
      final rotations = [
        for (var i = 0; i < document.pages.count; i++)
          document.pages[i].rotation.index * 90,
      ];
      document.dispose();

      if (rotations.length < pageCount) {
        // The two libraries disagree about the page count. Trust the renderer,
        // which is what the reader will actually see.
        rotations.addAll(List.filled(pageCount - rotations.length, 0));
      }
      return rotations;
    } catch (e) {
      return List.filled(pageCount, 0);
    }
  }

  @override
  Future<Uint8List> renderPage({
    required int pageNumber,
    required double scale,
  }) async {
    if (_document == null) {
      throw StateError('No document loaded');
    }

    // Generate unique render ID for this request
    final renderId = ++_renderIdCounter;

    // Cancel any previous render for this page and set new active ID
    _activeRenderIds[pageNumber] = renderId;

    final completer = Completer<Uint8List>();
    _pendingRenders[renderId] = completer;

    try {
      // Check if this render is still active before expensive operations
      if (_activeRenderIds[pageNumber] != renderId) {
        throw RenderCancelledException(pageNumber);
      }

      final page = await _document!.getPage(pageNumber);

      // Check again after async operation
      if (_activeRenderIds[pageNumber] != renderId) {
        await page.close();
        throw RenderCancelledException(pageNumber);
      }

      final pageImage = await page.render(
        width: page.width * scale,
        height: page.height * scale,
        format: PdfPageImageFormat.png,
        backgroundColor: '#FFFFFF',
      );

      await page.close();

      // Final check before completing - only complete if still active
      if (_activeRenderIds[pageNumber] != renderId) {
        throw RenderCancelledException(pageNumber);
      }

      final bytes = pageImage!.bytes;
      completer.complete(bytes);
      return bytes;
    } catch (e) {
      if (e is RenderCancelledException) {
        rethrow;
      }
      completer.completeError(e);
      rethrow;
    } finally {
      _pendingRenders.remove(renderId);
    }
  }

  @override
  void cancelRender(int pageNumber) {
    // Remove active render ID - any ongoing render for this page will fail
    // its check and throw RenderCancelledException
    _activeRenderIds.remove(pageNumber);
  }

  @override
  Future<void> closeDocument() async {
    // Clear all active renders
    _activeRenderIds.clear();
    _pendingRenders.clear();

    if (_document != null) {
      await _document!.close();
      _document = null;
      _documentInfo = null;
    }
  }
}

/// Exception thrown when a render operation is cancelled.
class RenderCancelledException implements Exception {
  final int pageNumber;

  RenderCancelledException(this.pageNumber);

  @override
  String toString() => 'Render cancelled for page $pageNumber';
}
