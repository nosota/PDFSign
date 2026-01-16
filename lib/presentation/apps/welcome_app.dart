import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/core/window/window_broadcast.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/locale_preference_provider.dart';
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

class _WelcomeAppState extends ConsumerState<WelcomeApp> {
  /// Navigator key for showing dialogs from menu callbacks.
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _initWindowBroadcast();
  }

  /// Initializes window broadcast for receiving preference change notifications.
  Future<void> _initWindowBroadcast() async {
    WindowBroadcast.setOnLocaleChanged(_handleLocaleChanged);
    await WindowBroadcast.init();
  }

  /// Handles locale changed broadcast from another window.
  void _handleLocaleChanged() {
    ref.read(localePreferenceProvider.notifier).reload();
  }

  @override
  void dispose() {
    WindowBroadcast.setOnLocaleChanged(null);
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
        final l10n = AppLocalizations.of(context)!;
        return AppMenuBar(
          localizations: l10n,
          navigatorKey: _navigatorKey,
          // Welcome screen doesn't have Save or Share functionality
          includeSaveMenu: false,
          includeShare: false,
          onFileOpened: () => windowManager.hide(),
          child: child!,
        );
      },
      home: const WelcomeScreen(),
    );
  }
}
