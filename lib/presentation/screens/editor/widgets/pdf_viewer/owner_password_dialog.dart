import 'package:flutter/material.dart';

import 'package:pdfsign/l10n/generated/app_localizations.dart';

/// Asks for the owner password without taking the document off the screen.
///
/// Two places need it: the notice over a document that will not be changed,
/// and the panel that sets a document's protection — changing it is the
/// owner's business, whoever is reading.
class OwnerPasswordDialog extends StatefulWidget {
  const OwnerPasswordDialog({
    required this.onSubmit,
    this.title,
    this.confirmLabel,
    super.key,
  });

  /// Shows the dialog, answering whether it did what was asked.
  static Future<bool> show(
    BuildContext context, {
    required Future<bool> Function(String password) onSubmit,
    String? title,
    String? confirmLabel,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (_) => OwnerPasswordDialog(
          onSubmit: onSubmit,
          title: title,
          confirmLabel: confirmLabel,
        ),
      ) ??
      false;

  /// Tries the password, and reports whether it was accepted.
  final Future<bool> Function(String password) onSubmit;

  /// Why the password is being asked for.
  ///
  /// The two callers stop the reader for different reasons and must say so:
  /// a document that will not be changed is not the same thing as one whose
  /// protection is somebody else's to set. Defaults to the read-only reason.
  final String? title;

  /// What the accepting button says. Defaults to opening the document.
  final String? confirmLabel;

  @override
  State<OwnerPasswordDialog> createState() => OwnerPasswordDialogState();
}

class OwnerPasswordDialogState extends State<OwnerPasswordDialog> {
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
      title: Text(widget.title ?? l10n.documentReadOnlyTitle),
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
          child: Text(widget.confirmLabel ?? l10n.openDocumentButton),
        ),
      ],
    );
  }
}
