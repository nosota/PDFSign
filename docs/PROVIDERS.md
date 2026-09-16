# Riverpod Providers

Complete documentation of all Riverpod providers in the PDFSign project.

## Overview

The project uses Riverpod for state management with code generation (`riverpod_annotation`). Providers are organized by feature area:

```
lib/presentation/providers/
├── pdf_viewer/         # PDF viewing state
├── editor/             # Image placement state
├── sidebar/            # Sidebar UI state
├── data_source_providers.dart
├── repository_providers.dart
└── shared_preferences_provider.dart
```

---

## PDF Viewer Providers

### PdfDocument

**File:** `lib/presentation/providers/pdf_viewer/pdf_document_provider.dart`

Core provider managing PDF document state and navigation.

```dart
@Riverpod(keepAlive: true)
class PdfDocument extends _$PdfDocument {
  @override
  PdfViewerState build() => const PdfViewerState.initial();
}
```

**State:** `PdfViewerState` (sealed class with states: initial, loading, loaded, error, passwordRequired)

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `openDocument` | `Future<void> openDocument(String filePath, {int? initialPage})` | Opens PDF from file path; `initialPage` (clamped to the valid range) restores a page position, used after Save As |
| `openProtectedDocument` | `Future<void> openProtectedDocument(String filePath, String password)` | Opens password-protected PDF |
| `closeDocument` | `Future<void> closeDocument()` | Closes current document |
| `reloadDocument` | `Future<int?> reloadDocument()` | Reloads document, preserves current page |
| `setScale` | `bool setScale(double newScale)` | Sets zoom scale, returns true if changed |
| `multiplyScale` | `void multiplyScale(double factor)` | Multiplies scale (pinch-to-zoom) |
| `fitToWidth` | `void fitToWidth()` | Sets zoom to fit-width mode |
| `zoomInStep` | `void zoomInStep()` | Zooms in to next preset level |
| `zoomOutStep` | `void zoomOutStep()` | Zooms out to previous preset level |
| `setCurrentPage` | `void setCurrentPage(int pageNumber)` | Sets page (1-based) |
| `nextPage` | `void nextPage()` | Goes to next page |
| `previousPage` | `void previousPage()` | Goes to previous page |
| `updateViewport` | `void updateViewport(double width, double height)` | Updates viewport dimensions |

**Dependencies:**
- `pdfDocumentRepositoryProvider`
- `pdfPageCacheProvider`

---

### PdfPageCache

**File:** `lib/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart`

LRU cache for rendered PDF pages.

```dart
@Riverpod(keepAlive: true)
PdfPageCache pdfPageCache(ref) => PdfPageCache(maxCacheSize: 10);
```

**Class Methods (PdfPageCache):**

| Method | Signature | Description |
|--------|-----------|-------------|
| `get` | `PageCacheEntry? get(int pageNumber, double scale)` | Gets cached page, updates LRU order |
| `put` | `void put(PageCacheEntry entry)` | Adds/updates cached page |
| `remove` | `void remove(int pageNumber, double scale)` | Removes specific page |
| `removeAllForPage` | `void removeAllForPage(int pageNumber)` | Removes all scales for a page |
| `clear` | `void clear()` | Clears all cached entries |
| `contains` | `bool contains(int pageNumber, double scale)` | Checks if page cached |
| `length` | `int get length` | Number of cached entries |

**Configuration:** Max 10 pages, scale quantized to 2 decimal places.

---

### PdfPageImage

**File:** `lib/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart`

FutureProvider for rendering individual PDF pages.

```dart
@riverpod
Future<Uint8List> pdfPageImage(ref, {
  required int pageNumber,
  required double scale,
})
```

**Returns:** `Uint8List` containing PNG bytes of rendered page.

**Throws:** `PageRenderCancelledException` if render was cancelled.

---

### VisiblePages

**File:** `lib/presentation/providers/pdf_viewer/pdf_page_cache_provider.dart`

Manages which pages should be rendered (lazy loading).

```dart
@riverpod
class VisiblePages extends _$VisiblePages {
  static const int _bufferSize = 2;

  @override
  Set<int> build() => {};
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `updateVisibleRange` | `void updateVisibleRange({required int firstVisible, required int lastVisible, required int totalPages})` | Updates visible page range with buffer. No-ops when the resulting set is unchanged — `PdfPageList` refreshes this from a post-frame callback, so assigning an equal `Set` would rebuild the list on every frame |
| `shouldRender` | `bool shouldRender(int pageNumber)` | Checks if page should be rendered |

**Buffer:** 2 pages beyond visible range.

---

### PermissionRetry

**File:** `lib/presentation/providers/pdf_viewer/permission_retry_provider.dart`

Flag for the folder-permission retry loop. While `true`, the viewer shows a "Waiting for folder access permission…" state instead of an error, so a `FileAccessFailure` does not surface as a hard failure while `EditorScreen` retries (20 attempts, 1.5 s apart).

```dart
final permissionRetryProvider = StateProvider<bool>((ref) => false);
```

---

## Editor Providers

### PlacedImages

**File:** `lib/presentation/providers/editor/placed_images_provider.dart`

Manages images placed on PDF pages.

```dart
@Riverpod(keepAlive: true)
class PlacedImages extends _$PlacedImages {
  @override
  List<PlacedImage> build() => [];
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `addImage` | `PlacedImage addImage({required String sourceImageId, required String imagePath, required int pageIndex, required Offset position, required Size size})` | Adds a new object and returns it, so the caller can select it without guessing which entry of the list is new |
| `removeImage` | `void removeImage(String id)` | Removes image by ID |
| `updateImage` | `void updateImage(PlacedImage updated)` | Updates existing image |
| `moveImage` | `void moveImage(String id, Offset newPosition)` | Moves image to new position |
| `resizeImage` | `void resizeImage(String id, Size newSize)` | Resizes image |
| `rotateImage` | `void rotateImage(String id, double newRotation)` | Rotates image |
| `transformImage` | `void transformImage(String id, {Offset? position, Size? size, double? rotation, int? pageIndex})` | Updates position, size, rotation together |
| `getImagesForPage` | `List<PlacedImage> getImagesForPage(int pageIndex)` | Gets images for specific page |
| `duplicateImage` | `PlacedImage? duplicateImage(String id, {Offset offset = const Offset(20, 20)})` | Creates duplicate |
| `clear` | `void clear()` | Clears all images |
| `hasImages` | `bool get hasImages` | True if any images placed |

---

### EditorSelection

**File:** `lib/presentation/providers/editor/editor_selection_provider.dart`

Single-selection state for placed images.

```dart
@riverpod
class EditorSelection extends _$EditorSelection {
  @override
  String? build() => null;
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `select` | `void select(String id)` | Selects image by ID |
| `clear` | `void clear()` | Clears selection |
| `toggle` | `void toggle(String id)` | Toggles selection |
| `isSelected` | `bool isSelected(String id)` | Checks if image is selected |

**Coordinating helper (same file, top-level function):**

```dart
void deleteSelectedImage(WidgetRef ref)
```

Deletes the selected object across three providers at once: removes it from `placedImagesProvider`, clears `editorSelectionProvider`, then marks `documentDirtyProvider` dirty — or **clean** if no objects remain, since the document is back to its original state. Called from the Delete/Backspace shortcut, the Edit → Delete menu item, and the native toolbar Delete button.

---

### DocumentDirty

**File:** `lib/presentation/providers/editor/document_dirty_provider.dart`

Whether the document has changes that are not in the file yet. **Derived, not
flagged** (ADR-0008): it compares the current objects with the baseline, so
move, resize and rotate count as changes, and moving an object back where it
was reports clean again.

```dart
@Riverpod(keepAlive: true)
bool documentDirty(DocumentDirtyRef ref) {
  return !listEquals(
    ref.watch(placedImagesProvider),
    ref.watch(savedPlacedImagesProvider),
  );
}
```

There is nothing to call: consumers just read or listen to the `bool`.

---

### SavedPlacedImages

**File:** `lib/presentation/providers/editor/document_dirty_provider.dart`

The objects as of the last write — the baseline `documentDirty` compares
against. The object-side counterpart of `OriginalPdfStorage`, which keeps the
file-side baseline.

```dart
@Riverpod(keepAlive: true)
class SavedPlacedImages extends _$SavedPlacedImages {
  @override
  List<PlacedImage> build() => const [];
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `markSaved` | `void markSaved(List<PlacedImage> current)` | Records the objects just written, which makes the document clean |
| `reset` | `void reset()` | Baseline of an empty page; used by Save As, which clears the objects |

Costs nothing to hold: `PlacedImages` replaces the whole list on every change
and `PlacedImage` is immutable, so the baseline is a reference to a list that is
never mutated, not a copy.

---

### GlobalDirtyState

**File:** `lib/presentation/providers/editor/global_dirty_state_provider.dart`

Tracks dirty state across all windows (for Save All).

```dart
@Riverpod(keepAlive: true)
class GlobalDirtyState extends _$GlobalDirtyState {
  @override
  Map<String, bool> build() => {};
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `updateWindowState` | `void updateWindowState(String windowId, bool isDirty)` | Updates dirty state for window |
| `removeWindow` | `void removeWindow(String windowId)` | Removes window from tracking |
| `clear` | `void clear()` | Clears all tracked windows |
| `hasAnyDirtyWindow` | `bool get hasAnyDirtyWindow` | True if any window has unsaved changes |
| `getWindowState` | `bool? getWindowState(String windowId)` | Gets dirty state for specific window |

---

### SizeUnitPreference

**File:** `lib/presentation/providers/editor/size_unit_preference_provider.dart`

User preference for size units (cm/inch).

```dart
final sizeUnitPreferenceProvider =
    NotifierProvider<SizeUnitPreferenceNotifier, SizeUnit>(...);
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `toggle` | `void toggle()` | Toggles between cm and inch, persists, broadcasts |
| `setUnit` | `void setUnit(SizeUnit unit)` | Sets unit directly, persists, broadcasts |
| `reload` | `Future<void> reload()` | Reloads from SharedPreferences |

**Persistence Key:** `'size_unit_preference'`

---

### OriginalPdfStorage

**File:** `lib/presentation/providers/editor/original_pdf_provider.dart`

Stores original PDF bytes for Save operations.

```dart
final originalPdfStorageProvider = Provider<OriginalPdfStorage>((ref) {
  final storage = OriginalPdfStorage();
  ref.onDispose(() => storage.dispose());
  return storage;
});
```

---

### PdfSaveService

**File:** `lib/presentation/providers/editor/pdf_save_service_provider.dart`

Provides the PDF writing service.

```dart
@riverpod
PdfSaveService pdfSaveService(PdfSaveServiceRef ref) => PdfSaveService();
```

> **Note:** `pdf_viewer_app.dart` instantiates `PdfSaveService()` directly instead of reading this provider. See REQUIREMENTS.md §13.2.

### PageJumpRequest

**File:** `lib/presentation/providers/pdf_viewer/page_jump_provider.dart`

```dart
ref.read(pageJumpRequestProvider.notifier).request(7);
```

Asks the viewer to bring a page into view. The Go to Page dialog is opened from
the View menu, which lives at the window root and cannot reach the page column
deep inside the tree; the root leaves a request here and `PdfViewer` picks it
up.

Each request carries a token, because the same page may be asked for twice in
a row and the viewer acts on a *change*: without it the second ask would
compare equal to the first and be ignored.

### rotateCurrentPage

**File:** `lib/presentation/providers/editor/rotate_page.dart`

```dart
rotateCurrentPage(ref, 1);   // a quarter turn clockwise
rotateCurrentPage(ref, -1);  // anticlockwise
```

Turns the page the viewer reports as current and the objects standing on it,
together. A top-level helper rather than a method on either notifier because it
has to move two pieces of state at once, and a provider writing into another
provider is what `CLAUDE.md` forbids.

Returns whether anything was turned, so a caller can stay quiet when no
document is open.

The page's own `rotation` versus `fileRotation` is what makes the document
dirty — `hasUnsavedPageRotationProvider` — so a turn cannot be closed away in
silence. After a save to the same file, `markRotationsSaved()` tells the pages
the file has caught up; after Save As the document reloads and reads the new
file's rotations itself.

### EditorClipboard

**File:** `lib/presentation/providers/editor/editor_clipboard.dart`

Not a provider — a coordinator over several, in the same shape as
`deleteSelectedImage(ref)` and `CloseAllCoordinator`. Cut, copy and paste for
objects placed on the document.

```dart
final outcome = await EditorClipboard(ref: ref).paste();
```

| Method | Does |
|--------|------|
| `copy()` | Puts the selected object on the system clipboard, with its pixels beside it |
| `cut()` | Copies, then removes the object — only if the copy succeeded |
| `paste()` | Puts the clipboard contents on the page currently in view |

Returns an `EditorClipboardOutcome` rather than showing anything itself; the
caller maps it to a localized message. `nothing` is silent by design — an empty
clipboard or no selection is an ordinary outcome.

**Dispatches on focus.** The Edit menu owns Cmd+X/C/V for the whole window
(§13.11), so each action first asks `textInputHasFocus()` and, when a text
field holds the keyboard, invokes `CopySelectionTextIntent` / `PasteTextIntent`
on it instead. Without that, typing a comment and pressing Cmd+C would copy the
selected object.

**Where a paste lands** is `PastePlanner`'s question
(`lib/presentation/providers/editor/paste_planner.dart`): the page the viewer
reports as current, at the copied position plus a cascade step, clamped onto the
page; an image from another application is stored with the document via
`PastedImageStorage`, then centred and sized like a drop — it is **not** added
to the library. The
two classes are split along that seam — `EditorClipboard` decides *whether* a
paste happens and who handles it, `PastePlanner` decides *what lands where*.
`PlacedImagePlacement` holds the shared geometry so dropping and pasting cannot
drift apart.

**Cross-window.** Nothing is broadcast: the system clipboard is already shared
between windows, and between applications.

---

## Sidebar Providers

### SidebarImages

**File:** `lib/presentation/providers/sidebar/sidebar_images_provider.dart`

Real-time stream of sidebar images with multi-window sync.

```dart
@riverpod
class SidebarImages extends _$SidebarImages {
  @override
  Stream<List<SidebarImage>> build() {
    final repository = ref.watch(sidebarImageRepositoryProvider);
    return repository.watchImages();
  }
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `addImages` | `Future<void> addImages(List<String> filePaths)` | Adds images from file paths |
| `removeImage` | `Future<void> removeImage(String id)` | Removes image by ID |
| `reorder` | `Future<void> reorder(int oldIndex, int newIndex)` | Reorders images after drag-and-drop |
| `clearAll` | `Future<void> clearAll()` | Clears all images |
| `updateComment` | `Future<void> updateComment(String id, String? comment)` | Updates image comment |

**Multi-Window Sync:** Real-time via Isar's `watchImages()`.

---

### SidebarSelection

**File:** `lib/presentation/providers/sidebar/sidebar_selection_provider.dart`

Selection state for sidebar images.

```dart
@riverpod
class SidebarSelection extends _$SidebarSelection {
  @override
  String? build() => null;
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `select` | `void select(String imageId)` | Selects image by ID |
| `clear` | `void clear()` | Clears selection |
| `toggle` | `void toggle(String imageId)` | Toggles selection |

---

### SidebarWidth

**File:** `lib/presentation/providers/sidebar/sidebar_width_provider.dart`

Sidebar panel width state.

```dart
@riverpod
class SidebarWidth extends _$SidebarWidth {
  @override
  double build() => SidebarConstants.defaultWidth;
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `setWidth` | `void setWidth(double width)` | Sets width (clamped to min/max) |
| `adjustWidth` | `void adjustWidth(double delta)` | Adjusts width by delta |
| `reset` | `void reset()` | Resets to default width |

---

## Preference Providers

### LocalePreference

**File:** `lib/presentation/providers/locale_preference_provider.dart`

User language preference.

```dart
final localePreferenceProvider =
    NotifierProvider<LocalePreferenceNotifier, String?>(...);
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `setLocale` | `void setLocale(String? localeCode)` | Sets locale or null for system default |
| `reload` | `Future<void> reload()` | Reloads from SharedPreferences |
| `getLocale` | `Locale? getLocale()` | Returns Locale object to use |

**Persistence Key:** `'locale_preference'`

**Supported:** 58 locales in `supportedLocales`, including RTL (Arabic, Hebrew, Persian). `allSupportedLocales` is derived from that list and passed to `MaterialApp.supportedLocales`.

> **Known defect:** `lib/l10n/` contains 66 `.arb` files. `ja`, `ko`, and `zh` are translated and code-generated but are **absent from `supportedLocales`**, so they are neither selectable in Settings nor resolvable from the system locale. See REQUIREMENTS.md §13.5.

---

### LastOpenDirectory

**File:** `lib/presentation/providers/last_open_directory_provider.dart`

Remembers the directory of the last opened PDF so the file picker reopens there.

```dart
final lastOpenDirectoryProvider =
    NotifierProvider<LastOpenDirectoryNotifier, String?>(...);
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `getDirectoryForPicker` | `Future<String> getDirectoryForPicker()` | Returns the saved directory if it still exists, otherwise `~/Documents` |
| `saveFromFilePath` | `void saveFromFilePath(String filePath)` | Stores the parent directory of the given file |

**Persistence Key:** `'last_open_directory'`

---

## File Operation Providers

### PdfFilePicker

**File:** `lib/presentation/providers/file_picker_provider.dart`

File picker operations.

```dart
@riverpod
class PdfFilePicker extends _$PdfFilePicker {
  @override
  String? build() => null;
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `pickPdf` | `Future<String?> pickPdf()` | Opens the picker in the last used directory (see `lastOpenDirectoryProvider`), returns the selected path and remembers its directory |
| `fileExists` | `Future<bool> fileExists(String path)` | Checks if file exists |
| `clear` | `void clear()` | Clears selected file state |

---

### RecentFiles

**File:** `lib/presentation/providers/recent_files_provider.dart`

Recent files list with async loading.

```dart
@Riverpod(keepAlive: true)
class RecentFiles extends _$RecentFiles {
  @override
  Future<List<RecentFile>> build() async {
    final repository = ref.watch(recentFilesRepositoryProvider);
    final result = await repository.getRecentFiles();
    return result.fold((failure) => throw Exception(failure.message), (files) => files);
  }
}
```

**Public Methods:**

| Method | Signature | Description |
|--------|-----------|-------------|
| `addFile` | `Future<void> addFile(RecentFile file)` | Adds file to recent files |
| `removeFile` | `Future<void> removeFile(String path)` | Removes file by path |
| `clearAll` | `Future<void> clearAll()` | Clears all recent files |

---

## Infrastructure Providers

### SharedPreferences

**File:** `lib/presentation/providers/shared_preferences_provider.dart`

```dart
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must override in main()');
});
```

**Must override** in `main()` with pre-initialized instance.

---

### Isar Database

**File:** `lib/presentation/providers/data_source_providers.dart`

```dart
@Riverpod(keepAlive: true)
Isar isar(ref) {
  throw UnimplementedError('Must override in main()');
}
```

**Must override** in `main()` with pre-initialized Isar instance.

---

### ImageStorageService

**File:** `lib/presentation/providers/repository_providers.dart`

Provides the service that copies imported images into app storage (ADR-0001).

```dart
@Riverpod(keepAlive: true)
ImageStorageService imageStorageService(ImageStorageServiceRef ref) =>
    ImageStorageService();
```

Consumed by `sidebarImageRepositoryProvider`.

---

## Dependency Graph

```
SharedPreferencesProvider ─┬─► SizeUnitPreferenceProvider
                           ├─► LocalePreferenceProvider
                           ├─► LastOpenDirectoryProvider
                           │    └─► PdfFilePickerProvider
                           └─► RecentFilesLocalDataSourceProvider
                                └─► RecentFilesRepositoryProvider
                                    └─► RecentFilesProvider

IsarProvider ─► SidebarImageLocalDataSourceProvider ─┐
                                                     ├─► SidebarImageRepositoryProvider
ImageStorageServiceProvider ─────────────────────────┘        └─► SidebarImagesProvider

FilePickerDataSourceProvider ─► FilePickerRepositoryProvider ─► PdfFilePickerProvider

PdfDataSourceProvider ─► PdfDocumentRepositoryProvider
                         ├─► PdfDocumentProvider
                         │   └─► PdfPageCacheProvider
                         ├─► PdfPageImageProvider
                         └─► VisiblePagesProvider

Independent Providers:
├── EditorSelection
├── PlacedImages
├── SidebarSelection
├── SidebarWidth
├── DocumentDirty
├── GlobalDirtyState
├── OriginalPdfStorage
├── PdfSaveService
└── PermissionRetry
```

---

## Key Patterns

1. **`keepAlive: true`** — For providers that persist across app lifecycle
2. **StreamNotifier** — SidebarImages for real-time multi-window sync
3. **WindowBroadcast** — SizeUnitPreference, LocalePreference for cross-window updates
4. **Either pattern** — Result handling with `fold()` for error cases
5. **LRU Caching** — PdfPageCache with automatic eviction
6. **State Immutability** — All states use `copyWith()` for updates
