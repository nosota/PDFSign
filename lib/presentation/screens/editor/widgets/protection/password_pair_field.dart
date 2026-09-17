import 'package:flutter/material.dart';

import 'package:pdfsign/core/constants/spacing.dart';

/// A password and the second copy of it that has to agree.
///
/// Typing a password nobody can see is easy to get wrong, and a document
/// locked with a mistyped password is a document nobody can open. The pair is
/// the usual answer; this holds both fields and says whether they match.
class PasswordPairController {
  final TextEditingController password = TextEditingController();
  final TextEditingController verify = TextEditingController();

  /// What was typed in the first field.
  String get text => password.text;

  /// Puts [value] in both fields, so an unchanged password verifies itself.
  set text(String value) {
    password.text = value;
    verify.text = value;
  }

  /// Whether the two fields agree.
  bool get matches => password.text == verify.text;

  void dispose() {
    password.dispose();
    verify.dispose();
  }
}

/// The two fields of a [PasswordPairController].
class PasswordPairField extends StatelessWidget {
  const PasswordPairField({
    required this.controller,
    required this.label,
    required this.verifyLabel,
    required this.fieldKey,
    this.enabled = true,
    super.key,
  });

  final PasswordPairController controller;
  final String label;
  final String verifyLabel;

  /// Distinguishes this pair's fields from another's, for tests.
  final String fieldKey;

  final bool enabled;

  /// The key of one field of a pair, for tests.
  @visibleForTesting
  static ValueKey<String> keyFor(String fieldKey, {required bool verify}) =>
      ValueKey<String>('password.$fieldKey.${verify ? 'verify' : 'first'}');

  @override
  Widget build(BuildContext context) {
    // Side by side rather than one above the other: the panel has two of
    // these pairs and six permissions to show, and stacked fields pushed the
    // owner password off the bottom of the window.
    return Row(
      children: [
        Expanded(child: _field(controller.password, label, verify: false)),
        const SizedBox(width: Spacing.spacing8),
        Expanded(child: _field(controller.verify, verifyLabel, verify: true)),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    required bool verify,
  }) =>
      TextField(
        key: keyFor(fieldKey, verify: verify),
        controller: controller,
        enabled: enabled,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: const OutlineInputBorder(),
        ),
      );
}
