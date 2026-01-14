import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:pdfsign/core/platform/toolbar_channel.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/screens/editor/editor_screen.dart';
import 'package:pdfsign/presentation/widgets/menus/app_menu_bar.dart';

/// Root app widget for PDF viewer windows (sub windows).
///
/// Each PDF viewer window displays a single PDF document.
/// Includes File menu with Open, Open Recent, Save, Save As, Share, Close Window.
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

  Future<void> _handleSave() async {
    final placedImages = ref.read(placedImagesProvider);
    if (placedImages.isEmpty) return;

    final saveService = PdfSaveService();
    final result = await saveService.savePdf(
      originalPath: widget.filePath,
      placedImages: placedImages,
    );

    result.fold(
      (failure) {
        // Show error snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Save failed: ${failure.message}')),
          );
        }
      },
      (_) {
        // Mark as clean and clear placed images
        ref.read(documentDirtyProvider.notifier).markClean();
        ref.read(placedImagesProvider.notifier).clear();
        // Reload the document to show the embedded images
        ref.read(pdfDocumentProvider.notifier).reloadDocument();
      },
    );
  }

  Future<void> _handleSaveAs() async {
    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF As',
      fileName: widget.fileName,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (outputPath == null) return;

    final placedImages = ref.read(placedImagesProvider);
    final saveService = PdfSaveService();
    final result = await saveService.savePdf(
      originalPath: widget.filePath,
      placedImages: placedImages,
      outputPath: outputPath,
    );

    result.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Save failed: ${failure.message}')),
          );
        }
      },
      (savedPath) {
        ref.read(documentDirtyProvider.notifier).markClean();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Saved to: $savedPath')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.fileName,
      theme: createAppTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final l10n = AppLocalizations.of(context)!;
        return AppMenuBar(
          localizations: l10n,
          includeSaveMenu: true,
          onSave: _handleSave,
          onSaveAs: _handleSaveAs,
          includeShare: true,
          onShare: _handleShare,
          child: child!,
        );
      },
      home: EditorScreen(filePath: widget.filePath),
    );
  }
}
