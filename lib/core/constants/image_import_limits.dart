/// Why an image was refused on the way in.
enum ImageImportRejection {
  /// The file is bigger than [ImageImportLimits.maxFileSizeBytes].
  tooLarge,

  /// A side is longer than [ImageImportLimits.maxPixelsPerSide].
  tooManyPixels,
}

/// Limits on images entering a document or the image library.
///
/// The file-size limit is checked before the bytes are read, which is the
/// point of it: decoding a 200 MB image to find out it is too big would
/// already have cost the memory the limit exists to protect.
abstract final class ImageImportLimits {
  /// Largest image file accepted, in bytes.
  static const int maxFileSizeBytes = 100 * 1024 * 1024;

  /// Longest side accepted, in pixels.
  static const int maxPixelsPerSide = 4096;

  /// The size limit as shown to the user, e.g. `100 MB`.
  static String get fileSizeLabel => '${maxFileSizeBytes ~/ (1024 * 1024)} MB';

  /// The resolution limit as shown to the user, e.g. `4096 × 4096`.
  static String get resolutionLabel =>
      '$maxPixelsPerSide × $maxPixelsPerSide';

  /// Checks a file or payload size. Returns null when it is acceptable.
  static ImageImportRejection? forByteCount(int byteCount) =>
      byteCount > maxFileSizeBytes ? ImageImportRejection.tooLarge : null;

  /// Checks decoded dimensions. Returns null when they are acceptable.
  static ImageImportRejection? forDimensions(int width, int height) =>
      width > maxPixelsPerSide || height > maxPixelsPerSide
          ? ImageImportRejection.tooManyPixels
          : null;
}
