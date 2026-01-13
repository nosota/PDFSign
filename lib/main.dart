import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pdfsign/core/window/window_arguments.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/data/models/sidebar_image_model.dart';
import 'package:pdfsign/presentation/apps/pdf_viewer_app.dart';
import 'package:pdfsign/presentation/apps/welcome_app.dart';
import 'package:pdfsign/presentation/providers/data_source_providers.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';

/// Application entry point.
///
/// Handles multi-window support:
/// - Main window (no args) → Welcome Screen
/// - Sub windows (with args) → PDF Viewer with file
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Main window has no args, sub-windows receive JSON args from desktop_multi_window
  if (args.isEmpty) {
    // Main window → Welcome Screen
    await _runWelcomeWindow();
  } else {
    // Sub window → PDF Viewer
    final controller = await WindowController.fromCurrentEngine();
    await _runPdfViewerWindow(controller);
  }
}

/// Initializes shared Isar database.
///
/// All windows share the same database file for instant sync.
Future<Isar> _initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [SidebarImageModelSchema],
    directory: dir.path,
    name: 'pdfsign',
  );
}

/// Runs the welcome window (main window).
Future<void> _runWelcomeWindow() async {
  // Initialize window manager for main window
  await WindowManagerService.instance.initializeMainWindow();

  // Pre-initialize dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  final isar = await _initializeIsar();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
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

  // Pre-initialize dependencies
  final sharedPrefs = await SharedPreferences.getInstance();
  final isar = await _initializeIsar();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
      ],
      child: PdfViewerApp(
        filePath: arguments.filePath ?? '',
        fileName: arguments.fileName ?? 'PDF Viewer',
      ),
    ),
  );
}
