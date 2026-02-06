import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/size_label.dart';

/// Selection handle constants.
class SelectionHandleConstants {
  // Визуальные размеры handles
  static const double cornerHandleSize = 10.0;
  static const double sideHandleWidth = 10.0;
  static const double sideHandleHeight = 6.0;

  // Hit-области (больше визуальных для удобства клика)
  static const double cornerHitSize = 24.0;
  static const double sideHitSize = 20.0;

  // Rotation handle (один сверху по центру)
  static const double rotationHandleSize = 24.0;
  static const double rotationHandleHitSize = 32.0;
  static const double rotationHandleStemLength = 20.0;
  static const double rotationStemWidth = 2.0;

  // Ограничения
  static const double minObjectSize = 20.0;

  // Визуальные стили
  static const double handleBorderWidth = 2.0;
  static const Color handleFillColor = Colors.white;
  static const double handleFillOpacity = 0.5;
  static const double handleFillHoverOpacity = 0.8;
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
  bool _isDragging = false;
  bool _isRotating = false;

  // Rotation state (saved at drag start for smooth rotation)
  double? _rotateStartAngle;
  double? _rotateStartRotation;

  /// Rotates a point around origin (0,0).
  Offset _rotatePoint(Offset point, double rotation) {
    final cosR = math.cos(rotation);
    final sinR = math.sin(rotation);
    return Offset(
      point.dx * cosR - point.dy * sinR,
      point.dx * sinR + point.dy * cosR,
    );
  }

  /// Transforms screen delta to object's local coordinates (accounting for rotation).
  Offset _transformToLocal(Offset screenDelta, double rotation) {
    final cosR = math.cos(-rotation);
    final sinR = math.sin(-rotation);
    return Offset(
      screenDelta.dx * cosR - screenDelta.dy * sinR,
      screenDelta.dx * sinR + screenDelta.dy * cosR,
    );
  }

  /// Computes corner positions in screen coordinates (relative to widget origin).
  Map<String, Offset> _computeCornerPositions(
    Offset center,
    double scaledWidth,
    double scaledHeight,
    double rotation,
  ) {
    final halfW = scaledWidth / 2;
    final halfH = scaledHeight / 2;

    final localCorners = {
      'topLeft': Offset(-halfW, -halfH),
      'topRight': Offset(halfW, -halfH),
      'bottomLeft': Offset(-halfW, halfH),
      'bottomRight': Offset(halfW, halfH),
    };

    return localCorners.map((key, local) {
      final rotated = _rotatePoint(local, rotation);
      return MapEntry(key, center + rotated);
    });
  }

  /// Computes side center positions in screen coordinates.
  Map<String, Offset> _computeSidePositions(
    Offset center,
    double scaledWidth,
    double scaledHeight,
    double rotation,
  ) {
    final halfW = scaledWidth / 2;
    final halfH = scaledHeight / 2;

    final localSides = {
      'top': Offset(0, -halfH),
      'bottom': Offset(0, halfH),
      'left': Offset(-halfW, 0),
      'right': Offset(halfW, 0),
    };

    return localSides.map((key, local) {
      final rotated = _rotatePoint(local, rotation);
      return MapEntry(key, center + rotated);
    });
  }

  /// Gets cursor for corner handle based on rotation.
  MouseCursor _getCornerCursor(String corner, double rotation) {
    const baseAngles = {
      'topLeft': 225.0,
      'topRight': 315.0,
      'bottomRight': 45.0,
      'bottomLeft': 135.0,
    };

    var angle = (baseAngles[corner]! + rotation * 180 / math.pi) % 360;
    if (angle < 0) angle += 360;

    // 8 directions, 45° each
    if (angle >= 337.5 || angle < 22.5) {
      return SystemMouseCursors.resizeLeftRight;
    }
    if (angle >= 22.5 && angle < 67.5) {
      return SystemMouseCursors.resizeUpLeftDownRight;
    }
    if (angle >= 67.5 && angle < 112.5) {
      return SystemMouseCursors.resizeUpDown;
    }
    if (angle >= 112.5 && angle < 157.5) {
      return SystemMouseCursors.resizeUpRightDownLeft;
    }
    if (angle >= 157.5 && angle < 202.5) {
      return SystemMouseCursors.resizeLeftRight;
    }
    if (angle >= 202.5 && angle < 247.5) {
      return SystemMouseCursors.resizeUpLeftDownRight;
    }
    if (angle >= 247.5 && angle < 292.5) {
      return SystemMouseCursors.resizeUpDown;
    }
    return SystemMouseCursors.resizeUpRightDownLeft;
  }

  /// Gets cursor for side handle based on rotation.
  MouseCursor _getSideCursor(String side, double rotation) {
    const baseAngles = {
      'top': 270.0,
      'bottom': 90.0,
      'left': 180.0,
      'right': 0.0,
    };

    var angle = (baseAngles[side]! + rotation * 180 / math.pi) % 360;
    if (angle < 0) angle += 360;

    final isVertical =
        (angle >= 45 && angle < 135) || (angle >= 225 && angle < 315);
    return isVertical
        ? SystemMouseCursors.resizeUpDown
        : SystemMouseCursors.resizeLeftRight;
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.image;
    final scale = widget.scale;

    // Calculate scaled dimensions
    final scaledWidth = image.size.width * scale;
    final scaledHeight = image.size.height * scale;

    // Padding must accommodate object at any rotation angle plus rotation handle
    // Max extent from center = half diagonal of the rectangle + stem + handle
    final halfDiagonal = math.sqrt(
      scaledWidth * scaledWidth + scaledHeight * scaledHeight,
    ) / 2;
    final padding = halfDiagonal +
        SelectionHandleConstants.rotationHandleStemLength +
        SelectionHandleConstants.rotationHandleHitSize;

    // Center of object in screen coordinates (relative to page)
    final centerScreen = Offset(
      (image.position.dx + image.size.width / 2) * scale,
      (image.position.dy + image.size.height / 2) * scale,
    );

    // Center relative to widget origin (widget is square with side = padding * 2)
    final centerLocal = Offset(padding, padding);

    // Compute handle positions in widget's local coordinates
    final cornerPositions =
        _computeCornerPositions(centerLocal, scaledWidth, scaledHeight, image.rotation);
    final sidePositions =
        _computeSidePositions(centerLocal, scaledWidth, scaledHeight, image.rotation);

    // Compute rotation handle position (top center, outside the object)
    final rotationHandleInfo = _computeRotationHandlePosition(
      centerLocal,
      scaledWidth,
      scaledHeight,
      image.rotation,
    );

    // Hit area half sizes for positioning (center of hit area at handle position)
    const halfCornerHit = SelectionHandleConstants.cornerHitSize / 2;
    const halfSideHit = SelectionHandleConstants.sideHitSize / 2;
    const halfRotationHit = SelectionHandleConstants.rotationHandleHitSize / 2;

    return Positioned(
      left: centerScreen.dx - padding,
      top: centerScreen.dy - padding,
      child: SizedBox(
        width: padding * 2,
        height: padding * 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // [1] Image with Transform.rotate OUTSIDE (hit area rotates with image)
            Positioned(
              left: padding - scaledWidth / 2,
              top: padding - scaledHeight / 2,
              child: Transform.rotate(
                angle: image.rotation,
                child: MouseRegion(
                  cursor: _isDragging
                      ? SystemMouseCursors.grabbing
                      : SystemMouseCursors.grab,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _handleTap,
                    onPanStart: _handlePanStart,
                    onPanUpdate: _handlePanUpdate,
                    onPanEnd: _handlePanEnd,
                    child: SizedBox(
                      width: scaledWidth,
                      height: scaledHeight,
                      child: Stack(
                        children: [
                          // Image
                          Positioned.fill(
                            child: Image.file(
                              File(image.imagePath),
                              fit: BoxFit.fill,
                            ),
                          ),
                          // Selection border (inside rotation)
                          if (widget.isSelected)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: SelectionHandleConstants.selectionBorderColor.withOpacity(0.5),
                                    width: SelectionHandleConstants.selectionBorderWidth,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // [2] Rotation handle stem (line from top edge to handle)
            // IgnorePointer prevents stem from blocking mouse events on the image
            if (widget.isSelected)
              IgnorePointer(
                child: CustomPaint(
                  size: Size(padding * 2, padding * 2),
                  painter: _StemPainter(
                    start: rotationHandleInfo.topEdge,
                    end: rotationHandleInfo.handleCenter,
                    color: _isRotating
                        ? SelectionHandleConstants.handleBorderColor
                        : SelectionHandleConstants.handleBorderColor.withOpacity(0.5),
                  ),
                ),
              ),

            // [3] Rotation handle (circle at top center)
            if (widget.isSelected)
              Positioned(
                left: rotationHandleInfo.handleCenter.dx - halfRotationHit,
                top: rotationHandleInfo.handleCenter.dy - halfRotationHit,
                child: _RotationHandle(
                  onDragStart: _handleRotateDragStart,
                  onDrag: _handleRotateDrag,
                  onDragEnd: _handleRotateDragEnd,
                  isRotating: _isRotating,
                ),
              ),

            // [4] Corner handles (OUTSIDE rotation, in screen coords)
            if (widget.isSelected)
              for (final corner in ['topLeft', 'topRight', 'bottomLeft', 'bottomRight'])
                Positioned(
                  left: cornerPositions[corner]!.dx - halfCornerHit,
                  top: cornerPositions[corner]!.dy - halfCornerHit,
                  child: _CornerHandle(
                    corner: corner,
                    cursor: _getCornerCursor(corner, image.rotation),
                    onDrag: (delta) => _handleCornerDrag(corner, delta),
                    isRotating: _isRotating,
                  ),
                ),

            // [5] Side handles (OUTSIDE rotation, in screen coords)
            if (widget.isSelected)
              for (final side in ['top', 'bottom', 'left', 'right'])
                Positioned(
                  left: sidePositions[side]!.dx - halfSideHit,
                  top: sidePositions[side]!.dy - halfSideHit,
                  child: _SideHandle(
                    side: side,
                    cursor: _getSideCursor(side, image.rotation),
                    onDrag: (delta) => _handleSideDrag(side, delta),
                    isRotating: _isRotating,
                  ),
                ),

            // [6] Size label (positioned at visually bottom edge)
            if (widget.isSelected)
              Builder(
                builder: (context) {
                  final bottomInfo = _findBottomEdge(
                    widgetCenter: centerLocal,
                    scaledWidth: scaledWidth,
                    scaledHeight: scaledHeight,
                    rotation: image.rotation,
                    originalWidth: image.size.width,
                    originalHeight: image.size.height,
                  );

                  // Offset perpendicular to edge (outward from object)
                  const labelOffset = 16.0;
                  Offset outward;
                  switch (bottomInfo.edge) {
                    case 'top':
                      outward = _rotatePoint(const Offset(0, -1), image.rotation);
                    case 'bottom':
                      outward = _rotatePoint(const Offset(0, 1), image.rotation);
                    case 'left':
                      outward = _rotatePoint(const Offset(-1, 0), image.rotation);
                    case 'right':
                      outward = _rotatePoint(const Offset(1, 0), image.rotation);
                    default:
                      outward = _rotatePoint(const Offset(0, 1), image.rotation);
                  }

                  final labelPos = bottomInfo.center + outward * labelOffset;

                  return Positioned(
                    left: labelPos.dx,
                    top: labelPos.dy,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, -0.5),
                      child: Transform.rotate(
                        angle: bottomInfo.labelRotation,
                        child: SizeLabel(
                          firstDimension: bottomInfo.firstDim,
                          secondDimension: bottomInfo.secondDim,
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  /// Computes the rotation handle position (top center with stem).
  ({Offset topEdge, Offset handleCenter}) _computeRotationHandlePosition(
    Offset center,
    double scaledWidth,
    double scaledHeight,
    double rotation,
  ) {
    final halfH = scaledHeight / 2;

    // Top edge center in local coords (before rotation)
    final topEdgeLocal = Offset(0, -halfH);

    // Rotate to get screen position
    final topEdgeScreen = center + _rotatePoint(topEdgeLocal, rotation);

    // Direction "up" from top edge (outward, perpendicular to top edge)
    final upDirection = _rotatePoint(const Offset(0, -1), rotation);

    // Handle center position (stem length + half handle size from top edge)
    const stemLength = SelectionHandleConstants.rotationHandleStemLength;
    const handleSize = SelectionHandleConstants.rotationHandleSize;
    final handleCenter = topEdgeScreen + upDirection * (stemLength + handleSize / 2);

    return (topEdge: topEdgeScreen, handleCenter: handleCenter);
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
    // Delta is in rotated local coordinates (because GestureDetector is inside Transform.rotate)
    // Convert to screen/PDF coordinates by rotating by +rotation
    final localDelta = details.delta / widget.scale;
    final pdfDelta = _rotatePoint(localDelta, widget.image.rotation);
    final newPosition = widget.image.position + pdfDelta;

    ref.read(placedImagesProvider.notifier).moveImage(
          widget.image.id,
          newPosition,
        );
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() => _isDragging = false);
  }

  // ==========================================================================
  // CORNER DRAG (resize only - no rotation)
  // ==========================================================================

  void _handleCornerDrag(String corner, Offset delta) {
    final image = widget.image;
    final pdfDelta = delta / widget.scale;
    final localDelta = _transformToLocal(pdfDelta, image.rotation);

    // Corner handles always do proportional resize
    _handleProportionalResize(corner, localDelta);
  }

  void _handleProportionalResize(String corner, Offset localDelta) {
    final image = widget.image;
    final oldWidth = image.size.width;
    final oldHeight = image.size.height;
    final oldCenter = image.center;
    const minSize = SelectionHandleConstants.minObjectSize;

    // Determine target width based on corner (scale by width only)
    double targetWidth;
    switch (corner) {
      case 'topLeft':
      case 'bottomLeft':
        targetWidth = oldWidth - localDelta.dx;
      case 'topRight':
      case 'bottomRight':
        targetWidth = oldWidth + localDelta.dx;
      default:
        return;
    }

    // Scale proportionally by width
    var scale = targetWidth / oldWidth;
    var newWidth = oldWidth * scale;
    var newHeight = oldHeight * scale;

    // Enforce minimum size on both axes
    if (newWidth < minSize || newHeight < minSize) {
      final minScale = math.max(minSize / oldWidth, minSize / oldHeight);
      scale = minScale;
      newWidth = oldWidth * scale;
      newHeight = oldHeight * scale;
    }

    // Fix opposite corner by shifting center
    final actualWidthDelta = newWidth - oldWidth;
    final actualHeightDelta = newHeight - oldHeight;

    Offset localCenterShift;
    switch (corner) {
      case 'topLeft':
        localCenterShift = Offset(-actualWidthDelta / 2, -actualHeightDelta / 2);
      case 'topRight':
        localCenterShift = Offset(actualWidthDelta / 2, -actualHeightDelta / 2);
      case 'bottomLeft':
        localCenterShift = Offset(-actualWidthDelta / 2, actualHeightDelta / 2);
      case 'bottomRight':
        localCenterShift = Offset(actualWidthDelta / 2, actualHeightDelta / 2);
      default:
        localCenterShift = Offset.zero;
    }

    // Transform center shift back to PDF coordinates
    final pdfCenterShift = _rotatePoint(localCenterShift, image.rotation);
    final newCenter = oldCenter + pdfCenterShift;
    final newPosition = Offset(
      newCenter.dx - newWidth / 2,
      newCenter.dy - newHeight / 2,
    );

    ref.read(placedImagesProvider.notifier).transformImage(
          image.id,
          position: newPosition,
          size: Size(newWidth, newHeight),
        );
  }

  // ==========================================================================
  // SIDE DRAG (non-proportional stretch)
  // ==========================================================================

  void _handleSideDrag(String side, Offset delta) {
    final image = widget.image;
    final pdfDelta = delta / widget.scale;
    final localDelta = _transformToLocal(pdfDelta, image.rotation);

    var newWidth = image.size.width;
    var newHeight = image.size.height;
    var newX = image.position.dx;
    var newY = image.position.dy;

    const minSize = SelectionHandleConstants.minObjectSize;

    switch (side) {
      case 'top':
        final newH =
            (image.size.height - localDelta.dy).clamp(minSize, double.infinity);
        newY = image.position.dy + (image.size.height - newH);
        newHeight = newH;
      case 'bottom':
        newHeight =
            (image.size.height + localDelta.dy).clamp(minSize, double.infinity);
      case 'left':
        final newW =
            (image.size.width - localDelta.dx).clamp(minSize, double.infinity);
        newX = image.position.dx + (image.size.width - newW);
        newWidth = newW;
      case 'right':
        newWidth =
            (image.size.width + localDelta.dx).clamp(minSize, double.infinity);
    }

    ref.read(placedImagesProvider.notifier).transformImage(
          image.id,
          position: Offset(newX, newY),
          size: Size(newWidth, newHeight),
        );
  }

  // ==========================================================================
  // ROTATION (from rotation handle)
  // ==========================================================================

  void _handleRotateDragStart() {
    setState(() => _isRotating = true);
    _rotateStartRotation = widget.image.rotation;
    _rotateStartAngle = null;
  }

  void _handleRotateDrag(Offset globalPosition) {
    final image = widget.image;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final localPos = renderBox.globalToLocal(globalPosition);

    // Compute center position in widget's local coordinates
    // Must match the padding calculation in build()
    final scaledWidth = image.size.width * widget.scale;
    final scaledHeight = image.size.height * widget.scale;
    final halfDiagonal = math.sqrt(
      scaledWidth * scaledWidth + scaledHeight * scaledHeight,
    ) / 2;
    final padding = halfDiagonal +
        SelectionHandleConstants.rotationHandleStemLength +
        SelectionHandleConstants.rotationHandleHitSize;
    final centerLocal = Offset(padding, padding);

    final currentAngle = (localPos - centerLocal).direction;

    // Save start angle on first update
    if (_rotateStartAngle == null) {
      _rotateStartAngle = currentAngle;
      return;
    }

    // Compute angle delta with normalization for smooth ±180° transition
    var angleDelta = currentAngle - _rotateStartAngle!;
    while (angleDelta > math.pi) {
      angleDelta -= 2 * math.pi;
    }
    while (angleDelta < -math.pi) {
      angleDelta += 2 * math.pi;
    }

    final newRotation = _rotateStartRotation! + angleDelta;
    ref.read(placedImagesProvider.notifier).rotateImage(image.id, newRotation);
  }

  void _handleRotateDragEnd() {
    setState(() => _isRotating = false);
    _rotateStartRotation = null;
    _rotateStartAngle = null;
  }

  // ==========================================================================
  // SIZE LABEL (positioned at visually bottom edge)
  // ==========================================================================

  /// Finds the visually bottom edge (maximum Y center in screen coords).
  ///
  /// Returns edge name, center position, label rotation, and dimensions.
  ({
    String edge,
    Offset center,
    double labelRotation,
    double firstDim,
    double secondDim,
  }) _findBottomEdge({
    required Offset widgetCenter,
    required double scaledWidth,
    required double scaledHeight,
    required double rotation,
    required double originalWidth,
    required double originalHeight,
  }) {
    final halfW = scaledWidth / 2;
    final halfH = scaledHeight / 2;

    // Edge centers in local coords (before rotation)
    final localCenters = {
      'top': Offset(0, -halfH),
      'bottom': Offset(0, halfH),
      'left': Offset(-halfW, 0),
      'right': Offset(halfW, 0),
    };

    // Find edge with max Y in screen coords
    String bottomEdge = 'bottom';
    double maxY = double.negativeInfinity;

    for (final entry in localCenters.entries) {
      final rotated = _rotatePoint(entry.value, rotation);
      final screenPos = widgetCenter + rotated;
      if (screenPos.dy > maxY) {
        maxY = screenPos.dy;
        bottomEdge = entry.key;
      }
    }

    // Screen position of bottom edge center
    final localCenter = localCenters[bottomEdge]!;
    final screenCenter = widgetCenter + _rotatePoint(localCenter, rotation);

    // Label rotation = parallel to edge, but normalized to be readable
    double labelRotation;
    double firstDim;
    double secondDim;

    switch (bottomEdge) {
      case 'top':
        labelRotation = rotation + math.pi; // flipped 180°
        firstDim = originalWidth;
        secondDim = originalHeight;
      case 'bottom':
        labelRotation = rotation;
        firstDim = originalWidth;
        secondDim = originalHeight;
      case 'left':
        labelRotation = rotation - math.pi / 2;
        firstDim = originalHeight;
        secondDim = originalWidth;
      case 'right':
        labelRotation = rotation + math.pi / 2;
        firstDim = originalHeight;
        secondDim = originalWidth;
      default:
        labelRotation = rotation;
        firstDim = originalWidth;
        secondDim = originalHeight;
    }

    // Normalize angle to [-π/2, π/2] so text is readable (not upside down)
    while (labelRotation > math.pi / 2) {
      labelRotation -= math.pi;
    }
    while (labelRotation < -math.pi / 2) {
      labelRotation += math.pi;
    }

    return (
      edge: bottomEdge,
      center: screenCenter,
      labelRotation: labelRotation,
      firstDim: firstDim,
      secondDim: secondDim,
    );
  }
}

/// Corner handle widget (square, for proportional resize only).
class _CornerHandle extends StatefulWidget {
  const _CornerHandle({
    required this.corner,
    required this.cursor,
    required this.onDrag,
    this.isRotating = false,
  });

  final String corner;
  final MouseCursor cursor;
  final void Function(Offset delta) onDrag;
  final bool isRotating;

  @override
  State<_CornerHandle> createState() => _CornerHandleState();
}

class _CornerHandleState extends State<_CornerHandle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.cornerHitSize;
    const visualSize = SelectionHandleConstants.cornerHandleSize;

    final borderColor = _isHovered
        ? SelectionHandleConstants.handleBorderColor
        : SelectionHandleConstants.handleBorderColor.withOpacity(0.5);
    final fillColor = SelectionHandleConstants.handleFillColor.withOpacity(
      _isHovered
          ? SelectionHandleConstants.handleFillHoverOpacity
          : SelectionHandleConstants.handleFillOpacity,
    );

    // Use grabbing cursor during rotation to override handle cursor
    final cursor =
        widget.isRotating ? SystemMouseCursors.grabbing : widget.cursor;

    return MouseRegion(
      cursor: cursor,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => widget.onDrag(details.delta),
        child: SizedBox(
          width: hitSize,
          height: hitSize,
          child: Center(
            child: Container(
              width: visualSize,
              height: visualSize,
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(
                  color: borderColor,
                  width: SelectionHandleConstants.handleBorderWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Side handle widget (square, for non-proportional stretch).
class _SideHandle extends StatefulWidget {
  const _SideHandle({
    required this.side,
    required this.cursor,
    required this.onDrag,
    this.isRotating = false,
  });

  final String side;
  final MouseCursor cursor;
  final void Function(Offset delta) onDrag;
  final bool isRotating;

  @override
  State<_SideHandle> createState() => _SideHandleState();
}

class _SideHandleState extends State<_SideHandle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.sideHitSize;
    const visualSize = SelectionHandleConstants.cornerHandleSize;

    final borderColor = _isHovered
        ? SelectionHandleConstants.handleBorderColor
        : SelectionHandleConstants.handleBorderColor.withOpacity(0.5);
    final fillColor = SelectionHandleConstants.handleFillColor.withOpacity(
      _isHovered
          ? SelectionHandleConstants.handleFillHoverOpacity
          : SelectionHandleConstants.handleFillOpacity,
    );

    // Use grabbing cursor during rotation to override handle cursor
    final cursor =
        widget.isRotating ? SystemMouseCursors.grabbing : widget.cursor;

    return MouseRegion(
      cursor: cursor,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => widget.onDrag(details.delta),
        child: SizedBox(
          width: hitSize,
          height: hitSize,
          child: Center(
            child: Container(
              width: visualSize,
              height: visualSize,
              decoration: BoxDecoration(
                color: fillColor,
                border: Border.all(
                  color: borderColor,
                  width: SelectionHandleConstants.handleBorderWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rotation handle widget (circular, positioned at top center).
class _RotationHandle extends StatefulWidget {
  const _RotationHandle({
    required this.onDragStart,
    required this.onDrag,
    required this.onDragEnd,
    this.isRotating = false,
  });

  final VoidCallback onDragStart;
  final void Function(Offset globalPosition) onDrag;
  final VoidCallback onDragEnd;
  final bool isRotating;

  @override
  State<_RotationHandle> createState() => _RotationHandleState();
}

class _RotationHandleState extends State<_RotationHandle> {
  bool _isDragging = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.rotationHandleHitSize;
    const visualSize = SelectionHandleConstants.rotationHandleSize;

    final isActive = _isDragging || _isHovered || widget.isRotating;
    final borderColor = isActive
        ? SelectionHandleConstants.handleBorderColor
        : SelectionHandleConstants.handleBorderColor.withOpacity(0.5);
    final fillColor = SelectionHandleConstants.handleFillColor.withOpacity(
      isActive
          ? SelectionHandleConstants.handleFillHoverOpacity
          : SelectionHandleConstants.handleFillOpacity,
    );

    return MouseRegion(
      cursor: _isDragging ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) {
          setState(() => _isDragging = true);
          widget.onDragStart();
        },
        onPanUpdate: (details) {
          widget.onDrag(details.globalPosition);
        },
        onPanEnd: (_) {
          setState(() => _isDragging = false);
          widget.onDragEnd();
        },
        child: SizedBox(
          width: hitSize,
          height: hitSize,
          child: Center(
            child: Container(
              width: visualSize,
              height: visualSize,
              decoration: BoxDecoration(
                color: fillColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: SelectionHandleConstants.handleBorderWidth,
                ),
              ),
              child: Icon(
                Icons.refresh,
                size: visualSize * 0.6,
                color: borderColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the stem line from top edge to rotation handle.
class _StemPainter extends CustomPainter {
  const _StemPainter({
    required this.start,
    required this.end,
    required this.color,
  });

  final Offset start;
  final Offset end;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = SelectionHandleConstants.rotationStemWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(_StemPainter oldDelegate) {
    return oldDelegate.start != start ||
        oldDelegate.end != end ||
        oldDelegate.color != color;
  }
}
