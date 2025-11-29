import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// Type of signature item
enum SignatureType {
  /// Handwritten signature
  signature,

  /// Official stamp/seal
  stamp,
}

/// Entity representing a signature or stamp in the library
class SignatureItem extends Equatable {
  /// Unique identifier
  final String id;

  /// User-provided name/label
  final String name;

  /// Type of item (signature or stamp)
  final SignatureType type;

  /// Binary image data
  final Uint8List imageData;

  /// Display order in the list
  final int order;

  /// When the item was created
  final DateTime createdAt;

  /// Original file name
  final String originalFileName;

  /// MIME type of the image
  final String mimeType;

  const SignatureItem({
    required this.id,
    required this.name,
    required this.type,
    required this.imageData,
    required this.order,
    required this.createdAt,
    required this.originalFileName,
    required this.mimeType,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        imageData,
        order,
        createdAt,
        originalFileName,
        mimeType,
      ];

  /// Create a copy with updated fields
  SignatureItem copyWith({
    String? id,
    String? name,
    SignatureType? type,
    Uint8List? imageData,
    int? order,
    DateTime? createdAt,
    String? originalFileName,
    String? mimeType,
  }) {
    return SignatureItem(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      imageData: imageData ?? this.imageData,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
      originalFileName: originalFileName ?? this.originalFileName,
      mimeType: mimeType ?? this.mimeType,
    );
  }
}
