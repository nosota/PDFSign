import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_item.dart';
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
  late ScrollController _scrollController;
  bool _ownsScrollController = false;
  int _currentPage = 1;
  double _previousScale = 1.0;

  ScrollController get scrollController => _scrollController;

  @override
  void initState() {
    super.initState();
    _initScrollController();
    _previousScale = widget.scale;
  }

  void _initScrollController() {
    if (widget.scrollController != null) {
      _scrollController = widget.scrollController!;
      _ownsScrollController = false;
    } else {
      _scrollController = ScrollController();
      _ownsScrollController = true;
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    if (_ownsScrollController) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(PdfPageList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle scroll controller change
    if (widget.scrollController != oldWidget.scrollController) {
      _scrollController.removeListener(_onScroll);
      if (_ownsScrollController) {
        _scrollController.dispose();
      }
      _initScrollController();
    }

    // Handle scale change - maintain center focus
    if (oldWidget.scale != widget.scale && _scrollController.hasClients) {
      _adjustScrollForScaleChange(oldWidget.scale, widget.scale);
    }

    _previousScale = widget.scale;
  }

  void _adjustScrollForScaleChange(double oldScale, double newScale) {
    if (!_scrollController.hasClients) return;

    final viewportHeight = _scrollController.position.viewportDimension;
    final currentOffset = _scrollController.offset;

    // Calculate the center point in document coordinates
    final centerOffset = currentOffset + viewportHeight / 2;

    // Calculate the position ratio at old scale
    final oldTotalHeight = _calculateTotalHeight(oldScale);
    final positionRatio = centerOffset / oldTotalHeight;

    // Calculate new offset to maintain center
    final newTotalHeight = _calculateTotalHeight(newScale);
    final newCenterOffset = newTotalHeight * positionRatio;
    final newOffset = newCenterOffset - viewportHeight / 2;

    // Apply new offset
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final clampedOffset = newOffset.clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        );
        _scrollController.jumpTo(clampedOffset);
      }
    });
  }

  void _onScroll() {
    widget.onScroll();
    _updateVisiblePages();
    _updateCurrentPage();
  }

  void _updateVisiblePages() {
    if (!_scrollController.hasClients) return;

    final viewportHeight = _scrollController.position.viewportDimension;
    final scrollOffset = _scrollController.offset;

    // Calculate which pages are visible
    double cumulativeHeight = PdfViewerConstants.verticalPadding;
    int firstVisible = 1;
    int lastVisible = 1;

    for (int i = 0; i < widget.document.pages.length; i++) {
      final page = widget.document.pages[i];
      final pageHeight = page.height * widget.scale;
      final pageTop = cumulativeHeight;
      final pageBottom = cumulativeHeight + pageHeight;

      if (pageBottom >= scrollOffset && pageTop <= scrollOffset + viewportHeight) {
        if (firstVisible == 1 || i + 1 < firstVisible) {
          firstVisible = i + 1;
        }
        lastVisible = i + 1;
      }

      cumulativeHeight += pageHeight + PdfViewerConstants.pageGap;
    }

    ref.read(visiblePagesProvider.notifier).updateVisibleRange(
          firstVisible: firstVisible,
          lastVisible: lastVisible,
          totalPages: widget.document.pageCount,
        );
  }

  void _updateCurrentPage() {
    if (!_scrollController.hasClients) return;

    final scrollOffset = _scrollController.offset;
    final viewportCenter = scrollOffset + _scrollController.position.viewportDimension / 2;

    double cumulativeHeight = PdfViewerConstants.verticalPadding;
    int centerPage = 1;

    for (int i = 0; i < widget.document.pages.length; i++) {
      final page = widget.document.pages[i];
      final pageHeight = page.height * widget.scale;
      final pageCenter = cumulativeHeight + pageHeight / 2;

      if (pageCenter <= viewportCenter) {
        centerPage = i + 1;
      } else {
        break;
      }

      cumulativeHeight += pageHeight + PdfViewerConstants.pageGap;
    }

    if (centerPage != _currentPage) {
      _currentPage = centerPage;
      widget.onPageChanged(centerPage);
    }
  }

  double _calculateTotalHeight([double? scale]) {
    final s = scale ?? widget.scale;
    double totalHeight = PdfViewerConstants.verticalPadding * 2;
    for (final page in widget.document.pages) {
      totalHeight += page.height * s;
    }
    totalHeight += PdfViewerConstants.pageGap * (widget.document.pageCount - 1);
    return totalHeight;
  }

  /// Scrolls to show the specified page.
  void scrollToPage(int pageNumber, {bool animate = true}) {
    if (!_scrollController.hasClients) return;

    final targetPage = pageNumber.clamp(1, widget.document.pageCount);
    double targetOffset = PdfViewerConstants.verticalPadding;

    for (int i = 0; i < targetPage - 1; i++) {
      final page = widget.document.pages[i];
      targetOffset += page.height * widget.scale + PdfViewerConstants.pageGap;
    }

    // Center the page in viewport if possible
    final viewportHeight = _scrollController.position.viewportDimension;
    final pageHeight = widget.document.pages[targetPage - 1].height * widget.scale;

    if (pageHeight < viewportHeight) {
      targetOffset -= (viewportHeight - pageHeight) / 2;
    }

    targetOffset = targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent);

    if (animate) {
      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.jumpTo(targetOffset);
    }
  }

  /// Scrolls by a delta amount.
  void scrollBy(double deltaX, double deltaY, {bool animate = true}) {
    if (!_scrollController.hasClients) return;

    final newOffset = (_scrollController.offset + deltaY).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    if (animate) {
      _scrollController.animateTo(
        newOffset,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(newOffset);
    }
  }

  /// Returns scroll offset for center-focused zoom calculations.
  double get scrollOffset => _scrollController.hasClients ? _scrollController.offset : 0;

  /// Returns viewport dimensions.
  double get viewportHeight =>
      _scrollController.hasClients ? _scrollController.position.viewportDimension : 0;

  @override
  Widget build(BuildContext context) {
    final visiblePages = ref.watch(visiblePagesProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Initialize visible pages on first build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _updateVisiblePages();
          }
        });

        return SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Container(
            width: constraints.maxWidth,
            height: _calculateTotalHeight(),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: PdfViewerConstants.verticalPadding,
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
          ),
        );
      },
    );
  }
}
