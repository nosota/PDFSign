import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';

/// Bitmap formats the editor exchanges through the clipboard.
enum ClipboardImageFormat {
  png('png'),
  jpeg('jpg');

  const ClipboardImageFormat(this.fileExtension);

  /// Extension to use when the bytes are written to a file.
  final String fileExtension;

  /// The format a file with this [extension] holds, or null if unsupported.
  static ClipboardImageFormat? forExtension(String extension) {
    final normalized = extension.toLowerCase().replaceFirst('.', '');
    return switch (normalized) {
      'png' => ClipboardImageFormat.png,
      'jpg' || 'jpeg' => ClipboardImageFormat.jpeg,
      _ => null,
    };
  }
}

/// A bitmap read from the clipboard.
class ClipboardImage extends Equatable {
  const ClipboardImage({
    required this.bytes,
    required this.format,
  });

  final Uint8List bytes;
  final ClipboardImageFormat format;

  @override
  List<Object?> get props => [bytes, format];
}

/// What the editor found on the clipboard.
///
/// Both fields are empty when the clipboard holds nothing the editor can use —
/// plain text, a file list, or nothing at all. That is an ordinary outcome,
/// not a failure.
class ClipboardContents extends Equatable {
  const ClipboardContents({
    this.placedObject,
    this.image,
  });

  /// An object copied from this app, when the clipboard carries our format.
  final ClipboardPlacedObject? placedObject;

  /// A bitmap, either written alongside [placedObject] or copied from
  /// another application.
  final ClipboardImage? image;

  /// Whether there is anything the editor can paste.
  bool get isEmpty => placedObject == null && image == null;

  @override
  List<Object?> get props => [placedObject, image];
}
