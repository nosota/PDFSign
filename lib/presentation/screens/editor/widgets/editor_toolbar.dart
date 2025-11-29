import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/editor_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_provider.dart';

/// Top toolbar with Undo/Redo and Zoom controls
class EditorToolbar extends ConsumerWidget {
  const EditorToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final zoomLevel = ref.watch(zoomLevelProvider);
    final undoRedoState = ref.watch(undoRedoProvider);

    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F7),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E7),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppTheme.spacing8),

          // Undo button
          _ToolbarIconButton(
            icon: Icons.undo,
            tooltip: '${l10n.undo} (⌘Z)',
            onPressed: () {
              ref.read(undoRedoProvider.notifier).undo();
            },
            enabled: undoRedoState.canUndo,
          ),

          const SizedBox(width: AppTheme.spacing4),

          // Redo button
          _ToolbarIconButton(
            icon: Icons.redo,
            tooltip: '${l10n.redo} (⌘⇧Z)',
            onPressed: () {
              ref.read(undoRedoProvider.notifier).redo();
            },
            enabled: undoRedoState.canRedo,
          ),

          const SizedBox(width: AppTheme.spacing16),
          const _VerticalDivider(),
          const SizedBox(width: AppTheme.spacing16),

          // Zoom out button
          _ToolbarIconButton(
            icon: Icons.remove,
            tooltip: '${l10n.zoomOut} (⌘-)',
            onPressed: () {
              ref.read(zoomLevelProvider.notifier).zoomOut();
            },
          ),

          const SizedBox(width: AppTheme.spacing8),

          // Zoom percentage dropdown
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E5E7)),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<double>(
                value: _getNearestZoomPreset(zoomLevel),
                items: const [
                  DropdownMenuItem(value: 0.5, child: Text('50%')),
                  DropdownMenuItem(value: 0.75, child: Text('75%')),
                  DropdownMenuItem(value: 1.0, child: Text('100%')),
                  DropdownMenuItem(value: 1.25, child: Text('125%')),
                  DropdownMenuItem(value: 1.5, child: Text('150%')),
                  DropdownMenuItem(value: 2.0, child: Text('200%')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    ref.read(zoomLevelProvider.notifier).setZoom(value);
                  }
                },
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1A1A1A),
                ),
                isDense: true,
              ),
            ),
          ),

          const SizedBox(width: AppTheme.spacing8),

          // Zoom in button
          _ToolbarIconButton(
            icon: Icons.add,
            tooltip: '${l10n.zoomIn} (⌘+)',
            onPressed: () {
              ref.read(zoomLevelProvider.notifier).zoomIn();
            },
          ),

          const SizedBox(width: AppTheme.spacing16),

          // Fit to screen button
          _ToolbarIconButton(
            icon: Icons.fit_screen,
            tooltip: '${l10n.fitToScreen} (⌘1)',
            onPressed: () {
              // TODO: Implement fit to screen
            },
          ),

          const Spacer(),

          // Page indicator (placeholder)
          Text(
            'Page 1 of 1',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF6B6B6B),
                ),
          ),

          const SizedBox(width: AppTheme.spacing16),
        ],
      ),
    );
  }

  /// Get nearest zoom preset for dropdown
  double _getNearestZoomPreset(double zoom) {
    const presets = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    return presets.reduce((a, b) {
      return (a - zoom).abs() < (b - zoom).abs() ? a : b;
    });
  }
}

/// Toolbar icon button widget
class _ToolbarIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool enabled;

  const _ToolbarIconButton({
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: enabled ? onPressed : null,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
        color: const Color(0xFF1A1A1A),
        disabledColor: const Color(0xFFB0B0B0),
        splashRadius: 20,
      ),
    );
  }
}

/// Vertical divider widget
class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24,
      color: const Color(0xFFE5E5E7),
    );
  }
}
