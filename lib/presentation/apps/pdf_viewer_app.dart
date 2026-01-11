import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/editor_screen.dart';
import 'package:pdfsign/presentation/widgets/menus/app_menu_bar.dart';

/// Root app widget for PDF viewer windows (sub windows).
///
/// Each PDF viewer window displays a single PDF document.
/// Includes File menu with Open, Open Recent, Share, Close Window.
class PdfViewerApp extends ConsumerWidget {
  const PdfViewerApp({
    required this.filePath,
    required this.fileName,
    super.key,
  });

  /// Path to the PDF file to display.
  final String filePath;

  /// Name of the PDF file (for window title).
  final String fileName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppMenuBar(
      // PDF viewer has Share functionality
      includeShare: true,
      onShare: () => _handleShare(),
      child: MaterialApp(
        title: fileName,
        theme: createAppTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: EditorScreen(filePath: filePath),
      ),
    );
  }

  Future<void> _handleShare() async {
    if (filePath.isNotEmpty) {
      final file = XFile(filePath);
      await Share.shareXFiles([file]);
    }
  }
}
