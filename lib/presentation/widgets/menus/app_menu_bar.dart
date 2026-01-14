import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/file_picker_provider.dart';
import 'package:pdfsign/presentation/providers/recent_files_provider.dart';

/// Base menu bar builder with common File menu items.
///
/// Provides Open, Open Recent, Save, Save As, Share, and Close Window functionality.
/// All menu labels are localized via AppLocalizations.
class AppMenuBar extends ConsumerWidget {
  const AppMenuBar({
    required this.child,
    required this.localizations,
    this.includeSaveMenu = false,
    this.onSave,
    this.onSaveAs,
    this.includeShare = false,
    this.onShare,
    this.onFileOpened,
    super.key,
  });

  /// The child widget to wrap with the menu bar.
  final Widget child;

  /// Localization strings.
  final AppLocalizations localizations;

  /// Whether to include Save and Save As menu items.
  final bool includeSaveMenu;

  /// Callback when Save is selected.
  final VoidCallback? onSave;

  /// Callback when Save As is selected.
  final VoidCallback? onSaveAs;

  /// Whether to include the Share menu item.
  final bool includeShare;

  /// Callback when Share is selected.
  final VoidCallback? onShare;

  /// Callback when a file is successfully opened.
  final VoidCallback? onFileOpened;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return PlatformMenuBar(
      menus: [
        // macOS App menu (first menu is always the app menu)
        const PlatformMenu(
          label: 'PDFSign',
          menus: [
            PlatformProvidedMenuItem(
              type: PlatformProvidedMenuItemType.about,
            ),
            PlatformMenuItemGroup(
              members: [
                PlatformProvidedMenuItem(
                  type: PlatformProvidedMenuItemType.quit,
                ),
              ],
            ),
          ],
        ),
        // File menu
        PlatformMenu(
          label: localizations.menuFile,
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
      // Group 1: Open
      PlatformMenuItemGroup(
        members: [
          PlatformMenuItem(
            label: localizations.menuOpen,
            shortcut: const SingleActivator(
              LogicalKeyboardKey.keyO,
              meta: true,
            ),
            onSelected: () => _handleOpen(ref, onFileOpened),
          ),
        ],
      ),
      // Group 2: Open Recent submenu
      PlatformMenuItemGroup(
        members: [
          _buildOpenRecentMenu(ref, recentFilesAsync, onFileOpened),
        ],
      ),
    ];

    // Group 3: Save and Save As (optional)
    if (includeSaveMenu) {
      items.add(
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: localizations.menuSave,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyS,
                meta: true,
              ),
              onSelected: onSave,
            ),
            PlatformMenuItem(
              label: localizations.menuSaveAs,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyS,
                meta: true,
                shift: true,
              ),
              onSelected: onSaveAs,
            ),
          ],
        ),
      );
    }

    // Group 4: Share (optional)
    if (includeShare) {
      items.add(
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: localizations.menuShare,
              onSelected: onShare,
            ),
          ],
        ),
      );
    }

    // Group 5: Close Window
    items.add(
      PlatformMenuItemGroup(
        members: [
          PlatformMenuItem(
            label: localizations.menuCloseWindow,
            shortcut: const SingleActivator(
              LogicalKeyboardKey.keyW,
              meta: true,
            ),
            onSelected: () => _handleCloseWindow(),
          ),
        ],
      ),
    );

    return items;
  }

  PlatformMenu _buildOpenRecentMenu(
    WidgetRef ref,
    AsyncValue<List<RecentFile>> recentFilesAsync,
    VoidCallback? onFileOpened,
  ) {
    final recentFiles = recentFilesAsync.valueOrNull ?? [];

    final menuItems = <PlatformMenuItem>[];

    if (recentFiles.isNotEmpty) {
      // Group 1: Recent files (up to 10)
      final recentFileItems = <PlatformMenuItem>[];
      for (final file in recentFiles.take(10)) {
        recentFileItems.add(
          PlatformMenuItem(
            label: file.fileName,
            onSelected: () => _handleOpenRecent(ref, file.path, onFileOpened),
          ),
        );
      }
      menuItems.add(
        PlatformMenuItemGroup(members: recentFileItems),
      );

      // Group 2: Clear Menu
      menuItems.add(
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: localizations.menuClearMenu,
              onSelected: () =>
                  ref.read(recentFilesProvider.notifier).clearAll(),
            ),
          ],
        ),
      );
    } else {
      // No recent files - single disabled item
      menuItems.add(
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: localizations.menuNoRecentFiles,
              onSelected: null,
            ),
          ],
        ),
      );
    }

    return PlatformMenu(
      label: localizations.menuOpenRecent,
      menus: menuItems,
    );
  }

  Future<void> _handleOpen(WidgetRef ref, VoidCallback? onFileOpened) async {
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
      final windowId = await WindowManagerService.instance.createPdfWindow(path);
      if (windowId != null) {
        onFileOpened?.call();
      }
    }
  }

  Future<void> _handleOpenRecent(
    WidgetRef ref,
    String path,
    VoidCallback? onFileOpened,
  ) async {
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
    final windowId = await WindowManagerService.instance.createPdfWindow(path);
    if (windowId != null) {
      onFileOpened?.call();
    }
  }

  Future<void> _handleCloseWindow() async {
    await WindowManagerService.instance.closeCurrentWindow();
  }
}
