import 'package:flutter/foundation.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/document_protection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_dirty_provider.g.dart';

/// The objects as they stood the last time the document was written, or empty
/// for a document that has not been saved in this session.
///
/// This is the object-side counterpart of `OriginalPdfStorage`, which keeps the
/// file-side baseline. Both live in memory for the lifetime of the window,
/// which is exactly as long as the placed objects themselves exist.
///
/// Holding it costs nothing: [PlacedImages] replaces the whole list on every
/// change and [PlacedImage] is immutable, so a baseline is a reference to a
/// list that is never mutated, not a copy.
@Riverpod(keepAlive: true)
class SavedPlacedImages extends _$SavedPlacedImages {
  @override
  List<PlacedImage> build() => const [];

  /// Records [current] as written to disk, which makes the document clean.
  ///
  /// The caller passes the exact list it handed to the writer rather than this
  /// re-reading the provider: a save is asynchronous, and re-reading on
  /// completion would record edits made *during* the save as if they had been
  /// written.
  // ignore: use_setters_to_change_properties
  void markSaved(List<PlacedImage> current) {
    state = current;
  }

  /// Resets the baseline to an empty document.
  ///
  /// Used when a document is opened, reloaded, or saved under a new name —
  /// all of which leave the page without placed objects.
  void reset() {
    state = const [];
  }
}

/// Whether any page is turned differently than the file has it.
///
/// Kept apart from the objects because the two are recorded differently: an
/// object's baseline is a snapshot, a page's is the `/Rotate` it was read
/// with, which the page itself carries.
@Riverpod(keepAlive: true)
bool hasUnsavedPageRotation(HasUnsavedPageRotationRef ref) {
  final document = ref.watch(pdfDocumentProvider).documentOrNull;
  return document?.pages.any((page) => page.isRotatedFromFile) ?? false;
}

/// Whether the document has changes that are not in the file yet.
///
/// Derived rather than flagged: it answers the only question that matters —
/// does the current set of objects differ from what was written? Marking a
/// flag by hand at each call site made move, resize and rotate invisible, and
/// let a delete after a save report the document as clean (ADR-0008).
@Riverpod(keepAlive: true)
bool documentDirty(DocumentDirtyRef ref) =>
    !listEquals(
      ref.watch(placedImagesProvider),
      ref.watch(savedPlacedImagesProvider),
    ) ||
    ref.watch(hasUnsavedPageRotationProvider) ||
    ref.watch(protectionChangedProvider);
