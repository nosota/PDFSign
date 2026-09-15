import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/clipboard_contents.dart';
import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';

/// Access to the system clipboard for the editor.
///
/// The system clipboard rather than a field in memory, because each window
/// runs its own Dart isolate: nothing held in Dart can be copied in one window
/// and pasted in another. It also lets an object be pasted into other
/// applications, and an image copied elsewhere be pasted here.
abstract class ClipboardRepository {
  /// Puts a placed object on the clipboard.
  ///
  /// Writes two renditions of the same item: the object itself, which this app
  /// can restore exactly, and [imageBytes], which every other application
  /// understands and which lets a paste survive the library image being
  /// deleted in the meantime.
  Future<Either<Failure, Unit>> writePlacedObject({
    required ClipboardPlacedObject object,
    required Uint8List imageBytes,
    required ClipboardImageFormat imageFormat,
  });

  /// Reads whatever of the clipboard the editor can use.
  Future<Either<Failure, ClipboardContents>> read();
}
