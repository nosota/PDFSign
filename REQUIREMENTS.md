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
| Version | 1.5.0+7 (`pubspec.yaml`) — `Info.plist` reads both through `$(FLUTTER_BUILD_NAME)` / `$(FLUTTER_BUILD_NUMBER)`; the About panel shows the version alone (see §2.4) |
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

### 2.4 Application Object

`NSPrincipalClass` is `PDFSignApplication` (`macos/Runner/PDFSignApplication.swift`), not `NSApplication`. The subclass exists for one reason and should not grow others: `NSApplication`'s standard About panel prints `Version <CFBundleShortVersionString> (<CFBundleVersion>)` whenever both keys are set, so the panel read "Version 1.2.0 (1)". The override shows the panel with an empty version option, which drops the parenthetical; `CFBundleVersion` itself is untouched, because macOS uses it to tell one build from another.

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
The password is asked for in the viewer, tried, and asked for again if it was wrong. It is then held only in the open document's state for as long as the window lives: it is not written to Recent Files, preferences or the database, is not logged, and is not broadcast to other windows.

Opening takes the protected route only for a document CoreGraphics reports as encrypted (`com.pdfsign/pdf_security`). Everything else is opened straight from the file as before, so a large plain document is still never pulled into memory. A protected one is opened with `syncfusion` and rendered from a copy with its passwords cleared, held in memory and never written to disk (ADR-0011).

A document carrying only an owner password — readable by anyone, restricted in what may be done with it — opens with no password at all. Before this it was refused outright, because the renderer turns down anything encrypted whether it is locked or not.

Documents protected by a means other than a password (a certificate) cannot be opened, and say so: `UnsupportedProtectionFailure`.

#### FR-1.9 — Permissions of a protected document
A document whose permissions withhold `editContent` is opened read-only: nothing may be dropped or pasted onto it, its pages may not be turned, and it may not be saved. The page does not outline itself under a drag it will refuse. A notice above the document says why, and takes the owner password — which under PDF 32000-1:2008 §7.6.3.2 grants full access whatever the flags say. The document is reopened in place with it; a wrong password leaves the document on screen untouched.

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

#### FR-2.9 — Reopening in place
The document is closed and reopened in the same window, restoring the page in view. It happens by itself where a window has to turn to different bytes: after Save As, and after an owner password lifts a restriction (FR-1.9). There is no longer a reader-facing Reload command — `Cmd+R` has meant Rotate Right since 1.2.0, and the menu item went with it.

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
The list is a `ReorderableListView`. Reordering is started from the grip (`⋮⋮`), from the first movement; a tooltip on hover says what the grip is for. Dragging the image itself carries it to the page instead (FR-4.1).

Where the drag begins is the whole of what separates the two, and that is deliberate: asking for a hold as well was tried and made reordering look broken.

#### FR-3.6 — Comments
Each card carries an inline editable comment below the thumbnail. `Enter` saves, `Esc` cancels, tapping outside saves. Long comments get a tooltip after 500 ms.

#### FR-3.7 — Deletion
A delete button appears on hover. Deleting removes both the database row **and the file in app storage** — see §13.1 for the consequence this has for already-placed images.

#### FR-3.8 — Resizable panel
Default 200 px, range 150–400 px, dragged by a 4 px handle. The width is per-window and is **not** persisted across launches.

---

### 3.4 Placing Objects

#### FR-4.1 — Drag from sidebar to page
Dragging an image body onto a page creates a `PlacedImage` at the drop point (`pdf_drop_target.dart`). The grip and the comment field are not part of it: the grip reorders (FR-3.5), and a drag across a text field belongs to selecting its text.

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

#### FR-5.4a — Remembered size

Resizing an object records that size against the library image it came from, and the next object dragged out of the library starts at it, fitted to the page it lands on. Objects already on a page are untouched: three copies of one image, resized separately, keep their three sizes, and a fourth arrives at the size of the one resized last.

The size is recorded when the resize gesture ends, not while it runs, and it lives in the library row, so it survives a restart and is shared between windows through the Isar stream. Only the size: rotation stays with the object it was applied to. An image pasted from another application has no library row and so remembers nothing.

#### FR-5.5 — Rotate
One circular handle on a 20 pt stem above the top edge. Free rotation with ±180° normalization for smooth wrap-around. There is no snapping and no modifier-key constraint.

#### FR-5.6 — Handle appearance
10 px corner squares / 10×6 px side handles, white fill at 50 % opacity rising to 80 % on hover, 2 px `#0066FF` border. Hit areas are larger than the visuals (24 px corners, 20 px sides, 32 px rotation handle).

#### FR-5.7 — Size label
Below the visually lowest edge, showing `W × H` in cm or inches to one decimal. Clicking toggles the unit and broadcasts the change to every open window.

#### FR-5.8 — Delete
`Delete` / `Backspace` (suppressed while a text field has focus), **Edit → Delete** (`Cmd+Backspace`), or the Delete button in the native toolbar, which is greyed out while nothing is selected rather than taken away — an item set that never changes is one that never moves the controls around it.

#### FR-5.9 — Cut / copy / paste
Through the **system pasteboard** (ADR-0009), so an object can be carried to another PDFSign window and an image copied in another application can be pasted onto the page. `Cmd+X` / `Cmd+C` / `Cmd+V`, and **Edit → Cut / Copy / Paste**. While a text field holds the keyboard the action is handed to the field instead.

#### FR-5.11 — Undo and redo
**Edit → Undo** (`Cmd+Z`) and **Redo** (`Shift+Cmd+Z`), and the two-part control at the left of the toolbar. Each half is enabled only while there is a step in that direction. Fifty steps, per window and per document (ADR-0012).

Each step is a snapshot of what a reader can change — the objects, the turn every page is shown at, and the selection — rather than an action that knows how to reverse itself. Covered: placing, moving, resizing, rotating, deleting, cutting, pasting, restacking and turning a page. A gesture is one step, not one per frame, and a gesture that changed nothing is no step at all.

Not covered, deliberately: the image library in the right-hand panel and the size it remembers, both shared across windows through Isar; the view (zoom, scroll, page); saving; and settings. While a text field holds the keyboard, `Cmd+Z` is the field's own.

The history is forgotten when the window turns to another document — opening one, or Save As, which starts a new file. It survives a save: undoing past one is allowed, and leaves the document correctly reported as unsaved.

#### FR-5.10 — Restacking
**Bring to Front** (`Shift+Cmd+F`), **Bring Forward** (`Opt+Shift+Cmd+F`), **Send Backward** (`Opt+Shift+Cmd+B`) and **Send to Back** (`Shift+Cmd+B`), from **Edit** or from the four-part control at the left of the toolbar. Enabled whenever something is selected.

Objects carry no depth of their own: the order they are drawn in is the order they sit in `placedImagesProvider`, on screen (`placed_image_overlay.dart`) and in the written file (`pdf_save_service.dart`) alike. Restacking is therefore a move within that list, and the two cannot disagree. A move reaches only the places its own page occupies, so the objects of other pages keep their order however the list is interleaved; a move that changes nothing leaves the list identical, which is what keeps an empty entry out of the undo history.

---

### 3.6 Saving and Export

#### FR-6.1 — Save (`Cmd+S`)
Rasterizes every placed object into the PDF and overwrites the current file. Rotation is applied around the object's centre via `translate → rotate → translate` on the Syncfusion graphics state.

Objects are positioned against the page **as the reader sees it**, while Syncfusion draws in the page's own unrotated space. `PageRotationTransform` maps between the two, and a page the reader turned is written as its `/Rotate` (ADR-0010). The object keeps its own width and height and is placed by its centre: drawing into the turned-over rectangle *and* rotating would count the page's turn twice.

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
again (ADR-0008). A change of protection (FR-6.9) counts the same way and
against its own baseline: asking for the protection the document already has
leaves it clean.

#### FR-6.8 — Close with unsaved changes
Closing a dirty window shows a Save / Discard dialog. Close All and Quit show a consolidated Save All / Don't Save / Cancel dialog reporting how many documents are affected; if saves fail afterwards, a second dialog offers "Close Anyway".

#### FR-6.10 — Printing
**File → Print…** (`Cmd+P`) prints the document as the reader sees it: the objects are embedded and the pages carry the turns they were given, so what comes out of the printer is what a save would have written. **Print Current Page** (`Opt+Cmd+P`) is the same panel with its range pre-filled with the page in view.

The panel is **the system's own**, built by PDFKit from the document
(`PDFDocument.printOperation(for:scalingMode:autoRotate:)`): copies, page range, paper size, orientation, scaling, layout, two-sided, presets, the preview and the PDF menu all come from macOS, along with the printer's own settings. Nothing of that is rebuilt here. Neither PDF library in the project can print — pdfx renders and syncfusion writes files — so printing comes from the platform, and it needs no new dependency: Quartz is already linked.

Pages are scaled **down to fit** the paper and rotated to suit it, so a page larger than the sheet is shrunk rather than clipped and a landscape page is not cut off. The panel opens on **every page** unless Print Current Page asked otherwise: printing one page when the reader meant the document is a worse mistake than an extra click. It opens on a *copy* of the shared print settings, so a range chosen for one job is not the next one's default.

**Nothing is written to disk on the way.** The bytes go to the system from memory, which is what ADR-0011 asks of a decrypted document. What the printing system spools afterwards is outside the app, exactly as it is for Preview.

**Printing is one of the things a document's permissions speak about.** A document that withholds it asks for the owner password first, through the dialog the protection panel uses, saying *Only the owner may print this document*. The permission is checked twice: once here, to ask rather than fail, and once natively against the document itself, so a document that forbids printing is refused even if something upstream forgot to ask.

**Known and deliberate:** the panel's **PDF → Save as PDF** writes an unprotected copy of what is being printed. That is the system's behaviour, not this app's, and it is reachable only by someone who is allowed to print the document in the first place.

#### FR-6.9 — Setting the document's protection
**File → Protect Document…** (`Shift+Cmd+L`) and the lock in the native toolbar, between Delete and Share. The lock is drawn closed while the document asks for a password or withholds anything, and open while it does not — including while that is only what the reader has *asked* for and not yet saved.

A document that **withholds something or asks for a password to open**, and was not opened with the owner's, asks for the owner password first — protection somebody set is theirs to change. The dialog is the one the read-only notice uses (FR-1.9) and says why it is asking: *Only the owner may change this document's protection*, which is a different reason from *This document does not allow changes* and must not borrow its words.

A document that is encrypted but **withholds nothing** — no password to open, every permission granted — opens the panel straight away. Such encryption restricts nobody, and it cannot be told apart from what this app leaves behind itself when protection is removed (§13.16): asking there would be asking for a password that may not exist, and no answer would do.

The password is accepted only if it turns out to be the **owner's**. A document may permit changes and still keep its protection to itself, so a test of whether editing is now allowed would pass the user password and let a reader set passwords on a document that is not theirs to set them on.

**The panel** carries, in the order macOS's own sheet does:

| Control | Meaning |
|---------|---------|
| Require Password To Open Document | The user password. The field pair is disabled until it is ticked |
| Printing | `print` + `fullQualityPrint` |
| Copying | `copyContent` + `accessibilityCopyContent` |
| Page Assembly | `assembleDocument` |
| Annotations | `editAnnotations` |
| Changing the Document | `editContent` |
| Form Filling | `fillFields` |
| Owner password | Required by any restriction; what lifts them all |

Each password is typed twice, because a document locked with a mistyped password is a document nobody can open.

**Changing the Document carries Annotations and Form Filling with it.** Bit 4 of `/P` subsumes bits 6 and 9 — measured in Acrobat DC's Security tab, which reports annotating and form filling as allowed whenever `editContent` is granted regardless of their own bits. While it is ticked the other two are held ticked and cannot be cleared, so the panel and the written file never say different things.

**Changing the Document is a box of its own,** which Apple's sheet does not have: it folds that permission in with the others. It is the one permission PDFSign itself needs in order to place a signature, and a reader who cannot see it cannot tell why their own app stopped being able to sign a document they protected. Withholding it is allowed and warned about.

The panel refuses to close on: a required password that is empty, a pair that does not match, and any restriction without an owner password — restrictions nobody holds the password to are restrictions anyone can lift, which is worse than none because they look like protection. It says which, **above the buttons rather than inside the scrolling part**, and focuses the field that would settle it, which scrolls that field into view: a panel that refuses out of sight looks like a panel that did nothing.

**Remove Protection** answers a wholly open document: no passwords, every permission granted. See §13.16 for the one thing that cannot be taken back off.

**Nothing is written until the document is saved** (ADR-0013). The choice becomes a pending change like any other: it marks the document unsaved, `Cmd+Z` takes it back, and Save, Save As and Share all write it. The encryption algorithm follows the document — one that arrived AES-128 is written back AES-128 — and protection added to a document that had none is AES-256.

Passwords set here live in memory for as long as the window does, under the same rule as the one a document was opened with (FR-1.8): never logged, never written to Recent Files, preferences or the database, never broadcast to another window, and deliberately absent from `toString`.

---

### 3.7 Multi-Window Behaviour

#### FR-7.1 — Window types
| Window | Size | Notes |
|--------|------|-------|
| Welcome | 900×700, min 600×400 | Main window, id `"0"` |
| PDF viewer | 800×600 content | One per document; the size comes from `desktop_multi_window`, which gives every window it creates the same frame |
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

#### FR-7.9 — Window placement
Because every window the plugin creates is handed the same frame, placement is decided natively by `WindowCascade` (`macos/Runner/WindowCascade.swift`), called from the window-created callback in `AppDelegate`. The first window of a run is centred; each one after it is stepped down and to the right with AppKit's `cascadeTopLeft(from:)` — 29 points, measured — which turns the diagonal back to the top or the left edge instead of pushing a window off the screen. The diagonal starts over once the last placed window has closed, so a document opened on its own does not land wherever the previous batch stopped.

The Settings window is placed as well and then centres itself from Dart (FR-7.1), so it consumes a step of the diagonal without occupying it. That is deliberate: the alternative is teaching native code to tell one kind of window from another, for a difference nobody can see.

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
| `Cmd+P` | Print… | PDF window |
| `Opt+Cmd+P` | Print Current Page | PDF window |
| `Shift+Cmd+L` | Protect Document… | PDF window |
| `Cmd+Z` / `Shift+Cmd+Z` | Undo / Redo | PDF window; belongs to a focused text field |
| `Cmd+Backspace` | Delete object (Edit menu) | PDF window |
| `Delete` / `Backspace` | Delete object | PDF window, unless a text field has focus |
| `Cmd+X` / `Cmd+C` / `Cmd+V` | Cut / copy / paste object | PDF viewer |
| `Cmd+V` | Paste image into library | sidebar focused |
| `Cmd+L` / `Cmd+R` | Rotate the page in view left / right | PDF window |
| `Shift+Cmd+F` / `Opt+Shift+Cmd+F` | Bring to Front / Bring Forward | PDF window, with something selected |
| `Shift+Cmd+B` / `Opt+Shift+Cmd+B` | Send to Back / Send Backward | PDF window, with something selected |
| `Cmd+G` | Go to page | PDF window |
| `Cmd+0` | Fit Width | PDF window |
| `Cmd+=` / `Cmd+-` | Zoom in / out | PDF window |
| `Cmd+M` | Minimize | all |
| `PageUp` / `PageDown` | Previous / next page | PDF window |
| `Home` / `End` | First / last page | PDF window |
| Arrows | Scroll by 50 px | PDF window |

The macOS app menu provides About, Settings…, and Quit PDFSign. The Edit and View menus exist only in PDF windows; Edit holds Undo, Redo, Cut, Copy, Paste, the two rotations, the four restacking commands and Delete, and File holds Protect Document… between Save All and Share, and Print… after it.

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
| `SidebarImage` | id, path, name, added-at, order, pixel dimensions, file size, comment, last used size |
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

- **66** `.arb` files in `lib/l10n/`, **137** message keys, generated into `lib/l10n/generated/`.
- **Every file carries every key.** The 48 strings added by the protected-document, restacking, undo and printing work, and the 15 that had been left in English since earlier releases — the View menu, Go to Page, the rotations, cut/copy/paste, the image-limit and clipboard messages — were translated into all 65 languages on 2026-09-17.
- **62** locales are selectable in Settings and registered in `MaterialApp.supportedLocales`.
- RTL is supported for `ar`, `he`, `fa`. The editor forces LTR layout direction so panels keep their sides; text inside widgets still renders RTL.
- Changing the language applies immediately in all open windows via broadcast.

Known localization defects are listed in §13.5 and §13.6.

---

## 7. Security and Privacy

- Fully offline. No network requests, no accounts, no telemetry, no crash reporting.
- All data stays in the user's home directory.
- No encryption at rest — the image library and its files are stored in the clear, consistent with their non-sensitive nature.
- A protected document's password is held in memory only, for as long as its window is open (FR-1.8). The decrypted copy made so that the document can be displayed is likewise memory-only: writing it would leave an unprotected copy of a protected document on disk.
- A document's own protection is never removed. Save, Save As and the copy made for Share all carry it, so a shared file still needs the password its sender's copy needed — which the sender is told.
- `Info.plist` declares usage descriptions for Desktop, Documents, Downloads, network volumes, and removable volumes.
- The app sandbox is disabled (§2.2).

---

## 8. Error Handling

The `Either<Failure, T>` pattern (dartz) is used across data and domain layers. Failure types live in `core/errors/failures.dart`: `FileNotFoundFailure`, `FileAccessFailure`, `InvalidFileFormatFailure`, `FileSizeLimitFailure`, `PasswordRequiredFailure`, `PasswordIncorrectFailure`, `WriteProtectedFailure`, `UnsupportedProtectionFailure`, `PdfLoadFailure`, `PdfRenderFailure`, `RenderCancelledFailure`, `StorageFailure`.

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
| `flutter analyze` | 1245 issues: 0 errors, **0 warnings**, 1245 info |
| Unit tests | **298** — page-column geometry (`PdfPageLayout`), placement rules, dirty-state policy, the clipboard payload codec, image import limits, page-rotation geometry, the writer, reading and writing protected documents, permission bits, restacking, the undo history, what printing composes, sends and refuses, and that every language carries every string |
| Widget tests | **120** — drop placement, off-page snapping, drag feedback, the close-everything flow, cut/copy/paste, page rotation, the password prompt, the read-only notice, the protection panel, restacking and what each action records in the history |
| Native tests | **55** — the toolbar's fixed item set and layout, the enabled state of Delete, undo/redo and restacking, the lock's two faces, window cascading, the CoreGraphics security probe, the title bar that keeps the toolbar's backdrop off the document, and what may be printed (`macos/RunnerTests`) |
| Integration tests | **none** |
| Golden tests | **none** |
| CI | none |

The largest info groups remain `prefer_relative_imports`, `prefer_expression_function_bodies`, `always_put_control_body_on_new_line` and `avoid_catches_without_on_clauses`; see the Import Convention note in `CLAUDE.md` for why the first group cannot be acted on as things stand.

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
| 12.14 | **Page rotation of the whole document at once** | One page at a time is implemented — the page in view, from the toolbar or Edit → Rotate Left / Right (⌘L / ⌘R). Turning every page at once is not |
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

### 13.5 Three translations are unreachable — **closed**
Japanese, Korean, Chinese (Simplified) and Chinese (Traditional) were translated and code-generated but missing from `supportedLocales`, so they were neither selectable nor picked up from the system locale. They were added on 2026-09-17 and are now reachable.

`app_es.arb`, `app_pt.arb` and `app_zh.arb` remain outside the list on purpose: the regional files (`es_ES`, `es_AR`, `es_MX`, `pt_BR`, `pt_PT`, `zh_CN`, `zh_TW`) are what a reader chooses, and the bare files stand behind them as fallbacks.

### 13.6 Hardcoded UI strings
Localized and unused: `savePdfAs`, `savedTo`, `noOriginalPdfStored`, `incorrectPassword`, `removeFromList`, `fileAccessDenied`, `saveFailed`. The corresponding UI uses English literals — `PageIndicator` ("Page N of M"), the sidebar empty state, the viewer's empty/error/password states, and every save-failure snackbar.

### 13.7 Placed objects are clipped to the page
`PdfPageItem` wraps each page in `clipBehavior: Clip.antiAlias`. An object near a page edge has its handles — especially the rotation handle above the top edge — clipped. `PlacedImage`'s doc comment mentions cross-page objects; they are not supported.

### 13.8 The page column is not virtualized
All pages are built into one `Column` inside a `SingleChildScrollView`. Only image *rendering* is lazy, so the widget count is O(page count).

Page measurement itself is no longer a problem: `PdfPageLayout` precomputes page offsets once per (document, scale, viewport width) and answers lookups by binary search, so scrolling no longer walks every page.

### 13.9 Toolbar helpers live in a global mutable dictionary

`toolbarHelpers` in `AppDelegate.swift` is a file-scope mutable dictionary keyed by `ObjectIdentifier(window)` — the window's address, which the allocator reuses. Entries are evicted when a window closes and every lookup confirms ownership, so the stale-entry hazard is closed, but the design is still a global that `CLAUDE.md` would reject in Dart. Attaching the helper to the window (associated object) or to the `FlutterViewController` would remove it.

> The related hazard is gone: the toolbar's item set is now fixed, and Delete is greyed out rather than inserted and removed, so there is no mutation to drift out of step.

### 13.10 Exception classification by string matching
`PdfDocumentRepositoryImpl` maps `pdfx` failures to `Failure` types by searching the exception's `toString()` for `"password"`, `"not found"`, `"permission"`, and similar. Brittle across library versions and locales. See CODE_REVIEW §1.1.

### 13.11 `Cmd` shortcuts only exist in the menu
With a `PlatformMenuBar` installed, a `Cmd` key equivalent never reaches Flutter's focus tree: verified on 2026-09-15 by synthesising key events against the running app, where `PageDown` reached `PdfViewer._handleKeyEvent` and `Cmd+G`, `Cmd+=` and `Cmd+C` did not. A shortcut therefore has to be a menu item to exist at all.

One consequence is still open:

- **`Cmd+A` does not select all in any text field** — the image comment, Go to Page or Settings. Cut/Copy/Paste were fixed by routing the Edit menu through `EditorClipboard`; Select All has no menu item. There are keyboard workarounds (`Shift`+arrows, `Shift`+`Home`/`End`) and mouse ones, and "select all" over *objects* has no meaning here: the editor selects one object at a time.

Go to Page and zoom were reached the same dead way and now have View-menu items. Reload was deleted rather than given one: it reopened the file without refreshing the cached original bytes every save starts from (ADR-0002), so a save after it would have written the stale document and discarded whatever had changed on disk.

### 13.12 Paste is always enabled
`PlatformMenuBar` gives no hook to revalidate a menu item as the menu opens, and polling the pasteboard would be worse. Edit → Paste is therefore always enabled while a document is open and does nothing when the clipboard holds nothing usable. Cut and Copy do better: they follow the selection and the keyboard focus.

### 13.13 Two icons are kept, for two generations of macOS
`macos/Runner/AppIcon.icon` is an Icon Composer document and is what macOS 26 draws: the system puts every app icon on a tile of its own, and only an icon in this format fills it. Measured on 2026-09-16: with the legacy `.icns` alone the artwork was inset inside the tile and the tile's grey showed all round it, whatever the artwork did — a complete `.icns` with all ten representations made no difference, so it is the format, not the sizes.

`AppIcon.appiconset` stays beside it as the icon for macOS 25 and older, and `actool` prefers the `.icon` where both apply. The document must be a file in the Xcode project rather than an entry in the asset catalogue: placed inside `Assets.xcassets` it is ignored, and with the appiconset removed as well the build produced no icon at all.

The `.icns` that `actool` emits still carries only 16, 32, 128 and 256 px. On macOS 26 that no longer matters — the tile is drawn from the new format — and on older systems Get Info upscales from 256.

### 13.14 Pasted images are swept only at a cold start
An image pasted from another application is stored in `pasted/` in app support and has no library row to own it. The folder is emptied when the main window starts, which is the only moment no document window can be holding one of those files. If the app is killed, its scratch files survive until the next launch. Bounded and self-correcting, but not immediate.

### 13.15 The Syncfusion license key is committed
`TODO.md` contains a Syncfusion community license key in plain text. It should be removed from the repository and from history.

### 13.16 Protection cannot be taken all the way off
`PdfSecurity` can be given passwords and permission flags but has no way to remove the `/Encrypt` dictionary from a document. **Remove Protection** (FR-6.9) therefore writes empty passwords and every permission granted: the saved file opens for anyone, in any reader, with nothing withheld, and that is what the reader asked for — but it is still an encrypted PDF, and a tool that reports on encryption (CoreGraphics `isEncrypted`, `qpdf --show-encryption`) will still say it is one.

Pressing Remove on a document that had no protection at all encrypts it in this same open way, and at AES-256, since there is no algorithm to inherit.

This is why the owner-password gate in FR-6.9 turns on what a document *withholds* rather than on whether it is encrypted: a file this app removed protection from is encrypted, opens freely and grants everything, and is indistinguishable from someone else's document with an owner password and no restrictions. Gating on encryption would lock the reader out of their own file with a question nothing could answer.

Taking the dictionary out would mean writing the document's objects into a fresh `PdfDocument`, which loses everything Syncfusion does not carry across — form fields, annotations, bookmarks, tagging. That is a worse trade than an empty `/Encrypt`, so it was not made. `qpdf --decrypt` is the honest way out for a reader who needs one, and the panel does not pretend otherwise.

---

## 14. Document History

| Version | Date | Change |
|---------|------|--------|
| 2.5 | 2026-09-17 | Localization completed: every `.arb` file carries every key, §13.5 closed, §6 figures remeasured. |
| 2.4 | 2026-09-17 | Printing (FR-6.10): the system's panel, the document as the reader sees it, the print permission honoured, and the page in view as a pre-filled range. |
| 2.3 | 2026-09-17 | FR-6.9: the owner-password gate turns on what a document withholds, not on whether it is encrypted, and says which of the two reasons it is asking for. |
| 2.2 | 2026-09-17 | Setting a document's protection (FR-6.9, ADR-0013) and its one limitation (§13.16); FR-6.7 extended to protection; §3.9 shortcuts and FR-2.9 corrected against the menu, which has had no Reload command since 1.2.0; §10 figures remeasured. |
| 2.1 | 2026-09-17 | Protected documents (FR-1.8, FR-1.9, §2.4), object restacking (FR-5.10) and undo/redo (FR-5.11); §12.1, §12.2 and §12.3 closed; FR-5.8 and FR-5.9 corrected against the implementation. |
| 2.0 | 2026-09-15 | Rewritten against the implementation. Removed unbuilt requirements to §12, added §13 technical debt, corrected platform scope, dependencies, entity model, storage map, and localization figures. |
| 1.0 | 2025-11-29 | Original pre-implementation specification (cross-platform, Signatures/Stamps tabs, z-order, undo/redo, `com.nosota.pdfsign`). Superseded. |
