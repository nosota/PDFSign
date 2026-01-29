# Entities

Domain entities in the PDFSign project. All entities are immutable and use value equality via Equatable.

## Overview

```
lib/domain/entities/
├── pdf_document_info.dart  # PDF document metadata
├── pdf_page_info.dart      # Single page info
├── placed_image.dart       # Image placed on PDF page
├── sidebar_image.dart      # Image in sidebar library
├── recent_file.dart        # Recently opened file
└── window_info.dart        # Application window info
```

---

## PdfDocumentInfo

**File:** `lib/domain/entities/pdf_document_info.dart`

Information about a loaded PDF document.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `filePath` | `String` | Full path to the PDF file |
| `fileName` | `String` | File name extracted from path |
| `pageCount` | `int` | Total number of pages |
| `pages` | `List<PdfPageInfo>` | Info about each page |
| `isPasswordProtected` | `bool` | Whether document required password (default: `false`) |

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `copyWith` | `PdfDocumentInfo copyWith({...})` | Creates copy with modified fields |

### Usage

```dart
final docInfo = PdfDocumentInfo(
  filePath: '/path/to/document.pdf',
  fileName: 'document.pdf',
  pageCount: 10,
  pages: [...],
  isPasswordProtected: false,
);

// Access page dimensions
final firstPage = docInfo.pages[0];
final width = firstPage.width;
```

---

## PdfPageInfo

**File:** `lib/domain/entities/pdf_page_info.dart`

Information about a single PDF page.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `pageNumber` | `int` | 1-based page number |
| `width` | `double` | Original page width in points |
| `height` | `double` | Original page height in points |

### Computed Properties

| Property | Type | Description |
|----------|------|-------------|
| `aspectRatio` | `double` | Width divided by height |

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `copyWith` | `PdfPageInfo copyWith({...})` | Creates copy with modified fields |

### Notes

- Dimensions are in PDF points (1 point = 1/72 inch)
- Page number is 1-based (first page is 1, not 0)
- Supports mixed page sizes within same document

---

## PlacedImage

**File:** `lib/domain/entities/placed_image.dart`

Represents an image placed on a PDF page.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier (UUID) |
| `sourceImageId` | `String` | Reference to sidebar image ID |
| `imagePath` | `String` | Path to image file in app storage |
| `pageIndex` | `int` | 0-based page index where placed |
| `position` | `Offset` | Top-left position in PDF points |
| `size` | `Size` | Width and height in PDF points |
| `rotation` | `double` | Rotation angle in radians (default: `0`) |

### Computed Properties

| Property | Type | Description |
|----------|------|-------------|
| `bounds` | `Rect` | Bounding rectangle (before rotation) |
| `center` | `Offset` | Center point of the image |

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `copyWith` | `PlacedImage copyWith({...})` | Creates copy with modified fields |

### Units

- **Position and Size:** PDF points (1 point = 1/72 inch)
- **Rotation:** Radians (positive = clockwise)

### Usage

```dart
final placedImage = PlacedImage(
  id: uuid.v4(),
  sourceImageId: sidebarImage.id,
  imagePath: sidebarImage.filePath,
  pageIndex: 0,
  position: Offset(100, 100),
  size: Size(200, 150),
  rotation: 0,
);

// Move image
final moved = placedImage.copyWith(
  position: Offset(200, 200),
);

// Rotate image (45 degrees)
final rotated = placedImage.copyWith(
  rotation: 0.785398, // pi/4 radians
);
```

### Relationship to SidebarImage

- `sourceImageId` references the sidebar image used as source
- `imagePath` is copied from sidebar image (same file)
- Multiple PlacedImages can reference the same sourceImageId
- Deleting sidebar image does NOT automatically delete placed images

---

## SidebarImage

**File:** `lib/domain/entities/sidebar_image.dart`

Represents an image in the sidebar library panel.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier (UUID) |
| `filePath` | `String` | Path in app storage (not original path) |
| `fileName` | `String` | Original file name for display |
| `addedAt` | `DateTime` | When image was added |
| `orderIndex` | `int` | Position in sorted list (0-based) |
| `width` | `int` | Original image width in pixels |
| `height` | `int` | Original image height in pixels |
| `fileSize` | `int` | File size in bytes |
| `comment` | `String?` | Optional user comment |

### Computed Properties

| Property | Type | Description |
|----------|------|-------------|
| `aspectRatio` | `double` | Width divided by height |

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `copyWith` | `SidebarImage copyWith({..., bool clearComment})` | Creates copy with modified fields |

### Special copyWith Behavior

To clear the comment, use `clearComment: true`:

```dart
// Set comment
final withComment = image.copyWith(comment: 'My signature');

// Clear comment (set to null)
final noComment = image.copyWith(clearComment: true);
```

### Storage Path

Images are stored in app storage, not at their original location:

```
~/Library/Application Support/com.ivanvaganov.pdfsign/images/{uuid}.{ext}
```

### toString

```dart
'SidebarImage(id: $id, fileName: $fileName, orderIndex: $orderIndex)'
```

---

## RecentFile

**File:** `lib/domain/entities/recent_file.dart`

Represents a recently opened PDF file.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `path` | `String` | Full file system path to PDF |
| `fileName` | `String` | File name extracted from path |
| `lastOpened` | `DateTime` | When file was last opened |
| `pageCount` | `int` | Number of pages in PDF |
| `isPasswordProtected` | `bool` | Whether PDF requires password |

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `copyWith` | `RecentFile copyWith({...})` | Creates copy with modified fields |

### toString

```dart
'RecentFile(fileName: $fileName, lastOpened: $lastOpened)'
```

### Notes

- `pageCount` and `isPasswordProtected` are stored at time of opening
- If file is moved/deleted, the entry remains until cleanup
- `cleanupInvalidFiles()` in repository removes entries for deleted files

---

## WindowInfo

**File:** `lib/domain/entities/window_info.dart`

Information about an open application window. Used in Window menu.

### Enum: WindowType

```dart
enum WindowType {
  welcome,   // Main Welcome window (ID "0")
  pdf,       // PDF viewer window
  settings,  // Settings window
}
```

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `windowId` | `String` | Unique window ID from desktop_multi_window |
| `title` | `String` | Display title (filename for PDF, "Settings" for settings) |
| `type` | `WindowType` | Type of window |
| `isKey` | `bool` | Whether window is currently focused |
| `filePath` | `String?` | File path for PDF windows, null for others |

### Factory Constructor

```dart
factory WindowInfo.fromMap(Map<dynamic, dynamic> map)
```

Creates WindowInfo from native map data:

```dart
{
  'windowId': '123',
  'title': 'document.pdf',
  'type': 'pdf',      // 'welcome', 'pdf', or 'settings'
  'isKey': true,
  'filePath': '/path/to/document.pdf',
}
```

### Usage

```dart
// Get window list from native
final windows = await WindowListChannel.getWindowList();

for (final window in windows) {
  if (window.isKey) {
    // This is the focused window
    print('${window.title} is focused');
  }
}
```

---

## Data Models

Corresponding data models in `lib/data/models/`:

| Entity | Model | Storage |
|--------|-------|---------|
| `SidebarImage` | `SidebarImageModel` | Isar database |
| `RecentFile` | `RecentFileModel` | SharedPreferences (JSON) |

Models handle serialization and conversion to/from entities:

```dart
// In model
factory SidebarImageModel.fromEntity(SidebarImage entity)
SidebarImage toEntity()

// In repository
final models = await _localDataSource.getImages();
final entities = models.map((m) => m.toEntity()).toList();
```

---

## Equatable

All entities extend `Equatable` for value equality:

```dart
class SidebarImage extends Equatable {
  // ...

  @override
  List<Object?> get props => [
    id,
    filePath,
    fileName,
    addedAt,
    orderIndex,
    width,
    height,
    fileSize,
    comment,
  ];
}
```

This enables:
- Efficient state comparison in Riverpod
- Correct behavior in collections (Set, Map keys)
- Meaningful equality checks in tests
