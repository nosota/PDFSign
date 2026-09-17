import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The keys of a translation file, leaving the `@`-metadata out.
Set<String> keysOf(File file) {
  final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return decoded.keys.where((key) => !key.startsWith('@')).toSet();
}

void main() {
  final directory = Directory('lib/l10n');
  final expected = keysOf(File('${directory.path}/app_en.arb'));

  final translations = directory
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.arb'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  test('should have something to compare against', () {
    expect(expected.length, greaterThan(100));
    expect(translations.length, greaterThan(60));
  });

  group('every language says everything', () {
    for (final file in translations) {
      final name = file.uri.pathSegments.last;
      test('should be complete in $name', () {
        // A key missing from one language shows that reader an English
        // sentence in the middle of their own — which is how fifteen strings
        // went unnoticed in every language until 2026-09-17.
        final missing = expected.difference(keysOf(file)).toList()..sort();
        expect(missing, isEmpty, reason: '$name is missing $missing');
      });
    }
  });

  test('should have a translation for every locale that can be chosen', () {
    // An entry in one list without a file in the other is what left Japanese,
    // Korean and Chinese unreachable for months (REQUIREMENTS §13.5).
    final source =
        File('lib/presentation/providers/locale_preference_provider.dart')
            .readAsStringSync();
    final codes = RegExp(r"SupportedLocale\(code: '([^']+)'")
        .allMatches(source)
        .map((match) => match.group(1)!)
        .toList();
    expect(codes, isNotEmpty);

    final files = translations.map((file) => file.uri.pathSegments.last).toSet();
    for (final code in codes) {
      expect(files, contains('app_$code.arb'),
          reason: '$code can be chosen but has no translation');
    }
  });

  test('should not carry keys English does not have', () {
    // A stale key is dead weight, and usually a rename that was half done.
    for (final file in translations) {
      final extra = keysOf(file).difference(expected).toList()..sort();
      expect(extra, isEmpty,
          reason: '${file.uri.pathSegments.last} carries $extra');
    }
  });
}
