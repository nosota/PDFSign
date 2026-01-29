# Services

Data layer services in the PDFSign project.

## Overview

Services handle specific business operations that don't fit into repositories. They are stateless (except for caching) and focus on a single responsibility.

```
lib/data/services/
├── pdf_save_service.dart       # PDF saving with embedded images
├── original_pdf_storage.dart   # Original PDF bytes caching
├── image_storage_service.dart  # Image file management
```

---

## PdfSaveService

**File:** `lib/data/services/pdf_save_service.dart`

Service for saving PDFs with placed images embedded. Uses Syncfusion PDF library.

### Public Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `savePdf` | `Future<Either<Failure, String>> savePdf({required String originalPath, required List<PlacedImage> placedImages, String? outputPath})` | Saves PDF with images from file path |
| `savePdfFromBytes` | `Future<Either<Failure, String>> savePdfFromBytes({required Uint8List originalBytes, required List<PlacedImage> placedImages, required String outputPath})` | Saves PDF with images from bytes |
| `createTempPdfWithImages` | `Future<Either<Failure, String>> createTempPdfWithImages({required String originalPath, required List<PlacedImage> placedImages})` | Creates temp PDF for sharing |
| `createTempPdfWithImagesFromBytes` | `Future<Either<Failure, String>> createTempPdfWithImagesFromBytes({required Uint8List originalBytes, required List<PlacedImage> placedImages})` | Creates temp PDF from bytes |

### Implementation Details

**Image Embedding Process:**

1. Groups images by page index
2. For each page with images:
   - Gets page graphics context
   - For each image:
     - Saves graphics state
     - Applies rotation transform around center point
     - Draws image using `graphics.drawImage()`
     - Restores graphics state
3. Saves document to output path

**Rotation Handling:**

```dart
// Calculate center point for rotation
final centerX = placedImage.position.dx + placedImage.size.width / 2;
final centerY = placedImage.position.dy + placedImage.size.height / 2;

// Apply rotation around center
if (placedImage.rotation != 0) {
  graphics.translateTransform(centerX, centerY);
  graphics.rotateTransform(_radiansToDegrees(placedImage.rotation));
  graphics.translateTransform(-centerX, -centerY);
}
```

**Error Handling:**

- Returns `FileNotFoundFailure` if original PDF not found
- Returns `StorageFailure` for any save errors
- Skips images with missing files (doesn't fail entire save)

---

## OriginalPdfStorage

**File:** `lib/data/services/original_pdf_storage.dart`

Stores original PDF bytes for Save operations. Allows multiple Save operations to always use the clean original (without previously embedded objects).

### Public Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `store` | `Future<bool> store(String sourcePath)` | Stores PDF from path |
| `getBytes` | `Future<Uint8List> getBytes()` | Gets stored bytes |
| `dispose` | `Future<void> dispose()` | Cleans up storage |

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `originalFilePath` | `String?` | Path to original file (for display) |
| `hasData` | `bool` | Whether any PDF is stored |
| `isInMemory` | `bool` | Whether stored in memory vs temp file |

### Implementation Details

**Memory Threshold:** 50 MB

- **Small files (≤50MB):** Stored in memory as `Uint8List` for fast access
- **Large files (>50MB):** Copied to temp file to conserve RAM

**Temp File Location:**

```
${tempDir}/pdfsign_original_${timestamp}.pdf
```

**Usage Pattern:**

```dart
// When opening PDF
await originalPdfStorage.store(filePath);

// When saving
final originalBytes = await originalPdfStorage.getBytes();
await pdfSaveService.savePdfFromBytes(
  originalBytes: originalBytes,
  placedImages: placedImages,
  outputPath: outputPath,
);

// When closing document
await originalPdfStorage.dispose();
```

---

## ImageStorageService

**File:** `lib/data/services/image_storage_service.dart`

Manages image file storage in app data folder. Copies images to a dedicated folder so they're independent of original file locations.

### Public Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `getImagesDirectory` | `Future<Directory> getImagesDirectory()` | Gets/creates images directory |
| `copyImageToStorage` | `Future<String> copyImageToStorage(String sourcePath)` | Copies image, returns new path |
| `deleteImage` | `Future<void> deleteImage(String storagePath)` | Deletes image from storage |
| `isInStorage` | `bool isInStorage(String filePath)` | Checks if path is in app storage |

### Storage Location

**macOS:**
```
~/Library/Application Support/com.ivanvaganov.pdfsign/images/
```

**Windows:**
```
C:\Users\<user>\AppData\Roaming\pdfsign\images\
```

### File Naming

Files are copied with UUID-based names to avoid conflicts:

```
{uuid}.{original_extension}
```

Example: `a1b2c3d4-e5f6-7890-abcd-ef1234567890.png`

### Usage in Repository

```dart
// In SidebarImageRepositoryImpl.addImage()
final storagePath = await _storageService.copyImageToStorage(filePath);

// Store storagePath in Isar, not original filePath
final entity = SidebarImage(
  filePath: storagePath,  // Path in app storage
  ...
);
```

---

## WindowManagerService

**File:** `lib/core/window/window_manager_service.dart`

Singleton service for managing multiple windows in the application.

### Public Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `initializeMainWindow` | `Future<void> initializeMainWindow()` | Sets up Welcome window |
| `initializeSubWindow` | `Future<void> initializeSubWindow({required String title})` | Sets up PDF viewer window |
| `initializeSettingsWindow` | `Future<void> initializeSettingsWindow({required String title})` | Sets up Settings window (fixed size) |
| `createPdfWindow` | `Future<String?> createPdfWindow(String filePath)` | Creates/focuses PDF window |
| `createSettingsWindow` | `Future<String?> createSettingsWindow()` | Creates/focuses Settings (singleton) |
| `registerWindow` | `void registerWindow(String windowId)` | Tracks window as open |
| `unregisterWindow` | `void unregisterWindow(String windowId)` | Removes window from tracking |
| `setWelcomeHidden` | `void setWelcomeHidden()` | Marks Welcome as hidden |
| `closeAllWindows` | `Future<void> closeAllWindows()` | Closes all PDF windows |
| `closeCurrentWindow` | `Future<void> closeCurrentWindow()` | Closes current window |
| `getAllWindows` | `Future<List<WindowController>> getAllWindows()` | Gets all window controllers |

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `instance` | `WindowManagerService` | Singleton instance |
| `openWindows` | `Set<String>` | IDs of open PDF windows |
| `hasOpenWindows` | `bool` | Whether any PDF windows exist |
| `hasSettingsWindow` | `bool` | Whether Settings is open |
| `isWelcomeHidden` | `bool` | Whether Welcome was hidden |

### Implementation Details

**PDF Window Creation:**

1. Checks if file already open via `OpenPdfFilesChannel`
2. If open, focuses existing window and returns its ID
3. Otherwise creates new window with `WindowController.create()`
4. Registers file with native storage
5. Broadcasts `hideWelcome` if this is first PDF
6. Returns new window ID

**Settings Singleton:**

1. Checks native storage for existing Settings ID
2. If exists, verifies window still alive
3. If alive, focuses and returns ID
4. If dead, clears native ID
5. Creates new Settings window
6. Registers with native storage

**Window Sizes:**

- Main (Welcome): 900x700, minimum 600x400
- PDF Viewer: Inherits from main
- Settings: Fixed 650x500, not resizable, no minimize

---

## WindowBroadcast

**File:** `lib/core/window/window_broadcast.dart`

Service for broadcasting messages between windows using `desktop_multi_window`'s inter-window communication.

### Broadcast Methods

| Method | Description |
|--------|-------------|
| `broadcastUnitChanged()` | Size unit preference changed |
| `broadcastLocaleChanged()` | Locale preference changed |
| `broadcastSaveAll()` | Save All triggered |
| `broadcastCloseAll()` | Close All triggered |
| `broadcastShowWelcome()` | Show Welcome window |
| `broadcastHideWelcome()` | Hide Welcome permanently |
| `broadcastDirtyStateChanged(windowId, isDirty)` | Window dirty state changed |
| `broadcastRequestDirtyStates()` | Request dirty states from all |
| `broadcastSettingsOpened(windowId)` | Settings window opened |
| `broadcastSettingsClosed()` | Settings window closed |

### Callback Setters

| Method | Callback Type |
|--------|---------------|
| `setOnUnitChanged` | `VoidCallback` |
| `setOnLocaleChanged` | `VoidCallback` |
| `setOnSaveAll` | `VoidCallback` |
| `setOnCloseAll` | `VoidCallback` |
| `setOnShowWelcome` | `VoidCallback` |
| `setOnHideWelcome` | `VoidCallback` |
| `setOnDirtyStateChanged` | `(String windowId, bool isDirty)` |
| `setOnRequestDirtyStates` | `VoidCallback` |
| `setOnSettingsOpened` | `(String windowId)` |
| `setOnSettingsClosed` | `VoidCallback` |

### Broadcast Types

**Excluding Self:**
- `unitChanged`, `localeChanged`, `showWelcome`, `dirtyStateChanged`, `requestDirtyStates`, `settingsOpened`, `settingsClosed`

**Including Self:**
- `saveAll`, `closeAll`, `hideWelcome`

---

## Service Dependency Graph

```
PdfSaveService
├── Uses: Syncfusion PDF library
├── Input: PlacedImage list
└── Output: Saved PDF file

OriginalPdfStorage
├── Used by: PdfSaveService (via provider)
├── Stores: Original PDF bytes
└── Strategy: In-memory (≤50MB) or temp file (>50MB)

ImageStorageService
├── Used by: SidebarImageRepositoryImpl
├── Copies: Images to app support folder
└── Generates: UUID-based filenames

WindowManagerService
├── Uses: desktop_multi_window, window_manager
├── Uses: OpenPdfFilesChannel, SettingsSingletonChannel
├── Uses: WindowBroadcast
└── Manages: Window creation and lifecycle

WindowBroadcast
├── Uses: desktop_multi_window
└── Handles: Inter-window communication
```
