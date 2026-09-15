import 'package:flutter/material.dart';

import 'package:pdfsign/l10n/generated/app_localizations.dart';

/// Shown when Save All could not write every document.
///
/// Closing anyway discards the changes that were not written, so the choice
/// belongs to the user rather than to a timeout.
class SaveFailedDialog extends StatelessWidget {
  const SaveFailedDialog({
    required this.failedCount,
    super.key,
  });

  /// How many documents were left unwritten.
  final int failedCount;

  /// Shows the dialog. Returns true when the user chose to close anyway.
  static Future<bool> show(BuildContext context, int failedCount) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SaveFailedDialog(failedCount: failedCount),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.saveFailedDialogTitle),
      content: Text(l10n.saveFailedDialogMessage(failedCount)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.closeAllDialogCancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.saveFailedDialogClose),
        ),
      ],
    );
  }
}
