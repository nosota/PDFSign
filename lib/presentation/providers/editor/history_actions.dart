import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/utils/focus_utils.dart';

import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/presentation/providers/editor/editor_history.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';

/// Reading and restoring the document state the undo history is made of.
///
/// Top-level helpers rather than methods on a notifier: they move the objects
/// and the pages together, and a provider writing into another is what
/// `CLAUDE.md` forbids. [EditorHistory] itself holds snapshots and never
/// touches the providers they came from.

/// The document as it stands.
EditorSnapshot currentSnapshot(WidgetRef ref) {
  final document = ref.read(pdfDocumentProvider).documentOrNull;
  return EditorSnapshot(
    objects: ref.read(placedImagesProvider),
    pageRotations: [
      for (final page in document?.pages ?? const <PdfPageInfo>[])
        page.rotation,
    ],
    selectedId: ref.read(editorSelectionProvider),
  );
}

/// Runs [change] as one step that can be undone.
///
/// For an action that happens at once. A gesture that reports over many frames
/// uses [beginHistoryStep] and [endHistoryStep] instead, so that the whole
/// drag is one step rather than one per frame.
void recordHistoryStep(WidgetRef ref, void Function() change) {
  beginHistoryStep(ref);
  change();
  endHistoryStep(ref);
}

/// Opens a step, remembering the document as it is now.
///
/// Idempotent while a step is open: a gesture may call it on every frame.
void beginHistoryStep(WidgetRef ref) =>
    ref.read(editorHistoryProvider.notifier).begin(() => currentSnapshot(ref));

/// Closes the open step, keeping it only if the document actually changed.
void endHistoryStep(WidgetRef ref) =>
    ref.read(editorHistoryProvider.notifier).commit(currentSnapshot(ref));

/// Takes the document one step back. Returns whether there was one.
///
/// While a text field holds the keyboard the step is the field's own: ⌘Z in
/// the middle of typing a comment should take back a letter, not the object
/// placed before the reader started typing.
bool undoEdit(WidgetRef ref) {
  if (_handedToTextField(const UndoTextIntent(SelectionChangedCause.keyboard))) {
    return true;
  }
  return _travel(ref, (history, current) => history.undo(current));
}

/// Takes the document one step forward. Returns whether there was one.
bool redoEdit(WidgetRef ref) {
  if (_handedToTextField(const RedoTextIntent(SelectionChangedCause.keyboard))) {
    return true;
  }
  return _travel(ref, (history, current) => history.redo(current));
}

/// Gives [intent] to the focused text field, if there is one.
bool _handedToTextField(Intent intent) {
  if (!textInputHasFocus()) return false;

  final context = FocusManager.instance.primaryFocus?.context;
  if (context != null) {
    Actions.invoke(context, intent);
  }
  return true;
}

/// Forgets the history of this window's document.
///
/// The document has been replaced — opened, or saved under a new name, which
/// clears the page and starts a new file.
void clearHistory(WidgetRef ref) =>
    ref.read(editorHistoryProvider.notifier).clear();

bool _travel(
  WidgetRef ref,
  EditorSnapshot? Function(EditorHistory history, EditorSnapshot current) step,
) {
  final history = ref.read(editorHistoryProvider.notifier);
  final restored = step(history, currentSnapshot(ref));
  if (restored == null) return false;

  _restore(ref, restored);
  return true;
}

void _restore(WidgetRef ref, EditorSnapshot snapshot) {
  ref.read(placedImagesProvider.notifier).replaceAll(snapshot.objects);
  ref.read(pdfDocumentProvider.notifier).restoreRotations(snapshot.pageRotations);

  // Put the reader back where they were, but only on something that is there:
  // undoing the placing of an object leaves its selection pointing at nothing.
  final selected = snapshot.selectedId;
  final selection = ref.read(editorSelectionProvider.notifier);
  if (selected != null &&
      snapshot.objects.any((object) => object.id == selected)) {
    selection.select(selected);
  } else {
    selection.clear();
  }
}
