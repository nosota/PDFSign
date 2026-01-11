import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/page_indicator.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_list.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer_constants.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/zoom_controls.dart';

/// Main PDF viewer widget with continuous scroll and zoom controls.
///
/// Displays PDF pages in a macOS Preview-style layout with:
/// - Continuous vertical scroll
/// - Lazy loading and caching
/// - Zoom controls (+/-, dropdown, Ctrl+scroll)
/// - Auto-hiding page indicator
class PdfViewer extends ConsumerStatefulWidget {
  const PdfViewer({super.key});

  @override
  ConsumerState<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends ConsumerState<PdfViewer> {
  bool _isScrolling = false;
  Timer? _scrollEndTimer;
  Timer? _zoomDebounceTimer;

  @override
  void dispose() {
    _scrollEndTimer?.cancel();
    _zoomDebounceTimer?.cancel();
    super.dispose();
  }

  void _handleScroll() {
    if (!_isScrolling) {
      setState(() {
        _isScrolling = true;
      });
    }

    _scrollEndTimer?.cancel();
    _scrollEndTimer = Timer(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _isScrolling = false;
        });
      }
    });
  }

  void _handleCtrlScroll(PointerScrollEvent event) {
    if (!HardwareKeyboard.instance.isControlPressed) return;

    _zoomDebounceTimer?.cancel();
    _zoomDebounceTimer = Timer(PdfViewerConstants.zoomDebounceDuration, () {
      if (!mounted) return;

      final notifier = ref.read(pdfDocumentProvider.notifier);
      if (event.scrollDelta.dy < 0) {
        notifier.zoomIn();
      } else {
        notifier.zoomOut();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewerState = ref.watch(pdfDocumentProvider);

    return viewerState.map(
      initial: (_) => _buildEmptyState(),
      loading: (state) => _buildLoadingState(state.filePath),
      loaded: (state) => _buildLoadedState(state),
      error: (state) => _buildErrorState(state.message),
      passwordRequired: (state) => _buildPasswordRequired(state.filePath),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: const Center(
        child: Text(
          'No document loaded',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(String filePath) {
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildLoadedState(PdfViewerLoaded state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Update viewport width for fitWidth calculation
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(pdfDocumentProvider.notifier).updateViewportWidth(
                constraints.maxWidth,
              );
        });

        return Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              _handleCtrlScroll(event);
            }
          },
          child: Container(
            color: PdfViewerConstants.backgroundColor,
            child: Stack(
              children: [
                // PDF pages
                PdfPageList(
                  document: state.document,
                  scale: state.effectiveScale,
                  onPageChanged: (page) {
                    ref.read(pdfDocumentProvider.notifier).setCurrentPage(page);
                  },
                  onScroll: _handleScroll,
                ),

                // Zoom controls (bottom right)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: ZoomControls(
                    currentZoom: state.zoomLevel,
                    onZoomChanged: (level) {
                      ref.read(pdfDocumentProvider.notifier).setZoomLevel(level);
                    },
                    onZoomIn: () {
                      ref.read(pdfDocumentProvider.notifier).zoomIn();
                    },
                    onZoomOut: () {
                      ref.read(pdfDocumentProvider.notifier).zoomOut();
                    },
                  ),
                ),

                // Page indicator (bottom center)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: Center(
                    child: PageIndicator(
                      currentPage: state.currentPage,
                      totalPages: state.document.pageCount,
                      isScrolling: _isScrolling,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load PDF',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordRequired(String filePath) {
    return Container(
      color: PdfViewerConstants.backgroundColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 48,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              'Password Required',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'This PDF is password protected.',
              style: TextStyle(color: Colors.grey),
            ),
            // TODO: Add password input dialog
          ],
        ),
      ),
    );
  }
}
