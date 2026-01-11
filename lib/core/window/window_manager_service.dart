import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:window_manager/window_manager.dart';

import 'window_arguments.dart';

/// Service for managing multiple windows in the application.
///
/// Handles creation of new PDF viewer windows and window lifecycle.
class WindowManagerService {
  WindowManagerService._();

  static final WindowManagerService instance = WindowManagerService._();

  /// Tracks IDs of currently open PDF viewer windows.
  final Set<String> _openWindows = {};

  /// Gets the set of currently open window IDs.
  Set<String> get openWindows => Set.unmodifiable(_openWindows);

  /// Initializes the window manager for the main window.
  Future<void> initializeMainWindow() async {
    await windowManager.ensureInitialized();

    final windowOptions = WindowOptions(
      size: const Size(900, 700),
      minimumSize: const Size(600, 400),
      center: true,
      backgroundColor: const Color(0xFFE5E5E5),
      titleBarStyle: TitleBarStyle.normal,
      title: 'PDFSign',
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  /// Initializes a sub-window (PDF viewer window).
  Future<void> initializeSubWindow({required String title}) async {
    await windowManager.ensureInitialized();
    await windowManager.setTitle(title);
  }

  /// Creates a new window to display a PDF file.
  ///
  /// Returns the window ID if successful, null otherwise.
  Future<String?> createPdfWindow(String filePath) async {
    try {
      final fileName = path.basename(filePath);

      final arguments = WindowArguments.pdfViewer(
        filePath: filePath,
        fileName: fileName,
      );

      final configuration = WindowConfiguration(
        arguments: arguments.toJson(),
        hiddenAtLaunch: false,
      );

      final window = await WindowController.create(configuration);

      final windowId = window.windowId;
      _openWindows.add(windowId);

      // Show the window
      await window.show();

      if (kDebugMode) {
        print('Created PDF window $windowId for: $filePath');
      }

      return windowId;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to create PDF window: $e');
      }
      return null;
    }
  }

  /// Registers a window as open.
  void registerWindow(String windowId) {
    _openWindows.add(windowId);
  }

  /// Unregisters a window when it closes.
  void unregisterWindow(String windowId) {
    _openWindows.remove(windowId);
  }

  /// Checks if there are any open PDF viewer windows.
  bool get hasOpenWindows => _openWindows.isNotEmpty;

  /// Closes all open PDF viewer windows.
  Future<void> closeAllWindows() async {
    final windowIds = List<String>.from(_openWindows);
    for (final windowId in windowIds) {
      try {
        final controller = WindowController.fromWindowId(windowId);
        await controller.hide();
      } catch (_) {
        // Window may already be closed
      }
    }
    _openWindows.clear();
  }

  /// Closes the current window.
  Future<void> closeCurrentWindow() async {
    final controller = await WindowController.fromCurrentEngine();
    if (controller.windowId == '0') {
      // Main window - exit app
      exit(0);
    } else {
      // Sub window - just hide it
      await controller.hide();
    }
  }

  /// Gets all window controllers.
  Future<List<WindowController>> getAllWindows() async {
    return WindowController.getAll();
  }
}
