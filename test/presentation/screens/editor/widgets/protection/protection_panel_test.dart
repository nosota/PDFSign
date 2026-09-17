import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/protection/password_pair_field.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/protection/protection_panel.dart';

void main() {
  DocumentProtection? answer;
  var closed = false;

  /// Opens the panel over a bare screen and waits for it to settle.
  ///
  /// [answer] and [closed] then say what it was closed with, which is the only
  /// thing the caller of this panel ever sees.
  Future<void> openPanel(
    WidgetTester tester, {
    DocumentProtection? current,
  }) async {
    answer = null;
    closed = false;
    await tester.binding.setSurfaceSize(const Size(700, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async {
              answer = await ProtectionPanel.show(context, current: current);
              closed = true;
            },
            child: const Text('open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  Future<void> tapKey(WidgetTester tester, Key key) async {
    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
  }

  Finder passwordField(String pair, {required bool verify}) =>
      find.byKey(PasswordPairField.keyFor(pair, verify: verify));

  Finder permission(DocumentPermission p) =>
      find.byKey(ProtectionPanel.permissionKey(p));

  bool isTicked(WidgetTester tester, DocumentPermission p) =>
      tester.widget<CheckboxListTile>(permission(p)).value ?? false;

  bool isAvailable(WidgetTester tester, DocumentPermission p) =>
      tester.widget<CheckboxListTile>(permission(p)).onChanged != null;

  AppLocalizations l10nOf(WidgetTester tester) =>
      AppLocalizations.of(tester.element(find.byType(ProtectionPanel)))!;

  group('a document with no protection', () {
    testWidgets('should open with everything permitted and no password',
        (tester) async {
      await openPanel(tester);

      for (final p in DocumentPermission.values) {
        expect(isTicked(tester, p), isTrue, reason: '${p.name} was withheld');
      }
      expect(
        tester.widget<TextField>(passwordField('open', verify: false)).enabled,
        isFalse,
        reason: 'no password is being asked for, so the field is not in use',
      );
    });
  });

  group('changing the document', () {
    testWidgets('should hold annotations and form filling on with it',
        (tester) async {
      // The broad right carries the narrow ones whatever their own bits say;
      // the panel must not offer to withhold what the file will grant.
      await openPanel(tester);
      // Everything starts granted, so the narrow ones are already held on by
      // the broad one. Letting go of it is what frees them.
      await tapKey(tester,
          ProtectionPanel.permissionKey(DocumentPermission.changingContent));
      expect(isAvailable(tester, DocumentPermission.annotations), isTrue);
      await tapKey(tester,
          ProtectionPanel.permissionKey(DocumentPermission.annotations));
      expect(isTicked(tester, DocumentPermission.annotations), isFalse);

      await tapKey(tester,
          ProtectionPanel.permissionKey(DocumentPermission.changingContent));

      expect(isTicked(tester, DocumentPermission.annotations), isTrue);
      expect(isAvailable(tester, DocumentPermission.annotations), isFalse);
      expect(isAvailable(tester, DocumentPermission.formFilling), isFalse);
    });

    testWidgets('should warn when it is withheld', (tester) async {
      // Withholding it shuts this app out of the document it is protecting.
      await openPanel(tester);

      await tapKey(tester,
          ProtectionPanel.permissionKey(DocumentPermission.changingContent));

      expect(find.text(l10nOf(tester).signingNeedsChangingContent),
          findsOneWidget);
    });
  });

  group('what the panel refuses', () {
    testWidgets('should refuse an empty password it was asked to require',
        (tester) async {
      await openPanel(tester);
      await tester.tap(find.text(l10nOf(tester).requirePasswordToOpen));
      await tester.pumpAndSettle();

      await tapKey(tester, ProtectionPanel.applyKey);

      expect(find.text(l10nOf(tester).passwordCannotBeEmpty), findsOneWidget);
      expect(find.byType(ProtectionPanel), findsOneWidget,
          reason: 'the panel closed on an answer it should have refused');
    });

    testWidgets('should refuse two passwords that differ', (tester) async {
      await openPanel(tester);
      await tester.tap(find.text(l10nOf(tester).requirePasswordToOpen));
      await tester.pumpAndSettle();
      await tester.enterText(passwordField('open', verify: false), 'one');
      await tester.enterText(passwordField('open', verify: true), 'other');

      await tapKey(tester, ProtectionPanel.applyKey);

      expect(find.text(l10nOf(tester).passwordsDoNotMatch), findsOneWidget);
      expect(find.byType(ProtectionPanel), findsOneWidget);
    });

    testWidgets('should say why where the reader is looking', (tester) async {
      // The panel is taller than a small window, and a complaint inside the
      // scrolling part sits below the fold: the reader presses Apply, nothing
      // appears to happen, and the reason is out of sight.
      await tester.binding.setSurfaceSize(const Size(700, 560));
      await openPanel(tester);
      await tapKey(
          tester, ProtectionPanel.permissionKey(DocumentPermission.printing));

      await tapKey(tester, ProtectionPanel.applyKey);

      final complaint = find.text(l10nOf(tester).restrictionsNeedOwnerPassword);
      expect(complaint, findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(SingleChildScrollView),
          matching: complaint,
        ),
        findsNothing,
        reason: 'inside the scroll area the complaint can be out of sight',
      );
      expect(
        tester.getRect(complaint).bottom <= tester.getRect(find.byType(ProtectionPanel)).bottom,
        isTrue,
        reason: 'the complaint has to be within the panel, not below it',
      );
    });

    testWidgets('should put the reader in the field that would settle it',
        (tester) async {
      // Saying what is wrong is half of it; the field to fix it in is below
      // the fold on a small window, and focusing scrolls it into view.
      await tester.binding.setSurfaceSize(const Size(700, 560));
      await openPanel(tester);
      await tapKey(
          tester, ProtectionPanel.permissionKey(DocumentPermission.printing));

      await tapKey(tester, ProtectionPanel.applyKey);

      final owner = tester.widget<TextField>(
        passwordField('owner', verify: false),
      );
      expect(owner.focusNode?.hasFocus, isTrue);
    });

    testWidgets('should refuse restrictions with no owner password',
        (tester) async {
      // Restrictions nobody holds the password to are restrictions anyone can
      // lift, which is worse than none: they look like protection.
      await openPanel(tester);
      await tapKey(
          tester, ProtectionPanel.permissionKey(DocumentPermission.printing));

      await tapKey(tester, ProtectionPanel.applyKey);

      expect(find.text(l10nOf(tester).restrictionsNeedOwnerPassword),
          findsOneWidget);
      expect(find.byType(ProtectionPanel), findsOneWidget);
    });
  });

  group('what the panel answers', () {
    testWidgets('should close on the passwords and permissions given',
        (tester) async {
      await openPanel(tester);
      final l10n = l10nOf(tester);

      await tester.tap(find.text(l10n.requirePasswordToOpen));
      await tester.pumpAndSettle();
      await tester.enterText(passwordField('open', verify: false), 'open-me');
      await tester.enterText(passwordField('open', verify: true), 'open-me');
      await tester.enterText(passwordField('owner', verify: false), 'own-me');
      await tester.enterText(passwordField('owner', verify: true), 'own-me');
      await tapKey(tester, ProtectionPanel.applyKey);

      expect(answer, isNotNull);
      expect(answer!.userPassword, 'open-me');
      expect(answer!.ownerPassword, 'own-me');
      expect(answer!.permissions, DocumentPermission.values.toSet());
    });

    testWidgets('should answer nothing when it is cancelled', (tester) async {
      await openPanel(tester);

      await tester.tap(find.text(l10nOf(tester).cancel));
      await tester.pumpAndSettle();

      expect(closed, isTrue);
      expect(answer, isNull, reason: 'cancelling must change nothing');
    });

    testWidgets('should answer a wholly open document when asked to remove',
        (tester) async {
      await openPanel(
        tester,
        current: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      await tapKey(tester, ProtectionPanel.removeKey);

      expect(answer, isNotNull);
      expect(answer!.requiresPasswordToOpen, isFalse);
      expect(answer!.ownerPassword, isEmpty);
      expect(answer!.permissions, DocumentPermission.values.toSet());
    });

    testWidgets('should start from the protection the document has',
        (tester) async {
      await openPanel(
        tester,
        current: DocumentProtection(
          userPassword: 'open-me',
          ownerPassword: 'own-me',
          permissions: const {DocumentPermission.printing},
        ),
      );

      expect(isTicked(tester, DocumentPermission.printing), isTrue);
      expect(isTicked(tester, DocumentPermission.copying), isFalse);
      expect(
        tester.widget<TextField>(passwordField('open', verify: false)).enabled,
        isTrue,
        reason: 'the document does ask for a password, so the field is in use',
      );
    });
  });
}
