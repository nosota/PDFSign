import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/data/models/signature_item_model.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';

/// Abstract interface for signature local data source
abstract class SignatureLocalDataSource {
  /// Get all signatures sorted by order
  Future<List<SignatureItemModel>> getSignatures();

  /// Get all stamps sorted by order
  Future<List<SignatureItemModel>> getStamps();

  /// Get item by UUID
  Future<SignatureItemModel?> getItemById(String uuid);

  /// Add new signature
  Future<SignatureItemModel> addSignature({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  });

  /// Add new stamp
  Future<SignatureItemModel> addStamp({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  });

  /// Update item
  Future<void> updateItem(SignatureItemModel item);

  /// Delete item by UUID
  Future<void> deleteItem(String uuid);

  /// Reorder items
  Future<void> reorderItems(List<SignatureItemModel> items);

  /// Get next available order for type
  Future<int> getNextOrder(SignatureType type);

  /// Stream of signatures
  Stream<List<SignatureItemModel>> watchSignatures();

  /// Stream of stamps
  Stream<List<SignatureItemModel>> watchStamps();
}

/// Implementation using Isar database
class SignatureLocalDataSourceImpl implements SignatureLocalDataSource {
  final Isar _isar;

  const SignatureLocalDataSourceImpl(this._isar);

  @override
  Future<List<SignatureItemModel>> getSignatures() async {
    try {
      return await _isar.signatureItemModels
          .filter()
          .typeEqualTo(SignatureType.signature)
          .sortByOrder()
          .findAll();
    } catch (e) {
      throw DatabaseException('Failed to get signatures: ${e.toString()}');
    }
  }

  @override
  Future<List<SignatureItemModel>> getStamps() async {
    try {
      return await _isar.signatureItemModels
          .filter()
          .typeEqualTo(SignatureType.stamp)
          .sortByOrder()
          .findAll();
    } catch (e) {
      throw DatabaseException('Failed to get stamps: ${e.toString()}');
    }
  }

  @override
  Future<SignatureItemModel?> getItemById(String uuid) async {
    try {
      return await _isar.signatureItemModels
          .filter()
          .uuidEqualTo(uuid)
          .findFirst();
    } catch (e) {
      throw DatabaseException('Failed to get item: ${e.toString()}');
    }
  }

  @override
  Future<SignatureItemModel> addSignature({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  }) async {
    return _addItem(
      imageData: imageData,
      name: name,
      originalFileName: originalFileName,
      mimeType: mimeType,
      type: SignatureType.signature,
    );
  }

  @override
  Future<SignatureItemModel> addStamp({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  }) async {
    return _addItem(
      imageData: imageData,
      name: name,
      originalFileName: originalFileName,
      mimeType: mimeType,
      type: SignatureType.stamp,
    );
  }

  Future<SignatureItemModel> _addItem({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
    required SignatureType type,
  }) async {
    try {
      // Generate UUID
      final uuid = DateTime.now().millisecondsSinceEpoch.toString();

      // Get next order
      final order = await getNextOrder(type);

      // Create model
      final model = SignatureItemModel.create(
        uuid: uuid,
        name: name,
        type: type,
        imageData: imageData,
        order: order,
        createdAt: DateTime.now(),
        originalFileName: originalFileName,
        mimeType: mimeType,
      );

      // Save to database
      await _isar.writeTxn(() async {
        await _isar.signatureItemModels.put(model);
      });

      return model;
    } catch (e) {
      throw DatabaseException('Failed to add item: ${e.toString()}');
    }
  }

  @override
  Future<void> updateItem(SignatureItemModel item) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.signatureItemModels.put(item);
      });
    } catch (e) {
      throw DatabaseException('Failed to update item: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteItem(String uuid) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.signatureItemModels
            .filter()
            .uuidEqualTo(uuid)
            .deleteFirst();
      });
    } catch (e) {
      throw DatabaseException('Failed to delete item: ${e.toString()}');
    }
  }

  @override
  Future<void> reorderItems(List<SignatureItemModel> items) async {
    try {
      await _isar.writeTxn(() async {
        // Update order for each item
        for (var i = 0; i < items.length; i++) {
          items[i].order = i;
          await _isar.signatureItemModels.put(items[i]);
        }
      });
    } catch (e) {
      throw DatabaseException('Failed to reorder items: ${e.toString()}');
    }
  }

  @override
  Future<int> getNextOrder(SignatureType type) async {
    try {
      final items = await _isar.signatureItemModels
          .filter()
          .typeEqualTo(type)
          .sortByOrderDesc()
          .limit(1)
          .findAll();

      if (items.isEmpty) {
        return 0;
      }

      return items.first.order + 1;
    } catch (e) {
      throw DatabaseException('Failed to get next order: ${e.toString()}');
    }
  }

  @override
  Stream<List<SignatureItemModel>> watchSignatures() {
    try {
      return _isar.signatureItemModels
          .filter()
          .typeEqualTo(SignatureType.signature)
          .sortByOrder()
          .watch(fireImmediately: true);
    } catch (e) {
      throw DatabaseException('Failed to watch signatures: ${e.toString()}');
    }
  }

  @override
  Stream<List<SignatureItemModel>> watchStamps() {
    try {
      return _isar.signatureItemModels
          .filter()
          .typeEqualTo(SignatureType.stamp)
          .sortByOrder()
          .watch(fireImmediately: true);
    } catch (e) {
      throw DatabaseException('Failed to watch stamps: ${e.toString()}');
    }
  }
}
