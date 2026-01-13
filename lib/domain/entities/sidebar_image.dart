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

  const SidebarImage({
    required this.id,
    required this.filePath,
    required this.fileName,
    required this.addedAt,
    required this.orderIndex,
    required this.width,
    required this.height,
    required this.fileSize,
  });

  /// Aspect ratio (width / height).
  double get aspectRatio => width / height;

  /// Creates a copy with updated fields.
  SidebarImage copyWith({
    String? id,
    String? filePath,
    String? fileName,
    DateTime? addedAt,
    int? orderIndex,
    int? width,
    int? height,
    int? fileSize,
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
      ];

  @override
  String toString() {
    return 'SidebarImage(id: $id, fileName: $fileName, orderIndex: $orderIndex)';
  }
}
