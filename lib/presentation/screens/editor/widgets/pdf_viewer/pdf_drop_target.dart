import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_layout.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/placed_image_placement.dart';
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
  final _layoutCache = PdfPageLayoutCache();

  /// Pointer position in this widget's coordinates while a drag is over it.
  ///
  /// Kept in viewport space rather than as a resolved page index: which page
  /// the pointer is over also depends on the scroll offset, which can change
  /// while the pointer stands still. Resolving during build off the live offset
  /// keeps the outline honest about where the object will actually land.
  Offset? _pointerLocal;

  @override
  Widget build(BuildContext context) =>
      DragTarget<DraggableSidebarImage>(
        // Refuse the drag outright when there is no page to drop onto, or
        // when the document does not allow anything to be put on it.
        onWillAcceptWithDetails: (details) =>
            _editingAllowed && _trackPointer(details.offset),
        onMove: (details) => _trackPointer(details.offset),
        onLeave: (_) => _clearPointer(),
        onAcceptWithDetails: (details) {
          _clearPointer();
          _handleDrop(details);
        },
        builder: (context, candidateData, rejectedData) {
          final highlight = _buildTargetHighlight(context);
          return NotificationListener<ScrollNotification>(
            // The outline is positioned from the live scroll offset, so it has
            // to be repainted when the content scrolls under a held pointer.
            // Depending on an ancestor to rebuild is not enough: the viewer
            // only rebuilds at the start and end of a scroll burst.
            onNotification: _onScroll,
            child: Stack(
              fit: StackFit.expand,
              children: [
                widget.child,
                if (highlight != null) highlight,
              ],
            ),
          );
        },
      );

  bool _onScroll(ScrollNotification notification) {
    if (_pointerLocal != null && mounted) {
      setState(() {});
    }
    // Never absorb it: the viewer listens for the same notifications.
    return false;
  }

  /// Outlines the page that will receive the drop.
  ///
  /// Positioned from the cached layout and the live scroll offset, so it stays
  /// aligned with the page without reading the render tree during build.
  Widget? _buildTargetHighlight(BuildContext context) {
    // Outlining a page the drop will be refused on would promise something
    // that is not going to happen.
    if (!_editingAllowed) return null;

    final local = _pointerLocal;
    final layout = _layoutCache.current;
    if (local == null || layout == null) {
      return null;
    }

    final scrollOffset = widget.getScrollOffset();
    final contentPoint = local + scrollOffset;
    final index = layout.pageIndexAt(contentPoint) ??
        layout.nearestPageIndex(contentPoint);
    if (index == null) {
      return null;
    }

    final rect = layout.pageRect(index).shift(-scrollOffset);
    final primary = Theme.of(context).colorScheme.primary;

    return Positioned.fromRect(
      key: PdfDropTarget.highlightKey,
      rect: rect,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            // An outline only: a wash over the page dims the very content the
            // reader is aiming at.
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

  /// Records where the pointer is, and reports whether a drop is possible.
  ///
  /// The rebuild this triggers is cheap: `widget.child` is the same instance
  /// every time, so only the Stack and the outline are rebuilt.
  bool _trackPointer(Offset globalPosition) {
    final renderBox = _renderBox;
    if (renderBox == null) {
      return false;
    }

    final local = renderBox.globalToLocal(globalPosition);
    if (_pointerLocal != local) {
      setState(() => _pointerLocal = local);
    }
    return _layoutFor(renderBox).pageCount > 0;
  }

  void _clearPointer() {
    if (_pointerLocal == null) {
      return;
    }
    setState(() => _pointerLocal = null);
  }

  /// This widget's render box, or null before it has been laid out.
  RenderBox? get _renderBox {
    final box = context.findRenderObject() as RenderBox?;
    return box != null && box.hasSize ? box : null;
  }

  PdfPageLayout _layoutFor(RenderBox box) => _layoutCache.of(
        document: widget.document,
        scale: widget.scale,
        viewportWidth: box.size.width,
      );

  /// Maps a global pointer position onto the page column.
  ///
  /// Returns null before this widget has been laid out.
  ({PdfPageLayout layout, Offset contentPoint})? _resolve(
    Offset globalPosition,
  ) {
    final renderBox = _renderBox;
    if (renderBox == null) {
      return null;
    }
    return (
      layout: _layoutFor(renderBox),
      contentPoint:
          renderBox.globalToLocal(globalPosition) + widget.getScrollOffset(),
    );
  }

  /// Whether the document permits its content to be changed.
  bool get _editingAllowed => widget.document.security.allowsEditing;

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
    // The size this image was last adjusted to, if the reader ever adjusted
    // one; objects already on a page are untouched by that and keep theirs.
    // Fitted to this page, which may be smaller than the one it came from.
    final remembered = details.data.lastUsedSize;
    final size = remembered != null
        ? PlacedImagePlacement.fitToPage(remembered, pageSize)
        : PlacedImagePlacement.defaultSizeFor(details.data.aspectRatio, pageSize);

    // Cursor position in unscaled page points. Falls outside the page for an
    // off-page drop; the clamp below pulls the object back inside.
    final pageOrigin = layout.pageRect(pageIndex).topLeft;
    final cursorOnPage = (contentPoint - pageOrigin) / layout.scale;

    final position =
        PlacedImagePlacement.centeredOn(cursorOnPage, size, pageSize);

    final placed = ref.read(placedImagesProvider.notifier).addImage(
          sourceImageId: details.data.sourceImageId,
          imagePath: details.data.imagePath,
          pageIndex: pageIndex,
          position: position,
          size: size,
        );

    ref.read(editorSelectionProvider.notifier).select(placed.id);
  }
}
