import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfsign/core/router/app_router.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/app_localizations.dart';
import 'package:pdfsign/presentation/providers/settings/settings_provider.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/drag_drop_zone.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/empty_state.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/recent_files_list.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/skeleton_loader.dart';
import 'package:pdfsign/presentation/screens/welcome/widgets/welcome_header.dart';

/// Welcome screen with drag & drop, file picker, and recent files history
///
/// This is the main entry point of the application.
/// Features:
/// - Drag & drop PDF files (desktop)
/// - File picker (all platforms)
/// - Recent files list with search
/// - Adaptive layout for mobile, tablet, and desktop
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine layout based on screen width
            final isDesktop = constraints.maxWidth >= 1024;
            final isTablet =
                constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

            return CustomScrollView(
              slivers: [
                // Header section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _getHorizontalPadding(
                        isDesktop: isDesktop,
                        isTablet: isTablet,
                      ),
                      vertical: AppTheme.spacing48,
                    ),
                    child: const WelcomeHeader(),
                  ),
                ),

                // Drag & Drop / File Picker section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _getHorizontalPadding(
                        isDesktop: isDesktop,
                        isTablet: isTablet,
                      ),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isDesktop ? 600 : double.infinity,
                        ),
                        child: DragDropZone(
                          onFileSelected: (path) =>
                              _handleFileSelected(context, ref, path),
                        ),
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: AppTheme.spacing64),
                ),

                // Recent Files section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _getHorizontalPadding(
                        isDesktop: isDesktop,
                        isTablet: isTablet,
                      ),
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isDesktop ? 800 : double.infinity,
                        ),
                        child: recentFilesAsync.when(
                          data: (files) {
                            if (files.isEmpty) {
                              return const EmptyState();
                            }
                            return RecentFilesList(
                              files: files,
                              onFileOpen: (path) =>
                                  _openRecentFile(context, path),
                              onFileRemove: (path) =>
                                  _removeRecentFile(context, ref, path),
                            );
                          },
                          loading: () => const SkeletonLoader(itemCount: 3),
                          error: (error, stack) => _buildErrorState(
                            context,
                            error.toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom spacing
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppTheme.spacing64),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _getHorizontalPadding({
    required bool isDesktop,
    required bool isTablet,
  }) {
    if (isDesktop) return AppTheme.spacing64;
    if (isTablet) return AppTheme.spacing32;
    return AppTheme.spacing16;
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            'Error loading recent files',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B6B6B),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _handleFileSelected(
    BuildContext context,
    WidgetRef ref,
    String path,
  ) async {
    if (context.mounted) {
      context.push(
        '${AppRouter.pdfViewerPath}?path=${Uri.encodeComponent(path)}',
      );
    }
  }

  void _openRecentFile(BuildContext context, String path) {
    context.push(
      '${AppRouter.pdfViewerPath}?path=${Uri.encodeComponent(path)}',
    );
  }

  Future<void> _removeRecentFile(
    BuildContext context,
    WidgetRef ref,
    String path,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.removeFromRecent),
        content: Text(l10n.removeFromRecentConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(l10n.remove),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(recentFilesProvider.notifier).removeRecentFile(path);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.itemDeleted),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
