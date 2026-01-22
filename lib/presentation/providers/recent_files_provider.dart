import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

part 'recent_files_provider.g.dart';

/// Provider for managing recent files state.
///
/// Handles loading, adding, removing, and clearing recent files.
/// Uses keepAlive to prevent auto-dispose which can cause state loss
/// between operations and race conditions with SharedPreferences.
@Riverpod(keepAlive: true)
class RecentFiles extends _$RecentFiles {
  /// Whether initial cleanup has been performed.
  bool _initialCleanupDone = false;

  @override
  Future<List<RecentFile>> build() async {
    final repository = ref.watch(recentFilesRepositoryProvider);

    // Only cleanup invalid files on first load, not on every rebuild.
    // This prevents race conditions where cleanup overwrites newly added files.
    if (!_initialCleanupDone) {
      _initialCleanupDone = true;
      final result = await repository.cleanupInvalidFiles();
      return result.fold(
        (failure) => throw Exception(failure.message),
        (files) => files,
      );
    }

    // On subsequent rebuilds, just read current files
    final result = await repository.getRecentFiles();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (files) => files,
    );
  }

  /// Adds a file to recent files and refreshes the list.
  Future<void> addFile(RecentFile file) async {
    final repository = ref.read(recentFilesRepositoryProvider);
    final result = await repository.addRecentFile(file);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// Removes a file from recent files.
  Future<void> removeFile(String path) async {
    final repository = ref.read(recentFilesRepositoryProvider);
    final result = await repository.removeRecentFile(path);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }

  /// Clears all recent files.
  Future<void> clearAll() async {
    final repository = ref.read(recentFilesRepositoryProvider);
    final result = await repository.clearAllRecentFiles();

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) => ref.invalidateSelf(),
    );
  }
}
