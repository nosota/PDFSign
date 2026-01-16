import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service for broadcasting messages between windows.
///
/// Uses desktop_multi_window's native inter-window communication
/// which is reliable across different Flutter engines.
class WindowBroadcast {
  WindowBroadcast._();

  static VoidCallback? _onUnitChanged;
  static VoidCallback? _onLocaleChanged;
  static bool _initialized = false;

  /// Sets callback for when size unit changes in another window.
  static void setOnUnitChanged(VoidCallback? callback) {
    _onUnitChanged = callback;
  }

  /// Sets callback for when locale changes in another window.
  static void setOnLocaleChanged(VoidCallback? callback) {
    _onLocaleChanged = callback;
  }

  /// Initializes the broadcast listener for this window.
  ///
  /// Must be called once during window startup to receive broadcasts.
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    try {
      final currentWindow = await WindowController.fromCurrentEngine();
      await currentWindow.setWindowMethodHandler(_handleMethodCall);
    } catch (e) {
      if (kDebugMode) {
        print('WindowBroadcast: Failed to init: $e');
      }
    }
  }

  /// Broadcasts that size unit preference changed to all other windows.
  static Future<void> broadcastUnitChanged() async {
    await _broadcast('unitChanged');
  }

  /// Broadcasts that locale preference changed to all other windows.
  static Future<void> broadcastLocaleChanged() async {
    await _broadcast('localeChanged');
  }

  /// Internal method to broadcast a message to all other windows.
  static Future<void> _broadcast(String method) async {
    try {
      // Get all windows
      final allWindows = await WindowController.getAll();

      // Get current window ID to exclude self
      final currentWindow = await WindowController.fromCurrentEngine();
      final currentId = currentWindow.windowId;

      // Send to all other windows
      for (final window in allWindows) {
        if (window.windowId != currentId) {
          try {
            await window.invokeMethod(method, null);
          } catch (e) {
            // Window may be closed or not ready, ignore
            if (kDebugMode) {
              print(
                'WindowBroadcast: Failed to notify window ${window.windowId}: $e',
              );
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('WindowBroadcast: Failed to broadcast: $e');
      }
    }
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'unitChanged':
        _onUnitChanged?.call();
        return null;
      case 'localeChanged':
        _onLocaleChanged?.call();
        return null;
      default:
        return null;
    }
  }
}
