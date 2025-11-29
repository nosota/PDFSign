import 'package:dartz/dartz.dart';
import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/data/datasources/local/settings_local_datasource.dart';
import 'package:pdfsign/data/models/recent_file_model.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';
import 'package:pdfsign/domain/repositories/settings_repository.dart';

/// Implementation of SettingsRepository
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  const SettingsRepositoryImpl(this._localDataSource);

  @override
  ResultFuture<List<RecentFile>> getRecentFiles() async {
    try {
      final models = await _localDataSource.getRecentFiles();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid addRecentFile(RecentFile file) async {
    try {
      final model = RecentFileModel.fromEntity(file);
      await _localDataSource.addRecentFile(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid removeRecentFile(String path) async {
    try {
      await _localDataSource.removeRecentFile(path);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid clearRecentFiles() async {
    try {
      await _localDataSource.clearRecentFiles();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<String> getLanguage() async {
    try {
      final language = await _localDataSource.getLanguage();
      return Right(language);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid setLanguage(String languageCode) async {
    try {
      await _localDataSource.setLanguage(languageCode);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<String> getThemeMode() async {
    try {
      final themeMode = await _localDataSource.getThemeMode();
      return Right(themeMode);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid setThemeMode(String mode) async {
    try {
      await _localDataSource.setThemeMode(mode);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<WindowDimensions> getWindowDimensions() async {
    try {
      final dimensions = await _localDataSource.getWindowDimensions();
      return Right(dimensions);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid setWindowDimensions(WindowDimensions dimensions) async {
    try {
      await _localDataSource.setWindowDimensions(dimensions);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<double> getPanelWidth() async {
    try {
      final width = await _localDataSource.getPanelWidth();
      return Right(width);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid setPanelWidth(double width) async {
    try {
      await _localDataSource.setPanelWidth(width);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<double> getLastZoomLevel() async {
    try {
      final zoomLevel = await _localDataSource.getLastZoomLevel();
      return Right(zoomLevel);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid setLastZoomLevel(double zoomLevel) async {
    try {
      await _localDataSource.setLastZoomLevel(zoomLevel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<int> getSelectedTab() async {
    try {
      final tabIndex = await _localDataSource.getSelectedTab();
      return Right(tabIndex);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid setSelectedTab(int tabIndex) async {
    try {
      await _localDataSource.setSelectedTab(tabIndex);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
