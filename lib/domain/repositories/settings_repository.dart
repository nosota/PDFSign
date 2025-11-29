import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';

/// Repository interface for application settings and preferences
abstract class SettingsRepository {
  /// Get recent files list
  ResultFuture<List<RecentFile>> getRecentFiles();

  /// Add a file to recent files
  ResultFutureVoid addRecentFile(RecentFile file);

  /// Remove a file from recent files
  ResultFutureVoid removeRecentFile(String path);

  /// Clear all recent files
  ResultFutureVoid clearRecentFiles();

  /// Get the current language code
  ResultFuture<String> getLanguage();

  /// Set the language
  ResultFutureVoid setLanguage(String languageCode);

  /// Get the theme mode (light/dark/system)
  ResultFuture<String> getThemeMode();

  /// Set the theme mode
  ResultFutureVoid setThemeMode(String mode);

  /// Get window dimensions (desktop only)
  ResultFuture<WindowDimensions> getWindowDimensions();

  /// Save window dimensions (desktop only)
  ResultFutureVoid setWindowDimensions(WindowDimensions dimensions);

  /// Get panel width (desktop only)
  ResultFuture<double> getPanelWidth();

  /// Set panel width (desktop only)
  ResultFutureVoid setPanelWidth(double width);

  /// Get last zoom level
  ResultFuture<double> getLastZoomLevel();

  /// Set last zoom level
  ResultFutureVoid setLastZoomLevel(double zoomLevel);

  /// Get selected tab (signatures/stamps)
  ResultFuture<int> getSelectedTab();

  /// Set selected tab
  ResultFutureVoid setSelectedTab(int tabIndex);
}

/// Window dimensions for desktop
class WindowDimensions {
  final double width;
  final double height;
  final double? x;
  final double? y;
  final bool isMaximized;

  const WindowDimensions({
    required this.width,
    required this.height,
    this.x,
    this.y,
    this.isMaximized = false,
  });

  WindowDimensions copyWith({
    double? width,
    double? height,
    double? x,
    double? y,
    bool? isMaximized,
  }) {
    return WindowDimensions(
      width: width ?? this.width,
      height: height ?? this.height,
      x: x ?? this.x,
      y: y ?? this.y,
      isMaximized: isMaximized ?? this.isMaximized,
    );
  }
}
