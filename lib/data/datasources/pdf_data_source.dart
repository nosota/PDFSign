import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;

import 'package:pdfsign/core/platform/pdf_security_channel.dart';
import 'package:pdfsign/core/utils/page_rotation_transform.dart';
import 'package:pdfsign/data/datasources/protected_pdf_reader.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
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
  PdfDataSourceImpl({ProtectedPdfReader? protectedReader})
      : _protectedReader = protectedReader ?? const ProtectedPdfReader();

  /// Opens documents the renderer cannot open by itself.
  final ProtectedPdfReader _protectedReader;

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
  Future<PdfDocumentInfo> openDocument(String filePath) => _open(filePath, null);

  @override
  Future<PdfDocumentInfo> openProtectedDocument(
    String filePath,
    String password,
  ) =>
      _open(filePath, password);

  /// Opens [filePath], taking the protected route only when it is protected.
  ///
  /// The document already open is closed only once the new one has been read.
  /// An open that fails — a wrong password, most of all — leaves the reader
  /// looking at what they were looking at before, rather than at nothing.
  Future<PdfDocumentInfo> _open(String filePath, String? password) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw PathNotFoundException(
        filePath,
        const OSError('No such file or directory'),
      );
    }

    final protection = await PdfSecurityChannel.inspect(filePath);
    final opened = protection != null && protection.isEncrypted
        ? await _readProtected(file, password)
        // Read straight from the file, which is what keeps a large document
        // out of memory. Only a protected one has to be held there.
        : (document: await PdfDocument.openFile(filePath), contents: null);

    final PdfDocumentInfo info;
    try {
      info = await _extractDocumentInfo(
        filePath,
        opened.document,
        rotations: opened.contents?.rotations,
        security: opened.contents?.security ??
            const DocumentSecurity.unprotected(),
      );
    } catch (_) {
      // The document that was already open is still the one on screen, so the
      // one that failed has nobody to close it but this.
      await opened.document.close();
      rethrow;
    }

    await closeDocument();
    _document = opened.document;
    _documentInfo = info;
    return info;
  }

  /// Reads a protected document through the PDF writer and opens the copy.
  Future<({PdfDocument document, ProtectedPdfContents contents})> _readProtected(
    File file,
    String? password,
  ) async {
    final bytes = await file.readAsBytes();

    // Whatever the reader cannot handle it names itself; a failure from
    // anywhere else — a damaged cross-reference table, say — is a broken
    // document and must not be reported as an unsupported protection.
    final contents = await _protectedReader.read(bytes, password: password);

    return (
      document: await PdfDocument.openData(contents.renderableBytes),
      contents: contents,
    );
  }

  Future<PdfDocumentInfo> _extractDocumentInfo(
    String filePath,
    PdfDocument document, {
    List<int>? rotations,
    DocumentSecurity security = const DocumentSecurity.unprotected(),
  }) async {
    final fileName = filePath.split('/').last;
    final pageCount = document.pagesCount;
    // A protected document was already parsed to be opened at all, and its
    // rotations came back with it; reading them again would mean asking for
    // the password a second time.
    final pageRotations = _fitToPages(
      rotations ?? await _readPageRotations(filePath),
      pageCount,
    );
    final pages = <PdfPageInfo>[];

    for (int i = 1; i <= pageCount; i++) {
      final page = await document.getPage(i);
      // pdfx reports the media box, which is the page before `/Rotate` is
      // applied, while it renders the page with `/Rotate` applied. Reporting
      // the displayed size here is what keeps the page column and the image
      // inside it the same shape.
      final rotation = pageRotations[i - 1];
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
      security: security,
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
  Future<List<int>> _readPageRotations(String filePath) async {
    try {
      final bytes = await File(filePath).readAsBytes();
      final document = sf.PdfDocument(inputBytes: bytes);
      final rotations = [
        for (var i = 0; i < document.pages.count; i++)
          document.pages[i].rotation.index * 90,
      ];
      document.dispose();
      return rotations;
    } catch (e) {
      return const [];
    }
  }

  /// Makes a rotation per page, however many the reader of them found.
  ///
  /// The two PDF libraries can disagree about how many pages a document has.
  /// The renderer decides, because it is what the reader will actually see; a
  /// page it knows about and the other does not is shown unturned.
  static List<int> _fitToPages(List<int> rotations, int pageCount) {
    if (rotations.length == pageCount) return rotations;
    return [
      for (var i = 0; i < pageCount; i++)
        i < rotations.length ? rotations[i] : 0,
    ];
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
