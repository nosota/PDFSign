import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_sidebar.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/sidebar_resize_handle.dart';

/// PDF Editor screen with PDF viewing capabilities.
///
/// Displays a single PDF document in its own window.
/// Window close handling is done in PdfViewerApp.
class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({
    required this.filePath,
    super.key,
  });

  final String? filePath;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  @override
  void initState() {
    super.initState();
    _loadDocument();
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
  Widget build(BuildContext context) {
    return Scaffold(
      // Force LTR layout direction to keep panels in place for RTL languages.
      // Text inside widgets will still be RTL as it inherits from MaterialApp.
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
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
      ),
    );
  }
}
