import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdfsign/core/router/app_router.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';

/// Application entry point.
///
/// Pre-initializes SharedPreferences before building the widget tree
/// to avoid async loading states in the UI.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Pre-initialize SharedPreferences
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Override the provider with pre-loaded instance
        sharedPreferencesProvider.overrideWith(
          (ref) => Future.value(sharedPrefs),
        ),
      ],
      child: const PDFSignApp(),
    ),
  );
}

/// Root application widget.
class PDFSignApp extends ConsumerWidget {
  const PDFSignApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'PDFSign',
      theme: createAppTheme(),
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
