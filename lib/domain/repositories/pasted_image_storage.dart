import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:pdfsign/core/errors/failure.dart';

/// Storage for images pasted into a document from another application.
///
/// Deliberately separate from the image library: a pasted image belongs to the
/// document it was pasted into, not to the user's collection of stamps and
/// signatures. It still needs a file, because a placed object is drawn from its
/// path and `PdfSaveService` reads that path when embedding it into the PDF.
///
/// Nothing owns these files the way a library row owns its image, so they are
/// swept at application start — see [clear].
abstract class PastedImageStorage {
  /// Writes [bytes] and returns the path they were written to.
  Future<Either<Failure, String>> save(
    Uint8List bytes, {
    required String fileExtension,
  });

  /// Deletes every stored pasted image.
  ///
  /// Safe only while no document window is open: objects pasted in one window
  /// can be copied into another, so the files are shared for the length of a
  /// session. Called once at application start, before any document exists.
  Future<void> clear();
}
