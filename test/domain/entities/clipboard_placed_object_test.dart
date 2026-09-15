import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';

void main() {
  const object = ClipboardPlacedObject(
    sourceImageId: 'source-1',
    imagePath: '/storage/abc.png',
    size: Size(120, 60),
    position: Offset(10, 20),
    rotation: 0.5,
  );

  group('a payload this app wrote', () {
    test('should survive a round trip unchanged', () {
      expect(ClipboardPlacedObject.fromJson(object.toJson()), object);
    });

    test('should keep a zero rotation without being told', () {
      const upright = ClipboardPlacedObject(
        sourceImageId: 'source-1',
        imagePath: '/storage/abc.png',
        size: Size(1, 1),
        position: Offset.zero,
      );
      expect(ClipboardPlacedObject.fromJson(upright.toJson()), upright);
    });
  });

  group('anything else on the clipboard', () {
    // The pasteboard is open to every application, so this is untrusted
    // input: each of these must be refused rather than throw or produce a
    // half-built object.
    test('should be refused when it is not a map', () {
      expect(ClipboardPlacedObject.fromJson('hello'), isNull);
      expect(ClipboardPlacedObject.fromJson(42), isNull);
      expect(ClipboardPlacedObject.fromJson(null), isNull);
      expect(ClipboardPlacedObject.fromJson(<Object>[]), isNull);
    });

    test('should be refused when the version does not match', () {
      final future = object.toJson()..['version'] = 99;
      expect(ClipboardPlacedObject.fromJson(future), isNull);

      final versionless = object.toJson()..remove('version');
      expect(ClipboardPlacedObject.fromJson(versionless), isNull);
    });

    test('should be refused when an identifier is missing or empty', () {
      for (final key in ['sourceImageId', 'imagePath']) {
        expect(
          ClipboardPlacedObject.fromJson(object.toJson()..remove(key)),
          isNull,
          reason: 'missing $key',
        );
        expect(
          ClipboardPlacedObject.fromJson(object.toJson()..[key] = ''),
          isNull,
          reason: 'empty $key',
        );
        expect(
          ClipboardPlacedObject.fromJson(object.toJson()..[key] = 7),
          isNull,
          reason: '$key of the wrong type',
        );
      }
    });

    test('should be refused when a dimension is not a positive number', () {
      for (final key in ['width', 'height']) {
        for (final value in [0, -5, double.nan, double.infinity, 'wide']) {
          expect(
            ClipboardPlacedObject.fromJson(object.toJson()..[key] = value),
            isNull,
            reason: '$key = $value',
          );
        }
      }
    });

    test('should be refused when a coordinate is not finite', () {
      for (final key in ['x', 'y', 'rotation']) {
        for (final value in [double.nan, double.infinity, 'over there']) {
          expect(
            ClipboardPlacedObject.fromJson(object.toJson()..[key] = value),
            isNull,
            reason: '$key = $value',
          );
        }
      }
    });

    test('should accept a negative coordinate, which is merely off-page', () {
      final offPage = object.toJson()
        ..['x'] = -30.0
        ..['y'] = -40.0;
      expect(
        ClipboardPlacedObject.fromJson(offPage)?.position,
        const Offset(-30, -40),
      );
    });

    test('should accept whole numbers where doubles are expected', () {
      // jsonDecode hands back int for a value written without a fraction.
      final integral = object.toJson()
        ..['width'] = 120
        ..['x'] = 10
        ..['rotation'] = 0;
      final decoded = ClipboardPlacedObject.fromJson(integral);
      expect(decoded?.size.width, 120.0);
      expect(decoded?.position.dx, 10.0);
      expect(decoded?.rotation, 0.0);
    });
  });
}
