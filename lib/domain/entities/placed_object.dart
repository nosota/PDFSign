import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Entity representing a signature/stamp placed on a PDF page
class PlacedObject extends Equatable {
  /// Unique identifier for this placement
  final String id;

  /// Reference to the SignatureItem ID
  final String signatureId;

  /// Page number (0-indexed)
  final int pageNumber;

  /// Position on the page (top-left corner)
  /// Coordinates are in PDF coordinate system
  final Offset position;

  /// Size of the placed object
  final Size size;

  /// Rotation angle in degrees (0-360)
  final double rotation;

  /// Z-index for layering (higher = on top)
  final int zIndex;

  /// When the object was placed
  final DateTime placedAt;

  const PlacedObject({
    required this.id,
    required this.signatureId,
    required this.pageNumber,
    required this.position,
    required this.size,
    required this.rotation,
    required this.zIndex,
    required this.placedAt,
  });

  @override
  List<Object?> get props => [
        id,
        signatureId,
        pageNumber,
        position,
        size,
        rotation,
        zIndex,
        placedAt,
      ];

  /// Create a copy with updated fields
  PlacedObject copyWith({
    String? id,
    String? signatureId,
    int? pageNumber,
    Offset? position,
    Size? size,
    double? rotation,
    int? zIndex,
    DateTime? placedAt,
  }) {
    return PlacedObject(
      id: id ?? this.id,
      signatureId: signatureId ?? this.signatureId,
      pageNumber: pageNumber ?? this.pageNumber,
      position: position ?? this.position,
      size: size ?? this.size,
      rotation: rotation ?? this.rotation,
      zIndex: zIndex ?? this.zIndex,
      placedAt: placedAt ?? this.placedAt,
    );
  }
}

/// Simple Offset class for position
@immutable
class Offset extends Equatable {
  final double dx;
  final double dy;

  const Offset(this.dx, this.dy);

  @override
  List<Object?> get props => [dx, dy];

  Offset operator +(Offset other) => Offset(dx + other.dx, dy + other.dy);

  Offset operator -(Offset other) => Offset(dx - other.dx, dy - other.dy);

  Offset operator *(double scalar) => Offset(dx * scalar, dy * scalar);

  static const Offset zero = Offset(0, 0);
}

/// Simple Size class for dimensions
@immutable
class Size extends Equatable {
  final double width;
  final double height;

  const Size(this.width, this.height);

  @override
  List<Object?> get props => [width, height];

  Size operator *(double scalar) => Size(width * scalar, height * scalar);

  Size operator /(double divisor) => Size(width / divisor, height / divisor);

  static const Size zero = Size(0, 0);

  /// Check if this size is valid (non-negative dimensions)
  bool get isValid => width >= 0 && height >= 0;

  /// Get the aspect ratio (width / height)
  double get aspectRatio => height != 0 ? width / height : 0;
}
