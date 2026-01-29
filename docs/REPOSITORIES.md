# Repositories

Repository layer in the PDFSign project. Implements Clean Architecture pattern with abstract interfaces in Domain layer and concrete implementations in Data layer.

## Overview

```
lib/domain/repositories/           # Abstract interfaces
├── pdf_document_repository.dart
├── sidebar_image_repository.dart
├── recent_files_repository.dart
└── file_picker_repository.dart

lib/data/repositories/             # Implementations
├── pdf_document_repository_impl.dart
├── sidebar_image_repository_impl.dart
├── recent_files_repository_impl.dart
└── file_picker_repository_impl.dart
```

---

## PdfDocumentRepository

**Interface:** `lib/domain/repositories/pdf_document_repository.dart`
**Implementation:** `lib/data/repositories/pdf_document_repository_impl.dart`

Handles PDF document operations: opening, rendering, and lifecycle.

### Interface Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `openDocument` | `Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath)` | Opens PDF from path |
| `openProtectedDocument` | `Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(String filePath, String password)` | Opens password-protected PDF |
| `renderPage` | `Future<Either<Failure, Uint8List>> renderPage({required int pageNumber, required double scale})` | Renders page as PNG bytes |
| `cancelRender` | `void cancelRender(int pageNumber)` | Cancels pending render |
| `closeDocument` | `Future<void> closeDocument()` | Closes document and releases resources |

### Interface Properties

| Property | Type | Description |
|----------|------|-------------|
| `isDocumentLoaded` | `bool` | Whether a document is loaded |
| `currentDocument` | `PdfDocumentInfo?` | Current document info |

### Implementation Details

**Error Mapping:**

| Exception Contains | Failure Type |
|-------------------|--------------|
| `password`, `encrypted`, `protected` | `PasswordRequiredFailure` |
| `not found`, `No such file` | `FileNotFoundFailure` |
| `permission`, `access` | `FileAccessFailure` |
| `incorrect` (password) | `PasswordIncorrectFailure` |
| Render cancelled | `RenderCancelledFailure` |
| Other | `PdfLoadFailure` / `PdfRenderFailure` |

**Render Cancellation:**

The repository wraps the data source's render cancellation system, allowing renders to be cancelled when pages scroll out of view.

---

## SidebarImageRepository

**Interface:** `lib/domain/repositories/sidebar_image_repository.dart`
**Implementation:** `lib/data/repositories/sidebar_image_repository_impl.dart`

Handles sidebar image CRUD operations and real-time syncing between windows.

### Interface Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `getImages` | `Future<Either<Failure, List<SidebarImage>>> getImages()` | Gets all images sorted by order |
| `watchImages` | `Stream<List<SidebarImage>> watchImages()` | Real-time stream of images |
| `addImage` | `Future<Either<Failure, SidebarImage>> addImage({...})` | Adds new image |
| `removeImage` | `Future<Either<Failure, Unit>> removeImage(String id)` | Removes image by ID |
| `reorderImages` | `Future<Either<Failure, Unit>> reorderImages(List<String> orderedIds)` | Updates order |
| `clearAllImages` | `Future<Either<Failure, Unit>> clearAllImages()` | Clears all images |
| `cleanupInvalidImages` | `Future<Either<Failure, List<SidebarImage>>> cleanupInvalidImages()` | Removes entries for deleted files |
| `updateComment` | `Future<Either<Failure, Unit>> updateComment(String id, String? comment)` | Updates image comment |

### addImage Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `filePath` | `String` | Original file path |
| `fileName` | `String` | Display name |
| `width` | `int` | Image width in pixels |
| `height` | `int` | Image height in pixels |
| `fileSize` | `int` | File size in bytes |

### Implementation Details

**Image Storage Flow:**

1. `addImage()` receives original file path
2. Calls `ImageStorageService.copyImageToStorage()` to copy to app folder
3. Stores new path (in app storage) in Isar database
4. Returns entity with storage path, not original path

**Remove Flow:**

1. Gets image from Isar to find file path
2. Removes from Isar database
3. Deletes file from app storage via `ImageStorageService`

**Reorder Flow:**

1. Receives list of image IDs in new order
2. Creates map of `id -> newIndex`
3. Updates `orderIndex` for each image in Isar

**Multi-Window Sync:**

The `watchImages()` method returns an Isar stream that automatically emits when database changes. Since all windows share the same Isar instance, changes in one window are immediately visible in others.

---

## RecentFilesRepository

**Interface:** `lib/domain/repositories/recent_files_repository.dart`
**Implementation:** `lib/data/repositories/recent_files_repository_impl.dart`

Manages the list of recently opened PDF files.

### Interface Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `getRecentFiles` | `Future<Either<Failure, List<RecentFile>>> getRecentFiles()` | Gets recent files (max 12) |
| `addRecentFile` | `Future<Either<Failure, Unit>> addRecentFile(RecentFile file)` | Adds or updates entry |
| `removeRecentFile` | `Future<Either<Failure, Unit>> removeRecentFile(String path)` | Removes by path |
| `clearAllRecentFiles` | `Future<Either<Failure, Unit>> clearAllRecentFiles()` | Clears all entries |
| `cleanupInvalidFiles` | `Future<Either<Failure, List<RecentFile>>> cleanupInvalidFiles()` | Removes entries for deleted files |

### Implementation Details

**Thread Safety:**

Uses an async lock (`_AsyncLock`) to serialize read-modify-write operations:

```dart
static final _lock = _AsyncLock();

Future<Either<Failure, Unit>> addRecentFile(RecentFile file) async {
  return _lock.synchronized(() async {
    // Read current list
    // Modify (remove existing, add at top)
    // Write back
  });
}
```

**Operations Under Lock:**
- `addRecentFile` - read-modify-write
- `removeRecentFile` - read-modify-write
- `clearAllRecentFiles` - prevents race with add/remove
- `cleanupInvalidFiles` - read-modify-write

**Sorting:**

Files are sorted by `lastOpened` descending (most recent first).

**Max Files:**

Limited to `AppConstants.maxRecentFiles` (12 files).

**File Deduplication:**

When adding a file that already exists, the old entry is removed and a new one is added at the top (effectively moving it to most recent).

---

## FilePickerRepository

**Interface:** `lib/domain/repositories/file_picker_repository.dart`
**Implementation:** `lib/data/repositories/file_picker_repository_impl.dart`

Handles file picking operations via native file picker.

### Interface Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `pickPdfFile` | `Future<Either<Failure, String?>> pickPdfFile()` | Opens file picker, returns selected path |
| `fileExists` | `Future<Either<Failure, bool>> fileExists(String path)` | Checks if file exists |
| `getFileSize` | `Future<Either<Failure, int>> getFileSize(String path)` | Gets file size in bytes |

### Implementation Details

**Error Handling:**

| Exception Type | Failure Type |
|----------------|--------------|
| `PlatformException` | `FileAccessFailure` |
| Other | `UnknownFailure` |

**Return Values:**

- `pickPdfFile` returns `Right(null)` if user cancels
- `pickPdfFile` returns `Right(path)` if file selected
- `pickPdfFile` returns `Left(failure)` on error

---

## Repository Providers

**File:** `lib/presentation/providers/repository_providers.dart`

```dart
@riverpod
PdfDocumentRepository pdfDocumentRepository(ref) {
  final dataSource = ref.watch(pdfDataSourceProvider);
  return PdfDocumentRepositoryImpl(dataSource: dataSource);
}

@riverpod
SidebarImageRepository sidebarImageRepository(ref) {
  final dataSource = ref.watch(sidebarImageLocalDataSourceProvider);
  final storageService = ref.watch(imageStorageServiceProvider);
  return SidebarImageRepositoryImpl(dataSource, storageService);
}

@riverpod
RecentFilesRepository recentFilesRepository(ref) {
  final dataSource = ref.watch(recentFilesLocalDataSourceProvider);
  return RecentFilesRepositoryImpl(dataSource);
}

@riverpod
FilePickerRepository filePickerRepository(ref) {
  final dataSource = ref.watch(filePickerDataSourceProvider);
  return FilePickerRepositoryImpl(dataSource);
}
```

---

## Error Handling Pattern

All repositories use the `Either` type from dartz for error handling:

```dart
// In repository
Future<Either<Failure, T>> someMethod() async {
  try {
    final result = await _dataSource.operation();
    return Right(result);
  } catch (e) {
    return Left(StorageFailure(message: 'Failed: $e'));
  }
}

// In provider/use case
final result = await repository.someMethod();
result.fold(
  (failure) => throw Exception(failure.message),
  (data) => data,
);
```

---

## Dependency Graph

```
Domain Layer (Interfaces)
├── PdfDocumentRepository
├── SidebarImageRepository
├── RecentFilesRepository
└── FilePickerRepository

Data Layer (Implementations)
├── PdfDocumentRepositoryImpl
│   └── PdfDataSource
├── SidebarImageRepositoryImpl
│   ├── SidebarImageLocalDataSource (Isar)
│   └── ImageStorageService
├── RecentFilesRepositoryImpl
│   └── RecentFilesLocalDataSource (SharedPreferences)
└── FilePickerRepositoryImpl
    └── FilePickerDataSource (file_picker package)
```
