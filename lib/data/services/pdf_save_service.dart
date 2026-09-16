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
  Future<Either<Failure, String>> savePdfFromBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
    required List<PdfPageInfo> pages,
    required String outputPath,
  }) async {
    try {
      final document = PdfDocument(inputBytes: originalBytes);
      await _apply(document, placedImages, pages);

      final savedBytes = await document.save();
      document.dispose();

      await File(outputPath).writeAsBytes(savedBytes);
      return Right(outputPath);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to save PDF: $e'));
    }
  }

  /// Creates a temporary copy of the PDF with images embedded, for sharing.
  Future<Either<Failure, String>> createTempPdfWithImagesFromBytes({
    required Uint8List originalBytes,
    required List<PlacedImage> placedImages,
    required List<PdfPageInfo> pages,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      return await savePdfFromBytes(
        originalBytes: originalBytes,
        placedImages: placedImages,
        pages: pages,
        outputPath: '${tempDir.path}/${_uuid.v4()}.pdf',
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
