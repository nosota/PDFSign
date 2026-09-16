import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' hide Rect;

/// Puts the temporary directory somewhere a test can reach without a platform.
class _TempDirectory extends PathProviderPlatform with MockPlatformInterfaceMixin {
  _TempDirectory(this.path);

  final String path;

  @override
  Future<String?> getTemporaryPath() async => path;
}

/// 1x1 transparent PNG, so there is something to stamp.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  late Directory directory;
  late String imagePath;
  late PdfSaveService service;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('pdfsign-protection');
    imagePath = '${directory.path}/stamp.png';
    await File(imagePath).writeAsBytes(base64Decode(_pngBase64));
    service = PdfSaveService();
    PathProviderPlatform.instance = _TempDirectory(directory.path);
    addTearDown(() => directory.delete(recursive: true));
  });

  /// A two-page document protected with both passwords.
  Future<Uint8List> protected({
    PdfEncryptionAlgorithm algorithm = PdfEncryptionAlgorithm.aesx256Bit,
    String user = 'open-me',
    String owner = 'own-me',
  }) async {
    final draft = PdfDocument();
    draft.pages.add();
    draft.pages.add();
    final plain = await draft.save();
    draft.dispose();

    final document = PdfDocument(inputBytes: plain);
    document.security
      ..algorithm = algorithm
      ..userPassword = user
      ..ownerPassword = owner;
    document.security.permissions.addAll([
      PdfPermissionsFlags.print,
      PdfPermissionsFlags.editContent,
    ]);
    final bytes = await document.save();
    document.dispose();
    return Uint8List.fromList(bytes);
  }

  List<PdfPageInfo> pagesOf(Uint8List bytes, String password) {
    final document = PdfDocument(inputBytes: bytes, password: password);
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

  /// Opens [path] with [password], returning null when it will not open.
  PdfDocument? openSaved(String path, {String? password}) {
    try {
      return PdfDocument(
        inputBytes: File(path).readAsBytesSync(),
        password: password,
      );
    } on ArgumentError {
      return null;
    }
  }

  Future<String> save(Uint8List original, {required String password}) async {
    final output = '${directory.path}/saved-${original.length}.pdf';
    final result = await service.savePdfFromBytes(
      originalBytes: original,
      placedImages: [stamp()],
      pages: pagesOf(original, password),
      outputPath: output,
      password: password,
    );
    expect(result.isRight(), isTrue, reason: 'the save should have succeeded');
    return output;
  }

  group('saving a protected document', () {
    test('should write a file that still asks for the password', () async {
      final original = await protected();

      final output = await save(original, password: 'open-me');

      expect(openSaved(output), isNull,
          reason: 'the saved document opened with no password at all');
    });

    test('should keep both of the original passwords working', () async {
      // Only the user password was given. The owner password cannot be worked
      // out from it, so this passes only if the original protection was
      // carried over rather than rebuilt.
      final original = await protected();

      final output = await save(original, password: 'open-me');

      expect(openSaved(output, password: 'open-me'), isNotNull);
      expect(openSaved(output, password: 'own-me'), isNotNull);
    });

    test('should keep the document readable and whole', () async {
      final original = await protected();

      final output = await save(original, password: 'open-me');

      final saved = openSaved(output, password: 'open-me');
      expect(saved!.pages.count, 2);
      saved.dispose();
    });

    test('should keep the permissions the document was given', () async {
      final original = await protected();

      final output = await save(original, password: 'open-me');

      final saved = openSaved(output, password: 'open-me')!;
      final granted = <PdfPermissionsFlags>[];
      saved.security.permissions.forEach(granted.add);
      expect(granted, contains(PdfPermissionsFlags.print));
      expect(granted, contains(PdfPermissionsFlags.editContent));
      saved.dispose();
    });

    for (final algorithm in [
      PdfEncryptionAlgorithm.rc4x40Bit,
      PdfEncryptionAlgorithm.rc4x128Bit,
      PdfEncryptionAlgorithm.aesx128Bit,
      PdfEncryptionAlgorithm.aesx256Bit,
    ]) {
      test('should keep ${algorithm.name} protection', () async {
        final original = await protected(algorithm: algorithm);

        final output = await save(original, password: 'open-me');

        final saved = openSaved(output, password: 'open-me');
        expect(saved, isNotNull);
        expect(saved!.security.algorithm, algorithm);
        saved.dispose();
      });
    }
  });

  group('sharing a protected document', () {
    test('should protect the copy that is handed out', () async {
      // The recipient of a protected document needs its password; handing out
      // an unprotected copy would give away what the document was protecting.
      final original = await protected();

      final result = await service.createTempPdfWithImagesFromBytes(
        originalBytes: original,
        placedImages: [stamp()],
        pages: pagesOf(original, 'open-me'),
        password: 'open-me',
      );

      final path = result.getOrElse(() => '');
      expect(path, isNotEmpty);
      addTearDown(() => File(path).delete());
      expect(openSaved(path), isNull, reason: 'the shared copy was unprotected');
      expect(openSaved(path, password: 'open-me'), isNotNull);
    });
  });

  group('saving without the password', () {
    test('should fail rather than write a broken file', () async {
      final original = await protected();
      final output = '${directory.path}/no-password.pdf';

      final result = await service.savePdfFromBytes(
        originalBytes: original,
        placedImages: [stamp()],
        pages: pagesOf(original, 'open-me'),
        outputPath: output,
      );

      expect(result.isLeft(), isTrue);
      expect(File(output).existsSync(), isFalse);
    });
  });
}
