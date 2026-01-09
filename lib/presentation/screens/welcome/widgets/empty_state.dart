import 'package:flutter/material.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/app_localizations.dart';

/// Empty state widget for when there are no recent files
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Illustration
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.folder_open,
                size: 64,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacing24),

          // Title
          Text(
            l10n.noRecentFiles,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF424242),
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),

          // Description
          Text(
            l10n.noRecentFilesDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B6B6B),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
