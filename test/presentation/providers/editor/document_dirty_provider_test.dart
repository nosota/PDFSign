import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  PlacedImages placed() => container.read(placedImagesProvider.notifier);
  bool isDirty() => container.read(documentDirtyProvider);

  /// Records the current objects as written, the way a successful save does.
  void save() {
    container
        .read(savedPlacedImagesProvider.notifier)
        .markSaved(container.read(placedImagesProvider));
  }

  PlacedImage addObject() => placed().addImage(
        sourceImageId: 'img-1',
        imagePath: '/tmp/stamp.png',
        pageIndex: 0,
        position: const Offset(100, 100),
        size: const Size(150, 100),
      );

  group('a document nobody has touched', () {
    test('should be clean when it has no objects', () {
      expect(isDirty(), isFalse);
    });
  });

  group('changes to the set of objects', () {
    test('should be dirty after an object is added', () {
      addObject();
      expect(isDirty(), isTrue);
    });

    test('should be clean again after the only new object is removed', () {
      // Preserved behaviour: adding and immediately removing leaves the
      // document exactly as it was, so it must not prompt to save.
      final image = addObject();
      expect(isDirty(), isTrue);

      placed().removeImage(image.id);

      expect(isDirty(), isFalse);
    });

    test('should be clean after saving', () {
      addObject();
      save();
      expect(isDirty(), isFalse);
    });
  });

  group('geometry changes after a save', () {
    test('should be dirty after an object is moved', () {
      // The defect this policy replaced: a move left the document reporting
      // clean, so closing it discarded the move without asking, and the Save
      // menu item stayed disabled.
      final image = addObject();
      save();
      expect(isDirty(), isFalse);

      placed().moveImage(image.id, const Offset(120, 140));

      expect(isDirty(), isTrue);
    });

    test('should be dirty after an object is resized', () {
      final image = addObject();
      save();

      placed().resizeImage(image.id, const Size(200, 120));

      expect(isDirty(), isTrue);
    });

    test('should be dirty after an object is rotated', () {
      final image = addObject();
      save();

      placed().rotateImage(image.id, 0.3);

      expect(isDirty(), isTrue);
    });

    test('should be clean again when a move is undone by hand', () {
      final image = addObject();
      save();

      placed().moveImage(image.id, const Offset(120, 140));
      expect(isDirty(), isTrue);

      placed().moveImage(image.id, const Offset(100, 100));

      expect(isDirty(), isFalse, reason: 'back to the written geometry');
    });
  });

  group('removing an object that was already written', () {
    test('should be dirty, not clean', () {
      // The second hole in the old policy: deleting the last object always
      // reported clean, even when that object was already embedded in the
      // file, so the deletion was silently dropped on close.
      final image = addObject();
      save();
      expect(isDirty(), isFalse);

      placed().removeImage(image.id);

      expect(isDirty(), isTrue);
    });
  });

  group('saving under a new name', () {
    test('should be clean once the objects and the baseline are cleared', () {
      addObject();
      save();
      addObject();
      expect(isDirty(), isTrue);

      // Save As embeds the objects and starts the new file from a clean page.
      placed().clear();
      container.read(savedPlacedImagesProvider.notifier).reset();

      expect(isDirty(), isFalse);
    });
  });
}
