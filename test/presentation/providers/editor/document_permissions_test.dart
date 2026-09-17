import 'dart:typed_data';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:pdfsign/presentation/providers/editor/editor_clipboard.dart';
import 'package:pdfsign/presentation/providers/editor/rotate_page.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

const _a4 = Size(595, 842);

/// A document whose content may not be changed.
const _readOnly = DocumentSecurity.protected(
  password: 'open-me',
  allowsEditing: false,
  hasOwnerRights: false,
);

/// The same document, opened by whoever owns it.
const _ownerRights = DocumentSecurity.protected(
  password: 'own-me',
  allowsEditing: true,
  hasOwnerRights: true,
);

void main() {
  late _FakeRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _FakeRepository();
    container = ProviderContainer(
      overrides: [pdfDocumentRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
  });

  Future<void> open(DocumentSecurity security) async {
    repository.security = security;
    await container.read(pdfDocumentProvider.notifier).openDocument('/doc.pdf');
  }

  List<PdfPageInfo> pages() =>
      container.read(pdfDocumentProvider).documentOrNull!.pages;

  late WidgetRef widgetRef;

  Future<void> pumpHost(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Consumer(
          builder: (context, ref, _) {
            widgetRef = ref;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('a document that does not allow changes', () {
    testWidgets('should refuse to have its pages turned', (tester) async {
      // A turn is written into the file, so it is a change like any other.
      await open(_readOnly);
      await pumpHost(tester);

      expect(rotateCurrentPage(widgetRef, 1), isFalse);
      expect(pages()[0].rotation, 0);
    });

    testWidgets('should refuse a paste', (tester) async {
      await open(_readOnly);
      await pumpHost(tester);

      final outcome = await EditorClipboard(ref: widgetRef).paste();

      expect(outcome, EditorClipboardOutcome.editingNotAllowed);
    });
  });

  group('a document that does allow changes', () {
    testWidgets('should turn its pages as usual', (tester) async {
      // The control: the refusals above are about the permissions and not
      // about the test setup.
      await open(const DocumentSecurity.unprotected());
      await pumpHost(tester);

      expect(rotateCurrentPage(widgetRef, 1), isTrue);
      expect(pages()[0].rotation, 90);
    });

    testWidgets('should turn its pages for the owner of a protected one',
        (tester) async {
      await open(_ownerRights);
      await pumpHost(tester);

      expect(rotateCurrentPage(widgetRef, 1), isTrue);
    });
  });

  group('reopening the document after Save As', () {
    test('should not ask again for the password it already holds', () async {
      // Save As writes a copy that keeps the original protection, and the
      // window turns to that copy. Opening it without the password would put
      // the password prompt on screen straight after a successful save.
      await open(_ownerRights);

      await container.read(pdfDocumentProvider.notifier).openDocument(
            '/copy.pdf',
            password: 'own-me',
          );

      expect(container.read(pdfDocumentProvider).isLoaded, isTrue);
      expect(repository.lastPasswordUsed, 'own-me');
    });

    test('should ask for a password rather than call the old one wrong',
        () async {
      // A carried-over password is not one the reader typed. If it does not
      // fit the document being opened, they are owed a question, not a
      // complaint about something they never did.
      await open(_ownerRights);
      repository.refuse = true;

      await container.read(pdfDocumentProvider.notifier).openDocument(
            '/other.pdf',
            password: 'own-me',
          );

      container.read(pdfDocumentProvider).maybeMap(
            passwordRequired: (state) => expect(state.wasWrong, isFalse),
            orElse: () => fail('expected the password to be asked for'),
          );
    });
  });

  group('lifting the restriction with the owner password', () {
    test('should reopen the document when the password is accepted', () async {
      await open(_readOnly);

      repository.security = _ownerRights;
      final accepted = await container
          .read(pdfDocumentProvider.notifier)
          .unlockEditing('own-me');

      expect(accepted, isTrue);
      final security =
          container.read(pdfDocumentProvider).documentOrNull!.security;
      expect(security.allowsEditing, isTrue);
      expect(security.hasOwnerRights, isTrue);
    });

    test('should refuse a password that opens the document but grants nothing',
        () async {
      // The document's own user password is accepted and reopens it with
      // exactly the rights it already had. Reporting success would close the
      // dialog on a reader who is no better off, with nothing said.
      await open(_readOnly);

      final accepted = await container
          .read(pdfDocumentProvider.notifier)
          .unlockEditing('open-me');

      expect(accepted, isFalse);
      expect(
        container.read(pdfDocumentProvider).documentOrNull!.security,
        _readOnly,
      );
    });

    test('should leave the document alone when the password is wrong',
        () async {
      // The reader is looking at the document while they guess. A wrong guess
      // must not take it off the screen.
      await open(_readOnly);
      repository.refuse = true;

      final accepted = await container
          .read(pdfDocumentProvider.notifier)
          .unlockEditing('wrong');

      expect(accepted, isFalse);
      expect(container.read(pdfDocumentProvider).isLoaded, isTrue);
      expect(
        container.read(pdfDocumentProvider).documentOrNull!.security,
        _readOnly,
      );
    });
  });

  group('claiming the owner rights in order to set the protection', () {
    /// Permits every change, and still keeps its protection to itself.
    const editableButOwned = DocumentSecurity.protected(
      password: null,
      allowsEditing: true,
      hasOwnerRights: false,
    );

    test('should refuse a password that grants no owner rights', () async {
      // Editing was allowed before the password was given, so a test of
      // editing would pass one that is not the owner's and let a reader set
      // passwords on a document that is not theirs to set them on.
      await open(editableButOwned);

      final accepted = await container
          .read(pdfDocumentProvider.notifier)
          .unlockOwnerRights('open-me');

      expect(accepted, isFalse);
      expect(
        container.read(pdfDocumentProvider).documentOrNull!.security,
        editableButOwned,
      );
    });

    test('should accept the owner password', () async {
      await open(editableButOwned);

      repository.security = _ownerRights;
      final accepted = await container
          .read(pdfDocumentProvider.notifier)
          .unlockOwnerRights('own-me');

      expect(accepted, isTrue);
      expect(
        container.read(pdfDocumentProvider).documentOrNull!.security
            .hasOwnerRights,
        isTrue,
      );
    });

    test('should leave the document alone when the password is wrong',
        () async {
      await open(editableButOwned);
      repository.refuse = true;

      final accepted = await container
          .read(pdfDocumentProvider.notifier)
          .unlockOwnerRights('wrong');

      expect(accepted, isFalse);
      expect(container.read(pdfDocumentProvider).isLoaded, isTrue);
    });
  });
}

class _FakeRepository implements PdfDocumentRepository {
  DocumentSecurity security = const DocumentSecurity.unprotected();

  /// Makes the next open fail, as a wrong password would.
  bool refuse = false;

  /// The password the last protected open was given.
  String? lastPasswordUsed;

  PdfDocumentInfo _info(String filePath) => PdfDocumentInfo(
        filePath: filePath,
        fileName: 'doc.pdf',
        pageCount: 2,
        pages: [
          PdfPageInfo(pageNumber: 1, width: _a4.width, height: _a4.height),
          PdfPageInfo(pageNumber: 2, width: _a4.width, height: _a4.height),
        ],
        security: security,
      );

  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath) async =>
      Right(_info(filePath));

  @override
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  ) async {
    lastPasswordUsed = password;
    return refuse
        ? const Left(PasswordIncorrectFailure())
        : Right(_info(filePath));
  }

  @override
  Future<Either<Failure, Uint8List>> renderPage({
    required int pageNumber,
    required double scale,
  }) =>
      throw UnimplementedError();

  @override
  void cancelRender(int pageNumber) {}

  @override
  Future<Either<Failure, Unit>> closeDocument() async => const Right(unit);

  @override
  bool get isDocumentLoaded => true;

  @override
  PdfDocumentInfo? get currentDocument => null;
}
