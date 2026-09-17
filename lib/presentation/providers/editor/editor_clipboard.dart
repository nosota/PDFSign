import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/utils/focus_utils.dart';
import 'package:pdfsign/domain/entities/clipboard_contents.dart';
import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/history_actions.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/editor/paste_planner.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

/// What a clipboard action did, for the caller to report.
enum EditorClipboardOutcome {
  /// The action was carried out.
  done,

  /// There was nothing to act on: no selection, or nothing pasteable on the
  /// clipboard. Not an error — say nothing.
  nothing,

  /// A text field had focus and handled the action itself.
  handledByTextField,

  /// The clipboard could not be read or written.
  clipboardUnavailable,

  /// An image from the clipboard could not be added to the library.
  imageImportFailed,

  /// The document does not permit its content to be changed.
  editingNotAllowed,
}

/// Cut, copy and paste for objects placed on the document.
///
/// Lives on the system clipboard rather than in a field, because each window
/// is its own Dart isolate (ADR-0006) and nothing in Dart memory can travel
/// between them. That choice also means an object copied here can be pasted
/// into another application, and an image copied from one can be pasted here.
///
/// Every action first checks whether a text field has focus and, if so, hands
/// the action to it. The Edit menu owns Cmd+X/C/V for the whole window — with
/// a `PlatformMenuBar` installed, key equivalents never reach the widget tree
/// — so without that check, typing a comment and pressing Cmd+C would copy the
/// selected object instead of the selected text.
class EditorClipboard {
  EditorClipboard({required this.ref});

  final WidgetRef ref;

  /// Copies the selected object.
  Future<EditorClipboardOutcome> copy() async {
    if (textInputHasFocus()) {
      return _delegateToTextField(CopySelectionTextIntent.copy);
    }
    return _copySelection();
  }

  /// Copies the selected object and removes it from the document.
  Future<EditorClipboardOutcome> cut() async {
    if (textInputHasFocus()) {
      return _delegateToTextField(
        const CopySelectionTextIntent.cut(SelectionChangedCause.keyboard),
      );
    }

    final selected = _selectedImage();
    final outcome = await _copySelection();
    if (outcome != EditorClipboardOutcome.done || selected == null) {
      return outcome;
    }

    recordHistoryStep(ref, () {
      ref.read(placedImagesProvider.notifier).removeImage(selected.id);
      ref.read(editorSelectionProvider.notifier).clear();
    });
    return EditorClipboardOutcome.done;
  }

  /// Puts the clipboard contents on the page currently in view.
  Future<EditorClipboardOutcome> paste() async {
    if (textInputHasFocus()) {
      return _delegateToTextField(
        PasteTextIntent(SelectionChangedCause.keyboard),
      );
    }

    if (!_editingAllowed) {
      return EditorClipboardOutcome.editingNotAllowed;
    }

    final target = _targetPage();
    if (target == null) {
      return EditorClipboardOutcome.nothing;
    }

    final contents = await _readClipboard();
    if (contents == null) {
      return EditorClipboardOutcome.clipboardUnavailable;
    }
    if (contents.isEmpty) {
      return EditorClipboardOutcome.nothing;
    }

    final plan = await PastePlanner(
      ref: ref,
      pageIndex: target.index,
      pageSize: target.size,
    ).plan(contents);
    if (plan == null) {
      // An image that could not be imported is worth reporting; an empty
      // clipboard is not.
      return contents.image == null
          ? EditorClipboardOutcome.nothing
          : EditorClipboardOutcome.imageImportFailed;
    }

    _place(plan, target.index);
    return EditorClipboardOutcome.done;
  }

  /// Whether the open document permits its content to be changed.
  bool get _editingAllowed =>
      ref.read(pdfDocumentProvider).documentOrNull?.security.allowsEditing ??
      true;

  /// Reads the clipboard, or null when it cannot be reached.
  Future<ClipboardContents?> _readClipboard() async {
    final read = await ref.read(clipboardRepositoryProvider).read();
    return read.fold((failure) => null, (contents) => contents);
  }

  /// Adds the planned object to the page and selects it.
  void _place(PastePlan plan, int pageIndex) {
    recordHistoryStep(ref, () {
      final placed = ref.read(placedImagesProvider.notifier).addImage(
            sourceImageId: plan.sourceImageId,
            imagePath: plan.imagePath,
            pageIndex: pageIndex,
            position: plan.position,
            size: plan.size,
            rotation: plan.rotation,
          );
      ref.read(editorSelectionProvider.notifier).select(placed.id);
    });
  }

  Future<EditorClipboardOutcome> _copySelection() async {
    final selected = _selectedImage();
    if (selected == null) {
      return EditorClipboardOutcome.nothing;
    }

    // The library row may have been deleted, taking the file with it (§13.1).
    // Without bytes there is nothing another application could paste, and our
    // own payload would point at a path that no longer resolves.
    final file = File(selected.imagePath);
    final format = ClipboardImageFormat.forExtension(
      selected.imagePath.split('.').last,
    );
    if (format == null || !await file.exists()) {
      return EditorClipboardOutcome.nothing;
    }

    final written =
        await ref.read(clipboardRepositoryProvider).writePlacedObject(
              object: ClipboardPlacedObject(
                sourceImageId: selected.sourceImageId,
                imagePath: selected.imagePath,
                size: selected.size,
                position: selected.position,
                rotation: selected.rotation,
              ),
              imageBytes: await file.readAsBytes(),
              imageFormat: format,
            );

    return written.fold(
      (failure) => EditorClipboardOutcome.clipboardUnavailable,
      (_) => EditorClipboardOutcome.done,
    );
  }

  /// Hands the action to the focused text field.
  ///
  /// `EditableText` registers actions for these intents, so invoking one from
  /// the field's own context reaches it the same way the key press would have.
  EditorClipboardOutcome _delegateToTextField(Intent intent) {
    final context = FocusManager.instance.primaryFocus?.context;
    if (context != null) {
      Actions.invoke(context, intent);
    }
    return EditorClipboardOutcome.handledByTextField;
  }

  PlacedImage? _selectedImage() {
    final selectedId = ref.read(editorSelectionProvider);
    if (selectedId == null) {
      return null;
    }
    for (final image in ref.read(placedImagesProvider)) {
      if (image.id == selectedId) {
        return image;
      }
    }
    return null;
  }

  /// The page a paste lands on: the one the viewer reports as current.
  ({int index, Size size})? _targetPage() {
    final document = ref.read(pdfDocumentProvider);
    final info = document.documentOrNull;
    if (info == null || info.pages.isEmpty) {
      return null;
    }

    final currentPage = document.maybeMap(
      loaded: (state) => state.currentPage,
      orElse: () => 1,
    );
    final index = currentPage.clamp(1, info.pages.length) - 1;
    final page = info.pages[index];

    if (page.width <= 0 || page.height <= 0) {
      return null;
    }
    return (index: index, size: Size(page.width, page.height));
  }

}
