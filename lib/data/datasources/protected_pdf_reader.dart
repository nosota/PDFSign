import 'dart:typed_data';

import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;

import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/domain/entities/document_security.dart';

/// A protected document, read far enough that it can be rendered.
class ProtectedPdfContents {
  const ProtectedPdfContents({
    required this.renderableBytes,
    required this.rotations,
    required this.security,
  });

  /// The document with its passwords removed, for the renderer.
  ///
  /// **These bytes must never reach the disk.** Writing them would leave an
  /// unprotected copy of a protected document behind. They exist to be handed
  /// to the renderer in memory and for nothing else; every save starts from
  /// the original bytes instead (ADR-0002).
  final Uint8List renderableBytes;

  /// Each page's `/Rotate`, in degrees, in page order.
  ///
  /// Read here because the document is already open and parsed; reading it
  /// again from the file would mean supplying the password a second time.
  final List<int> rotations;

  /// What the document permits, and the password that opened it.
  final DocumentSecurity security;
}

/// Opens password-protected PDFs.
///
/// The renderer cannot do this itself: pdfx takes a password on its Dart API
/// and drops it on macOS, where it refuses any encrypted document outright.
/// So the document is opened by the PDF writer instead — which does take a
/// password — and a copy without passwords is handed to the renderer. The
/// copy is identical page for page; only the protection is gone from it.
class ProtectedPdfReader {
  const ProtectedPdfReader();

  /// Reads [bytes] with [password], or without one for a document that needs
  /// none.
  ///
  /// [bytes] must already be known to be an encrypted PDF — the caller
  /// establishes that with CoreGraphics before coming here. That is what makes
  /// it safe to read a refusal at the opening stage as a protection this app
  /// cannot handle.
  ///
  /// Throws [PdfPasswordRequiredException] when the password is missing or
  /// wrong, and [PdfUnsupportedProtectionException] when the document is
  /// protected by something this app cannot open. Anything that goes wrong
  /// after the document is open — a damaged page tree, say — is passed on as
  /// it is, because a broken document is not an unsupported one.
  Future<ProtectedPdfContents> read(
    Uint8List bytes, {
    String? password,
    bool requiresPasswordToOpen = false,
  }) async {
    final document = _open(bytes, password);
    try {
      // Read before the passwords are cleared: blanking them takes the
      // permissions and the owner's rights with them.
      final security = _securityOf(
        document,
        password,
        requiresPasswordToOpen: requiresPasswordToOpen,
      );
      final rotations = [
        for (var i = 0; i < document.pages.count; i++)
          document.pages[i].rotation.index * 90,
      ];

      return ProtectedPdfContents(
        renderableBytes: await _withoutPasswords(document),
        rotations: rotations,
        security: security,
      );
    } finally {
      document.dispose();
    }
  }

  /// Opens the document, turning the library's refusals into typed failures.
  sf.PdfDocument _open(Uint8List bytes, String? password) {
    try {
      return sf.PdfDocument(inputBytes: bytes, password: password);
    } on ArgumentError catch (error) {
      // The library names the argument it turned down. For a bad password
      // that name is `password`, which makes this a test of a field rather
      // than a search for words in a sentence. Measured against a wrong
      // password, a missing one, a truncated file and bytes that are not a
      // PDF at all: only the password cases carry that name.
      if (error.name == 'password') {
        throw PdfPasswordRequiredException(passwordWasGiven: password != null);
      }
      // The file is encrypted and the library turned it down for a reason
      // that is not the password: it does not handle this kind of protection.
      // Certificate-based protection is the case in practice — the library
      // reads the standard security handler and nothing else.
      throw PdfUnsupportedProtectionException('${error.message}');
    }
  }

  /// Reads what the document permits.
  DocumentSecurity _securityOf(
    sf.PdfDocument document,
    String? password, {
    required bool requiresPasswordToOpen,
  }) {
    final security = document.security;
    // Opening with the owner password grants full access whatever the
    // permission flags say (PDF 32000-1:2008, 7.6.3.2). Measured: the library
    // reports a non-empty owner password exactly when the document was opened
    // with it — including the case where it recovers the user password too.
    final hasOwnerRights = security.ownerPassword.isNotEmpty;
    final granted = _granted(security);

    return DocumentSecurity.protected(
      password: password,
      hasOwnerRights: hasOwnerRights,
      allowsEditing:
          hasOwnerRights || granted.contains(DocumentPermission.changingContent),
      current: DocumentProtection(
        // The password that opens the document, as far as it is known. Opening
        // with the owner password reveals the user one as well; opening with
        // the user password does not work the other way round, so the owner
        // field is left empty and the panel asks for it afresh.
        userPassword: requiresPasswordToOpen ? security.userPassword : '',
        ownerPassword: security.ownerPassword,
        permissions: granted,
        algorithm: _encryptionOf(security.algorithm),
      ),
    );
  }

  /// What the document permits, in the app's own terms.
  Set<DocumentPermission> _granted(sf.PdfSecurity security) {
    final flags = <sf.PdfPermissionsFlags>{};
    security.permissions.forEach(flags.add);

    return {
      if (flags.contains(sf.PdfPermissionsFlags.print))
        DocumentPermission.printing,
      if (flags.contains(sf.PdfPermissionsFlags.copyContent))
        DocumentPermission.copying,
      if (flags.contains(sf.PdfPermissionsFlags.assembleDocument))
        DocumentPermission.pageAssembly,
      if (flags.contains(sf.PdfPermissionsFlags.editAnnotations))
        DocumentPermission.annotations,
      if (flags.contains(sf.PdfPermissionsFlags.editContent))
        DocumentPermission.changingContent,
      if (flags.contains(sf.PdfPermissionsFlags.fillFields))
        DocumentPermission.formFilling,
    };
  }

  static DocumentEncryption _encryptionOf(sf.PdfEncryptionAlgorithm algorithm) =>
      switch (algorithm) {
        sf.PdfEncryptionAlgorithm.rc4x40Bit => DocumentEncryption.rc4x40,
        sf.PdfEncryptionAlgorithm.rc4x128Bit => DocumentEncryption.rc4x128,
        sf.PdfEncryptionAlgorithm.aesx128Bit => DocumentEncryption.aes128,
        sf.PdfEncryptionAlgorithm.aesx256Bit => DocumentEncryption.aes256,
        sf.PdfEncryptionAlgorithm.aesx256BitRevision6 =>
          DocumentEncryption.aes256,
      };

  /// Returns a copy of [document] the renderer will accept.
  ///
  /// Emptying both passwords leaves the document encrypted with the empty
  /// user password, which CoreGraphics — and so pdfx — opens unaided.
  Future<Uint8List> _withoutPasswords(sf.PdfDocument document) async {
    document.security
      ..userPassword = ''
      ..ownerPassword = '';
    return Uint8List.fromList(await document.save());
  }
}
