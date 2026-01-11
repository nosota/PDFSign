import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/presentation/providers/file_picker_provider.dart';
import 'package:pdfsign/presentation/providers/recent_files_provider.dart';

/// Base menu bar builder with common File menu items.
///
/// Provides Open, Open Recent, and Close Window functionality.
class AppMenuBar extends ConsumerWidget {
  const AppMenuBar({
    required this.child,
    this.includeShare = false,
    this.onShare,
    super.key,
  });

  /// The child widget to wrap with the menu bar.
  final Widget child;

  /// Whether to include the Share menu item.
  final bool includeShare;

  /// Callback when Share is selected.
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: 'File',
          menus: _buildFileMenuItems(context, ref, recentFilesAsync),
        ),
      ],
      child: child,
    );
  }

  List<PlatformMenuItem> _buildFileMenuItems(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<RecentFile>> recentFilesAsync,
  ) {
    final items = <PlatformMenuItem>[
      // Open...
      PlatformMenuItem(
        label: 'Open...',
        shortcut: const SingleActivator(
          LogicalKeyboardKey.keyO,
          meta: true,
        ),
        onSelected: () => _handleOpen(ref),
      ),
      // Separator
      const PlatformMenuItemGroup(members: []),
      // Open Recent submenu
      _buildOpenRecentMenu(ref, recentFilesAsync),
    ];

    // Share (optional)
    if (includeShare) {
      items.addAll([
        const PlatformMenuItemGroup(members: []),
        PlatformMenuItem(
          label: 'Share...',
          onSelected: onShare,
        ),
      ]);
    }

    // Close Window
    items.addAll([
      const PlatformMenuItemGroup(members: []),
      PlatformMenuItem(
        label: 'Close Window',
        shortcut: const SingleActivator(
          LogicalKeyboardKey.keyW,
          meta: true,
        ),
        onSelected: () => _handleCloseWindow(),
      ),
    ]);

    return items;
  }

  PlatformMenu _buildOpenRecentMenu(
    WidgetRef ref,
    AsyncValue<List<RecentFile>> recentFilesAsync,
  ) {
    final recentFiles = recentFilesAsync.valueOrNull ?? [];

    final menuItems = <PlatformMenuItem>[];

    // Recent files (up to 10)
    for (final file in recentFiles.take(10)) {
      menuItems.add(
        PlatformMenuItem(
          label: file.fileName,
          onSelected: () => _handleOpenRecent(ref, file.path),
        ),
      );
    }

    // Separator and Clear Menu (if there are recent files)
    if (recentFiles.isNotEmpty) {
      menuItems.addAll([
        const PlatformMenuItemGroup(members: []),
        PlatformMenuItem(
          label: 'Clear Menu',
          onSelected: () => ref.read(recentFilesProvider.notifier).clearAll(),
        ),
      ]);
    } else {
      // Show disabled "No Recent Files" item
      menuItems.add(
        const PlatformMenuItem(
          label: 'No Recent Files',
          onSelected: null,
        ),
      );
    }

    return PlatformMenu(
      label: 'Open Recent',
      menus: menuItems,
    );
  }

  Future<void> _handleOpen(WidgetRef ref) async {
    final filePicker = ref.read(pdfFilePickerProvider.notifier);
    final path = await filePicker.pickPdf();

    if (path != null) {
      final fileName = path.split('/').last;

      // Add to recent files
      await ref.read(recentFilesProvider.notifier).addFile(
            RecentFile(
              path: path,
              fileName: fileName,
              lastOpened: DateTime.now(),
              pageCount: 0,
              isPasswordProtected: false,
            ),
          );

      // Open in new window
      await WindowManagerService.instance.createPdfWindow(path);
    }
  }

  Future<void> _handleOpenRecent(WidgetRef ref, String path) async {
    // Update last opened time
    final fileName = path.split('/').last;
    await ref.read(recentFilesProvider.notifier).addFile(
          RecentFile(
            path: path,
            fileName: fileName,
            lastOpened: DateTime.now(),
            pageCount: 0,
            isPasswordProtected: false,
          ),
        );

    // Open in new window
    await WindowManagerService.instance.createPdfWindow(path);
  }

  Future<void> _handleCloseWindow() async {
    await WindowManagerService.instance.closeCurrentWindow();
  }
}
