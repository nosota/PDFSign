import 'dart:convert';

import 'package:pdfsign/core/constants/app_constants.dart';
import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/data/models/recent_file_model.dart';
import 'package:pdfsign/domain/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstract interface for settings local data source
abstract class SettingsLocalDataSource {
  /// Get recent files
  Future<List<RecentFileModel>> getRecentFiles();

  /// Add recent file
  Future<void> addRecentFile(RecentFileModel file);

  /// Remove recent file
  Future<void> removeRecentFile(String path);

  /// Clear all recent files
  Future<void> clearRecentFiles();

  /// Get language code
  Future<String> getLanguage();

  /// Set language code
  Future<void> setLanguage(String languageCode);

  /// Get theme mode
  Future<String> getThemeMode();

  /// Set theme mode
  Future<void> setThemeMode(String mode);

  /// Get window dimensions
  Future<WindowDimensions> getWindowDimensions();

  /// Set window dimensions
  Future<void> setWindowDimensions(WindowDimensions dimensions);

  /// Get panel width
  Future<double> getPanelWidth();

  /// Set panel width
  Future<void> setPanelWidth(double width);

  /// Get last zoom level
  Future<double> getLastZoomLevel();

  /// Set last zoom level
  Future<void> setLastZoomLevel(double zoomLevel);

  /// Get selected tab
  Future<int> getSelectedTab();

  /// Set selected tab
  Future<void> setSelectedTab(int tabIndex);
}

/// Implementation using SharedPreferences
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences _prefs;

  const SettingsLocalDataSourceImpl(this._prefs);

  @override
  Future<List<RecentFileModel>> getRecentFiles() async {
    try {
      final jsonString = _prefs.getString(AppConstants.prefKeyRecentFiles);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => RecentFileModel()
            ..path = json['path']
            ..fileName = json['fileName']
            ..lastOpened = DateTime.parse(json['lastOpened'])
            ..pageCount = json['pageCount']
            ..isPasswordProtected = json['isPasswordProtected'])
          .toList();
    } catch (e) {
      throw CacheException('Failed to get recent files: ${e.toString()}');
    }
  }

  @override
  Future<void> addRecentFile(RecentFileModel file) async {
    try {
      final recentFiles = await getRecentFiles();

      // Remove if already exists
      recentFiles.removeWhere((f) => f.path == file.path);

      // Add to beginning
      recentFiles.insert(0, file);

      // Limit to max recent files
      if (recentFiles.length > AppConstants.maxRecentFiles) {
        recentFiles.removeRange(
          AppConstants.maxRecentFiles,
          recentFiles.length,
        );
      }

      // Save
      await _saveRecentFiles(recentFiles);
    } catch (e) {
      throw CacheException('Failed to add recent file: ${e.toString()}');
    }
  }

  @override
  Future<void> removeRecentFile(String path) async {
    try {
      final recentFiles = await getRecentFiles();
      recentFiles.removeWhere((f) => f.path == path);
      await _saveRecentFiles(recentFiles);
    } catch (e) {
      throw CacheException('Failed to remove recent file: ${e.toString()}');
    }
  }

  @override
  Future<void> clearRecentFiles() async {
    try {
      await _prefs.remove(AppConstants.prefKeyRecentFiles);
    } catch (e) {
      throw CacheException('Failed to clear recent files: ${e.toString()}');
    }
  }

  Future<void> _saveRecentFiles(List<RecentFileModel> files) async {
    final jsonList = files
        .map((f) => {
              'path': f.path,
              'fileName': f.fileName,
              'lastOpened': f.lastOpened.toIso8601String(),
              'pageCount': f.pageCount,
              'isPasswordProtected': f.isPasswordProtected,
            })
        .toList();

    await _prefs.setString(
      AppConstants.prefKeyRecentFiles,
      json.encode(jsonList),
    );
  }

  @override
  Future<String> getLanguage() async {
    try {
      return _prefs.getString(AppConstants.prefKeyLanguage) ?? 'en';
    } catch (e) {
      throw CacheException('Failed to get language: ${e.toString()}');
    }
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    try {
      await _prefs.setString(AppConstants.prefKeyLanguage, languageCode);
    } catch (e) {
      throw CacheException('Failed to set language: ${e.toString()}');
    }
  }

  @override
  Future<String> getThemeMode() async {
    try {
      return _prefs.getString(AppConstants.prefKeyThemeMode) ?? 'light';
    } catch (e) {
      throw CacheException('Failed to get theme mode: ${e.toString()}');
    }
  }

  @override
  Future<void> setThemeMode(String mode) async {
    try {
      await _prefs.setString(AppConstants.prefKeyThemeMode, mode);
    } catch (e) {
      throw CacheException('Failed to set theme mode: ${e.toString()}');
    }
  }

  @override
  Future<WindowDimensions> getWindowDimensions() async {
    try {
      final width = _prefs.getDouble(AppConstants.prefKeyWindowWidth) ??
          AppConstants.defaultWindowWidth;
      final height = _prefs.getDouble(AppConstants.prefKeyWindowHeight) ??
          AppConstants.defaultWindowHeight;
      final x = _prefs.getDouble(AppConstants.prefKeyWindowX);
      final y = _prefs.getDouble(AppConstants.prefKeyWindowY);
      final isMaximized =
          _prefs.getBool(AppConstants.prefKeyWindowMaximized) ?? true;

      return WindowDimensions(
        width: width,
        height: height,
        x: x,
        y: y,
        isMaximized: isMaximized,
      );
    } catch (e) {
      throw CacheException('Failed to get window dimensions: ${e.toString()}');
    }
  }

  @override
  Future<void> setWindowDimensions(WindowDimensions dimensions) async {
    try {
      await _prefs.setDouble(AppConstants.prefKeyWindowWidth, dimensions.width);
      await _prefs.setDouble(
        AppConstants.prefKeyWindowHeight,
        dimensions.height,
      );
      if (dimensions.x != null) {
        await _prefs.setDouble(AppConstants.prefKeyWindowX, dimensions.x!);
      }
      if (dimensions.y != null) {
        await _prefs.setDouble(AppConstants.prefKeyWindowY, dimensions.y!);
      }
      await _prefs.setBool(
        AppConstants.prefKeyWindowMaximized,
        dimensions.isMaximized,
      );
    } catch (e) {
      throw CacheException('Failed to set window dimensions: ${e.toString()}');
    }
  }

  @override
  Future<double> getPanelWidth() async {
    try {
      return _prefs.getDouble(AppConstants.prefKeyPanelWidth) ??
          AppConstants.defaultPanelWidth;
    } catch (e) {
      throw CacheException('Failed to get panel width: ${e.toString()}');
    }
  }

  @override
  Future<void> setPanelWidth(double width) async {
    try {
      await _prefs.setDouble(AppConstants.prefKeyPanelWidth, width);
    } catch (e) {
      throw CacheException('Failed to set panel width: ${e.toString()}');
    }
  }

  @override
  Future<double> getLastZoomLevel() async {
    try {
      return _prefs.getDouble(AppConstants.prefKeyLastZoomLevel) ??
          AppConstants.defaultZoomLevel;
    } catch (e) {
      throw CacheException('Failed to get last zoom level: ${e.toString()}');
    }
  }

  @override
  Future<void> setLastZoomLevel(double zoomLevel) async {
    try {
      await _prefs.setDouble(AppConstants.prefKeyLastZoomLevel, zoomLevel);
    } catch (e) {
      throw CacheException('Failed to set last zoom level: ${e.toString()}');
    }
  }

  @override
  Future<int> getSelectedTab() async {
    try {
      return _prefs.getInt(AppConstants.prefKeySelectedTab) ?? 0;
    } catch (e) {
      throw CacheException('Failed to get selected tab: ${e.toString()}');
    }
  }

  @override
  Future<void> setSelectedTab(int tabIndex) async {
    try {
      await _prefs.setInt(AppConstants.prefKeySelectedTab, tabIndex);
    } catch (e) {
      throw CacheException('Failed to set selected tab: ${e.toString()}');
    }
  }
}
