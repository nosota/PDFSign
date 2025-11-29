import 'dart:typed_data';

import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';

/// Repository interface for managing signature and stamp library
abstract class SignatureRepository {
  /// Get all signatures from the library
  ResultFuture<List<SignatureItem>> getSignatures();

  /// Get all stamps from the library
  ResultFuture<List<SignatureItem>> getStamps();

  /// Get a specific signature/stamp by ID
  ResultFuture<SignatureItem> getItemById(String id);

  /// Add a new signature to the library
  ///
  /// [imageData] - Binary image data
  /// [name] - User-provided name/label
  /// [originalFileName] - Original file name
  /// [mimeType] - MIME type of the image
  ResultFuture<SignatureItem> addSignature({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  });

  /// Add a new stamp to the library
  ///
  /// [imageData] - Binary image data
  /// [name] - User-provided name/label
  /// [originalFileName] - Original file name
  /// [mimeType] - MIME type of the image
  ResultFuture<SignatureItem> addStamp({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  });

  /// Update an existing signature/stamp
  ResultFutureVoid updateItem(SignatureItem item);

  /// Delete a signature/stamp
  ResultFutureVoid deleteItem(String id);

  /// Reorder items in the library
  ///
  /// [items] - List of items with updated order field
  ResultFutureVoid reorderItems(List<SignatureItem> items);

  /// Get the next available order number for a given type
  ResultFuture<int> getNextOrder(SignatureType type);

  /// Stream of all signatures (for reactive updates)
  Stream<List<SignatureItem>> watchSignatures();

  /// Stream of all stamps (for reactive updates)
  Stream<List<SignatureItem>> watchStamps();
}
