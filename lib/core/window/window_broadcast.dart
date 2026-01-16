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
  static bool _initialized = false;

  /// Sets callback for when size unit changes in another window.
  static void setOnUnitChanged(VoidCallback? callback) {
    _onUnitChanged = callback;
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
            await window.invokeMethod('unitChanged', null);
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
      default:
        return null;
    }
  }
}
