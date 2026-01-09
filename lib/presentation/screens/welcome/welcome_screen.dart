import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/app_localizations.dart';
import 'package:pdfsign/presentation/providers/settings/settings_provider.dart';

/// Welcome screen with Open PDF button and recent files list
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final recentFilesAsync = ref.watch(recentFilesProvider);

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Title
              const Icon(
                Icons.picture_as_pdf,
                size: 80,
                color: Color(0xFF0066FF),
              ),
              const SizedBox(height: AppTheme.spacing24),
              Text(
                'PDFSign',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppTheme.spacing48),

              // Open PDF Button
              SizedBox(
                width: 300,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () => _openPdf(context),
                  icon: const Icon(Icons.folder_open),
                  label: Text(l10n.openPdf),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppTheme.spacing64),

              // Recent Files Section
              recentFilesAsync.when(
                data: (recentFiles) {
                  if (recentFiles.isEmpty) {
                    return Text(
                      l10n.noRecentFiles,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6B6B6B),
                          ),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          l10n.recentFiles,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing16),
                      ...recentFiles.take(10).map((file) {
                        return Card(
                          margin: const EdgeInsets.only(
                            bottom: AppTheme.spacing8,
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.picture_as_pdf,
                              color: Color(0xFF0066FF),
                            ),
                            title: Text(file.fileName),
                            subtitle: Text(
                              '${file.pageCount} ${file.pageCount == 1 ? l10n.page : l10n.pages} • ${file.lastOpened.toLocal().toString().split('.')[0]}',
                            ),
                            trailing: file.isPasswordProtected
                                ? const Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Color(0xFF6B6B6B),
                                  )
                                : null,
                            onTap: () => _openRecentFile(context, file.path),
                            onLongPress: () =>
                                _removeRecentFile(context, ref, file.path),
                          ),
                        );
                      }),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openPdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      dialogTitle: AppLocalizations.of(context)!.openPdf,
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF Editor coming soon! Selected: ${path.split('/').last}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _openRecentFile(BuildContext context, String path) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF Editor coming soon! File: ${path.split('/').last}'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _removeRecentFile(
    BuildContext context,
    WidgetRef ref,
    String path,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.removeFromRecent),
        content: Text(AppLocalizations.of(context)!.removeFromRecentConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context)!.remove),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(recentFilesProvider.notifier).removeRecentFile(path);
    }
  }
}
