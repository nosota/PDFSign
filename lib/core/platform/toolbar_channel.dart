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

  /// Sets the visibility of the Delete button in the toolbar.
  ///
  /// The Delete button should be visible only when an object is selected.
  /// Pass [label] and [tooltip] to set localized texts.
  static Future<void> setDeleteButtonVisible(
    bool visible, {
    String? label,
    String? tooltip,
  }) async {
    try {
      await _channel.invokeMethod('setDeleteButtonVisible', {
        'visible': visible,
        'label': label,
        'tooltip': tooltip,
      });
    } catch (e) {
      if (kDebugMode) {
        print('ToolbarChannel: Failed to set delete button visibility: $e');
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
      default:
        if (kDebugMode) {
          print('ToolbarChannel: Unknown method ${call.method}');
        }
    }
  }
}
