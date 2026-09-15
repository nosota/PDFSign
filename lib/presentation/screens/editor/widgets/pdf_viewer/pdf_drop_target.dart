import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_layout.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer_constants.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/draggable_image_card.dart';

/// Drop area covering the PDF viewport.
///
/// Accepts a [DraggableSidebarImage] dragged out of the sidebar and turns it
/// into a placed object on the page under the cursor. While a drag is in
/// flight the page that would receive the object is outlined, so a drop that
/// lands in the margin still shows where it will go.
class PdfDropTarget extends ConsumerStatefulWidget {
  const PdfDropTarget({
    required this.child,
    required this.document,
    required this.scale,
    required this.getScrollOffset,
    super.key,
  });

  /// The viewer content this target sits on top of.
  final Widget child;

  /// The document currently displayed.
  final PdfDocumentInfo document;

  /// Render scale the pages are laid out at.
  final double scale;

  /// Reads the live scroll offset of the page column, as (horizontal,
  /// vertical). Content coordinates are viewport coordinates plus this.
  final Offset Function() getScrollOffset;

  /// Identifies the outline drawn over the page that would receive the drop.
  @visibleForTesting
  static const highlightKey = ValueKey<String>('pdfDropTargetHighlight');

  @override
  ConsumerState<PdfDropTarget> createState() => _PdfDropTargetState();
}

class _PdfDropTargetState extends ConsumerState<PdfDropTarget> {
  /// Share of the page width a freshly placed object occupies.
  static const _defaultWidthRatio = 0.25;

  /// Hard ceiling on a placed object relative to the page.
  static const _maxPageCoverage = 0.9;

  final _layoutCache = PdfPageLayoutCache();

  /// Page that would receive the object if the drag ended now.
  int? _targetPageIndex;

  @override
  Widget build(BuildContext context) =>
      DragTarget<DraggableSidebarImage>(
        // Refuse the drag outright when there is no page to drop onto.
        onWillAcceptWithDetails: (details) => _acceptAndTrack(details.offset),
        onMove: (details) => _setTargetPage(_targetPageFor(details.offset)),
        onLeave: (_) => _setTargetPage(null),
        onAcceptWithDetails: (details) {
          _setTargetPage(null);
          _handleDrop(details);
        },
        builder: (context, candidateData, rejectedData) {
          final highlight = _buildTargetHighlight(context);
          return Stack(
            fit: StackFit.expand,
            children: [
              widget.child,
              if (highlight != null) highlight,
            ],
          );
        },
      );

  /// Outlines the page that will receive the drop.
  ///
  /// Positioned from the cached layout and the live scroll offset, so it stays
  /// aligned with the page without reading the render tree during build.
  Widget? _buildTargetHighlight(BuildContext context) {
    final index = _targetPageIndex;
    final layout = _layoutCache.current;
    if (index == null || layout == null || index >= layout.pageCount) {
      return null;
    }

    final rect = layout.pageRect(index).shift(-widget.getScrollOffset());
    final primary = Theme.of(context).colorScheme.primary;

    return Positioned.fromRect(
      key: PdfDropTarget.highlightKey,
      rect: rect,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.06),
            border: Border.all(
              color: primary.withValues(alpha: 0.7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(
              PdfViewerConstants.pageBorderRadius,
            ),
          ),
        ),
      ),
    );
  }

  /// Tracks the page under the pointer and reports whether a drop is possible.
  bool _acceptAndTrack(Offset globalPosition) {
    final index = _targetPageFor(globalPosition);
    _setTargetPage(index);
    return index != null;
  }

  void _setTargetPage(int? index) {
    if (_targetPageIndex == index) {
      return;
    }
    setState(() => _targetPageIndex = index);
  }

  /// Page that a pointer at [globalPosition] would drop onto: the page under
  /// the cursor, else the nearest one. Null only when there is no page at all.
  int? _targetPageFor(Offset globalPosition) {
    final resolved = _resolve(globalPosition);
    if (resolved == null) {
      return null;
    }
    final (:layout, :contentPoint) = resolved;
    return layout.pageIndexAt(contentPoint) ??
        layout.nearestPageIndex(contentPoint);
  }

  /// Maps a global pointer position onto the page column.
  ///
  /// Returns null before this widget has been laid out.
  ({PdfPageLayout layout, Offset contentPoint})? _resolve(
    Offset globalPosition,
  ) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      return null;
    }

    final layout = _layoutCache.of(
      document: widget.document,
      scale: widget.scale,
      viewportWidth: renderBox.size.width,
    );
    final contentPoint =
        renderBox.globalToLocal(globalPosition) + widget.getScrollOffset();

    return (layout: layout, contentPoint: contentPoint);
  }

  void _handleDrop(DragTargetDetails<DraggableSidebarImage> details) {
    final resolved = _resolve(details.offset);
    if (resolved == null) {
      return;
    }
    final (:layout, :contentPoint) = resolved;

    // A drop in the margin, in a gap, or past the end of the document snaps to
    // the nearest page rather than being lost or silently sent to page one.
    final pageIndex = layout.pageIndexAt(contentPoint) ??
        layout.nearestPageIndex(contentPoint);
    if (pageIndex == null) {
      return;
    }

    final page = widget.document.pages[pageIndex];
    final pageSize = Size(page.width, page.height);
    final size = _defaultSizeFor(details.data.aspectRatio, pageSize);

    // Cursor position in unscaled page points. Falls outside the page for an
    // off-page drop; the clamp below pulls the object back inside.
    final pageOrigin = layout.pageRect(pageIndex).topLeft;
    final cursorOnPage = (contentPoint - pageOrigin) / layout.scale;

    final position = Offset(
      _clamped(cursorOnPage.dx - size.width / 2, pageSize.width - size.width),
      _clamped(
        cursorOnPage.dy - size.height / 2,
        pageSize.height - size.height,
      ),
    );

    final placed = ref.read(placedImagesProvider.notifier).addImage(
          sourceImageId: details.data.sourceImageId,
          imagePath: details.data.imagePath,
          pageIndex: pageIndex,
          position: position,
          size: size,
        );

    ref.read(documentDirtyProvider.notifier).markDirty();
    ref.read(editorSelectionProvider.notifier).select(placed.id);
  }

  /// Clamps a coordinate so the object stays fully on the page.
  ///
  /// [maxValue] can only go negative if an object were larger than its page,
  /// which [_defaultSizeFor] prevents; guarding anyway keeps a malformed
  /// document from producing an out-of-range position.
  static double _clamped(double value, double maxValue) {
    if (value < 0 || maxValue <= 0) {
      return 0;
    }
    return value > maxValue ? maxValue : value;
  }

  /// Size for a freshly placed object: a quarter of the page width, keeping
  /// the source aspect ratio, never covering more than 90% of the page.
  static Size _defaultSizeFor(double aspectRatio, Size pageSize) {
    // A library row with a zero dimension would yield 0, infinity or NaN.
    // Fall back to a square rather than letting that reach the saved PDF.
    final ratio =
        aspectRatio.isFinite && aspectRatio > 0 ? aspectRatio : 1.0;

    final target = pageSize.width * _defaultWidthRatio;
    var width = ratio > 1 ? target : target * ratio;
    var height = ratio > 1 ? target / ratio : target;

    final maxWidth = pageSize.width * _maxPageCoverage;
    if (width > maxWidth) {
      width = maxWidth;
      height = width / ratio;
    }

    final maxHeight = pageSize.height * _maxPageCoverage;
    if (height > maxHeight) {
      height = maxHeight;
      width = height * ratio;
    }

    return Size(width, height);
  }
}
