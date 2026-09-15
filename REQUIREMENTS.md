# PDFSign — Requirements Specification

**Version:** 2.0
**Date:** 2026-09-15
**Status:** Actual — describes the implemented system
**Supersedes:** v1.0 (2025-11-29), which described a planned cross-platform product that was never built as specified

---

## 0. About This Document

This specification describes **what PDFSign actually does**, verified against the source tree. Every functional requirement below is backed by an implementation and references the file that provides it.

Two companion documents cover what this one deliberately does not:

- **[TODO.md](TODO.md)** — the owner's personal roadmap (V1.0 → V1.3 and beyond). Planned features live there, not here.
- **[KNOWN ISSUES.md](KNOWN%20ISSUES.md)** — open defects.

§12 lists requirements from v1.0 that were **never implemented**, so that the gap between the original plan and the product is explicit rather than silently lost.

Architecture detail is kept out of this document; see [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) and [docs/adr/](docs/adr/).

---

## 1. Product Overview

### 1.1 Name and Identity

| Field | Value |
|-------|-------|
| Product name | PDFSign |
| Bundle identifier | `com.ivanvaganov.pdfsign` |
| Dart package name | `pdfsign` |
| Version | 1.0.0+1 (`pubspec.yaml`) |
| License | Proprietary |

### 1.2 Description

A native macOS application for viewing PDF documents and placing raster images — signatures, stamps, seals — onto their pages. Placed images are permanently rasterized into the output PDF.

### 1.3 Explicit Non-Goal

PDFSign produces **visual** marks only. It does not create cryptographic or certified electronic signatures, does not use X.509 certificates, and makes no claim about the legal effect of the documents it produces.

### 1.4 Primary User

An individual who repeatedly applies the same small set of signature/stamp images to PDF documents and wants them stored once, reachable instantly, and placed by drag-and-drop.

---

## 2. Platform and Environment

### 2.1 Supported Platform

**macOS only.**

The repository contains `ios/`, `android/`, `windows/`, and `linux/` directories, but these are **unmodified Flutter templates**. The application depends on macOS-specific native code (`macos/Runner/AppDelegate.swift`) for window management, the Finder integration, the native toolbar, and drag-and-drop into sub-windows. It will not run meaningfully on any other platform.

| Requirement | Value |
|-------------|-------|
| macOS | 10.15+ |
| Flutter SDK | 3.24.0+ |
| Dart SDK | 3.5.0+ |

### 2.2 Sandbox

The app sandbox is **disabled** (`macos/Runner/Release.entitlements`: `com.apple.security.app-sandbox = false`). This is a deliberate trade-off: it allows recent files to be reopened after a restart without security-scoped bookmarks.

**Consequence:** the app in its current configuration cannot be distributed through the Mac App Store, which requires sandboxing. Any App Store plan requires implementing security-scoped bookmarks first.

### 2.3 Build Flavors

None. There is a single build configuration. `flutter_flavorizr` is not used.

---

## 3. Functional Requirements — Implemented

### 3.1 Opening Documents

#### FR-1.1 — Open via Welcome window
The Welcome window (`welcome_screen.dart`, `desktop_welcome_view.dart`) presents an app logo, an **Open PDF** button, and a Recent Files list. Selecting a file opens it in a new window and hides the Welcome window.

#### FR-1.2 — Open via File menu
**File → Open…** (`Cmd+O`) opens the native picker from anywhere (`app_menu_bar.dart`).

#### FR-1.3 — Picker remembers last directory
The picker opens in the directory of the last file chosen, persisted under `last_open_directory`. Falls back to `~/Documents` if unset or if the stored directory no longer exists (`last_open_directory_provider.dart`).

#### FR-1.4 — Open from Finder
Double-click, **Open With**, and drag-to-Dock are handled natively and forwarded over the `com.pdfsign/file_handler` channel. Files arriving before the Flutter engine is ready are queued natively and delivered once Dart signals `ready` (`file_open_handler.dart`, `AppDelegate.swift`). The app is registered as an `Alternate`-rank viewer for `com.adobe.pdf`.

#### FR-1.5 — Recent files
- **12** entries retained (`AppConstants.maxRecentFiles`), stored as JSON in `SharedPreferences` under `recent_files`.
- Ordered by last-opened, descending.
- Up to **10** shown in **File → Open Recent**, plus a **Clear Menu** item.
- Opening an entry whose file no longer exists removes it and reports "File not found".
- Writes are serialized by a static async lock, because several windows may write concurrently (`recent_files_repository_impl.dart`).

#### FR-1.6 — One window per file
Opening a file that is already open focuses the existing window instead of opening a second one. The file → window mapping is held natively (`com.pdfsign/open_pdf_files`), because Dart state is not shared across Flutter engines.

#### FR-1.7 — Folder-permission retry
If opening fails with `File access denied`, the editor retries every 1.5 s up to 20 times (30 s total), showing a localized "Waiting for folder access permission…" state. On timeout the window closes (`editor_screen.dart`).

#### FR-1.8 — Password-protected PDFs
Detected and surfaced: the viewer shows a "Password Required" state. **Entering a password is not implemented** — see §12.3.

---

### 3.2 Viewing

#### FR-2.1 — Continuous scroll
All pages are laid out vertically in one scrollable column with a 24 pt gap and 40 pt padding at top and bottom (`pdf_page_list.dart`, `PdfViewerConstants`).

#### FR-2.2 — Page appearance
macOS Preview styling: `#E5E5E5` viewport background, white pages, 2 pt corner radius, two-layer soft shadow. A 20 px gradient fade sits under the title bar.

#### FR-2.3 — Zoom
| Property | Value |
|----------|-------|
| Range | 10 % – 500 % (`ZoomConstraints`) |
| Default | Fit Width |
| Presets | Fit Width, 50, 75, 100, 125, 150, 200, 300, 400, 500 % |
| Step outside presets | 0.1 |

Fit Width is computed against the **widest** page in the document minus 80 px of horizontal padding, and recomputed whenever the viewport resizes.

#### FR-2.4 — Pinch-to-zoom
During the gesture only a `Transform.scale` is applied — no re-rendering. On gesture end the real scale is committed once and the scroll offset is corrected so the focal point stays put (`pdf_viewer.dart`).

#### FR-2.5 — Wheel zoom
`Cmd`/`Ctrl` + scroll steps through zoom presets.

#### FR-2.6 — Horizontal scroll
Appears only when scaled content exceeds the viewport; 40 pt of padding is then added on each side for a "floating page" effect.

#### FR-2.7 — Page indicator
A floating pill showing `Page N of M` appears while scrolling or on page change, then fades out after 1.5 s.

#### FR-2.8 — Go to page
`Cmd+G` opens a dialog accepting a page number, clamped to the valid range.

#### FR-2.9 — Reload
`Cmd+R` closes and reopens the document, restoring the current page.

---

### 3.3 Image Library (Sidebar)

#### FR-3.1 — Single flat library
One list, shared by every open window. There is **no** separation into "Signatures" and "Stamps" tabs.

#### FR-3.2 — Adding images
Four routes, all converging on `SidebarImages.addImages`:
1. **Add Image** button → native picker, multi-select.
2. Drag-and-drop from Finder onto the sidebar.
3. `Cmd+V` — PNG or JPEG from the system clipboard, written to a temp file first (`super_clipboard`).
4. Programmatic (used internally).

Accepted extensions on drop: `.png .jpg .jpeg .gif .webp .bmp .tiff .tif`. Dimensions and file size are read via `ui.instantiateImageCodec`; unreadable files are skipped silently.

#### FR-3.3 — Copy into app storage
Every added image is copied to `~/Library/Application Support/<bundle-id>/images/<uuid><ext>`. The database stores the **copy's** path, never the original's (ADR-0001). The library therefore survives the source file being moved, renamed, or deleted.

#### FR-3.4 — Persistence and cross-window sync
Metadata lives in Isar (collection `SidebarImageModel`). Every window subscribes to `watchImages()`, so an addition, deletion, or reorder in one window appears in all the others immediately, with no explicit message passing (ADR-0006).

#### FR-3.5 — Reordering
The list is a `ReorderableListView`. Dragging works **only from the grip handle** (`⋮⋮`); dragging the image body starts a drag-to-PDF instead. The drag proxy uses a Figma-style scale + opacity effect.

#### FR-3.6 — Comments
Each card carries an inline editable comment below the thumbnail. `Enter` saves, `Esc` cancels, tapping outside saves. Long comments get a tooltip after 500 ms.

#### FR-3.7 — Deletion
A delete button appears on hover. Deleting removes both the database row **and the file in app storage** — see §13.1 for the consequence this has for already-placed images.

#### FR-3.8 — Resizable panel
Default 200 px, range 150–400 px, dragged by a 4 px handle. The width is per-window and is **not** persisted across launches.

---

### 3.4 Placing Objects

#### FR-4.1 — Drag from sidebar to page
Dragging an image body onto a page creates a `PlacedImage` at the drop point (`pdf_drop_target.dart`).

#### FR-4.2 — Default size
25 % of page width, aspect ratio preserved, capped at 90 % of either page dimension. The object is centred on the cursor and clamped inside the page.

#### FR-4.3 — Drop outside a page
A drop that lands in the side margin, in the gap between pages, above the first
page, or past the end of the document snaps to the **nearest page**, measured to
the page rectangle, and is clamped so the object lies fully inside it. Ties
resolve to the earlier page. A document with no pages refuses the drag outright.

#### FR-4.4 — Auto-select
A newly placed object is selected immediately, on every path including a snapped
off-page drop.

#### FR-4.4a — Drop feedback
While a drag is in flight the page that would receive the object is outlined, so
a drop aimed at the margin still shows where it will land.

#### FR-4.5 — Coordinates
Position and size are stored in **PDF points** (1/72 in) relative to the page's top-left corner, independent of zoom.

#### FR-4.6 — Lifetime
Placed objects live in memory only (`PlacedImages`, `keepAlive`). They are **not** persisted: closing the window without saving discards them, and there is no session restore.

---

### 3.5 Transforming Objects

Implemented in `placed_image_overlay.dart`.

#### FR-5.1 — Selection
Single-selection. Click an object to select; click the page background to clear.

#### FR-5.2 — Move
Drag the object body. Deltas are rotated into PDF space so dragging stays intuitive on rotated objects.

#### FR-5.3 — Proportional resize
Four square corner handles. Scaling is driven by the width delta; the opposite corner stays fixed by shifting the centre. Minimum 20 pt on both axes.

#### FR-5.4 — Non-proportional stretch
Four side handles stretch one axis, anchoring the opposite edge.

#### FR-5.5 — Rotate
One circular handle on a 20 pt stem above the top edge. Free rotation with ±180° normalization for smooth wrap-around. There is no snapping and no modifier-key constraint.

#### FR-5.6 — Handle appearance
10 px corner squares / 10×6 px side handles, white fill at 50 % opacity rising to 80 % on hover, 2 px `#0066FF` border. Hit areas are larger than the visuals (24 px corners, 20 px sides, 32 px rotation handle).

#### FR-5.7 — Size label
Below the visually lowest edge, showing `W × H` in cm or inches to one decimal. Clicking toggles the unit and broadcasts the change to every open window.

#### FR-5.8 — Delete
`Delete` / `Backspace` (suppressed while a text field has focus), **Edit → Delete** (`Cmd+Backspace`), or the Delete button in the native toolbar, which appears only while something is selected.

#### FR-5.9 — Copy / paste
`Cmd+C` remembers the selected object's id; `Cmd+V` duplicates it offset by (20, 20) and selects the copy. This is an in-window mechanism, not the system clipboard, so it does not carry objects to another document.

---

### 3.6 Saving and Export

#### FR-6.1 — Save (`Cmd+S`)
Rasterizes every placed object into the PDF and overwrites the current file. Rotation is applied around the object's centre via `translate → rotate → translate` on the Syncfusion graphics state.

#### FR-6.2 — Always save from the original
Every save starts from the **original** PDF bytes cached at open time, never from the previous save (ADR-0002). Repeated saves therefore do not stack images or degrade the file.

Caching strategy (`OriginalPdfStorage`): ≤ 50 MB in memory, > 50 MB copied to a temp file.

#### FR-6.3 — Save As (`Cmd+Shift+S`)
Writes to a chosen path, then switches the window to the new file: the open-files registry is updated, the title changes, placed objects are cleared (they are embedded now), the dirty flag resets, and the current page is restored after reload.

#### FR-6.4 — Save All (`Cmd+Opt+S`)
Broadcasts to every window; each saves only if it is dirty. Enabled only while at least one window is dirty.

#### FR-6.5 — Share
Builds a temp PDF with the objects embedded and hands it to the native share sheet, then deletes the temp file 5 s later. With no placed objects, the original file is shared directly. Available from **File → Share…** and the native toolbar button.

#### FR-6.6 — Objects stay editable after save
Saving marks the document clean but does **not** clear the objects or reload the document, so editing can continue.

#### FR-6.7 — Dirty-state policy
A document counts as changed when its current set of placed objects differs
from the set that was last written to the file — including position, size and
rotation. The state is derived from that comparison rather than flagged per
operation, so moving an object back where it was reports the document clean
again (ADR-0008).

#### FR-6.8 — Close with unsaved changes
Closing a dirty window shows a Save / Discard dialog. Close All and Quit show a consolidated Save All / Don't Save / Cancel dialog reporting how many documents are affected; if saves fail afterwards, a second dialog offers "Close Anyway".

---

### 3.7 Multi-Window Behaviour

#### FR-7.1 — Window types
| Window | Size | Notes |
|--------|------|-------|
| Welcome | 900×700, min 600×400 | Main window, id `"0"` |
| PDF viewer | inherited | One per document |
| Settings | 650×500 fixed | Singleton, not resizable, not minimizable |

#### FR-7.2 — Isolated engines
Each window runs its own Flutter engine with its own `ProviderContainer`. Nothing in Dart is shared implicitly (ADR-0006).

#### FR-7.3 — Welcome auto-hide
Opening the first PDF hides the Welcome window permanently for that session. Closing Welcome while other windows exist hides it; closing it as the last window quits the app.

#### FR-7.4 — Last window quits
Closing the last visible window terminates the process. The check queries the native window list, not Dart state.

#### FR-7.5 — Settings singleton
Enforced through native `UserDefaults` plus an in-engine re-entrancy flag, because a Dart-level singleton cannot span engines (ADR-0005).

#### FR-7.6 — Menu ownership
Only the focused window renders `PlatformMenuBar`; otherwise several engines fight over the one system menu bar.

#### FR-7.7 — Window menu
Minimize (`Cmd+M`), Zoom, Bring All to Front, and a live list of open windows with a checkmark on the focused one, sourced from `com.pdfsign/window_list`.

#### FR-7.8 — Cross-window messages
`WindowBroadcast` carries: `unitChanged`, `localeChanged`, `saveAll`, `closeAll`, `showWelcome`, `hideWelcome`, `dirtyStateChanged`, `requestDirtyStates`, `settingsOpened`, `settingsClosed`. A newly opened window requests the dirty state of all the others on startup.

---

### 3.8 Settings

One window, one **General** section:

- **Language** — searchable list of 58 entries plus "System Default", applied live to every window.
- **Units** — Centimeters / Inches, applied live to every window.

There are no other settings. In particular there is no clipboard-behaviour section, no theme choice, and no storage management.

---

### 3.9 Menus and Shortcuts

| Shortcut | Action | Scope |
|----------|--------|-------|
| `Cmd+O` | Open… | all windows |
| `Cmd+S` | Save | PDF window |
| `Cmd+Shift+S` | Save As… | PDF window |
| `Cmd+Opt+S` | Save All | PDF window |
| `Cmd+W` | Close Window | all |
| `Cmd+Opt+W` | Close All | all |
| `Cmd+Q` | Quit (with save prompt) | all |
| `Cmd+,` | Settings | all |
| `Cmd+Backspace` | Delete object (Edit menu) | PDF window |
| `Delete` / `Backspace` | Delete object | PDF window, unless a text field has focus |
| `Cmd+C` / `Cmd+V` | Copy / paste object | PDF viewer |
| `Cmd+V` | Paste image into library | sidebar focused |
| `Cmd+G` | Go to page | PDF window |
| `Cmd+R` | Reload document | PDF window |
| `Cmd+0` | Fit Width | PDF window |
| `Cmd+=` / `Cmd+-` | Zoom in / out | PDF window |
| `Cmd+M` | Minimize | all |
| `PageUp` / `PageDown` | Previous / next page | PDF window |
| `Home` / `End` | First / last page | PDF window |
| Arrows | Scroll by 50 px | PDF window |

The macOS app menu provides About, Settings…, and Quit PDFSign. The Edit menu exists only in PDF windows and contains only Delete.

---

## 4. Technical Specification

### 4.1 Architecture

Clean Architecture in four layers — `core`, `domain`, `data`, `presentation` — with Riverpod (code-generated) for state. Full detail in [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

### 4.2 Actual Dependencies

```yaml
dependencies:
  flutter_riverpod: ^2.5.1          # state management
  riverpod_annotation: ^2.3.5
  equatable: ^2.0.5                 # value equality for entities
  freezed_annotation: ^2.4.1        # sealed viewer state, DTOs
  go_router: ^14.2.7                # see §13.3 — currently unused
  pdfx: ^2.6.0                      # PDF rendering
  syncfusion_flutter_pdf: ^32.1.23  # PDF writing / image embedding
  isar: ^3.1.0+1                    # image library database
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.4
  file_picker: ^8.1.2
  mime: ^1.0.6
  desktop_drop: ^0.4.4              # Finder drop (main window)
  super_clipboard: ^0.9.1           # image paste
  dartz: ^0.10.1                    # Either
  uuid: ^4.5.1
  intl: ^0.20.2
  json_annotation: ^4.9.0
  logger: ^2.4.0                    # see §13.4 — currently unused
  shared_preferences: ^2.3.2
  desktop_multi_window: ^0.3.0      # multi-window
  window_manager: ^0.4.2            # window control
  share_plus: ^10.0.0
```

Rendering is **`pdfx`**, not `syncfusion_flutter_pdfviewer`. Syncfusion is used for writing only.

### 4.3 Native Integration

Six method channels, implemented in `macos/Runner/AppDelegate.swift`:

| Channel | Purpose |
|---------|---------|
| `com.pdfsign/file_handler` | Finder → app file opening, with a pre-ready queue |
| `com.pdfsign/window` | Sub-window close interception, focus/blur, destroy, show/hide |
| `com.pdfsign/settings_singleton` | Settings window id in `UserDefaults` |
| `com.pdfsign/open_pdf_files` | Open-file → window-id registry, focus-by-path |
| `com.pdfsign/window_list` | Window menu list, focus, minimize, zoom, bring-all-to-front |
| `com.pdfsign/toolbar` | Native `NSToolbar` with Share and conditional Delete buttons |

`desktop_drop` is additionally **reimplemented natively** (`SubWindowDropTarget` / `DropTargetView`) because the package supports only the main window, while every document lives in a sub-window.

See [docs/PLATFORM_CHANNELS.md](docs/PLATFORM_CHANNELS.md).

### 4.4 Domain Entities

| Entity | Purpose |
|--------|---------|
| `PdfDocumentInfo` | Path, name, page count, per-page dimensions |
| `PdfPageInfo` | 1-based number, width/height in points |
| `PlacedImage` | id, source id, image path, page index, position, size, rotation |
| `SidebarImage` | id, path, name, added-at, order, dimensions, size, comment |
| `RecentFile` | path, name, last-opened, page count, protected flag |
| `WindowInfo` | window id, title, type, focused flag, file path |

All immutable, `Equatable`, with `copyWith`. Full field tables in [docs/ENTITIES.md](docs/ENTITIES.md).

> There is no `SignatureItem` entity. v1.0 specified one; the implementation splits the concept into `SidebarImage` (library) and `PlacedImage` (instance on a page).

### 4.5 Storage Map

| Data | Mechanism | Location |
|------|-----------|----------|
| Image library metadata | Isar, `SidebarImageModel` | `getApplicationDocumentsDirectory()` → `~/Documents/pdfsign.isar` |
| Image files | file system | `~/Library/Application Support/<bundle-id>/images/` |
| Recent files | SharedPreferences (JSON) | key `recent_files` |
| Language | SharedPreferences | key `locale_preference` |
| Units | SharedPreferences | key `size_unit_preference` |
| Last open directory | SharedPreferences | key `last_open_directory` |
| Original PDF bytes | memory or temp file | session only |
| Placed objects | memory | session only, discarded on close |
| Settings window id, open files | native `UserDefaults` | cross-engine |

---

## 5. UI Specification

### 5.1 Theme

Material 3, light only. There is no dark theme and no theme switch.

| Token | Value |
|-------|-------|
| Primary | `#0066FF` |
| Background | `#FFFFFF` |
| Surface | `#F5F5F7` |
| Border | `#E5E5E7` |
| Text primary / secondary / disabled | `#1A1A1A` / `#6B6B6B` / `#B0B0B0` |
| Error / success / warning | `#DC3545` / `#28A745` / `#FFC107` |
| Viewer background | `#E5E5E5` |
| Selection + handle border | `#0066FF` |

### 5.2 Key Metrics

| Element | Value |
|---------|-------|
| Sidebar width | 200 default, 150–400 |
| Resize handle | 4 px |
| Page gap / vertical padding / horizontal padding | 24 / 40 / 40 pt |
| Page corner radius | 2 pt |
| Minimum object size | 20 pt |
| Corner handle / side handle | 10 px / 10×6 px |
| Rotation handle / stem | 24 px / 20 px |
| Page indicator auto-hide | 1500 ms |
| Scroll-end debounce | 150 ms |

---

## 6. Localization

- **66** `.arb` files in `lib/l10n/`, **74** message keys, generated into `lib/l10n/generated/`.
- **58** locales are selectable in Settings and registered in `MaterialApp.supportedLocales`.
- RTL is supported for `ar`, `he`, `fa`. The editor forces LTR layout direction so panels keep their sides; text inside widgets still renders RTL.
- Changing the language applies immediately in all open windows via broadcast.

Known localization defects are listed in §13.5 and §13.6.

---

## 7. Security and Privacy

- Fully offline. No network requests, no accounts, no telemetry, no crash reporting.
- All data stays in the user's home directory.
- No encryption at rest — the image library and its files are stored in the clear, consistent with their non-sensitive nature.
- `Info.plist` declares usage descriptions for Desktop, Documents, Downloads, network volumes, and removable volumes.
- The app sandbox is disabled (§2.2).

---

## 8. Error Handling

The `Either<Failure, T>` pattern (dartz) is used across data and domain layers. Failure types live in `core/errors/failures.dart`: `FileNotFoundFailure`, `FileAccessFailure`, `InvalidFileFormatFailure`, `FileSizeLimitFailure`, `PasswordRequiredFailure`, `PasswordIncorrectFailure`, `WriteProtectedFailure`, `PdfLoadFailure`, `PdfRenderFailure`, `RenderCancelledFailure`, `StorageFailure`.

`RenderCancelledFailure` is not an error condition — it signals a deliberately abandoned render and results in a placeholder, not an error state.

User-facing errors appear as snackbars (save failures), dedicated viewer states (load failure, password required, permission wait), or dialogs (file not found, save failed during Close All).

---

## 9. Performance Design

| Concern | Mechanism |
|---------|-----------|
| Large documents | Only visible pages + 2-page buffer are rendered (`VisiblePages`) |
| Memory | LRU cache of 10 rendered pages (`PdfPageCache`) |
| Cache thrashing while zooming | Scale quantized to 2 decimals |
| Wasted work while scrolling | Render cancellation by render-id |
| Pinch smoothness | `Transform.scale` during the gesture, one real re-render at the end |
| Large PDFs during save | Originals > 50 MB cached to a temp file rather than RAM |

No formal performance budgets are enforced, and there is no profiling harness. The numeric targets in v1.0 (launch < 2 s, 10 MB load < 3 s, 60 FPS, < 200 MB) were never measured or asserted anywhere in the codebase.

---

## 10. Quality Status

| Aspect | State |
|--------|-------|
| `flutter analyze` | 993 issues: 0 errors, **0 warnings**, 993 info |
| Unit tests | **78** — page-column geometry (`PdfPageLayout`), placement rules, dirty-state policy, the clipboard payload codec, image import limits |
| Widget tests | **41** — drop placement, off-page snapping, drag feedback, the close-everything flow, cut/copy/paste |
| Native tests | **15** — toolbar item management (`macos/RunnerTests`) |
| Integration tests | **none** |
| Golden tests | **none** |
| CI | none |

The largest info groups are `prefer_relative_imports`, `prefer_expression_function_bodies`, `always_put_control_body_on_new_line` and `avoid_catches_without_on_clauses`; see the Import Convention note in `CLAUDE.md` for why the first group cannot be acted on as things stand.

The analyzer is clean of warnings: the last three — a lint removed in Dart 3.7
still listed in `analysis_options.yaml`, and two unreachable private methods in
`window_manager_service.dart` — were cleared on 2026-09-15. `CLAUDE.md`'s
zero-warning rule is met; keep it that way.

> `prefer_relative_imports` fires on nearly every file because `analysis_options.yaml` enables that rule while simultaneously setting `always_use_package_imports: error`, and `CLAUDE.md` forbids absolute imports. These three sources contradict each other; the codebase consistently uses `package:` imports. One of the three has to give.

---

## 11. Documentation Map

| Document | Content |
|----------|---------|
| [README.md](README.md) | Setup and build |
| [CHANGELOG.md](CHANGELOG.md) | Version history |
| [TODO.md](TODO.md) | Personal roadmap — **not** a requirements source |
| [KNOWN ISSUES.md](KNOWN%20ISSUES.md) | Open defects |
| [CODE_REVIEW.md](CODE_REVIEW.md) | Code review findings, with status per item |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Layers, multi-window, pipelines |
| [docs/PROVIDERS.md](docs/PROVIDERS.md) | Every Riverpod provider |
| [docs/SERVICES.md](docs/SERVICES.md) | Business services |
| [docs/REPOSITORIES.md](docs/REPOSITORIES.md) | Repository contracts |
| [docs/ENTITIES.md](docs/ENTITIES.md) | Domain entities |
| [docs/PLATFORM_CHANNELS.md](docs/PLATFORM_CHANNELS.md) | Native macOS integration |
| [docs/adr/](docs/adr/) | Architecture decision records |

---

## 12. Not Implemented

Specified in v1.0 (or implied by leftover code) but **absent from the product**. Listed so the gap is explicit; scheduling lives in [TODO.md](TODO.md).

| # | Feature | Evidence of the gap |
|---|---------|---------------------|
| 12.1 | **Z-order management** (bring to front / send to back / forward / backward) | `PlacedImage` has no z-index; paint order is insertion order. TODO → V1.0 |
| 12.2 | **Undo / redo**, 50 levels | No command stack anywhere. TODO → V1.1 |
| 12.3 | **Password entry for protected PDFs** | `PdfDocument.openProtectedDocument()` exists and works, but nothing calls it — `pdf_viewer.dart` carries `// TODO: Add password input dialog`. `l10n.incorrectPassword` is unused. TODO → V1.0 (save/share with the original password) |
| 12.4 | **Paste dialog** with "Add to Signatures / Stamps / Don't add" and "Don't ask again" | No dialog. A pasted image goes onto the page and is deliberately not added to the library (ADR-0009) |
| 12.5 | **Signatures / Stamps split** in the library | One flat list |
| 12.6 | **`Cmd+D` duplicate** | Duplication exists only via `Cmd+C` → `Cmd+V` |
| 12.7 | **Context menu** on placed objects | No right-click menu anywhere |
| 12.8 | **Image validation limits** (100 MB, 4096×4096) | **Implemented** — `ImageImportLimits`, enforced on library import and on paste |
| 12.9 | **Cross-platform support** (iOS, Android, Windows, Linux) | Template projects only; see §2.1 |
| 12.10 | **Mobile layouts** | `MobileWelcomeView` exists but calls `context.goNamed('editor')` with no router mounted — see §13.3 |
| 12.11 | **Persistence of placed objects / session restore** | In-memory only |
| 12.12 | **Copying an object between documents** | `Cmd+C` buffer is per-window. TODO → V1.1 |
| 12.13 | **Text annotations** | TODO → V1.3 |
| 12.14 | **Page rotation** (`Cmd+R` as rotate-all) | `Cmd+R` currently reloads. TODO → V1.1 |
| 12.15 | **Crash reporting, flavors, CI/CD, obfuscation** | None configured |

---

## 13. Known Limitations and Technical Debt

### 13.1 Deleting a library image deletes its file, breaking placed instances
`SidebarImageRepositoryImpl.removeImage` deletes the row **and** the file in app storage. ADR-0003 states that placed objects keep working because their file still exists — that is not what the code does. A placed object whose source was deleted renders as a broken-image placeholder, and `PdfSaveService` skips it silently (`if (!await imageFile.exists()) continue;`), so it vanishes from the saved PDF without any warning.

### 13.2 `PdfSaveService` is built outside its provider
`pdf_viewer_app.dart` instantiates `PdfSaveService()` directly in three places instead of reading `pdfSaveServiceProvider`, which `CLAUDE.md` names as an outstanding layering violation. Its save-failure snackbars are also English literals rather than `AppLocalizations`.

> Until 2026-09-15 this entry claimed Save was implemented twice and that `Cmd+S` could run both paths. Measurement showed otherwise: the copy in `pdf_viewer.dart` was unreachable, because with a `PlatformMenuBar` installed no `Cmd` shortcut reaches the widget tree (§13.13). It has been deleted along with the rest of the dead `Cmd` branch.

### 13.3 `go_router` is dead weight
`lib/core/router/app_router.dart` is referenced by nothing. All three window roots build `home:` directly. The only import of `go_router` outside it is the unreachable mobile view.

### 13.4 `logger` is a declared but unused dependency
Diagnostics go through `kDebugMode` + `print()`, which `CLAUDE.md` prohibits and which is the source of many lints.

### 13.5 Three translations are unreachable
`app_ja.arb`, `app_ko.arb`, `app_zh.arb`, `app_zh_CN.arb`, and `app_zh_TW.arb` are translated and code-generated, but `ja`, `ko`, and `zh` are **missing from `supportedLocales`**. Since `MaterialApp.supportedLocales` is built from that same list, Japanese, Korean, and Chinese are neither selectable in Settings nor picked up from the system locale — those users fall back to English.

### 13.6 Hardcoded UI strings
Localized and unused: `savePdfAs`, `savedTo`, `noOriginalPdfStored`, `incorrectPassword`, `goToPage`, `go`, `removeFromList`, `fileAccessDenied`, `saveFailed`. The corresponding UI uses English literals — `GoToPageDialog` ("Go to Page", "Page number", "Cancel", "Go"), `PageIndicator` ("Page N of M"), the sidebar empty state, the viewer's empty/error/password states, and every save-failure snackbar.

### 13.7 Placed objects are clipped to the page
`PdfPageItem` wraps each page in `clipBehavior: Clip.antiAlias`. An object near a page edge has its handles — especially the rotation handle above the top edge — clipped. `PlacedImage`'s doc comment mentions cross-page objects; they are not supported.

### 13.8 The page column is not virtualized
All pages are built into one `Column` inside a `SingleChildScrollView`. Only image *rendering* is lazy, so the widget count is O(page count).

Page measurement itself is no longer a problem: `PdfPageLayout` precomputes page offsets once per (document, scale, viewport width) and answers lookups by binary search, so scrolling no longer walks every page.

### 13.9 Toolbar helpers live in a global mutable dictionary

`toolbarHelpers` in `AppDelegate.swift` is a file-scope mutable dictionary keyed by `ObjectIdentifier(window)` — the window's address, which the allocator reuses. Entries are now evicted when a window closes and every lookup confirms ownership, so the stale-entry hazard is closed, but the design is still a global that `CLAUDE.md` would reject in Dart. Attaching the helper to the window (associated object) or to the `FlutterViewController` would remove it.

### 13.10 Exception classification by string matching
`PdfDocumentRepositoryImpl` maps `pdfx` failures to `Failure` types by searching the exception's `toString()` for `"password"`, `"not found"`, `"permission"`, and similar. Brittle across library versions and locales. See CODE_REVIEW §1.1.

### 13.11 `Cmd` shortcuts only exist in the menu
With a `PlatformMenuBar` installed, a `Cmd` key equivalent never reaches Flutter's focus tree: verified on 2026-09-15 by synthesising key events against the running app, where `PageDown` reached `PdfViewer._handleKeyEvent` and `Cmd+G`, `Cmd+=` and `Cmd+C` did not. A shortcut therefore has to be a menu item to exist at all.

Two consequences are still open:

- **Go to Page (`Cmd+G`), Reload (`Cmd+R`) and zoom (`Cmd+0`, `Cmd+±`) are unreachable.** The handlers are still in `PdfViewer`, but nothing can invoke them. They need View-menu items or removal.
- **Text editing shortcuts are dead in every field** except where the Edit menu now covers them: `Cmd+A` does not select all in the image comment, the Go to Page field or Settings. Cut/Copy/Paste were fixed by routing the Edit menu through `EditorClipboard`; Select All has no menu item yet.

### 13.12 Paste is always enabled
`PlatformMenuBar` gives no hook to revalidate a menu item as the menu opens, and polling the pasteboard would be worse. Edit → Paste is therefore always enabled while a document is open and does nothing when the clipboard holds nothing usable. Cut and Copy do better: they follow the selection and the keyboard focus.

### 13.13 Pasted images are swept only at a cold start
An image pasted from another application is stored in `pasted/` in app support and has no library row to own it. The folder is emptied when the main window starts, which is the only moment no document window can be holding one of those files. If the app is killed, its scratch files survive until the next launch. Bounded and self-correcting, but not immediate.

### 13.14 The Syncfusion license key is committed
`TODO.md` contains a Syncfusion community license key in plain text. It should be removed from the repository and from history.

---

## 14. Document History

| Version | Date | Change |
|---------|------|--------|
| 2.0 | 2026-09-15 | Rewritten against the implementation. Removed unbuilt requirements to §12, added §13 technical debt, corrected platform scope, dependencies, entity model, storage map, and localization figures. |
| 1.0 | 2025-11-29 | Original pre-implementation specification (cross-platform, Signatures/Stamps tabs, z-order, undo/redo, `com.nosota.pdfsign`). Superseded. |
