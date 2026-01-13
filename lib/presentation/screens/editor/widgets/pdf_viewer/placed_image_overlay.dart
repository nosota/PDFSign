import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';

/// Selection handle constants.
class SelectionHandleConstants {
  // Визуальные размеры handles
  static const double cornerHandleSize = 10.0;
  static const double sideHandleWidth = 10.0;
  static const double sideHandleHeight = 6.0;

  // Hit-области (больше визуальных для удобства клика)
  static const double cornerHitSize = 24.0;
  static const double sideHitSize = 20.0;

  // Rotate zones (невидимые, снаружи углов)
  static const double rotateZoneOffset = 12.0;
  static const double rotateZoneSize = 20.0;

  // Ограничения
  static const double minObjectSize = 20.0;

  // Визуальные стили
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
  bool _isDragging = false;

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

    // Padding must accommodate object at any rotation angle
    // Max extent from center = half diagonal of the rectangle
    final halfDiagonal = math.sqrt(
      scaledWidth * scaledWidth + scaledHeight * scaledHeight,
    ) / 2;
    final padding = halfDiagonal +
        SelectionHandleConstants.rotateZoneOffset +
        SelectionHandleConstants.rotateZoneSize;

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

    // Hit area half sizes for positioning (center of hit area at handle position)
    const halfCornerHit = SelectionHandleConstants.cornerHitSize / 2;
    const halfSideHit = SelectionHandleConstants.sideHitSize / 2;

    return Positioned(
      left: centerScreen.dx - padding,
      top: centerScreen.dy - padding,
      child: SizedBox(
        width: padding * 2,
        height: padding * 2,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // [1] Image with Transform.rotate INSIDE
            Positioned(
              left: padding - scaledWidth / 2,
              top: padding - scaledHeight / 2,
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
                  child: Transform.rotate(
                    angle: image.rotation,
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
                                    color: SelectionHandleConstants.selectionBorderColor,
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

            // [2] Corner handles (OUTSIDE rotation, in screen coords)
            if (widget.isSelected)
              for (final corner in ['topLeft', 'topRight', 'bottomLeft', 'bottomRight'])
                Positioned(
                  left: cornerPositions[corner]!.dx - halfCornerHit,
                  top: cornerPositions[corner]!.dy - halfCornerHit,
                  child: _CornerHandle(
                    corner: corner,
                    cursor: _getCornerCursor(corner, image.rotation),
                    onDrag: (delta) => _handleCornerDrag(corner, delta),
                  ),
                ),

            // [3] Side handles (OUTSIDE rotation, in screen coords)
            if (widget.isSelected)
              for (final side in ['top', 'bottom', 'left', 'right'])
                Positioned(
                  left: sidePositions[side]!.dx - halfSideHit,
                  top: sidePositions[side]!.dy - halfSideHit,
                  child: _SideHandle(
                    side: side,
                    cursor: _getSideCursor(side, image.rotation),
                    onDrag: (delta) => _handleSideDrag(side, delta),
                    isVertical: side == 'left' || side == 'right',
                  ),
                ),

            // [4] Rotate zones (with icons, OUTSIDE corners)
            if (widget.isSelected)
              for (final quadrant in ['topLeft', 'topRight', 'bottomLeft', 'bottomRight'])
                _buildRotateZone(quadrant, cornerPositions[quadrant]!, image.rotation),
          ],
        ),
      ),
    );
  }

  Widget _buildRotateZone(String quadrant, Offset cornerPos, double rotation) {
    const offset = SelectionHandleConstants.rotateZoneOffset;
    const size = SelectionHandleConstants.rotateZoneSize;

    // Local direction "outward" from corner (before rotation)
    Offset localDirection;
    switch (quadrant) {
      case 'topLeft':
        localDirection = const Offset(-1, -1);
      case 'topRight':
        localDirection = const Offset(1, -1);
      case 'bottomLeft':
        localDirection = const Offset(-1, 1);
      case 'bottomRight':
        localDirection = const Offset(1, 1);
      default:
        localDirection = Offset.zero;
    }

    // Normalize and apply rotation
    final normalizedDir = localDirection / localDirection.distance;
    final rotatedDir = _rotatePoint(normalizedDir, rotation);

    // Position zone center at offset distance from corner in rotated direction
    final zoneCenter = cornerPos + rotatedDir * (offset + size / 2);

    return Positioned(
      left: zoneCenter.dx - size / 2,
      top: zoneCenter.dy - size / 2,
      child: _RotateZone(
        quadrant: quadrant,
        onDragStart: _handleRotateDragStart,
        onDrag: _handleRotateDrag,
        onDragEnd: _handleRotateDragEnd,
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
  // ROTATION (from rotate zones)
  // ==========================================================================

  void _handleRotateDragStart() {
    _rotateStartRotation = widget.image.rotation;
    _rotateStartAngle = null;
  }

  void _handleRotateDrag(Offset globalPosition) {
    final image = widget.image;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final localPos = renderBox.globalToLocal(globalPosition);

    // Compute center position in widget's local coordinates
    final padding = SelectionHandleConstants.rotateZoneOffset +
        SelectionHandleConstants.rotateZoneSize;
    final scaledWidth = image.size.width * widget.scale;
    final scaledHeight = image.size.height * widget.scale;
    final centerLocal = Offset(
      padding + scaledWidth / 2,
      padding + scaledHeight / 2,
    );

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
    _rotateStartRotation = null;
    _rotateStartAngle = null;
  }
}

/// Corner handle widget (square, for proportional resize only).
class _CornerHandle extends StatelessWidget {
  const _CornerHandle({
    required this.corner,
    required this.cursor,
    required this.onDrag,
  });

  final String corner;
  final MouseCursor cursor;
  final void Function(Offset delta) onDrag;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.cornerHitSize;
    const visualSize = SelectionHandleConstants.cornerHandleSize;

    return MouseRegion(
      cursor: cursor,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => onDrag(details.delta),
        child: SizedBox(
          width: hitSize,
          height: hitSize,
          child: Center(
            child: Container(
              width: visualSize,
              height: visualSize,
              decoration: BoxDecoration(
                color: SelectionHandleConstants.handleFillColor,
                border: Border.all(
                  color: SelectionHandleConstants.handleBorderColor,
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

/// Side handle widget (rectangle, for non-proportional stretch).
class _SideHandle extends StatelessWidget {
  const _SideHandle({
    required this.side,
    required this.cursor,
    required this.onDrag,
    this.isVertical = false,
  });

  final String side;
  final MouseCursor cursor;
  final void Function(Offset delta) onDrag;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    const hitSize = SelectionHandleConstants.sideHitSize;
    final visualWidth = isVertical
        ? SelectionHandleConstants.sideHandleHeight
        : SelectionHandleConstants.sideHandleWidth;
    final visualHeight = isVertical
        ? SelectionHandleConstants.sideHandleWidth
        : SelectionHandleConstants.sideHandleHeight;

    return MouseRegion(
      cursor: cursor,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => onDrag(details.delta),
        child: SizedBox(
          width: hitSize,
          height: hitSize,
          child: Center(
            child: Container(
              width: visualWidth,
              height: visualHeight,
              decoration: BoxDecoration(
                color: SelectionHandleConstants.handleFillColor,
                border: Border.all(
                  color: SelectionHandleConstants.handleBorderColor,
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

/// Rotate zone widget with curved arrow icon.
class _RotateZone extends StatefulWidget {
  const _RotateZone({
    required this.quadrant,
    required this.onDragStart,
    required this.onDrag,
    required this.onDragEnd,
  });

  final String quadrant;
  final VoidCallback onDragStart;
  final void Function(Offset globalPosition) onDrag;
  final VoidCallback onDragEnd;

  @override
  State<_RotateZone> createState() => _RotateZoneState();
}

class _RotateZoneState extends State<_RotateZone> {
  bool _isDragging = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const size = SelectionHandleConstants.rotateZoneSize;

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
          width: size,
          height: size,
          child: CustomPaint(
            painter: _RotateIconPainter(
              quadrant: widget.quadrant,
              color: _isHovered || _isDragging
                  ? SelectionHandleConstants.handleBorderColor
                  : SelectionHandleConstants.handleBorderColor.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints a curved arrow icon for rotation zones.
class _RotateIconPainter extends CustomPainter {
  _RotateIconPainter({
    required this.quadrant,
    required this.color,
  });

  final String quadrant;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Determine start angle and sweep based on quadrant
    // Arrow indicates counter-clockwise rotation direction
    double startAngle;
    const sweepAngle = 2.0; // ~115 degrees arc

    switch (quadrant) {
      case 'topLeft':
        startAngle = math.pi; // 180° - arrow points down-right
      case 'topRight':
        startAngle = -math.pi / 2; // -90° - arrow points down-left
      case 'bottomLeft':
        startAngle = math.pi / 2; // 90° - arrow points up-right
      case 'bottomRight':
        startAngle = 0; // 0° - arrow points up-left
      default:
        startAngle = 0;
    }

    // Draw arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // Draw arrowhead at end of arc
    final arrowAngle = startAngle + sweepAngle;
    final arrowTip = Offset(
      center.dx + radius * math.cos(arrowAngle),
      center.dy + radius * math.sin(arrowAngle),
    );

    // Arrow direction (perpendicular to radius + slight backward angle)
    final arrowDir = arrowAngle + math.pi / 2 + 0.5;
    const arrowSize = 5.0;

    final arrow1 = Offset(
      arrowTip.dx + arrowSize * math.cos(arrowDir + 0.5),
      arrowTip.dy + arrowSize * math.sin(arrowDir + 0.5),
    );
    final arrow2 = Offset(
      arrowTip.dx + arrowSize * math.cos(arrowDir - 0.5),
      arrowTip.dy + arrowSize * math.sin(arrowDir - 0.5),
    );

    canvas.drawLine(arrowTip, arrow1, paint);
    canvas.drawLine(arrowTip, arrow2, paint);
  }

  @override
  bool shouldRepaint(_RotateIconPainter oldDelegate) {
    return oldDelegate.quadrant != quadrant || oldDelegate.color != color;
  }
}
