import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/presentation/providers/editor/history_actions.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';

/// Turns the page the reader is looking at by a quarter turn.
///
/// Positive turns clockwise, negative anticlockwise. Returns whether anything
/// was turned, so a caller can stay quiet when there was no page to turn.
///
/// A top-level helper rather than a method on either notifier because it has
/// to move two pieces of state together: the page's own description and the
/// objects standing on it. A provider writing into another provider is what
/// `CLAUDE.md` forbids, and splitting the work across two call sites is how
/// the two would drift apart.
bool rotateCurrentPage(WidgetRef ref, int quarterTurns) {
  if (quarterTurns % 4 == 0) {
    return false;
  }

  final state = ref.read(pdfDocumentProvider);
  final document = state.documentOrNull;
  if (document == null || document.pages.isEmpty) {
    return false;
  }
  // A turn is written into the file, so a document that does not allow its
  // content to be changed does not allow this either.
  if (!document.security.allowsEditing) {
    return false;
  }

  final pageNumber = state
      .maybeMap(loaded: (loaded) => loaded.currentPage, orElse: () => 1)
      .clamp(1, document.pages.length);
  final page = document.pages[pageNumber - 1];

  recordHistoryStep(ref, () {
    // The objects are turned against the page as it stands *now*: the notifier
    // below replaces it with the turned one, and the old sides are what the
    // objects' coordinates are expressed against.
    ref.read(placedImagesProvider.notifier).turnPage(
          pageNumber - 1,
          quarterTurns,
          Size(page.width, page.height),
        );
    ref.read(pdfDocumentProvider.notifier).rotatePage(pageNumber, quarterTurns);
  });

  return true;
}
