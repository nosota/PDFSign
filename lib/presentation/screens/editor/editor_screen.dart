import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/core/theme/app_typography.dart';

/// PDF Editor screen placeholder.
///
/// Will be implemented in the next iteration.
class EditorScreen extends StatelessWidget {
  const EditorScreen({
    required this.filePath,
    super.key,
  });

  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(
          filePath?.split('/').last ?? 'Editor',
          style: AppTypography.displaySmall,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'PDF Editor',
              style: AppTypography.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              filePath ?? 'No file selected',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Coming soon...',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
