import 'dart:ui';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pdfsign/core/window/window_arguments.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/data/models/sidebar_image_model.dart';
import 'package:pdfsign/data/repositories/pasted_image_storage_impl.dart';
import 'package:pdfsign/presentation/apps/pdf_viewer_app.dart';
import 'package:pdfsign/presentation/apps/settings_app.dart';
import 'package:pdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/apps/welcome_app.dart';
import 'package:pdfsign/presentation/providers/data_source_providers.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';

/// Application entry point.
///
/// Handles multi-window support:
/// - Main window (no args) → Welcome Screen
/// - Sub windows (with args) → PDF Viewer, Settings, etc.
Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Main window has no args, sub-windows receive JSON args from desktop_multi_window
  if (args.isEmpty) {
    // Main window → Welcome Screen
    await _runWelcomeWindow();
  } else {
    // Sub window → route based on window type
    final controller = await WindowController.fromCurrentEngine();
    final arguments = WindowArguments.fromJson(controller.arguments);

    switch (arguments.windowType) {
      case WindowType.pdfViewer:
        await _runPdfViewerWindow(controller, arguments);
      case WindowType.settings:
        await _runSettingsWindow();
      case WindowType.welcome:
        // Should not happen, but handle gracefully
        await _runWelcomeWindow();
    }
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

  // Images pasted into a document are stored with it rather than in the
  // library, so nothing owns their files the way a library row does. This is
  // the one moment they can safely be swept: the main window starts before any
  // document window exists, and objects pasted in one window can be copied
  // into another, so the files are shared for the length of a session.
  await PastedImageStorageImpl().clear();

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
Future<void> _runPdfViewerWindow(
  WindowController controller,
  WindowArguments arguments,
) async {
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

/// What the settings window is called, in the reader's language.
///
/// [stored] is the saved language preference; null or `system` means the one
/// the system asks for. A language this app does not have falls back to
/// English, exactly as the rest of the interface does.
Future<String> settingsWindowTitle(String? stored) async {
  final chosen = localeFromPreference(stored) ??
      _supportedSystemLocale() ??
      const Locale('en');
  final localizations = await AppLocalizations.delegate.load(chosen);
  return localizations.settingsTitle;
}

/// The system's locale, if this app speaks it.
Locale? _supportedSystemLocale() {
  final system = PlatformDispatcher.instance.locale;
  for (final supported in allSupportedLocales) {
    if (supported.languageCode == system.languageCode &&
        supported.countryCode == system.countryCode) {
      return supported;
    }
  }
  for (final supported in allSupportedLocales) {
    if (supported.languageCode == system.languageCode) return supported;
  }
  return null;
}

/// Runs a settings window (sub window).
Future<void> _runSettingsWindow() async {
  // The title goes on the window itself, before any widget exists to read a
  // localization from, so the strings are loaded by hand here. Left in
  // English, it was the one word of the window a reader never saw in their
  // own language.
  final sharedPrefs = await SharedPreferences.getInstance();
  final title = await settingsWindowTitle(sharedPrefs.getString(localeKey));

  await WindowManagerService.instance.initializeSettingsWindow(title: title);

  // Pre-initialize dependencies
  final isar = await _initializeIsar();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        isarProvider.overrideWithValue(isar),
      ],
      child: const SettingsApp(),
    ),
  );
}
