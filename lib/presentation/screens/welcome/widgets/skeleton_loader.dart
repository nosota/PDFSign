import 'package:flutter/material.dart';
import 'package:pdfsign/core/theme/app_theme.dart';

/// Skeleton loading placeholder for recent files list
class SkeletonLoader extends StatefulWidget {
  final int itemCount;

  const SkeletonLoader({
    this.itemCount = 3,
    super.key,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header skeleton
        _SkeletonBox(
          width: 150,
          height: 28,
          animation: _animation,
        ),
        const SizedBox(height: AppTheme.spacing16),

        // List items
        ...List.generate(
          widget.itemCount,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
            child: _SkeletonFileCard(animation: _animation),
          ),
        ),
      ],
    );
  }
}

class _SkeletonFileCard extends StatelessWidget {
  final Animation<double> animation;

  const _SkeletonFileCard({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          // Icon skeleton
          _SkeletonBox(
            width: 40,
            height: 40,
            borderRadius: 8,
            animation: animation,
          ),
          const SizedBox(width: AppTheme.spacing12),

          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkeletonBox(
                  width: double.infinity,
                  height: 16,
                  animation: animation,
                ),
                const SizedBox(height: 8),
                _SkeletonBox(
                  width: 150,
                  height: 12,
                  animation: animation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Animation<double> animation;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.animation,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFFE0E0E0),
                Color(0xFFF5F5F5),
                Color(0xFFE0E0E0),
              ],
              stops: [
                animation.value - 0.3,
                animation.value,
                animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ),
          ),
        );
      },
    );
  }
}
