import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';

part 'signature_item_model.g.dart';

@collection
class SignatureItemModel {
  // Unnamed constructor required by Isar
  SignatureItemModel();

  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late String name;

  @Enumerated(EnumType.name)
  late SignatureType type;

  late List<byte> imageData;

  @Index()
  late int order;

  late DateTime createdAt;

  late String originalFileName;

  late String mimeType;

  /// Convert to domain entity
  SignatureItem toEntity() {
    return SignatureItem(
      id: uuid,
      name: name,
      type: type,
      imageData: Uint8List.fromList(imageData),
      order: order,
      createdAt: createdAt,
      originalFileName: originalFileName,
      mimeType: mimeType,
    );
  }

  /// Create from domain entity
  factory SignatureItemModel.fromEntity(SignatureItem entity) {
    return SignatureItemModel()
      ..uuid = entity.id
      ..name = entity.name
      ..type = entity.type
      ..imageData = entity.imageData.toList()
      ..order = entity.order
      ..createdAt = entity.createdAt
      ..originalFileName = entity.originalFileName
      ..mimeType = entity.mimeType;
  }

  /// Create new model
  factory SignatureItemModel.create({
    required String uuid,
    required String name,
    required SignatureType type,
    required Uint8List imageData,
    required int order,
    required DateTime createdAt,
    required String originalFileName,
    required String mimeType,
  }) {
    return SignatureItemModel()
      ..uuid = uuid
      ..name = name
      ..type = type
      ..imageData = imageData.toList()
      ..order = order
      ..createdAt = createdAt
      ..originalFileName = originalFileName
      ..mimeType = mimeType;
  }
}
