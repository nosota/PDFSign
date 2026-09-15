# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/).

## [Unreleased]

### Added

- Remember last used directory in File->Open dialog
- Delete button in toolbar and Edit menu
- Single top-center rotate handle (replaced corner rotate zones)
- Transparency to selection handles with hover effect
- Drag feedback: the page that will receive a dropped image is outlined while dragging

### Changed

- A drop that lands off-page now snaps to the nearest page instead of silently landing on page 1

### Fixed

- Crash when the Delete toolbar button was shown on a toolbar that already carried it — NSToolbar raised an uncatchable exception and the whole app aborted
- Opening a second document no longer removes the Delete button from the first window: every window now owns its toolbar instead of sharing one by identifier
- Delete toolbar button no longer appears in a freshly opened window before anything is selected, and a request that arrives before the toolbar exists is no longer lost
- Drop outline now follows the page when the view scrolls under a held pointer, instead of pointing at the page that was under the cursor before the scroll
- A library image with a zero dimension no longer produces an invalid size in the sidebar, the drag ghost or the placed object
- Test target could not build since the app was renamed to PDFSign
- Image dropped from the sidebar now lands under the cursor instead of jumping up and to the left
- Drop hit-testing for documents with pages of differing widths while scrolled horizontally
- An off-page drop no longer creates an unselected, invisible object on page 1 while marking the document dirty
- Continuous repainting while a document was open and idle, caused by the visible-page range notifying on every frame
- First page is no longer dropped from the visible range when a second page is on screen
- Current-page indicator no longer falls back to page 1 past the end of the document
- Clear dirty flag when all placed images are deleted
- Restore page position after Save As
- Reload PDF after Save As to show embedded images
- ScaffoldMessenger error in Save As file switching
- CustomPaint stem blocking image mouse events
- Title bar blur area

## [0.0.5] — 2026-01-11

### Added

- Welcome Screen with Clean Architecture and modern UI/UX
- PDF viewer with pdfx and macOS Preview-like styling
- Keyboard shortcuts and pinch-to-zoom for PDF viewer
- 500% zoom, zoom limits, focal zoom, horizontal scroll
- Multi-window support with File menu and Share
- Floating page effect with horizontal padding when zoomed
- Cmd+G navigation with page indicator
- Native Share button in macOS title bar
- Cmd+R to reload document preserving current page
- Resizable image sidebar with multi-window sync
- Drag-and-drop image placement on PDF pages
- Clipboard paste support for sidebar images
- Copy sidebar images to app data folder
- Drag-and-drop for images in sub-windows
- Figma-style selection handles with rotation
- Hover effect on corner and side handles
- Drag-drop image placement with auto-selection
- Comments for sidebar images
- Save and Save As menu items with full i18n localization
- Grip handle to separate reorder and drag-to-PDF gestures
- Figma-style scale + opacity drag shadow
- Window menu with localized translations
- macOS Finder integration for opening PDF files
- App icon on Welcome Screen
- Folder permission handling with retry logic
- Localized folder permission waiting message
- Prevent opening the same PDF file twice
- Save All command with reactive menu state
- Settings window singleton with race condition protection
- macOS app menu and auto-hide welcome screen

### Fixed

- Preserve placed images during zoom with keepAlive provider
- Keep grabbing cursor stable during rotation over handles
- Disable macOS sandbox to allow recent files to open after restart
- Preserve aspect ratio during zoom to prevent text distortion
- PDF page rendering errors during rapid zoom/scroll
- Resolve menu not appearing on first PDF opened from Finder
- FileOpenHandler error handling and cleanup
- Handle save errors during Close All and Quit operations
- Show save dialog on Cmd+Q from Settings window
- Only recent files list scrollable on Welcome screen
- Ref-after-dispose error in AppMenuBar async methods
- Extend gray background to fill viewport when zoomed out
- Save confirmation dialog for window close and Cmd+Q
- Enforce Settings singleton across all Flutter engines
- Native window list for multi-window close detection
- Settings singleton and proper window close method
- PlatformMenuBar rendered only in focused window
- Save menu race condition with multiple windows
- Hide Welcome Screen on menu-triggered file open
- Focus returns to PDF viewer on object selection
- Respect text input focus for Delete/Backspace shortcuts

### Changed

- Bundle identifier changed to com.ivanvaganov.pdfsign
- Renamed app from pdfsign to PDFSign
- Image sidebar moved to right side, header removed
- Zoom preset checkmark shows current scale
- Recent files limit increased from 10 to 12
- Optimize pinch-to-zoom with Transform.scale

## [0.0.4] — 2026-01-09

### Added

- Production-ready PDF viewer with continuous scroll and zoom
- PDF viewer zoom: fit-to-width default, 10%-500% range

### Fixed

- Clamp opacity value in EmptyState animation

## [0.0.3] — 2025-11-29

### Changed

- Removed editor functionality, kept welcome screen as base for rewrite

## [0.0.2] — 2025-11-29

### Changed

- Migrated from BLoC to Riverpod for state management

## [0.0.1] — 2025-11-29

### Added

- Initial project structure
- Basic application scaffold
