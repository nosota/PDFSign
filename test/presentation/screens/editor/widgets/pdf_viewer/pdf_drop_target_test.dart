import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/placed_image.dart';
import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_drop_target.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_item.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_list.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/draggable_image_card.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/image_thumbnail_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 1x1 transparent PNG. Stands in for both the library thumbnail and the
/// rendered page; layout never depends on the decoded pixels.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

const _sidebarWidth = 200.0;
const _scale = 1.0;

// Layout constants the expectations are derived from.
const _verticalPadding = 40.0;
const _horizontalPadding = 40.0;
const _pageGap = 24.0;

// A4 in PDF points.
const _a4 = Size(595, 842);

/// Renders every page as a 1x1 PNG so the real [PdfPageList] can be mounted
/// without a PDF engine.
class _FakePdfDocumentRepository implements PdfDocumentRepository {
  _FakePdfDocumentRepository(this._pageBytes);

  final Uint8List _pageBytes;

  @override
  Future<Either<Failure, Uint8List>> renderPage({
    required int pageNumber,
    required double scale,
  }) async =>
      Right(_pageBytes);

  @override
  void cancelRender(int pageNumber) {}

  @override
  Future<void> closeDocument() async {}

  @override
  PdfDocumentInfo? get currentDocument => null;

  @override
  bool get isDocumentLoaded => true;

  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  ) =>
      throw UnimplementedError();
}

PdfDocumentInfo _document(
  List<Size> pageSizes, {
  DocumentSecurity security = const DocumentSecurity.unprotected(),
}) =>
    PdfDocumentInfo(
      filePath: '/tmp/doc.pdf',
      fileName: 'doc.pdf',
      security: security,
      pageCount: pageSizes.length,
      pages: [
        for (var i = 0; i < pageSizes.length; i++)
          PdfPageInfo(
            pageNumber: i + 1,
            width: pageSizes[i].width,
            height: pageSizes[i].height,
          ),
      ],
    );

void main() {
  late Directory tempDir;
  late String imagePath;
  late Uint8List pngBytes;
  late SharedPreferences preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    pngBytes = base64Decode(_pngBase64);
    tempDir = await Directory.systemTemp.createTemp('pdfsign_drop_test');
    imagePath = '${tempDir.path}/stamp.png';
    await File(imagePath).writeAsBytes(pngBytes);
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  /// A wide signature-shaped image: aspect ratio 800/300 ≈ 2.67.
  SidebarImage buildImage({
    int width = 800,
    int height = 300,
    Size? lastUsedSize,
  }) =>
      SidebarImage(
        id: 'img-1',
        filePath: imagePath,
        fileName: 'stamp.png',
        addedAt: DateTime(2026),
        orderIndex: 0,
        width: width,
        height: height,
        fileSize: 1024,
        lastUsedSize: lastUsedSize,
      );

  /// Mounts the real page column inside the drop target, with the sidebar card
  /// beside it — the same wiring the editor uses.
  Future<GlobalKey<PdfPageListState>> pumpEditor(
    WidgetTester tester,
    ProviderContainer container, {
    required PdfDocumentInfo document,
    required SidebarImage image,
    required double viewportWidth,
    required double viewportHeight,
  }) async {
    await tester.binding.setSurfaceSize(
      Size(viewportWidth + _sidebarWidth, viewportHeight),
    );
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final pageListKey = GlobalKey<PdfPageListState>();

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                SizedBox(
                  width: viewportWidth,
                  height: viewportHeight,
                  child: PdfDropTarget(
                    document: document,
                    scale: _scale,
                    getScrollOffset: () =>
                        pageListKey.currentState?.scrollOffsetXY ?? Offset.zero,
                    child: PdfPageList(
                      key: pageListKey,
                      document: document,
                      scale: _scale,
                      onPageChanged: (_) {},
                      onScroll: () {},
                    ),
                  ),
                ),
                SizedBox(
                  width: _sidebarWidth,
                  child: ReorderableListView.builder(
                    itemCount: 1,
                    onReorder: (_, __) {},
                    itemBuilder: (context, index) => DraggableImageCard(
                      key: ValueKey(image.id),
                      image: image,
                      index: index,
                      isSelected: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return pageListKey;
  }

  ProviderContainer buildContainer() {
    final container = ProviderContainer(
      overrides: [
        pdfDocumentRepositoryProvider
            .overrideWithValue(_FakePdfDocumentRepository(pngBytes)),
        // The selected object renders a SizeLabel, which reads the unit
        // preference.
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  /// Drags the sidebar thumbnail, from its centre, to [dropPoint].
  Future<void> dragToViewer(WidgetTester tester, Offset dropPoint) async {
    final grabPoint = tester.getCenter(find.byType(ImageThumbnailCard).first);
    final gesture = await tester.startGesture(grabPoint);
    await tester.pump(const Duration(milliseconds: 50));
    await gesture.moveTo(Offset(dropPoint.dx + 40, dropPoint.dy - 30));
    await tester.pump();
    await gesture.moveTo(dropPoint);
    await tester.pump();
    await gesture.up();
    await tester.pumpAndSettle();
  }

  Offset centreOf(PlacedImage placed) => Offset(
        placed.position.dx + placed.size.width / 2,
        placed.position.dy + placed.size.height / 2,
      );

  /// Screen rectangle of the page as it was actually laid out.
  ///
  /// Reading it from the render tree rather than from constants is what keeps
  /// these tests honest: if PdfPageList ever draws pages somewhere the drop
  /// calculator does not expect, the expectations below break.
  Rect renderedPageRect(WidgetTester tester, int pageIndex) =>
      tester.getRect(find.byType(PdfPageItem).at(pageIndex));

  group('a document that does not allow changes', () {
    testWidgets('should refuse the drop and stay empty', (tester) async {
      // The document permits reading and printing and nothing else. Putting a
      // signature on it would be exactly the change it refuses.
      final container = buildContainer();
      final document = _document(
        const [_a4],
        security: const DocumentSecurity.protected(
          password: 'open-me',
          allowsEditing: false,
          hasOwnerRights: false,
        ),
      );

      await pumpEditor(
        tester,
        container,
        document: document,
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      await dragToViewer(tester, renderedPageRect(tester, 0).center);

      expect(container.read(placedImagesProvider), isEmpty);
    });

    testWidgets('should not outline a page it will not accept',
        (tester) async {
      final container = buildContainer();
      final document = _document(
        const [_a4],
        security: const DocumentSecurity.protected(
          password: 'open-me',
          allowsEditing: false,
          hasOwnerRights: false,
        ),
      );

      await pumpEditor(
        tester,
        container,
        document: document,
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      final centre = renderedPageRect(tester, 0).center;
      final gesture =
          await tester.startGesture(tester.getCenter(find.byType(ImageThumbnailCard).first));
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.moveTo(centre);
      await tester.pump();

      expect(find.byKey(PdfDropTarget.highlightKey), findsNothing);

      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('drop on a page', () {
    testWidgets('should centre the object on the cursor', (tester) async {
      final container = buildContainer();
      final document = _document(const [_a4, _a4, _a4]);

      await pumpEditor(
        tester,
        container,
        document: document,
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      const dropPoint = Offset(300, 240);
      final pageRect = renderedPageRect(tester, 0);
      // Sanity-check the harness against the documented layout.
      expect(pageRect.left, moreOrLessEquals((600 - 595) / 2, epsilon: 0.5));
      expect(pageRect.top, moreOrLessEquals(_verticalPadding, epsilon: 0.5));

      await dragToViewer(tester, dropPoint);

      final placed = container.read(placedImagesProvider);
      expect(placed, hasLength(1));

      final expected = dropPoint - pageRect.topLeft;
      expect(
        centreOf(placed.single).dx,
        moreOrLessEquals(expected.dx, epsilon: 0.5),
      );
      expect(
        centreOf(placed.single).dy,
        moreOrLessEquals(expected.dy, epsilon: 0.5),
      );
      expect(placed.single.pageIndex, 0);
    });

    testWidgets('should use the size this image was last given', (tester) async {
      // A stamp adjusted once comes back at that size, rather than at the
      // default a fresh image gets.
      final container = buildContainer();

      await pumpEditor(
        tester,
        container,
        document: _document(const [_a4]),
        image: buildImage(lastUsedSize: const Size(140, 70)),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      await dragToViewer(tester, const Offset(300, 240));

      expect(
        container.read(placedImagesProvider).single.size,
        const Size(140, 70),
      );
    });

    testWidgets('should fit a remembered size onto a smaller page',
        (tester) async {
      // The size was settled on a larger page; it must not hang off this one.
      final container = buildContainer();

      await pumpEditor(
        tester,
        container,
        document: _document(const [Size(200, 200)]),
        image: buildImage(lastUsedSize: const Size(500, 250)),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      await dragToViewer(tester, const Offset(300, 240));

      final placed = container.read(placedImagesProvider).single;
      expect(placed.size.width, lessThanOrEqualTo(200));
      expect(placed.size.height, lessThanOrEqualTo(200));
      expect(placed.size.width / placed.size.height, closeTo(2, 0.001));
    });

    testWidgets('should size the object to a quarter of the page width',
        (tester) async {
      final container = buildContainer();

      await pumpEditor(
        tester,
        container,
        document: _document(const [_a4]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      await dragToViewer(tester, const Offset(300, 240));

      final placed = container.read(placedImagesProvider).single;
      expect(
        placed.size.width,
        moreOrLessEquals(_a4.width * 0.25, epsilon: 0.01),
      );
      expect(
        placed.size.width / placed.size.height,
        moreOrLessEquals(800 / 300, epsilon: 0.01),
      );
    });

    testWidgets('should select the new object and mark the document dirty',
        (tester) async {
      final container = buildContainer();

      await pumpEditor(
        tester,
        container,
        document: _document(const [_a4]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      expect(container.read(documentDirtyProvider), isFalse);

      await dragToViewer(tester, const Offset(300, 240));

      final placed = container.read(placedImagesProvider).single;
      expect(container.read(editorSelectionProvider), placed.id);
      expect(container.read(documentDirtyProvider), isTrue);
    });
  });

  group('drop outside a page', () {
    testWidgets('should snap into the page when dropped in the side margin',
        (tester) async {
      final container = buildContainer();

      await pumpEditor(
        tester,
        container,
        document: _document(const [_a4]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      // The page spans x 2.5..597.5; 599 is past its right edge.
      await dragToViewer(tester, const Offset(599, 240));

      final placed = container.read(placedImagesProvider).single;
      expect(placed.pageIndex, 0);
      expect(placed.position.dx, greaterThanOrEqualTo(0));
      expect(
        placed.position.dx + placed.size.width,
        lessThanOrEqualTo(_a4.width + 0.01),
      );
      // Flush against the right edge it snapped to.
      expect(
        placed.position.dx + placed.size.width,
        moreOrLessEquals(_a4.width, epsilon: 0.5),
      );
    });

    testWidgets('should land on the last page when dropped past the end',
        (tester) async {
      // Regression: this used to place the object on page 1 with no selection,
      // leaving an invisible edit and a dirty document.
      final container = buildContainer();
      const shortPage = Size(300, 100);

      await pumpEditor(
        tester,
        container,
        document: _document(const [shortPage, shortPage]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      // Pages occupy y 40..140 and 164..264; 320 is below the document.
      await dragToViewer(tester, const Offset(300, 320));

      final placed = container.read(placedImagesProvider).single;
      expect(placed.pageIndex, 1, reason: 'must snap to the last page');
      expect(container.read(editorSelectionProvider), placed.id);
      expect(
        placed.position.dy + placed.size.height,
        lessThanOrEqualTo(shortPage.height + 0.01),
      );
    });

    testWidgets('should pick the nearer page when dropped in the gap',
        (tester) async {
      final container = buildContainer();
      const shortPage = Size(300, 100);

      await pumpEditor(
        tester,
        container,
        document: _document(const [shortPage, shortPage]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      // The gap spans 140..164; 145 sits nearer the page above.
      await dragToViewer(tester, const Offset(300, 145));

      expect(container.read(placedImagesProvider).single.pageIndex, 0);
    });

    testWidgets('should land on the first page when dropped above the document',
        (tester) async {
      final container = buildContainer();
      const shortPage = Size(300, 100);

      await pumpEditor(
        tester,
        container,
        document: _document(const [shortPage, shortPage]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      // Above the top padding, so above page 1.
      await dragToViewer(tester, const Offset(300, 5));

      final placed = container.read(placedImagesProvider).single;
      expect(placed.pageIndex, 0);
      expect(placed.position.dy, greaterThanOrEqualTo(0));
    });
  });

  group('drag feedback', () {
    testWidgets('should outline the page that would receive the drop',
        (tester) async {
      final container = buildContainer();
      const shortPage = Size(300, 100);

      await pumpEditor(
        tester,
        container,
        document: _document(const [shortPage, shortPage]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      expect(find.byKey(PdfDropTarget.highlightKey), findsNothing);

      final grabPoint = tester.getCenter(find.byType(ImageThumbnailCard).first);
      final gesture = await tester.startGesture(grabPoint);
      await tester.pump(const Duration(milliseconds: 50));

      // Hover over the second page.
      await gesture.moveTo(const Offset(300, 200));
      await tester.pump();

      final highlight = find.byKey(PdfDropTarget.highlightKey);
      expect(highlight, findsOneWidget);
      expect(tester.getRect(highlight), renderedPageRect(tester, 1));

      // Hovering the margin still points at the page it would snap to.
      await gesture.moveTo(const Offset(20, 90));
      await tester.pump();
      expect(tester.getRect(highlight), renderedPageRect(tester, 0));

      await gesture.up();
      await tester.pumpAndSettle();
      expect(find.byKey(PdfDropTarget.highlightKey), findsNothing);
    });
  });

  group('drag feedback follows the document', () {
    testWidgets('should keep the outline on the page when the view scrolls',
        (tester) async {
      final container = buildContainer();

      final pageList = await pumpEditor(
        tester,
        container,
        document: _document(const [_a4, _a4, _a4]),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      final grabPoint = tester.getCenter(find.byType(ImageThumbnailCard).first);
      final gesture = await tester.startGesture(grabPoint);
      await tester.pump(const Duration(milliseconds: 50));
      await gesture.moveTo(const Offset(300, 240));
      await tester.pump();

      final highlight = find.byKey(PdfDropTarget.highlightKey);
      expect(tester.getRect(highlight), renderedPageRect(tester, 0));

      // Scroll without moving the pointer. The outline must follow the page,
      // not stay pinned to the offset it was drawn at.
      pageList.currentState!.scrollBy(0, 100, animate: false);
      await tester.pump();
      await tester.pump();

      final movedPage = renderedPageRect(tester, 0);
      expect(movedPage.top, lessThan(_verticalPadding));
      expect(tester.getRect(highlight), movedPage);

      await gesture.up();
      await tester.pumpAndSettle();
    });
  });

  group('library row with unusable dimensions', () {
    testWidgets('should still drag and drop without an invalid size',
        (tester) async {
      final container = buildContainer();

      await pumpEditor(
        tester,
        container,
        document: _document(const [_a4]),
        image: buildImage(width: 100, height: 0),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      await dragToViewer(tester, const Offset(300, 240));

      final placed = container.read(placedImagesProvider).single;
      expect(placed.size.width.isFinite, isTrue);
      expect(placed.size.height.isFinite, isTrue);
      expect(placed.size.width, greaterThan(0));
      expect(placed.size.height, greaterThan(0));
    });
  });

  group('document with no pages', () {
    testWidgets('should refuse the drop instead of inventing a page',
        (tester) async {
      final container = buildContainer();

      await pumpEditor(
        tester,
        container,
        document: _document(const []),
        image: buildImage(),
        viewportWidth: 600,
        viewportHeight: 500,
      );

      await dragToViewer(tester, const Offset(300, 240));

      expect(container.read(placedImagesProvider), isEmpty);
      expect(container.read(documentDirtyProvider), isFalse);
      expect(container.read(editorSelectionProvider), isNull);
      expect(find.byKey(PdfDropTarget.highlightKey), findsNothing);
    });
  });

  group('document with pages of differing widths', () {
    testWidgets('should hit the narrow page where it is actually drawn',
        (tester) async {
      // Regression: the drop calculator used to anchor every page to the side
      // padding while scrolling horizontally, so narrow pages were mis-hit.
      final container = buildContainer();
      const wide = Size(595, 100);
      const narrow = Size(300, 100);

      await pumpEditor(
        tester,
        container,
        document: _document(const [wide, narrow]),
        image: buildImage(),
        viewportWidth: 400,
        viewportHeight: 500,
      );

      // The column is 595 wide inside 40pt padding, so the narrow page is
      // drawn centred in it, not flush against the padding.
      final narrowPage = renderedPageRect(tester, 1);
      expect(
        narrowPage.left,
        moreOrLessEquals(_horizontalPadding + (595 - 300) / 2, epsilon: 0.5),
      );
      expect(
        narrowPage.top,
        moreOrLessEquals(_verticalPadding + 100 + _pageGap, epsilon: 0.5),
      );

      const dropPoint = Offset(250, 200);
      expect(narrowPage.contains(dropPoint), isTrue);

      await dragToViewer(tester, dropPoint);

      final placed = container.read(placedImagesProvider).single;
      expect(placed.pageIndex, 1, reason: 'the narrow page is the target');
      final expected = dropPoint - narrowPage.topLeft;
      expect(centreOf(placed).dx, moreOrLessEquals(expected.dx, epsilon: 0.5));
      expect(centreOf(placed).dy, moreOrLessEquals(expected.dy, epsilon: 0.5));
    });
  });
}
