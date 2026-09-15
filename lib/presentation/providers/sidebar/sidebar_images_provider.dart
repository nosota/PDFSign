import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  /// Validates each file exists and is a valid image before adding.
  Future<void> addImages(List<String> filePaths) async {
    for (final path in filePaths) {
      await addImageFile(path);
    }
  }

  /// Adds a single image file to the library and returns the stored row.
  ///
  /// Returns null when the file is missing or is not a decodable image. The
  /// row carries the copy made in app storage (ADR-0001) and its dimensions,
  /// which is what a caller needs to place the image on a page.
  Future<SidebarImage?> addImageFile(String path) async {
    final repository = ref.read(sidebarImageRepositoryProvider);

    final file = File(path);
    if (!await file.exists()) return null;

    try {
      // Get image dimensions
      final bytes = await file.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();

      // Extract file info
      final fileName = path.split('/').last;
      final fileSize = await file.length();

      final result = await repository.addImage(
        filePath: path,
        fileName: fileName,
        width: frame.image.width,
        height: frame.image.height,
        fileSize: fileSize,
      );

      frame.image.dispose();

      return result.fold((failure) => null, (image) => image);
    } catch (e) {
      // Not a decodable image
      return null;
    }
  }

  /// Adds an image from raw bytes, as pasted from the clipboard.
  ///
  /// Returns the stored row, or null when the bytes are not a decodable
  /// image — which is what the clipboard offers if another application
  /// advertises a format it cannot actually produce.
  Future<SidebarImage?> addImageData(
    Uint8List bytes, {
    required String fileExtension,
  }) async {
    final repository = ref.read(sidebarImageRepositoryProvider);

    try {
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final width = frame.image.width;
      final height = frame.image.height;
      frame.image.dispose();

      final result = await repository.addImageFromBytes(
        bytes: bytes,
        fileExtension: fileExtension,
        fileName: 'pasted.$fileExtension',
        width: width,
        height: height,
      );
      return result.fold((failure) => null, (image) => image);
    } catch (e) {
      // Not a decodable image
      return null;
    }
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
