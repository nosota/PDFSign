import 'package:flutter/material.dart';

import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';

/// Zoom controls widget with dropdown and +/- buttons.
class ZoomControls extends StatelessWidget {
  const ZoomControls({
    required this.currentScale,
    required this.isFitWidth,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onFitWidth,
    required this.onPresetSelected,
    super.key,
  });

  /// Current scale value.
  final double currentScale;

  /// Whether currently in fit-width mode.
  final bool isFitWidth;

  /// Called when zoom in button is pressed.
  final VoidCallback onZoomIn;

  /// Called when zoom out button is pressed.
  final VoidCallback onZoomOut;

  /// Called when fit to width is selected.
  final VoidCallback onFitWidth;

  /// Called when a preset is selected from dropdown.
  final void Function(double scale) onPresetSelected;

  String get _zoomLabel {
    if (isFitWidth) return 'Fit Width';
    final percent = (currentScale * 100).round();
    return '$percent%';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ZoomButton(
            icon: Icons.remove,
            onPressed: onZoomOut,
            tooltip: 'Zoom Out (⌘-)',
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.border,
          ),
          _ZoomDropdown(
            label: _zoomLabel,
            isFitWidth: isFitWidth,
            onFitWidth: onFitWidth,
            onPresetSelected: onPresetSelected,
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.border,
          ),
          _ZoomButton(
            icon: Icons.add,
            onPressed: onZoomIn,
            tooltip: 'Zoom In (⌘+)',
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 20,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ZoomDropdown extends StatelessWidget {
  const _ZoomDropdown({
    required this.label,
    required this.isFitWidth,
    required this.onFitWidth,
    required this.onPresetSelected,
  });

  final String label;
  final bool isFitWidth;
  final VoidCallback onFitWidth;
  final void Function(double scale) onPresetSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ZoomPreset>(
      onSelected: (preset) {
        if (preset == ZoomPreset.fitWidth) {
          onFitWidth();
        } else if (preset.scale != null) {
          onPresetSelected(preset.scale!);
        }
      },
      tooltip: 'Select zoom level',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        final presets = ZoomPreset.values.where((p) => p != ZoomPreset.custom);
        return presets.map((preset) {
          final isSelected = preset == ZoomPreset.fitWidth
              ? isFitWidth
              : preset.scale != null &&
                  (preset.scale! - (isFitWidth ? 0 : 1.0)).abs() < 0.01;
          return PopupMenuItem<ZoomPreset>(
            value: preset,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: isSelected
                      ? const Icon(Icons.check, size: 16)
                      : null,
                ),
                const SizedBox(width: 8),
                Text(
                  preset.label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
