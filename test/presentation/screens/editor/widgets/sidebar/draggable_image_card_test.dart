import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/sidebar_image.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/draggable_image_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 1x1 transparent PNG, so the thumbnail has something to draw.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

void main() {
  late Directory directory;
  late String imagePath;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    directory = await Directory.systemTemp.createTemp('pdfsign-card-test');
    imagePath = '${directory.path}/stamp.png';
    await File(imagePath).writeAsBytes(base64Decode(_pngBase64));
    addTearDown(() => directory.delete(recursive: true));
  });

  SidebarImage imageNamed(String id) => SidebarImage(
        id: id,
        filePath: imagePath,
        fileName: '$id.png',
        addedAt: DateTime(2026),
        orderIndex: 0,
        width: 800,
        height: 300,
        fileSize: 1024,
      );

  /// The library beside a drop target, the way the editor arranges them.
  ///
  /// Returns what each of the two answers: the reorders the list reported and
  /// the images the page received.
  Future<({List<String> reorders, List<String> dropped})> pumpSidebar(
    WidgetTester tester,
  ) async {
    final reorders = <String>[];
    final dropped = <String>[];
    final images = [imageNamed('first'), imageNamed('second')];

    await tester.binding.setSurfaceSize(const Size(600, 500));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Row(
              children: [
                SizedBox(
                  width: 350,
                  height: 500,
                  child: DragTarget<DraggableSidebarImage>(
                    onAcceptWithDetails: (details) =>
                        dropped.add(details.data.sourceImageId),
                    builder: (context, _, __) =>
                        const ColoredBox(color: Color(0xFFEEEEEE)),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 500,
                  child: ReorderableListView.builder(
                    itemCount: images.length,
                    onReorder: (from, to) => reorders.add('$from->$to'),
                    itemBuilder: (context, index) => DraggableImageCard(
                      key: ValueKey(images[index].id),
                      image: images[index],
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
    return (reorders: reorders, dropped: dropped);
  }

  /// The grip of the first card.
  Finder grip() => find.byIcon(Icons.drag_indicator).first;

  /// Drags from [start] onto the page.
  Future<void> dragToPage(WidgetTester tester, Offset start) async {
    final gesture = await tester.startGesture(start);
    await tester.pump(const Duration(milliseconds: 40));
    await gesture.moveBy(const Offset(-60, 10));
    await tester.pump();
    await gesture.moveTo(const Offset(160, 220));
    await tester.pump();
    await gesture.up();
    await tester.pumpAndSettle();
  }

  group('dragging the image itself', () {
    testWidgets('should carry it to the page and leave the order alone',
        (tester) async {
      final result = await pumpSidebar(tester);

      await dragToPage(tester, tester.getCenter(find.byType(Image).first));

      expect(result.dropped, ['first']);
      expect(result.reorders, isEmpty);
    });
  });

  group('dragging the grip', () {
    testWidgets('should rearrange the library', (tester) async {
      // The grip is the one part of the card that reorders rather than
      // carrying the image out. It does so from the first movement: this is
      // the whole of what it is for, and asking for a hold as well made it
      // look broken.
      final result = await pumpSidebar(tester);

      final gesture = await tester.startGesture(tester.getCenter(grip()));
      await tester.pump(const Duration(milliseconds: 20));
      // Past the middle of the card below, and no further: a pointer taken
      // outside the list is a different gesture again.
      for (var i = 0; i < 6; i++) {
        await gesture.moveBy(const Offset(0, 30));
        await tester.pump(const Duration(milliseconds: 20));
      }
      await gesture.up();
      await tester.pumpAndSettle();

      expect(result.reorders, isNotEmpty);
      expect(result.dropped, isEmpty,
          reason: 'a rearrangement must not also land on the page');
    });
  });
}
