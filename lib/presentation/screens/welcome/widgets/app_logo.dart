import 'package:flutter/material.dart';
import 'package:pdfsign/core/constants/spacing.dart';
import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/core/theme/app_typography.dart';

/// Application logo widget displayed on welcome screen.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.edit_document,
            size: 48,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: Spacing.spacing16),
        const Text(
          'PDFSign',
          style: AppTypography.displayLarge,
        ),
      ],
    );
  }
}
