import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import '../../../core/theme/app_theme.dart';

/// PDF Viewer Screen with Preview.app-like behavior
///
/// Features:
/// - Continuous page scrolling with rendered pages
/// - Light gray background with shadows around pages
/// - Pinch zoom centered at gesture point
/// - Mouse wheel zoom (Ctrl/Cmd + scroll)
/// - Keyboard shortcuts: Cmd+/Cmd-/Cmd+0 (Mac), Ctrl+/Ctrl-/Ctrl+0 (Win/Linux)
/// - Cmd+0 resets to fit-to-width
/// - Pages centered when zoom < fit-to-width
/// - Zoom range: 10% to 500%
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
  PdfDocument? _document;
  final TransformationController _transformationController =
      TransformationController();
  final ScrollController _scrollController = ScrollController();

  double _scale = 1;
  double _viewportWidth = 0;
  bool _isLoading = true;
  String? _errorMessage;
  List<PdfPageImage> _renderedPages = [];

  // Zoom constants (10% to 500% range, like Preview)
  static const double _minZoom = 0.1;
  static const double _maxZoom = 5;
  static const double _zoomStep = 0.1;

  // Page spacing and padding
  static const double _pageSpacing = 16;
  static const double _pagePadding = 20;

  // Background colors (light gray like Preview)
  static const Color _backgroundColor = Color(0xFFE8E8E8);
  static const Color _pageColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  @override
  void dispose() {
    _document?.close();
    _transformationController.dispose();
    _scrollController.dispose();
    for (final page in _renderedPages) {
      page.bytes.clear();
    }
    super.dispose();
  }

  Future<void> _loadDocument() async {
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

    try {
      final document = await PdfDocument.openFile(widget.pdfPath!);
      setState(() {
        _document = document;
        _isLoading = false;
      });

      // Render all pages after document is loaded
      await _renderAllPages();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load PDF: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _renderAllPages() async {
    if (_document == null) return;

    final List<PdfPageImage> pages = [];
    for (int i = 0; i < _document!.pagesCount; i++) {
      try {
        final page = await _document!.getPage(i + 1);
        final pageImage = await page.render(
          width: page.width * 2, // 2x for retina
          height: page.height * 2,
          format: PdfPageImageFormat.png,
        );
        await page.close();

        if (pageImage != null) {
          pages.add(pageImage);
        }
      } catch (e) {
        debugPrint('Failed to render page ${i + 1}: $e');
      }
    }

    setState(() {
      _renderedPages = pages;
    });

    // Calculate fit-to-width after rendering first page
    if (_renderedPages.isNotEmpty && _viewportWidth > 0) {
      _calculateFitToWidth();
    }
  }

  void _calculateFitToWidth() {
    if (_renderedPages.isEmpty || _viewportWidth <= 0) {
      return;
    }

    final firstPage = _renderedPages.first;
    final pageWidth =
        (firstPage.width ?? 0) / 2; // Divide by 2 because we rendered at 2x
    final availableWidth = _viewportWidth - (_pagePadding * 2);

    final fitZoom = availableWidth / pageWidth;

    setState(() {
      _scale = fitZoom.clamp(_minZoom, _maxZoom);
      _updateTransformation();
    });
  }

  void _updateTransformation() {
    _transformationController.value = Matrix4.identity()
      ..scale(_scale, _scale, 1);
  }

  void _handleZoomIn() {
    setState(() {
      _scale = (_scale + _zoomStep).clamp(_minZoom, _maxZoom);
      _updateTransformation();
    });
  }

  void _handleZoomOut() {
    setState(() {
      _scale = (_scale - _zoomStep).clamp(_minZoom, _maxZoom);
      _updateTransformation();
    });
  }

  void _handleResetZoom() {
    _calculateFitToWidth();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    final isCommandPressed = (Platform.isMacOS &&
            HardwareKeyboard.instance.isMetaPressed) ||
        (!Platform.isMacOS && HardwareKeyboard.instance.isControlPressed);

    if (!isCommandPressed) {
      return;
    }

    if (event.logicalKey == LogicalKeyboardKey.digit0 ||
        event.logicalKey == LogicalKeyboardKey.numpad0) {
      _handleResetZoom();
    } else if (event.logicalKey == LogicalKeyboardKey.equal ||
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
        backgroundColor: _backgroundColor,
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

    if (_document == null) {
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
        // Save viewport width and calculate fit-to-width on first render
        if (_viewportWidth != constraints.maxWidth) {
          _viewportWidth = constraints.maxWidth;
          if (_renderedPages.isNotEmpty && _scale == 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _calculateFitToWidth();
            });
          }
        }

        return Listener(
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              final isCommandPressed = (Platform.isMacOS &&
                      HardwareKeyboard.instance.isMetaPressed) ||
                  (!Platform.isMacOS &&
                      HardwareKeyboard.instance.isControlPressed);

              if (isCommandPressed) {
                if (event.scrollDelta.dy < 0) {
                  _handleZoomIn();
                } else {
                  _handleZoomOut();
                }
              }
            }
          },
          child: InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.01,
            maxScale: _maxZoom,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            clipBehavior: Clip.none,
            panEnabled: true,
            scaleEnabled: true,
            onInteractionUpdate: (details) {
              setState(() {
                _scale = _transformationController.value.getMaxScaleOnAxis();
              });
            },
            child: _buildPageList(constraints),
          ),
        );
      },
    );
  }

  Widget _buildPageList(BoxConstraints constraints) {
    if (_renderedPages.isEmpty) {
      return const SizedBox.shrink();
    }

    // Calculate total content height
    double totalHeight = _pagePadding * 2; // Top and bottom padding
    for (int i = 0; i < _renderedPages.length; i++) {
      final pageHeight = (_renderedPages[i].height ?? 0) / 2;
      totalHeight += pageHeight;
      if (i < _renderedPages.length - 1) {
        totalHeight += _pageSpacing;
      }
    }

    // Calculate content width (max page width + padding)
    double contentWidth = 0;
    for (final page in _renderedPages) {
      final pageWidth = (page.width ?? 0) / 2;
      if (pageWidth > contentWidth) {
        contentWidth = pageWidth;
      }
    }
    contentWidth += _pagePadding * 2;

    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: constraints.maxWidth,
          height: totalHeight > constraints.maxHeight
              ? totalHeight
              : constraints.maxHeight,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: _pagePadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < _renderedPages.length; i++) ...[
                    _buildPageWidget(_renderedPages[i]),
                    if (i < _renderedPages.length - 1)
                      const SizedBox(height: _pageSpacing),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageWidget(PdfPageImage pageImage) {
    final pageWidth = (pageImage.width ?? 0) / 2; // Divide by 2 (rendered at 2x)
    final pageHeight = (pageImage.height ?? 0) / 2;

    return Container(
      width: pageWidth,
      height: pageHeight,
      decoration: BoxDecoration(
        color: _pageColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Image.memory(
        pageImage.bytes,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
