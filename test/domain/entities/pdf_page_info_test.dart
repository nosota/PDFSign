import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/pdf_page_info.dart';

void main() {
  const upright = PdfPageInfo(pageNumber: 1, width: 595, height: 842);

  group('a page as it comes out of the file', () {
    test('should be shown exactly as the file has it', () {
      expect(upright.pendingQuarterTurns, 0);
      expect(upright.isRotatedFromFile, isFalse);
    });

    test('should still be clean when the file itself carries a rotation', () {
      // A page the file marks as turned is not an unsaved change.
      const landscape = PdfPageInfo(
        pageNumber: 1,
        width: 842,
        height: 595,
        rotation: 90,
        fileRotation: 90,
      );
      expect(landscape.isRotatedFromFile, isFalse);
      expect(landscape.pendingQuarterTurns, 0);
    });
  });

  group('turning a page', () {
    test('should swap the sides for a quarter turn', () {
      final turned = upright.rotated(1);
      expect(turned.width, 842);
      expect(turned.height, 595);
      expect(turned.rotation, 90);
      expect(turned.fileRotation, 0, reason: 'the file has not changed');
      expect(turned.isRotatedFromFile, isTrue);
      expect(turned.pendingQuarterTurns, 1);
    });

    test('should keep the sides for a half turn', () {
      final turned = upright.rotated(2);
      expect(turned.width, 595);
      expect(turned.height, 842);
      expect(turned.rotation, 180);
      expect(turned.pendingQuarterTurns, 2);
    });

    test('should turn the other way for a negative quarter', () {
      final turned = upright.rotated(-1);
      expect(turned.rotation, 270);
      expect(turned.width, 842);
      expect(turned.pendingQuarterTurns, 3);
    });

    test('should come back to where it started after four turns', () {
      var page = upright;
      for (var i = 0; i < 4; i++) {
        page = page.rotated(1);
      }
      expect(page, upright);
      expect(page.isRotatedFromFile, isFalse);
    });

    test('should do nothing for no turns', () {
      expect(upright.rotated(0), same(upright));
      expect(upright.rotated(4), same(upright));
    });

    test('should add to a rotation the file already carries', () {
      const landscape = PdfPageInfo(
        pageNumber: 1,
        width: 842,
        height: 595,
        rotation: 90,
        fileRotation: 90,
      );
      final turned = landscape.rotated(1);

      expect(turned.rotation, 180);
      expect(turned.width, 595, reason: 'back to portrait');
      expect(turned.pendingQuarterTurns, 1, reason: 'one turn beyond the file');
    });

    test('should report no pending turn once it is back where the file has it',
        () {
      const landscape = PdfPageInfo(
        pageNumber: 1,
        width: 842,
        height: 595,
        rotation: 90,
        fileRotation: 90,
      );
      // Turned away and back again: nothing to save.
      expect(landscape.rotated(1).rotated(-1).isRotatedFromFile, isFalse);
    });
  });

  group('recording a save', () {
    test('should become clean when the file catches up', () {
      final turned = upright.rotated(1);
      final saved = turned.copyWith(fileRotation: turned.rotation);

      expect(saved.isRotatedFromFile, isFalse);
      expect(saved.pendingQuarterTurns, 0);
      expect(saved.width, 842, reason: 'still shown the way it was turned');
    });
  });
}
