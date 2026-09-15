import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/platform/file_open_handler.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/presentation/apps/close_all_coordinator.dart';
import 'package:pdfsign/core/window/window_broadcast.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:pdfsign/presentation/providers/recent_files_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:pdfsign/presentation/screens/welcome/welcome_screen.dart';
import 'package:pdfsign/presentation/widgets/menus/app_menu_bar.dart';

/// Root app widget for the welcome window (main window).
///
/// Shows the welcome screen with recent files and file picker.
/// Includes File menu with Open, Open Recent, Close Window.
class WelcomeApp extends ConsumerStatefulWidget {
  const WelcomeApp({super.key});

  @override
  ConsumerState<WelcomeApp> createState() => _WelcomeAppState();
}

class _WelcomeAppState extends ConsumerState<WelcomeApp>
    with WindowListener {
  /// Navigator key for showing dialogs from menu callbacks.
  final _navigatorKey = GlobalKey<NavigatorState>();

  /// Whether this window currently has focus.
  /// Only focused window renders PlatformMenuBar to avoid conflicts.
  bool _isWindowFocused = true;

  @override
  void initState() {
    super.initState();
    _initWindowBroadcast();
    _initFileOpenHandler();

    // Register window listener for focus tracking and close interception
    windowManager.addListener(this);
    windowManager.setPreventClose(true);
  }

  /// Initializes file open handler for Finder integration.
  void _initFileOpenHandler() {
    final repository = ref.read(recentFilesRepositoryProvider);
    FileOpenHandler.init(
      recentFilesRepository: repository,
      onHideWelcome: _handleHideWelcome,
    );
  }

  /// Initializes window broadcast for receiving notifications.
  Future<void> _initWindowBroadcast() async {
    WindowBroadcast.setOnLocaleChanged(_handleLocaleChanged);
    WindowBroadcast.setOnHideWelcome(_handleHideWelcome);
    await WindowBroadcast.init();
  }

  /// Handles hide welcome broadcast (sent when PDF opens from any window).
  void _handleHideWelcome() {
    // Stop rendering menu before hiding - otherwise Welcome's menu
    // will conflict with PDF window's menu on first launch from Finder.
    _isWindowFocused = false;
    setState(() {});

    WindowManagerService.instance.setWelcomeHidden();
    windowManager.hide();
  }

  /// Handles locale changed broadcast from another window.
  void _handleLocaleChanged() {
    ref.read(localePreferenceProvider.notifier).reload();
  }

  @override
  void onWindowFocus() async {
    _isWindowFocused = true;
    setState(() {});

    // Reload SharedPreferences from disk to get latest recent files
    // (files may have been opened from Finder while Welcome was hidden)
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.reload();
    // Invalidate provider to re-read from the now-updated cache
    ref.invalidate(recentFilesProvider);
  }

  @override
  void onWindowBlur() {
    _isWindowFocused = false;
    setState(() {});
  }

  /// Handles window close.
  ///
  /// If there are other windows (PDF or Settings), hides Welcome Screen permanently.
  /// If Welcome is the only window, quits the application.
  @override
  void onWindowClose() async {
    final hasOtherWindows = _hasOtherOpenWindows();

    if (hasOtherWindows) {
      // Other windows exist - hide Welcome permanently
      WindowManagerService.instance.setWelcomeHidden();
      await windowManager.hide();
    } else {
      // Welcome is the only window - quit the app
      exit(0);
    }
  }

  /// Checks if there are any other open windows (PDF or Settings).
  bool _hasOtherOpenWindows() {
    final service = WindowManagerService.instance;
    // Check for PDF windows
    if (service.hasOpenWindows) return true;
    // Check for Settings window (need to expose this)
    if (service.hasSettingsWindow) return true;
    return false;
  }

  /// Handles Close All menu action.
  ///
  /// Shows CloseAllDialog if any PDF windows have unsaved changes,
  /// then broadcasts close to all PDF windows.
  /// Closes every PDF window, asking about unsaved work first.
  Future<void> _handleCloseAll() async {
    if (await CloseAllCoordinator(ref: ref, navigatorKey: _navigatorKey)
        .confirm()) {
      await WindowBroadcast.broadcastCloseAll();
    }
  }

  /// Handles Quit command (Cmd+Q).
  ///
  /// Shows CloseAllDialog if any PDF windows have unsaved changes,
  /// then quits the application.
  /// Quits the application, asking about unsaved work first.
  Future<void> _handleQuit() async {
    if (await CloseAllCoordinator(ref: ref, navigatorKey: _navigatorKey)
        .confirm()) {
      exit(0);
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    WindowBroadcast.setOnLocaleChanged(null);
    WindowBroadcast.setOnHideWelcome(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch locale preference for live updates
    ref.watch(localePreferenceProvider);
    final locale = ref.watch(localePreferenceProvider.notifier).getLocale();

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'PDFSign',
      theme: createAppTheme(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: allSupportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Only render PlatformMenuBar when this window has focus.
        // This prevents multiple windows from fighting over the native menu.
        if (!_isWindowFocused) {
          return child!;
        }

        final l10n = AppLocalizations.of(context)!;
        final hasOpenPdfs = WindowManagerService.instance.hasOpenWindows;
        return AppMenuBar(
          localizations: l10n,
          navigatorKey: _navigatorKey,
          // Welcome screen: hide Save, Save As, Save All, and Share
          includeSave: false,
          includeSaveAs: false,
          includeSaveAll: false,
          includeShare: false,
          // Note: Welcome hiding is handled automatically in createPdfWindow()
          // Close All - enabled only if there are PDF windows
          includeCloseAll: true,
          onCloseAll: _handleCloseAll,
          isCloseAllEnabled: hasOpenPdfs,
          // Use windowManager.close() which triggers onWindowClose() to hide
          onCloseWindow: () => windowManager.close(),
          // Quit (Cmd+Q) - check for unsaved changes and exit
          onQuit: _handleQuit,
          child: child!,
        );
      },
      home: const WelcomeScreen(),
    );
  }
}
