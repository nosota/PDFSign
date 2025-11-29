import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/l10n/app_localizations.dart';
import 'package:pdfsign/presentation/providers/settings/settings_provider.dart';
import 'package:pdfsign/presentation/providers/signature_library/signature_library_provider.dart';

/// Right panel with Signatures and Stamps tabs
class SignaturePanel extends ConsumerStatefulWidget {
  const SignaturePanel({super.key});

  @override
  ConsumerState<SignaturePanel> createState() => _SignaturePanelState();
}

class _SignaturePanelState extends ConsumerState<SignaturePanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load saved tab
    Future.microtask(() async {
      final selectedTab = await ref.read(selectedTabProvider.future);
      if (mounted) {
        _tabController.index = selectedTab;
      }
    });

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(selectedTabProvider.notifier).setTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Tabs
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F7),
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE5E5E7),
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: l10n.signatures),
              Tab(text: l10n.stamps),
            ],
            labelColor: const Color(0xFF0066FF),
            unselectedLabelColor: const Color(0xFF6B6B6B),
            indicatorColor: const Color(0xFF0066FF),
            indicatorWeight: 2,
          ),
        ),

        // Tab views
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _SignatureList(type: SignatureType.signature),
              _SignatureList(type: SignatureType.stamp),
            ],
          ),
        ),
      ],
    );
  }
}

/// List of signatures or stamps
class _SignatureList extends ConsumerWidget {
  final SignatureType type;

  const _SignatureList({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final provider = type == SignatureType.signature
        ? signaturesProvider
        : stampsProvider;
    final itemsAsync = ref.watch(provider);

    return Column(
      children: [
        // List
        Expanded(
          child: itemsAsync.when(
            data: (items) {
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    type == SignatureType.signature
                        ? l10n.noSignatures
                        : l10n.noStamps,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF6B6B6B),
                        ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(AppTheme.spacing16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _SignatureCard(
                    item: item,
                    onDelete: () => _deleteItem(context, ref, item),
                    onRename: (newName) => _renameItem(ref, item, newName),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),

        // Add button
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFE5E5E7),
                width: 1,
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => _addItem(context, ref, type),
              icon: const Icon(Icons.add, size: 20),
              label: Text(l10n.add),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addItem(
    BuildContext context,
    WidgetRef ref,
    SignatureType type,
  ) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: AppLocalizations.of(context)!.selectImage,
    );

    if (result != null && result.files.single.path != null) {
      final file = result.files.single;
      final bytes = await file.xFile.readAsBytes();

      // Validate size
      if (bytes.length > AppConstants.maxImageFileSizeBytes) {
        if (context.mounted) {
          _showError(context, AppLocalizations.of(context)!.fileSizeExceeded);
        }
        return;
      }

      // Add to library
      try {
        if (type == SignatureType.signature) {
          await ref.read(signaturesProvider.notifier).addSignature(
            imageData: bytes,
            name: file.name,
            originalFileName: file.name,
            mimeType: _getMimeType(file.extension ?? ''),
          );
        } else {
          await ref.read(stampsProvider.notifier).addStamp(
            imageData: bytes,
            name: file.name,
            originalFileName: file.name,
            mimeType: _getMimeType(file.extension ?? ''),
          );
        }
      } catch (e) {
        if (context.mounted) {
          _showError(context, e.toString());
        }
      }
    }
  }

  Future<void> _deleteItem(
    BuildContext context,
    WidgetRef ref,
    SignatureItem item,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteConfirmTitle),
        content: Text(AppLocalizations.of(context)!.deleteConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (item.type == SignatureType.signature) {
        await ref.read(signaturesProvider.notifier).deleteSignature(item.id);
      } else {
        await ref.read(stampsProvider.notifier).deleteStamp(item.id);
      }
    }
  }

  Future<void> _renameItem(
    WidgetRef ref,
    SignatureItem item,
    String newName,
  ) async {
    final updated = SignatureItem(
      id: item.id,
      name: newName,
      type: item.type,
      imageData: item.imageData,
      order: item.order,
      createdAt: item.createdAt,
      originalFileName: item.originalFileName,
      mimeType: item.mimeType,
    );

    if (item.type == SignatureType.signature) {
      await ref.read(signaturesProvider.notifier).updateSignature(updated);
    } else {
      await ref.read(stampsProvider.notifier).updateStamp(updated);
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'webp':
        return 'image/webp';
      case 'svg':
        return 'image/svg+xml';
      default:
        return 'image/png';
    }
  }
}

/// Card for signature/stamp item
class _SignatureCard extends StatefulWidget {
  final SignatureItem item;
  final VoidCallback onDelete;
  final Function(String) onRename;

  const _SignatureCard({
    required this.item,
    required this.onDelete,
    required this.onRename,
  });

  @override
  State<_SignatureCard> createState() => _SignatureCardState();
}

class _SignatureCardState extends State<_SignatureCard> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<SignatureItem>(
      data: widget.item,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        child: Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF0066FF), width: 2),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            child: Opacity(
              opacity: 0.8,
              child: Image.memory(
                Uint8List.fromList(widget.item.imageData.toList()),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildCard(context),
      ),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        child: Column(
          children: [
            // Image preview
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE5E5E7)),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Center(
                child: Image.memory(
                  Uint8List.fromList(widget.item.imageData.toList()),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red);
                  },
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacing8),

            // Name (editable)
            _isEditing
                ? TextField(
                    controller: _controller,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        widget.onRename(value);
                      }
                      setState(() => _isEditing = false);
                    },
                    onTapOutside: (_) {
                      if (_controller.text.isNotEmpty) {
                        widget.onRename(_controller.text);
                      }
                      setState(() => _isEditing = false);
                    },
                  )
                : GestureDetector(
                    onTap: () => setState(() => _isEditing = true),
                    child: Text(
                      widget.item.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

            // Delete button
            const SizedBox(height: AppTheme.spacing8),
            TextButton.icon(
              onPressed: widget.onDelete,
              icon: const Icon(Icons.delete, size: 16),
              label: Text(AppLocalizations.of(context)!.delete),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
