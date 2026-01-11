import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:pdfsign/core/theme/app_typography.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer.dart';

/// PDF Editor screen with PDF viewing capabilities.
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
    if (widget.filePath != null) {
      // Schedule the document load after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(pdfDocumentProvider.notifier).openDocument(widget.filePath!);
      });
    }
  }

  @override
  void didUpdateWidget(EditorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filePath != oldWidget.filePath && widget.filePath != null) {
      ref.read(pdfDocumentProvider.notifier).openDocument(widget.filePath!);
    }
  }

  Future<void> _handleBack() async {
    await ref.read(pdfDocumentProvider.notifier).closeDocument();
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewerState = ref.watch(pdfDocumentProvider);
    final fileName = viewerState.documentOrNull?.fileName ??
        widget.filePath?.split('/').last ??
        'Editor';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _handleBack,
        ),
        title: Text(
          fileName,
          style: AppTypography.displaySmall,
        ),
      ),
      body: const PdfViewer(),
    );
  }
}
