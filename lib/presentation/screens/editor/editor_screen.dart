import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_sidebar.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/sidebar_resize_handle.dart';

/// Result of the save changes dialog.
enum SaveChangesResult { save, dontSave, cancel }

/// PDF Editor screen with PDF viewing capabilities.
///
/// Displays a single PDF document in its own window.
/// Handles close prompt when there are unsaved changes.
class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({
    required this.filePath,
    super.key,
  });

  final String? filePath;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    // Enable prevent close so we can show confirmation dialog
    windowManager.setPreventClose(true);
    _loadDocument();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _loadDocument() {
    final path = widget.filePath;
    if (path != null && path.isNotEmpty) {
      // Schedule the document load after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(pdfDocumentProvider.notifier).openDocument(path);
      });
    }
  }

  @override
  void didUpdateWidget(EditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final path = widget.filePath;
    if (path != oldWidget.filePath && path != null && path.isNotEmpty) {
      ref.read(pdfDocumentProvider.notifier).openDocument(path);
    }
  }

  @override
  void onWindowClose() async {
    final isDirty = ref.read(documentDirtyProvider);

    if (!isDirty) {
      // No unsaved changes, close immediately
      await windowManager.destroy();
      return;
    }

    // Show confirmation dialog
    final result = await _showSaveChangesDialog();

    switch (result) {
      case SaveChangesResult.save:
        // Save and then close
        await _saveAndClose();
        break;
      case SaveChangesResult.dontSave:
        // Discard changes and close
        await windowManager.destroy();
        break;
      case SaveChangesResult.cancel:
        // Don't close
        break;
    }
  }

  Future<SaveChangesResult> _showSaveChangesDialog() async {
    final result = await showDialog<SaveChangesResult>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Save Changes?'),
        content: const Text(
          'Do you want to save the changes you made to this document?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(SaveChangesResult.dontSave),
            child: const Text("Don't Save"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(SaveChangesResult.cancel),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(SaveChangesResult.save),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    return result ?? SaveChangesResult.cancel;
  }

  Future<void> _saveAndClose() async {
    final state = ref.read(pdfDocumentProvider);
    final filePath = state.maybeMap(
      loaded: (s) => s.document.filePath,
      orElse: () => null,
    );

    if (filePath == null) {
      await windowManager.destroy();
      return;
    }

    final placedImages = ref.read(placedImagesProvider);
    if (placedImages.isEmpty) {
      await windowManager.destroy();
      return;
    }

    final saveService = PdfSaveService();
    final result = await saveService.savePdf(
      originalPath: filePath,
      placedImages: placedImages,
    );

    result.fold(
      (failure) {
        // Show error and don't close
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Save failed: ${failure.message}')),
          );
        }
      },
      (_) async {
        // Close after successful save
        await windowManager.destroy();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          // PDF viewer (expands to fill remaining space)
          Expanded(
            child: PdfViewer(),
          ),

          // Resize handle
          SidebarResizeHandle(),

          // Right sidebar with images
          ImageSidebar(),
        ],
      ),
    );
  }
}
