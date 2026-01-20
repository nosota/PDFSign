import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/core/window/window_broadcast.dart';
import 'package:pdfsign/core/window/window_manager_service.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/global_dirty_state_provider.dart';
import 'package:pdfsign/presentation/providers/editor/size_unit_preference_provider.dart';
import 'package:pdfsign/presentation/providers/locale_preference_provider.dart';
import 'package:pdfsign/presentation/widgets/dialogs/close_all_dialog.dart';
import 'package:pdfsign/presentation/widgets/menus/app_menu_bar.dart';

/// Root app widget for the settings window.
///
/// Displays app preferences in a macOS-style layout:
/// - Sidebar with sections on the left
/// - Content area on the right
/// Fixed size 650x500, not resizable.
class SettingsApp extends ConsumerStatefulWidget {
  const SettingsApp({super.key});

  @override
  ConsumerState<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends ConsumerState<SettingsApp>
    with WindowListener {
  /// Navigator key for showing dialogs.
  final _navigatorKey = GlobalKey<NavigatorState>();

  /// Whether this window currently has focus.
  /// Only focused window renders PlatformMenuBar to avoid conflicts.
  bool _isWindowFocused = true;

  @override
  void initState() {
    super.initState();
    _initWindowBroadcast();

    // Register window listener for focus tracking and close interception
    windowManager.addListener(this);
    windowManager.setPreventClose(true);

    // DEBUG: Log window ID on startup
    if (kDebugMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final controller = await WindowController.fromCurrentEngine();
        print('>>> Settings window started with ID: ${controller.windowId}');
      });
    }
  }

  /// Initializes window broadcast for receiving preference change notifications.
  Future<void> _initWindowBroadcast() async {
    WindowBroadcast.setOnUnitChanged(_handleUnitChanged);
    WindowBroadcast.setOnLocaleChanged(_handleLocaleChanged);
    await WindowBroadcast.init();
  }

  /// Handles unit changed broadcast from another window.
  void _handleUnitChanged() {
    ref.read(sizeUnitPreferenceProvider.notifier).reload();
  }

  /// Handles locale changed broadcast from another window.
  void _handleLocaleChanged() {
    ref.read(localePreferenceProvider.notifier).reload();
  }

  @override
  void onWindowFocus() {
    _isWindowFocused = true;
    setState(() {});
  }

  @override
  void onWindowBlur() {
    _isWindowFocused = false;
    setState(() {});
  }

  /// Handles window close notification.
  /// If this is the last visible window, terminates the application.
  @override
  void onWindowClose() async {
    final service = WindowManagerService.instance;

    // Clean up resources BEFORE window closes
    windowManager.removeListener(this);
    service.clearSettingsWindowId();
    WindowBroadcast.setOnUnitChanged(null);
    WindowBroadcast.setOnLocaleChanged(null);

    // Check if there are other visible windows
    final hasOpenPdfs = service.hasOpenWindows;
    final isWelcomeVisible = !service.isWelcomeHidden;

    if (!hasOpenPdfs && !isWelcomeVisible) {
      // This is the last visible window - terminate the app
      exit(0);
    }

    // Other visible windows exist - just close this window
    // Using windowManager.destroy() is safe now because
    // applicationShouldTerminateAfterLastWindowClosed = false in AppDelegate
    await windowManager.destroy();
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('>>> Settings dispose() called');
    }
    // Cleanup already done in onWindowClose(), but do it again just in case
    // (dispose might be called without onWindowClose in some scenarios)
    try {
      windowManager.removeListener(this);
    } catch (_) {}
    WindowManagerService.instance.clearSettingsWindowId();
    WindowBroadcast.setOnUnitChanged(null);
    WindowBroadcast.setOnLocaleChanged(null);
    super.dispose();
  }

  /// Handles Close All menu action.
  ///
  /// Shows CloseAllDialog if any PDF windows have unsaved changes,
  /// then broadcasts close to all PDF windows.
  Future<void> _handleCloseAll() async {
    final navigatorContext = _navigatorKey.currentContext;
    if (navigatorContext == null) return;

    final globalState = ref.read(globalDirtyStateProvider);
    final dirtyCount = globalState.values.where((d) => d).length;

    if (dirtyCount == 0) {
      // No dirty windows, close all without dialog
      await WindowBroadcast.broadcastCloseAll();
      return;
    }

    // Show close all dialog
    final result = await CloseAllDialog.show(navigatorContext, dirtyCount);

    switch (result) {
      case CloseAllResult.saveAll:
        // Save all dirty windows first, then close all
        await WindowBroadcast.broadcastSaveAll();
        // Small delay to ensure saves complete
        await Future.delayed(const Duration(milliseconds: 100));
        await WindowBroadcast.broadcastCloseAll();
        break;
      case CloseAllResult.discard:
        // Close all without saving
        await WindowBroadcast.broadcastCloseAll();
        break;
      case CloseAllResult.cancel:
      case null:
        // User cancelled, do nothing
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch locale preference for live updates
    ref.watch(localePreferenceProvider);
    final locale = ref.watch(localePreferenceProvider.notifier).getLocale();

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Settings',
      theme: createAppTheme(),
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: allSupportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Only render PlatformMenuBar when this window has focus.
        // This prevents multiple windows from fighting over the native menu.
        if (!_isWindowFocused) {
          return child!;
        }

        final l10n = AppLocalizations.of(context)!;
        final hasOpenPdfs = WindowManagerService.instance.hasOpenWindows;
        return AppMenuBar(
          localizations: l10n,
          navigatorKey: _navigatorKey,
          // Settings window: hide Save, Save As, Save All, and Share
          includeSave: false,
          includeSaveAs: false,
          includeSaveAll: false,
          includeShare: false,
          // Close All - enabled only if there are PDF windows
          includeCloseAll: true,
          onCloseAll: _handleCloseAll,
          isCloseAllEnabled: hasOpenPdfs,
          // Use windowManager.close() which triggers onWindowClose() for cleanup
          onCloseWindow: () => windowManager.close(),
          child: child!,
        );
      },
      home: const _SettingsContent(),
    );
  }
}

/// Main content of the settings window.
class _SettingsContent extends StatelessWidget {
  const _SettingsContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const _SettingsSidebar(selectedSection: 'general'),
          const VerticalDivider(width: 1, thickness: 1),
          const Expanded(child: _GeneralSection()),
        ],
      ),
    );
  }
}

// =============================================================================
// Sidebar
// =============================================================================

class _SettingsSidebar extends StatelessWidget {
  const _SettingsSidebar({required this.selectedSection});

  final String selectedSection;

  static const _backgroundColor = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: 160,
      color: _backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12),
          _SidebarItem(
            icon: Icons.tune,
            label: l10n.settingsGeneral,
            isSelected: selectedSection == 'general',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSelected
        ? const Color(0xFFE0E0E0)
        : _isHovered
            ? const Color(0xFFEAEAEA)
            : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: Colors.black87,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// General Section
// =============================================================================

class _GeneralSection extends StatelessWidget {
  const _GeneralSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Language section
          _SectionHeader(label: l10n.settingsLanguage),
          const SizedBox(height: 8),
          const Expanded(child: _SearchableLanguageList()),

          const SizedBox(height: 24),

          // Units section
          _SectionHeader(label: l10n.settingsUnits),
          const SizedBox(height: 8),
          const _UnitsList(),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}

// =============================================================================
// Searchable Language List
// =============================================================================

class _SearchableLanguageList extends ConsumerStatefulWidget {
  const _SearchableLanguageList();

  @override
  ConsumerState<_SearchableLanguageList> createState() =>
      _SearchableLanguageListState();
}

class _SearchableLanguageListState
    extends ConsumerState<_SearchableLanguageList> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SupportedLocale> get _filteredLocales {
    if (_searchQuery.isEmpty) return supportedLocales;
    final q = _searchQuery.toLowerCase();
    return supportedLocales
        .where((locale) =>
            locale.nativeName.toLowerCase().contains(q) ||
            locale.englishName.toLowerCase().contains(q))
        .toList();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = '');
  }

  void _selectLocale(String? code) {
    ref.read(localePreferenceProvider.notifier).setLocale(code);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selectedLocale = ref.watch(localePreferenceProvider);

    return Column(
      children: [
        // Search field
        SizedBox(
          height: 36,
          child: TextField(
            controller: _searchController,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: l10n.settingsSearchLanguages,
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
              prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey[600]),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, size: 16, color: Colors.grey[600]),
                      onPressed: _clearSearch,
                      padding: EdgeInsets.zero,
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),

        const SizedBox(height: 8),

        // Language list
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredLocales.length + 2,
                itemBuilder: (context, index) {
                  // System Default (always first)
                  if (index == 0) {
                    return _LanguageListItem(
                      label: '★ ${l10n.settingsLanguageSystem}',
                      isSelected: selectedLocale == null,
                      onTap: () => _selectLocale(null),
                    );
                  }
                  // Divider
                  if (index == 1) {
                    return const Divider(height: 1, thickness: 1);
                  }
                  // Regular locales
                  final locale = _filteredLocales[index - 2];
                  return _LanguageListItem(
                    label: locale.displayName,
                    isSelected: selectedLocale == locale.code,
                    onTap: () => _selectLocale(locale.code),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LanguageListItem extends StatefulWidget {
  const _LanguageListItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_LanguageListItem> createState() => _LanguageListItemState();
}

class _LanguageListItemState extends State<_LanguageListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSelected
        ? const Color(0xFFE3F2FD)
        : _isHovered
            ? const Color(0xFFF0F0F0)
            : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: const TextStyle(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.isSelected)
                const Icon(Icons.check, size: 16, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Units List
// =============================================================================

class _UnitsList extends ConsumerWidget {
  const _UnitsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedUnit = ref.watch(sizeUnitPreferenceProvider);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SelectableListItem(
              label: l10n.settingsUnitsCentimeters,
              isSelected: selectedUnit == SizeUnit.cm,
              onTap: () => ref
                  .read(sizeUnitPreferenceProvider.notifier)
                  .setUnit(SizeUnit.cm),
            ),
            const Divider(height: 1, thickness: 1),
            _SelectableListItem(
              label: l10n.settingsUnitsInches,
              isSelected: selectedUnit == SizeUnit.inch,
              onTap: () => ref
                  .read(sizeUnitPreferenceProvider.notifier)
                  .setUnit(SizeUnit.inch),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectableListItem extends StatefulWidget {
  const _SelectableListItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_SelectableListItem> createState() => _SelectableListItemState();
}

class _SelectableListItemState extends State<_SelectableListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSelected
        ? const Color(0xFFE3F2FD)
        : _isHovered
            ? const Color(0xFFF0F0F0)
            : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              if (widget.isSelected)
                const Icon(Icons.check, size: 16, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
