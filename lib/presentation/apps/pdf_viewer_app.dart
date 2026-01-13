import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pdfsign/core/platform/toolbar_channel.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/screens/editor/editor_screen.dart';
import 'package:pdfsign/presentation/widgets/menus/app_menu_bar.dart';

/// Root app widget for PDF viewer windows (sub windows).
///
/// Each PDF viewer window displays a single PDF document.
/// Includes File menu with Open, Open Recent, Share, Close Window.
/// Has a Share button in the native macOS toolbar.
class PdfViewerApp extends ConsumerStatefulWidget {
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
  ConsumerState<PdfViewerApp> createState() => _PdfViewerAppState();
}

class _PdfViewerAppState extends ConsumerState<PdfViewerApp> {
  @override
  void initState() {
    super.initState();
    // Initialize toolbar channel and register share callback
    ToolbarChannel.init();
    ToolbarChannel.setOnSharePressed(_handleShare);
  }

  @override
  void dispose() {
    // Unregister share callback
    ToolbarChannel.setOnSharePressed(null);
    super.dispose();
  }

  Future<void> _handleShare() async {
    if (widget.filePath.isEmpty) return;

    final placedImages = ref.read(placedImagesProvider);

    if (placedImages.isEmpty) {
      // No changes, share original file
      final file = XFile(widget.filePath);
      await Share.shareXFiles([file]);
      return;
    }

    // Create temp PDF with placed images
    final saveService = PdfSaveService();
    final result = await saveService.createTempPdfWithImages(
      originalPath: widget.filePath,
      placedImages: placedImages,
    );

    await result.fold(
      (failure) async {
        // Show error and share original
        final file = XFile(widget.filePath);
        await Share.shareXFiles([file]);
      },
      (tempPath) async {
        // Share temp file
        final file = XFile(tempPath);
        await Share.shareXFiles([file]);

        // Clean up temp file after a short delay (allow share to complete)
        Future.delayed(const Duration(seconds: 5), () {
          try {
            File(tempPath).deleteSync();
          } catch (_) {
            // Ignore cleanup errors
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppMenuBar(
      // PDF viewer has Share functionality
      includeShare: true,
      onShare: _handleShare,
      child: MaterialApp(
        title: widget.fileName,
        theme: createAppTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        home: EditorScreen(filePath: widget.filePath),
      ),
    );
  }
}
