import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// 1x1 transparent PNG, so there is something to stamp.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

/// The permission bits of PDF 32000-1:2008, Table 22, read out of a file.
///
/// Read from the bytes rather than asked of the library that wrote them: what
/// matters is what another reader will see.
Set<int> permissionBitsOf(List<int> bytes) {
  final text = String.fromCharCodes(bytes);
  final dictionary =
      RegExp(r'<<[^<>]*?/Filter\s*/Standard.*?>>', dotAll: true).firstMatch(text);
  expect(dictionary, isNotNull, reason: 'the document carries no protection');
  final p = RegExp(r'/P\s*(-?\d+)').firstMatch(dictionary!.group(0)!);
  expect(p, isNotNull, reason: 'the protection states no permissions');

  final value = int.parse(p!.group(1)!) & 0xFFFFFFFF;
  // Only the bits that mean something. Bits 7 and 8, and everything from 13
  // up, are reserved and the specification requires them to be 1, so a writer
  // that sets them is obeying the standard rather than granting anything.
  const meaningful = [3, 4, 5, 6, 9, 10, 11, 12];
  return {
    for (final bit in meaningful)
      if (value >> (bit - 1) & 1 == 1) bit,
  };
}

void main() {
  late Directory directory;
  late String imagePath;
  late PdfSaveService service;
  late Uint8List original;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('pdfsign-protect');
    imagePath = '${directory.path}/stamp.png';
    await File(imagePath).writeAsBytes(base64Decode(_pngBase64));
    service = PdfSaveService();
    addTearDown(() => directory.delete(recursive: true));

    final document = PdfDocument()..pages.add();
    document.pages.add();
    original = Uint8List.fromList(await document.save());
    document.dispose();
  });

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

  PlacedImage stamp() => PlacedImage(
        id: 'stamp-1',
        imagePath: imagePath,
        pageIndex: 0,
        position: const Offset(50, 50),
        size: const Size(80, 40),
      );

  /// Saves [bytes] with [protection] and hands back what was written.
  Future<Uint8List> save(
    Uint8List bytes, {
    required DocumentProtection? protection,
    String? password,
  }) async {
    final output = '${directory.path}/out-${DateTime.now().microsecondsSinceEpoch}.pdf';
    final result = await service.savePdfFromBytes(
      originalBytes: bytes,
      placedImages: [stamp()],
      pages: pagesOf(original),
      outputPath: output,
      password: password,
      protection: protection,
    );
    expect(result.isRight(), isTrue, reason: 'the save should have succeeded');
    return File(output).readAsBytesSync();
  }

  /// Opens [bytes] with [password], or null when it will not open.
  PdfDocument? open(List<int> bytes, {String? password}) {
    try {
      return PdfDocument(inputBytes: bytes, password: password);
    } on ArgumentError {
      return null;
    }
  }

  group('protecting a document that had none', () {
    test('should ask for the password it was given', () async {
      final written = await save(
        original,
        protection: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      expect(open(written), isNull, reason: 'it opened with no password');
      expect(open(written, password: 'open-me'), isNotNull);
      expect(open(written, password: 'own-me'), isNotNull);
    });

    test('should write exactly the permissions asked for', () async {
      // Bit 3 is printing and 12 is high-quality printing; nothing else was
      // asked for, so nothing else may be granted.
      final written = await save(
        original,
        protection: DocumentProtection(
          userPassword: '',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      expect(permissionBitsOf(written), {3, 12});
    });

    test('should write AES-256 unless told otherwise', () async {
      final written = await save(
        original,
        protection: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      final reopened = open(written, password: 'open-me')!;
      expect(reopened.security.algorithm, PdfEncryptionAlgorithm.aesx256Bit);
      reopened.dispose();
    });

    test('should keep an algorithm it is asked to keep', () async {
      // A document made for an old reader keeps the encryption that reader
      // understands.
      final written = await save(
        original,
        protection: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
          algorithm: DocumentEncryption.rc4x128,
        ),
      );

      final reopened = open(written, password: 'open-me')!;
      expect(reopened.security.algorithm, PdfEncryptionAlgorithm.rc4x128Bit);
      reopened.dispose();
    });
  });

  group('the right to change the document', () {
    test('should carry annotations and form filling with it', () async {
      // Measured in Acrobat: a document permitting content changes is reported
      // as permitting annotations and form filling too. Writing the bits that
      // way keeps the file and what a reader says about it in agreement.
      final written = await save(
        original,
        protection: DocumentProtection(
          userPassword: '',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.changingContent},
        ),
      );

      expect(permissionBitsOf(written), containsAll(<int>[4, 6, 9]));
    });
  });

  group('changing the protection a document already has', () {
    test('should take a permission away', () async {
      final protectedOnce = await save(
        original,
        protection: DocumentProtection(
          userPassword: '',
          ownerPassword: 'own-me',
          permissions: const {
            DocumentPermission.printing,
            DocumentPermission.copying,
          },
        ),
      );
      expect(permissionBitsOf(protectedOnce), containsAll(<int>[3, 5]));

      final narrowed = await save(
        protectedOnce,
        protection: DocumentProtection(
          userPassword: '',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      expect(permissionBitsOf(narrowed), {3, 12},
          reason: 'copying was granted once and never taken back');
    });

    test('should replace the password, and retire the old one', () async {
      final protectedOnce = await save(
        original,
        protection: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      final rekeyed = await save(
        protectedOnce,
        password: 'own-me',
        protection: DocumentProtection(
          userPassword: 'new-one',
          ownerPassword: 'new-owner',
          permissions: const {DocumentPermission.printing},
        ),
      );

      expect(open(rekeyed, password: 'new-one'), isNotNull);
      expect(open(rekeyed, password: 'open-me'), isNull);
    });
  });

  group('removing protection', () {
    test('should open with no password and permit everything', () async {
      final protectedOnce = await save(
        original,
        protection: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      final opened = await save(
        protectedOnce,
        password: 'own-me',
        protection: DocumentProtection.none(),
      );

      expect(open(opened), isNotNull, reason: 'it still asked for a password');
      expect(permissionBitsOf(opened), containsAll(<int>[3, 4, 5, 6, 9, 10, 11, 12]));
    });
  });

  group('saving with no protection given', () {
    test('should leave the document as it was', () async {
      // The reader has not touched the panel; nothing about the protection
      // should change because they moved an object.
      final protectedOnce = await save(
        original,
        protection: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      final again = await save(protectedOnce, password: 'open-me', protection: null);

      expect(open(again), isNull);
      expect(open(again, password: 'open-me'), isNotNull);
      expect(permissionBitsOf(again), {3, 12});
    });
  });
}
