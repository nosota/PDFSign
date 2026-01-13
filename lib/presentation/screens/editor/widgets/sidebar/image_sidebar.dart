import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/constants/sidebar_constants.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_images_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_selection_provider.dart';
import 'package:pdfsign/presentation/providers/sidebar/sidebar_width_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/add_image_button.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_list.dart';

/// Main sidebar panel widget for displaying and managing images.
///
/// Features:
/// - Resizable width
/// - Drag-drop from Finder
/// - Scrollable image list with reordering
/// - Add button at bottom
class ImageSidebar extends ConsumerStatefulWidget {
  const ImageSidebar({super.key});

  @override
  ConsumerState<ImageSidebar> createState() => _ImageSidebarState();
}

class _ImageSidebarState extends ConsumerState<ImageSidebar> {
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final width = ref.watch(sidebarWidthProvider);
    final imagesAsync = ref.watch(sidebarImagesProvider);

    return GestureDetector(
      // Clear selection when clicking empty area
      onTap: () => ref.read(sidebarSelectionProvider.notifier).clear(),
      child: Container(
        width: width,
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Image list with drop target
            Expanded(
              child: DropTarget(
                onDragEntered: (_) => setState(() => _isDragging = true),
                onDragExited: (_) => setState(() => _isDragging = false),
                onDragDone: _handleFileDrop,
                child: Container(
                  decoration: BoxDecoration(
                    border: _isDragging
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          )
                        : null,
                  ),
                  child: imagesAsync.when(
                    data: (images) {
                      if (images.isEmpty) {
                        return _buildEmptyState(context);
                      }
                      return ImageList(images: images);
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) => Center(
                      child: Text('Error: $error'),
                    ),
                  ),
                ),
              ),
            ),

            // Add button
            const AddImageButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: SidebarConstants.headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.image_outlined,
            size: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            'Images',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'Drop images here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'or click Add Image',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleFileDrop(DropDoneDetails details) {
    setState(() => _isDragging = false);

    final paths = details.files
        .where((f) => _isImageFile(f.path))
        .map((f) => f.path)
        .toList();

    if (paths.isNotEmpty) {
      ref.read(sidebarImagesProvider.notifier).addImages(paths);
    }
  }

  bool _isImageFile(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.bmp') ||
        lower.endsWith('.tiff') ||
        lower.endsWith('.tif');
  }
}
