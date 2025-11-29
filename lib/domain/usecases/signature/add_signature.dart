import 'dart:typed_data';

import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/domain/repositories/signature_repository.dart';

/// Use case for adding a new signature to the library
class AddSignature {
  final SignatureRepository _repository;

  const AddSignature(this._repository);

  /// Execute the use case
  ///
  /// [imageData] - Binary image data
  /// [name] - User-provided name/label
  /// [originalFileName] - Original file name
  /// [mimeType] - MIME type of the image
  ResultFuture<SignatureItem> call({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  }) async {
    return _repository.addSignature(
      imageData: imageData,
      name: name,
      originalFileName: originalFileName,
      mimeType: mimeType,
    );
  }
}
