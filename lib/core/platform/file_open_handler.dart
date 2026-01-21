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
    if (_initialized) return;
    _initialized = true;
    _addRecentFileCallback = addRecentFile;

    // Set up handler for incoming file open requests from macOS
    _channel.setMethodCallHandler(_handleMethodCall);

    // Signal to macOS that Flutter is ready to receive files
    try {
      await _channel.invokeMethod('ready');
      if (kDebugMode) {
        print('FileOpenHandler: signaled ready to macOS');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FileOpenHandler: failed to signal ready: $e');
      }
    }
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'openFile':
        final filePath = call.arguments as String;
        await _openFile(filePath);
        return null;

      default:
        throw PlatformException(
          code: 'UNSUPPORTED',
          message: 'Method ${call.method} not supported',
        );
    }
  }

  static Future<void> _openFile(String filePath) async {
    if (kDebugMode) {
      print('FileOpenHandler: opening file: $filePath');
    }

    // Validate file exists
    final file = File(filePath);
    if (!await file.exists()) {
      if (kDebugMode) {
        print('FileOpenHandler: file does not exist: $filePath');
      }
      return;
    }

    // Validate it's a PDF
    if (!filePath.toLowerCase().endsWith('.pdf')) {
      if (kDebugMode) {
        print('FileOpenHandler: not a PDF file: $filePath');
      }
      return;
    }

    // Add to recent files
    final fileName = filePath.split('/').last;
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
      } catch (e) {
        if (kDebugMode) {
          print('FileOpenHandler: failed to add to recent files: $e');
        }
      }
    }

    // Open in new window (or focus existing if already open)
    await WindowManagerService.instance.createPdfWindow(filePath);
  }
}
