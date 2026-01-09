import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../core/theme/app_theme.dart';

/// PDF Viewer Screen with continuous scroll and zoom support
///
/// Features:
/// - Continuous page scrolling
/// - Fit width mode
/// - Zoom via mouse wheel (Ctrl+wheel)
/// - Keyboard shortcuts: Cmd+/Cmd- (Mac), Ctrl+/Ctrl- (Win/Linux)
/// - Responsive scaling on window resize
/// - No toolbar, no sidebar (clean view)
class PdfViewerScreen extends ConsumerStatefulWidget {
  final String? pdfPath;

  const PdfViewerScreen({
    required this.pdfPath,
    super.key,
  });

  @override
  ConsumerState<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends ConsumerState<PdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfController = PdfViewerController();

  double _zoomLevel = 1;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isDocumentLoaded = false;
  double _viewportWidth = 0;

  // Zoom constants (10% to 500% range, like Preview)
  static const double _minZoom = 0.1;
  static const double _maxZoom = 5;
  static const double _zoomStep = 0.1;

  // Standard A4 page width in points (8.27 inches at 72 DPI)
  static const double _standardPageWidth = 595;

  @override
  void initState() {
    super.initState();
    _validateFile();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  Future<void> _validateFile() async {
    if (widget.pdfPath == null || widget.pdfPath!.isEmpty) {
      setState(() {
        _errorMessage = 'No PDF file specified';
        _isLoading = false;
      });
      return;
    }

    final file = File(widget.pdfPath!);
    if (!await file.exists()) {
      setState(() {
        _errorMessage = 'File not found: ${widget.pdfPath}';
        _isLoading = false;
      });
      return;
    }

    // File exists, PDF viewer will handle loading
    setState(() {
      _isLoading = false;
    });
  }

  void _handleZoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel + _zoomStep).clamp(_minZoom, _maxZoom);
      _pdfController.zoomLevel = _zoomLevel;
    });
  }

  void _handleZoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel - _zoomStep).clamp(_minZoom, _maxZoom);
      _pdfController.zoomLevel = _zoomLevel;
    });
  }

  void _calculateFitToWidth() {
    if (_viewportWidth <= 0) return;

    // Account for scrollbar and padding (approximate)
    const padding = 40.0;
    final availableWidth = _viewportWidth - padding;

    // Calculate zoom to fit page width to viewport
    final fitZoom = availableWidth / _standardPageWidth;

    setState(() {
      _zoomLevel = fitZoom.clamp(_minZoom, _maxZoom);
      if (_isDocumentLoaded) {
        _pdfController.zoomLevel = _zoomLevel;
      }
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    final isCommandPressed = (Platform.isMacOS &&
            HardwareKeyboard.instance.isMetaPressed) ||
        (!Platform.isMacOS &&
            HardwareKeyboard.instance.isControlPressed);

    if (!isCommandPressed) {
      return;
    }

    if (event.logicalKey == LogicalKeyboardKey.equal ||
        event.logicalKey == LogicalKeyboardKey.add) {
      _handleZoomIn();
    } else if (event.logicalKey == LogicalKeyboardKey.minus) {
      _handleZoomOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (widget.pdfPath == null) {
      return _buildErrorState();
    }

    return _buildPdfViewer();
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: AppTheme.spacing16),
          Text(
            'Loading PDF...',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B6B6B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: AppTheme.spacing16),
            const Text(
              'Failed to load PDF',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              _errorMessage ?? 'Unknown error occurred',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B6B6B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing24,
                  vertical: AppTheme.spacing12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfViewer() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Save viewport width but don't recalculate zoom on resize
        if (_viewportWidth != constraints.maxWidth) {
          _viewportWidth = constraints.maxWidth;
          // Only calculate fit-to-width on initial load
          if (!_isDocumentLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_isDocumentLoaded) {
                _calculateFitToWidth();
              }
            });
          }
        }

        return Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              // Check if Ctrl (Windows/Linux) or Cmd (Mac) is pressed
              final isCommandPressed = (Platform.isMacOS &&
                      HardwareKeyboard.instance.isMetaPressed) ||
                  (!Platform.isMacOS &&
                      HardwareKeyboard.instance.isControlPressed);

              if (isCommandPressed) {
                // Zoom with mouse wheel
                if (event.scrollDelta.dy < 0) {
                  _handleZoomIn();
                } else {
                  _handleZoomOut();
                }
              }
            }
          },
          child: SfPdfViewer.file(
            File(widget.pdfPath!),
            key: _pdfViewerKey,
            controller: _pdfController,
            pageLayoutMode: PdfPageLayoutMode.continuous,
            scrollDirection: PdfScrollDirection.vertical,
            enableDoubleTapZooming: false,
            enableTextSelection: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            onDocumentLoaded: (details) {
              // Mark document as loaded and apply fit-to-width zoom
              setState(() {
                _isDocumentLoaded = true;
              });
              _calculateFitToWidth();
            },
            onDocumentLoadFailed: (details) {
              setState(() {
                _errorMessage = details.error;
              });
            },
          ),
        );
      },
    );
  }
}
