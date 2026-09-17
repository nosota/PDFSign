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
├── file_open_handler.dart          # Finder file open requests
└── pdf_security_channel.dart       # Whether a PDF is encrypted
```

Native implementations are in `macos/Runner/AppDelegate.swift`, except the PDF
security probe (`macos/Runner/PdfFileSecurity.swift`) and window placement
(`macos/Runner/WindowCascade.swift`).

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
| `setDeleteButtonEnabled` | `enabled`, `label`, `tooltip` | - | Enable or grey out Delete, with localized texts |
| `setRotateLabels` | `left`, `right` | - | Localized texts for the rotate control |
| `setHistoryEnabled` | `canUndo`, `canRedo`, `labels` | - | Greys each half of the undo control on its own |
| `setZOrderEnabled` | `enabled`, `labels`, `groupLabel` | - | Greys the four-segment restacking control |
| `setProtectionState` | `protected`, `label`, `tooltip` | - | Which way the lock is drawn, and its texts |

### Native → Dart Methods

| Method | Arguments | Description |
|--------|-----------|-------------|
| `onSharePressed` | - | Share toolbar button was clicked |
| `onDeletePressed` | - | Delete toolbar button was clicked |
| `onRotateLeftPressed` | - | Left half of the rotate control was clicked |
| `onRotateRightPressed` | - | Right half of the rotate control was clicked |
| `onUndoPressed` / `onRedoPressed` | - | A half of the undo control was clicked |
| `onSendToBackPressed`, `onSendBackwardPressed`, `onBringForwardPressed`, `onBringToFrontPressed` | - | A segment of the restacking control was clicked |
| `onProtectPressed` | - | The lock was clicked |

### Callback Setters

```dart
ToolbarChannel.setOnSharePressed(VoidCallback? callback);
ToolbarChannel.setOnDeletePressed(VoidCallback? callback);
ToolbarChannel.setOnRotateLeftPressed(VoidCallback? callback);
ToolbarChannel.setOnRotateRightPressed(VoidCallback? callback);
ToolbarChannel.setOnProtectPressed(VoidCallback? callback);
ToolbarChannel.setOnHistoryPressed(undo: ..., redo: ...);
ToolbarChannel.setOnRestackPressed([toBack, backward, forward, toFront]);
```

### Item layout

```
[ ⟲ undo ⟳ ][ ⇱ restack ⇲ ][ rotate ⟲ ⟳ ][ flexible space ][ Delete ][ gap ][ 🔒 ][ gap ][ Share ]
```

Left to right: undo and redo, the four restacking segments, the two page
turns, then Delete, the lock and Share. Restacking sits before the page turns
because it acts on the object and the turns act on the page under it. The lock
stands between Delete and Share, separated from both by a fixed space: it is a
property of the file, and the thing worth settling before handing it on.

The item set never changes. Delete is **greyed out** when nothing is selected
rather than taken away: an earlier version inserted and removed it, which moved
the controls beside it every time the selection changed, and which twice put
NSToolbar into a state that aborted the process. A fixed item set cannot drift,
cannot duplicate an item, and cannot shift anything.

Rotation, undo and restacking are each an `NSToolbarItemGroup` of segments —
one control, not two or four buttons. Delete stands on its own: fixed spaces
separate it from the lock and the lock from Share, because deleting an object,
protecting a document and sharing it are unrelated actions, and icons side by
side read as one control.

Measured on the running app: with and without a selection the icons occupy
exactly the same columns, and only the trash's colour changes.

**A group validates its own subitems.** Setting `autovalidates = false` on a
subitem does not stop `NSToolbarItemGroup` from enabling it again, so
`validateToolbarItem(_:)` answers with the state Dart last pushed rather than
`true`. Four tests hold that: restoring the unconditional `true` makes them
fail.

The lock keeps the same picture whichever way it is drawn — only the symbol
changes, closed for a document that asks for a password or withholds anything,
open for one that does not.

**The title bar is transparent, deliberately.** With an opaque one AppKit
inserts a `BackdropView` beside the Flutter view and hangs it 32 pt over the
top of the content. It draws nothing there and it hit-tests, so it swallows
every click in that strip — the read-only notice's button could not be pressed
at all, and an object resting against the top of the viewport could not be
picked up. Nothing is drawn under the title bar here, so the backdrop has
nothing to blur.

The toolbar is built by AppKit before Flutter has resolved a locale, so it
starts with English texts. `setRotateLabels`, `setHistoryEnabled`,
`setZOrderEnabled` and `setProtectionState` carry localized texts alongside
their state and correct them once the toolbar exists, and again whenever the
language changes.

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

## PdfSecurityChannel

**File:** `lib/core/platform/pdf_security_channel.dart`
**Channel:** `com.pdfsign/pdf_security`
**Native:** `macos/Runner/PdfFileSecurity.swift`

Reads what a PDF file says about its own protection, **before anything opens
it**. What decides whether a document takes the ordinary route or the protected
one (FR-1.8, ADR-0011).

### Dart → Native Methods

| Method | Arguments | Returns | Description |
|--------|-----------|---------|-------------|
| `inspect` | the file path, as a bare `String` | `{isEncrypted: bool, isUnlocked: bool}`, or nil | What CoreGraphics makes of the file |

```dart
final security = await PdfSecurityChannel.inspect(path);
// null  → no answer; go on and let the renderer speak for itself
// isEncrypted    → the file carries encryption of any kind
// needsPassword  → encrypted and not already unlocked by an empty user password
```

### Why CoreGraphics

Neither PDF library can answer this. The renderer (pdfx) refuses every
encrypted file on macOS without saying why; the writer (syncfusion) has no
public way to report that a document was encrypted at all — `security.algorithm`
returns a default value for a plain file, which cannot be told from a real one.
CoreGraphics is the authority the renderer itself answers to, which makes its
verdict the one that predicts what the renderer will do.

### Notes

- **nil is not "unencrypted".** A file the system cannot parse as a PDF gets no
  answer, which is a different thing and is reported as such; `inspect` returns
  null and the caller goes on.
- A document carrying **only an owner password** comes back
  `isEncrypted: true, isUnlocked: true` — an empty user password already opened
  it. It needs nothing from the reader, but its permissions still apply
  (FR-1.9).
- Registered for **every** engine, main window and sub-windows alike: any
  window may be the one that opens a document.

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
        setupPdfSecurityChannel(binaryMessenger: controller.engine.binaryMessenger)
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
| `com.pdfsign/pdf_security` | Whether a file is encrypted, before it is opened | Dart → Native |
