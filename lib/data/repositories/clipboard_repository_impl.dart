import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:super_clipboard/super_clipboard.dart';

import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/domain/entities/clipboard_contents.dart';
import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';
import 'package:pdfsign/domain/repositories/clipboard_repository.dart';

/// [ClipboardRepository] over the system pasteboard.
class ClipboardRepositoryImpl implements ClipboardRepository {
  /// Pasteboard type carrying a placed object as UTF-8 JSON.
  ///
  /// Private to this app: anything else on the pasteboard under this name is
  /// rejected by [ClipboardPlacedObject.fromJson].
  static const placedObjectFormat = SimpleFileFormat(
    uniformTypeIdentifiers: ['com.ivanvaganov.pdfsign.placed-object'],
    mimeTypes: ['application/vnd.pdfsign.placed-object'],
  );

  @override
  Future<Either<Failure, Unit>> writePlacedObject({
    required ClipboardPlacedObject object,
    required Uint8List imageBytes,
    required ClipboardImageFormat imageFormat,
  }) async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return const Left(ClipboardFailure());
    }

    try {
      final payload = Uint8List.fromList(
        utf8.encode(jsonEncode(object.toJson())),
      );

      // Highest fidelity first: platforms that respect the order hand our own
      // format to us and the bitmap to everyone else.
      final item = DataWriterItem()
        ..add(placedObjectFormat(payload))
        ..add(_formatFor(imageFormat)(imageBytes));

      await clipboard.write([item]);
      return const Right(unit);
    } catch (e) {
      return Left(ClipboardFailure(message: 'Failed to copy: $e'));
    }
  }

  @override
  Future<Either<Failure, ClipboardContents>> read() async {
    final clipboard = SystemClipboard.instance;
    if (clipboard == null) {
      return const Left(ClipboardFailure());
    }

    try {
      final reader = await clipboard.read();

      final placedObject = await _readPlacedObject(reader);
      final image = await _readImage(reader);

      return Right(ClipboardContents(placedObject: placedObject, image: image));
    } catch (e) {
      return Left(ClipboardFailure(message: 'Failed to read clipboard: $e'));
    }
  }

  Future<ClipboardPlacedObject?> _readPlacedObject(
    ClipboardReader reader,
  ) async {
    if (!reader.canProvide(placedObjectFormat)) {
      return null;
    }
    final bytes = await _readBytes(reader, placedObjectFormat);
    if (bytes == null) {
      return null;
    }
    try {
      return ClipboardPlacedObject.fromJson(jsonDecode(utf8.decode(bytes)));
    } catch (_) {
      // Our own format name, but not our data. Treat it as absent rather than
      // as an error: the bitmap alongside it may still be pasteable.
      return null;
    }
  }

  Future<ClipboardImage?> _readImage(ClipboardReader reader) async {
    for (final format in ClipboardImageFormat.values) {
      final fileFormat = _formatFor(format);
      if (!reader.canProvide(fileFormat)) {
        continue;
      }
      final bytes = await _readBytes(reader, fileFormat);
      if (bytes != null && bytes.isNotEmpty) {
        return ClipboardImage(bytes: bytes, format: format);
      }
    }
    return null;
  }

  /// Bridges the callback-based file reader to a future.
  ///
  /// Completes with null when the format turns out not to be readable after
  /// all, so one unusable rendition cannot fail the whole paste.
  Future<Uint8List?> _readBytes(
    ClipboardReader reader,
    FileFormat format,
  ) async {
    final completer = Completer<Uint8List?>();

    void complete(Uint8List? value) {
      if (!completer.isCompleted) {
        completer.complete(value);
      }
    }

    final progress = reader.getFile(
      format,
      (file) async => complete(await file.readAll()),
      onError: (_) => complete(null),
    );
    if (progress == null) {
      return null;
    }

    return completer.future;
  }

  static FileFormat _formatFor(ClipboardImageFormat format) =>
      switch (format) {
        ClipboardImageFormat.png => Formats.png,
        ClipboardImageFormat.jpeg => Formats.jpeg,
      };
}
