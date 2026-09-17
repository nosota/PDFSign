import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/domain/repositories/sidebar_image_repository.dart';
import 'package:pdfsign/presentation/providers/editor/editor_history.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/history_actions.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/placed_image_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 1x1 transparent PNG, so the object has something to draw.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  late ProviderContainer container;
  late _FakeSidebarImageRepository library;
  late Directory directory;
  late String imagePath;

  setUp(() async {
    // The size label reads the unit preference.
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    directory = await Directory.systemTemp.createTemp('pdfsign-resize-test');
    imagePath = '${directory.path}/stamp.png';
    await File(imagePath).writeAsBytes(base64Decode(_pngBase64));

    library = _FakeSidebarImageRepository();
    container = ProviderContainer(
      overrides: [
        sidebarImageRepositoryProvider.overrideWithValue(library),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(() => directory.delete(recursive: true));

    // Nothing in this tree watches the selection and it is autoDispose.
    container.listen(editorSelectionProvider, (previous, next) {});
  });

  /// Places one object and selects it, so its handles are on screen.
  String place({String? sourceImageId}) {
    final placed = container.read(placedImagesProvider.notifier).addImage(
          sourceImageId: sourceImageId,
          imagePath: imagePath,
          pageIndex: 0,
          position: const Offset(100, 100),
          size: const Size(120, 60),
        );
    container.read(editorSelectionProvider.notifier).select(placed.id);
    return placed.id;
  }

  /// A handle on the tree's own ref, for the helpers that take one.
  late WidgetRef ref;

  Future<void> pumpOverlay(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 600,
              height: 600,
              child: Consumer(
                builder: (context, widgetRef, _) {
                  ref = widgetRef;
                  return const PlacedImageOverlay(pageIndex: 0, scale: 1);
                },
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  Finder bottomRightHandle() =>
      find.byKey(PlacedImageOverlay.handleKey('bottomRight'));

  /// Drags the object's bottom-right corner by [delta].
  Future<void> dragCorner(WidgetTester tester, Offset delta) async {
    await tester.drag(bottomRightHandle(), delta);
    await tester.pump();
  }

  group('resizing an object from the library', () {
    testWidgets('should record the new size against its library image',
        (tester) async {
      place(sourceImageId: 'row-1');
      await pumpOverlay(tester);

      await dragCorner(tester, const Offset(60, 30));

      final resized = container.read(placedImagesProvider).single.size;
      expect(resized.width, greaterThan(120), reason: 'the drag resized it');
      expect(library.lastUsedSizes['row-1'], resized);
    });

    testWidgets('should record once the gesture is over, not during it',
        (tester) async {
      // The drag reports every frame; writing on each one would be a write
      // per frame for the whole gesture.
      place(sourceImageId: 'row-1');
      await pumpOverlay(tester);

      final gesture =
          await tester.startGesture(tester.getCenter(bottomRightHandle()));
      await tester.pump();

      for (var i = 0; i < 5; i++) {
        await gesture.moveBy(const Offset(10, 5));
        await tester.pump();
      }
      expect(library.writes, 0, reason: 'nothing written while dragging');

      await gesture.up();
      await tester.pump();

      expect(library.writes, 1);
    });

    testWidgets('should record a drag the pointer was taken away from',
        (tester) async {
      // A pointer can be lost mid-drag. Measured on this Flutter version, a
      // PointerCancelEvent produces `onPanEnd` rather than `onPanCancel`, so
      // the same path records it — which is why there is no cancel handler.
      place(sourceImageId: 'row-1');
      await pumpOverlay(tester);

      final gesture =
          await tester.startGesture(tester.getCenter(bottomRightHandle()));
      await tester.pump();
      await gesture.moveBy(const Offset(60, 30));
      await tester.pump();

      await gesture.cancel();
      await tester.pump();

      final size = container.read(placedImagesProvider).single.size;
      expect(size.width, greaterThan(120), reason: 'the drag resized it');
      expect(library.lastUsedSizes['row-1'], size);
    });
  });

  group('the undo history', () {
    testWidgets('should take one step for a whole resize, not one per frame',
        (tester) async {
      place(sourceImageId: 'row-1');
      await pumpOverlay(tester);

      final gesture =
          await tester.startGesture(tester.getCenter(bottomRightHandle()));
      await tester.pump();
      for (var i = 0; i < 5; i++) {
        await gesture.moveBy(const Offset(10, 5));
        await tester.pump();
      }
      await gesture.up();
      await tester.pump();

      expect(container.read(editorHistoryProvider.notifier).undoDepth, 1);
    });

    testWidgets('should take no step for a resize that went nowhere',
        (tester) async {
      // Grabbing a handle and letting go without moving changes nothing, and
      // a step for it would make the next undo appear to do nothing.
      place(sourceImageId: 'row-1');
      await pumpOverlay(tester);

      final gesture =
          await tester.startGesture(tester.getCenter(bottomRightHandle()));
      await tester.pump();
      await gesture.up();
      await tester.pump();

      expect(container.read(editorHistoryProvider.notifier).undoDepth, 0);
    });

    testWidgets('should put the object back the size it was', (tester) async {
      final id = place(sourceImageId: 'row-1');
      await pumpOverlay(tester);
      final before = container.read(placedImagesProvider).single.size;

      await dragCorner(tester, const Offset(60, 30));
      expect(container.read(placedImagesProvider).single.size, isNot(before));

      undoEdit(ref);

      expect(container.read(placedImagesProvider).single.size, before);
      expect(container.read(placedImagesProvider).single.id, id);
    });
  });

  group('resizing an object with no library image', () {
    testWidgets('should record nothing', (tester) async {
      // An image pasted from another application is stored with the document
      // and has no library row to remember against.
      place();
      await pumpOverlay(tester);

      await dragCorner(tester, const Offset(60, 30));

      expect(container.read(placedImagesProvider).single.size.width,
          greaterThan(120));
      expect(library.lastUsedSizes, isEmpty);
      expect(library.writes, 0);
    });
  });
}

class _FakeSidebarImageRepository implements SidebarImageRepository {
  final Map<String, Size> lastUsedSizes = {};
  int writes = 0;

  @override
  Future<Either<Failure, Unit>> updateLastUsedSize(String id, Size size) async {
    writes++;
    lastUsedSizes[id] = size;
    return const Right(unit);
  }

  @override
  Stream<List<SidebarImage>> watchImages() => const Stream.empty();

  @override
  Future<Either<Failure, List<SidebarImage>>> getImages() async =>
      const Right([]);

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
  Future<Either<Failure, List<SidebarImage>>> cleanupInvalidImages() =>
      throw UnimplementedError();

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
