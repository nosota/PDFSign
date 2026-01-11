import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pdfsign/core/window/window_arguments.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:pdfsign/presentation/apps/welcome_app.dart';
import 'package:pdfsign/presentation/apps/pdf_viewer_app.dart';

/// Application entry point.
///
/// Handles multi-window support:
/// - Window ID '0' (main window) → Welcome Screen
/// - Window ID > '0' (sub windows) → PDF Viewer with file
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get current window controller
  final controller = await WindowController.fromCurrentEngine();
  final windowId = controller.windowId;

  if (windowId == '0') {
    // Main window → Welcome Screen
    await _runWelcomeWindow();
  } else {
    // Sub window → PDF Viewer
    await _runPdfViewerWindow(controller);
  }
}

/// Runs the welcome window (main window).
Future<void> _runWelcomeWindow() async {
  // Initialize window manager for main window
  await WindowManagerService.instance.initializeMainWindow();

  // Pre-initialize SharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith(
          (ref) => Future.value(sharedPrefs),
        ),
      ],
      child: const WelcomeApp(),
    ),
  );
}

/// Runs a PDF viewer window (sub window).
Future<void> _runPdfViewerWindow(WindowController controller) async {
  // Get window arguments
  final arguments = WindowArguments.fromJson(controller.arguments);

  // Initialize window for this sub-window
  await WindowManagerService.instance.initializeSubWindow(
    title: arguments.fileName ?? 'PDF Viewer',
  );

  // Pre-initialize SharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWith(
          (ref) => Future.value(sharedPrefs),
        ),
      ],
      child: PdfViewerApp(
        filePath: arguments.filePath ?? '',
        fileName: arguments.fileName ?? 'PDF Viewer',
      ),
    ),
  );
}
