import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  PlacedImages notifier() => container.read(placedImagesProvider.notifier);

  List<PlacedImage> objects() => container.read(placedImagesProvider);

  /// Places an object on [page] and returns its id.
  ///
  /// The order objects are added in is the order they are drawn in, from the
  /// back forwards, so the first one placed is the one underneath.
  String place({int page = 0}) => notifier()
      .addImage(
        imagePath: '/storage/stamp.png',
        pageIndex: page,
        position: const Offset(10, 10),
        size: const Size(40, 20),
      )
      .id;

  /// The ids of the objects on [page], from the back forwards.
  List<String> orderOn(int page) => [
        for (final image in objects())
          if (image.pageIndex == page) image.id,
      ];

  group('bringing an object forward', () {
    test('should put it in front of everything else on its page', () {
      final back = place();
      final middle = place();
      final front = place();

      notifier().bringToFront(back);

      expect(orderOn(0), [middle, front, back]);
    });

    test('should pass one object at a time', () {
      final back = place();
      final middle = place();
      final front = place();

      notifier().bringForward(back);

      expect(orderOn(0), [middle, back, front]);
    });

    test('should leave the frontmost object exactly where it is', () {
      place();
      final front = place();
      final before = objects();

      notifier()
        ..bringToFront(front)
        ..bringForward(front);

      // Identical rather than equal: a move that changes nothing must not
      // replace the list, or every no-op would land in the undo history.
      expect(identical(objects(), before), isTrue);
    });
  });

  group('sending an object back', () {
    test('should put it behind everything else on its page', () {
      final back = place();
      final middle = place();
      final front = place();

      notifier().sendToBack(front);

      expect(orderOn(0), [front, back, middle]);
    });

    test('should pass one object at a time', () {
      final back = place();
      final middle = place();
      final front = place();

      notifier().sendBackward(front);

      expect(orderOn(0), [back, front, middle]);
    });

    test('should leave the rearmost object exactly where it is', () {
      final back = place();
      place();
      final before = objects();

      notifier()
        ..sendToBack(back)
        ..sendBackward(back);

      expect(identical(objects(), before), isTrue);
    });
  });

  group('objects on other pages', () {
    test('should not move when a page is restacked', () {
      // The objects of all pages share one list, interleaved in the order they
      // were placed. Restacking must reach only the places its own page
      // occupies.
      final firstOnPageOne = place(page: 1);
      final back = place();
      final onPageTwo = place(page: 2);
      final front = place();
      final secondOnPageOne = place(page: 1);

      notifier().bringToFront(back);

      expect(orderOn(0), [front, back]);
      expect(orderOn(1), [firstOnPageOne, secondOnPageOne],
          reason: 'another page was restacked too');
      expect(orderOn(2), [onPageTwo]);
    });

    test('should not count as neighbours', () {
      // The object in front of this one is the one in front on *its page*,
      // whatever sits between them in the list.
      final back = place();
      place(page: 1);
      final front = place();

      notifier().bringForward(back);

      expect(orderOn(0), [front, back]);
    });
  });

  group('an object that is not there', () {
    test('should leave the list untouched', () {
      place();
      final before = objects();

      notifier()
        ..bringToFront('no-such-object')
        ..sendToBack('no-such-object')
        ..bringForward('no-such-object')
        ..sendBackward('no-such-object');

      expect(identical(objects(), before), isTrue);
    });
  });

  group('an object alone on its page', () {
    test('should have nowhere to go', () {
      final only = place();
      place(page: 1);
      final before = objects();

      notifier()
        ..bringToFront(only)
        ..sendToBack(only)
        ..bringForward(only)
        ..sendBackward(only);

      expect(identical(objects(), before), isTrue);
    });
  });
}
