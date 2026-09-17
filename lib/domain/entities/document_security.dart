import 'package:equatable/equatable.dart';

import 'package:pdfsign/domain/entities/document_protection.dart';

/// What a document's own protection allows, and what it took to open it.
///
/// The [password] is kept only for as long as the document is open, and only
/// so that saving can put the protection back exactly as it was. It is never
/// written to disk, never logged, never put in Recent Files, and never sent to
/// another window.
class DocumentSecurity extends Equatable {
  /// A document with no encryption at all: everything is permitted.
  const DocumentSecurity.unprotected()
      : current = null,
        password = null,
        isProtected = false,
        allowsEditing = true,
        hasOwnerRights = true;

  /// An encrypted document.
  ///
  /// [password] is null for a document that opened without one — it carries an
  /// owner password to restrict what may be done with it, and an empty user
  /// password so that anyone may read it.
  ///
  /// [hasOwnerRights] is true when the password given was the owner's, which
  /// under the PDF specification grants full access whatever the permission
  /// flags say. [allowsEditing] already accounts for that.
  const DocumentSecurity.protected({
    required this.password,
    required this.allowsEditing,
    required this.hasOwnerRights,
    this.current,
  }) : isProtected = true;

  /// Whether the document is encrypted.
  final bool isProtected;

  /// The password the document was opened with, if one was needed.
  final String? password;

  /// Whether the document permits its content to be changed.
  ///
  /// False means the document asks not to be modified: an object may not be
  /// placed on it, and it may not be saved. Supplying the owner password
  /// lifts this.
  final bool allowsEditing;

  /// The protection the document carries, as far as it could be read.
  ///
  /// This is what the panel starts from. Null for a document with none, and
  /// for one whose protection could not be read back — a password that opened
  /// the document does not always reveal the other one.
  final DocumentProtection? current;

  /// Whether the document was opened with owner rights.
  ///
  /// When false, editing can still be unlocked by supplying the owner
  /// password; when true, there is nothing further to ask for.
  final bool hasOwnerRights;

  /// Whether changing this document's protection is the owner's business.
  ///
  /// True for a document that withholds something or asks for a password to
  /// open, and was not opened with the owner's. Such protection is somebody's
  /// decision and this app will not quietly undo it.
  ///
  /// False for a document that withholds nothing, **even though it is
  /// encrypted**. Encryption that grants every permission and opens without a
  /// password restricts nobody, and it cannot be told apart from what this app
  /// leaves behind itself: removing protection writes empty passwords and a
  /// full set of permissions, because the writer cannot take the encryption
  /// dictionary out (REQUIREMENTS §13.16). Asking for an owner password there
  /// would be asking for one that does not exist, and no answer would do.
  ///
  /// Null [current] means the protection could not be read at all, which is
  /// answered conservatively: ask.
  bool get protectionNeedsOwnerPassword =>
      isProtected && !hasOwnerRights && !(current?.isOpen ?? false);

  @override
  List<Object?> get props => [
        isProtected,
        password,
        allowsEditing,
        hasOwnerRights,
        current,
      ];

  /// Says nothing about the password, deliberately.
  ///
  /// This object is reachable from the document info that is interpolated into
  /// diagnostics; a default `toString` would put the password in them.
  @override
  String toString() => 'DocumentSecurity(protected: $isProtected, '
      'allowsEditing: $allowsEditing, ownerRights: $hasOwnerRights)';
}
