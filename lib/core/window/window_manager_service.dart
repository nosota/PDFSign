import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:window_manager/window_manager.dart';

import 'window_arguments.dart';

/// Extension to add close functionality to WindowController.
/// The desktop_multi_window package doesn't provide a built-in close method.
extension WindowControllerClose on WindowController {
  /// Closes this window by invoking the native close method.
  Future<void> close() {
    return invokeMethod('window_close');
  }
}

/// Service for managing multiple windows in the application.
///
/// Handles creation of new PDF viewer windows and window lifecycle.
class WindowManagerService {
  WindowManagerService._();

  static final WindowManagerService instance = WindowManagerService._();

  /// Tracks IDs of currently open PDF viewer windows.
  final Set<String> _openWindows = {};

  /// Tracks the ID of the currently open Settings window (singleton).
  String? _settingsWindowId;

  /// Flag to prevent race condition when creating Settings window.
  bool _isCreatingSettingsWindow = false;

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

  /// Initializes the settings window with fixed size.
  ///
  /// Settings window: 650x500, not resizable, no minimize button.
  Future<void> initializeSettingsWindow({required String title}) async {
    await windowManager.ensureInitialized();

    const windowSize = Size(650, 500);

    await windowManager.setTitle(title);
    await windowManager.setSize(windowSize);
    await windowManager.setMinimumSize(windowSize);
    await windowManager.setMaximumSize(windowSize);
    await windowManager.setResizable(false);
    await windowManager.setMinimizable(false);
    await windowManager.center();
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

  /// Creates or focuses the Settings window (singleton pattern).
  ///
  /// If Settings window is already open, focuses it and returns its ID.
  /// Otherwise creates a new Settings window.
  /// Returns the window ID if successful, null otherwise.
  Future<String?> createSettingsWindow() async {
    // Prevent race condition: if already creating, return null
    if (_isCreatingSettingsWindow) {
      if (kDebugMode) {
        print('Settings window creation already in progress, ignoring');
      }
      return null;
    }

    // Set flag IMMEDIATELY before ANY async operation to prevent race condition
    _isCreatingSettingsWindow = true;

    try {
      // Check if Settings window already exists and is still alive
      if (_settingsWindowId != null) {
        final stillExists = await _isSettingsWindowAlive();
        if (stillExists) {
          // Window exists, bring it to front
          await _bringSettingsWindowToFront();
          return _settingsWindowId;
        }
        // Window was closed, reset state
        _settingsWindowId = null;
      }
      final arguments = WindowArguments.settings();

      final configuration = WindowConfiguration(
        arguments: arguments.toJson(),
        hiddenAtLaunch: false,
      );

      final window = await WindowController.create(configuration);
      _settingsWindowId = window.windowId;

      // Show the window
      await window.show();

      if (kDebugMode) {
        print('Created settings window $_settingsWindowId');
      }

      return _settingsWindowId;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to create settings window: $e');
      }
      return null;
    } finally {
      _isCreatingSettingsWindow = false;
    }
  }

  /// Checks if the Settings window is still alive by querying all windows.
  Future<bool> _isSettingsWindowAlive() async {
    if (_settingsWindowId == null) return false;

    try {
      // Get all currently open windows
      final allWindows = await WindowController.getAll();
      final allWindowIds = allWindows.map((w) => w.windowId).toList();

      final exists = allWindowIds.contains(_settingsWindowId);

      if (kDebugMode) {
        print(
          'Settings window $_settingsWindowId exists: $exists '
          '(all windows: $allWindowIds)',
        );
      }

      return exists;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if settings window exists: $e');
      }
      return false;
    }
  }

  /// Clears the Settings window ID when the window is closed.
  void clearSettingsWindowId() {
    _settingsWindowId = null;
    if (kDebugMode) {
      print('Settings window ID cleared');
    }
  }

  /// Brings the existing Settings window to front.
  Future<void> _bringSettingsWindowToFront() async {
    if (_settingsWindowId == null) return;

    try {
      final window = WindowController.fromWindowId(_settingsWindowId!);
      await window.show();

      if (kDebugMode) {
        print('Brought settings window to front: $_settingsWindowId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error bringing settings window to front: $e');
      }
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
      // Sub window - close it properly using the extension method
      await controller.close();
    }
  }

  /// Gets all window controllers.
  Future<List<WindowController>> getAllWindows() async {
    return WindowController.getAll();
  }
}
