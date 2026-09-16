import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/core/constants/image_import_limits.dart';
import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

part 'sidebar_images_provider.g.dart';

/// Provider for sidebar images with real-time multi-window sync.
///
/// Uses a stream-based approach to receive updates from Isar database
/// whenever images are added, removed, or reordered in any window.
@riverpod
class SidebarImages extends _$SidebarImages {
  @override
  Stream<List<SidebarImage>> build() {
    final repository = ref.watch(sidebarImageRepositoryProvider);
    return repository.watchImages();
  }

  /// Adds images from file paths.
  ///
  /// Reports what happened so the caller can tell the user about anything
  /// that was refused; a file that is silently dropped looks like a bug.
  Future<ImageImportReport> addImages(List<String> filePaths) async {
    var added = 0;
    final rejections = <ImageImportRejection>[];

    for (final path in filePaths) {
      final outcome = await _addImageFile(path);
      if (outcome.stored) {
        added++;
      }
      final rejection = outcome.rejection;
      if (rejection != null) {
        rejections.add(rejection);
      }
    }

    return ImageImportReport(added: added, rejections: rejections);
  }

  /// Adds one image file to the library.
  ///
  /// Reports whether it was stored and, separately, whether it was refused
  /// for a reason worth naming. A file that is missing or undecodable is
  /// neither stored nor refused: there is nothing to tell the user beyond
  /// what they already know about their own file.
  Future<({bool stored, ImageImportRejection? rejection})> _addImageFile(
    String path,
  ) async {
    final repository = ref.read(sidebarImageRepositoryProvider);

    final file = File(path);
    if (!await file.exists()) return (stored: false, rejection: null);

    // Size first, before the bytes are read: reading a file to find out it is
    // too big to read defeats the limit.
    final fileSize = await file.length();
    final tooLarge = ImageImportLimits.forByteCount(fileSize);
    if (tooLarge != null) return (stored: false, rejection: tooLarge);

    try {
      final bytes = await file.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final width = frame.image.width;
      final height = frame.image.height;
      frame.image.dispose();

      final tooManyPixels = ImageImportLimits.forDimensions(width, height);
      if (tooManyPixels != null) {
        return (stored: false, rejection: tooManyPixels);
      }

      final result = await repository.addImage(
        filePath: path,
        fileName: path.split('/').last,
        width: width,
        height: height,
        fileSize: fileSize,
      );
      return (stored: result.isRight(), rejection: null);
    } catch (e) {
      // Not a decodable image
      return (stored: false, rejection: null);
    }
  }

  /// Records the size an image was last given on a page.
  ///
  /// The next object dragged out of the library starts at this size. Objects
  /// already on a page are not touched: three copies of one image, resized
  /// separately, keep their three sizes.
  ///
  /// Silent on failure. The reader resized an object and it stayed resized;
  /// that the preference could not be written is not worth interrupting them
  /// for, and the next resize will try again.
  Future<void> rememberSize(String id, Size size) async {
    if (size.width <= 0 || size.height <= 0) {
      return;
    }
    await ref.read(sidebarImageRepositoryProvider).updateLastUsedSize(id, size);
  }

  /// Removes an image by its ID.
  Future<void> removeImage(String id) async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.removeImage(id);
  }

  /// Reorders images after drag-and-drop.
  ///
  /// [oldIndex] is the original position.
  /// [newIndex] is the target position.
  Future<void> reorder(int oldIndex, int newIndex) async {
    final currentImages = state.valueOrNull ?? [];
    if (currentImages.isEmpty) return;

    // Calculate new order
    final ids = currentImages.map((i) => i.id).toList();
    final item = ids.removeAt(oldIndex);

    // Adjust newIndex for removal
    final adjustedNewIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
    ids.insert(adjustedNewIndex, item);

    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.reorderImages(ids);
  }

  /// Clears all images from the sidebar.
  Future<void> clearAll() async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.clearAllImages();
  }

  /// Updates the comment for an image by ID.
  Future<void> updateComment(String id, String? comment) async {
    final repository = ref.read(sidebarImageRepositoryProvider);
    await repository.updateComment(id, comment);
  }
}

/// What one call to [SidebarImages.addImages] did.
class ImageImportReport {
  const ImageImportReport({
    required this.added,
    required this.rejections,
  });

  /// How many images reached the library.
  final int added;

  /// Why each refused image was refused, one entry per image.
  final List<ImageImportRejection> rejections;

  /// The single reason every refusal shared, or null when they differ or
  /// when nothing was refused.
  ///
  /// Lets the caller name the limit that was hit instead of saying only that
  /// something went wrong.
  ImageImportRejection? get sharedRejection {
    if (rejections.isEmpty) return null;
    final first = rejections.first;
    return rejections.every((r) => r == first) ? first : null;
  }
}
