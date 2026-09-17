import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/history_actions.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';

/// Where a restacking move takes the selected object.
enum ZOrderMove {
  /// In front of everything else on its page.
  toFront,

  /// Past the one object in front of it.
  forward,

  /// Behind the one object behind it.
  backward,

  /// Behind everything else on its page.
  toBack,
}

/// Moves the selected object through the stack of its page.
///
/// Returns whether anything moved, so a caller can stay quiet when there was
/// nothing to do: no selection, a document that forbids changes, or an object
/// already as far as the move would take it.
///
/// A top-level helper rather than a method on the notifier because it reads
/// the selection, which lives in another provider — a provider writing into
/// another is what `CLAUDE.md` forbids.
bool restackSelected(WidgetRef ref, ZOrderMove move) {
  final document = ref.read(pdfDocumentProvider).documentOrNull;
  // Restacking changes the order objects are drawn in and so what the saved
  // file looks like; a document that does not allow changes does not allow
  // this one.
  if (document != null && !document.security.allowsEditing) {
    return false;
  }

  final selectedId = ref.read(editorSelectionProvider);
  if (selectedId == null) return false;

  final images = ref.read(placedImagesProvider.notifier);
  final before = ref.read(placedImagesProvider);

  recordHistoryStep(ref, () {
    switch (move) {
      case ZOrderMove.toFront:
        images.bringToFront(selectedId);
      case ZOrderMove.forward:
        images.bringForward(selectedId);
      case ZOrderMove.backward:
        images.sendBackward(selectedId);
      case ZOrderMove.toBack:
        images.sendToBack(selectedId);
    }
  });

  // The notifier leaves the list untouched when the move changes nothing, so
  // this is an exact answer rather than a guess at one.
  return !identical(ref.read(placedImagesProvider), before);
}
