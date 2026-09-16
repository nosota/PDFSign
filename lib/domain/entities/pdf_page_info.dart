import 'package:equatable/equatable.dart';

/// Information about a single PDF page.
///
/// [width] and [height] are the page **as displayed**: a page the file marks
/// as rotated a quarter turn reports its sides the way the reader sees them,
/// so layout, drop placement and pasting need to know nothing about rotation.
/// The unrotated media box is recovered from [rotation] where it is needed —
/// only the save path, which draws in the file's own space.
class PdfPageInfo extends Equatable {
  const PdfPageInfo({
    required this.pageNumber,
    required this.width,
    required this.height,
    this.rotation = 0,
    this.fileRotation = 0,
  });

  /// 1-based page number.
  final int pageNumber;

  /// Page width in points, as displayed.
  final double width;

  /// Page height in points, as displayed.
  final double height;

  /// How the page is turned right now, in degrees clockwise: 0, 90, 180, 270.
  ///
  /// Starts equal to [fileRotation] and changes as the reader rotates the
  /// page. The difference between the two is what has not been saved yet.
  final int rotation;

  /// The page's `/Rotate` in the file on disk, in degrees clockwise.
  ///
  /// Kept apart from [rotation] because the renderer works from the file and
  /// therefore already applies this much: only the difference has to be
  /// applied to the rendered image.
  final int fileRotation;

  /// Aspect ratio (width / height).
  double get aspectRatio => width / height;

  /// Quarter turns the rendered page still needs, 0 to 3 clockwise.
  int get pendingQuarterTurns => (((rotation - fileRotation) ~/ 90) % 4 + 4) % 4;

  /// Whether the page is turned differently than the file says.
  bool get isRotatedFromFile => rotation != fileRotation;

  /// The same page turned by [quarterTurns] more quarter turns clockwise.
  ///
  /// Negative values turn anticlockwise. The sides swap for an odd number of
  /// turns, which is what makes the page column re-lay itself out.
  PdfPageInfo rotated(int quarterTurns) {
    final normalized = ((quarterTurns % 4) + 4) % 4;
    if (normalized == 0) {
      return this;
    }
    final swapsSides = normalized.isOdd;
    return PdfPageInfo(
      pageNumber: pageNumber,
      width: swapsSides ? height : width,
      height: swapsSides ? width : height,
      rotation: (rotation + normalized * 90) % 360,
      fileRotation: fileRotation,
    );
  }

  /// Creates a copy with modified fields.
  PdfPageInfo copyWith({
    int? pageNumber,
    double? width,
    double? height,
    int? rotation,
    int? fileRotation,
  }) {
    return PdfPageInfo(
      pageNumber: pageNumber ?? this.pageNumber,
      width: width ?? this.width,
      height: height ?? this.height,
      rotation: rotation ?? this.rotation,
      fileRotation: fileRotation ?? this.fileRotation,
    );
  }

  @override
  List<Object?> get props => [
        pageNumber,
        width,
        height,
        rotation,
        fileRotation,
      ];
}
