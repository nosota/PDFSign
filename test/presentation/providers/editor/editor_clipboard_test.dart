import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/domain/entities/clipboard_contents.dart';
import 'package:pdfsign/domain/entities/clipboard_placed_object.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/domain/repositories/clipboard_repository.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';
import 'package:pdfsign/domain/repositories/sidebar_image_repository.dart';
import 'package:pdfsign/presentation/providers/editor/editor_clipboard.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/placed_image_placement.dart';

/// 1x1 transparent PNG — decodable, so the library import path is real.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

const _a4 = Size(595, 842);

void main() {
  late ProviderContainer container;
  late _FakeClipboardRepository clipboard;
  late _FakeSidebarImageRepository library;
  late Directory storage;
  late String imagePath;
  late Uint8List pngBytes;

  setUp(() async {
    pngBytes = base64Decode(_pngBase64);

    // A real file on disk: copy refuses to put an object on the clipboard
    // whose image is gone, and that distinction is part of what is tested.
    storage = await Directory.systemTemp.createTemp('pdfsign-clipboard-test');
    imagePath = '${storage.path}/source.png';
    await File(imagePath).writeAsBytes(pngBytes);

    clipboard = _FakeClipboardRepository();
    library = _FakeSidebarImageRepository(storage.path);

    container = ProviderContainer(
      overrides: [
        clipboardRepositoryProvider.overrideWithValue(clipboard),
        sidebarImageRepositoryProvider.overrideWithValue(library),
        pdfDocumentRepositoryProvider
            .overrideWithValue(_FakePdfDocumentRepository()),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(() => storage.delete(recursive: true));

    // The selection provider is autoDispose and nothing in this tree watches
    // it, so without a listener it would reset to null between arranging a
    // test and acting on it. In the app the menu and toolbar keep it alive.
    container.listen(editorSelectionProvider, (previous, next) {});
  });

  /// Loads a two-page document and reports the page the viewer is showing.
  Future<void> openDocument({int currentPage = 1}) async {
    await container.read(pdfDocumentProvider.notifier).openDocument('/doc.pdf');
    if (currentPage != 1) {
      container.read(pdfDocumentProvider.notifier).setCurrentPage(currentPage);
    }
  }

  /// Puts an object on the page and selects it.
  String placeAndSelect({
    Offset position = const Offset(100, 200),
    Size size = const Size(120, 60),
    double rotation = 0,
    int pageIndex = 0,
    String? path,
  }) {
    final placed = container.read(placedImagesProvider.notifier).addImage(
          sourceImageId: 'library-1',
          imagePath: path ?? imagePath,
          pageIndex: pageIndex,
          position: position,
          size: size,
          rotation: rotation,
        );
    container.read(editorSelectionProvider.notifier).select(placed.id);
    return placed.id;
  }

  /// Runs a clipboard action outside the fake clock.
  ///
  /// The coordinator touches real files, and `testWidgets` drives a fake
  /// async zone in which a `dart:io` future never completes.
  Future<EditorClipboardOutcome> run(
    WidgetTester tester,
    Future<EditorClipboardOutcome> Function() action,
  ) async =>
      (await tester.runAsync(action))!;

  /// Mounts a host widget and hands back the coordinator under test.
  ///
  /// The coordinator takes a [WidgetRef] and asks [FocusManager] who holds the
  /// keyboard, so it needs a tree even though none of the logic draws.
  Future<EditorClipboard> pumpClipboard(
    WidgetTester tester, {
    bool withTextField = false,
  }) async {
    late EditorClipboard editorClipboard;
    final controller = TextEditingController(text: 'comment');
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Consumer(
            builder: (context, ref, _) {
              editorClipboard = EditorClipboard(ref: ref);
              return Scaffold(
                body: withTextField
                    ? TextField(controller: controller)
                    : const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return editorClipboard;
  }

  group('copying', () {
    testWidgets('should do nothing when no object is selected', (tester) async {
      await openDocument();
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.copy), EditorClipboardOutcome.nothing);
      expect(clipboard.written, isNull);
    });

    testWidgets('should refuse when the source image is gone', (tester) async {
      // Deleting a library image deletes its file (REQUIREMENTS §13.1). With
      // no bytes there is nothing to hand to another application, and our own
      // payload would point at a path that no longer resolves.
      await openDocument();
      placeAndSelect(path: '${storage.path}/never-written.png');
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.copy), EditorClipboardOutcome.nothing);
      expect(clipboard.written, isNull);
    });

    testWidgets('should write the object and its pixels', (tester) async {
      await openDocument();
      placeAndSelect(
        position: const Offset(100, 200),
        size: const Size(120, 60),
        rotation: 0.4,
      );
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.copy), EditorClipboardOutcome.done);

      final written = clipboard.written!;
      expect(written.object.sourceImageId, 'library-1');
      expect(written.object.imagePath, imagePath);
      expect(written.object.size, const Size(120, 60));
      expect(written.object.position, const Offset(100, 200));
      expect(written.object.rotation, 0.4);
      // The bitmap is what makes the object pasteable into other apps.
      expect(written.imageBytes, pngBytes);
      expect(written.imageFormat, ClipboardImageFormat.png);
    });

    testWidgets('should report a clipboard that will not take it',
        (tester) async {
      await openDocument();
      placeAndSelect();
      clipboard.failWrites = true;
      final editorClipboard = await pumpClipboard(tester);

      expect(
        await run(tester, editorClipboard.copy),
        EditorClipboardOutcome.clipboardUnavailable,
      );
    });
  });

  group('cutting', () {
    testWidgets('should remove the object once it is safely copied',
        (tester) async {
      await openDocument();
      placeAndSelect();
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.cut), EditorClipboardOutcome.done);
      expect(container.read(placedImagesProvider), isEmpty);
      expect(container.read(editorSelectionProvider), isNull);
      expect(clipboard.written, isNotNull);
    });

    testWidgets('should keep the object when the copy failed', (tester) async {
      // Removing it here would destroy the only copy.
      await openDocument();
      placeAndSelect();
      clipboard.failWrites = true;
      final editorClipboard = await pumpClipboard(tester);

      expect(
        await run(tester, editorClipboard.cut),
        EditorClipboardOutcome.clipboardUnavailable,
      );
      expect(container.read(placedImagesProvider), hasLength(1));
    });
  });

  group('pasting an object copied from this app', () {
    ClipboardPlacedObject payload({
      Offset position = const Offset(100, 200),
      Size size = const Size(120, 60),
      double rotation = 0,
      String? path,
    }) =>
        ClipboardPlacedObject(
          sourceImageId: 'library-1',
          imagePath: path ?? imagePath,
          size: size,
          position: position,
          rotation: rotation,
        );

    testWidgets('should land beside the original, not on top of it',
        (tester) async {
      await openDocument();
      clipboard.contents = ClipboardContents(placedObject: payload());
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.paste), EditorClipboardOutcome.done);

      final placed = container.read(placedImagesProvider).single;
      expect(
        placed.position,
        const Offset(100, 200) + PlacedImagePlacement.cascadeStep,
      );
      expect(placed.size, const Size(120, 60));
      expect(container.read(editorSelectionProvider), placed.id);
    });

    testWidgets('should keep the rotation it was copied with', (tester) async {
      await openDocument();
      clipboard.contents =
          ClipboardContents(placedObject: payload(rotation: 1.2));
      final editorClipboard = await pumpClipboard(tester);

      await run(tester, editorClipboard.paste);

      expect(container.read(placedImagesProvider).single.rotation, 1.2);
    });

    testWidgets('should step further aside on a second paste', (tester) async {
      // Two pastes landing on the same point would look like the second one
      // did nothing.
      await openDocument();
      clipboard.contents = ClipboardContents(placedObject: payload());
      final editorClipboard = await pumpClipboard(tester);

      await run(tester, editorClipboard.paste);
      await run(tester, editorClipboard.paste);

      final positions =
          container.read(placedImagesProvider).map((i) => i.position).toList();
      expect(positions, hasLength(2));
      expect(positions[0], isNot(positions[1]));
    });

    testWidgets('should land on the page the reader is looking at',
        (tester) async {
      await openDocument(currentPage: 2);
      clipboard.contents = ClipboardContents(placedObject: payload());
      final editorClipboard = await pumpClipboard(tester);

      await run(tester, editorClipboard.paste);

      expect(container.read(placedImagesProvider).single.pageIndex, 1);
    });

    testWidgets('should be pulled onto the page when it was copied off it',
        (tester) async {
      await openDocument();
      clipboard.contents = ClipboardContents(
        placedObject: payload(position: const Offset(560, 820)),
      );
      final editorClipboard = await pumpClipboard(tester);

      await run(tester, editorClipboard.paste);

      final placed = container.read(placedImagesProvider).single;
      expect(placed.position.dx + placed.size.width,
          lessThanOrEqualTo(_a4.width));
      expect(placed.position.dy + placed.size.height,
          lessThanOrEqualTo(_a4.height));
    });

    testWidgets('should fall back to the pixels when the source file is gone',
        (tester) async {
      // Copied, then the library row was deleted before the paste.
      await openDocument();
      clipboard.contents = ClipboardContents(
        placedObject: payload(path: '${storage.path}/deleted.png'),
        image: ClipboardImage(bytes: pngBytes, format: ClipboardImageFormat.png),
      );
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.paste), EditorClipboardOutcome.done);

      final placed = container.read(placedImagesProvider).single;
      expect(library.added, hasLength(1));
      expect(placed.sourceImageId, library.added.single.id);
      // The size it was copied at survives the detour through the bitmap.
      expect(placed.size, const Size(120, 60));
    });

    testWidgets('should give up when the source file is gone and so are pixels',
        (tester) async {
      await openDocument();
      clipboard.contents = ClipboardContents(
        placedObject: payload(path: '${storage.path}/deleted.png'),
      );
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.paste), EditorClipboardOutcome.nothing);
      expect(container.read(placedImagesProvider), isEmpty);
    });
  });

  group('pasting an image from another application', () {
    testWidgets('should add it to the library and centre it on the page',
        (tester) async {
      await openDocument();
      clipboard.contents = ClipboardContents(
        image: ClipboardImage(bytes: pngBytes, format: ClipboardImageFormat.png),
      );
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.paste), EditorClipboardOutcome.done);

      expect(library.added, hasLength(1));
      final placed = container.read(placedImagesProvider).single;
      expect(placed.imagePath, library.added.single.filePath);
      expect(
        placed.position.dx + placed.size.width / 2,
        closeTo(_a4.width / 2, 0.001),
      );
      expect(
        placed.position.dy + placed.size.height / 2,
        closeTo(_a4.height / 2, 0.001),
      );
    });

    testWidgets('should report an image the library will not take',
        (tester) async {
      await openDocument();
      library.failAdds = true;
      clipboard.contents = ClipboardContents(
        image: ClipboardImage(bytes: pngBytes, format: ClipboardImageFormat.png),
      );
      final editorClipboard = await pumpClipboard(tester);

      expect(
        await run(tester, editorClipboard.paste),
        EditorClipboardOutcome.imageImportFailed,
      );
      expect(container.read(placedImagesProvider), isEmpty);
    });
  });

  group('pasting nothing', () {
    testWidgets('should leave the document alone for an empty clipboard',
        (tester) async {
      await openDocument();
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.paste), EditorClipboardOutcome.nothing);
      expect(container.read(placedImagesProvider), isEmpty);
    });

    testWidgets('should report a clipboard that cannot be read', (tester) async {
      await openDocument();
      clipboard.failReads = true;
      final editorClipboard = await pumpClipboard(tester);

      expect(
        await run(tester, editorClipboard.paste),
        EditorClipboardOutcome.clipboardUnavailable,
      );
    });

    testWidgets('should do nothing when no document is open', (tester) async {
      clipboard.contents = ClipboardContents(
        image: ClipboardImage(bytes: pngBytes, format: ClipboardImageFormat.png),
      );
      final editorClipboard = await pumpClipboard(tester);

      expect(await run(tester, editorClipboard.paste), EditorClipboardOutcome.nothing);
      // The clipboard is not even consulted: there is nowhere to put anything.
      expect(library.added, isEmpty);
    });
  });

  group('while the user is typing', () {
    testWidgets('should leave copy to the text field', (tester) async {
      // The Edit menu owns Cmd+C for the whole window, so without this the
      // object would be copied while the user meant the text.
      await openDocument();
      placeAndSelect();
      final editorClipboard = await pumpClipboard(tester, withTextField: true);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(
        await run(tester, editorClipboard.copy),
        EditorClipboardOutcome.handledByTextField,
      );
      expect(clipboard.written, isNull);
    });

    testWidgets('should leave paste to the text field', (tester) async {
      await openDocument();
      clipboard.contents = ClipboardContents(
        image: ClipboardImage(bytes: pngBytes, format: ClipboardImageFormat.png),
      );
      final editorClipboard = await pumpClipboard(tester, withTextField: true);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(
        await run(tester, editorClipboard.paste),
        EditorClipboardOutcome.handledByTextField,
      );
      expect(container.read(placedImagesProvider), isEmpty);
    });

    testWidgets('should leave the object in place on cut', (tester) async {
      await openDocument();
      placeAndSelect();
      final editorClipboard = await pumpClipboard(tester, withTextField: true);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(
        await run(tester, editorClipboard.cut),
        EditorClipboardOutcome.handledByTextField,
      );
      expect(container.read(placedImagesProvider), hasLength(1));
    });
  });
}

class _WrittenItem {
  const _WrittenItem(this.object, this.imageBytes, this.imageFormat);

  final ClipboardPlacedObject object;
  final Uint8List imageBytes;
  final ClipboardImageFormat imageFormat;
}

class _FakeClipboardRepository implements ClipboardRepository {
  ClipboardContents contents = const ClipboardContents();
  _WrittenItem? written;
  bool failWrites = false;
  bool failReads = false;

  @override
  Future<Either<Failure, ClipboardContents>> read() async =>
      failReads ? const Left(ClipboardFailure()) : Right(contents);

  @override
  Future<Either<Failure, Unit>> writePlacedObject({
    required ClipboardPlacedObject object,
    required Uint8List imageBytes,
    required ClipboardImageFormat imageFormat,
  }) async {
    if (failWrites) {
      return const Left(ClipboardFailure());
    }
    written = _WrittenItem(object, imageBytes, imageFormat);
    contents = ClipboardContents(
      placedObject: object,
      image: ClipboardImage(bytes: imageBytes, format: imageFormat),
    );
    return const Right(unit);
  }
}

class _FakeSidebarImageRepository implements SidebarImageRepository {
  _FakeSidebarImageRepository(this._storagePath);

  final String _storagePath;
  final List<SidebarImage> added = [];
  bool failAdds = false;

  @override
  Future<Either<Failure, SidebarImage>> addImageFromBytes({
    required Uint8List bytes,
    required String fileExtension,
    required String fileName,
    required int width,
    required int height,
  }) async {
    if (failAdds) {
      return const Left(StorageFailure(message: 'nope'));
    }
    final image = SidebarImage(
      id: 'library-${added.length + 1}',
      filePath: '$_storagePath/stored-${added.length + 1}.$fileExtension',
      fileName: fileName,
      addedAt: DateTime(2026),
      orderIndex: added.length,
      width: width,
      height: height,
      fileSize: bytes.length,
    );
    await File(image.filePath).writeAsBytes(bytes);
    added.add(image);
    return Right(image);
  }

  @override
  Stream<List<SidebarImage>> watchImages() => Stream.value(added);

  @override
  Future<Either<Failure, List<SidebarImage>>> cleanupInvalidImages() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, SidebarImage>> addImage({
    required String filePath,
    required String fileName,
    required int width,
    required int height,
    required int fileSize,
  }) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, List<SidebarImage>>> getImages() async => Right(added);

  @override
  Future<Either<Failure, Unit>> removeImage(String id) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> reorderImages(List<String> orderedIds) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> clearAllImages() => throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> updateComment(String id, String? comment) =>
      throw UnimplementedError();
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
            PdfPageInfo(
              pageNumber: 1,
              width: _a4.width,
              height: _a4.height,
            ),
            PdfPageInfo(
              pageNumber: 2,
              width: _a4.width,
              height: _a4.height,
            ),
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
