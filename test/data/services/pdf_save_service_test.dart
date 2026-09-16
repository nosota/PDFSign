import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// 1x1 transparent PNG.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  late Directory directory;
  late String imagePath;
  late Uint8List original;
  late PdfSaveService service;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('pdfsign-save-test');
    imagePath = '${directory.path}/stamp.png';
    await File(imagePath).writeAsBytes(base64Decode(_pngBase64));

    final document = PdfDocument();
    document.pages.add();
    document.pages.add();
    original = Uint8List.fromList(await document.save());
    document.dispose();

    service = PdfSaveService();
    addTearDown(() => directory.delete(recursive: true));
  });

  /// The pages of the freshly made document, as the reader first sees them.
  List<PdfPageInfo> pagesOf(Uint8List bytes) {
    final document = PdfDocument(inputBytes: bytes);
    final pages = [
      for (var i = 0; i < document.pages.count; i++)
        PdfPageInfo(
          pageNumber: i + 1,
          width: document.pages[i].size.width,
          height: document.pages[i].size.height,
        ),
    ];
    document.dispose();
    return pages;
  }

  /// Page rotations of a saved document, in degrees.
  List<int> rotationsOf(String path) {
    final document = PdfDocument(inputBytes: File(path).readAsBytesSync());
    final rotations = [
      for (var i = 0; i < document.pages.count; i++)
        document.pages[i].rotation.index * 90,
    ];
    document.dispose();
    return rotations;
  }

  PlacedImage stampOn(int pageIndex) => PlacedImage(
        id: 'stamp-$pageIndex',
        imagePath: imagePath,
        pageIndex: pageIndex,
        position: const Offset(10, 20),
        size: const Size(100, 50),
      );

  group('turns the reader made', () {
    test('should be written into the file', () async {
      final pages = pagesOf(original);
      final turned = [pages[0].rotated(1), pages[1]];
      final output = '${directory.path}/turned.pdf';

      final result = await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: const [],
        pages: turned,
        outputPath: output,
      );

      expect(result.isRight(), isTrue);
      expect(rotationsOf(output), [90, 0]);
    });

    test('should be written for every direction', () async {
      final pages = pagesOf(original);
      for (final entry in {1: 90, 2: 180, 3: 270, -1: 270}.entries) {
        final output = '${directory.path}/turned${entry.key}.pdf';
        await service.savePdfFromBytes(
          originalBytes: original,
          placedImages: const [],
          pages: [pages[0].rotated(entry.key), pages[1]],
          outputPath: output,
        );
        expect(rotationsOf(output).first, entry.value, reason: '${entry.key}');
      }
    });

    test('should leave a page alone when it was not turned', () async {
      final output = '${directory.path}/untouched.pdf';

      await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: const [],
        pages: pagesOf(original),
        outputPath: output,
      );

      expect(rotationsOf(output), [0, 0]);
    });

    test('should not be written again once the file has them', () async {
      // A page opened from a file that already carries the rotation is not an
      // unsaved change, and must not be turned a second time.
      final pages = pagesOf(original);
      final alreadySaved = [
        pages[0].copyWith(rotation: 90, fileRotation: 90, width: 842),
        pages[1],
      ];
      final output = '${directory.path}/stable.pdf';

      await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: const [],
        pages: alreadySaved,
        outputPath: output,
      );

      // The original bytes have no rotation, so nothing is written — which is
      // right: those bytes are the file the rotation is already in.
      expect(rotationsOf(output), [0, 0]);
    });
  });

  group('objects on a turned page', () {
    test('should still be written', () async {
      final pages = pagesOf(original);
      final output = '${directory.path}/stamped.pdf';

      final result = await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: [stampOn(0)],
        pages: [pages[0].rotated(1), pages[1]],
        outputPath: output,
      );

      expect(result.isRight(), isTrue);
      final saved = await File(output).readAsBytes();
      expect(saved.length, greaterThan(original.length));
      expect(rotationsOf(output), [90, 0]);
    });

    test('should be skipped when their image is gone', () async {
      // Deleting a library row deletes its file (REQUIREMENTS §13.1). The page
      // must still be written, and the rotation with it.
      final pages = pagesOf(original);
      final output = '${directory.path}/missing.pdf';

      final result = await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: [
          PlacedImage(
            id: 'gone',
            imagePath: '${directory.path}/never-written.png',
            pageIndex: 0,
            position: Offset.zero,
            size: const Size(10, 10),
          ),
        ],
        pages: [pages[0].rotated(1), pages[1]],
        outputPath: output,
      );

      expect(result.isRight(), isTrue);
      expect(rotationsOf(output), [90, 0]);
    });

    test('should ignore an object pointing past the last page', () async {
      final output = '${directory.path}/beyond.pdf';

      final result = await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: [stampOn(7)],
        pages: pagesOf(original),
        outputPath: output,
      );

      expect(result.isRight(), isTrue);
    });
  });

  group('when the caller says nothing about the pages', () {
    test('should still write the objects', () async {
      // The document may not have finished loading. Falling back to the
      // rotation in the file is what keeps a save from being refused.
      final output = '${directory.path}/nopages.pdf';

      final result = await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: [stampOn(0)],
        pages: const [],
        outputPath: output,
      );

      expect(result.isRight(), isTrue);
      expect(rotationsOf(output), [0, 0]);
    });
  });

  group('failure', () {
    test('should report a path that cannot be written', () async {
      final result = await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: const [],
        pages: pagesOf(original),
        outputPath: '/nonexistent-directory/out.pdf',
      );

      expect(result.isLeft(), isTrue);
    });

    test('should report bytes that are not a PDF', () async {
      final result = await service.savePdfFromBytes(
        originalBytes: Uint8List.fromList(utf8.encode('not a pdf')),
        placedImages: const [],
        pages: const [],
        outputPath: '${directory.path}/broken.pdf',
      );

      expect(result.isLeft(), isTrue);
    });
  });
}
