import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/data/datasources/recent_files_local_data_source.dart';
import 'package:pdfsign/data/models/recent_file_model.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/domain/repositories/recent_files_repository.dart';

/// Concrete implementation of [RecentFilesRepository].
class RecentFilesRepositoryImpl implements RecentFilesRepository {
  final RecentFilesLocalDataSource _localDataSource;

  RecentFilesRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<RecentFile>>> getRecentFiles() async {
    try {
      final models = await _localDataSource.getRecentFiles();
      final entities = models.map((m) => m.toEntity()).toList();

      // Sort by lastOpened descending
      entities.sort((a, b) => b.lastOpened.compareTo(a.lastOpened));

      // Ensure we don't exceed max files
      final trimmed = entities.take(AppConstants.maxRecentFiles).toList();

      return Right(trimmed);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to load recent files: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addRecentFile(RecentFile file) async {
    try {
      final models = await _localDataSource.getRecentFiles();

      // Remove existing entry for same path (will be re-added at top)
      models.removeWhere((m) => m.path == file.path);

      // Add new entry at the beginning
      models.insert(0, RecentFileModel.fromEntity(file));

      // Keep only max entries
      final trimmed = models.take(AppConstants.maxRecentFiles).toList();

      await _localDataSource.saveRecentFiles(trimmed);

      return const Right(unit);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to save recent file: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeRecentFile(String path) async {
    try {
      final models = await _localDataSource.getRecentFiles();

      models.removeWhere((m) => m.path == path);

      await _localDataSource.saveRecentFiles(models);

      return const Right(unit);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to remove recent file: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAllRecentFiles() async {
    try {
      await _localDataSource.clearRecentFiles();
      return const Right(unit);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to clear recent files: $e'));
    }
  }

  @override
  Future<Either<Failure, List<RecentFile>>> cleanupInvalidFiles() async {
    try {
      final models = await _localDataSource.getRecentFiles();
      final validModels = <RecentFileModel>[];

      for (final model in models) {
        final file = File(model.path);
        if (await file.exists()) {
          validModels.add(model);
        }
      }

      // Save cleaned up list
      await _localDataSource.saveRecentFiles(validModels);

      final entities = validModels.map((m) => m.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(StorageFailure(message: 'Failed to cleanup files: $e'));
    }
  }
}
