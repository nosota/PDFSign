import 'dart:ui';

import 'package:equatable/equatable.dart';

/// A placed object copied to the clipboard.
///
/// Carries what is needed to recreate the object elsewhere: which library
/// image it came from, how large it was and how it was turned. The position it
/// was copied from is kept so a paste into the same document can land beside
/// the original rather than in the middle of the page.
///
/// This travels through the system clipboard, so anything can put bytes under
/// our format name. [fromJson] therefore validates every field and returns
/// null instead of throwing.
class ClipboardPlacedObject extends Equatable {
  const ClipboardPlacedObject({
    required this.imagePath,
    this.sourceImageId,
    required this.size,
    required this.position,
    this.rotation = 0,
  });

  /// Payload format version. Bump when the shape changes incompatibly.
  static const currentVersion = 1;

  /// Library row the object came from, or null when it has none — an image
  /// pasted from another application is stored with the document instead.
  final String? sourceImageId;

  /// Path to the image file in app storage at the time of copying.
  ///
  /// May no longer exist when the object is pasted — the library row can be
  /// deleted in between, which also deletes the file. The paste path falls
  /// back to the image flavour written alongside this payload.
  final String imagePath;

  /// Size in PDF points.
  final Size size;

  /// Position on the page it was copied from, in PDF points.
  final Offset position;

  /// Rotation angle in radians.
  final double rotation;

  Map<String, dynamic> toJson() => {
        'version': currentVersion,
        'sourceImageId': sourceImageId,
        'imagePath': imagePath,
        'width': size.width,
        'height': size.height,
        'x': position.dx,
        'y': position.dy,
        'rotation': rotation,
      };

  /// Reads a payload written by [toJson], or null if [json] is not one.
  static ClipboardPlacedObject? fromJson(Object? json) {
    if (json is! Map) {
      return null;
    }
    if (json['version'] != currentVersion) {
      return null;
    }

    final sourceImageId = json['sourceImageId'];
    if (sourceImageId != null &&
        (sourceImageId is! String || sourceImageId.isEmpty)) {
      return null;
    }

    final imagePath = json['imagePath'];
    if (imagePath is! String || imagePath.isEmpty) {
      return null;
    }

    final width = _positiveOrNull(json['width']);
    final height = _positiveOrNull(json['height']);
    if (width == null || height == null) {
      return null;
    }

    final x = _finiteOrNull(json['x']);
    final y = _finiteOrNull(json['y']);
    final rotation = _finiteOrNull(json['rotation']);
    if (x == null || y == null || rotation == null) {
      return null;
    }

    return ClipboardPlacedObject(
      sourceImageId: sourceImageId as String?,
      imagePath: imagePath,
      size: Size(width, height),
      position: Offset(x, y),
      rotation: rotation,
    );
  }

  static double? _finiteOrNull(Object? value) {
    final number = value is num ? value.toDouble() : null;
    if (number == null || !number.isFinite) {
      return null;
    }
    return number;
  }

  static double? _positiveOrNull(Object? value) {
    final number = _finiteOrNull(value);
    if (number == null || number <= 0) {
      return null;
    }
    return number;
  }

  @override
  List<Object?> get props => [
        sourceImageId,
        imagePath,
        size,
        position,
        rotation,
      ];
}
