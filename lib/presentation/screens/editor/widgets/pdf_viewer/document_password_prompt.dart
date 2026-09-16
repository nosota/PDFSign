import 'package:flutter/material.dart';

import 'package:pdfsign/core/constants/spacing.dart';
import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';

/// Asks for the password a document needs before it can be shown.
///
/// It takes the place of the document rather than floating over it, because
/// there is nothing behind it to look at: until the password is given there is
/// no document to show.
class DocumentPasswordPrompt extends StatefulWidget {
  const DocumentPasswordPrompt({
    required this.onSubmit,
    this.wasWrong = false,
    this.title,
    this.body,
    this.fieldLabel,
    super.key,
  });

  /// Called with what was typed. Never called with an empty password.
  final ValueChanged<String> onSubmit;

  /// Whether a password was already tried and turned down.
  final bool wasWrong;

  /// Heading, defaulting to the one for a document that will not open.
  final String? title;

  /// Sentence under the heading.
  final String? body;

  /// Label of the field.
  final String? fieldLabel;

  @override
  State<DocumentPasswordPrompt> createState() => _DocumentPasswordPromptState();
}

class _DocumentPasswordPromptState extends State<DocumentPasswordPrompt> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  /// Cleared as soon as the reader edits, so the complaint is about what they
  /// last tried rather than about what they are typing now.
  late bool _showWrong = widget.wasWrong;

  @override
  void didUpdateWidget(DocumentPasswordPrompt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.wasWrong && !oldWidget.wasWrong) {
      setState(() => _showWrong = true);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final password = _controller.text;
    if (password.isEmpty) return;
    widget.onSubmit(password);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Spacing.spacing24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock_outline,
                size: 48, color: AppColors.textSecondary),
            const SizedBox(height: Spacing.spacing16),
            Text(
              widget.title ?? l10n.documentProtectedTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: Spacing.spacing8),
            Text(
              widget.body ?? l10n.documentProtectedBody,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: Spacing.spacing16),
            _field(l10n),
            const SizedBox(height: Spacing.spacing16),
            ElevatedButton(
              onPressed: _submit,
              child: Text(l10n.openDocumentButton),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(AppLocalizations l10n) {
    return TextField(
      key: const Key('document-password-field'),
      controller: _controller,
      focusNode: _focusNode,
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        labelText: widget.fieldLabel ?? l10n.passwordFieldLabel,
        errorText: _showWrong ? l10n.incorrectPassword : null,
      ),
      onChanged: (_) {
        if (_showWrong) setState(() => _showWrong = false);
      },
      onSubmitted: (_) => _submit(),
    );
  }
}
