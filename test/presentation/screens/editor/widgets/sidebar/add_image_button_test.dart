import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/constants/sidebar_constants.dart';
import 'package:pdfsign/core/theme/app_theme.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/sidebar/add_image_button.dart';

void main() {
  /// Puts the button in a sidebar of [width], speaking [locale].
  Future<AppLocalizations> pump(
    WidgetTester tester, {
    required Locale locale,
    double width = SidebarConstants.defaultWidth,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          // The app's own theme: its type is wider than the default, and the
          // label wraps at sidebar widths where the default would not.
          theme: createAppTheme(),
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(width: width, child: const AddImageButton()),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return AppLocalizations.delegate.load(locale);
  }

  /// Whether the label fits inside the button's own bounds.
  void expectLabelVisible(WidgetTester tester, String label) {
    final button = tester.getRect(find.byType(AddImageButton));
    final text = tester.getRect(find.text(label));
    expect(
      text.bottom <= button.bottom + 0.5 && text.top >= button.top - 0.5,
      isTrue,
      reason: 'the label runs from ${text.top} to ${text.bottom}, '
          'the button from ${button.top} to ${button.bottom}',
    );
  }

  testWidgets('should show the whole label in English', (tester) async {
    final l10n = await pump(tester, locale: const Locale('en'));
    expectLabelVisible(tester, l10n.addImage);
  });

  testWidgets('should show the whole label in a language that wraps it',
      (tester) async {
    // "Добавить изображение" does not fit a 200 pt sidebar on one line, and a
    // button of a fixed height cut the second line off.
    final l10n = await pump(tester, locale: const Locale('ru'));
    expectLabelVisible(tester, l10n.addImage);
  });

  testWidgets('should show the whole label in the narrowest sidebar',
      (tester) async {
    final l10n = await pump(
      tester,
      locale: const Locale('nl'),
      width: SidebarConstants.minWidth,
    );
    expectLabelVisible(tester, l10n.addImage);
  });

  testWidgets('should grow when the label takes more than one line',
      (tester) async {
    // Tests draw in a font of their own, so the width a label wraps at here
    // is not the width it wraps at on screen — what this holds is the shape
    // of the fix: when the label does wrap, the bar grows to show it rather
    // than cutting the second line off.
    final l10n = await pump(tester, locale: const Locale('ru'), width: 96);

    expect(
      tester.getSize(find.text(l10n.addImage)).height,
      greaterThan(20),
      reason: 'the label is expected to wrap at this width',
    );
    expect(
      tester.getSize(find.byType(AddImageButton)).height,
      greaterThan(SidebarConstants.addButtonHeight),
    );
    expectLabelVisible(tester, l10n.addImage);
  });
}
