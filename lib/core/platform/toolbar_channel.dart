import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Platform channel for communicating with native macOS toolbar.
///
/// Handles toolbar button actions from Swift side.
class ToolbarChannel {
  ToolbarChannel._();

  static const _channel = MethodChannel('com.pdfsign/toolbar');
  static VoidCallback? _onSharePressed;
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

  static Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onSharePressed':
        _onSharePressed?.call();
      default:
        if (kDebugMode) {
          print('ToolbarChannel: Unknown method ${call.method}');
        }
    }
  }
}
