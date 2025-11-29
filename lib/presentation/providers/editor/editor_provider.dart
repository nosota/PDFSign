import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/domain/entities/placed_object.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';

part 'editor_provider.g.dart';

/// Command interface for undo/redo pattern
abstract class EditorCommand {
  void execute();
  void undo();
  String get description;
}

/// Editor state
class EditorState {
  final List<PlacedObject> placedObjects;
  final String? selectedObjectId;
  final bool hasUnsavedChanges;

  const EditorState({
    this.placedObjects = const [],
    this.selectedObjectId,
    this.hasUnsavedChanges = false,
  });

  EditorState copyWith({
    List<PlacedObject>? placedObjects,
    String? selectedObjectId,
    bool? clearSelection,
    bool? hasUnsavedChanges,
  }) {
    return EditorState(
      placedObjects: placedObjects ?? this.placedObjects,
      selectedObjectId: clearSelection == true ? null : (selectedObjectId ?? this.selectedObjectId),
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
    );
  }
}

/// Main editor state provider
@riverpod
class Editor extends _$Editor {
  @override
  EditorState build() => const EditorState();

  /// Place object from signature/stamp
  void placeObject({
    required String signatureId,
    required int pageNumber,
    required Offset position,
    required Size size,
    double rotation = 0,
  }) {
    final newObject = PlacedObject(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      signatureId: signatureId,
      pageNumber: pageNumber,
      position: position,
      size: size,
      rotation: rotation,
      zIndex: _getMaxZIndex() + 1,
      placedAt: DateTime.now(),
    );

    _executeCommand(PlaceObjectCommand(
      editor: this,
      object: newObject,
    ));
  }

  /// Select object
  void selectObject(String? objectId) {
    state = state.copyWith(selectedObjectId: objectId);
  }

  /// Deselect all
  void deselectAll() {
    state = state.copyWith(clearSelection: true);
  }

  /// Move selected object
  void moveObject(String objectId, Offset newPosition) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    _executeCommand(MoveObjectCommand(
      editor: this,
      objectId: objectId,
      oldPosition: obj.position,
      newPosition: newPosition,
    ));
  }

  /// Move selected object by delta (for arrow keys)
  void nudgeObject(String objectId, Offset delta) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    final newPosition = obj.position + delta;
    moveObject(objectId, newPosition);
  }

  /// Rotate object
  void rotateObject(String objectId, double angleDelta) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    final newRotation = (obj.rotation + angleDelta) % 360;
    _executeCommand(RotateObjectCommand(
      editor: this,
      objectId: objectId,
      oldRotation: obj.rotation,
      newRotation: newRotation,
    ));
  }

  /// Scale object
  void scaleObject(String objectId, double scaleFactor) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    final newSize = obj.size * scaleFactor;
    if (newSize.width < AppConstants.minObjectSize ||
        newSize.height < AppConstants.minObjectSize) {
      return;
    }

    _executeCommand(ScaleObjectCommand(
      editor: this,
      objectId: objectId,
      oldSize: obj.size,
      newSize: newSize,
    ));
  }

  /// Resize object (free scaling)
  void resizeObject(String objectId, Size newSize) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    if (newSize.width < AppConstants.minObjectSize ||
        newSize.height < AppConstants.minObjectSize) {
      return;
    }

    _executeCommand(ResizeObjectCommand(
      editor: this,
      objectId: objectId,
      oldSize: obj.size,
      newSize: newSize,
    ));
  }

  /// Delete object
  void deleteObject(String objectId) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    _executeCommand(DeleteObjectCommand(
      editor: this,
      object: obj,
    ));

    // Deselect if this object was selected
    if (state.selectedObjectId == objectId) {
      deselectAll();
    }
  }

  /// Duplicate object (Ctrl+D)
  void duplicateObject(String objectId) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    // Offset the duplicate slightly
    const offsetX = 20.0;
    const offsetY = 20.0;

    final duplicate = PlacedObject(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      signatureId: obj.signatureId,
      pageNumber: obj.pageNumber,
      position: Offset(obj.position.dx + offsetX, obj.position.dy + offsetY),
      size: obj.size,
      rotation: obj.rotation,
      zIndex: _getMaxZIndex() + 1,
      placedAt: DateTime.now(),
    );

    _executeCommand(PlaceObjectCommand(
      editor: this,
      object: duplicate,
    ));

    // Select the duplicate
    selectObject(duplicate.id);
  }

  /// Change z-order
  void bringToFront(String objectId) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    final maxZ = _getMaxZIndex();
    if (obj.zIndex >= maxZ) return;

    _executeCommand(ChangeZIndexCommand(
      editor: this,
      objectId: objectId,
      oldZIndex: obj.zIndex,
      newZIndex: maxZ + 1,
    ));
  }

  void sendToBack(String objectId) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    if (obj.zIndex <= AppConstants.minZIndex) return;

    // Increment all other objects' z-index
    final newObjects = state.placedObjects.map((o) {
      if (o.id == objectId) {
        return o.copyWith(zIndex: AppConstants.minZIndex);
      } else {
        return o.copyWith(zIndex: o.zIndex + 1);
      }
    }).toList();

    _updateObjects(newObjects);
  }

  void bringForward(String objectId) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    // Find next higher z-index
    final higherObjects = state.placedObjects
        .where((o) => o.zIndex > obj.zIndex)
        .toList()
      ..sort((a, b) => a.zIndex.compareTo(b.zIndex));

    if (higherObjects.isEmpty) return;

    final nextObj = higherObjects.first;
    _swapZIndex(objectId, nextObj.id);
  }

  void sendBackward(String objectId) {
    final obj = _findObject(objectId);
    if (obj == null) return;

    // Find next lower z-index
    final lowerObjects = state.placedObjects
        .where((o) => o.zIndex < obj.zIndex)
        .toList()
      ..sort((a, b) => b.zIndex.compareTo(a.zIndex));

    if (lowerObjects.isEmpty) return;

    final nextObj = lowerObjects.first;
    _swapZIndex(objectId, nextObj.id);
  }

  /// Clear all objects
  void clearAll() {
    state = const EditorState();
    ref.read(undoRedoProvider.notifier).clear();
  }

  // Helper methods
  PlacedObject? _findObject(String id) {
    try {
      return state.placedObjects.firstWhere((obj) => obj.id == id);
    } catch (_) {
      return null;
    }
  }

  int _getMaxZIndex() {
    if (state.placedObjects.isEmpty) return AppConstants.minZIndex;
    return state.placedObjects.map((o) => o.zIndex).reduce((a, b) => a > b ? a : b);
  }

  void _swapZIndex(String id1, String id2) {
    final obj1 = _findObject(id1);
    final obj2 = _findObject(id2);
    if (obj1 == null || obj2 == null) return;

    final z1 = obj1.zIndex;
    final z2 = obj2.zIndex;

    final newObjects = state.placedObjects.map((o) {
      if (o.id == id1) return o.copyWith(zIndex: z2);
      if (o.id == id2) return o.copyWith(zIndex: z1);
      return o;
    }).toList();

    _updateObjects(newObjects);
  }

  void _updateObjects(List<PlacedObject> objects) {
    state = state.copyWith(
      placedObjects: objects,
      hasUnsavedChanges: true,
    );
  }

  void _executeCommand(EditorCommand command) {
    command.execute();
    ref.read(undoRedoProvider.notifier).addCommand(command);
  }

  // Methods called by commands (not exposed publicly)
  void addObjectInternal(PlacedObject object) {
    _updateObjects([...state.placedObjects, object]);
  }

  void removeObjectInternal(String objectId) {
    _updateObjects(
      state.placedObjects.where((obj) => obj.id != objectId).toList(),
    );
  }

  void updateObjectInternal(String objectId, PlacedObject updatedObject) {
    _updateObjects(
      state.placedObjects
          .map((obj) => obj.id == objectId ? updatedObject : obj)
          .toList(),
    );
  }
}

/// Undo/Redo provider
@riverpod
class UndoRedo extends _$UndoRedo {
  final List<EditorCommand> _undoStack = [];
  final List<EditorCommand> _redoStack = [];

  @override
  ({bool canUndo, bool canRedo, String? lastCommand}) build() {
    return (canUndo: false, canRedo: false, lastCommand: null);
  }

  void addCommand(EditorCommand command) {
    _undoStack.add(command);
    _redoStack.clear();

    // Limit stack size
    if (_undoStack.length > AppConstants.maxUndoStackSize) {
      _undoStack.removeAt(0);
    }

    _updateState();
  }

  void undo() {
    if (_undoStack.isEmpty) return;

    final command = _undoStack.removeLast();
    command.undo();
    _redoStack.add(command);

    _updateState();
  }

  void redo() {
    if (_redoStack.isEmpty) return;

    final command = _redoStack.removeLast();
    command.execute();
    _undoStack.add(command);

    _updateState();
  }

  void clear() {
    _undoStack.clear();
    _redoStack.clear();
    _updateState();
  }

  void _updateState() {
    state = (
      canUndo: _undoStack.isNotEmpty,
      canRedo: _redoStack.isNotEmpty,
      lastCommand: _undoStack.isNotEmpty ? _undoStack.last.description : null,
    );
  }
}

// ==================== Commands ====================

class PlaceObjectCommand implements EditorCommand {
  final Editor editor;
  final PlacedObject object;

  PlaceObjectCommand({required this.editor, required this.object});

  @override
  void execute() => editor.addObjectInternal(object);

  @override
  void undo() => editor.removeObjectInternal(object.id);

  @override
  String get description => 'Place object';
}

class DeleteObjectCommand implements EditorCommand {
  final Editor editor;
  final PlacedObject object;

  DeleteObjectCommand({required this.editor, required this.object});

  @override
  void execute() => editor.removeObjectInternal(object.id);

  @override
  void undo() => editor.addObjectInternal(object);

  @override
  String get description => 'Delete object';
}

class MoveObjectCommand implements EditorCommand {
  final Editor editor;
  final String objectId;
  final Offset oldPosition;
  final Offset newPosition;

  MoveObjectCommand({
    required this.editor,
    required this.objectId,
    required this.oldPosition,
    required this.newPosition,
  });

  @override
  void execute() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(position: newPosition),
      );
    }
  }

  @override
  void undo() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(position: oldPosition),
      );
    }
  }

  @override
  String get description => 'Move object';
}

class RotateObjectCommand implements EditorCommand {
  final Editor editor;
  final String objectId;
  final double oldRotation;
  final double newRotation;

  RotateObjectCommand({
    required this.editor,
    required this.objectId,
    required this.oldRotation,
    required this.newRotation,
  });

  @override
  void execute() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(rotation: newRotation),
      );
    }
  }

  @override
  void undo() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(rotation: oldRotation),
      );
    }
  }

  @override
  String get description => 'Rotate object';
}

class ScaleObjectCommand implements EditorCommand {
  final Editor editor;
  final String objectId;
  final Size oldSize;
  final Size newSize;

  ScaleObjectCommand({
    required this.editor,
    required this.objectId,
    required this.oldSize,
    required this.newSize,
  });

  @override
  void execute() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(size: newSize),
      );
    }
  }

  @override
  void undo() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(size: oldSize),
      );
    }
  }

  @override
  String get description => 'Scale object';
}

class ResizeObjectCommand implements EditorCommand {
  final Editor editor;
  final String objectId;
  final Size oldSize;
  final Size newSize;

  ResizeObjectCommand({
    required this.editor,
    required this.objectId,
    required this.oldSize,
    required this.newSize,
  });

  @override
  void execute() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(size: newSize),
      );
    }
  }

  @override
  void undo() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(size: oldSize),
      );
    }
  }

  @override
  String get description => 'Resize object';
}

class ChangeZIndexCommand implements EditorCommand {
  final Editor editor;
  final String objectId;
  final int oldZIndex;
  final int newZIndex;

  ChangeZIndexCommand({
    required this.editor,
    required this.objectId,
    required this.oldZIndex,
    required this.newZIndex,
  });

  @override
  void execute() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(zIndex: newZIndex),
      );
    }
  }

  @override
  void undo() {
    final obj = editor._findObject(objectId);
    if (obj != null) {
      editor.updateObjectInternal(
        objectId,
        obj.copyWith(zIndex: oldZIndex),
      );
    }
  }

  @override
  String get description => 'Change z-order';
}
