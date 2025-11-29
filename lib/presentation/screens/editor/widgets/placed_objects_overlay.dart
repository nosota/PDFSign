import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/data/services/clipboard_service.dart';
import 'package:pdfsign/domain/entities/placed_object.dart' as domain;
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/l10n/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/editor_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_provider.dart';
import 'package:pdfsign/presentation/providers/signature_library/signature_library_provider.dart';

/// Interactive overlay for placed objects with selection and transform handles
class PlacedObjectsOverlay extends ConsumerStatefulWidget {
  const PlacedObjectsOverlay({super.key});

  @override
  ConsumerState<PlacedObjectsOverlay> createState() => _PlacedObjectsOverlayState();
}

class _PlacedObjectsOverlayState extends ConsumerState<PlacedObjectsOverlay> {
  Offset? _dragStartPosition;
  domain.Offset? _objectStartPosition;
  domain.Size? _resizeStartSize;
  double? _rotationStart;
  ResizeHandle? _activeHandle;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorProvider);
    final zoomLevel = ref.watch(zoomLevelProvider);

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: GestureDetector(
        onTap: () {
          // Deselect when clicking empty space
          ref.read(editorProvider.notifier).deselectAll();
        },
        child: Stack(
          children: [
            // Render all placed objects
            ...editorState.placedObjects.map((obj) {
              final isSelected = obj.id == editorState.selectedObjectId;
              return _PlacedObjectWidget(
                key: ValueKey(obj.id),
                object: obj,
                isSelected: isSelected,
                zoomLevel: zoomLevel,
                onTap: () => _selectObject(obj.id),
                onPanStart: isSelected ? _onPanStart : null,
                onPanUpdate: isSelected ? _onPanUpdate : null,
                onPanEnd: isSelected ? _onPanEnd : null,
              );
            }).toList(),

            // Selection handles for selected object
            if (editorState.selectedObjectId != null)
              _buildSelectionHandles(editorState, zoomLevel),
          ],
        ),
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId == null) return;

    final zoomLevel = ref.read(zoomLevelProvider);
    final isShift = HardwareKeyboard.instance.isShiftPressed;
    final distance = isShift ? AppConstants.shiftNudgeDistance : AppConstants.nudgeDistance;

    domain.Offset? delta;

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      delta = domain.Offset(0, -distance / zoomLevel);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      delta = domain.Offset(0, distance / zoomLevel);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      delta = domain.Offset(-distance / zoomLevel, 0);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      delta = domain.Offset(distance / zoomLevel, 0);
    } else if (event.logicalKey == LogicalKeyboardKey.delete ||
               event.logicalKey == LogicalKeyboardKey.backspace) {
      ref.read(editorProvider.notifier).deleteObject(selectedId);
      return;
    }

    if (delta != null) {
      ref.read(editorProvider.notifier).nudgeObject(selectedId, delta);
    }
  }

  Widget _buildSelectionHandles(EditorState state, double zoomLevel) {
    final selectedObj = state.placedObjects
        .firstWhere((obj) => obj.id == state.selectedObjectId);

    return _SelectionHandles(
      object: selectedObj,
      zoomLevel: zoomLevel,
      onHandleDragStart: _onHandleDragStart,
      onHandleDragUpdate: _onHandleDragUpdate,
      onHandleDragEnd: _onHandleDragEnd,
    );
  }

  void _selectObject(String objectId) {
    ref.read(editorProvider.notifier).selectObject(objectId);
  }

  void _onPanStart(DragStartDetails details) {
    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId == null) return;

    final obj = ref.read(editorProvider).placedObjects
        .firstWhere((o) => o.id == selectedId);

    setState(() {
      _dragStartPosition = details.globalPosition;
      _objectStartPosition = obj.position;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_dragStartPosition == null || _objectStartPosition == null) return;

    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId == null) return;

    final zoomLevel = ref.read(zoomLevelProvider);
    final delta = details.globalPosition - _dragStartPosition!;

    final newPosition = domain.Offset(
      _objectStartPosition!.dx + delta.dx / zoomLevel,
      _objectStartPosition!.dy + delta.dy / zoomLevel,
    );

    ref.read(editorProvider.notifier).moveObject(selectedId, newPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _dragStartPosition = null;
      _objectStartPosition = null;
    });
  }

  void _onHandleDragStart(ResizeHandle handle, DragStartDetails details) {
    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId == null) return;

    final obj = ref.read(editorProvider).placedObjects
        .firstWhere((o) => o.id == selectedId);

    setState(() {
      _activeHandle = handle;
      _dragStartPosition = details.globalPosition;
      _resizeStartSize = obj.size;
      _rotationStart = obj.rotation;
    });
  }

  void _onHandleDragUpdate(ResizeHandle handle, DragUpdateDetails details) {
    if (_dragStartPosition == null) return;

    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId == null) return;

    final zoomLevel = ref.read(zoomLevelProvider);
    final delta = details.globalPosition - _dragStartPosition!;

    if (handle == ResizeHandle.rotate) {
      // Rotation logic (simplified)
      final angleDelta = delta.dx * 0.5; // Sensitivity factor
      ref.read(editorProvider.notifier).rotateObject(selectedId, angleDelta);
    } else {
      // Resize logic
      _handleResize(handle, delta, zoomLevel, selectedId);
    }
  }

  void _handleResize(ResizeHandle handle, Offset delta, double zoomLevel, String objectId) {
    if (_resizeStartSize == null) return;

    double deltaWidth = 0;
    double deltaHeight = 0;

    switch (handle) {
      case ResizeHandle.topLeft:
        deltaWidth = -delta.dx / zoomLevel;
        deltaHeight = -delta.dy / zoomLevel;
        break;
      case ResizeHandle.topRight:
        deltaWidth = delta.dx / zoomLevel;
        deltaHeight = -delta.dy / zoomLevel;
        break;
      case ResizeHandle.bottomLeft:
        deltaWidth = -delta.dx / zoomLevel;
        deltaHeight = delta.dy / zoomLevel;
        break;
      case ResizeHandle.bottomRight:
        deltaWidth = delta.dx / zoomLevel;
        deltaHeight = delta.dy / zoomLevel;
        break;
      case ResizeHandle.top:
        deltaHeight = -delta.dy / zoomLevel;
        break;
      case ResizeHandle.bottom:
        deltaHeight = delta.dy / zoomLevel;
        break;
      case ResizeHandle.left:
        deltaWidth = -delta.dx / zoomLevel;
        break;
      case ResizeHandle.right:
        deltaWidth = delta.dx / zoomLevel;
        break;
      default:
        return;
    }

    final newSize = domain.Size(
      (_resizeStartSize!.width + deltaWidth).clamp(AppConstants.minObjectSize, double.infinity),
      (_resizeStartSize!.height + deltaHeight).clamp(AppConstants.minObjectSize, double.infinity),
    );

    ref.read(editorProvider.notifier).resizeObject(objectId, newSize);
  }

  void _onHandleDragEnd(ResizeHandle handle, DragEndDetails details) {
    setState(() {
      _activeHandle = null;
      _dragStartPosition = null;
      _resizeStartSize = null;
      _rotationStart = null;
    });
  }
}

enum ResizeHandle {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  top,
  bottom,
  left,
  right,
  rotate,
}

/// Widget for a single placed object
class _PlacedObjectWidget extends ConsumerWidget {
  final domain.PlacedObject object;
  final bool isSelected;
  final double zoomLevel;
  final VoidCallback onTap;
  final Function(DragStartDetails)? onPanStart;
  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragEndDetails)? onPanEnd;

  const _PlacedObjectWidget({
    super.key,
    required this.object,
    required this.isSelected,
    required this.zoomLevel,
    required this.onTap,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenPos = Offset(
      object.position.dx * zoomLevel,
      object.position.dy * zoomLevel,
    );
    final screenSize = Size(
      object.size.width * zoomLevel,
      object.size.height * zoomLevel,
    );

    return Positioned(
      left: screenPos.dx,
      top: screenPos.dy,
      child: GestureDetector(
        onTap: onTap,
        onSecondaryTapDown: isSelected ? (details) => _showContextMenu(context, ref, details) : null,
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: Transform.rotate(
          angle: object.rotation * 3.14159 / 180,
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isSelected ? const Color(0xFF0066FF) : const Color(0xFFE5E5E7),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: _buildObjectContent(ref),
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context, WidgetRef ref, TapDownDetails details) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) return;

    showMenu<void>(
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(1, 1),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.copy, size: 18),
              SizedBox(width: 8),
              Text('Copy'),
            ],
          ),
          onTap: () {
            _copyToClipboard(context, ref);
          },
        ),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.content_copy, size: 18),
              SizedBox(width: 8),
              Text('Duplicate'),
            ],
          ),
          onTap: () {
            ref.read(editorProvider.notifier).duplicateObject(object.id);
          },
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.flip_to_front, size: 18),
              SizedBox(width: 8),
              Text('Bring to Front'),
            ],
          ),
          onTap: () {
            ref.read(editorProvider.notifier).bringToFront(object.id);
          },
        ),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.flip_to_back, size: 18),
              SizedBox(width: 8),
              Text('Send to Back'),
            ],
          ),
          onTap: () {
            ref.read(editorProvider.notifier).sendToBack(object.id);
          },
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          child: const Row(
            children: [
              Icon(Icons.delete, size: 18, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
          onTap: () {
            ref.read(editorProvider.notifier).deleteObject(object.id);
          },
        ),
      ],
    );
  }

  Future<void> _copyToClipboard(BuildContext context, WidgetRef ref) async {
    final clipboardService = ClipboardService();

    try {
      // Get the signature item
      final signaturesAsync = await ref.read(signaturesProvider.future);
      final stampsAsync = await ref.read(stampsProvider.future);
      final allItems = [...signaturesAsync, ...stampsAsync];

      final signatureItem = allItems.firstWhere(
        (item) => item.id == object.signatureId,
        orElse: () => throw Exception('Signature item not found'),
      );

      // Copy image to clipboard
      final success = await clipboardService.copyImage(signatureItem.imageData);

      if (context.mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.copiedToClipboard)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorCopyFailed),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.errorCopyFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildObjectContent(WidgetRef ref) {
    // Get signature item
    final signaturesAsync = ref.watch(signaturesProvider);
    final stampsAsync = ref.watch(stampsProvider);

    SignatureItem? item;

    signaturesAsync.whenData((signatures) {
      try {
        item = signatures.firstWhere((s) => s.id == object.signatureId);
      } catch (_) {}
    });

    if (item == null) {
      stampsAsync.whenData((stamps) {
        try {
          item = stamps.firstWhere((s) => s.id == object.signatureId);
        } catch (_) {}
      });
    }

    if (item != null) {
      return Image.memory(
        Uint8List.fromList(item!.imageData.toList()),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
              item!.name,
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }

    return const Center(child: Icon(Icons.image, size: 24));
  }
}

/// Selection handles widget
class _SelectionHandles extends StatelessWidget {
  final domain.PlacedObject object;
  final double zoomLevel;
  final Function(ResizeHandle, DragStartDetails) onHandleDragStart;
  final Function(ResizeHandle, DragUpdateDetails) onHandleDragUpdate;
  final Function(ResizeHandle, DragEndDetails) onHandleDragEnd;

  const _SelectionHandles({
    required this.object,
    required this.zoomLevel,
    required this.onHandleDragStart,
    required this.onHandleDragUpdate,
    required this.onHandleDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    final screenPos = Offset(
      object.position.dx * zoomLevel,
      object.position.dy * zoomLevel,
    );
    final screenSize = Size(
      object.size.width * zoomLevel,
      object.size.height * zoomLevel,
    );

    return Stack(
      children: [
        // Corner handles
        _buildHandle(ResizeHandle.topLeft, screenPos.translate(-6, -6)),
        _buildHandle(ResizeHandle.topRight, screenPos.translate(screenSize.width - 6, -6)),
        _buildHandle(ResizeHandle.bottomLeft, screenPos.translate(-6, screenSize.height - 6)),
        _buildHandle(ResizeHandle.bottomRight, screenPos.translate(screenSize.width - 6, screenSize.height - 6)),

        // Edge handles
        _buildHandle(ResizeHandle.top, screenPos.translate(screenSize.width / 2 - 6, -6)),
        _buildHandle(ResizeHandle.bottom, screenPos.translate(screenSize.width / 2 - 6, screenSize.height - 6)),
        _buildHandle(ResizeHandle.left, screenPos.translate(-6, screenSize.height / 2 - 6)),
        _buildHandle(ResizeHandle.right, screenPos.translate(screenSize.width - 6, screenSize.height / 2 - 6)),

        // Rotation handle
        _buildRotationHandle(screenPos.translate(screenSize.width / 2 - 12, -AppConstants.rotationHandleDistance)),
      ],
    );
  }

  Widget _buildHandle(ResizeHandle handle, Offset position) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanStart: (details) => onHandleDragStart(handle, details),
        onPanUpdate: (details) => onHandleDragUpdate(handle, details),
        onPanEnd: (details) => onHandleDragEnd(handle, details),
        child: MouseRegion(
          cursor: _getCursor(handle),
          child: Container(
            width: AppConstants.handleSize,
            height: AppConstants.handleSize,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFF0066FF), width: 2),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRotationHandle(Offset position) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanStart: (details) => onHandleDragStart(ResizeHandle.rotate, details),
        onPanUpdate: (details) => onHandleDragUpdate(ResizeHandle.rotate, details),
        onPanEnd: (details) => onHandleDragEnd(ResizeHandle.rotate, details),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: AppConstants.rotationHandleSize,
            height: AppConstants.rotationHandleSize,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFF0066FF), width: 2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.rotate_right,
              size: 16,
              color: Color(0xFF0066FF),
            ),
          ),
        ),
      ),
    );
  }

  SystemMouseCursor _getCursor(ResizeHandle handle) {
    switch (handle) {
      case ResizeHandle.topLeft:
      case ResizeHandle.bottomRight:
        return SystemMouseCursors.resizeUpLeftDownRight;
      case ResizeHandle.topRight:
      case ResizeHandle.bottomLeft:
        return SystemMouseCursors.resizeUpRightDownLeft;
      case ResizeHandle.top:
      case ResizeHandle.bottom:
        return SystemMouseCursors.resizeUpDown;
      case ResizeHandle.left:
      case ResizeHandle.right:
        return SystemMouseCursors.resizeLeftRight;
      default:
        return SystemMouseCursors.grab;
    }
  }
}
