# Platform Channels

Native macOS integration via Flutter platform channels.

## Overview

PDFSign uses platform channels for features that require native macOS APIs:

```
lib/core/platform/
├── sub_window_channel.dart         # Sub-window lifecycle
├── settings_singleton_channel.dart # Settings window singleton
├── open_pdf_files_channel.dart     # Open file tracking
├── window_list_channel.dart        # Window menu operations
├── toolbar_channel.dart            # Native toolbar
└── file_open_handler.dart          # Finder file open requests
```

Native implementations are in `macos/Runner/AppDelegate.swift`.

---

## SubWindowChannel

**File:** `lib/core/platform/sub_window_channel.dart`
**Channel:** `com.pdfsign/window`

Manages sub-window lifecycle (PDF Viewer, Settings). Provides close prevention, focus events, and window destruction.

### Dart → Native Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `setPreventClose` | `bool` | - | Enable/disable close prevention |
| `close` | - | - | Request close (triggers delegate if prevented) |
| `destroy` | - | - | Force close without delegate |
| `hide` | - | - | Hide window |
| `show` | - | - | Show and focus window |

### Native → Dart Methods

| Method | Arguments | Description |
|--------|-----------|-------------|
| `onWindowClose` | - | User clicked close button or Cmd+W |
| `onWindowFocus` | - | Window became focused |
| `onWindowBlur` | - | Window lost focus |

### Callback Setters

```dart
SubWindowChannel.setOnWindowClose(VoidCallback? callback);
SubWindowChannel.setOnWindowFocus(VoidCallback? callback);
SubWindowChannel.setOnWindowBlur(VoidCallback? callback);
```

### Usage Example

```dart
// In initState
SubWindowChannel.setPreventClose(true);
SubWindowChannel.setOnWindowClose(_handleWindowClose);
SubWindowChannel.setOnWindowFocus(_handleFocus);
SubWindowChannel.setOnWindowBlur(_handleBlur);

// Handle close with save dialog
Future<void> _handleWindowClose() async {
  if (isDirty) {
    final shouldClose = await showSaveDialog();
    if (!shouldClose) return;
  }
  await SubWindowChannel.destroy();
}

// In dispose
SubWindowChannel.dispose();
```

---

## SettingsSingletonChannel

**File:** `lib/core/platform/settings_singleton_channel.dart`
**Channel:** `com.pdfsign/settings_singleton`

Ensures only one Settings window exists across all Flutter engines. Uses native-side storage (UserDefaults) as source of truth.

### Dart → Native Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `getSettingsWindowId` | - | `String?` | Get current Settings window ID |
| `setSettingsWindowId` | `String` | - | Store Settings window ID |
| `clearSettingsWindowId` | - | - | Clear Settings window ID |
| `focusSettingsWindow` | - | `bool` | Focus existing Settings window |

### Usage Example

```dart
// Check if Settings already exists
final existingId = await SettingsSingletonChannel.getSettingsWindowId();
if (existingId != null) {
  // Try to focus existing window
  final focused = await SettingsSingletonChannel.focusExistingSettings();
  if (focused) return existingId;
}

// Create new Settings window
final window = await WindowController.create(configuration);
await SettingsSingletonChannel.setSettingsWindowId(window.windowId);

// On Settings close
await SettingsSingletonChannel.clearSettingsWindowId();
```

### Why Native Storage?

Each window runs in a separate Flutter engine with isolated Dart memory. Native storage (UserDefaults) is shared across all engines, providing a single source of truth for the Settings window ID.

---

## OpenPdfFilesChannel

**File:** `lib/core/platform/open_pdf_files_channel.dart`
**Channel:** `com.pdfsign/open_pdf_files`

Tracks open PDF files to prevent duplicate windows. When user tries to open an already-open file, focuses existing window instead of creating duplicate.

### Dart → Native Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `getWindowIdForFile` | `String` (filePath) | `String?` | Get window ID for file if open |
| `registerPdfFile` | `{filePath, windowId}` | - | Register file as open |
| `unregisterPdfFile` | `String` (filePath) | - | Unregister when window closes |
| `focusPdfWindow` | `String` (filePath) | `bool` | Focus window displaying file |

### Usage Example

```dart
// Before creating window, check if file already open
final existingWindowId = await OpenPdfFilesChannel.getWindowIdForFile(filePath);
if (existingWindowId != null) {
  await OpenPdfFilesChannel.focusPdfWindow(filePath);
  return existingWindowId;
}

// Create new window and register
final window = await WindowController.create(configuration);
await OpenPdfFilesChannel.registerPdfFile(filePath, window.windowId);

// On window close
await OpenPdfFilesChannel.unregisterPdfFile(filePath);
```

---

## WindowListChannel

**File:** `lib/core/platform/window_list_channel.dart`
**Channel:** `com.pdfsign/window_list`

Provides Window menu functionality: listing windows, focusing, minimizing, zooming.

### Dart → Native Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `getWindowList` | - | `List<WindowInfo>` | Get all visible windows |
| `focusWindow` | `String` (windowId) | `bool` | Bring window to front |
| `minimizeWindow` | - | - | Minimize current window to Dock |
| `zoomWindow` | - | - | Toggle maximize current window |
| `bringAllToFront` | - | - | Bring all app windows to front |

### WindowInfo Structure

```dart
WindowInfo {
  windowId: String,    // Window ID
  title: String,       // Display title
  type: WindowType,    // welcome, pdf, settings
  isKey: bool,         // Is currently focused
  filePath: String?,   // PDF path (for PDF windows)
}
```

### Usage Example

```dart
// Build Window menu
final windows = await WindowListChannel.getWindowList();

for (final window in windows) {
  final label = window.isKey ? '✓ ${window.title}' : '   ${window.title}';

  menuItems.add(PlatformMenuItem(
    label: label,
    onSelected: () => WindowListChannel.focusWindow(window.windowId),
  ));
}

// Standard window actions
PlatformMenuItem(
  label: 'Minimize',
  shortcut: SingleActivator(LogicalKeyboardKey.keyM, meta: true),
  onSelected: () => WindowListChannel.minimizeWindow(),
),
```

---

## ToolbarChannel

**File:** `lib/core/platform/toolbar_channel.dart`
**Channel:** `com.pdfsign/toolbar`

Handles native macOS toolbar in PDF viewer windows.

### Dart → Native Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `setupToolbar` | - | - | Request toolbar setup for current window |

### Native → Dart Methods

| Method | Arguments | Description |
|--------|-----------|-------------|
| `onSharePressed` | - | Share toolbar button was clicked |

### Callback Setter

```dart
ToolbarChannel.setOnSharePressed(VoidCallback? callback);
```

### Usage Example

```dart
// Initialize once at app startup
ToolbarChannel.init();

// In PDF viewer window
@override
void initState() {
  super.initState();
  ToolbarChannel.setupToolbar();
  ToolbarChannel.setOnSharePressed(_handleShare);
}

void _handleShare() {
  // Create temp PDF with images and share
}
```

### Notes

- Only PDF viewer windows should call `setupToolbar()`
- Settings and Welcome windows do not have toolbar
- `init()` should be called once from main app

---

## FileOpenHandler

**File:** `lib/core/platform/file_open_handler.dart`
**Channel:** `com.pdfsign/file_handler`

Handles file open requests from macOS Finder (double-click, "Open With", drag to Dock icon).

### Dart → Native Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `ready` | - | - | Signal that Flutter is ready to receive files |

### Native → Dart Methods

| Method | Arguments | Description |
|--------|-----------|-------------|
| `openFile` | `String` (filePath) | Open PDF file from Finder |

### Initialization

```dart
await FileOpenHandler.init(
  recentFilesRepository: ref.read(recentFilesRepositoryProvider),
  onHideWelcome: _handleHideWelcome,
);
```

### File Open Flow

1. User double-clicks PDF in Finder
2. macOS sends `application:openFile:` to AppDelegate
3. If Flutter not ready, file path is queued
4. When `ready` is called, queued files are sent via channel
5. `openFile` method receives path and:
   - Validates file exists and is PDF
   - Opens in new window (or focuses existing)
   - Adds to recent files
   - Hides Welcome window

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `recentFilesRepository` | `RecentFilesRepository` | For adding to recent files |
| `onHideWelcome` | `VoidCallback?` | Called when Welcome should hide |

---

## Native Implementation (Swift)

All channels are implemented in `macos/Runner/AppDelegate.swift`.

### Channel Registration

```swift
func applicationDidFinishLaunching(_ notification: Notification) {
    // Register channels with main Flutter view controller
    if let controller = mainFlutterWindow?.contentViewController as? FlutterViewController {
        setupWindowChannel(binaryMessenger: controller.engine.binaryMessenger)
        setupSettingsChannel(binaryMessenger: controller.engine.binaryMessenger)
        setupOpenPdfFilesChannel(binaryMessenger: controller.engine.binaryMessenger)
        setupWindowListChannel(binaryMessenger: controller.engine.binaryMessenger)
        setupToolbarChannel(binaryMessenger: controller.engine.binaryMessenger)
        setupFileHandlerChannel(binaryMessenger: controller.engine.binaryMessenger)
    }
}
```

### Native Storage Keys

| Key | Storage | Description |
|-----|---------|-------------|
| `settingsWindowId` | UserDefaults | Settings window ID |
| `openPdfFiles` | Dictionary | File path → Window ID mapping |

---

## Inter-Window Communication

For communication between Flutter engines (windows), use `WindowBroadcast` instead of platform channels. See [SERVICES.md](SERVICES.md#windowbroadcast).

Platform channels communicate between Dart and native code within the same window. WindowBroadcast uses `desktop_multi_window`'s inter-engine communication.

---

## Error Handling

All channel methods catch exceptions and return safe defaults:

```dart
static Future<String?> getWindowIdForFile(String filePath) async {
  try {
    final result = await _channel.invokeMethod<String?>(...);
    return result;
  } catch (e) {
    if (kDebugMode) {
      print('OpenPdfFilesChannel.getWindowIdForFile ERROR: $e');
    }
    return null;  // Safe default
  }
}
```

This prevents channel errors from crashing the app while maintaining functionality.

---

## Channel Summary

| Channel | Purpose | Direction |
|---------|---------|-----------|
| `com.pdfsign/window` | Sub-window lifecycle | Bidirectional |
| `com.pdfsign/settings_singleton` | Settings window singleton | Dart → Native |
| `com.pdfsign/open_pdf_files` | Track open files | Dart → Native |
| `com.pdfsign/window_list` | Window menu | Dart → Native |
| `com.pdfsign/toolbar` | Native toolbar | Bidirectional |
| `com.pdfsign/file_handler` | Finder file open | Bidirectional |
