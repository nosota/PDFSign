import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/window/window_broadcast.dart';
import 'package:pdfsign/l10n/generated/app_localizations.dart';
import 'package:pdfsign/presentation/providers/editor/global_dirty_state_provider.dart';
import 'package:pdfsign/presentation/widgets/dialogs/close_all_dialog.dart';
import 'package:pdfsign/presentation/widgets/dialogs/save_failed_dialog.dart';

/// Runs the "everything is about to close" flow that Close All and Quit share.
///
/// All three window types used to carry their own copy of this, six in total.
/// They only ever differed in what happens afterwards — broadcasting a close or
/// leaving the process — so that part stays with the caller and everything up
/// to the decision lives here.
class CloseAllCoordinator {
  CloseAllCoordinator({
    required this.ref,
    required this.navigatorKey,
    this.saveTimeout = const Duration(seconds: 30),
  });

  final WidgetRef ref;
  final GlobalKey<NavigatorState> navigatorKey;

  /// Backstop for a save that never reports back. Only a window that hangs
  /// should ever reach it: a save that finishes clears the dirty flag and one
  /// that fails says so, and either ends the wait immediately.
  final Duration saveTimeout;

  /// Asks about unsaved documents, saves the ones the user wants kept, and
  /// reports whether closing may go ahead.
  Future<bool> confirm() async {
    if (_dirtyWindowCount() == 0) {
      return true;
    }

    final context = navigatorKey.currentContext;
    if (context == null) {
      // Nothing can be asked without a navigator, and there is unsaved work.
      // Refusing loses nothing; proceeding would discard it silently.
      return false;
    }

    final choice = await CloseAllDialog.show(context, _dirtyWindowCount());
    switch (choice) {
      case CloseAllResult.discard:
        return true;
      case CloseAllResult.cancel:
      case null:
        return false;
      case CloseAllResult.saveAll:
        return _saveEverythingThenConfirm();
    }
  }

  Future<bool> _saveEverythingThenConfirm() async {
    await WindowBroadcast.broadcastSaveAll();
    final unsaved = await _awaitPendingSaves();
    if (unsaved == 0) {
      return true;
    }

    // Some window could not be written. Closing now would drop its changes, so
    // the decision goes back to the user.
    final context = navigatorKey.currentContext;
    if (context == null) {
      return false;
    }
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return false;
    }
    return SaveFailedDialog.show(context, unsaved);
  }

  /// Waits for the saves that Save All started and returns how many windows
  /// were left unwritten.
  ///
  /// Waiting on the signal the windows already send, rather than sleeping for a
  /// fixed time, is what makes this both quick and correct: the common case
  /// finishes in milliseconds instead of stalling, and a slow save on a large
  /// document is no longer mistaken for a failure and closed out from under.
  Future<int> _awaitPendingSaves() async {
    if (_dirtyWindowCount() == 0) {
      return 0;
    }

    final completer = Completer<int>();
    final failedWindows = <String>{};

    void finish(int unsaved) {
      if (!completer.isCompleted) {
        completer.complete(unsaved);
      }
    }

    WindowBroadcast.setOnSaveFailed((windowId) {
      failedWindows.add(windowId);
      finish(failedWindows.length);
    });

    final subscription = ref.listenManual<Map<String, bool>>(
      globalDirtyStateProvider,
      (previous, next) {
        if (!next.values.any((isDirty) => isDirty)) {
          finish(0);
        }
      },
    );

    final backstop = Timer(saveTimeout, () => finish(_dirtyWindowCount()));

    try {
      return await completer.future;
    } finally {
      backstop.cancel();
      subscription.close();
      WindowBroadcast.setOnSaveFailed(null);
    }
  }

  int _dirtyWindowCount() =>
      ref.read(globalDirtyStateProvider).values.where((d) => d).length;
}
