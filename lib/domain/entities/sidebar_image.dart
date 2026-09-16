import 'dart:ui';

import 'package:equatable/equatable.dart';

/// Domain entity representing an image in the sidebar panel.
///
/// Immutable with value equality via Equatable.
class SidebarImage extends Equatable {
  /// Unique identifier (UUID).
  final String id;

  /// Full file system path to the image.
  final String filePath;

  /// File name extracted from path (for display).
  final String fileName;

  /// When the image was added to the sidebar.
  final DateTime addedAt;

  /// Order index for sorting (0-based).
  final int orderIndex;

  /// Original image width in pixels.
  final int width;

  /// Original image height in pixels.
  final int height;

  /// File size in bytes.
  final int fileSize;

  /// Optional user comment for the image.
  final String? comment;

  /// The size this image was last given on a page, in PDF points.
  ///
  /// Null until the reader resizes one. A fresh drop then arrives at that
  /// size instead of the default, which is what makes a stamp keep the size
  /// it was adjusted to. Only the size: an object's own rotation stays with
  /// that object.
  final Size? lastUsedSize;

  const SidebarImage({
    required this.id,
    required this.filePath,
    required this.fileName,
    required this.addedAt,
    required this.orderIndex,
    required this.width,
    required this.height,
    required this.fileSize,
    this.comment,
    this.lastUsedSize,
  });

  /// Aspect ratio (width / height), falling back to 1 for unusable dimensions.
  ///
  /// A row with a zero dimension would otherwise yield 0, infinity or NaN,
  /// which reaches `AspectRatio`, `Transform` and the PDF writer as an invalid
  /// size and trips an assertion or paints nothing.
  double get aspectRatio {
    final ratio = width / height;
    return ratio.isFinite && ratio > 0 ? ratio : 1.0;
  }

  /// Creates a copy with updated fields.
  ///
  /// Use [clearComment] to explicitly set comment to null.
  SidebarImage copyWith({
    String? id,
    String? filePath,
    String? fileName,
    DateTime? addedAt,
    int? orderIndex,
    int? width,
    int? height,
    int? fileSize,
    String? comment,
    bool clearComment = false,
    Size? lastUsedSize,
  }) {
    return SidebarImage(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      addedAt: addedAt ?? this.addedAt,
      orderIndex: orderIndex ?? this.orderIndex,
      width: width ?? this.width,
      height: height ?? this.height,
      fileSize: fileSize ?? this.fileSize,
      comment: clearComment ? null : (comment ?? this.comment),
      lastUsedSize: lastUsedSize ?? this.lastUsedSize,
    );
  }

  @override
  List<Object?> get props => [
        id,
        filePath,
        fileName,
        addedAt,
        orderIndex,
        width,
        height,
        fileSize,
        comment,
        lastUsedSize,
      ];

  @override
  String toString() {
    return 'SidebarImage(id: $id, fileName: $fileName, orderIndex: $orderIndex)';
  }
}
