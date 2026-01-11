import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/welcome/welcome_screen.dart';
import 'package:pdfsign/presentation/widgets/menus/app_menu_bar.dart';

/// Root app widget for the welcome window (main window).
///
/// Shows the welcome screen with recent files and file picker.
/// Includes File menu with Open, Open Recent, Close Window.
class WelcomeApp extends ConsumerWidget {
  const WelcomeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
      ],
    );

    return AppMenuBar(
      // Welcome screen doesn't have Share functionality
      includeShare: false,
      onFileOpened: () => windowManager.hide(),
      child: MaterialApp.router(
        title: 'PDFSign',
        theme: createAppTheme(),
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
