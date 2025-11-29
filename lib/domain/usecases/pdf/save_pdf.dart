import 'dart:typed_data';

import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/domain/entities/placed_object.dart';
import 'package:pdfsign/domain/repositories/pdf_repository.dart';

/// Use case for saving a PDF with placed objects
class SavePdf {
  final PdfRepository _repository;

  const SavePdf(this._repository);

  /// Execute the use case
  ///
  /// [placedObjects] - List of objects to place on the PDF
  /// [signatureItems] - Map of signature IDs to their image data
  /// [outputPath] - Optional output path (if null, overwrites original)
  ResultFutureVoid call({
    required List<PlacedObject> placedObjects,
    required Map<String, Uint8List> signatureItems,
    String? outputPath,
  }) async {
    return _repository.savePdf(
      placedObjects: placedObjects,
      signatureItems: signatureItems,
      outputPath: outputPath,
    );
  }
}
