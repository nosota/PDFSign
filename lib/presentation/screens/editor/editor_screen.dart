import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfsign/data/services/clipboard_service.dart';
import 'package:pdfsign/data/services/pdf_save_service.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/l10n/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/editor_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_viewer_provider.dart';
import 'package:pdfsign/presentation/providers/signature_library/signature_library_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/editor_toolbar.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_canvas.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/signature_panel.dart';

/// Main editor screen for PDF editing with signatures/stamps
class EditorScreen extends ConsumerStatefulWidget {
  final String? pdfPath;

  const EditorScreen({
    super.key,
    this.pdfPath,
  });

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  double _panelWidth = 280.0; // Default panel width
  static const double _minPanelWidth = 200.0;
  static const double _maxPanelWidth = 400.0;

  final PdfSaveService _saveService = PdfSaveService();
  final ClipboardService _clipboardService = ClipboardService();
  String? _lastSavedPath;

  @override
  void initState() {
    super.initState();
    // Load PDF if path provided
    if (widget.pdfPath != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // TODO: Load PDF via provider
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PlatformMenuBar(
      menus: _buildMenus(context, l10n),
      child: Scaffold(
        body: Column(
          children: [
            // Top Toolbar
            const EditorToolbar(),

            // Main content area
            Expanded(
              child: Row(
                children: [
                  // PDF Canvas (left side)
                  Expanded(
                    child: PdfCanvas(
                      pdfPath: widget.pdfPath,
                    ),
                  ),

                  // Vertical divider (resizable)
                  MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _panelWidth = (_panelWidth - details.delta.dx).clamp(
                            _minPanelWidth,
                            _maxPanelWidth,
                          );
                        });
                      },
                      child: Container(
                        width: 4,
                        color: const Color(0xFFE5E5E7),
                        child: Center(
                          child: Container(
                            width: 1,
                            color: const Color(0xFFB0B0B0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Signature Panel (right side)
                  SizedBox(
                    width: _panelWidth,
                    child: const SignaturePanel(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build menu structure
  List<PlatformMenuItem> _buildMenus(BuildContext context, AppLocalizations l10n) {
    return [
      _buildFileMenu(context, l10n),
      _buildEditMenu(context, l10n),
      _buildViewMenu(context, l10n),
    ];
  }

  /// File menu
  PlatformMenu _buildFileMenu(BuildContext context, AppLocalizations l10n) {
    return PlatformMenu(
      label: l10n.file,
      menus: [
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.openPdf,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyO,
                meta: true,
              ),
              onSelected: () => _openPdf(context),
            ),
          ],
        ),
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.save,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyS,
                meta: true,
              ),
              onSelected: () => _savePdf(context),
            ),
            PlatformMenuItem(
              label: l10n.saveAs,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyS,
                meta: true,
                shift: true,
              ),
              onSelected: () => _saveAsPdf(context),
            ),
          ],
        ),
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.close,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyW,
                meta: true,
              ),
              onSelected: () => _closePdf(context),
            ),
          ],
        ),
        if (Platform.isMacOS)
          PlatformMenuItemGroup(
            members: [
              PlatformMenuItem(
                label: l10n.quit,
                shortcut: const SingleActivator(
                  LogicalKeyboardKey.keyQ,
                  meta: true,
                ),
                onSelected: () => exit(0),
              ),
            ],
          ),
      ],
    );
  }

  /// Edit menu
  PlatformMenu _buildEditMenu(BuildContext context, AppLocalizations l10n) {
    return PlatformMenu(
      label: l10n.edit,
      menus: [
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.undo,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyZ,
                meta: true,
              ),
              onSelected: () => _undo(),
            ),
            PlatformMenuItem(
              label: l10n.redo,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyZ,
                meta: true,
                shift: true,
              ),
              onSelected: () => _redo(),
            ),
          ],
        ),
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.delete,
              shortcut: const SingleActivator(LogicalKeyboardKey.delete),
              onSelected: () => _deleteSelected(),
            ),
          ],
        ),
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.copyToClipboard,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyC,
                meta: true,
              ),
              onSelected: () => _copy(),
            ),
            PlatformMenuItem(
              label: l10n.paste,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyV,
                meta: true,
              ),
              onSelected: () => _paste(context),
            ),
            PlatformMenuItem(
              label: l10n.duplicate,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyD,
                meta: true,
              ),
              onSelected: () => _duplicate(),
            ),
          ],
        ),
      ],
    );
  }

  /// View menu
  PlatformMenu _buildViewMenu(BuildContext context, AppLocalizations l10n) {
    return PlatformMenu(
      label: l10n.view,
      menus: [
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.zoomIn,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.equal,
                meta: true,
              ),
              onSelected: () {
                ref.read(zoomLevelProvider.notifier).zoomIn();
              },
            ),
            PlatformMenuItem(
              label: l10n.zoomOut,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.minus,
                meta: true,
              ),
              onSelected: () {
                ref.read(zoomLevelProvider.notifier).zoomOut();
              },
            ),
            PlatformMenuItem(
              label: l10n.actualSize,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.digit0,
                meta: true,
              ),
              onSelected: () {
                ref.read(zoomLevelProvider.notifier).resetZoom();
              },
            ),
          ],
        ),
        PlatformMenuItemGroup(
          members: [
            PlatformMenuItem(
              label: l10n.fitToScreen,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.digit1,
                meta: true,
              ),
              onSelected: () => _fitToScreen(),
            ),
            PlatformMenuItem(
              label: l10n.fullScreen,
              shortcut: const SingleActivator(
                LogicalKeyboardKey.keyF,
                meta: true,
                control: true,
              ),
              onSelected: () => _toggleFullScreen(),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================================
  // Action Methods
  // ==========================================================================

  /// Open PDF file
  Future<void> _openPdf(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      dialogTitle: AppLocalizations.of(context)!.openPdf,
    );

    if (result != null && result.files.single.path != null && context.mounted) {
      final path = result.files.single.path!;
      context.go('/editor?path=${Uri.encodeComponent(path)}');
    }
  }

  /// Save PDF
  Future<void> _savePdf(BuildContext context) async {
    if (widget.pdfPath == null) return;

    // If already saved before, save to same path
    if (_lastSavedPath != null) {
      await _performSave(_lastSavedPath!);
      return;
    }

    // Otherwise, show save as dialog
    await _saveAsPdf(context);
  }

  /// Save PDF as new file
  Future<void> _saveAsPdf(BuildContext context) async {
    if (widget.pdfPath == null) return;

    try {
      // Get suggested file name
      final suggestedName = _saveService.getSuggestedFileName(widget.pdfPath!);

      // Show save dialog
      final result = await FilePicker.platform.saveFile(
        dialogTitle: AppLocalizations.of(context)!.saveAs,
        fileName: suggestedName,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return;

      // Save the PDF
      await _performSave(result);

      // Update last saved path
      setState(() {
        _lastSavedPath = result;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.errorSaveFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Perform the actual save operation
  Future<void> _performSave(String destinationPath) async {
    if (widget.pdfPath == null) return;

    // Show loading indicator
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.saving),
          duration: const Duration(seconds: 30),
        ),
      );
    }

    try {
      // Get placed objects and signature items
      final editorState = ref.read(editorProvider);
      final signaturesAsync = await ref.read(signaturesProvider.future);
      final stampsAsync = await ref.read(stampsProvider.future);

      // Create a map of signature items
      final Map<String, SignatureItem> signatureItemsMap = {};
      for (final item in [...signaturesAsync, ...stampsAsync]) {
        signatureItemsMap[item.id] = item;
      }

      // Save the PDF
      await _saveService.savePdf(
        sourcePdfPath: widget.pdfPath!,
        destinationPath: destinationPath,
        placedObjects: editorState.placedObjects,
        signatureItems: signatureItemsMap,
      );

      // Clear unsaved changes flag
      // Note: You might want to add this to the editor state

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.pdfSaved),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.errorSaveFailed}: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 6),
          ),
        );
      }
    }
  }

  /// Close current PDF
  Future<void> _closePdf(BuildContext context) async {
    await ref.read(pdfDocumentProvider.notifier).closePdf();
    if (context.mounted) {
      context.go('/');
    }
  }

  /// Undo last action
  void _undo() {
    ref.read(undoRedoProvider.notifier).undo();
  }

  /// Redo last undone action
  void _redo() {
    ref.read(undoRedoProvider.notifier).redo();
  }

  /// Delete selected object
  void _deleteSelected() {
    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId != null) {
      ref.read(editorProvider.notifier).deleteObject(selectedId);
    }
  }

  /// Copy selected object to clipboard
  Future<void> _copy() async {
    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId == null) return;

    // Find the placed object
    final editorState = ref.read(editorProvider);
    final placedObject = editorState.placedObjects.firstWhere(
      (obj) => obj.id == selectedId,
      orElse: () => throw Exception('Object not found'),
    );

    try {
      // Get the signature item
      final signaturesAsync = await ref.read(signaturesProvider.future);
      final stampsAsync = await ref.read(stampsProvider.future);
      final allItems = [...signaturesAsync, ...stampsAsync];

      final signatureItem = allItems.firstWhere(
        (item) => item.id == placedObject.signatureId,
        orElse: () => throw Exception('Signature item not found'),
      );

      // Copy image to clipboard
      final success = await _clipboardService.copyImage(signatureItem.imageData);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.copiedToClipboard)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorCopyFailed),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.errorCopyFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Paste from clipboard
  Future<void> _paste(BuildContext context) async {
    try {
      // Check if clipboard has image
      final hasImage = await _clipboardService.hasImage();
      if (!hasImage) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorNoImageInClipboard),
            ),
          );
        }
        return;
      }

      // Ask user whether to add to signatures or stamps
      if (!mounted) return;
      final category = await showDialog<SignatureType>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.pasteImageTitle),
          content: Text(AppLocalizations.of(context)!.pasteImageMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, SignatureType.signature),
              child: Text(AppLocalizations.of(context)!.signature),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, SignatureType.stamp),
              child: Text(AppLocalizations.of(context)!.stamp),
            ),
          ],
        ),
      );

      if (category == null || !mounted) return;

      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.addingImage),
          duration: const Duration(seconds: 30),
        ),
      );

      // Read image from clipboard
      final imageData = await _clipboardService.readImage();
      if (imageData == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.errorReadingClipboard),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Get MIME type
      final mimeType = await _clipboardService.getImageMimeType() ?? 'image/png';

      // Add to library
      final now = DateTime.now();
      final timestamp = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}';
      final name = 'Clipboard_$timestamp';
      final extension = mimeType == 'image/png' ? 'png' : 'jpg';
      final fileName = '$name.$extension';

      if (category == SignatureType.signature) {
        await ref.read(signaturesProvider.notifier).addSignature(
              name: name,
              imageData: imageData,
              mimeType: mimeType,
              originalFileName: fileName,
            );
      } else {
        await ref.read(stampsProvider.notifier).addStamp(
              name: name,
              imageData: imageData,
              mimeType: mimeType,
              originalFileName: fileName,
            );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.imageAdded),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.errorPasteFailed}: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Duplicate selected object
  void _duplicate() {
    final selectedId = ref.read(editorProvider).selectedObjectId;
    if (selectedId != null) {
      ref.read(editorProvider.notifier).duplicateObject(selectedId);
    }
  }

  /// Fit PDF to screen
  void _fitToScreen() {
    // TODO: Implement fit to screen
  }

  /// Toggle full screen mode
  void _toggleFullScreen() {
    // TODO: Implement full screen toggle
  }
}
