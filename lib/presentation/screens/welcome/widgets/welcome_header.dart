import 'package:flutter/material.dart';
import 'package:pdfsign/core/theme/app_theme.dart';

/// Header section of welcome screen with logo and title
class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Animated PDF Icon
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            decoration: BoxDecoration(
              color: const Color(0xFF0066FF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.picture_as_pdf,
              size: 64,
              color: Color(0xFF0066FF),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacing24),

        // App Title
        Text(
          'PDFSign',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
        ),
        const SizedBox(height: AppTheme.spacing8),

        // Subtitle
        Text(
          'Sign and manage your PDF documents',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF6B6B6B),
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
