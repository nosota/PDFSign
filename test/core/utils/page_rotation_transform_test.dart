import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/utils/page_rotation_transform.dart';

void main() {
  // A4 in points, the page's own unrotated size.
  const mediaBox = Size(595, 842);

  group('normalizing what a file may contain', () {
    test('should keep the four legal values', () {
      for (final value in [0, 90, 180, 270]) {
        expect(PageRotationTransform.normalize(value), value);
      }
    });

    test('should bring anything else into range', () {
      expect(PageRotationTransform.normalize(360), 0);
      expect(PageRotationTransform.normalize(450), 90);
      expect(PageRotationTransform.normalize(-90), 270);
      expect(PageRotationTransform.normalize(-450), 270);
      // Not a multiple of 90 — the specification says it should be; round to
      // the nearest rather than refuse to show the page.
      expect(PageRotationTransform.normalize(89), 90);
    });

    test('should know which rotations swap the sides', () {
      expect(PageRotationTransform.swapsSides(0), isFalse);
      expect(PageRotationTransform.swapsSides(90), isTrue);
      expect(PageRotationTransform.swapsSides(180), isFalse);
      expect(PageRotationTransform.swapsSides(270), isTrue);
    });

    test('should report the displayed size', () {
      expect(PageRotationTransform.displaySize(mediaBox, 0), mediaBox);
      expect(
        PageRotationTransform.displaySize(mediaBox, 90),
        const Size(842, 595),
      );
      expect(PageRotationTransform.displaySize(mediaBox, 180), mediaBox);
      expect(
        PageRotationTransform.displaySize(mediaBox, 270),
        const Size(842, 595),
      );
    });
  });

  group('display space to file space', () {
    // Measured, not derived: a rectangle written at the file's origin
    // (0, 0, 120, 60) on a page marked /Rotate 90 renders at the top right of
    // the displayed page, standing on end. Everything else follows from that
    // one observation.
    test('should match what a viewer actually draws at 90 degrees', () {
      const inFile = Rect.fromLTWH(0, 0, 120, 60);
      final displayed =
          PageRotationTransform.toDisplaySpace(inFile, mediaBox, 90);

      expect(displayed, const Rect.fromLTWH(782, 0, 60, 120));
      // Flush against the right edge of the displayed page, which is 842 wide.
      expect(displayed.right, 842);
      expect(displayed.top, 0);
    });

    test('should be reversible at every rotation', () {
      const displayed = Rect.fromLTWH(37, 111, 120, 60);
      for (final rotation in [0, 90, 180, 270]) {
        final box = PageRotationTransform.displaySize(mediaBox, rotation);
        // Keep the rectangle inside the displayed page so the round trip is
        // testing the mapping and not clamping.
        final inside = Rect.fromLTWH(
          displayed.left.clamp(0, box.width - displayed.width),
          displayed.top.clamp(0, box.height - displayed.height),
          displayed.width,
          displayed.height,
        );
        final inFile =
            PageRotationTransform.toFileSpace(inside, mediaBox, rotation);
        expect(
          PageRotationTransform.toDisplaySpace(inFile, mediaBox, rotation),
          inside,
          reason: 'rotation $rotation',
        );
      }
    });

    test('should leave an unrotated page alone', () {
      const rect = Rect.fromLTWH(10, 20, 30, 40);
      expect(PageRotationTransform.toFileSpace(rect, mediaBox, 0), rect);
      expect(PageRotationTransform.toDisplaySpace(rect, mediaBox, 0), rect);
    });

    test('should keep a rectangle on the page at every rotation', () {
      // The top-left corner of the displayed page must land inside the file's
      // page whichever way it is turned.
      const corner = Rect.fromLTWH(0, 0, 50, 25);
      for (final rotation in [0, 90, 180, 270]) {
        final inFile =
            PageRotationTransform.toFileSpace(corner, mediaBox, rotation);
        expect(inFile.left, greaterThanOrEqualTo(0), reason: '$rotation');
        expect(inFile.top, greaterThanOrEqualTo(0), reason: '$rotation');
        expect(inFile.right, lessThanOrEqualTo(mediaBox.width),
            reason: '$rotation');
        expect(inFile.bottom, lessThanOrEqualTo(mediaBox.height),
            reason: '$rotation');
      }
    });

    test('should turn the sides over for a quarter turn', () {
      const wide = Rect.fromLTWH(10, 20, 100, 40);
      final inFile = PageRotationTransform.toFileSpace(wide, mediaBox, 90);
      expect(inFile.width, 40);
      expect(inFile.height, 100);
    });
  });

  group('turning the page itself', () {
    const page = Size(595, 842);

    test('should send the top-left corner to the top-right', () {
      // What the reader sees: turning clockwise carries the corner round.
      const corner = Rect.fromLTWH(0, 0, 50, 25);
      final turned = PageRotationTransform.turned(corner, page, 1);

      expect(turned, const Rect.fromLTWH(817, 0, 25, 50));
      expect(turned.right, 842, reason: 'flush against the new right edge');
    });

    test('should come back after four turns', () {
      const rect = Rect.fromLTWH(37, 111, 120, 60);
      var result = rect;
      var size = page;
      for (var i = 0; i < 4; i++) {
        result = PageRotationTransform.turned(result, size, 1);
        size = Size(size.height, size.width);
      }
      expect(result, rect);
    });

    test('should treat three clockwise turns as one anticlockwise', () {
      const rect = Rect.fromLTWH(37, 111, 120, 60);
      var clockwise = rect;
      var size = page;
      for (var i = 0; i < 3; i++) {
        clockwise = PageRotationTransform.turned(clockwise, size, 1);
        size = Size(size.height, size.width);
      }
      expect(PageRotationTransform.turned(rect, page, -1), clockwise);
    });

    test('should do nothing for no turns', () {
      const rect = Rect.fromLTWH(37, 111, 120, 60);
      expect(PageRotationTransform.turned(rect, page, 0), rect);
      expect(PageRotationTransform.turned(rect, page, 4), rect);
    });
  });

  group('an object of its own', () {
    test('should be written back by as much as the page is turned', () {
      expect(PageRotationTransform.angleToFileSpace(0, 0), 0);
      expect(
        PageRotationTransform.angleToFileSpace(0, 90),
        closeTo(-math.pi / 2, 1e-9),
      );
      expect(
        PageRotationTransform.angleToFileSpace(math.pi / 2, 90),
        closeTo(0, 1e-9),
      );
    });

    test('should follow the page when the page turns', () {
      expect(
        PageRotationTransform.angleTurned(0, 1),
        closeTo(math.pi / 2, 1e-9),
      );
      expect(
        PageRotationTransform.angleTurned(math.pi / 2, -1),
        closeTo(0, 1e-9),
      );
    });

    test('should not accumulate over a full circle', () {
      // Four turns must leave the object exactly as it was, or a document
      // nobody changed would compare as modified.
      expect(PageRotationTransform.angleTurned(0, 4), 0);
      expect(PageRotationTransform.angleTurned(math.pi, 4), closeTo(math.pi, 1e-9));
    });

    test('should come back into a single turn from below zero', () {
      expect(
        PageRotationTransform.angleTurned(0, -1),
        closeTo(3 * math.pi / 2, 1e-9),
      );
    });
  });
}
