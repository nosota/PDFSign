import 'dart:typed_data';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/editor_history.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/history_actions.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/editor/restack_selected.dart';
import 'package:pdfsign/presentation/providers/editor/rotate_page.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

void main() {
  late ProviderContainer container;
  late WidgetRef ref;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        pdfDocumentRepositoryProvider.overrideWithValue(_FakeRepository()),
      ],
    );
    addTearDown(container.dispose);
    container.listen(editorSelectionProvider, (previous, next) {});
  });

  Future<void> openDocument(WidgetTester tester) async {
    await container.read(pdfDocumentProvider.notifier).openDocument('/doc.pdf');
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Consumer(
          builder: (context, widgetRef, _) {
            ref = widgetRef;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  String place({int page = 0}) =>
      container.read(placedImagesProvider.notifier).addImage(
            imagePath: '/storage/stamp.png',
            pageIndex: page,
            position: const Offset(10, 10),
            size: const Size(40, 20),
          ).id;

  void select(String id) =>
      container.read(editorSelectionProvider.notifier).select(id);

  int undoDepth() => container.read(editorHistoryProvider.notifier).undoDepth;

  List<PlacedImage> objects() => container.read(placedImagesProvider);

  List<PdfPageInfo> pages() =>
      container.read(pdfDocumentProvider).documentOrNull!.pages;

  group('deleting an object', () {
    testWidgets('should be one step, and give it back', (tester) async {
      await openDocument(tester);
      final id = place();
      select(id);

      deleteSelectedImage(ref);
      expect(objects(), isEmpty);
      expect(undoDepth(), 1);

      expect(undoEdit(ref), isTrue);
      expect(objects().map((o) => o.id), [id]);
    });

    testWidgets('should put the selection back on what came back',
        (tester) async {
      await openDocument(tester);
      final id = place();
      select(id);
      deleteSelectedImage(ref);

      undoEdit(ref);

      expect(container.read(editorSelectionProvider), id);
    });
  });

  group('turning a page', () {
    testWidgets('should be one step for the page and the objects on it',
        (tester) async {
      // The objects move with the page. Putting the page back without them
      // would leave them lying across it at the wrong angle.
      await openDocument(tester);
      place();
      final before = objects().single;

      rotateCurrentPage(ref, 1);
      expect(pages()[0].rotation, 90);
      expect(objects().single, isNot(before));
      expect(undoDepth(), 1);

      undoEdit(ref);

      expect(pages()[0].rotation, 0);
      expect(objects().single, before);
    });

    testWidgets('should leave the file rotation alone', (tester) async {
      // What the file says is the baseline a save writes. Restoring it would
      // tell the document it had been saved when it had not.
      await openDocument(tester);
      rotateCurrentPage(ref, 1);

      undoEdit(ref);

      expect(pages()[0].fileRotation, 0);
      expect(pages()[0].isRotatedFromFile, isFalse);
    });

    testWidgets('should give the page its sides back', (tester) async {
      await openDocument(tester);
      final upright = Size(pages()[0].width, pages()[0].height);
      rotateCurrentPage(ref, 1);

      undoEdit(ref);

      expect(Size(pages()[0].width, pages()[0].height), upright);
    });
  });

  group('restacking', () {
    testWidgets('should be one step', (tester) async {
      await openDocument(tester);
      final back = place();
      final front = place();
      select(back);

      restackSelected(ref, ZOrderMove.toFront);
      expect(objects().map((o) => o.id), [front, back]);
      expect(undoDepth(), 1);

      undoEdit(ref);

      expect(objects().map((o) => o.id), [back, front]);
    });

    testWidgets('should record nothing when the object cannot move',
        (tester) async {
      // The buttons stay enabled while anything is selected, so asking an
      // object already at the front to come forward is ordinary. A step for it
      // would make the next undo appear to do nothing.
      await openDocument(tester);
      place();
      final front = place();
      select(front);

      restackSelected(ref, ZOrderMove.toFront);

      expect(undoDepth(), 0);
    });
  });

  group('undoing past a save', () {
    testWidgets('should make the document unsaved again', (tester) async {
      // The dirty state is measured against what was written, so this needs
      // nothing of its own — but it is the behaviour a reader relies on, and
      // it is worth holding to.
      await openDocument(tester);
      final id = place();
      container
          .read(savedPlacedImagesProvider.notifier)
          .markSaved(objects());
      expect(container.read(documentDirtyProvider), isFalse);

      select(id);
      deleteSelectedImage(ref);
      expect(container.read(documentDirtyProvider), isTrue);

      undoEdit(ref);

      expect(container.read(documentDirtyProvider), isFalse,
          reason: 'the document is back to exactly what was written');
    });
  });

  group('redo', () {
    testWidgets('should put back what the undo took away', (tester) async {
      await openDocument(tester);
      final id = place();
      select(id);
      deleteSelectedImage(ref);
      undoEdit(ref);

      expect(redoEdit(ref), isTrue);

      expect(objects(), isEmpty);
    });

    testWidgets('should be gone once something else is done', (tester) async {
      await openDocument(tester);
      final first = place();
      select(first);
      deleteSelectedImage(ref);
      undoEdit(ref);

      // Another step, made the way every action makes one.
      recordHistoryStep(ref, place);

      expect(container.read(editorHistoryProvider).canRedo, isFalse);
      expect(redoEdit(ref), isFalse);
    });
  });

  group('with nowhere to go', () {
    testWidgets('should do nothing and say so', (tester) async {
      await openDocument(tester);

      expect(undoEdit(ref), isFalse);
      expect(redoEdit(ref), isFalse);
    });
  });
}

class _FakeRepository implements PdfDocumentRepository {
  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath) async =>
      Right(
        PdfDocumentInfo(
          filePath: filePath,
          fileName: 'doc.pdf',
          pageCount: 2,
          pages: const [
            PdfPageInfo(pageNumber: 1, width: 595, height: 842),
            PdfPageInfo(pageNumber: 2, width: 595, height: 842),
          ],
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
