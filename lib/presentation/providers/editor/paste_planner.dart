import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/clipboard_contents.dart';
import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/placed_image_placement.dart';

/// A resolved paste: what to put on the page, and where.
class PastePlan {
  const PastePlan({
    required this.sourceImageId,
    required this.imagePath,
    required this.position,
    required this.size,
    required this.rotation,
  });

  final String sourceImageId;
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

  /// Imports a bitmap into the library and places it.
  ///
  /// The library writes the bytes into app storage under a UUID (ADR-0001), so
  /// the placed object keeps working for as long as the library row does — and
  /// the user gets the pasted image in the sidebar to reuse.
  ///
  /// [object] is the payload the bitmap arrived with, if any: it carries the
  /// size and rotation the object was copied at, which survive the detour.
  Future<PastePlan?> _fromImage(
    ClipboardImage image,
    ClipboardPlacedObject? object,
  ) async {
    final imported = await ref
        .read(sidebarImagesProvider.notifier)
        .addImageData(image.bytes, fileExtension: image.format.fileExtension);
    if (imported == null) {
      return null;
    }

    final size = object?.size ??
        PlacedImagePlacement.defaultSizeFor(
          imported.height > 0 ? imported.width / imported.height : 1,
          pageSize,
        );

    return PastePlan(
      sourceImageId: imported.id,
      imagePath: imported.filePath,
      position: object == null
          ? PlacedImagePlacement.centeredOnPage(size, pageSize)
          : object.position + PlacedImagePlacement.cascadeStep,
      size: size,
      rotation: object?.rotation ?? 0,
    );
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
