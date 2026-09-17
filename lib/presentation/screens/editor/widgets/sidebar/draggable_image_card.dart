import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_comment_field.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_thumbnail_card.dart';

/// Data object passed during drag operation.
class DraggableSidebarImage {
  final String sourceImageId;
  final String imagePath;
  final int width;
  final int height;

  /// The size this image was last given on a page, in PDF points.
  ///
  /// Null until the reader has resized one, and the drop falls back to the
  /// default size for the page.
  final Size? lastUsedSize;

  const DraggableSidebarImage({
    required this.sourceImageId,
    required this.imagePath,
    required this.width,
    required this.height,
    this.lastUsedSize,
  });

  /// Aspect ratio (width / height), falling back to 1 for unusable dimensions.
  double get aspectRatio {
    final ratio = width / height;
    return ratio.isFinite && ratio > 0 ? ratio : 1.0;
  }

  factory DraggableSidebarImage.fromSidebarImage(SidebarImage image) {
    return DraggableSidebarImage(
      sourceImageId: image.id,
      imagePath: image.filePath,
      width: image.width,
      height: image.height,
      lastUsedSize: image.lastUsedSize,
    );
  }
}

/// Image card: drag it onto the document, hold its grip to reorder the list.
///
/// Structure:
/// ```
/// ┌────┬──────────────────────┐
/// │ ⋮⋮ │   🖼 image.png       │
/// │    │                      │
/// │grip│  ← drag = to PDF     │
/// └────┴──────────────────────┘
/// │        Comment text...    │
/// └───────────────────────────┘
/// ```
///
/// The grip and the thumbnail are both inside the drag to the document, so a
/// drag that begins anywhere on the row carries the image to the page. The
/// grip additionally reorders the list, but only after being **held**.
///
/// The two used to be separated by position alone — grip reorders, thumbnail
/// carries — and the grip is 28 points wide against a sidebar of two hundred.
/// Beginning a drag a few points too far left silently rearranged the library,
/// which is shared by every open window and has no undo. A hold is a small
/// price for the reader who reorders; catching the other case is worth it.
///
/// The comment field is left outside the drag: it is a text field, and a drag
/// across it belongs to selecting its text.
class DraggableImageCard extends ConsumerWidget {
  const DraggableImageCard({
    required this.image,
    required this.index,
    required this.isSelected,
    super.key,
  });

  final SidebarImage image;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragData = DraggableSidebarImage.fromSidebarImage(image);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Grip and thumbnail together: a drag beginning anywhere across them
        // carries the image to the page.
        Draggable<DraggableSidebarImage>(
          data: dragData,
          // Anchor the drag to the pointer rather than to the point grabbed
          // inside the thumbnail. With the default childDragAnchorStrategy,
          // DragTargetDetails.offset reports the feedback's top-left corner,
          // not the cursor, which made PdfDropTarget place the image up and to
          // the left of the drop point. The feedback is re-centred on the
          // pointer in _buildDragFeedback().
          dragAnchorStrategy: pointerDragAnchorStrategy,
          feedback: _buildDragFeedback(context),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: _row(const _GripHandle(), selected: false),
          ),
          child: _row(
            // Held rather than grabbed: an immediate listener here would take
            // every drag that began a few points too far left and turn it into
            // a rearrangement of the library.
            ReorderableDelayedDragStartListener(
              index: index,
              child: const _GripHandle(),
            ),
            selected: isSelected,
          ),
        ),

        // Comment field
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 4),
          child: ImageCommentField(
            comment: image.comment,
            onCommentChanged: (comment) {
              ref
                  .read(sidebarImagesProvider.notifier)
                  .updateComment(image.id, comment);
            },
            onEditingStarted: () {
              // Clear PDF object selection when editing sidebar comment
              ref.read(editorSelectionProvider.notifier).clear();
            },
          ),
        ),
      ],
    );
  }

  /// The grip beside the thumbnail.
  Widget _row(Widget grip, {required bool selected}) => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            grip,
            Expanded(
              child: ImageThumbnailCard(image: image, isSelected: selected),
            ),
          ],
        ),
      );

  /// Builds the drag ghost, centred on the pointer.
  ///
  /// Under [pointerDragAnchorStrategy] the feedback is rendered with its
  /// top-left corner at the cursor, so it is shifted back by half its size to
  /// sit centred under the cursor — the same point `PdfDropTarget` centres the
  /// placed object on, so the object does not shift when released.
  ///
  /// Only the centre is preserved, not the size: this ghost is capped at
  /// `maxSize` logical pixels, while the placed object is 25% of the page
  /// width scaled by the current zoom. The object therefore grows or shrinks
  /// about the drop point — roughly 37 px at 25% zoom, ~450 px at 300%.
  Widget _buildDragFeedback(BuildContext context) {
    const maxSize = 150.0;
    final aspectRatio = image.aspectRatio;

    double width, height;
    if (aspectRatio > 1) {
      width = maxSize;
      height = maxSize / aspectRatio;
    } else {
      height = maxSize;
      width = maxSize * aspectRatio;
    }

    return Transform.translate(
      offset: Offset(-width / 2, -height / 2),
      child: Material(
        color: Colors.transparent,
        child: Image.file(
          File(image.filePath),
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

/// Grip handle for reordering items in the list.
class _GripHandle extends StatefulWidget {
  const _GripHandle();

  @override
  State<_GripHandle> createState() => _GripHandleState();
}

class _GripHandleState extends State<_GripHandle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.onSurfaceVariant;

    return Tooltip(
      // The hold is not something a reader can see; the grip has to say so.
      message: AppLocalizations.of(context)?.holdToReorder ?? '',
      // Shown on hover and nothing else. Left to itself a tooltip also waits
      // for a long press — the very gesture the grip needs — and takes it,
      // which stopped the list being reordered at all. Measured, then fixed.
      triggerMode: TooltipTriggerMode.manual,
      child: MouseRegion(
        cursor: SystemMouseCursors.grab,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          width: 28,
          margin: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
          decoration: BoxDecoration(
            color:
                _isHovered ? theme.colorScheme.surfaceContainerHighest : null,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(6),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.drag_indicator,
              size: 20,
              color: _isHovered ? baseColor : baseColor.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
