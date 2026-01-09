import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/l10n/app_localizations.dart';

/// List of recently opened PDF files with search and actions
class RecentFilesList extends StatefulWidget {
  final List<RecentFile> files;
  final ValueChanged<String> onFileOpen;
  final ValueChanged<String> onFileRemove;

  const RecentFilesList({
    required this.files,
    required this.onFileOpen,
    required this.onFileRemove,
    super.key,
  });

  @override
  State<RecentFilesList> createState() => _RecentFilesListState();
}

class _RecentFilesListState extends State<RecentFilesList> {
  String _searchQuery = '';
  final _searchController = TextEditingController();

  List<RecentFile> get _filteredFiles {
    if (_searchQuery.isEmpty) {
      return widget.files;
    }
    return widget.files
        .where(
          (file) =>
              file.fileName.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat.Hm().format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat.Hm().format(date)}';
    } else if (difference.inDays < 7) {
      return DateFormat('EEEE HH:mm').format(date);
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filteredFiles = _filteredFiles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with search
        Row(
          children: [
            Text(
              l10n.recentFiles,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            if (widget.files.length > 3)
              SizedBox(
                width: 200,
                height: 40,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: l10n.search,
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF0066FF),
                        width: 2,
                      ),
                    ),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing16),

        // Files list
        if (filteredFiles.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing32),
            child: Center(
              child: Text(
                l10n.noMatchingFiles,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6B6B6B),
                    ),
              ),
            ),
          )
        else
          ...filteredFiles.take(10).map((file) {
            return _RecentFileCard(
              file: file,
              onOpen: () => widget.onFileOpen(file.path),
              onRemove: () => widget.onFileRemove(file.path),
              dateText: _formatDate(file.lastOpened),
            );
          }),
      ],
    );
  }
}

class _RecentFileCard extends StatefulWidget {
  final RecentFile file;
  final VoidCallback onOpen;
  final VoidCallback onRemove;
  final String dateText;

  const _RecentFileCard({
    required this.file,
    required this.onOpen,
    required this.onRemove,
    required this.dateText,
  });

  @override
  State<_RecentFileCard> createState() => _RecentFileCardState();
}

class _RecentFileCardState extends State<_RecentFileCard> {
  bool _isHovered = false;

  void _showContextMenu(TapDownDetails details) {
    final l10n = AppLocalizations.of(context)!;
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        details.globalPosition,
        details.globalPosition,
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<String>(
          value: 'open',
          child: Row(
            children: [
              const Icon(Icons.open_in_new, size: 20),
              const SizedBox(width: AppTheme.spacing8),
              Text(l10n.open),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'show_folder',
          child: Row(
            children: [
              const Icon(Icons.folder_open, size: 20),
              const SizedBox(width: AppTheme.spacing8),
              Text(l10n.showInFolder),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'remove',
          child: Row(
            children: [
              const Icon(Icons.delete_outline, size: 20, color: Colors.red),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                l10n.removeFromRecent,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'open') {
        widget.onOpen();
      } else if (value == 'show_folder') {
        // TODO: Implement show in folder
      } else if (value == 'remove') {
        widget.onRemove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onSecondaryTapDown: _showContextMenu,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF0066FF).withOpacity(0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF0066FF).withOpacity(0.3)
                  : const Color(0xFFE0E0E0),
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onOpen,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                child: Row(
                  children: [
                    // PDF Icon
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacing8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.picture_as_pdf,
                        color: Color(0xFF0066FF),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing12),

                    // File info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.file.fileName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${widget.file.pageCount} ${widget.file.pageCount == 1 ? l10n.page : l10n.pages}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: const Color(0xFF6B6B6B),
                                    ),
                              ),
                              const Text(' • ',
                                  style: TextStyle(color: Color(0xFF6B6B6B))),
                              Text(
                                widget.dateText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: const Color(0xFF6B6B6B),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Icons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.file.isPasswordProtected)
                          const Padding(
                            padding: EdgeInsets.only(right: AppTheme.spacing8),
                            child: Icon(
                              Icons.lock,
                              size: 20,
                              color: Color(0xFF6B6B6B),
                            ),
                          ),
                        if (_isHovered)
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            iconSize: 20,
                            onPressed: () {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              final offset = renderBox.localToGlobal(Offset.zero);
                              _showContextMenu(
                                TapDownDetails(
                                  globalPosition: Offset(
                                    offset.dx + renderBox.size.width,
                                    offset.dy,
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
