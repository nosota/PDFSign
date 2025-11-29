import 'dart:typed_data';

import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/domain/entities/placed_object.dart';

/// Repository interface for PDF operations
abstract class PdfRepository {
  /// Open a PDF file from the given path
  ///
  /// [path] - Absolute path to the PDF file
  /// [password] - Optional password if the PDF is protected
  ///
  /// Returns the number of pages in the PDF
  ResultFuture<int> openPdf({
    required String path,
    String? password,
  });

  /// Close the currently open PDF
  ResultFutureVoid closePdf();

  /// Get the current PDF file path
  ResultFuture<String?> getCurrentPdfPath();

  /// Get the number of pages in the current PDF
  ResultFuture<int> getPageCount();

  /// Check if a PDF requires a password
  ///
  /// [path] - Absolute path to the PDF file
  ResultFuture<bool> requiresPassword(String path);

  /// Verify if a password is correct for a PDF
  ///
  /// [path] - Absolute path to the PDF file
  /// [password] - Password to verify
  ResultFuture<bool> verifyPassword({
    required String path,
    required String password,
  });

  /// Render a specific page of the PDF as an image
  ///
  /// [pageNumber] - Page number (0-indexed)
  /// [dpi] - Resolution for rendering
  ///
  /// Returns the rendered page as binary image data
  ResultFuture<Uint8List> renderPage({
    required int pageNumber,
    int dpi = 150,
  });

  /// Get the dimensions of a specific page
  ///
  /// [pageNumber] - Page number (0-indexed)
  ///
  /// Returns Size with width and height in points
  ResultFuture<Size> getPageSize(int pageNumber);

  /// Save the PDF with placed objects
  ///
  /// [placedObjects] - List of objects to place on the PDF
  /// [signatureItems] - Map of signature IDs to their image data
  /// [outputPath] - Optional output path (if null, overwrites original)
  ResultFutureVoid savePdf({
    required List<PlacedObject> placedObjects,
    required Map<String, Uint8List> signatureItems,
    String? outputPath,
  });

  /// Check if the current PDF is write-protected
  ResultFuture<bool> isWriteProtected();

  /// Get PDF metadata
  ResultFuture<PdfMetadata> getMetadata();
}

/// PDF metadata information
class PdfMetadata {
  final String? title;
  final String? author;
  final String? subject;
  final String? keywords;
  final String? creator;
  final String? producer;
  final DateTime? creationDate;
  final DateTime? modifiedDate;

  const PdfMetadata({
    this.title,
    this.author,
    this.subject,
    this.keywords,
    this.creator,
    this.producer,
    this.creationDate,
    this.modifiedDate,
  });
}
