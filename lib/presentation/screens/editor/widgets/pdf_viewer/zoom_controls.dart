import 'package:flutter/material.dart';

import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_state.dart';

/// Zoom controls widget with dropdown and +/- buttons.
class ZoomControls extends StatelessWidget {
  const ZoomControls({
    required this.currentZoom,
    required this.onZoomChanged,
    required this.onZoomIn,
    required this.onZoomOut,
    super.key,
  });

  /// Currently selected zoom level.
  final ZoomLevel currentZoom;

  /// Called when zoom level is changed via dropdown.
  final void Function(ZoomLevel) onZoomChanged;

  /// Called when zoom in button is pressed.
  final VoidCallback onZoomIn;

  /// Called when zoom out button is pressed.
  final VoidCallback onZoomOut;

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
            onPressed: currentZoom.previous != null ? onZoomOut : null,
            tooltip: 'Zoom Out',
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.border,
          ),
          _ZoomDropdown(
            currentZoom: currentZoom,
            onChanged: onZoomChanged,
          ),
          Container(
            width: 1,
            height: 24,
            color: AppColors.border,
          ),
          _ZoomButton(
            icon: Icons.add,
            onPressed: currentZoom.next != null ? onZoomIn : null,
            tooltip: 'Zoom In',
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
  final VoidCallback? onPressed;
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
            color: onPressed != null
                ? AppColors.textPrimary
                : AppColors.textDisabled,
          ),
        ),
      ),
    );
  }
}

class _ZoomDropdown extends StatelessWidget {
  const _ZoomDropdown({
    required this.currentZoom,
    required this.onChanged,
  });

  final ZoomLevel currentZoom;
  final void Function(ZoomLevel) onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ZoomLevel>(
      initialValue: currentZoom,
      onSelected: onChanged,
      tooltip: 'Select zoom level',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentZoom.label,
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
      itemBuilder: (context) => ZoomLevel.values
          .map(
            (level) => PopupMenuItem<ZoomLevel>(
              value: level,
              child: Text(
                level.label,
                style: TextStyle(
                  fontWeight: level == currentZoom
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
