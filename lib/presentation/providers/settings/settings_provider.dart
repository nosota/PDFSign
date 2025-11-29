import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/domain/repositories/settings_repository.dart';

part 'settings_provider.g.dart';

/// Provider for settings repository
@riverpod
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  throw UnimplementedError('SettingsRepository implementation not provided');
}

/// Recent files provider
@riverpod
class RecentFiles extends _$RecentFiles {
  @override
  Future<List<RecentFile>> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    final result = await repository.getRecentFiles();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (files) => files,
    );
  }

  Future<void> addRecentFile(RecentFile file) async {
    final repository = ref.read(settingsRepositoryProvider);
    final result = await repository.addRecentFile(file);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        ref.invalidateSelf();
      },
    );
  }

  Future<void> removeRecentFile(String path) async {
    final repository = ref.read(settingsRepositoryProvider);
    final result = await repository.removeRecentFile(path);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        ref.invalidateSelf();
      },
    );
  }

  Future<void> clearRecentFiles() async {
    final repository = ref.read(settingsRepositoryProvider);
    final result = await repository.clearRecentFiles();

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = const AsyncData([]);
      },
    );
  }
}

/// Language provider
@riverpod
class AppLanguage extends _$AppLanguage {
  @override
  Future<String> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    final result = await repository.getLanguage();
    return result.fold(
      (failure) => 'en', // Default to English
      (language) => language,
    );
  }

  Future<void> setLanguage(String languageCode) async {
    final repository = ref.read(settingsRepositoryProvider);
    final result = await repository.setLanguage(languageCode);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(languageCode);
      },
    );
  }
}

/// Panel width provider (desktop)
@riverpod
class PanelWidth extends _$PanelWidth {
  @override
  Future<double> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    final result = await repository.getPanelWidth();
    return result.fold(
      (failure) => 280.0, // Default width
      (width) => width,
    );
  }

  Future<void> setWidth(double width) async {
    final repository = ref.read(settingsRepositoryProvider);
    final result = await repository.setPanelWidth(width);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(width);
      },
    );
  }
}

/// Selected tab provider (0 = signatures, 1 = stamps)
@riverpod
class SelectedTab extends _$SelectedTab {
  @override
  Future<int> build() async {
    final repository = ref.watch(settingsRepositoryProvider);
    final result = await repository.getSelectedTab();
    return result.fold(
      (failure) => 0, // Default to signatures
      (tab) => tab,
    );
  }

  Future<void> setTab(int tabIndex) async {
    final repository = ref.read(settingsRepositoryProvider);
    final result = await repository.setSelectedTab(tabIndex);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(tabIndex);
      },
    );
  }
}

/// Clipboard paste preferences
class ClipboardPastePreferences {
  final bool dontAskAgain;
  final SignatureType? defaultType; // null means ask every time

  const ClipboardPastePreferences({
    this.dontAskAgain = false,
    this.defaultType,
  });

  ClipboardPastePreferences copyWith({
    bool? dontAskAgain,
    SignatureType? defaultType,
  }) {
    return ClipboardPastePreferences(
      dontAskAgain: dontAskAgain ?? this.dontAskAgain,
      defaultType: defaultType ?? this.defaultType,
    );
  }
}

/// Clipboard paste preferences provider (NEW UX feature)
@riverpod
class ClipboardPreferences extends _$ClipboardPreferences {
  @override
  ClipboardPastePreferences build() {
    // TODO: Load from SharedPreferences
    return const ClipboardPastePreferences();
  }

  void setDontAskAgain(bool value) {
    state = state.copyWith(dontAskAgain: value);
    // TODO: Save to SharedPreferences
  }

  void setDefaultType(SignatureType? type) {
    state = state.copyWith(defaultType: type);
    // TODO: Save to SharedPreferences
  }

  void reset() {
    state = const ClipboardPastePreferences();
    // TODO: Clear from SharedPreferences
  }
}
