import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
import 'package:pdfsign/presentation/providers/editor/print_document.dart';

/// A document read without the owner password, protected as [protection] says.
DocumentSecurity readWithout(DocumentProtection protection) =>
    DocumentSecurity.protected(
      password: protection.requiresPasswordToOpen ? 'open-me' : null,
      allowsEditing:
          protection.permissions.contains(DocumentPermission.changingContent),
      hasOwnerRights: false,
      current: protection,
    );

DocumentProtection withPermissions(Set<DocumentPermission> permissions) =>
    DocumentProtection(
      userPassword: '',
      ownerPassword: '',
      permissions: permissions,
    );

void main() {
  group('whether printing is the reader\'s to do', () {
    test('should print a document with no protection at all', () {
      expect(mayPrint(const DocumentSecurity.unprotected(), null), isTrue);
    });

    test('should refuse a document that withholds printing', () {
      final security = readWithout(
        withPermissions({DocumentPermission.copying}),
      );

      expect(mayPrint(security, null), isFalse);
    });

    test('should print a protected document that allows it', () {
      final security = readWithout(
        withPermissions({
          DocumentPermission.printing,
          DocumentPermission.copying,
        }),
      );

      expect(mayPrint(security, null), isTrue);
    });

    test('should print for whoever holds the owner password', () {
      // The owner password grants full access whatever the flags say.
      final security = DocumentSecurity.protected(
        password: 'own-me',
        allowsEditing: true,
        hasOwnerRights: true,
        current: withPermissions(const {}),
      );

      expect(mayPrint(security, null), isTrue);
    });

    test('should print a protection the reader has just asked for', () {
      // Setting protection takes the owner password, so a reader who has one
      // pending owns the document by definition.
      final security = readWithout(
        withPermissions({DocumentPermission.copying}),
      );

      expect(mayPrint(security, withPermissions(const {})), isTrue);
    });

    test('should print a document whose protection could not be read', () {
      // Nothing is known about what it permits; the system reads the document
      // itself before it prints, and that is the check that decides.
      const security = DocumentSecurity.protected(
        password: null,
        allowsEditing: true,
        hasOwnerRights: false,
      );

      expect(mayPrint(security, null), isTrue);
    });
  });

  group('the password the composed document opens with', () {
    test('should be the one the document was opened with', () {
      const security = DocumentSecurity.protected(
        password: 'open-me',
        allowsEditing: true,
        hasOwnerRights: false,
      );

      expect(passwordFor(security, null), 'open-me');
    });

    test('should be the owner password of a protection not yet saved', () {
      // The composed bytes carry the protection the reader asked for, and the
      // owner password is what prints a document that withholds printing.
      final pending = DocumentProtection(
        userPassword: 'open-me',
        ownerPassword: 'own-me',
        permissions: const {},
      );

      expect(passwordFor(const DocumentSecurity.unprotected(), pending),
          'own-me');
    });

    test('should fall back to the user password when there is no owner one',
        () {
      final pending = DocumentProtection(
        userPassword: 'open-me',
        ownerPassword: '',
        permissions: DocumentPermission.values.toSet(),
      );

      expect(passwordFor(const DocumentSecurity.unprotected(), pending),
          'open-me');
    });

    test('should be nothing for a protection that asks for no password', () {
      expect(
        passwordFor(const DocumentSecurity.unprotected(),
            DocumentProtection.none()),
        isNull,
      );
    });
  });
}
