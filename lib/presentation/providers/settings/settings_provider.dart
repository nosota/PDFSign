import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/presentation/providers/infrastructure/repository_providers.dart';

part 'settings_provider.g.dart';

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
