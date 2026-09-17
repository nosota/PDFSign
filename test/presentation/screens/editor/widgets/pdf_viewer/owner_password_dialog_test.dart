import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/owner_password_dialog.dart';

void main() {
  Future<void> pump(
    WidgetTester tester, {
    String? title,
    String? confirmLabel,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: OwnerPasswordDialog(
            onSubmit: (_) async => true,
            title: title,
            confirmLabel: confirmLabel,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  AppLocalizations l10nOf(WidgetTester tester) =>
      AppLocalizations.of(tester.element(find.byType(OwnerPasswordDialog)))!;

  testWidgets('should say the document refuses changes when that is the reason',
      (tester) async {
    await pump(tester);

    final l10n = l10nOf(tester);
    expect(find.text(l10n.documentReadOnlyTitle), findsOneWidget);
    expect(find.text(l10n.openDocumentButton), findsOneWidget);
  });

  testWidgets('should say the protection is the owners when that is the reason',
      (tester) async {
    // A document may permit every change and still keep its protection to
    // itself. Telling such a reader that it "does not allow changes" is a
    // plain untruth — they have been editing it.
    final messages = await AppLocalizations.delegate.load(const Locale('en'));
    await pump(
      tester,
      title: messages.protectionIsTheOwnersTitle,
      confirmLabel: messages.continueButton,
    );

    expect(find.text(messages.protectionIsTheOwnersTitle), findsOneWidget);
    expect(find.text(messages.continueButton), findsOneWidget);
    expect(find.text(messages.documentReadOnlyTitle), findsNothing);
  });
}
