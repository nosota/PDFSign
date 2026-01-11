import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

part 'recent_files_provider.g.dart';

/// Provider for managing recent files state.
///
/// Handles loading, adding, removing, and clearing recent files.
@riverpod
class RecentFiles extends _$RecentFiles {
  @override
  Future<List<RecentFile>> build() async {
    final repository = ref.watch(recentFilesRepositoryProvider);

    // Cleanup invalid files on initial load
    final result = await repository.cleanupInvalidFiles();

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
