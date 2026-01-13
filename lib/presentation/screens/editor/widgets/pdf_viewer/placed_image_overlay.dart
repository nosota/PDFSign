import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';

/// Selection handle constants.
class SelectionHandleConstants {
  static const double cornerHandleSize = 12.0;
  static const double sideHandleWidth = 12.0;
  static const double sideHandleHeight = 8.0;
  static const double handleBorderWidth = 2.0;
  static const Color handleFillColor = Colors.white;
  static const Color handleBorderColor = Color(0xFF0066FF);
  static const Color selectionBorderColor = Color(0xFF0066FF);
  static const double selectionBorderWidth = 2.0;
}

/// Overlay widget that renders placed images on a single PDF page.
///
/// This is rendered for each page that has placed images.
class PlacedImageOverlay extends ConsumerWidget {
  const PlacedImageOverlay({
    required this.pageIndex,
    required this.scale,
    super.key,
  });

  final int pageIndex;
  final double scale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allImages = ref.watch(placedImagesProvider);
    final selectedId = ref.watch(editorSelectionProvider);

    // Filter images for this page
    final pageImages =
        allImages.where((img) => img.pageIndex == pageIndex).toList();

    if (pageImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (final image in pageImages)
          _PlacedImageWidget(
            key: ValueKey(image.id),
            image: image,
            scale: scale,
            isSelected: image.id == selectedId,
          ),
      ],
    );
  }
}

/// Individual placed image with selection handles.
class _PlacedImageWidget extends ConsumerStatefulWidget {
  const _PlacedImageWidget({
    required this.image,
    required this.scale,
    required this.isSelected,
    super.key,
  });

  final PlacedImage image;
  final double scale;
  final bool isSelected;

  @override
  ConsumerState<_PlacedImageWidget> createState() => _PlacedImageWidgetState();
}

class _PlacedImageWidgetState extends ConsumerState<_PlacedImageWidget> {
  bool _isHovered = false;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final image = widget.image;
    final scale = widget.scale;

    // Calculate scaled position and size
    final scaledLeft = image.position.dx * scale;
    final scaledTop = image.position.dy * scale;
    final scaledWidth = image.size.width * scale;
    final scaledHeight = image.size.height * scale;

    return Positioned(
      left: scaledLeft,
      top: scaledTop,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: _isDragging
            ? SystemMouseCursors.grabbing
            : (_isHovered ? SystemMouseCursors.grab : SystemMouseCursors.basic),
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: _handleTap,
          onPanStart: _handlePanStart,
          onPanUpdate: _handlePanUpdate,
          onPanEnd: _handlePanEnd,
          child: Transform.rotate(
            angle: image.rotation,
            child: SizedBox(
              width: scaledWidth,
              height: scaledHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // The actual image
                  Positioned.fill(
                    child: Image.file(
                      File(image.imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),

                  // Selection box and handles
                  if (widget.isSelected || _isHovered)
                    _SelectionOverlay(
                      width: scaledWidth,
                      height: scaledHeight,
                      isSelected: widget.isSelected,
                      onCornerDrag: _handleCornerDrag,
                      onSideDrag: _handleSideDrag,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    ref.read(editorSelectionProvider.notifier).select(widget.image.id);
  }

  void _handlePanStart(DragStartDetails details) {
    setState(() => _isDragging = true);
    // Select the image when starting to drag
    ref.read(editorSelectionProvider.notifier).select(widget.image.id);
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    // Convert delta from screen to PDF coordinates
    final delta = details.delta / widget.scale;
    final newPosition = widget.image.position + delta;

    // Update position (clamping will be done when saving)
    ref.read(placedImagesProvider.notifier).moveImage(
          widget.image.id,
          newPosition,
        );
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() => _isDragging = false);
  }

  void _handleCornerDrag(String corner, Offset delta, Offset localPosition) {
    // Convert delta from screen to PDF coordinates
    final scaledDelta = delta / widget.scale;

    // Get image center and corner positions to determine resize vs rotate
    final image = widget.image;
    final center = image.center;
    final cornerPosition = _getCornerPosition(corner, image);

    // Vector from center to corner (before drag)
    final centerToCorner = cornerPosition - center;

    // Determine if this is resize (radial) or rotate (tangential) based on drag direction
    // Project delta onto radial and tangential directions
    final radialDir = centerToCorner.direction;
    final tangentialDir = radialDir + math.pi / 2;

    final cosRadial = math.cos(radialDir);
    final sinRadial = math.sin(radialDir);
    final cosTangential = math.cos(tangentialDir);
    final sinTangential = math.sin(tangentialDir);

    final radialComponent = scaledDelta.dx * cosRadial + scaledDelta.dy * sinRadial;
    final tangentialComponent =
        scaledDelta.dx * cosTangential + scaledDelta.dy * sinTangential;

    // If tangential movement is dominant, rotate
    // If radial movement is dominant, resize
    if (tangentialComponent.abs() > radialComponent.abs() * 1.5) {
      // Rotate - calculate angle change
      final oldAngle = (cornerPosition - center).direction;
      final newCornerPosition = cornerPosition + scaledDelta;
      final newAngle = (newCornerPosition - center).direction;
      final angleDelta = newAngle - oldAngle;

      ref.read(placedImagesProvider.notifier).rotateImage(
            image.id,
            image.rotation + angleDelta,
          );
    } else {
      // Resize - scale proportionally
      _handleProportionalResize(corner, scaledDelta);
    }
  }

  Offset _getCornerPosition(String corner, PlacedImage image) {
    switch (corner) {
      case 'topLeft':
        return image.position;
      case 'topRight':
        return Offset(image.position.dx + image.size.width, image.position.dy);
      case 'bottomLeft':
        return Offset(image.position.dx, image.position.dy + image.size.height);
      case 'bottomRight':
        return Offset(
          image.position.dx + image.size.width,
          image.position.dy + image.size.height,
        );
      default:
        return image.center;
    }
  }

  void _handleProportionalResize(String corner, Offset delta) {
    final image = widget.image;
    var newWidth = image.size.width;
    var newHeight = image.size.height;
    var newX = image.position.dx;
    var newY = image.position.dy;

    // Minimum size constraint
    const minSize = 20.0;

    // Calculate scale based on the corner being dragged
    switch (corner) {
      case 'topLeft':
        newWidth = (image.size.width - delta.dx).clamp(minSize, double.infinity);
        final scale = newWidth / image.size.width;
        newHeight = image.size.height * scale;
        newX = image.position.dx + (image.size.width - newWidth);
        newY = image.position.dy + (image.size.height - newHeight);
        break;
      case 'topRight':
        newWidth = (image.size.width + delta.dx).clamp(minSize, double.infinity);
        final scale = newWidth / image.size.width;
        newHeight = image.size.height * scale;
        newY = image.position.dy + (image.size.height - newHeight);
        break;
      case 'bottomLeft':
        newWidth = (image.size.width - delta.dx).clamp(minSize, double.infinity);
        final scale = newWidth / image.size.width;
        newHeight = image.size.height * scale;
        newX = image.position.dx + (image.size.width - newWidth);
        break;
      case 'bottomRight':
        newWidth = (image.size.width + delta.dx).clamp(minSize, double.infinity);
        final scale = newWidth / image.size.width;
        newHeight = image.size.height * scale;
        break;
    }

    ref.read(placedImagesProvider.notifier).transformImage(
          image.id,
          position: Offset(newX, newY),
          size: Size(newWidth, newHeight),
        );
  }

  void _handleSideDrag(String side, Offset delta) {
    // Convert delta from screen to PDF coordinates
    final scaledDelta = delta / widget.scale;
    final image = widget.image;

    var newWidth = image.size.width;
    var newHeight = image.size.height;
    var newX = image.position.dx;
    var newY = image.position.dy;

    // Minimum size constraint
    const minSize = 20.0;

    switch (side) {
      case 'top':
        final newH = (image.size.height - scaledDelta.dy).clamp(minSize, double.infinity);
        newY = image.position.dy + (image.size.height - newH);
        newHeight = newH;
        break;
      case 'bottom':
        newHeight = (image.size.height + scaledDelta.dy).clamp(minSize, double.infinity);
        break;
      case 'left':
        final newW = (image.size.width - scaledDelta.dx).clamp(minSize, double.infinity);
        newX = image.position.dx + (image.size.width - newW);
        newWidth = newW;
        break;
      case 'right':
        newWidth = (image.size.width + scaledDelta.dx).clamp(minSize, double.infinity);
        break;
    }

    ref.read(placedImagesProvider.notifier).transformImage(
          image.id,
          position: Offset(newX, newY),
          size: Size(newWidth, newHeight),
        );
  }
}

/// Selection overlay with border and handles.
class _SelectionOverlay extends StatelessWidget {
  const _SelectionOverlay({
    required this.width,
    required this.height,
    required this.isSelected,
    required this.onCornerDrag,
    required this.onSideDrag,
  });

  final double width;
  final double height;
  final bool isSelected;
  final void Function(String corner, Offset delta, Offset localPosition) onCornerDrag;
  final void Function(String side, Offset delta) onSideDrag;

  @override
  Widget build(BuildContext context) {
    final handleSize = SelectionHandleConstants.cornerHandleSize;
    final halfHandle = handleSize / 2;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Selection border
        if (isSelected)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: SelectionHandleConstants.selectionBorderColor,
                  width: SelectionHandleConstants.selectionBorderWidth,
                ),
              ),
            ),
          ),

        // Corner handles (only when selected)
        if (isSelected) ...[
          // Top-left corner
          Positioned(
            left: -halfHandle,
            top: -halfHandle,
            child: _CornerHandle(
              corner: 'topLeft',
              onDrag: onCornerDrag,
            ),
          ),
          // Top-right corner
          Positioned(
            right: -halfHandle,
            top: -halfHandle,
            child: _CornerHandle(
              corner: 'topRight',
              onDrag: onCornerDrag,
            ),
          ),
          // Bottom-left corner
          Positioned(
            left: -halfHandle,
            bottom: -halfHandle,
            child: _CornerHandle(
              corner: 'bottomLeft',
              onDrag: onCornerDrag,
            ),
          ),
          // Bottom-right corner
          Positioned(
            right: -halfHandle,
            bottom: -halfHandle,
            child: _CornerHandle(
              corner: 'bottomRight',
              onDrag: onCornerDrag,
            ),
          ),

          // Side handles
          // Top side
          Positioned(
            left: (width - SelectionHandleConstants.sideHandleWidth) / 2,
            top: -SelectionHandleConstants.sideHandleHeight / 2,
            child: _SideHandle(
              side: 'top',
              onDrag: onSideDrag,
            ),
          ),
          // Bottom side
          Positioned(
            left: (width - SelectionHandleConstants.sideHandleWidth) / 2,
            bottom: -SelectionHandleConstants.sideHandleHeight / 2,
            child: _SideHandle(
              side: 'bottom',
              onDrag: onSideDrag,
            ),
          ),
          // Left side
          Positioned(
            left: -SelectionHandleConstants.sideHandleWidth / 2,
            top: (height - SelectionHandleConstants.sideHandleHeight) / 2,
            child: _SideHandle(
              side: 'left',
              onDrag: onSideDrag,
              isVertical: true,
            ),
          ),
          // Right side
          Positioned(
            right: -SelectionHandleConstants.sideHandleWidth / 2,
            top: (height - SelectionHandleConstants.sideHandleHeight) / 2,
            child: _SideHandle(
              side: 'right',
              onDrag: onSideDrag,
              isVertical: true,
            ),
          ),
        ],
      ],
    );
  }
}

/// Corner handle widget (square, for resize/rotate).
class _CornerHandle extends StatelessWidget {
  const _CornerHandle({
    required this.corner,
    required this.onDrag,
  });

  final String corner;
  final void Function(String corner, Offset delta, Offset localPosition) onDrag;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _getCursor(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => onDrag(corner, details.delta, details.localPosition),
        child: Container(
          width: SelectionHandleConstants.cornerHandleSize,
          height: SelectionHandleConstants.cornerHandleSize,
          decoration: BoxDecoration(
            color: SelectionHandleConstants.handleFillColor,
            border: Border.all(
              color: SelectionHandleConstants.handleBorderColor,
              width: SelectionHandleConstants.handleBorderWidth,
            ),
          ),
        ),
      ),
    );
  }

  MouseCursor _getCursor() {
    switch (corner) {
      case 'topLeft':
      case 'bottomRight':
        return SystemMouseCursors.resizeUpLeftDownRight;
      case 'topRight':
      case 'bottomLeft':
        return SystemMouseCursors.resizeUpRightDownLeft;
      default:
        return SystemMouseCursors.precise;
    }
  }
}

/// Side handle widget (rectangle, for stretch).
class _SideHandle extends StatelessWidget {
  const _SideHandle({
    required this.side,
    required this.onDrag,
    this.isVertical = false,
  });

  final String side;
  final void Function(String side, Offset delta) onDrag;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final width = isVertical
        ? SelectionHandleConstants.sideHandleHeight
        : SelectionHandleConstants.sideHandleWidth;
    final height = isVertical
        ? SelectionHandleConstants.sideHandleWidth
        : SelectionHandleConstants.sideHandleHeight;

    return MouseRegion(
      cursor: _getCursor(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => onDrag(side, details.delta),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: SelectionHandleConstants.handleFillColor,
            border: Border.all(
              color: SelectionHandleConstants.handleBorderColor,
              width: SelectionHandleConstants.handleBorderWidth,
            ),
          ),
        ),
      ),
    );
  }

  MouseCursor _getCursor() {
    switch (side) {
      case 'top':
      case 'bottom':
        return SystemMouseCursors.resizeUpDown;
      case 'left':
      case 'right':
        return SystemMouseCursors.resizeLeftRight;
      default:
        return SystemMouseCursors.precise;
    }
  }
}
