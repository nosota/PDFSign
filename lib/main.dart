import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/injection/injection_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Set Syncfusion license key
  // SyncfusionLicense.registerLicense(AppConstants.syncfusionLicenseKey);

  // Initialize dependency injection
  await configureDependencies();

  runApp(const PDFSignApp());
}

/// Root application widget
class PDFSignApp extends StatelessWidget {
  const PDFSignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

      // TODO: Configure routing with go_router
      home: const Scaffold(
        body: Center(
          child: Text(
            'PDFSign - Coming Soon',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
