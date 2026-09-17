import 'dart:typed_data';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/editor/restack_selected.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

void main() {
  late _FakeRepository repository;
  late ProviderContainer container;
  late WidgetRef widgetRef;

  setUp(() {
    repository = _FakeRepository();
    container = ProviderContainer(
      overrides: [pdfDocumentRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    // Nothing in this tree watches the selection and it is autoDispose.
    container.listen(editorSelectionProvider, (previous, next) {});
  });

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

  String place() => container.read(placedImagesProvider.notifier).addImage(
        imagePath: '/storage/stamp.png',
        pageIndex: 0,
        position: const Offset(10, 10),
        size: const Size(40, 20),
      ).id;

  void select(String id) =>
      container.read(editorSelectionProvider.notifier).select(id);

  List<String> order() =>
      [for (final image in container.read(placedImagesProvider)) image.id];

  group('restacking the selected object', () {
    testWidgets('should move it and say that it moved', (tester) async {
      final back = place();
      final front = place();
      select(back);
      await pumpHost(tester);

      expect(restackSelected(widgetRef, ZOrderMove.toFront), isTrue);
      expect(order(), [front, back]);
    });

    testWidgets('should say nothing moved when it is already there',
        (tester) async {
      // The buttons stay enabled whenever something is selected, so asking for
      // a move that cannot happen is ordinary rather than exceptional — and it
      // must not look like an action for the undo history to record.
      place();
      final front = place();
      select(front);
      await pumpHost(tester);

      expect(restackSelected(widgetRef, ZOrderMove.toFront), isFalse);
      expect(restackSelected(widgetRef, ZOrderMove.forward), isFalse);
    });

    testWidgets('should do nothing with no selection', (tester) async {
      final back = place();
      final front = place();
      await pumpHost(tester);

      expect(restackSelected(widgetRef, ZOrderMove.toFront), isFalse);
      expect(order(), [back, front]);
    });
  });

  group('a document that does not allow changes', () {
    testWidgets('should refuse to have its objects restacked', (tester) async {
      // Restacking changes the order the objects are written in, so it changes
      // the file as much as moving one does.
      repository.security = const DocumentSecurity.protected(
        password: 'open-me',
        allowsEditing: false,
        hasOwnerRights: false,
      );
      await container
          .read(pdfDocumentProvider.notifier)
          .openDocument('/doc.pdf');
      final back = place();
      final front = place();
      select(back);
      await pumpHost(tester);

      expect(restackSelected(widgetRef, ZOrderMove.toFront), isFalse);
      expect(order(), [back, front]);
    });
  });
}

class _FakeRepository implements PdfDocumentRepository {
  DocumentSecurity security = const DocumentSecurity.unprotected();

  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath) async =>
      Right(
        PdfDocumentInfo(
          filePath: filePath,
          fileName: 'doc.pdf',
          pageCount: 1,
          pages: const [PdfPageInfo(pageNumber: 1, width: 595, height: 842)],
          security: security,
        ),
      );

  @override
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  ) =>
      throw UnimplementedError();

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
