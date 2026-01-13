import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_thumbnail_card.dart';

/// Data object passed during drag operation.
class DraggableSidebarImage {
  final String sourceImageId;
  final String imagePath;
  final int width;
  final int height;

  const DraggableSidebarImage({
    required this.sourceImageId,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  double get aspectRatio => width / height;

  factory DraggableSidebarImage.fromSidebarImage(SidebarImage image) {
    return DraggableSidebarImage(
      sourceImageId: image.id,
      imagePath: image.filePath,
      width: image.width,
      height: image.height,
    );
  }
}

/// Wrapper that makes ImageThumbnailCard draggable to the PDF viewer.
class DraggableImageCard extends ConsumerWidget {
  const DraggableImageCard({
    required this.image,
    required this.isSelected,
    super.key,
  });

  final SidebarImage image;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragData = DraggableSidebarImage.fromSidebarImage(image);

    return LongPressDraggable<DraggableSidebarImage>(
      data: dragData,
      delay: const Duration(milliseconds: 100),
      feedback: _buildDragFeedback(context),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: ImageThumbnailCard(
          image: image,
          isSelected: false,
        ),
      ),
      child: ImageThumbnailCard(
        image: image,
        isSelected: isSelected,
      ),
    );
  }

  Widget _buildDragFeedback(BuildContext context) {
    const maxSize = 150.0;
    final aspectRatio = image.aspectRatio;

    double width, height;
    if (aspectRatio > 1) {
      width = maxSize;
      height = maxSize / aspectRatio;
    } else {
      height = maxSize;
      width = maxSize * aspectRatio;
    }

    return Material(
      color: Colors.transparent,
      child: Image.file(
        File(image.filePath),
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
