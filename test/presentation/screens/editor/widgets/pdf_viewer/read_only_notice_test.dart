import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/read_only_notice.dart';

void main() {
  Future<void> pump(WidgetTester tester, DocumentSecurity security) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: ReadOnlyNotice(security: security)),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('should offer the owner password to whoever lacks it',
      (tester) async {
    await pump(
      tester,
      const DocumentSecurity.protected(
        password: 'open-me',
        allowsEditing: false,
        hasOwnerRights: false,
      ),
    );

    expect(find.byKey(ReadOnlyNotice.unlockKey), findsOneWidget);
  });

  testWidgets('should not ask for a password it already has', (tester) async {
    // Opened with the owner password and still restricted is not a state that
    // reaches this notice, but if it ever did, asking again would be absurd.
    await pump(
      tester,
      const DocumentSecurity.protected(
        password: 'own-me',
        allowsEditing: false,
        hasOwnerRights: true,
      ),
    );

    expect(find.byKey(ReadOnlyNotice.unlockKey), findsNothing);
  });

  testWidgets('should say why the document cannot be changed', (tester) async {
    await pump(
      tester,
      const DocumentSecurity.protected(
        password: null,
        allowsEditing: false,
        hasOwnerRights: false,
      ),
    );

    final context = tester.element(find.byType(ReadOnlyNotice));
    expect(
      find.text(AppLocalizations.of(context)!.documentReadOnlyBody),
      findsOneWidget,
    );
  });
}
