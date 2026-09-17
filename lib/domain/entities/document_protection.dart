import 'package:equatable/equatable.dart';

/// What a reader may do with a document without the owner's password.
///
/// These are the permission bits of PDF 32000-1:2008, Table 22, named for what
/// they mean to a person rather than by their number.
enum DocumentPermission {
  /// Print the document. Bit 3, together with high-quality printing (12).
  printing,

  /// Copy text and graphics out of it. Bit 5, with accessibility copying (10).
  copying,

  /// Insert, delete and rotate pages. Bit 11.
  pageAssembly,

  /// Add annotations and signatures. Bit 6.
  annotations,

  /// Change the content of the document. Bit 4.
  ///
  /// The broadest of them, and the one PDFSign itself needs: a signature is
  /// drawn into the page's content rather than attached as an annotation. A
  /// document that withholds it opens read-only here until the owner password
  /// is given.
  changingContent,

  /// Fill in form fields that already exist. Bit 9.
  formFilling,
}

/// How a document is encrypted.
///
/// The app writes AES-256 for protection it adds. The older algorithms exist
/// so that a document which already has one keeps it: changing a twenty-year-
/// old document's encryption to AES-256 would stop the readers it was made for
/// opening it at all.
enum DocumentEncryption {
  rc4x40,
  rc4x128,
  aes128,
  aes256,
}

/// The protection a document is to be written with.
///
/// Held as a pending change until the document is saved, because a save starts
/// from the bytes the document was read from (ADR-0002): the password that
/// opens those is not the password being set here, and the two must not be
/// confused.
class DocumentProtection extends Equatable {
  DocumentProtection({
    required this.userPassword,
    required this.ownerPassword,
    required Set<DocumentPermission> permissions,
    this.algorithm,
  }) : permissions = _withImplied(permissions);

  /// No protection: opens without a password and permits everything.
  ///
  /// This is what the panel's "Remove protection" writes. Note that the file
  /// keeps an encryption dictionary with empty passwords — the PDF writer this
  /// app uses has no way to take one out — so a strict tool may still describe
  /// the document as encrypted even though anything may be done with it and no
  /// password is asked for.
  DocumentProtection.none()
      : userPassword = '',
        ownerPassword = '',
        permissions = DocumentPermission.values.toSet(),
        algorithm = null;

  /// The password a reader must give to open the document; empty for none.
  final String userPassword;

  /// The password that lifts the restrictions below; empty for none.
  final String ownerPassword;

  /// What may be done without the owner password.
  final Set<DocumentPermission> permissions;

  /// The encryption to write, or null for AES-256.
  final DocumentEncryption? algorithm;

  /// Whether the document will ask for a password before it can be read.
  bool get requiresPasswordToOpen => userPassword.isNotEmpty;

  /// Whether anything is withheld from a reader without the owner password.
  bool get restrictsAnything =>
      permissions.length != DocumentPermission.values.length;

  /// Whether this leaves the document open to everyone for everything.
  bool get isOpen => !requiresPasswordToOpen && !restrictsAnything;

  /// Adds the permissions that [DocumentPermission.changingContent] carries
  /// with it.
  ///
  /// Measured in Acrobat: a document permitting content changes is reported as
  /// permitting annotations and form filling as well, whatever those bits say,
  /// because the broad right subsumes the narrow ones. Normalising here keeps
  /// what the panel shows and what a reader grants the same thing.
  static Set<DocumentPermission> _withImplied(
    Set<DocumentPermission> permissions,
  ) {
    if (!permissions.contains(DocumentPermission.changingContent)) {
      return Set.unmodifiable(permissions);
    }
    return Set.unmodifiable({
      ...permissions,
      DocumentPermission.annotations,
      DocumentPermission.formFilling,
    });
  }

  DocumentProtection copyWith({
    String? userPassword,
    String? ownerPassword,
    Set<DocumentPermission>? permissions,
    DocumentEncryption? algorithm,
  }) =>
      DocumentProtection(
        userPassword: userPassword ?? this.userPassword,
        ownerPassword: ownerPassword ?? this.ownerPassword,
        permissions: permissions ?? this.permissions,
        algorithm: algorithm ?? this.algorithm,
      );

  @override
  List<Object?> get props => [
        userPassword,
        ownerPassword,
        permissions,
        algorithm,
      ];

  /// Says nothing about the passwords, deliberately.
  @override
  String toString() => 'DocumentProtection(opensWithPassword: '
      '$requiresPasswordToOpen, ownerPassword: ${ownerPassword.isNotEmpty}, '
      'permissions: ${permissions.length}, algorithm: $algorithm)';
}
