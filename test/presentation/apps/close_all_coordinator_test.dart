import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/window/window_broadcast.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/apps/close_all_coordinator.dart';
import 'package:pdfsign/presentation/providers/editor/global_dirty_state_provider.dart';

void main() {
  late ProviderContainer container;
  late GlobalKey<NavigatorState> navigatorKey;

  /// desktop_multi_window has no platform side in a test, and its calls would
  /// otherwise never return, so the broadcasts answer as if no other window
  /// existed. Delivery is not what these tests are about — the waiting is.
  const multiWindow = MethodChannel('mixin.one/desktop_multi_window');

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
    navigatorKey = GlobalKey<NavigatorState>();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(multiWindow, (call) async {
      if (call.method == 'getAllSubWindowIds') return <int>[];
      return null;
    });
  });

  tearDown(() {
    WindowBroadcast.setOnSaveFailed(null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(multiWindow, null);
  });

  void markWindowDirty(String id, {bool dirty = true}) {
    container
        .read(globalDirtyStateProvider.notifier)
        .updateWindowState(id, dirty);
  }

  /// Mounts a host with a navigator and hands back the coordinator under test.
  Future<CloseAllCoordinator> pumpCoordinator(
    WidgetTester tester, {
    Duration saveTimeout = const Duration(seconds: 30),
  }) async {
    late CloseAllCoordinator coordinator;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Consumer(
            builder: (context, ref, _) {
              coordinator = CloseAllCoordinator(
                ref: ref,
                navigatorKey: navigatorKey,
                saveTimeout: saveTimeout,
              );
              return const Scaffold(body: SizedBox.shrink());
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return coordinator;
  }

  group('nothing to save', () {
    testWidgets('should go ahead without asking', (tester) async {
      final coordinator = await pumpCoordinator(tester);

      expect(await coordinator.confirm(), isTrue);
      await tester.pump();
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('should ignore windows that are already saved', (tester) async {
      markWindowDirty('w1', dirty: false);
      final coordinator = await pumpCoordinator(tester);

      expect(await coordinator.confirm(), isTrue);
    });
  });

  group('the user decides', () {
    testWidgets('should go ahead when changes are discarded', (tester) async {
      markWindowDirty('w1');
      final coordinator = await pumpCoordinator(tester);

      final decision = coordinator.confirm();
      await tester.pumpAndSettle();
      await tester.tap(find.text("Don't Save"));
      await tester.pumpAndSettle();

      expect(await decision, isTrue);
    });

    testWidgets('should stop when the user cancels', (tester) async {
      markWindowDirty('w1');
      final coordinator = await pumpCoordinator(tester);

      final decision = coordinator.confirm();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(await decision, isFalse);
    });
  });

  group('waiting for Save All', () {
    testWidgets('should continue as soon as the windows report saved',
        (tester) async {
      // The point of the change: this used to sleep for a fixed five seconds
      // whatever happened. With a 30 s backstop configured, finishing at all
      // proves the wait ends on the signal rather than on a timer.
      markWindowDirty('w1');
      markWindowDirty('w2');
      final coordinator = await pumpCoordinator(tester);

      final decision = coordinator.confirm();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save All'));
      await tester.pumpAndSettle();

      markWindowDirty('w1', dirty: false);
      await tester.pump();
      markWindowDirty('w2', dirty: false);
      await tester.pump();

      expect(await decision, isTrue);
    });

    testWidgets('should ask what to do when a window reports a failed save',
        (tester) async {
      markWindowDirty('w1');
      final coordinator = await pumpCoordinator(tester);

      final decision = coordinator.confirm();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save All'));
      await tester.pumpAndSettle();

      // A window answers that it could not write.
      await WindowBroadcast.dispatchForTesting(
        const MethodCall('saveFailed', {'windowId': 'w1'}),
      );
      await tester.pumpAndSettle();

      expect(find.text('Save Failed'), findsOneWidget);

      await tester.tap(find.text('Close Anyway'));
      await tester.pumpAndSettle();

      expect(await decision, isTrue);
    });

    testWidgets('should keep the windows open when the user backs out',
        (tester) async {
      markWindowDirty('w1');
      final coordinator = await pumpCoordinator(tester);

      final decision = coordinator.confirm();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save All'));
      await tester.pumpAndSettle();

      await WindowBroadcast.dispatchForTesting(
        const MethodCall('saveFailed', {'windowId': 'w1'}),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(await decision, isFalse);
    });

    testWidgets('should fall back to the timeout when a window goes quiet',
        (tester) async {
      // A window that neither finishes nor reports is the only case the
      // backstop is there for.
      markWindowDirty('w1');
      final coordinator = await pumpCoordinator(
        tester,
        saveTimeout: const Duration(milliseconds: 200),
      );

      final decision = coordinator.confirm();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save All'));
      await tester.pumpAndSettle();

      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      expect(find.text('Save Failed'), findsOneWidget);
      await tester.tap(find.text('Close Anyway'));
      await tester.pumpAndSettle();

      expect(await decision, isTrue);
    });
  });
}
