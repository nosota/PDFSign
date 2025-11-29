import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:pdfsign/domain/entities/placed_object.dart' as domain;
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Service for saving PDF documents with placed objects
class PdfSaveService {
  /// Save PDF with placed signatures/stamps
  Future<void> savePdf({
    required String sourcePdfPath,
    required String destinationPath,
    required List<domain.PlacedObject> placedObjects,
    required Map<String, SignatureItem> signatureItems,
  }) async {
    // Load the existing PDF document
    final PdfDocument document = PdfDocument(
      inputBytes: await File(sourcePdfPath).readAsBytes(),
    );

    try {
      // Sort objects by z-index to maintain correct layering
      final sortedObjects = List<domain.PlacedObject>.from(placedObjects)
        ..sort((a, b) => a.zIndex.compareTo(b.zIndex));

      // Place each object on its respective page
      for (final obj in sortedObjects) {
        final signatureItem = signatureItems[obj.signatureId];
        if (signatureItem == null) continue;

        // Get the page
        if (obj.pageNumber >= 0 && obj.pageNumber < document.pages.count) {
          final page = document.pages[obj.pageNumber];

          // Create image from signature data
          final image = PdfBitmap(signatureItem.imageData);

          // Calculate position and size
          // Note: PDF coordinate system has origin at bottom-left
          // Flutter uses top-left origin, so we need to convert
          final pageHeight = page.size.height;
          final x = obj.position.dx;
          final y = pageHeight - obj.position.dy - obj.size.height;

          // Create graphics state for transformations
          final graphics = page.graphics;

          // Save current graphics state
          graphics.save();

          // Apply transformations
          if (obj.rotation != 0) {
            // Translate to center of image
            graphics.translateTransform(
              x + obj.size.width / 2,
              y + obj.size.height / 2,
            );

            // Rotate (convert degrees to radians)
            graphics.rotateTransform(-obj.rotation); // Negative for PDF coordinate system

            // Translate back
            graphics.translateTransform(
              -obj.size.width / 2,
              -obj.size.height / 2,
            );

            // Draw image at origin
            graphics.drawImage(
              image,
              ui.Rect.fromLTWH(0, 0, obj.size.width, obj.size.height),
            );
          } else {
            // No rotation, draw directly
            graphics.drawImage(
              image,
              ui.Rect.fromLTWH(x, y, obj.size.width, obj.size.height),
            );
          }

          // Restore graphics state
          graphics.restore();
        }
      }

      // Save the document
      final List<int> bytes = await document.save();
      await File(destinationPath).writeAsBytes(bytes);
    } finally {
      // Dispose the document
      document.dispose();
    }
  }

  /// Get a suggested file name for saving
  String getSuggestedFileName(String originalPath) {
    final file = File(originalPath);
    final fileName = file.uri.pathSegments.last;
    final nameWithoutExtension = fileName.replaceAll('.pdf', '');
    final now = DateTime.now();
    final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';

    return '${nameWithoutExtension}_signed_$timestamp.pdf';
  }
}
