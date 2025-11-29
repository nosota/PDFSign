/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'PDFSign';
  static const String packageName = 'com.nosota.pdfsign';

  // File Limits
  static const int maxImageFileSizeBytes = 100 * 1024 * 1024; // 100MB
  static const int maxImageResolution = 4096; // 4096x4096

  // Recent Files
  static const int maxRecentFiles = 10;

  // Undo/Redo
  static const int maxUndoStackSize = 50;

  // Password
  static const int maxPasswordAttempts = 3;

  // Zoom
  static const double minZoomLevel = 0.1; // 10%
  static const double maxZoomLevel = 5.0; // 500%
  static const double defaultZoomLevel = 1.0; // 100%
  static const List<double> zoomPresets = [
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    2.0,
  ];

  // Transform
  static const double rotationIncrement = 5.0; // degrees
  static const double rotation90Increment = 90.0; // degrees
  static const double scaleIncrement = 0.05; // 5%
  static const double minObjectSize = 20.0; // logical pixels

  // Panel Dimensions (Desktop)
  static const double minPanelWidth = 200.0;
  static const double maxPanelWidth = 400.0;
  static const double defaultPanelWidth = 280.0;

  // Preview Image (in signature/stamp panel)
  static const double maxPreviewHeight = 150.0;

  // Window Dimensions (Desktop)
  static const double minWindowWidth = 1024.0;
  static const double minWindowHeight = 768.0;
  static const double defaultWindowWidth = 1280.0;
  static const double defaultWindowHeight = 800.0;

  // Selection Handles
  static const double handleSize = 12.0;
  static const double handleBorderWidth = 2.0;
  static const double selectionBoxBorderWidth = 2.0;
  static const double rotationHandleSize = 24.0;
  static const double rotationHandleDistance = 40.0;

  // Touch Target (Mobile)
  static const double minTouchTargetSize = 48.0;

  // Supported Image Formats
  static const List<String> supportedImageExtensions = [
    'png',
    'jpg',
    'jpeg',
    'tiff',
    'tif',
    'webp',
    'svg',
  ];

  static const List<String> supportedImageMimeTypes = [
    'image/png',
    'image/jpeg',
    'image/tiff',
    'image/webp',
    'image/svg+xml',
  ];

  // Database
  static const String databaseName = 'signatures.isar';

  // Preferences Keys
  static const String prefKeyLanguage = 'language';
  static const String prefKeyThemeMode = 'theme_mode';
  static const String prefKeyWindowWidth = 'window_width';
  static const String prefKeyWindowHeight = 'window_height';
  static const String prefKeyWindowX = 'window_x';
  static const String prefKeyWindowY = 'window_y';
  static const String prefKeyWindowMaximized = 'window_maximized';
  static const String prefKeyPanelWidth = 'panel_width';
  static const String prefKeyLastZoomLevel = 'last_zoom_level';
  static const String prefKeySelectedTab = 'selected_tab';
  static const String prefKeyRecentFiles = 'recent_files';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Debounce/Throttle
  static const Duration debounceSearchDuration = Duration(milliseconds: 300);
  static const Duration throttleResizeDuration = Duration(milliseconds: 16); // ~60fps

  // Snackbar/Toast
  static const Duration snackbarDuration = Duration(seconds: 4);
  static const Duration errorSnackbarDuration = Duration(seconds: 6);

  // Initial Placement
  static const double defaultPlacedObjectSize = 200.0;

  // Drag Ghost Opacity
  static const double dragGhostOpacity = 0.5;

  // Hover Effect Opacity
  static const double hoverOpacity = 0.04;

  // Minimum time to show loading indicator
  static const Duration minLoadingDuration = Duration(milliseconds: 500);

  // Z-Index
  static const int minZIndex = 0;
  static const int initialZIndex = 0;

  // Keyboard Nudge
  static const double nudgeDistance = 1.0; // pixels
  static const double shiftNudgeDistance = 10.0; // pixels

  // PDF Rendering
  static const double pdfPageSpacing = 16.0; // spacing between pages
  static const int pdfRenderDpi = 150; // DPI for rendering

  // Syncfusion License (placeholder - should be set in main)
  static const String syncfusionLicenseKey = '';
}