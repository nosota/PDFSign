import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/constants/image_import_limits.dart';
import 'package:pdfsign/domain/entities/clipboard_contents.dart';
import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/placed_image_placement.dart';

/// A resolved paste: what to put on the page, and where.
class PastePlan {
  const PastePlan({
    required this.imagePath,
    required this.position,
    required this.size,
    required this.rotation,
    this.sourceImageId,
  });

  /// Library row the object comes from, or null for a pasted image.
  final String? sourceImageId;
  final String imagePath;
  final Offset position;
  final Size size;
  final double rotation;
}

/// Turns clipboard contents into a placement on one page.
///
/// Kept apart from [EditorClipboard] because the two answer different
/// questions: that one decides *whether* a paste happens and who handles it,
/// this one decides *what lands where*.
class PastePlanner {
  PastePlanner({
    required this.ref,
    required this.pageIndex,
    required this.pageSize,
  });

  final WidgetRef ref;

  /// Page the object will land on.
  final int pageIndex;

  /// That page's size in PDF points.
  final Size pageSize;

  /// How many times a paste may step aside before giving up on finding a free
  /// spot. Reached only when a page is already stacked with copies.
  static const _maxCascadeSteps = 20;

  /// Works out what to place and where, or null if nothing can be.
  Future<PastePlan?> plan(ClipboardContents contents) async {
    final source = await _resolveSource(contents);
    if (source == null) {
      return null;
    }

    final size = PlacedImagePlacement.fitToPage(source.size, pageSize);
    return PastePlan(
      sourceImageId: source.sourceImageId,
      imagePath: source.imagePath,
      position: _freePosition(
        PlacedImagePlacement.clampToPage(source.position, size, pageSize),
        size,
      ),
      size: size,
      rotation: source.rotation,
    );
  }

  /// Prefers our own payload, which restores size and rotation exactly. Falls
  /// back to the bitmap when the payload's image is gone, or when the
  /// clipboard came from another application.
  Future<PastePlan?> _resolveSource(ClipboardContents contents) async {
    final object = contents.placedObject;
    if (object != null && await File(object.imagePath).exists()) {
      return PastePlan(
        sourceImageId: object.sourceImageId,
        imagePath: object.imagePath,
        position: object.position + PlacedImagePlacement.cascadeStep,
        size: object.size,
        rotation: object.rotation,
      );
    }

    final image = contents.image;
    return image == null ? null : _fromImage(image, object);
  }

  /// Stores a bitmap with the document and places it.
  ///
  /// A pasted image is not added to the image library: it belongs to this
  /// document, not to the user's collection of stamps and signatures. It still
  /// needs a file on disk, because the object is drawn from its path and
  /// `PdfSaveService` reads that path when embedding it (ADR-0009).
  ///
  /// [object] is the payload the bitmap arrived with, if any: it carries the
  /// size and rotation the object was copied at, which survive the detour.
  Future<PastePlan?> _fromImage(
    ClipboardImage image,
    ClipboardPlacedObject? object,
  ) async {
    // The same limits as a library import: an oversized image is no more
    // welcome in a document for having arrived through the clipboard.
    final pixels = await _decodedSize(image.bytes);
    if (ImageImportLimits.forByteCount(image.bytes.length) != null ||
        (pixels != null &&
            ImageImportLimits.forDimensions(pixels.width, pixels.height) !=
                null)) {
      return null;
    }

    final stored = await ref
        .read(pastedImageStorageProvider)
        .save(image.bytes, fileExtension: image.format.fileExtension);
    final imagePath = stored.fold((failure) => null, (path) => path);
    if (imagePath == null) {
      return null;
    }

    final size = object?.size ?? _sizeFor(pixels);
    return PastePlan(
      imagePath: imagePath,
      position: object == null
          ? PlacedImagePlacement.centeredOnPage(size, pageSize)
          : object.position + PlacedImagePlacement.cascadeStep,
      size: size,
      rotation: object?.rotation ?? 0,
    );
  }

  /// Pixel dimensions of [bytes], or null when they do not decode.
  ///
  /// Undecodable here means the clipboard offered a format it could not
  /// actually produce.
  Future<({int width, int height})?> _decodedSize(Uint8List bytes) async {
    try {
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final size = (width: frame.image.width, height: frame.image.height);
      frame.image.dispose();
      return size;
    } catch (e) {
      return null;
    }
  }

  /// Size a freshly pasted bitmap gets on the page, from its proportions.
  ///
  /// A square for an image whose proportions are unknown — a better answer
  /// than refusing a paste the user can see is an image.
  Size _sizeFor(({int width, int height})? pixels) {
    final ratio = pixels != null && pixels.height > 0
        ? pixels.width / pixels.height
        : 1.0;
    return PlacedImagePlacement.defaultSizeFor(ratio, pageSize);
  }

  /// Steps the position aside while an object already sits exactly there.
  ///
  /// Pasting twice in a row would otherwise hide the second copy under the
  /// first, which reads as the paste having done nothing.
  Offset _freePosition(Offset position, Size size) {
    final onPage = ref
        .read(placedImagesProvider)
        .where((image) => image.pageIndex == pageIndex)
        .toList();

    var candidate = position;
    for (var step = 0; step < _maxCascadeSteps; step++) {
      final taken = onPage.any(
        (image) => _samePosition(image.position, candidate),
      );
      if (!taken) {
        return candidate;
      }
      final next = PlacedImagePlacement.clampToPage(
        candidate + PlacedImagePlacement.cascadeStep,
        size,
        pageSize,
      );
      if (_samePosition(next, candidate)) {
        // Clamped against the page edge: stepping again cannot help.
        return candidate;
      }
      candidate = next;
    }
    return candidate;
  }

  static bool _samePosition(Offset a, Offset b) =>
      (a.dx - b.dx).abs() < 0.5 && (a.dy - b.dy).abs() < 0.5;
}
