import 'package:flutter/material.dart';

import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:flutter/services.dart';

import 'package:pdfsign/core/theme/app_colors.dart';

/// Dialog for navigating to a specific page.
class GoToPageDialog extends StatefulWidget {
  const GoToPageDialog({
    required this.currentPage,
    required this.totalPages,
    super.key,
  });

  final int currentPage;
  final int totalPages;

  /// Shows the dialog and returns the selected page number, or null if cancelled.
  static Future<int?> show(
    BuildContext context, {
    required int currentPage,
    required int totalPages,
  }) {
    return showDialog<int>(
      context: context,
      builder: (context) => GoToPageDialog(
        currentPage: currentPage,
        totalPages: totalPages,
      ),
    );
  }

  @override
  State<GoToPageDialog> createState() => _GoToPageDialogState();
}

class _GoToPageDialogState extends State<GoToPageDialog> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentPage.toString());
    _focusNode = FocusNode();

    // Select all text when dialog opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// The window's strings. Safe here: the dialog is only ever shown inside a
  /// `MaterialApp` that carries the localizations.
  AppLocalizations get l10n => AppLocalizations.of(context)!;

  void _submit() {
    final pageNumber = int.tryParse(_controller.text);
    if (pageNumber == null) {
      setState(() {
        _errorText = l10n.goToPageInvalid;
      });
      return;
    }

    if (pageNumber < 1 || pageNumber > widget.totalPages) {
      setState(() {
        _errorText = l10n.goToPageOutOfRange(widget.totalPages);
      });
      return;
    }

    Navigator.of(context).pop(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(l10n.goToPage),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.goToPagePrompt(widget.totalPages),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              errorText: _errorText,
              hintText: l10n.goToPageHint,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            onSubmitted: (_) => _submit(),
            onChanged: (_) {
              if (_errorText != null) {
                setState(() {
                  _errorText = null;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(l10n.go),
        ),
      ],
    );
  }
}
