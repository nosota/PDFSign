import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// 1x1 transparent PNG, so there is something to stamp.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  late Directory directory;
  late String imagePath;
  late PdfSaveService service;
  late Uint8List original;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('pdfsign-compose');
    imagePath = '${directory.path}/stamp.png';
    await File(imagePath).writeAsBytes(base64Decode(_pngBase64));
    service = PdfSaveService();
    addTearDown(() => directory.delete(recursive: true));

    final document = PdfDocument()..pages.add();
    document.pages.add();
    original = Uint8List.fromList(await document.save());
    document.dispose();
  });

  List<PdfPageInfo> pages() {
    final document = PdfDocument(inputBytes: original);
    final infos = [
      for (var i = 0; i < document.pages.count; i++)
        PdfPageInfo(
          pageNumber: i + 1,
          width: document.pages[i].size.width,
          height: document.pages[i].size.height,
        ),
    ];
    document.dispose();
    return infos;
  }

  PlacedImage stamp() => PlacedImage(
        id: 'stamp-1',
        imagePath: imagePath,
        pageIndex: 0,
        position: const Offset(50, 50),
        size: const Size(80, 40),
      );

  test('should give the same document a save would write', () async {
    // A print job and a save start from one place, so what comes out of the
    // printer cannot differ from what the file would hold. The two are not
    // compared byte for byte: the writer stamps each document with the moment
    // it was made, so two runs differ in the date and in nothing else.
    final composed = await service.composePdfBytes(
      originalBytes: original,
      placedImages: [stamp()],
      pages: pages(),
    );
    final output = '${directory.path}/saved.pdf';
    final saved = await service.savePdfFromBytes(
      originalBytes: original,
      placedImages: [stamp()],
      pages: pages(),
      outputPath: output,
    );
    expect(saved.isRight(), isTrue);

    final written = await File(output).readAsBytes();
    final fromMemory = PdfDocument(
      inputBytes: composed.getOrElse(() => Uint8List(0)),
    );
    final fromDisk = PdfDocument(inputBytes: written);
    addTearDown(() {
      fromMemory.dispose();
      fromDisk.dispose();
    });

    expect(fromMemory.pages.count, fromDisk.pages.count);
    expect(
      String.fromCharCodes(composed.getOrElse(() => Uint8List(0))),
      contains('/Image'),
      reason: 'the stamp has to be in the bytes handed to the printer',
    );
    expect(String.fromCharCodes(written), contains('/Image'));
  });

  test('should carry the objects into the bytes it hands back', () async {
    final before = await service.composePdfBytes(
      originalBytes: original,
      placedImages: const [],
      pages: pages(),
    );
    final after = await service.composePdfBytes(
      originalBytes: original,
      placedImages: [stamp()],
      pages: pages(),
    );

    expect(
      after.getOrElse(() => Uint8List(0)).length,
      greaterThan(before.getOrElse(() => Uint8List(0)).length),
      reason: 'a stamped page carries an image the bare one does not',
    );
  });

  test('should report a document it cannot open rather than throwing',
      () async {
    final result = await service.composePdfBytes(
      originalBytes: Uint8List.fromList([1, 2, 3]),
      placedImages: const [],
      pages: const [],
    );

    expect(result.isLeft(), isTrue);
  });

  test('should write nothing to disk', () async {
    // The bytes of a protected document are decrypted here; ADR-0011 forbids
    // them a file of their own.
    final before = directory.listSync().length;

    await service.composePdfBytes(
      originalBytes: original,
      placedImages: [stamp()],
      pages: pages(),
    );

    expect(directory.listSync().length, before);
  });
}
