/// Application-wide constants.
abstract final class AppConstants {
  /// Maximum number of recent files to store.
  static const int maxRecentFiles = 12;

  /// SharedPreferences key for storing recent files.
  static const String recentFilesKey = 'recent_files';
}
