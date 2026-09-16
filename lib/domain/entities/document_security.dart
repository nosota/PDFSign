import 'package:equatable/equatable.dart';

/// What a document's own protection allows, and what it took to open it.
///
/// The [password] is kept only for as long as the document is open, and only
/// so that saving can put the protection back exactly as it was. It is never
/// written to disk, never logged, never put in Recent Files, and never sent to
/// another window.
class DocumentSecurity extends Equatable {
  /// A document with no encryption at all: everything is permitted.
  const DocumentSecurity.unprotected()
      : password = null,
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

  /// Whether the document was opened with owner rights.
  ///
  /// When false, editing can still be unlocked by supplying the owner
  /// password; when true, there is nothing further to ask for.
  final bool hasOwnerRights;

  @override
  List<Object?> get props => [
        isProtected,
        password,
        allowsEditing,
        hasOwnerRights,
      ];

  /// Says nothing about the password, deliberately.
  ///
  /// This object is reachable from the document info that is interpolated into
  /// diagnostics; a default `toString` would put the password in them.
  @override
  String toString() => 'DocumentSecurity(protected: $isProtected, '
      'allowsEditing: $allowsEditing, ownerRights: $hasOwnerRights)';
}
