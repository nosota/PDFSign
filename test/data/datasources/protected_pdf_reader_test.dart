import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/data/datasources/protected_pdf_reader.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Builds a protected document to read back.
Future<Uint8List> encrypted({
  String user = 'open-me',
  String owner = 'own-me',
  List<PdfPermissionsFlags> permissions = const [PdfPermissionsFlags.print],
  PdfEncryptionAlgorithm algorithm = PdfEncryptionAlgorithm.aesx256Bit,
  int pages = 1,
  PdfPageRotateAngle rotation = PdfPageRotateAngle.rotateAngle0,
}) async {
  final draft = PdfDocument();
  for (var i = 0; i < pages; i++) {
    draft.pages.add().graphics.drawString(
          'page $i',
          PdfStandardFont(PdfFontFamily.helvetica, 18),
          bounds: const Rect.fromLTWH(20, 20, 120, 30),
        );
  }
  final plain = await draft.save();
  draft.dispose();

  // Rotation and protection are applied to a document that already exists,
  // which is the case the app itself deals with: a page's turn does not take
  // on a page being created.
  final document = PdfDocument(inputBytes: plain);
  for (var i = 0; i < document.pages.count; i++) {
    document.pages[i].rotation = rotation;
  }
  document.security
    ..algorithm = algorithm
    ..userPassword = user
    ..ownerPassword = owner;
  document.security.permissions.addAll(permissions);
  final bytes = await document.save();
  document.dispose();
  return Uint8List.fromList(bytes);
}

/// Whether [bytes] can be read with no password at all.
bool opensUnaided(List<int> bytes) {
  try {
    PdfDocument(inputBytes: bytes).dispose();
    return true;
  } on ArgumentError {
    return false;
  }
}

void main() {
  const reader = ProtectedPdfReader();

  group('a document that needs a password', () {
    test('should refuse to open without one, and say none was given',
        () async {
      final bytes = await encrypted();

      await expectLater(
        reader.read(bytes),
        throwsA(isA<PdfPasswordRequiredException>()
            .having((e) => e.passwordWasGiven, 'passwordWasGiven', isFalse)),
      );
    });

    test('should refuse a wrong password, and say one was given', () async {
      final bytes = await encrypted();

      await expectLater(
        reader.read(bytes, password: 'not-it'),
        throwsA(isA<PdfPasswordRequiredException>()
            .having((e) => e.passwordWasGiven, 'passwordWasGiven', isTrue)),
      );
    });

    test('should open with the user password', () async {
      final contents = await reader.read(await encrypted(), password: 'open-me');

      expect(contents.security.isProtected, isTrue);
      expect(contents.security.password, 'open-me');
      expect(contents.rotations, [0]);
    });
  });

  group('the copy handed to the renderer', () {
    test('should open with no password, which is what the renderer can do',
        () async {
      // pdfx cannot be given a password on macOS; it takes a document
      // CoreGraphics opens by itself, and nothing else.
      final contents = await reader.read(await encrypted(), password: 'open-me');

      expect(opensUnaided(contents.renderableBytes), isTrue);
    });

    test('should keep every page', () async {
      final contents = await reader.read(
        await encrypted(pages: 4),
        password: 'open-me',
      );

      final copy = PdfDocument(inputBytes: contents.renderableBytes);
      expect(copy.pages.count, 4);
      copy.dispose();
    });

    test('should leave the original bytes protected', () async {
      // The original is what every save starts from (ADR-0002). If reading
      // for the screen changed it, saving would write an unprotected file.
      final bytes = await encrypted();

      await reader.read(bytes, password: 'open-me');

      expect(opensUnaided(bytes), isFalse);
    });
  });

  group('what the document permits', () {
    test('should refuse editing when the document does not allow it',
        () async {
      final bytes = await encrypted(
        permissions: [PdfPermissionsFlags.print, PdfPermissionsFlags.copyContent],
      );

      final contents = await reader.read(bytes, password: 'open-me');

      expect(contents.security.allowsEditing, isFalse);
      expect(contents.security.hasOwnerRights, isFalse);
    });

    test('should allow editing when the document allows it', () async {
      final bytes = await encrypted(
        permissions: [PdfPermissionsFlags.print, PdfPermissionsFlags.editContent],
      );

      final contents = await reader.read(bytes, password: 'open-me');

      expect(contents.security.allowsEditing, isTrue);
    });

    test('should allow editing to whoever holds the owner password', () async {
      // The specification gives the owner full access whatever the flags say.
      final bytes = await encrypted(permissions: [PdfPermissionsFlags.print]);

      final contents = await reader.read(bytes, password: 'own-me');

      expect(contents.security.hasOwnerRights, isTrue);
      expect(contents.security.allowsEditing, isTrue);
    });
  });

  group('a document anyone may read but not change', () {
    test('should open with no password and still be restricted', () async {
      // An empty user password with an owner password set: every viewer opens
      // it, and the permissions still apply. This is the case the app used to
      // refuse outright.
      final bytes = await encrypted(
        user: '',
        permissions: [PdfPermissionsFlags.print],
      );

      final contents = await reader.read(bytes);

      expect(contents.security.isProtected, isTrue);
      expect(contents.security.password, isNull);
      expect(contents.security.allowsEditing, isFalse);
    });
  });

  group('documents written by another implementation', () {
    test('should open a file encrypted by macOS itself', () async {
      // Reading back what this app's own library wrote proves little. This
      // fixture was encrypted by Apple's PDFKit: AES-128, /CFM /AESV2.
      final bytes = await File(
        'test/fixtures/encrypted_by_pdfkit.pdf',
      ).readAsBytes();

      final contents = await reader.read(bytes, password: 'open-me');

      expect(contents.security.isProtected, isTrue);
      expect(opensUnaided(contents.renderableBytes), isTrue);
      expect(contents.rotations, hasLength(1));
    });
  });

  group('older and weaker algorithms', () {
    for (final algorithm in [
      PdfEncryptionAlgorithm.rc4x40Bit,
      PdfEncryptionAlgorithm.rc4x128Bit,
      PdfEncryptionAlgorithm.aesx128Bit,
      PdfEncryptionAlgorithm.aesx256Bit,
    ]) {
      test('should read a document encrypted with ${algorithm.name}', () async {
        final bytes = await encrypted(algorithm: algorithm);

        final contents = await reader.read(bytes, password: 'open-me');

        expect(opensUnaided(contents.renderableBytes), isTrue);
      });
    }
  });

  group('rotated pages', () {
    test('should report the turn each page carries', () async {
      final bytes = await encrypted(
        pages: 2,
        rotation: PdfPageRotateAngle.rotateAngle90,
      );

      final contents = await reader.read(bytes, password: 'open-me');

      expect(contents.rotations, [90, 90]);
    });
  });
}
