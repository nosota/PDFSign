import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';

/// Callback for adding a file to recent files.
typedef AddRecentFileCallback = Future<void> Function(RecentFile file);

/// Handles file open requests from macOS Finder.
///
/// When user opens PDF via Finder (double-click, "Open With", drag to Dock),
/// macOS sends the file path to this handler via platform channel.
class FileOpenHandler {
  FileOpenHandler._();

  static const _channel = MethodChannel('com.pdfsign/file_handler');
  static bool _initialized = false;
  static AddRecentFileCallback? _addRecentFileCallback;

  /// Initializes the file open handler.
  ///
  /// Call this once from WelcomeApp.initState() after Flutter is ready.
  /// [addRecentFile] callback is used to add opened files to recent files list.
  static Future<void> init({
    required AddRecentFileCallback addRecentFile,
  }) async {
    print('>>> FileOpenHandler.init() called, _initialized: $_initialized');
    if (_initialized) {
      print('>>> FileOpenHandler.init() - already initialized, returning');
      return;
    }
    _initialized = true;
    _addRecentFileCallback = addRecentFile;

    // Set up handler for incoming file open requests from macOS
    print('>>> FileOpenHandler.init() - setting up method call handler');
    _channel.setMethodCallHandler(_handleMethodCall);

    // Signal to macOS that Flutter is ready to receive files
    print('>>> FileOpenHandler.init() - sending ready signal to macOS');
    try {
      await _channel.invokeMethod('ready');
      print('>>> FileOpenHandler.init() - ready signal sent successfully');
    } catch (e) {
      print('>>> FileOpenHandler.init() - failed to signal ready: $e');
    }
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    print('>>> FileOpenHandler._handleMethodCall: ${call.method}');
    print('>>> Arguments: ${call.arguments}');

    switch (call.method) {
      case 'openFile':
        final filePath = call.arguments as String;
        print('>>> FileOpenHandler: received openFile for: $filePath');
        await _openFile(filePath);
        return null;

      default:
        print('>>> FileOpenHandler: unknown method ${call.method}');
        throw PlatformException(
          code: 'UNSUPPORTED',
          message: 'Method ${call.method} not supported',
        );
    }
  }

  static Future<void> _openFile(String filePath) async {
    print('>>> FileOpenHandler._openFile: $filePath');

    // Validate file exists
    final file = File(filePath);
    final exists = await file.exists();
    print('>>> File exists: $exists');
    if (!exists) {
      print('>>> FileOpenHandler: file does not exist, returning');
      return;
    }

    // Validate it's a PDF
    if (!filePath.toLowerCase().endsWith('.pdf')) {
      print('>>> FileOpenHandler: not a PDF file, returning');
      return;
    }

    // Add to recent files
    final fileName = filePath.split('/').last;
    print('>>> FileOpenHandler: adding to recent files: $fileName');
    if (_addRecentFileCallback != null) {
      try {
        await _addRecentFileCallback!(
          RecentFile(
            path: filePath,
            fileName: fileName,
            lastOpened: DateTime.now(),
            pageCount: 0,
            isPasswordProtected: false,
          ),
        );
        print('>>> FileOpenHandler: added to recent files successfully');
      } catch (e) {
        print('>>> FileOpenHandler: failed to add to recent files: $e');
      }
    } else {
      print('>>> FileOpenHandler: _addRecentFileCallback is null!');
    }

    // Open in new window (or focus existing if already open)
    print('>>> FileOpenHandler: calling createPdfWindow');
    await WindowManagerService.instance.createPdfWindow(filePath);
    print('>>> FileOpenHandler: createPdfWindow completed');
  }
}
