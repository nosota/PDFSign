import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/editor_history.dart';

/// A document with [count] objects on it, so two snapshots can be told apart.
EditorSnapshot snapshot({
  int count = 0,
  List<int> rotations = const [0],
  String? selected,
}) =>
    EditorSnapshot(
      objects: [
        for (var i = 0; i < count; i++)
          PlacedImage(
            id: 'object-$i',
            imagePath: '/storage/stamp.png',
            pageIndex: 0,
            position: const Offset(10, 10),
            size: const Size(40, 20),
          ),
      ],
      pageRotations: rotations,
      selectedId: selected,
    );

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  EditorHistory history() => container.read(editorHistoryProvider.notifier);

  HistoryDepth depth() => container.read(editorHistoryProvider);

  group('a fresh history', () {
    test('should have nowhere to go', () {
      expect(depth().canUndo, isFalse);
      expect(depth().canRedo, isFalse);
    });

    test('should ignore a step that was never opened', () {
      history().commit(snapshot(count: 1));

      expect(depth().canUndo, isFalse);
    });
  });

  group('making a step', () {
    test('should be able to go back afterwards', () {
      history()
        ..begin(() => snapshot())
        ..commit(snapshot(count: 1));

      expect(depth().canUndo, isTrue);
      expect(depth().canRedo, isFalse);
    });

    test('should keep nothing when the document did not change', () {
      // A drag that went nowhere, or an object sent to a front it was already
      // at. An entry for it would make the next undo appear to do nothing.
      history()
        ..begin(() => snapshot(count: 1))
        ..commit(snapshot(count: 1));

      expect(depth().canUndo, isFalse);
    });

    test('should not count a change of selection as a step', () {
      history()
        ..begin(() => snapshot(count: 1, selected: 'object-0'))
        ..commit(snapshot(count: 1));

      expect(depth().canUndo, isFalse);
    });

    test('should take the state from where the step began, however many '
        'times it was opened', () {
      // A gesture reports every frame and opens the step on each one, because
      // it cannot tell which frame is the first.
      final start = snapshot();
      history()
        ..begin(() => start)
        ..begin(() => snapshot(count: 1))
        ..begin(() => snapshot(count: 2))
        ..commit(snapshot(count: 3));

      expect(history().undo(snapshot(count: 3)), start);
    });

    test('should keep an abandoned step out of the history', () {
      history()
        ..begin(() => snapshot())
        ..abandon()
        ..commit(snapshot(count: 1));

      expect(depth().canUndo, isFalse);
    });
  });

  group('going back and forward', () {
    test('should return the state the step began at', () {
      final before = snapshot();
      final after = snapshot(count: 1);
      history()
        ..begin(() => before)
        ..commit(after);

      expect(history().undo(after), before);
      expect(depth().canUndo, isFalse);
      expect(depth().canRedo, isTrue);
    });

    test('should return the state the step ended at', () {
      final before = snapshot();
      final after = snapshot(count: 1);
      history()
        ..begin(() => before)
        ..commit(after);
      history().undo(after);

      expect(history().redo(before), after);
      expect(depth().canUndo, isTrue);
      expect(depth().canRedo, isFalse);
    });

    test('should report nothing when there is nowhere to go', () {
      expect(history().undo(snapshot()), isNull);
      expect(history().redo(snapshot()), isNull);
    });

    test('should drop what was undone once something else is done', () {
      // The reader has taken another road; the one they turned off cannot be
      // rejoined from here.
      history()
        ..begin(() => snapshot())
        ..commit(snapshot(count: 1));
      history().undo(snapshot(count: 1));
      expect(depth().canRedo, isTrue);

      history()
        ..begin(() => snapshot())
        ..commit(snapshot(count: 2));

      expect(depth().canRedo, isFalse);
    });

    test('should close an open step rather than carry it across', () {
      // ⌘Z in the middle of a drag: the drag's own step must not be committed
      // afterwards on top of the state the undo restored.
      history()
        ..begin(() => snapshot())
        ..commit(snapshot(count: 1));
      history()
        ..begin(() => snapshot(count: 1))
        ..undo(snapshot(count: 1))
        ..commit(snapshot(count: 5));

      expect(depth().canUndo, isFalse);
    });
  });

  group('how far back it goes', () {
    test('should keep the last fifty steps and no more', () {
      for (var i = 0; i < historyDepthLimit + 10; i++) {
        history()
          ..begin(() => snapshot(count: i))
          ..commit(snapshot(count: i + 1));
      }

      expect(history().undoDepth, historyDepthLimit);
    });

    test('should drop the oldest first', () {
      for (var i = 0; i < historyDepthLimit + 1; i++) {
        history()
          ..begin(() => snapshot(count: i))
          ..commit(snapshot(count: i + 1));
      }

      // The first step began at an empty document; after one step too many
      // that beginning is gone and the oldest left began at one object.
      var current = snapshot(count: historyDepthLimit + 1);
      EditorSnapshot? oldest;
      while (true) {
        final previous = history().undo(current);
        if (previous == null) break;
        oldest = previous;
        current = previous;
      }
      expect(oldest?.objects, hasLength(1));
    });
  });

  group('forgetting everything', () {
    test('should leave nowhere to go in either direction', () {
      history()
        ..begin(() => snapshot())
        ..commit(snapshot(count: 1));
      history().undo(snapshot(count: 1));

      history().clear();

      expect(depth().canUndo, isFalse);
      expect(depth().canRedo, isFalse);
      expect(history().undoDepth, 0);
      expect(history().redoDepth, 0);
    });
  });

  group('a page that was turned', () {
    test('should be a step of its own', () {
      history()
        ..begin(() => snapshot(rotations: [0, 0]))
        ..commit(snapshot(rotations: [90, 0]));

      expect(depth().canUndo, isTrue);
      expect(history().undo(snapshot(rotations: [90, 0]))?.pageRotations,
          [0, 0]);
    });
  });
}
