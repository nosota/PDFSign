import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/domain/entities/document_security.dart';

/// A document read without the owner password, protected as [protection] says.
DocumentSecurity readWithout(DocumentProtection? protection) =>
    DocumentSecurity.protected(
      password: protection?.requiresPasswordToOpen ?? false ? 'open-me' : null,
      allowsEditing:
          protection?.permissions.contains(DocumentPermission.changingContent) ??
              true,
      hasOwnerRights: false,
      current: protection,
    );

void main() {
  group('whether the owner password has to be asked for', () {
    test('should not ask for a document with no protection at all', () {
      expect(
        const DocumentSecurity.unprotected().protectionNeedsOwnerPassword,
        isFalse,
      );
    });

    test('should ask when the document withholds something', () {
      final security = readWithout(
        DocumentProtection(
          userPassword: '',
          ownerPassword: '',
          permissions: const {DocumentPermission.printing},
        ),
      );

      expect(security.protectionNeedsOwnerPassword, isTrue);
    });

    test('should ask when the document asks for a password to open', () {
      final security = readWithout(
        DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: '',
          permissions: DocumentPermission.values.toSet(),
        ),
      );

      expect(security.protectionNeedsOwnerPassword, isTrue);
    });

    test('should ask when the protection could not be read', () {
      // Nothing is known about what it permits, so the careful answer is the
      // one that asks rather than the one that assumes.
      expect(readWithout(null).protectionNeedsOwnerPassword, isTrue);
    });

    test('should not ask when the document is encrypted but withholds nothing',
        () {
      // The case a reader actually meets: an owner password, every permission
      // granted, and no password to open. It restricts nobody, and it cannot
      // be told apart from what this app leaves behind when protection is
      // removed — so asking would be asking for a password that may not exist.
      final security = readWithout(
        DocumentProtection(
          userPassword: '',
          ownerPassword: '',
          permissions: DocumentPermission.values.toSet(),
          algorithm: DocumentEncryption.aes256,
        ),
      );

      expect(security.isProtected, isTrue);
      expect(security.protectionNeedsOwnerPassword, isFalse);
    });

    test('should not ask a reader who already holds the owner password', () {
      final security = DocumentSecurity.protected(
        password: 'own-me',
        allowsEditing: true,
        hasOwnerRights: true,
        current: DocumentProtection(
          userPassword: '',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      expect(security.protectionNeedsOwnerPassword, isFalse);
    });
  });
}
