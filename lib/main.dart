import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/core/router/app_router.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Set Syncfusion license key
  // SyncfusionLicense.registerLicense(AppConstants.syncfusionLicenseKey);

  runApp(
    // Wrap the entire app with ProviderScope for Riverpod
    const ProviderScope(
      child: PDFSignApp(),
    ),
  );
}

/// Root application widget
class PDFSignApp extends StatelessWidget {
  const PDFSignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,

      // Localization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ru'), // Russian
      ],

      // Routing
      routerConfig: AppRouter.router,
    );
  }
}
