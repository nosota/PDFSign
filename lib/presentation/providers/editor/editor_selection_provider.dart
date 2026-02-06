import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';

part 'editor_selection_provider.g.dart';

/// Provider for tracking the currently selected placed image.
///
/// Only one image can be selected at a time.
@riverpod
class EditorSelection extends _$EditorSelection {
  @override
  String? build() {
    return null;
  }

  /// Selects an image by its ID.
  void select(String id) {
    state = id;
  }

  /// Clears the selection.
  void clear() {
    state = null;
  }

  /// Toggles selection for an image.
  void toggle(String id) {
    if (state == id) {
      state = null;
    } else {
      state = id;
    }
  }

  /// Checks if a specific image is selected.
  bool isSelected(String id) => state == id;
}

/// Deletes the currently selected image and clears selection.
///
/// This is a coordinating function that works across multiple providers:
/// - Removes the image from [placedImagesProvider]
/// - Clears the selection in [editorSelectionProvider]
/// - Marks the document as dirty in [documentDirtyProvider]
///
/// Does nothing if no image is selected.
void deleteSelectedImage(WidgetRef ref) {
  final selectedId = ref.read(editorSelectionProvider);
  if (selectedId == null) return;

  ref.read(placedImagesProvider.notifier).removeImage(selectedId);
  ref.read(editorSelectionProvider.notifier).clear();
  ref.read(documentDirtyProvider.notifier).markDirty();
}
