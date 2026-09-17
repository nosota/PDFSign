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
├── window_info.dart        # Application window info
├── document_security.dart  # A document's protection, and what opened it
├── document_protection.dart      # Passwords and permissions to write
├── clipboard_placed_object.dart  # A placed object on the clipboard
└── clipboard_contents.dart       # What the clipboard holds for the editor
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
| `security` | `DocumentSecurity` | The document's protection and what it took to open it (default: `DocumentSecurity.unprotected()`) |
| `isPasswordProtected` | `bool` | Computed — `security.isProtected` |

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
| `aspectRatio` | `double` | Width divided by height; falls back to `1.0` when a dimension is zero, so an invalid row cannot produce NaN or infinity |

### Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `copyWith` | `PdfPageInfo copyWith({...})` | Creates copy with modified fields |

### Notes

- Dimensions are in PDF points (1 point = 1/72 inch)
- Page number is 1-based (first page is 1, not 0)
- Supports mixed page sizes within same document

---

### Rotation

| Field | Meaning |
|-------|---------|
| `width` / `height` | The page **as displayed**. A page the file marks `/Rotate 90` reports its sides swapped, so layout, drop placement and pasting never deal with rotation. |
| `rotation` | How the page stands now, in degrees clockwise. |
| `fileRotation` | What the file on disk has. |

`rotation - fileRotation` is the turn the reader made and has not saved. It is
also `pendingQuarterTurns`, which is how much the rendered bitmap still has to
be turned when it is drawn — the renderer works from the file, so turning a
page costs no re-render (ADR-0010).

`rotated(quarterTurns)` returns the page turned, with its sides swapped for an
odd number of turns. Four turns return the original value exactly.

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
| `lastUsedSize` | `Size?` | The size this image was last given on a page, in PDF points |

### Computed Properties

| Property | Type | Description |
|----------|------|-------------|
| `aspectRatio` | `double` | Width divided by height; falls back to `1.0` when a dimension is zero, so an invalid row cannot produce NaN or infinity |

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

---

## ClipboardPlacedObject

**File:** `lib/domain/entities/clipboard_placed_object.dart`

A placed object copied to the clipboard: `imagePath`, `size`, `position`,
`rotation` and an optional `sourceImageId`, plus a `version`.

### Notes

- `sourceImageId` is null for an image pasted from another application: it is
  stored with the document rather than in the library, so there is no row to
  point at.
- `position` is where it was copied from, so a paste into the same document can
  land beside the original instead of in the middle of the page.
- `imagePath` may no longer exist when the object is pasted — deleting a
  library row deletes its file (§13.1). The paste path falls back to the bitmap
  written alongside.
- **`fromJson` treats its input as hostile.** Any application can write bytes
  under our pasteboard type, so every field is checked and anything unexpected
  yields null rather than an exception or a half-built object.

---

## ClipboardContents

**File:** `lib/domain/entities/clipboard_contents.dart`

What a clipboard read found: an optional `ClipboardPlacedObject` and an
optional `ClipboardImage` (bytes plus `ClipboardImageFormat`). Both null means
the clipboard holds nothing the editor can use — text, files, or nothing at
all. That is `isEmpty`, not a failure.


---

## DocumentSecurity

**File:** `lib/domain/entities/document_security.dart`

What an open document's protection allows, and what it took to open it. Built
by `ProtectedPdfReader` when a document turns out to be encrypted; every other
document carries `DocumentSecurity.unprotected()`.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `isProtected` | `bool` | Whether the document is encrypted |
| `password` | `String?` | The password it was opened with; null for one that needed none |
| `allowsEditing` | `bool` | Whether its content may be changed — false opens the document read-only (FR-1.9) |
| `hasOwnerRights` | `bool` | Whether the password given was the owner's, which grants full access whatever the flags say |
| `current` | `DocumentProtection?` | The protection as far as it could be read — what the panel starts from |

### Computed Properties

| Property | Description |
|----------|-------------|
| `protectionNeedsOwnerPassword` | Whether changing this document's protection is somebody else's business — it withholds something or asks for a password to open, and was not opened with the owner's |

### Notes

- **`password` lives here and nowhere else.** For as long as the window does:
  never written to disk, never logged, never put in Recent Files, never
  broadcast to another window (FR-1.8).
- **`toString` deliberately omits it.** This object is reachable from the
  document info that gets interpolated into diagnostics, and a default
  `toString` would put the password in them.
- `current` is null for a document with no protection *and* for one whose
  protection could not be read back: the password that opens a document does
  not always reveal the other one. `protectionNeedsOwnerPassword` answers that
  case conservatively — nothing is known, so it asks.
- **Encrypted is not the same as protected.** A document may be encrypted,
  open without a password and withhold nothing; it restricts nobody, and it
  cannot be told apart from what removing protection leaves behind (§13.16).
  `protectionNeedsOwnerPassword` is false there, which is what keeps the app
  from asking for a password that may not exist.

---

## DocumentProtection

**File:** `lib/domain/entities/document_protection.dart`

The passwords and permissions a document is to be **written** with — what the
panel answers and what `PdfSaveService` applies (FR-6.9, ADR-0013).

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `userPassword` | `String` | Opens the document. Empty means anyone may read it |
| `ownerPassword` | `String` | Lifts every restriction. Required by any restriction at all |
| `permissions` | `Set<DocumentPermission>` | What is granted without the owner password. Unmodifiable |
| `algorithm` | `DocumentEncryption?` | Null means the writer chooses — AES-256 |

### Computed Properties

| Property | Description |
|----------|-------------|
| `requiresPasswordToOpen` | `userPassword` is not empty |
| `restrictsAnything` | Something is withheld |
| `isOpen` | Neither — what the lock in the toolbar reads to decide its face |

### Enums

`DocumentPermission`: `printing`, `copying`, `pageAssembly`, `annotations`,
`changingContent`, `formFilling`.

`DocumentEncryption`: `rc4x40`, `rc4x128`, `aes128`, `aes256`.

### Notes

- **The constructor closes the set over what one permission implies.**
  `changingContent` carries `annotations` and `formFilling` with it, because
  bit 4 of `/P` subsumes bits 6 and 9 — measured in Acrobat, which reports both
  as allowed whenever changing is. Two protections that differ only in bits the
  file cannot express are therefore equal, which is what keeps the document
  from reporting itself dirty over a difference nobody can see.
- `DocumentProtection.none()` is a document with no passwords and everything
  granted. What **Remove Protection** answers, and as close to unprotected as
  a written file can get (§13.16).
- **`toString` omits both passwords**, for the same reason `DocumentSecurity`
  does.
