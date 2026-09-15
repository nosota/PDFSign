import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/placed_image_placement.dart';

void main() {
  const a4 = Size(595, 842);

  group('size for a fresh object', () {
    test('should be a quarter of the page width for a wide image', () {
      final size = PlacedImagePlacement.defaultSizeFor(2, a4);
      expect(size.width, closeTo(595 * 0.25, 0.001));
      expect(size.height, closeTo(595 * 0.25 / 2, 0.001));
    });

    test('should keep a tall image within the page', () {
      final size = PlacedImagePlacement.defaultSizeFor(0.05, a4);
      expect(size.height, lessThanOrEqualTo(842 * 0.9 + 0.001));
      expect(size.width / size.height, closeTo(0.05, 0.001));
    });

    test('should fall back to a square for an unusable aspect ratio', () {
      for (final ratio in [0.0, -1.0, double.nan, double.infinity]) {
        final size = PlacedImagePlacement.defaultSizeFor(ratio, a4);
        expect(size.width, closeTo(size.height, 0.001), reason: '$ratio');
        expect(size.width, greaterThan(0), reason: '$ratio');
      }
    });
  });

  group('an object arriving from elsewhere', () {
    test('should keep its size when it already fits', () {
      const size = Size(100, 50);
      expect(PlacedImagePlacement.fitToPage(size, a4), size);
    });

    test('should shrink to fit a smaller page, keeping its shape', () {
      // Copied from A4, pasted onto a small page.
      const small = Size(200, 200);
      final fitted = PlacedImagePlacement.fitToPage(const Size(400, 200), small);

      expect(fitted.width, lessThanOrEqualTo(200 * 0.9 + 0.001));
      expect(fitted.height, lessThanOrEqualTo(200 * 0.9 + 0.001));
      expect(fitted.width / fitted.height, closeTo(2, 0.001));
    });

    test('should be given a sane size when it has none', () {
      final fitted = PlacedImagePlacement.fitToPage(Size.zero, a4);
      expect(fitted.width, greaterThan(0));
      expect(fitted.height, greaterThan(0));
    });
  });

  group('keeping an object on the page', () {
    const size = Size(100, 50);

    test('should leave a position that is already inside alone', () {
      expect(
        PlacedImagePlacement.clampToPage(const Offset(20, 30), size, a4),
        const Offset(20, 30),
      );
    });

    test('should pull a negative position back to the edge', () {
      expect(
        PlacedImagePlacement.clampToPage(const Offset(-40, -10), size, a4),
        Offset.zero,
      );
    });

    test('should stop the object at the far edge', () {
      final clamped =
          PlacedImagePlacement.clampToPage(const Offset(900, 900), size, a4);
      expect(clamped.dx, 595 - 100);
      expect(clamped.dy, 842 - 50);
    });

    test('should park an oversized object at the origin', () {
      // Only reachable for a malformed document; must not produce a negative
      // coordinate.
      final clamped = PlacedImagePlacement.clampToPage(
        const Offset(10, 10),
        const Size(900, 900),
        a4,
      );
      expect(clamped, Offset.zero);
    });
  });

  group('centring', () {
    const size = Size(100, 50);

    test('should put the middle of the object on the point', () {
      final position =
          PlacedImagePlacement.centeredOn(const Offset(300, 400), size, a4);
      expect(position, const Offset(250, 375));
    });

    test('should centre on the page when asked for no particular point', () {
      final position = PlacedImagePlacement.centeredOnPage(size, a4);
      expect(position.dx + size.width / 2, closeTo(595 / 2, 0.001));
      expect(position.dy + size.height / 2, closeTo(842 / 2, 0.001));
    });

    test('should still land on the page for a point off its edge', () {
      final position =
          PlacedImagePlacement.centeredOn(const Offset(-50, 900), size, a4);
      expect(position.dx, 0);
      expect(position.dy, 842 - 50);
    });
  });
}
