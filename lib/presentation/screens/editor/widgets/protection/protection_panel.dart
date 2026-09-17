import 'package:flutter/material.dart';

import 'package:pdfsign/core/constants/spacing.dart';
import 'package:pdfsign/core/theme/app_colors.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/protection/password_pair_field.dart';

/// What the panel was closed with.
///
/// A [DocumentProtection] is what to write; null means the reader cancelled
/// and nothing about the document should change.
typedef ProtectionChoice = DocumentProtection?;

/// Sets the passwords and permissions a document is to be saved with.
///
/// Laid out like the panel macOS shows for the same job, with one addition:
/// changing the document has a box of its own. Apple folds that right into the
/// others, but it is the one PDFSign needs to place a signature, and a reader
/// who cannot see it cannot tell why their own app stopped being able to sign.
class ProtectionPanel extends StatefulWidget {
  const ProtectionPanel({required this.current, super.key});

  /// The protection the document already has, or null for one with none.
  final DocumentProtection? current;

  /// Shows the panel, returning what to write or null if it was cancelled.
  static Future<ProtectionChoice> show(
    BuildContext context, {
    DocumentProtection? current,
  }) =>
      showDialog<DocumentProtection>(
        context: context,
        builder: (_) => ProtectionPanel(current: current),
      );

  /// Identifies the button that clears everything, for tests.
  @visibleForTesting
  static const removeKey = ValueKey<String>('protectionPanelRemove');

  /// Identifies the button that accepts the panel, for tests.
  @visibleForTesting
  static const applyKey = ValueKey<String>('protectionPanelApply');

  /// Identifies one permission's checkbox, for tests.
  @visibleForTesting
  static ValueKey<String> permissionKey(DocumentPermission permission) =>
      ValueKey<String>('protectionPermission.${permission.name}');

  @override
  State<ProtectionPanel> createState() => _ProtectionPanelState();
}

class _ProtectionPanelState extends State<ProtectionPanel> {
  late bool _requireOpenPassword =
      widget.current?.requiresPasswordToOpen ?? false;
  late final Set<DocumentPermission> _permissions = {
    ...widget.current?.permissions ?? DocumentPermission.values.toSet(),
  };

  final _open = PasswordPairController();
  final _owner = PasswordPairController();

  String? _complaint;

  @override
  void initState() {
    super.initState();
    _open.text = widget.current?.userPassword ?? '';
    _owner.text = widget.current?.ownerPassword ?? '';
  }

  @override
  void dispose() {
    _open.dispose();
    _owner.dispose();
    super.dispose();
  }

  /// Whether anything is withheld from a reader without the owner password.
  bool get _restricts => _permissions.length != DocumentPermission.values.length;

  void _togglePermission(DocumentPermission permission, bool granted) {
    setState(() {
      _complaint = null;
      if (granted) {
        _permissions.add(permission);
        // The broad right carries the narrow ones; ticking them here is what
        // keeps the panel and the written file saying the same thing.
        if (permission == DocumentPermission.changingContent) {
          _permissions
            ..add(DocumentPermission.annotations)
            ..add(DocumentPermission.formFilling);
        }
      } else {
        _permissions.remove(permission);
      }
    });
  }

  /// Whether [permission] is held on by another that includes it.
  bool _impliedBy(DocumentPermission permission) =>
      _permissions.contains(DocumentPermission.changingContent) &&
      (permission == DocumentPermission.annotations ||
          permission == DocumentPermission.formFilling);

  void _apply(AppLocalizations l10n) {
    if (_requireOpenPassword && _open.text.isEmpty) {
      return setState(() => _complaint = l10n.passwordCannotBeEmpty);
    }
    if (_requireOpenPassword && !_open.matches) {
      return setState(() => _complaint = l10n.passwordsDoNotMatch);
    }
    if (!_owner.matches) {
      return setState(() => _complaint = l10n.passwordsDoNotMatch);
    }
    if (_restricts && _owner.text.isEmpty) {
      return setState(
        () => _complaint = l10n.restrictionsNeedOwnerPassword,
      );
    }

    Navigator.of(context).pop(
      DocumentProtection(
        userPassword: _requireOpenPassword ? _open.text : '',
        ownerPassword: _owner.text,
        permissions: _permissions,
        algorithm: widget.current?.algorithm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.protectDocumentTitle),
      content: SizedBox(
        width: 460,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _requireOpenPassword,
                title: Text(l10n.requirePasswordToOpen),
                onChanged: (on) => setState(() {
                  _requireOpenPassword = on ?? false;
                  _complaint = null;
                }),
              ),
              PasswordPairField(
                controller: _open,
                enabled: _requireOpenPassword,
                label: l10n.passwordFieldLabel,
                verifyLabel: l10n.verifyFieldLabel,
                fieldKey: 'open',
              ),
              const Divider(height: Spacing.spacing24),
              _permissionsSection(l10n),
              const Divider(height: Spacing.spacing24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.ownerPasswordHeading,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(height: Spacing.spacing8),
              PasswordPairField(
                controller: _owner,
                label: l10n.passwordFieldLabel,
                verifyLabel: l10n.verifyFieldLabel,
                fieldKey: 'owner',
              ),
              if (_complaint != null) ...[
                const SizedBox(height: Spacing.spacing12),
                Text(
                  _complaint!,
                  style: const TextStyle(color: AppColors.error),
                ),
              ],
            ],
          ),
        ),
      ),
      // Removing protection stands apart from accepting the panel: it is the
      // one action here that takes something away, and it should not sit
      // shoulder to shoulder with Apply.
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          key: ProtectionPanel.removeKey,
          onPressed: () => Navigator.of(context).pop(DocumentProtection.none()),
          child: Text(l10n.removeProtection),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancel),
            ),
            const SizedBox(width: Spacing.spacing8),
            ElevatedButton(
              key: ProtectionPanel.applyKey,
              onPressed: () => _apply(l10n),
              child: Text(l10n.applyButton),
            ),
          ],
        ),
      ],
    );
  }

  Widget _permissionsSection(AppLocalizations l10n) {
    final withholdsChanges =
        !_permissions.contains(DocumentPermission.changingContent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.permissionsHeading,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const SizedBox(height: Spacing.spacing4),
        Text(
          l10n.permissionsNote,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
        for (final permission in DocumentPermission.values)
          CheckboxListTile(
            key: ProtectionPanel.permissionKey(permission),
            contentPadding: EdgeInsets.zero,
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            value: _permissions.contains(permission),
            title: Text(_nameOf(permission, l10n)),
            onChanged: _impliedBy(permission)
                ? null
                : (granted) => _togglePermission(permission, granted ?? false),
          ),
        if (_permissions.contains(DocumentPermission.changingContent))
          Text(
            l10n.changingContentIncludes,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        if (withholdsChanges)
          Padding(
            padding: const EdgeInsets.only(top: Spacing.spacing8),
            child: Text(
              l10n.signingNeedsChangingContent,
              style: const TextStyle(color: AppColors.noticeText, fontSize: 12),
            ),
          ),
      ],
    );
  }

  String _nameOf(DocumentPermission permission, AppLocalizations l10n) =>
      switch (permission) {
        DocumentPermission.printing => l10n.permissionPrinting,
        DocumentPermission.copying => l10n.permissionCopying,
        DocumentPermission.pageAssembly => l10n.permissionPageAssembly,
        DocumentPermission.annotations => l10n.permissionAnnotations,
        DocumentPermission.changingContent => l10n.permissionChangingContent,
        DocumentPermission.formFilling => l10n.permissionFormFilling,
      };
}
