import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/presentation/providers/editor/document_dirty_provider.dart';
import 'package:pdfsign/presentation/providers/editor/document_protection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/editor_history.dart';
import 'package:pdfsign/presentation/providers/editor/editor_selection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/history_actions.dart';

DocumentProtection protectionWith({
  String user = 'open-me',
  Set<DocumentPermission> permissions = const {DocumentPermission.printing},
}) =>
    DocumentProtection(
      userPassword: user,
      ownerPassword: 'own-me',
      permissions: permissions,
    );

void main() {
  late ProviderContainer container;
  late WidgetRef ref;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
    container.listen(editorSelectionProvider, (previous, next) {});
  });

  Future<void> pumpHost(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: Consumer(
          builder: (context, widgetRef, _) {
            ref = widgetRef;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  DocumentProtection? pending() => container.read(pendingProtectionProvider);

  bool dirty() => container.read(documentDirtyProvider);

  group('asking for protection', () {
    test('should leave the document with something to save', () {
      expect(dirty(), isFalse);

      container.read(pendingProtectionProvider.notifier).set(protectionWith());

      expect(dirty(), isTrue);
    });

    test('should be clean again once it is written', () {
      final asked = protectionWith();
      container.read(pendingProtectionProvider.notifier).set(asked);

      container.read(savedProtectionProvider.notifier).markSaved(asked);

      expect(dirty(), isFalse);
    });

    test('should stay pending after a write, to be applied again', () {
      // The bytes a save starts from still carry the old protection, so the
      // next save has to put this one back. Clearing it here would write the
      // document out unprotected the second time.
      final asked = protectionWith();
      final notifier = container.read(pendingProtectionProvider.notifier)
        ..set(asked);
      container.read(savedProtectionProvider.notifier).markSaved(asked);

      expect(notifier.state, asked);
      expect(dirty(), isFalse);
    });

    test('should be dirty again when changed after a write', () {
      final asked = protectionWith();
      container.read(pendingProtectionProvider.notifier).set(asked);
      container.read(savedProtectionProvider.notifier).markSaved(asked);

      container
          .read(pendingProtectionProvider.notifier)
          .set(protectionWith(user: 'another'));

      expect(dirty(), isTrue);
    });

    test('should be clean when changed back to what was written', () {
      final asked = protectionWith();
      container.read(pendingProtectionProvider.notifier).set(asked);
      container.read(savedProtectionProvider.notifier).markSaved(asked);
      container
          .read(pendingProtectionProvider.notifier)
          .set(protectionWith(user: 'another'));

      container.read(pendingProtectionProvider.notifier).set(protectionWith());

      expect(dirty(), isFalse, reason: 'an equal protection is the same one');
    });
  });

  group('undoing a change of protection', () {
    testWidgets('should be a step of its own', (tester) async {
      await pumpHost(tester);

      recordHistoryStep(
        ref,
        () => container
            .read(pendingProtectionProvider.notifier)
            .set(protectionWith()),
      );

      expect(container.read(editorHistoryProvider).canUndo, isTrue);
    });

    testWidgets('should take the document back to having none', (tester) async {
      await pumpHost(tester);
      recordHistoryStep(
        ref,
        () => container
            .read(pendingProtectionProvider.notifier)
            .set(protectionWith()),
      );

      undoEdit(ref);

      expect(pending(), isNull);
      expect(dirty(), isFalse);
    });

    testWidgets('should take it back to the protection before it',
        (tester) async {
      await pumpHost(tester);
      final first = protectionWith();
      recordHistoryStep(
        ref,
        () => container.read(pendingProtectionProvider.notifier).set(first),
      );
      recordHistoryStep(
        ref,
        () => container
            .read(pendingProtectionProvider.notifier)
            .set(protectionWith(user: 'second')),
      );

      undoEdit(ref);

      expect(pending(), first);
    });

    testWidgets('should be put back by a redo', (tester) async {
      await pumpHost(tester);
      final asked = protectionWith();
      recordHistoryStep(
        ref,
        () => container.read(pendingProtectionProvider.notifier).set(asked),
      );
      undoEdit(ref);

      redoEdit(ref);

      expect(pending(), asked);
    });

    testWidgets('should record nothing when the protection did not change',
        (tester) async {
      await pumpHost(tester);
      container.read(pendingProtectionProvider.notifier).set(protectionWith());
      container.read(editorHistoryProvider.notifier).clear();

      recordHistoryStep(
        ref,
        () => container
            .read(pendingProtectionProvider.notifier)
            .set(protectionWith()),
      );

      expect(container.read(editorHistoryProvider).canUndo, isFalse);
    });
  });
}
