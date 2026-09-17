import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/utils/focus_utils.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/screens/editor/widgets/pdf_viewer/document_password_prompt.dart';

const _fieldKey = Key('document-password-field');

void main() {
  /// Mounts the prompt where the viewer puts it: inside the viewer's own
  /// focused `Focus`, which claims the arrow keys for page navigation.
  ///
  /// The guard in that handler is reproduced here rather than mocked, because
  /// the interaction between the two is the thing under test: without it the
  /// caret cannot be moved inside the field. This mirrors the viewer's handler
  /// rather than running it — mounting the viewer takes the whole provider
  /// stack — so it holds the arrangement to its contract without standing in
  /// for a test of `PdfViewer` itself.
  Future<List<LogicalKeyboardKey>> pump(
    WidgetTester tester, {
    required ValueChanged<String> onSubmit,
    bool wasWrong = false,
  }) async {
    final claimed = <LogicalKeyboardKey>[];

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Focus(
            autofocus: true,
            onKeyEvent: (node, event) {
              if (event is! KeyDownEvent) return KeyEventResult.ignored;
              if (textInputHasFocus()) return KeyEventResult.ignored;
              claimed.add(event.logicalKey);
              return KeyEventResult.handled;
            },
            child: DocumentPasswordPrompt(
              onSubmit: onSubmit,
              wasWrong: wasWrong,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return claimed;
  }

  testWidgets('should take the keyboard without being clicked first',
      (tester) async {
    // The viewer this prompt replaces holds the focus of the scope, so the
    // field's own autofocus is dropped and the reader would have to click it.
    await pump(tester, onSubmit: (_) {});

    final field = tester.widget<TextField>(find.byKey(_fieldKey));
    expect(field.focusNode!.hasFocus, isTrue);
  });

  testWidgets('should let the caret be moved inside the field',
      (tester) async {
    final claimed = await pump(tester, onSubmit: (_) {});
    await tester.enterText(find.byKey(_fieldKey), 'abcdefgh');
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(find.byKey(_fieldKey));
    expect(field.controller!.selection.baseOffset, 7,
        reason: 'the arrow key was taken by the page navigation around it');
    expect(claimed, isEmpty);
  });

  testWidgets('should hand over what was typed', (tester) async {
    String? submitted;
    await pump(tester, onSubmit: (password) => submitted = password);

    await tester.enterText(find.byKey(_fieldKey), 'secret123');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(submitted, 'secret123');
  });

  testWidgets('should do nothing with an empty password', (tester) async {
    var calls = 0;
    await pump(tester, onSubmit: (_) => calls++);

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(calls, 0);
  });

  testWidgets('should say when the last password was turned down',
      (tester) async {
    await pump(tester, onSubmit: (_) {}, wasWrong: true);

    final context = tester.element(find.byType(DocumentPasswordPrompt));
    expect(
      find.text(AppLocalizations.of(context)!.incorrectPassword),
      findsOneWidget,
    );
  });

  testWidgets('should stop saying so once the reader edits', (tester) async {
    await pump(tester, onSubmit: (_) {}, wasWrong: true);
    final context = tester.element(find.byType(DocumentPasswordPrompt));
    final complaint = AppLocalizations.of(context)!.incorrectPassword;

    await tester.enterText(find.byKey(_fieldKey), 'a');
    await tester.pumpAndSettle();

    expect(find.text(complaint), findsNothing);
  });
}
