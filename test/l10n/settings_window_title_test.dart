import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/main.dart';
import 'package:pdfsign/presentation/providers/locale_preference_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('the language a stored preference names', () {
    test('should be nothing for the system default', () {
      expect(localeFromPreference(null), isNull);
      expect(localeFromPreference('system'), isNull);
    });

    test('should be the locale of a language this app has', () {
      expect(localeFromPreference('de'), const Locale('de'));
      expect(localeFromPreference('zh_TW'), const Locale('zh', 'TW'));
    });

    test('should be nothing for a language it does not have', () {
      expect(localeFromPreference('xx'), isNull);
    });
  });

  group('what the settings window is called', () {
    test('should be in the language the reader chose', () async {
      // The window is titled before any widget exists to read a localization
      // from; left to itself it said "Settings" in every language.
      expect(await settingsWindowTitle('de'), 'Einstellungen');
      expect(await settingsWindowTitle('ja'), '設定');
      expect(await settingsWindowTitle('zh_CN'), '设置');
      expect(await settingsWindowTitle('zh_TW'), '設定');
      expect(await settingsWindowTitle('ru'), 'Настройки');
    });

    test('should fall back to something rather than fail', () async {
      expect(await settingsWindowTitle('xx'), isNotEmpty);
      expect(await settingsWindowTitle(null), isNotEmpty);
    });
  });
}
