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

  @override
  ConsumerState<PdfPageList> createState() => _PdfPageListState();
}

class _PdfPageListState extends ConsumerState<PdfPageList> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PdfPageList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scale != widget.scale) {
      // Scale changed, update visible pages
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateVisiblePages();
      });
    }
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

  double _calculateTotalHeight() {
    double totalHeight = PdfViewerConstants.verticalPadding * 2;
    for (final page in widget.document.pages) {
      totalHeight += page.height * widget.scale;
    }
    totalHeight += PdfViewerConstants.pageGap * (widget.document.pageCount - 1);
    return totalHeight;
  }

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
