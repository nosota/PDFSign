import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' show Rect, Size;

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:uuid/uuid.dart';

import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/core/utils/page_rotation_transform.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';

/// Service for saving PDFs with placed images embedded.
class PdfSaveService {
  final Uuid _uuid = const Uuid();

  /// Saves the PDF with all placed images embedded.
  ///
  /// [originalBytes] are the document as it came off disk — never the result
  /// of a previous save, or repeated saves compound (ADR-0002).
  ///
  /// [pages] describe the pages as the reader sees them: their turn, and the
  /// sides that turn gives them. Objects are positioned against that view, so
  /// without it they cannot be placed into the file's own space.
  ///
  /// [password] is the one the document was opened with, and is needed to read
  /// [originalBytes] at all when the document is protected. The protection
  /// then survives into the saved file by itself: measured across RC4-40,
  /// AES-128 and AES-256, the written document keeps its algorithm, its
  /// permissions and both of its original passwords — including the owner
  /// password, which cannot be recovered from a document opened with the user
  /// one. Nothing here has to put the protection back, and nothing here may
  /// take it off.
  Future<Either<Failure, String>> savePdfFromBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
    required List<PdfPageInfo> pages,
    required String outputPath,
    String? password,
    DocumentProtection? protection,
  }) async {
    final composed = await composePdfBytes(
      originalBytes: originalBytes,
      placedImages: placedImages,
      pages: pages,
      password: password,
      protection: protection,
    );

    return composed.fold(Left.new, (bytes) async {
      try {
        await File(outputPath).writeAsBytes(bytes);
        return Right(outputPath);
      } catch (e) {
        return Left(StorageFailure(message: 'Failed to save PDF: $e'));
      }
    });
  }

  /// The document as the reader sees it, in memory.
  ///
  /// The one place objects, page turns and protection are written, so a save,
  /// a shared copy and a print job cannot come out differently. Nothing here
  /// touches the disk: printing hands these bytes straight to the system, and
  /// a decrypted copy of a protected document must never be written out
  /// (ADR-0011).
  Future<Either<Failure, Uint8List>> composePdfBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
    required List<PdfPageInfo> pages,
    String? password,
    DocumentProtection? protection,
  }) async {
    try {
      final document = PdfDocument(inputBytes: originalBytes, password: password);
      await _apply(document, placedImages, pages);
      if (protection != null) {
        _protect(document, protection);
      }

      final composed = Uint8List.fromList(await document.save());
      document.dispose();
      return Right(composed);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to compose PDF: $e'));
    }
  }

  /// Writes [protection] into [document].
  ///
  /// Called after the objects are placed and before the document is written,
  /// so that what is saved carries the protection the reader asked for rather
  /// than the one the file arrived with. The password the original was *read*
  /// with is a different thing and has already done its work by now.
  void _protect(PdfDocument document, DocumentProtection protection) {
    final security = document.security;

    security.algorithm = _algorithmFor(protection.algorithm);
    security.userPassword = protection.userPassword;
    security.ownerPassword = protection.ownerPassword;
    _setPermissions(security, protection.permissions);
  }

  /// Leaves the document's permissions exactly as [permissions] describes.
  ///
  /// The library's permission set can be added to and taken from but not
  /// cleared, so what is no longer wanted is removed one at a time. Reading
  /// the current set first is what makes this an assignment rather than an
  /// accumulation: without it, permissions could only ever be granted.
  void _setPermissions(
    PdfSecurity security,
    Set<DocumentPermission> permissions,
  ) {
    final wanted = <PdfPermissionsFlags>{
      for (final permission in permissions) ..._flagsFor(permission),
    };

    final current = <PdfPermissionsFlags>[];
    security.permissions.forEach(current.add);
    for (final flag in current) {
      if (flag != PdfPermissionsFlags.none && !wanted.contains(flag)) {
        security.permissions.remove(flag);
      }
    }
    security.permissions.addAll(wanted.toList());
  }

  /// The bits one permission stands for.
  static List<PdfPermissionsFlags> _flagsFor(DocumentPermission permission) =>
      switch (permission) {
        DocumentPermission.printing => [
            PdfPermissionsFlags.print,
            PdfPermissionsFlags.fullQualityPrint,
          ],
        DocumentPermission.copying => [
            PdfPermissionsFlags.copyContent,
            PdfPermissionsFlags.accessibilityCopyContent,
          ],
        DocumentPermission.pageAssembly => [
            PdfPermissionsFlags.assembleDocument,
          ],
        DocumentPermission.annotations => [
            PdfPermissionsFlags.editAnnotations,
          ],
        DocumentPermission.changingContent => [
            PdfPermissionsFlags.editContent,
          ],
        DocumentPermission.formFilling => [PdfPermissionsFlags.fillFields],
      };

  /// AES-256 for protection this app adds; a document that already has an
  /// algorithm keeps it, so the readers it was made for can still open it.
  static PdfEncryptionAlgorithm _algorithmFor(DocumentEncryption? encryption) =>
      switch (encryption) {
        DocumentEncryption.rc4x40 => PdfEncryptionAlgorithm.rc4x40Bit,
        DocumentEncryption.rc4x128 => PdfEncryptionAlgorithm.rc4x128Bit,
        DocumentEncryption.aes128 => PdfEncryptionAlgorithm.aesx128Bit,
        DocumentEncryption.aes256 => PdfEncryptionAlgorithm.aesx256Bit,
        null => PdfEncryptionAlgorithm.aesx256Bit,
      };

  /// Creates a temporary copy of the PDF with images embedded, for sharing.
  ///
  /// The copy carries the original document's protection, so a shared
  /// protected document stays protected and its recipient needs the password.
  Future<Either<Failure, String>> createTempPdfWithImagesFromBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
    required List<PdfPageInfo> pages,
    String? password,
    DocumentProtection? protection,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      return await savePdfFromBytes(
        originalBytes: originalBytes,
        placedImages: placedImages,
        pages: pages,
        outputPath: '${tempDir.path}/${_uuid.v4()}.pdf',
        password: password,
        protection: protection,
      );
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to create temp PDF: $e'));
    }
  }

  /// Writes the reader's turns and objects into [document].
  ///
  /// The one place that does this, so the save, the Save As and the temporary
  /// copy made for sharing cannot come out differently.
  Future<void> _apply(
    PdfDocument document,
    List<PlacedImage> placedImages,
    List<PdfPageInfo> pages,
  ) async {
    final pagesByIndex = {
      for (final page in pages) page.pageNumber - 1: page,
    };

    _writeRotations(document, pages);

    final imagesByPage = <int, List<PlacedImage>>{};
    for (final image in placedImages) {
      imagesByPage.putIfAbsent(image.pageIndex, () => []).add(image);
    }

    for (final entry in imagesByPage.entries) {
      final pageIndex = entry.key;
      if (pageIndex < 0 || pageIndex >= document.pages.count) continue;

      final page = document.pages[pageIndex];
      // The page's own size, which is the media box: `graphics` draws in that
      // space whatever `/Rotate` says. Measured, not assumed.
      final mediaBox = page.size;
      // Fall back to the rotation in the file when the caller did not describe
      // this page, so a document opened elsewhere is still placed correctly.
      final rotation = pagesByIndex[pageIndex]?.rotation ??
          page.rotation.index * 90;

      for (final placedImage in entry.value) {
        await _draw(page.graphics, placedImage, mediaBox, rotation);
      }
    }
  }

  /// Applies the turns the reader made that the file does not have yet.
  void _writeRotations(PdfDocument document, List<PdfPageInfo> pages) {
    for (final page in pages) {
      if (!page.isRotatedFromFile) continue;

      final index = page.pageNumber - 1;
      if (index < 0 || index >= document.pages.count) continue;

      document.pages[index].rotation = _angleOf(page.rotation);
    }
  }

  /// Draws one object, mapped out of the reader's view into the file's space.
  Future<void> _draw(
    PdfGraphics graphics,
    PlacedImage placedImage,
    Size mediaBox,
    int rotation,
  ) async {
    final imageFile = File(placedImage.imagePath);
    if (!await imageFile.exists()) return;

    // Where the object sits in the file, which is what carries the page's
    // rotation. Only its centre is used: the object keeps the width and height
    // it has in its own frame, and the turn is expressed as an angle.
    final center = PageRotationTransform.toFileSpace(
      placedImage.position & placedImage.size,
      mediaBox,
      rotation,
    ).center;
    final angle = PageRotationTransform.angleToFileSpace(
      placedImage.rotation,
      rotation,
    );

    // Drawing into the turned-over rectangle *and* rotating would count the
    // page's rotation twice: the image would stand on end inside a box that is
    // already on its side. The rectangle therefore keeps the object's own
    // sides, centred where the object belongs, and the rotation does the rest.
    final bounds = Rect.fromCenter(
      center: center,
      width: placedImage.size.width,
      height: placedImage.size.height,
    );

    final pdfImage = PdfBitmap(await imageFile.readAsBytes());
    graphics.save();

    if (angle != 0) {
      graphics.translateTransform(center.dx, center.dy);
      graphics.rotateTransform(angle * 180 / math.pi);
      graphics.translateTransform(-center.dx, -center.dy);
    }

    graphics.drawImage(
      pdfImage,
      Rect.fromLTWH(bounds.left, bounds.top, bounds.width, bounds.height),
    );

    graphics.restore();
  }

  static PdfPageRotateAngle _angleOf(int degrees) =>
      switch (PageRotationTransform.normalize(degrees)) {
        90 => PdfPageRotateAngle.rotateAngle90,
        180 => PdfPageRotateAngle.rotateAngle180,
        270 => PdfPageRotateAngle.rotateAngle270,
        _ => PdfPageRotateAngle.rotateAngle0,
      };
}
