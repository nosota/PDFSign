/// Exceptions raised inside the data layer, for repositories to translate.
///
/// They exist so that a caller can tell cases apart by type rather than by
/// searching an error message for words.
library;

/// A document cannot be read without a password.
class PdfPasswordRequiredException implements Exception {
  const PdfPasswordRequiredException({required this.passwordWasGiven});

  /// Whether a password was supplied and turned down, as against none offered.
  ///
  /// The difference is what separates "this document needs a password" from
  /// "that password is wrong", and the reader is owed the right one.
  final bool passwordWasGiven;

  @override
  String toString() => 'PdfPasswordRequiredException('
      'passwordWasGiven: $passwordWasGiven)';
}

/// A document is protected by something other than a password.
///
/// Certificate-based protection is the case in practice: the PDF writer this
/// app uses handles the standard security handler and nothing else.
class PdfUnsupportedProtectionException implements Exception {
  const PdfUnsupportedProtectionException(this.detail);

  /// What the PDF library said, for the message shown to the reader.
  final String detail;

  @override
  String toString() => 'PdfUnsupportedProtectionException($detail)';
}
