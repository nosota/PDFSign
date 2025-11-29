import 'dart:io';
import 'dart:typed_data';

import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/domain/entities/placed_object.dart';
import 'package:pdfsign/domain/repositories/pdf_repository.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Abstract interface for PDF operations
abstract class PdfDataSource {
  /// Open PDF file
  Future<int> openPdf({required String path, String? password});

  /// Close current PDF
  Future<void> closePdf();

  /// Get current PDF path
  String? getCurrentPdfPath();

  /// Get page count
  int getPageCount();

  /// Check if requires password
  Future<bool> requiresPassword(String path);

  /// Verify password
  Future<bool> verifyPassword({required String path, required String password});

  /// Render page as image
  Future<Uint8List> renderPage({required int pageNumber, int dpi = 150});

  /// Get page size
  Future<Size> getPageSize(int pageNumber);

  /// Save PDF with placed objects
  Future<void> savePdf({
    required List<PlacedObject> placedObjects,
    required Map<String, Uint8List> signatureItems,
    String? outputPath,
  });

  /// Check if write protected
  Future<bool> isWriteProtected();

  /// Get metadata
  Future<PdfMetadata> getMetadata();
}

/// Implementation using Syncfusion PDF
class PdfDataSourceImpl implements PdfDataSource {
  PdfDocument? _document;
  String? _currentPath;

  @override
  Future<int> openPdf({required String path, String? password}) async {
    try {
      // Close existing document
      await closePdf();

      // Read file
      final file = File(path);
      if (!await file.exists()) {
        throw FileNotFoundException('PDF file not found: $path');
      }

      final bytes = await file.readAsBytes();

      // Try to load document
      try {
        _document = PdfDocument(inputBytes: bytes, password: password);
      } on PdfPasswordException {
        throw PasswordRequiredException('PDF requires password');
      } on PdfException catch (e) {
        if (e.message?.contains('password') ?? false) {
          throw PasswordIncorrectException(message: 'Incorrect password');
        }
        throw CorruptedPdfException('Failed to load PDF: ${e.message}');
      }

      _currentPath = path;

      return _document!.pages.count;
    } catch (e) {
      if (e is AppException) rethrow;
      throw UnknownFailure(e.toString()) as Never;
    }
  }

  @override
  Future<void> closePdf() async {
    try {
      _document?.dispose();
      _document = null;
      _currentPath = null;
    } catch (e) {
      throw StorageException('Failed to close PDF: ${e.toString()}');
    }
  }

  @override
  String? getCurrentPdfPath() => _currentPath;

  @override
  int getPageCount() {
    if (_document == null) {
      throw const StorageException('No PDF document is open');
    }
    return _document!.pages.count;
  }

  @override
  Future<bool> requiresPassword(String path) async {
    try {
      final file = File(path);
      if (!await file.exists()) {
        throw FileNotFoundException('PDF file not found: $path');
      }

      final bytes = await file.readAsBytes();

      try {
        final testDoc = PdfDocument(inputBytes: bytes);
        testDoc.dispose();
        return false;
      } on PdfPasswordException {
        return true;
      } catch (_) {
        return false;
      }
    } catch (e) {
      if (e is AppException) rethrow;
      throw UnknownFailure(e.toString()) as Never;
    }
  }

  @override
  Future<bool> verifyPassword({
    required String path,
    required String password,
  }) async {
    try {
      final file = File(path);
      if (!await file.exists()) {
        throw FileNotFoundException('PDF file not found: $path');
      }

      final bytes = await file.readAsBytes();

      try {
        final testDoc = PdfDocument(inputBytes: bytes, password: password);
        testDoc.dispose();
        return true;
      } on PdfException {
        return false;
      }
    } catch (e) {
      if (e is AppException) rethrow;
      throw UnknownFailure(e.toString()) as Never;
    }
  }

  @override
  Future<Uint8List> renderPage({required int pageNumber, int dpi = 150}) async {
    try {
      if (_document == null) {
        throw const StorageException('No PDF document is open');
      }

      final page = _document!.pages[pageNumber];
      final image = await page.toImage(dpi: dpi);

      return image;
    } catch (e) {
      if (e is AppException) rethrow;
      throw StorageException('Failed to render page: ${e.toString()}');
    }
  }

  @override
  Future<Size> getPageSize(int pageNumber) async {
    try {
      if (_document == null) {
        throw const StorageException('No PDF document is open');
      }

      final page = _document!.pages[pageNumber];
      final pageSize = page.size;

      return Size(pageSize.width, pageSize.height);
    } catch (e) {
      if (e is AppException) rethrow;
      throw StorageException('Failed to get page size: ${e.toString()}');
    }
  }

  @override
  Future<void> savePdf({
    required List<PlacedObject> placedObjects,
    required Map<String, Uint8List> signatureItems,
    String? outputPath,
  }) async {
    try {
      if (_document == null) {
        throw const StorageException('No PDF document is open');
      }

      // Group objects by page
      final objectsByPage = <int, List<PlacedObject>>{};
      for (final obj in placedObjects) {
        objectsByPage.putIfAbsent(obj.pageNumber, () => []).add(obj);
      }

      // Draw objects on each page
      for (final entry in objectsByPage.entries) {
        final pageNumber = entry.key;
        final pageObjects = entry.value;

        final page = _document!.pages[pageNumber];
        final graphics = page.graphics;

        // Sort by z-index (draw lower z-index first)
        pageObjects.sort((a, b) => a.zIndex.compareTo(b.zIndex));

        for (final obj in pageObjects) {
          final imageData = signatureItems[obj.signatureId];
          if (imageData == null) continue;

          // Create bitmap from image data
          final bitmap = PdfBitmap(imageData);

          // Save graphics state
          final state = graphics.save();

          // Apply transformations
          // Note: PDF coordinates are bottom-left origin, Flutter is top-left
          // Need to convert coordinates
          final pageHeight = page.size.height;
          final y = pageHeight - obj.position.dy - obj.size.height;

          graphics.translateTransform(obj.position.dx, y);

          // Rotate around center of object
          if (obj.rotation != 0) {
            graphics.translateTransform(
              obj.size.width / 2,
              obj.size.height / 2,
            );
            graphics.rotateTransform(-obj.rotation); // Negative for clockwise
            graphics.translateTransform(
              -obj.size.width / 2,
              -obj.size.height / 2,
            );
          }

          // Draw image
          graphics.drawImage(
            bitmap,
            Rect.fromLTWH(0, 0, obj.size.width, obj.size.height),
          );

          // Restore graphics state
          graphics.restore(state);
        }
      }

      // Save to file
      final bytes = await _document!.save();
      final output = outputPath ?? _currentPath;

      if (output == null) {
        throw const SaveException('No output path specified');
      }

      final outputFile = File(output);
      await outputFile.writeAsBytes(bytes);
    } catch (e) {
      if (e is AppException) rethrow;
      throw SaveException('Failed to save PDF: ${e.toString()}');
    }
  }

  @override
  Future<bool> isWriteProtected() async {
    try {
      if (_document == null) {
        throw const StorageException('No PDF document is open');
      }

      // Check if document has security settings that prevent modifications
      final security = _document!.security;
      if (security.userPassword.isNotEmpty) {
        // Has password protection
        return !security.permissions.contains(PdfPermissionsFlags.editContent);
      }

      return false;
    } catch (e) {
      // If we can't determine, assume not protected
      return false;
    }
  }

  @override
  Future<PdfMetadata> getMetadata() async {
    try {
      if (_document == null) {
        throw const StorageException('No PDF document is open');
      }

      final info = _document!.documentInformation;

      return PdfMetadata(
        title: info.title,
        author: info.author,
        subject: info.subject,
        keywords: info.keywords,
        creator: info.creator,
        producer: info.producer,
        creationDate: info.creationDate,
        modifiedDate: info.modificationDate,
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw StorageException('Failed to get metadata: ${e.toString()}');
    }
  }
}
