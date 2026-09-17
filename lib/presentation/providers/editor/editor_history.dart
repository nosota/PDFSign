import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';

part 'editor_history.g.dart';

/// How many steps a document may be taken back.
const historyDepthLimit = 50;

/// The editable state of a document at one moment.
///
/// Everything a reader can change about a document and undo is here: the
/// objects on its pages and the turn each page is shown at. Both are needed
/// together, because turning a page moves the objects standing on it, and an
/// undo that put one back without the other would leave them apart.
///
/// Holding one costs almost nothing. [PlacedImage] is immutable and
/// `PlacedImages` replaces the whole list on every change rather than mutating
/// it, so [objects] is a reference to a list nobody will alter — the same
/// argument ADR-0008 makes for the baseline the dirty state is measured
/// against. Fifty of these share every object that did not change between
/// them.
class EditorSnapshot extends Equatable {
  const EditorSnapshot({
    required this.objects,
    required this.pageRotations,
    required this.selectedId,
    this.protection,
  });

  /// The objects on the document, in the order they are drawn.
  final List<PlacedImage> objects;

  /// The turn each page is shown at, in degrees clockwise, in page order.
  ///
  /// Only the turn as displayed. What the file says is deliberately left out:
  /// that is the baseline a save writes, and restoring it would tell the
  /// document it had been saved when it had not.
  final List<int> pageRotations;

  /// What was selected, so an undo puts the reader back where they were.
  final String? selectedId;

  /// The protection the reader has asked for and not yet saved, if any.
  ///
  /// Null both for a document nobody has changed the protection of and for one
  /// changed back to that, which is the same thing and should compare equal.
  final DocumentProtection? protection;

  /// Whether this describes the same document as [other].
  ///
  /// The selection is left out on purpose: selecting something is not a change
  /// to the document and must not become a step of its own.
  bool describesSameDocumentAs(EditorSnapshot other) =>
      listEquals(objects, other.objects) &&
      listEquals(pageRotations, other.pageRotations) &&
      protection == other.protection;

  @override
  List<Object?> get props => [objects, pageRotations, selectedId, protection];
}

/// Which way a document can be taken from where it stands.
class HistoryDepth extends Equatable {
  const HistoryDepth({this.canUndo = false, this.canRedo = false});

  /// Whether there is a step to go back to.
  final bool canUndo;

  /// Whether there is a step to come back to.
  final bool canRedo;

  @override
  List<Object?> get props => [canUndo, canRedo];
}

/// The undo history of one window's document.
///
/// Holds snapshots and nothing else: it does not read or write the providers
/// the snapshots come from. Coordination between those lives in
/// `history_actions.dart`, which is where `CLAUDE.md` puts work that has to
/// move two pieces of state together.
///
/// Snapshots rather than a command for each action. A command has to say how
/// to undo itself, and the actions here include turning a page, which moves
/// every object on it through a coordinate transform. An inverse written by
/// hand for that is a quiet way to corrupt a document; restoring a snapshot is
/// an assignment, and cannot be got subtly wrong.
@Riverpod(keepAlive: true)
class EditorHistory extends _$EditorHistory {
  final List<EditorSnapshot> _past = [];
  final List<EditorSnapshot> _future = [];

  /// The state as it was before the step being made now, if one is open.
  EditorSnapshot? _open;

  @override
  HistoryDepth build() => const HistoryDepth();

  /// Steps that can be undone. For tests.
  @visibleForTesting
  int get undoDepth => _past.length;

  /// Steps that can be redone. For tests.
  @visibleForTesting
  int get redoDepth => _future.length;

  /// Opens a step, remembering the state to come back to.
  ///
  /// Idempotent while a step is open, so a gesture that reports every frame
  /// can call it on each one without needing to know it is the first. [before]
  /// is a function rather than a value because of that: a resize reports on
  /// every frame of the drag, and building a snapshot to throw away each time
  /// would allocate a list the length of the document per frame.
  void begin(EditorSnapshot Function() before) => _open ??= before();

  /// Closes the open step.
  ///
  /// The step is kept only if [after] differs from where it began: a drag that
  /// went nowhere, or a restacking of an object already at the front, is not
  /// something the reader can meaningfully undo, and an entry for it would
  /// make the next ⌘Z appear to do nothing.
  void commit(EditorSnapshot after) {
    final before = _open;
    _open = null;
    if (before == null || before.describesSameDocumentAs(after)) return;

    _past.add(before);
    if (_past.length > historyDepthLimit) {
      _past.removeAt(0);
    }
    // Anything done afresh is a new branch: what was undone cannot be redone
    // on top of it.
    _future.clear();
    _publish();
  }

  /// Abandons the open step without keeping it.
  void abandon() => _open = null;

  /// Takes one step back, given [current], or null when there is none.
  EditorSnapshot? undo(EditorSnapshot current) {
    if (_past.isEmpty) return null;
    _open = null;
    _future.add(current);
    final restored = _past.removeLast();
    _publish();
    return restored;
  }

  /// Takes one step forward, given [current], or null when there is none.
  EditorSnapshot? redo(EditorSnapshot current) {
    if (_future.isEmpty) return null;
    _open = null;
    _past.add(current);
    final restored = _future.removeLast();
    _publish();
    return restored;
  }

  /// Forgets everything.
  ///
  /// The document in the window has been replaced — opened, or saved under a
  /// new name, which clears the page and starts a new file. Steps that belong
  /// to what was there before would put back objects this document never had.
  void clear() {
    _past.clear();
    _future.clear();
    _open = null;
    _publish();
  }

  void _publish() {
    state = HistoryDepth(
      canUndo: _past.isNotEmpty,
      canRedo: _future.isNotEmpty,
    );
  }
}
