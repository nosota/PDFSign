import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/pdf_page_layout.dart';

// A4 in PDF points.
const _a4Width = 595.0;
const _a4Height = 842.0;

// Layout constants the expectations below are derived from.
const _verticalPadding = 40.0;
const _horizontalPadding = 40.0;
const _pageGap = 24.0;

PdfDocumentInfo _document(List<Size> pageSizes) => PdfDocumentInfo(
      filePath: '/tmp/doc.pdf',
      fileName: 'doc.pdf',
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

PdfDocumentInfo _uniformDocument(int pages) =>
    _document(List.filled(pages, const Size(_a4Width, _a4Height)));

void main() {
  group('column metrics', () {
    test('should not scroll horizontally when the page fits the viewport', () {
      final layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 800,
      );

      expect(layout.contentWidth, _a4Width);
      expect(layout.needsHorizontalScroll, isFalse);
      expect(layout.horizontalPadding, 0);
      expect(layout.effectiveWidth, 800);
      expect(layout.columnWidth, 800);
    });

    test('should add side padding when the page is wider than the viewport',
        () {
      final layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 400,
      );

      expect(layout.needsHorizontalScroll, isTrue);
      expect(layout.horizontalPadding, _horizontalPadding);
      expect(layout.effectiveWidth, _a4Width + _horizontalPadding * 2);
      expect(layout.columnWidth, _a4Width);
    });

    test('should measure total height as pages plus gaps plus padding', () {
      final layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 800,
      );

      expect(
        layout.totalHeight,
        _verticalPadding * 2 + _a4Height * 3 + _pageGap * 2,
      );
    });

    test('should scale the column with the render scale', () {
      final layout = PdfPageLayout(
        document: _uniformDocument(2),
        scale: 2,
        viewportWidth: 2000,
      );

      expect(layout.contentWidth, _a4Width * 2);
      expect(
        layout.totalHeight,
        _verticalPadding * 2 + _a4Height * 2 * 2 + _pageGap,
      );
    });
  });

  group('page rectangles', () {
    test('should centre pages in the viewport when not scrolling sideways', () {
      final layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 800,
      );

      expect(layout.pageRect(0).left, (800 - _a4Width) / 2);
      expect(layout.pageRect(0).top, _verticalPadding);
      expect(layout.pageRect(1).top, _verticalPadding + _a4Height + _pageGap);
      expect(
        layout.pageRect(2).top,
        _verticalPadding + (_a4Height + _pageGap) * 2,
      );
    });

    test('should centre a narrow page within the column, not against the '
        'padding, while scrolling sideways', () {
      // The widest page defines the column; a narrower page must still be
      // centred inside it. Anchoring it to the padding was the old defect.
      final layout = PdfPageLayout(
        document: _document(const [
          Size(_a4Width, _a4Height),
          Size(300, _a4Height),
        ]),
        scale: 1,
        viewportWidth: 200,
      );

      expect(layout.needsHorizontalScroll, isTrue);
      expect(layout.pageRect(0).left, _horizontalPadding);
      expect(
        layout.pageRect(1).left,
        _horizontalPadding + (_a4Width - 300) / 2,
      );
    });

    test('should centre a narrow page in the viewport when it fits', () {
      final layout = PdfPageLayout(
        document: _document(const [
          Size(_a4Width, _a4Height),
          Size(300, _a4Height),
        ]),
        scale: 1,
        viewportWidth: 800,
      );

      expect(layout.pageRect(0).left, (800 - _a4Width) / 2);
      expect(layout.pageRect(1).left, (800 - 300) / 2);
    });
  });

  group('pageIndexAt', () {
    late PdfPageLayout layout;

    setUp(() {
      layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 800,
      );
    });

    test('should find the page when the point is inside it', () {
      expect(layout.pageIndexAt(const Offset(300, 100)), 0);
      expect(layout.pageIndexAt(const Offset(300, 1000)), 1);
    });

    test('should return null in the gap between pages', () {
      // Page 1 ends at 882, page 2 starts at 906.
      expect(layout.pageIndexAt(const Offset(300, 890)), isNull);
    });

    test('should return null in the side margin', () {
      expect(layout.pageIndexAt(const Offset(50, 100)), isNull);
    });

    test('should return null above the first and below the last page', () {
      expect(layout.pageIndexAt(const Offset(300, 10)), isNull);
      expect(layout.pageIndexAt(Offset(300, layout.totalHeight - 10)), isNull);
    });
  });

  group('nearestPageIndex', () {
    late PdfPageLayout layout;

    setUp(() {
      layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 800,
      );
    });

    test('should pick the page the point already sits on', () {
      expect(layout.nearestPageIndex(const Offset(300, 100)), 0);
    });

    test('should pick the page across the side margin', () {
      expect(layout.nearestPageIndex(const Offset(0, 100)), 0);
    });

    test('should pick the closer side of a gap', () {
      // Gap spans 882..906; 890 is nearer the page above, 900 the one below.
      expect(layout.nearestPageIndex(const Offset(300, 890)), 0);
      expect(layout.nearestPageIndex(const Offset(300, 900)), 1);
    });

    test('should pick the last page below the end of the document', () {
      expect(
        layout.nearestPageIndex(Offset(300, layout.totalHeight + 500)),
        2,
      );
    });

    test('should pick the first page above the start of the document', () {
      expect(layout.nearestPageIndex(const Offset(300, -500)), 0);
    });

    test('should look past several pages when a distant one is truly closer',
        () {
      // Three narrow pages then a wide one. A point far to the left is level
      // with the first page but much closer to the wide page three slots down,
      // so a search that only checked neighbours would answer wrongly.
      final mixed = PdfPageLayout(
        document: _document(const [
          Size(100, 20),
          Size(100, 20),
          Size(100, 20),
          Size(_a4Width, 20),
        ]),
        scale: 1,
        viewportWidth: 800,
      );

      const point = Offset(0, 50);
      expect(mixed.pageIndexAt(point), isNull);

      // Confirm the premise before asserting the answer.
      final toFirst = (mixed.pageRect(0).left - point.dx).abs();
      final toWide = mixed.pageRect(3).topLeft - point;
      expect(toFirst * toFirst, greaterThan(toWide.distanceSquared));

      expect(mixed.nearestPageIndex(point), 3);
    });
  });

  group('visiblePageNumbers', () {
    test('should include the first page when it is on screen', () {
      // Regression: the previous implementation dropped the first page from
      // the range whenever a second page was also visible.
      final layout = PdfPageLayout(
        document: _uniformDocument(5),
        scale: 1,
        viewportWidth: 800,
      );

      expect(
        layout.visiblePageNumbers(scrollOffset: 0, viewportHeight: 1000),
        (first: 1, last: 2),
      );
    });

    test('should report a single page when only one is on screen', () {
      final layout = PdfPageLayout(
        document: _uniformDocument(5),
        scale: 1,
        viewportWidth: 800,
      );

      expect(
        layout.visiblePageNumbers(scrollOffset: 0, viewportHeight: 500),
        (first: 1, last: 1),
      );
    });

    test('should report the pages around a mid-document scroll offset', () {
      final layout = PdfPageLayout(
        document: _uniformDocument(5),
        scale: 1,
        viewportWidth: 800,
      );

      // Page 2 spans 906..1748, page 3 starts at 1772.
      expect(
        layout.visiblePageNumbers(scrollOffset: 1000, viewportHeight: 800),
        (first: 2, last: 3),
      );
    });

    test('should skip a page that ends above the viewport', () {
      final layout = PdfPageLayout(
        document: _uniformDocument(5),
        scale: 1,
        viewportWidth: 800,
      );

      // 890 lies in the gap after page 1, so page 1 is no longer visible.
      final range =
          layout.visiblePageNumbers(scrollOffset: 890, viewportHeight: 400);
      expect(range, (first: 2, last: 2));
    });
  });

  group('pageNumberAtCenter', () {
    late PdfPageLayout layout;

    setUp(() {
      layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 800,
      );
    });

    test('should return the page under the centre point', () {
      expect(layout.pageNumberAtCenter(100), 1);
      expect(layout.pageNumberAtCenter(1000), 2);
    });

    test('should keep the page through the first half of the gap', () {
      // Page 1 ends at 882; the gap's midpoint is 894.
      expect(layout.pageNumberAtCenter(890), 1);
      expect(layout.pageNumberAtCenter(900), 2);
    });

    test('should clamp to the last page past the end of the document', () {
      expect(layout.pageNumberAtCenter(layout.totalHeight + 1000), 3);
    });

    test('should clamp to the first page above the document', () {
      expect(layout.pageNumberAtCenter(-100), 1);
    });
  });

  group('scrollOffsetForPage', () {
    late PdfPageLayout layout;

    setUp(() {
      layout = PdfPageLayout(
        document: _uniformDocument(3),
        scale: 1,
        viewportWidth: 800,
      );
    });

    test('should centre a page shorter than the viewport', () {
      final offset = layout.scrollOffsetForPage(2, viewportHeight: 1000);
      expect(offset, layout.pageRect(1).top - (1000 - _a4Height) / 2);
    });

    test('should align a page taller than the viewport to its top', () {
      final offset = layout.scrollOffsetForPage(2, viewportHeight: 500);
      expect(offset, layout.pageRect(1).top);
    });

    test('should clamp an out-of-range page number', () {
      expect(
        layout.scrollOffsetForPage(99, viewportHeight: 500),
        layout.pageRect(2).top,
      );
      expect(
        layout.scrollOffsetForPage(0, viewportHeight: 500),
        layout.pageRect(0).top,
      );
    });
  });

  group('document with no pages', () {
    late PdfPageLayout layout;

    setUp(() {
      layout = PdfPageLayout(
        document: _document(const []),
        scale: 1,
        viewportWidth: 800,
      );
    });

    test('should report an empty column of padding only', () {
      expect(layout.pageCount, 0);
      expect(layout.contentWidth, 0);
      expect(layout.totalHeight, _verticalPadding * 2);
    });

    test('should resolve every lookup to nothing rather than throwing', () {
      expect(layout.pageIndexAt(Offset.zero), isNull);
      expect(layout.nearestPageIndex(Offset.zero), isNull);
      expect(
        layout.visiblePageNumbers(scrollOffset: 0, viewportHeight: 100),
        isNull,
      );
      expect(layout.pageNumberAtCenter(0), 1);
      expect(layout.scrollOffsetForPage(1, viewportHeight: 100), 0);
    });
  });
}
