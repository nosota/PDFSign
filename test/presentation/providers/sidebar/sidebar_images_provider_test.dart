import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/constants/image_import_limits.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/domain/repositories/sidebar_image_repository.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';

/// 1x1 transparent PNG — a real, decodable image.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  late ProviderContainer container;
  late _FakeSidebarImageRepository repository;
  late Directory directory;
  late Uint8List pngBytes;

  setUp(() async {
    pngBytes = base64Decode(_pngBase64);
    directory = await Directory.systemTemp.createTemp('pdfsign-import-test');
    repository = _FakeSidebarImageRepository();

    container = ProviderContainer(
      overrides: [
        sidebarImageRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(() => directory.delete(recursive: true));
  });

  Future<String> writeFile(String name, List<int> bytes) async {
    final file = File('${directory.path}/$name');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<ImageImportReport> addAll(List<String> paths) =>
      container.read(sidebarImagesProvider.notifier).addImages(paths);

  group('an image within the limits', () {
    test('should reach the library', () async {
      final path = await writeFile('ok.png', pngBytes);

      final report = await addAll([path]);

      expect(report.added, 1);
      expect(report.rejections, isEmpty);
      expect(repository.added, hasLength(1));
      expect(repository.added.single.fileName, 'ok.png');
    });
  });

  group('an oversized file', () {
    test('should be refused without being read', () async {
      // A file one byte over the limit, made cheaply as a sparse file: the
      // point of the check is that the bytes are never read, so a test that
      // has to write 100 MB would be testing the wrong thing.
      final path = '${directory.path}/huge.png';
      final file = await File(path).create();
      final handle = await file.open(mode: FileMode.write);
      await handle.setPosition(ImageImportLimits.maxFileSizeBytes);
      await handle.writeByte(0);
      await handle.close();

      final report = await addAll([path]);

      expect(report.added, 0);
      expect(report.rejections, [ImageImportRejection.tooLarge]);
      expect(repository.added, isEmpty);
    });
  });

  group('a file that is not an image', () {
    test('should be skipped without a complaint about limits', () async {
      // The user knows they picked something odd; there is no limit to name.
      final path = await writeFile('notes.png', utf8.encode('not an image'));

      final report = await addAll([path]);

      expect(report.added, 0);
      expect(report.rejections, isEmpty);
      expect(repository.added, isEmpty);
    });

    test('should be skipped when the file is not there at all', () async {
      final report = await addAll(['${directory.path}/missing.png']);

      expect(report.added, 0);
      expect(report.rejections, isEmpty);
    });
  });

  group('a batch', () {
    test('should add what it can and report the rest', () async {
      final good = await writeFile('good.png', pngBytes);
      final huge = '${directory.path}/huge.png';
      final handle = await (await File(huge).create()).open(
        mode: FileMode.write,
      );
      await handle.setPosition(ImageImportLimits.maxFileSizeBytes + 10);
      await handle.writeByte(0);
      await handle.close();

      final report = await addAll([good, huge]);

      expect(report.added, 1);
      expect(report.rejections, [ImageImportRejection.tooLarge]);
      expect(repository.added, hasLength(1));
    });

    test('should name the shared reason when every refusal agrees', () async {
      const report = ImageImportReport(
        added: 0,
        rejections: [
          ImageImportRejection.tooLarge,
          ImageImportRejection.tooLarge,
        ],
      );
      expect(report.sharedRejection, ImageImportRejection.tooLarge);
    });

    test('should name no reason when refusals disagree', () async {
      // The caller then says only that images were not added, rather than
      // naming a limit that half of them did not hit.
      const report = ImageImportReport(
        added: 0,
        rejections: [
          ImageImportRejection.tooLarge,
          ImageImportRejection.tooManyPixels,
        ],
      );
      expect(report.sharedRejection, isNull);
    });
  });
}

class _FakeSidebarImageRepository implements SidebarImageRepository {
  final List<SidebarImage> added = [];

  @override
  Future<Either<Failure, SidebarImage>> addImage({
    required String filePath,
    required String fileName,
    required int width,
    required int height,
    required int fileSize,
  }) async {
    final image = SidebarImage(
      id: 'row-${added.length + 1}',
      filePath: filePath,
      fileName: fileName,
      addedAt: DateTime(2026),
      orderIndex: added.length,
      width: width,
      height: height,
      fileSize: fileSize,
    );
    added.add(image);
    return Right(image);
  }

  @override
  Stream<List<SidebarImage>> watchImages() => Stream.value(added);

  @override
  Future<Either<Failure, List<SidebarImage>>> getImages() async => Right(added);

  @override
  Future<Either<Failure, List<SidebarImage>>> cleanupInvalidImages() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> removeImage(String id) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> reorderImages(List<String> orderedIds) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> clearAllImages() => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> updateComment(String id, String? comment) =>
      throw UnimplementedError();
}
