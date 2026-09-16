import 'dart:typed_data';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/editor/rotate_page.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

const _a4 = Size(595, 842);

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        pdfDocumentRepositoryProvider
            .overrideWithValue(_FakePdfDocumentRepository()),
      ],
    );
    addTearDown(container.dispose);
  });

  Future<void> openDocument({int currentPage = 1}) async {
    await container.read(pdfDocumentProvider.notifier).openDocument('/doc.pdf');
    if (currentPage != 1) {
      container.read(pdfDocumentProvider.notifier).setCurrentPage(currentPage);
    }
  }

  List<PdfPageInfo> pages() =>
      container.read(pdfDocumentProvider).documentOrNull!.pages;

  late WidgetRef widgetRef;

  /// Mounts a host whose only job is to hand over a [WidgetRef].
  ///
  /// The helper writes to providers, which Riverpod forbids during a build, so
  /// it is called from the test body rather than from a builder.
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

  bool rotate(int quarterTurns) => rotateCurrentPage(widgetRef, quarterTurns);

  group('turning the page in view', () {
    testWidgets('should swap the sides of that page only', (tester) async {
      await openDocument();
      await pumpHost(tester);

      expect(rotate(1), isTrue);

      expect(pages()[0].width, 842);
      expect(pages()[0].height, 595);
      expect(pages()[0].rotation, 90);
      expect(pages()[1].width, 595, reason: 'the other page is untouched');
    });

    testWidgets('should turn the page the reader is looking at',
        (tester) async {
      await openDocument(currentPage: 2);
      await pumpHost(tester);

      rotate(1);

      expect(pages()[0].rotation, 0);
      expect(pages()[1].rotation, 90);
    });

    testWidgets('should turn the other way for a negative quarter',
        (tester) async {
      await openDocument();
      await pumpHost(tester);

      rotate(-1);

      expect(pages()[0].rotation, 270);
    });

    testWidgets('should make the document dirty', (tester) async {
      await openDocument();
      await pumpHost(tester);
      expect(container.read(documentDirtyProvider), isFalse);

      rotate(1);

      // Without this a reader could turn a page, close, and lose it in
      // silence — the failure ADR-0008 was written about.
      expect(container.read(documentDirtyProvider), isTrue);
    });

    testWidgets('should be clean again when turned back', (tester) async {
      await openDocument();
      await pumpHost(tester);

      rotate(1);
      rotate(-1);

      expect(pages()[0].rotation, 0);
      expect(container.read(documentDirtyProvider), isFalse);
    });

    testWidgets('should be clean again after a full circle', (tester) async {
      // Objects move with the page, so a drifting angle would leave the
      // document looking modified after four turns that changed nothing.
      await openDocument();
      container.read(placedImagesProvider.notifier).addImage(
            imagePath: '/storage/a.png',
            pageIndex: 0,
            position: const Offset(10, 20),
            size: const Size(100, 50),
          );
      container.read(savedPlacedImagesProvider.notifier).markSaved(
            container.read(placedImagesProvider),
          );
      await pumpHost(tester);
      expect(container.read(documentDirtyProvider), isFalse);

      for (var i = 0; i < 4; i++) {
        rotate(1);
      }

      expect(container.read(documentDirtyProvider), isFalse);
    });

    testWidgets('should be clean once the file has caught up', (tester) async {
      await openDocument();
      await pumpHost(tester);
      rotate(1);

      container.read(pdfDocumentProvider.notifier).markRotationsSaved();

      expect(container.read(documentDirtyProvider), isFalse);
      expect(pages()[0].rotation, 90, reason: 'still shown turned');
      expect(pages()[0].fileRotation, 90, reason: 'and the file agrees');
    });
  });

  group('the objects standing on the page', () {
    /// Puts an object in the top-left corner of the page.
    String placeTopLeft({int pageIndex = 0}) =>
        container.read(placedImagesProvider.notifier).addImage(
              imagePath: '/storage/a.png',
              pageIndex: pageIndex,
              position: Offset.zero,
              size: const Size(100, 50),
            ).id;

    testWidgets('should travel with the page', (tester) async {
      await openDocument();
      placeTopLeft();
      await pumpHost(tester);

      rotate(1);

      // The top-left corner of a portrait page becomes the top-right corner
      // of the landscape one, and the object stands on end.
      final image = container.read(placedImagesProvider).single;
      expect(image.size, const Size(50, 100));
      expect(image.position.dx + image.size.width, _a4.height);
      expect(image.position.dy, 0);
    });

    testWidgets('should turn on their own axis too', (tester) async {
      await openDocument();
      placeTopLeft();
      await pumpHost(tester);

      rotate(1);

      expect(
        container.read(placedImagesProvider).single.rotation,
        closeTo(1.5707963267948966, 1e-9),
      );
    });

    testWidgets('should come home after four turns', (tester) async {
      await openDocument();
      placeTopLeft();
      await pumpHost(tester);
      final before = container.read(placedImagesProvider).single;

      for (var i = 0; i < 4; i++) {
        rotate(1);
      }

      final after = container.read(placedImagesProvider).single;
      expect(after.position, before.position);
      expect(after.size, before.size);
      expect(after.rotation, closeTo(before.rotation, 1e-9));
    });

    testWidgets('should leave objects on other pages where they are',
        (tester) async {
      await openDocument();
      placeTopLeft(pageIndex: 1);
      await pumpHost(tester);

      rotate(1);

      expect(container.read(placedImagesProvider).single.position, Offset.zero);
      expect(
        container.read(placedImagesProvider).single.size,
        const Size(100, 50),
      );
    });
  });

  group('when there is nothing to turn', () {
    testWidgets('should refuse before a document is open', (tester) async {
      await pumpHost(tester);
      expect(rotate(1), isFalse);
    });

    testWidgets('should refuse a turn of no quarters', (tester) async {
      await openDocument();
      await pumpHost(tester);
      expect(rotate(0), isFalse);
      expect(pages()[0].rotation, 0);
    });
  });
}

/// A two-page A4 document; nothing is ever rendered.
class _FakePdfDocumentRepository implements PdfDocumentRepository {
  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath) async =>
      Right(
        PdfDocumentInfo(
          filePath: filePath,
          fileName: 'doc.pdf',
          pageCount: 2,
          pages: [
            PdfPageInfo(pageNumber: 1, width: _a4.width, height: _a4.height),
            PdfPageInfo(pageNumber: 2, width: _a4.width, height: _a4.height),
          ],
        ),
      );

  @override
  Future<Either<Failure, Uint8List>> renderPage({
    required int pageNumber,
    required double scale,
  }) =>
      throw UnimplementedError();

  @override
  void cancelRender(int pageNumber) {}

  @override
  Future<void> closeDocument() async {}

  @override
  PdfDocumentInfo? get currentDocument => null;

  @override
  bool get isDocumentLoaded => true;

  @override
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  ) =>
      throw UnimplementedError();
}
