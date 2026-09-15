import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/domain/repositories/pasted_image_storage.dart';

/// [PastedImageStorage] backed by a folder in the app support directory.
class PastedImageStorageImpl implements PastedImageStorage {
  static const _folderName = 'pasted';

  final Uuid _uuid = const Uuid();

  @override
  Future<Either<Failure, String>> save(
    Uint8List bytes, {
    required String fileExtension,
  }) async {
    try {
      final directory = await _directory();
      final file = File(
        path.join(directory.path, '${_uuid.v4()}.$fileExtension'),
      );
      await file.writeAsBytes(bytes);
      return Right(file.path);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to store pasted image: $e'));
    }
  }

  @override
  Future<void> clear() async {
    try {
      final directory = await _directory();
      await for (final entity in directory.list()) {
        // Only files, and only ours: never recurse, never follow anything.
        if (entity is File) {
          await entity.delete();
        }
      }
    } catch (_) {
      // A sweep that cannot run leaves files behind, which costs disk space
      // and nothing else. It must not keep the application from starting.
    }
  }

  Future<Directory> _directory() async {
    final appSupport = await getApplicationSupportDirectory();
    final directory = Directory(path.join(appSupport.path, _folderName));

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory;
  }
}
