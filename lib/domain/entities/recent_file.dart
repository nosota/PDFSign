import 'package:equatable/equatable.dart';

/// Entity representing a recently opened PDF file
class RecentFile extends Equatable {
  /// Absolute file path
  final String path;

  /// Display file name
  final String fileName;

  /// When the file was last opened
  final DateTime lastOpened;

  /// Number of pages in the PDF
  final int pageCount;

  /// Whether the PDF is password-protected
  final bool isPasswordProtected;

  const RecentFile({
    required this.path,
    required this.fileName,
    required this.lastOpened,
    required this.pageCount,
    required this.isPasswordProtected,
  });

  @override
  List<Object?> get props => [
        path,
        fileName,
        lastOpened,
        pageCount,
        isPasswordProtected,
      ];

  /// Create a copy with updated fields
  RecentFile copyWith({
    String? path,
    String? fileName,
    DateTime? lastOpened,
    int? pageCount,
    bool? isPasswordProtected,
  }) {
    return RecentFile(
      path: path ?? this.path,
      fileName: fileName ?? this.fileName,
      lastOpened: lastOpened ?? this.lastOpened,
      pageCount: pageCount ?? this.pageCount,
      isPasswordProtected: isPasswordProtected ?? this.isPasswordProtected,
    );
  }

  /// Get a human-readable time ago string
  String getTimeAgoString() {
    final now = DateTime.now();
    final difference = now.difference(lastOpened);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'just now';
    }
  }
}
