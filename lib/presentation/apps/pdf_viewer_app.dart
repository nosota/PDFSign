import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/platform/toolbar_channel.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/core/window/window_broadcast.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/original_pdf_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/editor/size_unit_preference_provider.dart';
import 'package:pdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:pdfsign/presentation/screens/editor/editor_screen.dart';
import 'package:pdfsign/presentation/widgets/dialogs/save_changes_dialog.dart';
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

class _PdfViewerAppState extends ConsumerState<PdfViewerApp>
    with WindowListener {
  /// Navigator key for showing dialogs.
  final _navigatorKey = GlobalKey<NavigatorState>();

  /// Whether the document has been modified at least once.
  /// Used to determine if status suffix should be shown in title.
  bool _hasBeenModified = false;

  @override
  void initState() {
    super.initState();
    // Initialize toolbar channel for native toolbar
    ToolbarChannel.init();
    ToolbarChannel.setupToolbar(); // Request native toolbar with Share button
    ToolbarChannel.setOnSharePressed(_handleShare);

    // Initialize window broadcast for inter-window communication
    _initWindowBroadcast();

    // Register window listener for close interception
    windowManager.addListener(this);
    windowManager.setPreventClose(true);

    // Store original PDF bytes for Save operations
    _initOriginalPdfStorage();

    // Set initial window title (just filename, no suffix)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      windowManager.setTitle(widget.fileName);
    });
  }

  /// Initializes window broadcast for receiving unit change notifications.
  Future<void> _initWindowBroadcast() async {
    WindowBroadcast.setOnUnitChanged(_handleUnitChanged);
    await WindowBroadcast.init();
  }

  /// Stores the original PDF bytes for use in Save operations.
  Future<void> _initOriginalPdfStorage() async {
    final storage = ref.read(originalPdfStorageProvider);
    await storage.store(widget.filePath);
  }

  @override
  void dispose() {
    // Unregister callbacks
    ToolbarChannel.setOnSharePressed(null);
    WindowBroadcast.setOnUnitChanged(null);
    // Remove window listener
    windowManager.removeListener(this);
    // Clean up original PDF storage
    ref.read(originalPdfStorageProvider).dispose();
    super.dispose();
  }

  /// Updates the window title based on dirty state.
  ///
  /// Shows no suffix until document is modified for the first time.
  /// After first modification: "- Edited" when dirty, "- Saved" when clean.
  void _updateWindowTitle(bool isDirty) {
    // Track if document has ever been modified
    if (isDirty) {
      _hasBeenModified = true;
    }

    // No suffix until first modification
    if (!_hasBeenModified) {
      windowManager.setTitle(widget.fileName);
      return;
    }

    final navigatorContext = _navigatorKey.currentContext;
    if (navigatorContext == null) return;

    final l10n = AppLocalizations.of(navigatorContext);
    if (l10n == null) return;

    final suffix = isDirty ? l10n.documentEdited : l10n.documentSaved;
    windowManager.setTitle('${widget.fileName} - $suffix');
  }

  /// Intercepts window close to show save dialog if needed.
  @override
  void onWindowClose() async {
    final isDirty = ref.read(documentDirtyProvider);

    if (!isDirty) {
      await windowManager.destroy();
      return;
    }

    // Show save dialog
    final navigatorContext = _navigatorKey.currentContext;
    if (navigatorContext == null) {
      await windowManager.destroy();
      return;
    }

    final result = await SaveChangesDialog.show(
      navigatorContext,
      widget.fileName,
    );

    if (result == SaveChangesResult.save) {
      await _handleSave();
      await windowManager.destroy();
    } else if (result == SaveChangesResult.discard) {
      await windowManager.destroy();
    }
    // null = dialog dismissed or cancelled, don't close
  }

  /// Reloads preferences when window becomes active.
  ///
  /// This syncs settings changed in other windows (e.g., Settings window).
  @override
  void onWindowFocus() {
    // Reload size unit preference to sync with changes from Settings
    ref.read(sizeUnitPreferenceProvider.notifier).reload();
  }

  /// Handles unit changed broadcast from another window.
  ///
  /// This is called instantly when another window changes the size unit,
  /// without waiting for window focus.
  void _handleUnitChanged() {
    ref.read(sizeUnitPreferenceProvider.notifier).reload();
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

    // Get original bytes from storage
    final storage = ref.read(originalPdfStorageProvider);
    if (!storage.hasData) {
      // Fallback: share original file
      final file = XFile(widget.filePath);
      await Share.shareXFiles([file]);
      return;
    }

    final originalBytes = await storage.getBytes();

    // Create temp PDF with placed images
    final saveService = PdfSaveService();
    final result = await saveService.createTempPdfWithImagesFromBytes(
      originalBytes: originalBytes,
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
    final isDirty = ref.read(documentDirtyProvider);

    // Nothing to save if no changes were made
    if (placedImages.isEmpty && !isDirty) return;

    // Get original bytes from storage
    final storage = ref.read(originalPdfStorageProvider);
    if (!storage.hasData) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Save failed: no original PDF stored')),
        );
      }
      return;
    }

    final originalBytes = await storage.getBytes();

    final saveService = PdfSaveService();
    final result = await saveService.savePdfFromBytes(
      originalBytes: originalBytes,
      placedImages: placedImages,
      outputPath: widget.filePath,
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
        // Mark as clean but DO NOT clear objects or reload document
        // Objects remain editable for further modifications
        ref.read(documentDirtyProvider.notifier).markClean();
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
    final storage = ref.read(originalPdfStorageProvider);

    // Get original bytes (from storage or fallback to disk)
    final originalBytes = storage.hasData
        ? await storage.getBytes()
        : await File(widget.filePath).readAsBytes();

    final saveService = PdfSaveService();
    final result = await saveService.savePdfFromBytes(
      originalBytes: originalBytes,
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
        // Mark as clean but DO NOT clear objects
        // Objects remain editable for further modifications
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
    // Listen to dirty state changes and update window title
    ref.listen<bool>(documentDirtyProvider, (_, isDirty) {
      _updateWindowTitle(isDirty);
    });

    // Watch locale preference for live updates
    final locale = ref.watch(localePreferenceProvider.notifier).getLocale();

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: widget.fileName,
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
