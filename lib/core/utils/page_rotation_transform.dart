import 'dart:math' as math;
import 'dart:ui';

/// Maps rectangles between a rotated page as the reader sees it and the
/// unrotated space the file is written in.
///
/// A PDF page carries `/Rotate`, and a viewer turns the page by that much
/// before showing it. Everything in the editor works in what the reader sees;
/// everything written into the file has to be expressed in the page's own
/// space. This is the only place that knows how to get from one to the other.
///
/// Rotations are degrees clockwise and must be 0, 90, 180 or 270. Rectangles
/// use a top-left origin with y growing downwards, in both spaces.
abstract final class PageRotationTransform {
  /// Whether [rotation] swaps the page's sides.
  static bool swapsSides(int rotation) => normalize(rotation) % 180 == 90;

  /// Brings any degree value into 0, 90, 180 or 270.
  ///
  /// A file can carry a negative or out-of-range `/Rotate`; the specification
  /// says multiples of 90, and readers normalize.
  static int normalize(int rotation) {
    final quarters = (rotation / 90).round();
    return ((quarters % 4) + 4) % 4 * 90;
  }

  /// The size a page of [mediaBox] occupies once turned by [rotation].
  static Size displaySize(Size mediaBox, int rotation) => swapsSides(rotation)
      ? Size(mediaBox.height, mediaBox.width)
      : mediaBox;

  /// Maps a rectangle from the displayed page into the file's own space.
  ///
  /// [mediaBox] is the page's unrotated size.
  static Rect toFileSpace(Rect displayed, Size mediaBox, int rotation) {
    final w = mediaBox.width;
    final h = mediaBox.height;
    return switch (normalize(rotation)) {
      90 => Rect.fromLTWH(
          displayed.top,
          h - displayed.left - displayed.width,
          displayed.height,
          displayed.width,
        ),
      180 => Rect.fromLTWH(
          w - displayed.left - displayed.width,
          h - displayed.top - displayed.height,
          displayed.width,
          displayed.height,
        ),
      270 => Rect.fromLTWH(
          w - displayed.top - displayed.height,
          displayed.left,
          displayed.height,
          displayed.width,
        ),
      _ => displayed,
    };
  }

  /// Maps a rectangle from the file's own space onto the displayed page.
  static Rect toDisplaySpace(Rect inFile, Size mediaBox, int rotation) {
    final w = mediaBox.width;
    final h = mediaBox.height;
    return switch (normalize(rotation)) {
      90 => Rect.fromLTWH(
          h - inFile.top - inFile.height,
          inFile.left,
          inFile.height,
          inFile.width,
        ),
      180 => Rect.fromLTWH(
          w - inFile.left - inFile.width,
          h - inFile.top - inFile.height,
          inFile.width,
          inFile.height,
        ),
      270 => Rect.fromLTWH(
          inFile.top,
          w - inFile.left - inFile.width,
          inFile.height,
          inFile.width,
        ),
      _ => inFile,
    };
  }

  /// Moves a rectangle along with the page when the page itself is turned.
  ///
  /// Both the rectangle and [pageSize] are in the page's current displayed
  /// space; the result is in the space the page has after the turn.
  static Rect turned(Rect rect, Size pageSize, int quarterTurns) {
    final turns = ((quarterTurns % 4) + 4) % 4;
    var result = rect;
    var size = pageSize;
    for (var i = 0; i < turns; i++) {
      result = Rect.fromLTWH(
        size.height - result.top - result.height,
        result.left,
        result.height,
        result.width,
      );
      size = Size(size.height, size.width);
    }
    return result;
  }

  /// An object's own angle, expressed in the file's space.
  ///
  /// The file's content is turned by [rotation] to produce what the reader
  /// sees, so an object that is to appear at [radians] must be written that
  /// much further back.
  static double angleToFileSpace(double radians, int rotation) =>
      radians - normalize(rotation) * math.pi / 180;

  /// An object's own angle after the page is turned by [quarterTurns].
  ///
  /// Brought back into a single turn, so that turning a page four times leaves
  /// the objects on it exactly as they were. Letting the angle accumulate
  /// would make a document that is visually unchanged compare as modified,
  /// and unsaved-change prompts would follow.
  static double angleTurned(double radians, int quarterTurns) {
    const fullTurn = 2 * math.pi;
    final turned = radians + quarterTurns * math.pi / 2;
    final wrapped = turned % fullTurn;
    return wrapped < 0 ? wrapped + fullTurn : wrapped;
  }
}
