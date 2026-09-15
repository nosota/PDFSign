import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_item.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_layout.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer_constants.dart';

/// Virtualized list of PDF pages with continuous scroll.
class PdfPageList extends ConsumerStatefulWidget {
  const PdfPageList({
    required this.document,
    required this.scale,
    required this.onPageChanged,
    required this.onScroll,
    this.scrollController,
    super.key,
  });

  /// The PDF document to display.
  final PdfDocumentInfo document;

  /// Current scale factor for rendering.
  final double scale;

  /// Called when the current visible page changes.
  final void Function(int pageNumber) onPageChanged;

  /// Called when scroll occurs (for showing page indicator).
  final VoidCallback onScroll;

  /// Optional external scroll controller.
  final ScrollController? scrollController;

  @override
  ConsumerState<PdfPageList> createState() => PdfPageListState();
}

class PdfPageListState extends ConsumerState<PdfPageList> {
  late ScrollController _verticalController;
  ScrollController _horizontalController = ScrollController();
  bool _ownsVerticalController = false;
  int _currentPage = 1;
  double _viewportWidth = 0;
  PdfPageLayout? _cachedLayout;

  ScrollController get scrollController => _verticalController;

  /// Page geometry for the current document, scale and viewport width.
  ///
  /// Cached because the scroll handlers query it on every tick. Rebuilt only
  /// when one of its inputs changes; [identical] keeps the check O(1).
  PdfPageLayout get _layout {
    final cached = _cachedLayout;
    if (cached != null &&
        cached.scale == widget.scale &&
        cached.viewportWidth == _viewportWidth &&
        identical(cached.document, widget.document)) {
      return cached;
    }
    return _cachedLayout = PdfPageLayout(
      document: widget.document,
      scale: widget.scale,
      viewportWidth: _viewportWidth,
    );
  }

  @override
  void initState() {
    super.initState();
    _initScrollController();
  }

  void _initScrollController() {
    if (widget.scrollController != null) {
      _verticalController = widget.scrollController!;
      _ownsVerticalController = false;
    } else {
      _verticalController = ScrollController();
      _ownsVerticalController = true;
    }
    _verticalController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _verticalController.removeListener(_onScroll);
    if (_ownsVerticalController) {
      _verticalController.dispose();
    }
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PdfPageList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle scroll controller change
    if (widget.scrollController != oldWidget.scrollController) {
      _verticalController.removeListener(_onScroll);
      if (_ownsVerticalController) {
        _verticalController.dispose();
      }
      _initScrollController();
    }

    // Handle scale change - maintain center focus and update visible pages
    if (oldWidget.scale != widget.scale && _verticalController.hasClients) {
      _adjustScrollForScaleChange(oldWidget.scale, widget.scale);
      // Update visible pages when scale changes to trigger correct renders
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _verticalController.hasClients) {
          _updateVisiblePages();
        }
      });
    }
  }

  void _adjustScrollForScaleChange(double oldScale, double newScale) {
    if (!_verticalController.hasClients) return;

    final viewportHeight = _verticalController.position.viewportDimension;
    final currentOffset = _verticalController.offset;

    // Calculate the center point in document coordinates
    final centerOffset = currentOffset + viewportHeight / 2;

    // Calculate the position ratio at old scale
    final oldTotalHeight =
        PdfPageLayout.totalHeightFor(widget.document, oldScale);
    final positionRatio = centerOffset / oldTotalHeight;

    // Calculate new offset to maintain center
    final newTotalHeight =
        PdfPageLayout.totalHeightFor(widget.document, newScale);
    final newCenterOffset = newTotalHeight * positionRatio;
    final newOffset = newCenterOffset - viewportHeight / 2;

    // Apply new offset
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_verticalController.hasClients) {
        final clampedOffset = newOffset.clamp(
          0.0,
          _verticalController.position.maxScrollExtent,
        );
        _verticalController.jumpTo(clampedOffset);
      }
    });
  }

  void _onScroll() {
    widget.onScroll();
    _updateVisiblePages();
    _updateCurrentPage();
  }

  void _updateVisiblePages() {
    if (!_verticalController.hasClients) return;

    final range = _layout.visiblePageNumbers(
      scrollOffset: _verticalController.offset,
      viewportHeight: _verticalController.position.viewportDimension,
    );
    if (range == null) return;

    ref.read(visiblePagesProvider.notifier).updateVisibleRange(
          firstVisible: range.first,
          lastVisible: range.last,
          totalPages: widget.document.pageCount,
        );
  }

  void _updateCurrentPage() {
    if (!_verticalController.hasClients) return;

    final viewportCenter = _verticalController.offset +
        _verticalController.position.viewportDimension / 2;

    final centerPage = _layout.pageNumberAtCenter(viewportCenter);

    if (centerPage != _currentPage) {
      _currentPage = centerPage;
      widget.onPageChanged(centerPage);
    }
  }

  /// Scrolls to show the specified page.
  void scrollToPage(int pageNumber, {bool animate = true}) {
    if (!_verticalController.hasClients) return;

    final targetOffset = _layout
        .scrollOffsetForPage(
          pageNumber,
          viewportHeight: _verticalController.position.viewportDimension,
        )
        .clamp(0.0, _verticalController.position.maxScrollExtent);

    if (animate) {
      _verticalController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _verticalController.jumpTo(targetOffset);
    }
  }

  /// Scrolls by a delta amount in both directions.
  void scrollBy(double deltaX, double deltaY, {bool animate = true}) {
    // Vertical scroll
    if (_verticalController.hasClients && deltaY != 0) {
      final newVerticalOffset = (_verticalController.offset + deltaY).clamp(
        0.0,
        _verticalController.position.maxScrollExtent,
      );

      if (animate) {
        _verticalController.animateTo(
          newVerticalOffset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        _verticalController.jumpTo(newVerticalOffset);
      }
    }

    // Horizontal scroll
    if (_horizontalController.hasClients && deltaX != 0) {
      final newHorizontalOffset = (_horizontalController.offset + deltaX).clamp(
        0.0,
        _horizontalController.position.maxScrollExtent,
      );

      if (animate) {
        _horizontalController.animateTo(
          newHorizontalOffset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        _horizontalController.jumpTo(newHorizontalOffset);
      }
    }
  }

  /// Adjusts scroll position after a focal-point zoom.
  /// Keeps the document point at [focalPoint] at the same screen position.
  void adjustScrollForFocalZoom({
    required double oldScale,
    required double newScale,
    required Offset focalPoint,
  }) {
    final scaleRatio = newScale / oldScale;

    // Vertical adjustment
    double? newVerticalOffset;
    if (_verticalController.hasClients) {
      final oldVerticalOffset = _verticalController.offset;
      final focalY = focalPoint.dy;
      newVerticalOffset = oldVerticalOffset * scaleRatio + focalY * (scaleRatio - 1);
    }

    // Horizontal adjustment
    double? newHorizontalOffset;
    if (_horizontalController.hasClients) {
      final oldHorizontalOffset = _horizontalController.offset;
      final focalX = focalPoint.dx;
      newHorizontalOffset = oldHorizontalOffset * scaleRatio + focalX * (scaleRatio - 1);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Apply vertical scroll
      if (_verticalController.hasClients && newVerticalOffset != null) {
        final clampedVertical = newVerticalOffset.clamp(
          0.0,
          _verticalController.position.maxScrollExtent,
        );
        _verticalController.jumpTo(clampedVertical);
      }

      // Apply horizontal scroll
      if (_horizontalController.hasClients && newHorizontalOffset != null) {
        final clampedHorizontal = newHorizontalOffset.clamp(
          0.0,
          _horizontalController.position.maxScrollExtent,
        );
        _horizontalController.jumpTo(clampedHorizontal);
      }
    });
  }

  /// Returns scroll offset for center-focused zoom calculations.
  double get scrollOffset => _verticalController.hasClients ? _verticalController.offset : 0;

  /// Returns horizontal scroll offset.
  double get horizontalScrollOffset =>
      _horizontalController.hasClients ? _horizontalController.offset : 0;

  /// Returns combined scroll offset (horizontal, vertical).
  Offset get scrollOffsetXY => Offset(horizontalScrollOffset, scrollOffset);

  /// Returns viewport dimensions.
  double get viewportHeight =>
      _verticalController.hasClients ? _verticalController.position.viewportDimension : 0;

  @override
  Widget build(BuildContext context) {
    final visiblePages = ref.watch(visiblePagesProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Store viewport width for centering calculations
        _viewportWidth = constraints.maxWidth;

        // Initialize visible pages on first build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_verticalController.hasClients) {
            _updateVisiblePages();
          }
        });

        final layout = _layout;
        final needsHorizontalScroll = layout.needsHorizontalScroll;
        final effectiveWidth = layout.effectiveWidth;

        Widget content = SizedBox(
          width: effectiveWidth,
          height: layout.totalHeight,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: PdfViewerConstants.verticalPadding,
              horizontal: layout.horizontalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < widget.document.pages.length; i++) ...[
                  PdfPageItem(
                    pageInfo: widget.document.pages[i],
                    scale: widget.scale,
                    isVisible: visiblePages.contains(i + 1),
                  ),
                  if (i < widget.document.pages.length - 1)
                    const SizedBox(height: PdfViewerConstants.pageGap),
                ],
              ],
            ),
          ),
        );

        // Vertical scroll
        Widget verticalScroll = SingleChildScrollView(
          controller: _verticalController,
          physics: const ClampingScrollPhysics(),
          child: content,
        );

        // Wrap in horizontal scroll if needed
        if (needsHorizontalScroll) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalController,
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              width: effectiveWidth,
              height: constraints.maxHeight,
              child: verticalScroll,
            ),
          );
        }

        return verticalScroll;
      },
    );
  }
}
