import 'dart:convert';
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
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/rotate_page.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/page_jump_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_list.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 1x1 transparent PNG, standing in for a rendered page.
const _pngBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAE'
    'hQGAhKmMIQAAAABJRU5ErkJggg==';

const _a4 = Size(595, 842);
const _pageCount = 8;

void main() {
  late ProviderContainer container;
  late WidgetRef widgetRef;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        pdfDocumentRepositoryProvider.overrideWithValue(
          _FakePdfDocumentRepository(base64Decode(_pngBase64)),
        ),
      ],
    );
    addTearDown(container.dispose);
  });

  /// Pumps past the viewer's animations.
  ///
  /// Not `pumpAndSettle`: the viewer runs an auto-hiding page indicator, so
  /// there is always another frame coming and settling never happens. The
  /// span covers a Go to Page scroll, which animates over 300 ms.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 16; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  /// Mounts the real viewer at a viewport small enough that a long document
  /// has to scroll.
  Future<void> pumpViewer(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Consumer(
              builder: (context, ref, _) {
                widgetRef = ref;
                return const SizedBox(
                  width: 700,
                  height: 500,
                  child: PdfViewer(),
                );
              },
            ),
          ),
        ),
      ),
    );
    await container.read(pdfDocumentProvider.notifier).openDocument('/doc.pdf');
    await settle(tester);
  }

  PdfPageListState listState(WidgetTester tester) =>
      tester.state<PdfPageListState>(find.byType(PdfPageList));

  int currentPage() => container
      .read(pdfDocumentProvider)
      .maybeMap(loaded: (state) => state.currentPage, orElse: () => 0);

  group('going to a page', () {
    // The dialog is opened from the menu at the window root, which cannot
    // reach the page column; it leaves the answer in a provider instead.
    testWidgets('should scroll to the page that was asked for', (tester) async {
      await pumpViewer(tester);
      expect(currentPage(), 1);

      container.read(pageJumpRequestProvider.notifier).request(7);
      await settle(tester);

      expect(currentPage(), 7);
    });

    testWidgets('should stay put for a page that does not exist',
        (tester) async {
      await pumpViewer(tester);

      container.read(pageJumpRequestProvider.notifier).request(99);
      await settle(tester);

      // Clamped to the last page rather than scrolled into nothing.
      expect(currentPage(), lessThanOrEqualTo(_pageCount));
      expect(currentPage(), greaterThan(0));
    });
  });

  group('after turning a page', () {
    testWidgets('should stay on that page rather than jump to the first',
        (tester) async {
      // What a reader hit: turning a page changes the height of everything
      // below it, the scroll offset no longer means what it did, and a long
      // document landed back at the top.
      await pumpViewer(tester);

      listState(tester).scrollToPage(6, animate: false);
      await settle(tester);
      expect(currentPage(), 6, reason: 'arranged on page 6');

      rotateCurrentPage(widgetRef, 1);
      await settle(tester);

      expect(currentPage(), 6);
      expect(listState(tester).scrollOffsetXY.dy, greaterThan(0));
    });

    testWidgets('should still be on that page after turning it repeatedly',
        (tester) async {
      await pumpViewer(tester);
      listState(tester).scrollToPage(5, animate: false);
      await settle(tester);

      for (var i = 0; i < 4; i++) {
        rotateCurrentPage(widgetRef, 1);
        await settle(tester);
      }

      expect(currentPage(), 5);
    });

    testWidgets('should show the first page from its top', (tester) async {
      // A turned page is re-anchored to its own top, which for the first page
      // means the margin above it rather than the very start of the column.
      // The page it just changed the shape of is what the reader is looking
      // at either way.
      await pumpViewer(tester);

      rotateCurrentPage(widgetRef, 1);
      await settle(tester);

      expect(currentPage(), 1);
      expect(listState(tester).scrollOffsetXY.dy, lessThan(100));
    });
  });
}

/// A long document of identical A4 pages; every page renders as a 1x1 PNG.
class _FakePdfDocumentRepository implements PdfDocumentRepository {
  _FakePdfDocumentRepository(this._pageBytes);

  final Uint8List _pageBytes;

  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath) async =>
      Right(
        PdfDocumentInfo(
          filePath: filePath,
          fileName: 'doc.pdf',
          pageCount: _pageCount,
          pages: [
            for (var i = 1; i <= _pageCount; i++)
              PdfPageInfo(pageNumber: i, width: _a4.width, height: _a4.height),
          ],
        ),
      );

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
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  ) =>
      throw UnimplementedError();
}
