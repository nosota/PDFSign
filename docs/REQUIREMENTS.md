# PDFSign - Requirements Specification

**Version:** 1.0
**Date:** 2025-11-29
**Status:** Final Draft

---

## 1. Project Overview

### 1.1 Project Name
**PDFSign**

### 1.2 Description
A cross-platform (Desktop and Mobile) Flutter application designed to add signature and stamp images to PDF documents. The application preserves the original PDF structure, including text layers, hyperlinks, interactive forms, and metadata.

### 1.3 Package Information
- **Package Name:** `com.nosota.pdfsign`
- **Display Name:** PDFSign
- **Type:** Non-commercial, personal use
- **License:** Community (Syncfusion Community License eligible - revenue < $1M)

---

## 2. Scope and Objectives

### 2.1 In Scope
- PDF document viewing with continuous scrolling
- Signature and stamp library management
- Drag-and-drop placement of signatures/stamps on PDF
- Transform operations (move, rotate, scale) on placed objects
- Z-order management for overlapping objects
- Undo/Redo functionality (50 levels)
- Export modified PDF preserving original structure
- Cross-platform support (iOS, Android, Windows, macOS, Linux)
- Localization (English, Russian)
- Password-protected PDF support

### 2.2 Out of Scope (Phase 1)
- Drawing signatures directly in app
- Cloud synchronization
- User authentication
- Multiple document tabs
- Batch processing
- OCR functionality
- Form filling
- Digital signature certificates (X.509)

---

## 3. User Roles and Personas

### 3.1 Primary User
**Persona:** Document Manager
**Description:** Individual who needs to quickly add signatures and stamps to PDF documents for personal or business use.
**Technical Level:** Basic to Intermediate
**Goals:**
- Quickly add multiple signatures/stamps to documents
- Maintain document quality and structure
- Organize signature/stamp library efficiently

---

## 4. Functional Requirements

### 4.1 PDF Document Management

#### FR-1.1: Open PDF Document
- **Desktop:** Welcome screen with "Open PDF" button + recent files list (last 10)
- **Mobile:** Splash screen with "Select PDF" button
- **Supported formats:** PDF (all versions)
- **File size limit:** No limit (performance may vary)
- **Platform file picker:** Native file picker for each platform

#### FR-1.2: Password-Protected PDF
- Display password input dialog when opening protected PDF
- Allow 3 password attempts
- Return to file picker on failed attempts
- Display error message for write-protected PDFs

#### FR-1.3: Save Document
- **Save (Desktop: Ctrl+S, Mobile: N/A):** Overwrite original file without confirmation
- **Save As (Desktop: Ctrl+Shift+S):** Native file picker for destination selection
- **Format:** PDF with preserved structure (text, links, forms, metadata)

#### FR-1.4: Close Document
- Return to welcome/splash screen
- Clear undo/redo history
- Prompt to save if unsaved changes exist

### 4.2 PDF Viewing

#### FR-2.1: Continuous Page Scrolling
- Display PDF pages in continuous vertical layout
- Show end of one page and beginning of next simultaneously
- Smooth scrolling with mouse wheel, trackpad, or touch gestures

#### FR-2.2: Zoom Controls
- **Desktop Toolbar:**
  - Zoom In button
  - Zoom Out button
  - Zoom percentage display (editable dropdown: 50%, 75%, 100%, 125%, 150%, 200%)
  - Actual Size (100%)
  - Fit to Screen
- **Keyboard Shortcuts:**
  - Zoom In: Ctrl/Cmd + Plus
  - Zoom Out: Ctrl/Cmd + Minus
  - Actual Size: Ctrl/Cmd + 0
  - Fit to Screen: Ctrl/Cmd + 1
- **Gestures:**
  - Pinch to zoom (mobile, trackpad)
  - Ctrl/Cmd + Mouse wheel (desktop)
- **Range:** 10% to 500%

#### FR-2.3: Navigation
- Vertical scrollbar (always visible)
- Page indicator (e.g., "Page 3 of 15")
- Keyboard navigation: Page Up/Down, Home, End

### 4.3 Signature and Stamp Library

#### FR-3.1: Library Structure
- Two tabs: "Signatures" and "Stamps"
- Each tab contains independent collections
- Items displayed as cards with:
  - Image preview
  - Text label (always visible, below image)
  - Drag handle for reordering

#### FR-3.2: Add Signature/Stamp
- **Desktop:**
  - "Add" button at bottom of panel
  - Click → native file picker
- **Mobile:**
  - FAB with "+" icon
  - Tap → file picker
- **Supported formats:** PNG, JPG, JPEG, TIFF, WEBP, SVG
- **File size limit:** 100MB
- **Resolution limit:** 4096 x 4096 pixels
- **Error handling:** Display error dialog if limits exceeded

#### FR-3.3: Edit Signature/Stamp
- Edit text label by clicking on it (inline editing)
- Auto-save on blur or Enter key

#### FR-3.4: Delete Signature/Stamp
- Right-click → Delete (desktop)
- Long press → Delete (mobile)
- Confirmation dialog
- Does not affect already placed instances in documents

#### FR-3.5: Reorder Items
- Drag-and-drop to reorder within same tab
- Visual feedback during drag (placeholder)
- Affects display order only (not z-index)
- Persists across sessions

### 4.4 Object Placement

#### FR-4.1: Drag-and-Drop (Desktop)
- Drag signature/stamp from panel to PDF canvas
- Show semi-transparent preview ("ghost") during drag
- Drop to place at cursor position
- Cursor changes to indicate valid drop zone

#### FR-4.2: Tap-to-Place (Mobile)
- Tap item in bottom sheet
- Bottom sheet closes
- Object appears in center of visible area
- Automatically enters edit mode with handles visible

#### FR-4.3: Initial Placement
- Default size: Maintain aspect ratio, fit within 200x200 logical pixels
- Default rotation: 0°
- Z-index: Top-most (above all existing objects)

### 4.5 Object Transformation

#### FR-5.1: Selection
- **Desktop:** Click on placed object
- **Mobile:** Tap on placed object
- **Visual feedback:**
  - Blue selection box (#0066FF, 2px stroke)
  - 8 white handles with blue border (4 corners + 4 sides)
  - 1 rotation handle (above center, circular)
- **Deselection:** Click/tap on empty area

#### FR-5.2: Move
- **Desktop:** Click and drag object
- **Mobile:** Touch and drag object
- **Constraint:** Object stays within page boundaries
- **Visual feedback:** Real-time position update

#### FR-5.3: Scale
- **Desktop:** Drag corner or side handles
  - Corner handles: Free scaling (no aspect ratio lock)
  - Side handles: Scale along one axis
  - No modifier keys required
- **Mobile:** Pinch gesture on selected object
- **Minimum size:** 20x20 logical pixels
- **Maximum size:** Page dimensions

#### FR-5.4: Rotate
- **Desktop:**
  - Drag rotation handle (circular motion)
  - Display angle indicator during rotation
- **Mobile:**
  - Two-finger rotation gesture on selected object
  - Display angle indicator
- **Range:** 0° to 360° (continuous)
- **Visual feedback:** Real-time rotation

#### FR-5.5: Context Menu Operations
**Desktop:** Right-click on selected object
**Mobile:** Long press on selected object

**Menu items:**
- Rotate 5° Left (Ctrl+Alt+Left)
- Rotate 5° Right (Ctrl+Alt+Right)
- Rotate 90° (Ctrl+R)
- Scale +5% (Ctrl+Alt+Plus)
- Scale -5% (Ctrl+Alt+Minus)
- ———————————— (separator)
- Bring to Front (Ctrl+Shift+])
- Bring Forward (Ctrl+])
- Send Backward (Ctrl+[)
- Send to Back (Ctrl+Shift+[)
- ———————————— (separator)
- Delete (Del)

#### FR-5.6: Toolbar Operations (Desktop)
Toolbar appears when object is selected:
- [↻ 5°] [↺ 5°] [⤸ 90°] - Rotation
- [➕ 5%] [➖ 5%] - Scale
- [⬆⬆] [⬆] [⬇] [⬇⬇] - Z-order
- [🗑 Delete] - Delete

#### FR-5.7: Floating Toolbar (Mobile)
Floating toolbar appears above selected object:
- [↻] [↺] [⤸] - Rotation
- [➕] [➖] - Scale
- [↑] [↓] - Z-order (bring forward/send backward)
- [🗑] - Delete

### 4.6 Z-Order Management

#### FR-6.1: Z-Index Rules
- Each placed object has a z-index (integer)
- Higher z-index renders on top
- Initial z-index: max(existing) + 1
- Minimum z-index: 0

#### FR-6.2: Z-Order Commands
- **Bring to Front:** Set z-index to max(all) + 1
- **Send to Back:** Set z-index to 0, increment all others
- **Bring Forward:** Swap z-index with next higher object
- **Send Backward:** Swap z-index with next lower object

### 4.7 Undo/Redo

#### FR-7.1: History Management
- Track all reversible operations:
  - Place object
  - Move object
  - Scale object
  - Rotate object
  - Delete object
  - Z-order change
  - Add signature/stamp to library
  - Delete signature/stamp from library
- **History depth:** 50 operations
- **Reset:** Clear history on opening new PDF

#### FR-7.2: Undo/Redo Controls
- **Desktop:**
  - Toolbar buttons: [↶ Undo] [↷ Redo]
  - Keyboard: Ctrl/Cmd+Z (undo), Ctrl/Cmd+Shift+Z (redo)
  - Menu: Edit → Undo / Redo
- **Mobile:**
  - Floating action buttons (when applicable)
- **State:**
  - Disabled when no operations to undo/redo
  - Show tooltip with operation name on hover

### 4.8 Clipboard Operations (NEW)

#### FR-8.1: Copy to Clipboard (Ctrl+C)
- **Action:** Copy selected object's image to system clipboard
- **Format:** PNG with transparency
- **Desktop:** Ctrl/Cmd+C keyboard shortcut
- **Mobile:** Context menu or floating toolbar option
- **Behavior:**
  - Only works when an object is selected
  - Copies the signature/stamp image (not the placed instance)
  - Maintains original resolution
  - Shows toast notification "Copied to clipboard"

#### FR-8.2: Paste from Clipboard (Ctrl+V)
- **Action:** Paste image from clipboard to PDF and optionally add to library
- **Desktop:** Ctrl/Cmd+V keyboard shortcut
- **Mobile:** Long press → Paste option (if clipboard contains image)
- **Behavior:**
  1. Check if clipboard contains image data
  2. If yes, show "Paste Image" dialog:
     - Preview of the image
     - Text input for name/label
     - Radio buttons: "Add to Signatures" / "Add to Stamps" / "Don't add to library"
     - Checkbox: "Don't ask again, always add to [selected option]"
  3. Place image at center of visible viewport
  4. If "add to library" selected, add to appropriate tab
  5. If "Don't ask again" checked:
     - Save preference to SharedPreferences
     - Future pastes automatically use saved preference
     - No dialog shown (silent paste)
- **Supported formats:** PNG, JPG, WEBP (clipboard formats)
- **Error handling:**
  - If clipboard empty: Show toast "Clipboard is empty"
  - If format unsupported: Show toast "Unsupported image format"
  - If size exceeds limit: Show error dialog

#### FR-8.3: Paste Preferences Management
- **Settings location:** Settings screen → "Clipboard Behavior"
- **Options:**
  - Reset "Don't ask again" preference
  - Change default paste target (Signatures/Stamps)
- **Preference keys:**
  - `dont_ask_paste_again` (boolean)
  - `paste_default_tab` (0 = signatures, 1 = stamps, null = always ask)

### 4.9 Object Duplication (NEW)

#### FR-9.1: Duplicate Object (Ctrl+D)
- **Action:** Create a copy of the selected object
- **Keyboard shortcut:** Ctrl/Cmd+D
- **Behavior:**
  - Only works when an object is selected
  - Creates exact copy with same:
    - Size
    - Rotation
    - Signature/stamp reference
  - Offset position:
    - X: +20 logical pixels
    - Y: +20 logical pixels
  - Z-index: max(all) + 1 (on top)
  - Automatically select the duplicate
  - Add to undo stack
- **Mobile:** Available via floating toolbar or context menu
- **Visual feedback:** Duplicate appears with selection handles

#### FR-9.2: Context Menu Updates
Add new menu items:
- **Copy Image (Ctrl+C)**
- **Duplicate (Ctrl+D)**
- Separator
- *(existing rotate/scale options)*

#### FR-9.3: Toolbar Updates (Desktop)
Add new buttons:
- **[📋 Copy]** - Copy to clipboard
- **[📄 Duplicate]** - Duplicate object

---

## 5. Technical Requirements

### 5.1 Architecture

#### TR-1.1: Clean Architecture
**Mandatory layer structure:**
```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
├── presentation/
│   ├── blocs/
│   ├── screens/
│   └── widgets/
└── injection/
```

#### TR-1.2: State Management
- **Pattern:** Riverpod (flutter_riverpod ^2.5.1+)
- **Rules:**
  - Use `@riverpod` annotation for code generation
  - StateNotifier for complex state with multiple mutations
  - AsyncNotifier for async state loading
  - Simple StateProvider for UI state (zoom, selected tab, etc.)
  - Use Equatable for value equality
  - Use freezed for complex state classes
  - Provider scope: Application-wide via ProviderScope in main
- **Key Providers:**
  - `signaturesProvider` - Signature library management
  - `stampsProvider` - Stamp library management
  - `editorProvider` - Placed objects and transformations
  - `undoRedoProvider` - Command pattern for undo/redo
  - `pdfDocumentProvider` - PDF viewer state
  - `zoomLevelProvider` - Current zoom level
  - `settingsProvider` - App settings and preferences

#### TR-1.3: Dependency Injection
- **Built-in:** Riverpod providers handle DI automatically
- **Pattern:** Define dependencies as providers with `@riverpod` annotation
- **Scope:**
  - Repositories: Singleton via provider caching
  - Use cases: Accessed through repositories (no explicit DI needed)
  - Data sources: Singleton providers
- **Example:**
  ```dart
  @riverpod
  SignatureRepository signatureRepository(SignatureRepositoryRef ref) {
    final dataSource = ref.watch(signatureDataSourceProvider);
    return SignatureRepositoryImpl(dataSource);
  }
  ```

#### TR-1.4: Routing
- **Package:** go_router ^14.0.0
- **Routes:**
  - `/` - Welcome/Splash screen
  - `/editor` - PDF editor screen
- **Type-safe navigation:** Use code generation

### 5.2 Core Dependencies

```yaml
dependencies:
  # Flutter SDK
  flutter:
    sdk: flutter

  # State Management (Riverpod)
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  equatable: ^2.0.0
  freezed_annotation: ^2.4.0

  # Navigation
  go_router: ^14.0.0

  # PDF Processing
  syncfusion_flutter_pdf: ^27.1.48
  syncfusion_flutter_pdfviewer: ^27.1.48

  # Storage
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  path_provider: ^2.1.0

  # File Handling
  file_picker: ^8.0.0
  mime: ^1.0.0

  # Utilities
  dartz: ^0.10.1
  uuid: ^4.0.0

  # Localization
  intl: ^0.19.0
  flutter_localizations:
    sdk: flutter

dev_dependencies:
  # Linting
  flutter_lints: ^3.0.0

  # Code Generation
  build_runner: ^2.4.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  riverpod_generator: ^2.4.3
  isar_generator: ^3.1.0

  # Testing
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  mocktail: ^1.0.4
```

### 5.3 Platform Requirements

#### TR-3.1: Minimum Versions
- **iOS:** 13.0
- **Android:** API 24 (Android 7.0)
- **macOS:** 10.15
- **Windows:** Windows 10 (1809)+
- **Linux:** Ubuntu 20.04+

#### TR-3.2: Flutter/Dart Versions
- **Flutter SDK:** 3.24.0+ (stable)
- **Dart SDK:** 3.5.0+

### 5.4 Data Models

#### TR-4.1: SignatureItem Entity
```dart
@collection
class SignatureItem {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;              // UUID for app-level identification

  late String name;              // User-provided label

  @Enumerated(EnumType.name)
  late SignatureType type;       // signature | stamp

  late List<byte> imageData;     // Binary image data

  @Index()
  late int order;                // Display order in list

  late DateTime createdAt;

  late String originalFileName;

  late String mimeType;          // image/png, image/jpeg, etc.
}

enum SignatureType {
  signature,
  stamp,
}
```

#### TR-4.2: PlacedObject Entity
```dart
class PlacedObject {
  final String id;               // UUID
  final String signatureId;      // Reference to SignatureItem
  final int pageNumber;          // 0-indexed
  final Offset position;         // Top-left corner (PDF coordinates)
  final Size size;               // Width and height
  final double rotation;         // Degrees (0-360)
  final int zIndex;              // Layering order
  final DateTime placedAt;
}
```

#### TR-4.3: RecentFile Model
```dart
class RecentFile {
  final String path;
  final String fileName;
  final DateTime lastOpened;
  final int pageCount;
  final bool isPasswordProtected;
}
```

### 5.5 Error Handling

#### TR-5.1: Failure Types
```dart
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
}

class FileNotFoundFailure extends Failure {}
class FileAccessFailure extends Failure {}
class InvalidFileFormatFailure extends Failure {}
class FileSizeLimitFailure extends Failure {}
class PasswordRequiredFailure extends Failure {}
class PasswordIncorrectFailure extends Failure {}
class WriteProtectedFailure extends Failure {}
class StorageFailure extends Failure {}
class UnknownFailure extends Failure {}
```

#### TR-5.2: Result Pattern
Use `Either<Failure, Success>` from dartz package for all use cases.

---

## 6. UI/UX Specifications

### 6.1 Design System

#### UI-1.1: Color Palette
**Light Theme (Primary):**
```dart
// Background
backgroundColor: Color(0xFFFFFFFF)
surfaceColor: Color(0xFFF5F5F7)
borderColor: Color(0xFFE5E5E7)

// Text
textPrimary: Color(0xFF1A1A1A)
textSecondary: Color(0xFF6B6B6B)
textDisabled: Color(0xFFB0B0B0)

// Accent
primaryColor: Color(0xFF0066FF)
primaryHover: Color(0xFF0052CC)
primaryPressed: Color(0xFF003D99)

// Semantic
errorColor: Color(0xFFDC3545)
successColor: Color(0xFF28A745)
warningColor: Color(0xFFFFC107)

// Selection
selectionColor: Color(0xFF0066FF)
selectionHandleColor: Color(0xFFFFFFFF)
selectionHandleBorder: Color(0xFF0066FF)

// Hover
hoverColor: Color(0x0A0066FF) // 4% opacity
```

#### UI-1.2: Typography
```dart
// Using default Flutter font (Roboto/SF Pro)
displayLarge: 32px, weight: 700
displayMedium: 24px, weight: 700
displaySmall: 20px, weight: 600

bodyLarge: 16px, weight: 400
bodyMedium: 14px, weight: 400
bodySmall: 12px, weight: 400

labelLarge: 14px, weight: 500
labelMedium: 12px, weight: 500
labelSmall: 10px, weight: 500
```

#### UI-1.3: Spacing
**Base unit:** 8px
```dart
spacing4: 4px
spacing8: 8px
spacing12: 12px
spacing16: 16px
spacing24: 24px
spacing32: 32px
spacing48: 48px
spacing64: 64px
```

#### UI-1.4: Border Radius
```dart
radiusSmall: 4px   // inputs, small buttons
radiusMedium: 6px  // buttons, chips
radiusLarge: 8px   // cards, panels
radiusXLarge: 12px // dialogs, bottom sheets
```

#### UI-1.5: Shadows
```dart
shadowSubtle: BoxShadow(
  color: Color(0x0A000000), // 4% black
  offset: Offset(0, 2),
  blurRadius: 8,
)

shadowMedium: BoxShadow(
  color: Color(0x14000000), // 8% black
  offset: Offset(0, 4),
  blurRadius: 16,
)

shadowLarge: BoxShadow(
  color: Color(0x1F000000), // 12% black
  offset: Offset(0, 8),
  blurRadius: 24,
)
```

#### UI-1.6: Icons
- **Style:** Outline (Lucide Icons or Heroicons style)
- **Sizes:** 16px, 20px, 24px, 32px
- **Stroke width:** 2px

### 6.2 Desktop Layout

#### UI-2.1: Welcome Screen
```
┌──────────────────────────────────────────────────────┐
│  File  Edit  View  Help                              │
├──────────────────────────────────────────────────────┤
│                                                       │
│                    [PDFSign Logo]                     │
│                                                       │
│               ┌─────────────────────┐                │
│               │   📄 Open PDF       │                │
│               └─────────────────────┘                │
│                                                       │
│                  Recent Files                        │
│               ┌─────────────────────┐                │
│               │ 📄 Document1.pdf    │                │
│               │    Opened 2h ago    │                │
│               ├─────────────────────┤                │
│               │ 📄 Contract.pdf     │                │
│               │    Opened yesterday │                │
│               └─────────────────────┘                │
│                                                       │
└──────────────────────────────────────────────────────┘
```

#### UI-2.2: Editor Screen (Desktop)
```
┌────────────────────────────────────────────────────────┐
│ File  Edit  View                                       │
│ [↶][↷] [🔍-][100%▾][🔍+][⊡]                          │
├──────────────────────────────────┬─────────────────────┤
│                                  │┃                    │
│                                  │┃  ┌──────────────┐  │
│                                  │┃  │🖊 Подписи    │  │
│         PDF Canvas               │┃  │  📄 Печати   │  │
│                                  │┃  └──────────────┘  │
│      [Rendered PDF Pages]        │┃                    │
│                                  │┃  ┌──────────────┐  │
│   [Placed Objects with Handles]  │┃  │  [Preview]   │  │
│                                  │┃  │  Подпись 1   │  │
│                                  │┃  └──────────────┘  │
│                                  │┃                    │
│                                  │┃  ┌──────────────┐  │
│                                  │┃  │  [Preview]   │  │
│                                  │┃  │  Подпись 2   │  │
│                                  │┃  └──────────────┘  │
│                                  │┃                    │
│                                  │┃  [+ Добавить]      │
│                                  │┃                    │
│ Page 2 of 15                     │┃                    │
└──────────────────────────────────┴─────────────────────┘
          │┃│ ← Resizable divider
```

**Toolbar Details:**
- **Top Toolbar Height:** 48px
- **Menu bar:** Standard native menu bar (macOS/Windows/Linux)
- **Undo/Redo:** Icon buttons, 32x32, 8px margin
- **Zoom Controls:**
  - Zoom out: Icon button
  - Percentage: Dropdown, 80px width
  - Zoom in: Icon button
  - Fit to screen: Icon button

**Right Panel:**
- **Initial width:** 280px
- **Min width:** 200px
- **Max width:** 400px
- **Resizable:** Drag divider
- **Tabs:** Horizontal tabs at top, 48px height
- **Card spacing:** 16px vertical gap
- **Card padding:** 12px
- **Preview image:**
  - Width: panel_width - 32px
  - Max height: 150px
  - Aspect ratio: maintain original
- **Label:** Below image, 14px font, centered, 2 lines max with ellipsis
- **Add button:** Fixed at bottom, full width minus 16px margin

#### UI-2.3: Selection Handles (Desktop)
```
       ⟳ (rotate handle, 24px circle)
       │
   ┌───┼───┐
   ◻───▭───◻  ← Corner handles: 12x12px white squares, 2px blue border
   │       │     Side handles: 12x8px white rectangles, 2px blue border
   ▭       ▭
   │       │
   ◻───▭───◻
   └───────┘

   Selection box: 2px solid #0066FF
```

### 6.3 Mobile Layout

#### UI-3.1: Splash Screen (Mobile)
```
┌─────────────────────┐
│                     │
│                     │
│   [PDFSign Logo]    │
│                     │
│                     │
│  ┌───────────────┐  │
│  │ 📄 Select PDF │  │
│  └───────────────┘  │
│                     │
│                     │
└─────────────────────┘
```

#### UI-3.2: Editor Screen (Mobile)
```
┌─────────────────────┐
│ ☰  PDFSign      ⋮   │ ← App bar, 56dp
├─────────────────────┤
│                     │
│                     │
│    PDF Canvas       │
│                     │
│ [Rendered Pages]    │
│                     │
│ [Placed Objects]    │
│                     │
│                     │
│                     │
│                     │
│                 [+] │ ← FAB, 56dp
└─────────────────────┘
```

**App Bar Actions:**
- Left: Menu (hamburger) → File operations, Settings
- Right: More (3 dots) → Zoom controls, Help

**Floating Action Button:**
- Size: 56dp
- Position: Bottom-right, 16dp margin
- Icon: Plus sign
- Action: Open bottom sheet with signatures/stamps

#### UI-3.3: Bottom Sheet (Mobile)
```
┌─────────────────────┐
│         ⎯           │ ← Handle, 32x4dp, centered
├─────────────────────┤
│  🖊 Подписи         │
│  📄 Печати          │ ← Tabs
├─────────────────────┤
│  ┌───────────────┐  │
│  │   [Preview]   │  │
│  │   Подпись 1   │  │
│  └───────────────┘  │
│                     │
│  ┌───────────────┐  │
│  │   [Preview]   │  │
│  │   Подпись 2   │  │
│  └───────────────┘  │
│                     │
│  [ + Добавить ]     │
└─────────────────────┘
```

**Bottom Sheet Specs:**
- **Initial height:** 50% screen height
- **Max height:** 80% screen height
- **Min height:** 200dp
- **Draggable:** Yes
- **Backdrop:** Dim (40% black)
- **Dismiss:** Drag down or tap backdrop

#### UI-3.4: Floating Toolbar (Mobile)
When object is selected, show floating toolbar above it:
```
┌──────────────────────────────┐
│  ↻  ↺  ⤸  │  ➕  ➖  │  ↑  ↓  │  🗑  │
└──────────────────────────────┘
```

**Specs:**
- **Height:** 48dp
- **Position:** 16dp above selected object (or below if space insufficient)
- **Background:** White with shadowMedium
- **Button size:** 40dp
- **Dividers:** 1dp vertical line, borderColor

### 6.4 Responsive Behavior

#### UI-4.1: Desktop Window
- **Initial size:** 1280x800 logical pixels
- **Min size:** 1024x768
- **Default state:** Maximized
- **Resizable:** Yes
- **Full screen:** F11 (toggle)

#### UI-4.2: Tablet (7" - 12")
- Use desktop layout if width > 600dp
- Otherwise use mobile layout

#### UI-4.3: Orientation
- **Desktop:** Any (user-controlled window)
- **Mobile/Tablet:** Portrait and Landscape supported
- **Landscape behavior:**
  - PDF canvas expands horizontally
  - Bottom sheet converts to side sheet (right)

---

## 7. Platform-Specific Requirements

### 7.1 Desktop Platforms

#### PS-1.1: Window Management
- Native title bar (macOS, Windows, Linux)
- Native menu bar (File, Edit, View, Help)
- Window state persistence (size, position, maximized)
- Multiple windows: NOT supported in Phase 1

#### PS-1.2: Keyboard Shortcuts
**File:**
- Ctrl/Cmd+O: Open PDF
- Ctrl/Cmd+S: Save
- Ctrl/Cmd+Shift+S: Save As
- Ctrl/Cmd+W: Close document
- Ctrl/Cmd+Q: Quit application (macOS only)

**Edit:**
- Ctrl/Cmd+Z: Undo
- Ctrl/Cmd+Shift+Z: Redo
- Ctrl/Cmd+C: Copy selected object to clipboard as image
- Ctrl/Cmd+V: Paste image from clipboard (shows dialog for adding to library)
- Ctrl/Cmd+D: Duplicate selected object
- Del/Backspace: Delete selected object

**View:**
- Ctrl/Cmd+Plus: Zoom in
- Ctrl/Cmd+Minus: Zoom out
- Ctrl/Cmd+0: Actual size
- Ctrl/Cmd+1: Fit to screen
- F11: Full screen

**Object Manipulation:**
- Ctrl/Cmd+R: Rotate 90°
- Ctrl/Cmd+Alt+Left: Rotate 5° left
- Ctrl/Cmd+Alt+Right: Rotate 5° right
- Ctrl/Cmd+Alt+Plus: Scale +5%
- Ctrl/Cmd+Alt+Minus: Scale -5%
- Ctrl/Cmd+Shift+]: Bring to front
- Ctrl/Cmd+]: Bring forward
- Ctrl/Cmd+[: Send backward
- Ctrl/Cmd+Shift+[: Send to back

**Navigation:**
- Arrow keys: Nudge selected object (1px)
- Shift+Arrow: Nudge selected object (10px)
- Page Up/Down: Scroll PDF
- Home/End: Go to first/last page

#### PS-1.3: Mouse/Trackpad Gestures
- **Drag:** Move selected object
- **Right-click:** Context menu
- **Ctrl+Scroll:** Zoom in/out
- **Scroll:** Pan vertically
- **Shift+Scroll:** Pan horizontally
- **Trackpad pinch:** Zoom in/out
- **Hover:** Show resize cursor on handles

### 7.2 Mobile Platforms

#### PS-2.1: Touch Gestures
- **Tap:** Select object
- **Long press:** Context menu
- **Drag:** Move selected object
- **Pinch:**
  - On canvas: Zoom PDF
  - On selected object: Scale object
- **Two-finger rotate:** Rotate selected object
- **Swipe:** Scroll PDF

#### PS-2.2: iOS Specific
- Respect Safe Area insets
- Support Dynamic Type (accessibility)
- Share sheet integration for export
- Document picker integration
- Haptic feedback on interactions

#### PS-2.3: Android Specific
- Material Design 3 components
- Back button: Deselect object, then close document
- Share sheet integration
- System file picker
- Permission requests (storage)

### 7.3 Platform Capabilities

#### PS-3.1: File System Access
- **iOS:** Document picker, app sandbox
- **Android:** Scoped storage (API 29+)
- **Desktop:** Full file system access
- **Permissions:** Request at runtime on mobile

---

## 8. Localization Requirements

### 8.1 Supported Languages
- English (en) - Default
- Russian (ru)

### 8.2 Localizable Strings
All user-facing text must be externalized to ARB files:
```
lib/l10n/
├── app_en.arb
└── app_ru.arb
```

### 8.3 String Categories
- **UI Labels:** Button text, menu items, tab titles
- **Messages:** Success, error, warning messages
- **Tooltips:** Keyboard shortcut hints
- **Dialogs:** Confirmation messages, prompts
- **Placeholders:** Input field hints

### 8.4 Format Strings
Use ICU message format for:
- Plurals (e.g., "1 page" vs "5 pages")
- Dates/times (locale-specific formatting)
- Numbers (decimal separators)

### 8.5 RTL Support
- NOT required in Phase 1
- Architecture should support future RTL implementation

---

## 9. Security and Privacy

### 9.1 Data Storage
- **Location:** Local device only (no cloud)
- **Signature library:** Stored in app documents directory
- **Recent files:** Path references only (no content)
- **PDF modifications:** In-place or user-selected location

### 9.2 Permissions
- **File system access:** Required
- **Storage permission (Android):** Required on API < 29
- **No network access:** Not required
- **No camera access:** Not required in Phase 1

### 9.3 Password Handling
- PDF passwords NOT stored
- Password entered per session
- No password recovery mechanism

### 9.4 Data Privacy
- No analytics or telemetry
- No crash reporting in Phase 1
- No user accounts or authentication

---

## 10. Performance Requirements

### 10.1 Startup Time
- **Cold start:** < 2 seconds
- **Warm start:** < 1 second

### 10.2 PDF Loading
- **Small PDF (< 5MB):** < 1 second
- **Medium PDF (5-50MB):** < 3 seconds
- **Large PDF (50-100MB):** < 10 seconds
- **Progress indicator:** Show for operations > 500ms

### 10.3 Rendering
- **Frame rate:** 60 FPS minimum
- **Jank:** < 5 dropped frames per second
- **Memory:** < 200MB for typical session (10 page PDF, 5 signatures)

### 10.4 Responsiveness
- **Touch/click response:** < 100ms
- **Drag latency:** < 16ms (60 FPS)
- **Zoom smooth:** < 16ms per frame

### 10.5 File Operations
- **Save PDF:** < 5 seconds for typical document
- **Add signature to library:** < 1 second

### 10.6 Optimization Strategies
- Lazy load PDF pages (render on-demand)
- Cache rendered pages
- Debounce/throttle zoom operations
- Use `const` widgets extensively
- Profile with Flutter DevTools before releases

---

## 11. Data Management

### 11.1 Signature Library Storage

#### DM-1.1: Database
- **Technology:** Isar (embedded NoSQL)
- **Location:** App documents directory
- **File:** `signatures.isar`
- **Collections:** SignatureItem

#### DM-1.2: Image Storage
- **Embedded:** Image data stored as BLOB in Isar
- **Reason:** Simplifies backup, avoids orphaned files
- **Compression:** Original format preserved

#### DM-1.3: Backup Strategy
- User responsible for backing up app documents directory
- Export/import feature: OUT OF SCOPE for Phase 1

### 11.2 Recent Files

#### DM-2.1: Storage
- Shared Preferences or lightweight key-value store
- Limit: 10 most recent files

#### DM-2.2: Data Stored
```dart
class RecentFile {
  String path;
  String fileName;
  DateTime lastOpened;
  int pageCount;
  bool isPasswordProtected;
}
```

#### DM-2.3: Cleanup
- Remove entries for deleted files (check on app start)
- Clear all: Manual option in settings

### 11.3 Application State

#### DM-3.1: Persistence
- Window size/position (desktop)
- Last used zoom level
- Panel width (desktop)
- Selected tab (Signatures/Stamps)

#### DM-3.2: Session State
- Current PDF path
- Placed objects (in-memory until save)
- Undo/redo stack (in-memory, cleared on close)

---

## 12. Error Handling

### 12.1 Error Categories

#### ER-1.1: File Errors
- **File not found:** "The selected file could not be found."
- **Access denied:** "Permission denied. Please check file permissions."
- **Invalid format:** "This file is not a valid PDF document."
- **File too large:** "Image size exceeds 100MB limit."
- **Resolution too high:** "Image resolution exceeds 4096x4096 pixels."
- **Corrupted PDF:** "This PDF appears to be corrupted."

#### ER-1.2: Password Errors
- **Password required:** Dialog with input field
- **Incorrect password:** "Incorrect password. X attempts remaining."
- **Write protected:** "This PDF is protected and cannot be modified."

#### ER-1.3: Operation Errors
- **Save failed:** "Failed to save PDF. Error: [details]"
- **Insufficient space:** "Not enough disk space to save file."
- **Read-only location:** "Cannot save to a read-only location."

#### ER-1.4: Resource Errors
- **Out of memory:** "Insufficient memory. Try closing other apps."
- **Database error:** "Failed to access signature library."

### 12.2 Error Presentation

#### ER-2.1: Dialogs
- **Icon:** Error (red circle with X)
- **Title:** Error type
- **Message:** User-friendly explanation
- **Actions:** [OK] or [Retry] [Cancel]
- **Details:** Expandable technical details (desktop only)

#### ER-2.2: Inline Messages
- **Snackbar (mobile):** Brief error, auto-dismiss in 4 seconds
- **Banner (desktop):** Persistent until dismissed

#### ER-2.3: Logging
- All errors logged to console (debug builds)
- Log file: NOT implemented in Phase 1

---

## 13. Testing Requirements

### 13.1 Code Coverage
- **Minimum:** 80% overall
- **Domain layer:** 100% (pure business logic)
- **Data layer:** ≥ 80%
- **Presentation layer (BLoCs):** ≥ 90%
- **Widgets:** ≥ 70%

### 13.2 Test Types

#### TS-1.1: Unit Tests
- All use cases
- All repositories
- All BLoCs
- Utility functions
- **Naming:** `test('should return X when Y')`

#### TS-1.2: Widget Tests
- All custom widgets
- Screen layouts (smoke tests)
- User interactions (tap, drag)
- **Golden tests:** Selection handles, floating toolbar

#### TS-1.3: Integration Tests
- Full user flows:
  - Open PDF → Add signature → Save
  - Drag-and-drop workflow
  - Undo/redo operations
  - Password-protected PDF flow

#### TS-1.4: Platform Tests
- Run integration tests on all target platforms
- CI/CD: Automated testing on PR

### 13.3 Testing Tools
- **flutter_test:** Built-in testing framework
- **mockito:** Mock dependencies
- **bloc_test:** BLoC testing utilities
- **integration_test:** Full app tests

---

## 14. Dependencies and Licenses

### 14.1 Critical Dependencies
- **syncfusion_flutter_pdf:** Community License (revenue < $1M)
- **syncfusion_flutter_pdfviewer:** Community License

### 14.2 License Compliance
- Display license notice in About dialog
- Include attribution as per Syncfusion Community License terms
- Annual revenue verification required

### 14.3 Third-Party Assets
- Icons: Open source (MIT/Apache 2.0)
- Fonts: System fonts (no custom fonts in Phase 1)

---

## 15. Constraints and Assumptions

### 15.1 Constraints
- Must use Flutter stable channel (no beta/dev features)
- Must comply with Syncfusion Community License
- No network connectivity required
- Single document at a time
- Desktop and mobile only (no web)

### 15.2 Assumptions
- Users have basic computer/mobile literacy
- PDF files are well-formed (not corrupted)
- Signature/stamp images have transparent backgrounds (user responsibility)
- Users understand z-order concept
- Users manage their own backups

### 15.3 Risks
- **Syncfusion license change:** Mitigation - abstract PDF operations, allow swappable implementation
- **Performance on large PDFs:** Mitigation - pagination, lazy loading
- **Platform-specific bugs:** Mitigation - comprehensive testing, phased rollout

---

## 16. Future Enhancements (Out of Scope for Phase 1)

### 16.1 Features
- Draw signature with stylus/finger
- Text annotations
- Cloud sync (Google Drive, Dropbox)
- Multi-document tabs
- Batch processing
- PDF form filling
- Digital signature certificates (PKI)
- OCR integration

### 16.2 Platforms
- Web (requires different PDF library)
- Chrome OS

### 16.3 Integrations
- Email integration
- Cloud storage providers
- Document management systems

---

## 17. Acceptance Criteria

### 17.1 Functional
- ✅ Can open and view PDF with continuous scrolling
- ✅ Can add signatures/stamps to library
- ✅ Can drag-and-drop objects onto PDF
- ✅ Can transform objects (move, scale, rotate)
- ✅ Can manage z-order
- ✅ Can undo/redo operations
- ✅ Can save PDF with preserved structure
- ✅ Password-protected PDFs supported
- ✅ Works on all target platforms

### 17.2 Non-Functional
- ✅ 80%+ code coverage
- ✅ 60 FPS performance
- ✅ < 2s cold start time
- ✅ Zero linter warnings
- ✅ Follows Clean Architecture
- ✅ Fully localized (en, ru)

### 17.3 Quality
- ✅ No crashes on typical workflows
- ✅ User-friendly error messages
- ✅ Consistent UI across platforms
- ✅ Accessible (keyboard navigation, semantic labels)

---

## 18. Glossary

- **Signature:** An image representing a handwritten signature
- **Stamp:** An image representing an official stamp/seal
- **Placed Object:** An instance of a signature/stamp placed on PDF
- **Z-Index:** Vertical stacking order of overlapping objects
- **Transform:** Geometric operations (move, scale, rotate)
- **Handle:** UI control for resizing/rotating objects
- **Ghost:** Semi-transparent preview during drag operation
- **Continuous Scrolling:** Pages displayed end-to-end without gaps
- **Clean Architecture:** Layered architecture pattern (domain/data/presentation)

---

## 19. Revision History

| Version | Date       | Author          | Changes                          |
|---------|------------|-----------------|----------------------------------|
| 1.0     | 2025-11-29 | Requirements WG | Initial requirements finalized   |

---

**Document Status:** APPROVED FOR IMPLEMENTATION

**Next Steps:**
1. Generate project skeleton
2. Set up CI/CD pipeline
3. Begin implementation (domain layer first)
4. Iterative development with weekly reviews

---

**END OF REQUIREMENTS SPECIFICATION**