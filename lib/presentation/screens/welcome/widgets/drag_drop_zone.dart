import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/app_localizations.dart';

/// Drag & Drop zone for PDF files with fallback to file picker
class DragDropZone extends StatefulWidget {
  final ValueChanged<String> onFileSelected;

  const DragDropZone({
    required this.onFileSelected,
    super.key,
  });

  @override
  State<DragDropZone> createState() => _DragDropZoneState();
}

class _DragDropZoneState extends State<DragDropZone>
    with SingleTickerProviderStateMixin {
  bool _isDragging = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  bool get _isDesktop =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      dialogTitle: AppLocalizations.of(context)!.openPdf,
    );

    if (result != null && result.files.single.path != null) {
      widget.onFileSelected(result.files.single.path!);
    }
  }

  void _handleDrop(List<String> paths) {
    final pdfFiles = paths.where((path) => path.toLowerCase().endsWith('.pdf'));
    if (pdfFiles.isNotEmpty) {
      widget.onFileSelected(pdfFiles.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final content = AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isDragging ? 1.02 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(AppTheme.spacing32),
            decoration: BoxDecoration(
              color: _isDragging
                  ? const Color(0xFF0066FF).withOpacity(0.05)
                  : Colors.transparent,
              border: Border.all(
                color: _isDragging
                    ? const Color(0xFF0066FF)
                    : const Color(0xFFE0E0E0),
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isDragging ? Icons.file_download : Icons.folder_open,
                  size: 48,
                  color: _isDragging
                      ? const Color(0xFF0066FF)
                      : const Color(0xFF6B6B6B),
                ),
                const SizedBox(height: AppTheme.spacing16),
                Text(
                  _isDragging
                      ? l10n.dropFileHere
                      : (_isDesktop
                          ? l10n.dragDropOrClick
                          : l10n.tapToSelect),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: _isDragging
                            ? const Color(0xFF0066FF)
                            : const Color(0xFF6B6B6B),
                        fontWeight: _isDragging ? FontWeight.w600 : null,
                      ),
                  textAlign: TextAlign.center,
                ),
                if (_isDesktop) ...[
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    l10n.supportedFormat,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF9E9E9E),
                        ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );

    // Wrap with DropTarget only on desktop platforms
    if (_isDesktop) {
      return DropTarget(
        onDragEntered: (_) => setState(() => _isDragging = true),
        onDragExited: (_) => setState(() => _isDragging = false),
        onDragDone: (details) {
          setState(() => _isDragging = false);
          _handleDrop(details.files.map((file) => file.path).toList());
        },
        child: InkWell(
          onTap: _pickFile,
          borderRadius: BorderRadius.circular(16),
          child: content,
        ),
      );
    }

    // Mobile: just tap to open file picker
    return InkWell(
      onTap: _pickFile,
      borderRadius: BorderRadius.circular(16),
      child: content,
    );
  }
}
