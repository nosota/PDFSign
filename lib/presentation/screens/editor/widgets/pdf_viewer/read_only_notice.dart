import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/constants/spacing.dart';
import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';

/// Says that the document forbids changes, and offers the way out of it.
///
/// A document may be readable by anyone and still refuse to be modified. The
/// app honours that: nothing can be placed on it, turned, or saved. Whoever
/// holds the owner password may lift the restriction, which is what the button
/// here is for — so the reader is told both why they are stopped and what
/// would let them through, rather than finding controls that quietly do
/// nothing.
class ReadOnlyNotice extends ConsumerWidget {
  const ReadOnlyNotice({required this.security, super.key});

  /// The open document's protection.
  final DocumentSecurity security;

  /// Identifies the button that asks for the owner password.
  @visibleForTesting
  static const unlockKey = ValueKey<String>('readOnlyNoticeUnlock');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: AppColors.noticeBackground,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing16,
          vertical: Spacing.spacing8,
        ),
        child: Row(
          children: [
            const Icon(Icons.lock_outline,
                size: 18, color: AppColors.noticeIcon),
            const SizedBox(width: Spacing.spacing8),
            Expanded(
              child: Text(
                l10n.documentReadOnlyBody,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.noticeText,
                ),
              ),
            ),
            // Nothing left to ask for when the document was already opened
            // with the owner password.
            if (!security.hasOwnerRights)
              TextButton(
                key: unlockKey,
                onPressed: () => _askForOwnerPassword(context, ref),
                child: Text(l10n.enterOwnerPassword),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _askForOwnerPassword(BuildContext context, WidgetRef ref) async {
    // Nothing to do with the answer: a password that is accepted reopens the
    // document in place, and this notice goes with the restriction.
    await showDialog<bool>(
      context: context,
      builder: (_) => _OwnerPasswordDialog(
        onSubmit: ref.read(pdfDocumentProvider.notifier).unlockEditing,
      ),
    );
  }
}

/// Asks for the owner password without taking the document off the screen.
class _OwnerPasswordDialog extends StatefulWidget {
  const _OwnerPasswordDialog({required this.onSubmit});

  /// Tries the password, and reports whether it was accepted.
  final Future<bool> Function(String password) onSubmit;

  @override
  State<_OwnerPasswordDialog> createState() => _OwnerPasswordDialogState();
}

class _OwnerPasswordDialogState extends State<_OwnerPasswordDialog> {
  final _controller = TextEditingController();
  bool _wasWrong = false;
  bool _checking = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final password = _controller.text;
    if (password.isEmpty || _checking) return;

    setState(() => _checking = true);
    final accepted = await widget.onSubmit(password);
    if (!mounted) return;

    if (accepted) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _checking = false;
      _wasWrong = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.documentReadOnlyTitle),
      content: SizedBox(
        width: 320,
        child: TextField(
          key: const Key('owner-password-field'),
          controller: _controller,
          autofocus: true,
          obscureText: true,
          enabled: !_checking,
          decoration: InputDecoration(
            labelText: l10n.ownerPasswordFieldLabel,
            errorText: _wasWrong ? l10n.incorrectPassword : null,
          ),
          onChanged: (_) {
            if (_wasWrong) setState(() => _wasWrong = false);
          },
          onSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _checking ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _checking ? null : _submit,
          child: Text(l10n.openDocumentButton),
        ),
      ],
    );
  }
}
