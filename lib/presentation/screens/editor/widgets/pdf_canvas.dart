import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/domain/entities/placed_object.dart' as domain;
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/l10n/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/editor_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/placed_objects_overlay.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Main PDF canvas area with PDF viewer and placed objects overlay
class PdfCanvas extends ConsumerStatefulWidget {
  final String? pdfPath;

  const PdfCanvas({
    super.key,
    this.pdfPath,
  });

  @override
  ConsumerState<PdfCanvas> createState() => _PdfCanvasState();
}

class _PdfCanvasState extends ConsumerState<PdfCanvas> {
  final PdfViewerController _pdfController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    // Load PDF if path provided
    if (widget.pdfPath != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadPdf(widget.pdfPath!);
      });
    }
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  Future<void> _loadPdf(String path) async {
    await ref.read(pdfDocumentProvider.notifier).openPdf(path: path);

    // Check if there was an error
    final state = ref.read(pdfDocumentProvider);
    if (state.error != null && mounted) {
      _showError(state.error!);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pdfState = ref.watch(pdfDocumentProvider);
    final zoomLevel = ref.watch(zoomLevelProvider);
    final editorState = ref.watch(editorProvider);

    // Sync zoom with PDF controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pdfController.zoomLevel != zoomLevel) {
        _pdfController.zoomLevel = zoomLevel;
      }
    });

    // Listen to PDF controller zoom changes
    _pdfController.addListener(() {
      if (_pdfController.zoomLevel != zoomLevel) {
        ref.read(zoomLevelProvider.notifier).setZoom(_pdfController.zoomLevel);
      }
    });

    return Container(
      color: const Color(0xFFF5F5F7),
      child: DragTarget<SignatureItem>(
        onWillAcceptWithDetails: (details) => widget.pdfPath != null,
        onAcceptWithDetails: (details) {
          _handleDrop(details.data, details.offset);
        },
        builder: (context, candidateData, rejectedData) {
          return Stack(
            children: [
              // PDF Viewer
              if (widget.pdfPath != null && pdfState.filePath != null)
                SfPdfViewer.file(
                  File(widget.pdfPath!),
                  controller: _pdfController,
                  canShowPaginationDialog: false,
                  canShowPasswordDialog: false,
                  canShowScrollHead: true,
                  canShowScrollStatus: true,
                  enableDoubleTapZooming: true,
                  enableTextSelection: false,
                  onDocumentLoaded: (details) {
                    // PDF loaded
                  },
                  onDocumentLoadFailed: (details) {
                    _showError(details.error);
                  },
                  onPageChanged: (details) {
                    ref.read(currentPageProvider.notifier).setPage(details.newPageNumber - 1);
                  },
                  onZoomLevelChanged: (details) {
                    ref
                        .read(zoomLevelProvider.notifier)
                        .setZoom(details.newZoomLevel);
                  },
                )
              else
                // Empty state
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.picture_as_pdf_outlined,
                        size: 80,
                        color: Color(0xFFB0B0B0),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noPdfOpen,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: const Color(0xFF6B6B6B),
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.openPdfToStart,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFFB0B0B0),
                            ),
                      ),
                    ],
                  ),
                ),

              // Placed objects overlay
              if (widget.pdfPath != null)
                const Positioned.fill(
                  child: PlacedObjectsOverlay(),
                ),

              // Drop indicator
              if (candidateData.isNotEmpty)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF0066FF),
                        width: 3,
                      ),
                      color: const Color(0xFF0066FF).withOpacity(0.1),
                    ),
                  ),
                ),

              // Loading indicator
              if (pdfState.isLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  /// Handle drop of signature/stamp onto canvas
  void _handleDrop(SignatureItem item, Offset dropPosition) {
    final currentPage = ref.read(currentPageProvider);
    final zoomLevel = ref.read(zoomLevelProvider);

    // Default size for placed object (will maintain aspect ratio)
    const double defaultWidth = 200.0;

    // Calculate aspect ratio from image
    // For now, use a default height, but we should decode the image to get actual dimensions
    const double defaultHeight = 100.0;

    // Convert screen coordinates to PDF coordinates
    // Note: This is a simplified version. In production, you'd need to account for:
    // - PDF page scroll position
    // - PDF viewer viewport offset
    // - Actual page dimensions
    final pdfPosition = domain.Offset(
      dropPosition.dx / zoomLevel,
      dropPosition.dy / zoomLevel,
    );

    final size = domain.Size(defaultWidth / zoomLevel, defaultHeight / zoomLevel);

    ref.read(editorProvider.notifier).placeObject(
          signatureId: item.id,
          pageNumber: currentPage,
          position: pdfPosition,
          size: size,
        );
  }
}
