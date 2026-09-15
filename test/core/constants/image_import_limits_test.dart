import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/constants/image_import_limits.dart';

void main() {
  group('file size', () {
    test('should accept a file exactly at the limit', () {
      // The limit is the largest acceptable size, not the first rejected one.
      expect(
        ImageImportLimits.forByteCount(ImageImportLimits.maxFileSizeBytes),
        isNull,
      );
    });

    test('should refuse a file one byte over the limit', () {
      expect(
        ImageImportLimits.forByteCount(ImageImportLimits.maxFileSizeBytes + 1),
        ImageImportRejection.tooLarge,
      );
    });

    test('should accept an ordinary file', () {
      expect(ImageImportLimits.forByteCount(512 * 1024), isNull);
      expect(ImageImportLimits.forByteCount(0), isNull);
    });
  });

  group('dimensions', () {
    const limit = ImageImportLimits.maxPixelsPerSide;

    test('should accept an image exactly at the limit', () {
      expect(ImageImportLimits.forDimensions(limit, limit), isNull);
    });

    test('should refuse an image one pixel over on either side', () {
      expect(
        ImageImportLimits.forDimensions(limit + 1, limit),
        ImageImportRejection.tooManyPixels,
      );
      expect(
        ImageImportLimits.forDimensions(limit, limit + 1),
        ImageImportRejection.tooManyPixels,
      );
    });

    test('should accept a long thin image within the limit', () {
      // Only the sides are capped, not the total pixel count.
      expect(ImageImportLimits.forDimensions(limit, 1), isNull);
    });
  });

  group('what the user is shown', () {
    test('should describe the limits from the limits themselves', () {
      // Written into the message rather than repeated in 66 translations,
      // so the text cannot drift from the number that is enforced.
      expect(ImageImportLimits.fileSizeLabel, '100 MB');
      expect(ImageImportLimits.resolutionLabel, '4096 × 4096');
    });
  });
}
