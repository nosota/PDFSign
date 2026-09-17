import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Platform channel for communicating with native macOS toolbar.
///
/// Handles toolbar button actions from Swift side.
class ToolbarChannel {
  ToolbarChannel._();

  static const _channel = MethodChannel('com.pdfsign/toolbar');
  static VoidCallback? _onSharePressed;
  static VoidCallback? _onDeletePressed;
  static VoidCallback? _onRotateLeftPressed;
  static VoidCallback? _onRotateRightPressed;
  /// One callback per direction the selected object can be restacked.
  ///
  /// Keyed by the order the segments sit in: to the back, back one, forward
  /// one, to the front.
  static final List<VoidCallback?> _onRestack = List.filled(4, null);
  static VoidCallback? _onUndoPressed;
  static VoidCallback? _onRedoPressed;
  static bool _initialized = false;

  /// Initializes the toolbar channel.
  ///
  /// Should be called once during app startup.
  static void init() {
    if (_initialized) return;
    _initialized = true;
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  /// Sets the callback for when Share button is pressed in toolbar.
  ///
  /// Pass null to unregister the callback.
  static void setOnSharePressed(VoidCallback? callback) {
    _onSharePressed = callback;
  }

  /// Sets the callback for when Delete button is pressed in toolbar.
  ///
  /// Pass null to unregister the callback.
  static void setOnDeletePressed(VoidCallback? callback) {
    _onDeletePressed = callback;
  }

  /// Sets the callback for when Rotate Left is pressed in the toolbar.
  ///
  /// Pass null to unregister the callback.
  static void setOnRotateLeftPressed(VoidCallback? callback) {
    _onRotateLeftPressed = callback;
  }

  /// Sets the callback for when Rotate Right is pressed in the toolbar.
  ///
  /// Pass null to unregister the callback.
  static void setOnRotateRightPressed(VoidCallback? callback) {
    _onRotateRightPressed = callback;
  }

  /// Sets the callbacks for the two halves of the undo control.
  static void setOnHistoryPressed({
    VoidCallback? undo,
    VoidCallback? redo,
  }) {
    _onUndoPressed = undo;
    _onRedoPressed = redo;
  }

  /// Greys each half of the undo control out on its own.
  ///
  /// A document can have somewhere to go back to and nowhere to come forward
  /// from, so the two are set together but stand apart.
  static Future<void> setHistoryEnabled({
    required bool canUndo,
    required bool canRedo,
    List<String>? labels,
  }) async {
    try {
      await _channel.invokeMethod('setHistoryEnabled', {
        'canUndo': canUndo,
        'canRedo': canRedo,
        if (labels != null) 'labels': labels,
      });
    } catch (e) {
      if (kDebugMode) {
        print('ToolbarChannel: Failed to set history enabled: $e');
      }
    }
  }

  /// Sets the callbacks for the four restacking segments, in the order they
  /// sit in the control: to the back, back one, forward one, to the front.
  static void setOnRestackPressed(List<VoidCallback?> callbacks) {
    for (var i = 0; i < _onRestack.length; i++) {
      _onRestack[i] = i < callbacks.length ? callbacks[i] : null;
    }
  }

  /// Greys the restacking control out when nothing is selected.
  ///
  /// [labels] are the four segment names, in the same order.
  static Future<void> setZOrderEnabled(
    bool enabled, {
    List<String>? labels,
    String? groupLabel,
  }) async {
    try {
      await _channel.invokeMethod('setZOrderEnabled', {
        'enabled': enabled,
        if (labels != null) 'labels': labels,
        if (groupLabel != null) 'groupLabel': groupLabel,
      });
    } catch (e) {
      if (kDebugMode) {
        print('ToolbarChannel: Failed to set z-order enabled: $e');
      }
    }
  }

  /// Sets the localized texts of the rotate control.
  ///
  /// The toolbar is built before Flutter has resolved a locale, so it starts
  /// with English texts and is corrected here — on setup and whenever the
  /// language changes.
  static Future<void> setRotateLabels({
    required String left,
    required String right,
  }) async {
    try {
      await _channel.invokeMethod('setRotateLabels', {
        'left': left,
        'right': right,
      });
    } catch (e) {
      if (kDebugMode) {
        print('ToolbarChannel: Failed to set rotate labels: $e');
      }
    }
  }

  /// Enables or disables the Delete button in the toolbar.
  ///
  /// The button is always in the toolbar and is greyed out when nothing is
  /// selected. Taking it away instead would move the controls beside it every
  /// time the selection changed.
  ///
  /// Pass [label] and [tooltip] to set localized texts.
  static Future<void> setDeleteButtonEnabled(
    bool enabled, {
    String? label,
    String? tooltip,
  }) async {
    try {
      await _channel.invokeMethod('setDeleteButtonEnabled', {
        'enabled': enabled,
        'label': label,
        'tooltip': tooltip,
      });
    } catch (e) {
      if (kDebugMode) {
        print('ToolbarChannel: Failed to set delete button state: $e');
      }
    }
  }

  /// Requests native toolbar setup for this window.
  ///
  /// Should be called only for PDF viewer windows that need the toolbar.
  /// Settings and other windows should NOT call this method.
  static Future<void> setupToolbar() async {
    if (kDebugMode) {
      print('ToolbarChannel: calling setupToolbar...');
    }
    try {
      await _channel.invokeMethod('setupToolbar');
      if (kDebugMode) {
        print('ToolbarChannel: setupToolbar call completed');
      }
    } catch (e) {
      if (kDebugMode) {
        print('ToolbarChannel: Failed to setup toolbar: $e');
      }
    }
  }

  static Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onSharePressed':
        _onSharePressed?.call();
      case 'onDeletePressed':
        _onDeletePressed?.call();
      case 'onRotateLeftPressed':
        _onRotateLeftPressed?.call();
      case 'onRotateRightPressed':
        _onRotateRightPressed?.call();
      case 'onUndoPressed':
        _onUndoPressed?.call();
      case 'onRedoPressed':
        _onRedoPressed?.call();
      case 'onSendToBackPressed':
        _onRestack[0]?.call();
      case 'onSendBackwardPressed':
        _onRestack[1]?.call();
      case 'onBringForwardPressed':
        _onRestack[2]?.call();
      case 'onBringToFrontPressed':
        _onRestack[3]?.call();
      default:
        if (kDebugMode) {
          print('ToolbarChannel: Unknown method ${call.method}');
        }
    }
  }
}
