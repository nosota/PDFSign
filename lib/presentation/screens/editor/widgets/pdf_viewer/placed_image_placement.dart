import 'dart:ui';

/// Geometry for putting a new object on a page.
///
/// Dropping from the sidebar and pasting must agree on how large a fresh
/// object is and how it is kept inside the page. Keeping the rules in one
/// place is what stops the two from drifting apart.
abstract final class PlacedImagePlacement {
  /// Share of the page width a freshly placed object occupies.
  static const defaultWidthRatio = 0.25;

  /// Hard ceiling on a placed object relative to the page.
  static const maxPageCoverage = 0.9;

  /// Offset each paste adds so a pasted object does not hide its original.
  static const cascadeStep = Offset(20, 20);

  /// Size for a freshly placed object: a quarter of the page width, keeping
  /// the source aspect ratio, never covering more than [maxPageCoverage].
  static Size defaultSizeFor(double aspectRatio, Size pageSize) {
    // A library row with a zero dimension would yield 0, infinity or NaN.
    // Fall back to a square rather than letting that reach the saved PDF.
    final ratio = aspectRatio.isFinite && aspectRatio > 0 ? aspectRatio : 1.0;

    final target = pageSize.width * defaultWidthRatio;
    var width = ratio > 1 ? target : target * ratio;
    var height = ratio > 1 ? target / ratio : target;

    final maxWidth = pageSize.width * maxPageCoverage;
    if (width > maxWidth) {
      width = maxWidth;
      height = width / ratio;
    }

    final maxHeight = pageSize.height * maxPageCoverage;
    if (height > maxHeight) {
      height = maxHeight;
      width = height * ratio;
    }

    return Size(width, height);
  }

  /// Shrinks [size] until it fits within [maxPageCoverage] of the page,
  /// keeping its aspect ratio. Returns [size] unchanged when it already fits.
  ///
  /// Needed when an object copied from a large page is pasted onto a small
  /// one: keeping its points verbatim would cover the whole page or hang off
  /// it.
  static Size fitToPage(Size size, Size pageSize) {
    if (size.width <= 0 || size.height <= 0) {
      return defaultSizeFor(1, pageSize);
    }

    final maxWidth = pageSize.width * maxPageCoverage;
    final maxHeight = pageSize.height * maxPageCoverage;
    if (size.width <= maxWidth && size.height <= maxHeight) {
      return size;
    }

    final scale = _min(maxWidth / size.width, maxHeight / size.height);
    return Size(size.width * scale, size.height * scale);
  }

  static double _min(double a, double b) => a < b ? a : b;

  /// Top-left position that centres [size] on [pointOnPage], kept on the page.
  static Offset centeredOn(Offset pointOnPage, Size size, Size pageSize) =>
      clampToPage(
        Offset(
          pointOnPage.dx - size.width / 2,
          pointOnPage.dy - size.height / 2,
        ),
        size,
        pageSize,
      );

  /// Top-left position that centres [size] on the page.
  static Offset centeredOnPage(Size size, Size pageSize) => centeredOn(
        Offset(pageSize.width / 2, pageSize.height / 2),
        size,
        pageSize,
      );

  /// Moves [position] the least distance needed to keep the object on the page.
  static Offset clampToPage(Offset position, Size size, Size pageSize) => Offset(
        _clamped(position.dx, pageSize.width - size.width),
        _clamped(position.dy, pageSize.height - size.height),
      );

  /// Clamps a coordinate so the object stays fully on the page.
  ///
  /// [maxValue] can only go negative if an object were larger than its page,
  /// which [defaultSizeFor] prevents; guarding anyway keeps a malformed
  /// document from producing an out-of-range position.
  static double _clamped(double value, double maxValue) {
    if (value < 0 || maxValue <= 0) {
      return 0;
    }
    return value > maxValue ? maxValue : value;
  }
}
