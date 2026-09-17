# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/).

## [1.5.1] — 2026-09-17

### Added

- Japanese, Korean, Chinese (Simplified) and Chinese (Traditional) can be chosen in Settings. The translations existed but were not in the list of supported languages, so those readers saw English

### Changed

- Every language is complete. The strings added by the protected-document, restacking, undo and printing work — and fifteen that had been left in English since earlier releases, among them the View menu, Go to Page, the rotations, cut, copy and paste — are now translated in all 65 languages

## [1.5.0] — 2026-09-17

### Added

- Printing: **File → Print…** (⌘P) and **Print Current Page** (⌥⌘P). The document goes to the printer as it is on screen — objects embedded, pages turned — through the panel macOS shows for PDFs, so copies, page range, paper, orientation, scaling, layout, presets, the preview and Save as PDF all come from the system. Pages are shrunk to fit the paper rather than clipped, and turned to suit it
- A document that withholds printing asks for its owner password first and prints once it is given. The permission is checked against the document itself before anything is sent
- Nothing is written to disk on the way: the document is composed in memory and handed to the system from there

## [1.4.2] — 2026-09-17

### Fixed

- The protection panel says why it refused where the reader is looking: the message now stands above the buttons instead of at the end of the scrolling part, where it could be out of sight on a short window and the panel looked as though Apply had done nothing. The field that would settle it is focused too, which scrolls it into view

## [1.4.1] — 2026-09-17

### Fixed

- The **Enter owner password** button on the read-only notice can be pressed. Nothing in the top 32 points of a document window could be clicked at all: AppKit hangs the toolbar's backdrop over the content there, and it swallows the click before the app sees it. The same strip also held the top edge of an object resting against the top of the view and of the first image in the library

## [1.4.0] — 2026-09-17

### Added

- A document's protection can be set from the app: **File → Protect Document…** (⇧⌘L) and a lock in the toolbar, between Delete and Share. It sets the password that opens the document, the owner password that lifts every restriction, and six permissions — printing, copying, page assembly, annotations, changing the document and form filling. Each password is typed twice
- The lock shows how the document stands: closed while it asks for a password or withholds something, open while it does not
- **Changing the Document** is a checkbox of its own, which macOS's own sheet does not have. It is the permission PDFSign needs in order to place a signature, and withholding it is warned about. It carries annotations and form filling with it, because the PDF bit it writes subsumes theirs
- A protected document asks for its owner password before its protection can be changed, since without it nobody may change it
- **Remove Protection** clears both passwords and grants everything. The saved file opens for anyone with nothing withheld; it remains an encrypted PDF, because the writer has no way to take the encryption dictionary out
- Nothing is written until the document is saved: setting protection marks the document unsaved, ⌘Z takes it back, and Save, Save As and Share all carry it. A document that arrived AES-128 is written back AES-128; protection added to one that had none is AES-256

### Fixed

- Pressing the lock on a document that opens freely and permits everything no longer demands an owner password and no longer says "This document does not allow changes" about a document that plainly does. The password is asked for only when the document withholds something or asks for one to open, and the dialog now says which of the two reasons it is asking for
- A password given to change a document's protection is accepted only if it is the owner's. A document can permit changes and still keep its protection to itself, and the user password used to pass that test

## [1.3.2] — 2026-09-17

### Fixed

- Dragging a library image by its grip reorders the list again, from the first movement. A change made after 1.3.0 was tagged had asked the grip to be held first, which left reordering looking broken

### Added

- The grip beside a library image says what it is for when the pointer rests on it

## [1.3.0] — 2026-09-17

### Added

- Undo and Redo, fifty steps deep: Edit → Undo (⌘Z) / Redo (⇧⌘Z), and a two-part control at the left of the toolbar, each half live only while there is a step that way. Covers placing, moving, resizing, rotating, deleting, cutting, pasting, restacking and turning a page. A whole drag is one step rather than one per frame, and a drag that went nowhere is none. Undoing past a save is allowed and marks the document unsaved again; ⌘Z while typing in a text field belongs to the field
- Objects can be restacked within their page: Bring to Front, Bring Forward, Send Backward, Send to Back, from a four-part control at the left of the toolbar or from the Edit menu (⇧⌘F, ⌥⇧⌘F, ⌥⇧⌘B, ⇧⌘B). The order they are drawn in on screen is the order they are written into the file, so what overlaps what is the same in both
- Password-protected documents can be opened, signed, saved and shared. The password is asked for once, kept only while the window is open, and never written anywhere; Save, Save As and Share all keep the document's own protection, so the saved or shared file still needs the same password. Documents that carry only an owner password — readable by anyone, restricted in what may be done with them — now open at all, where before they were refused
- A document whose permissions forbid changes is opened read-only: nothing can be dropped or pasted onto it, its pages cannot be turned, and it cannot be saved. A notice says why, and takes the owner password to lift it
- A protected document large enough for its memory to matter says so when it opens, because it is shown from memory rather than from the file
- Sharing a protected document says that the copy keeps its password

### Fixed

- Opening several files at once from Finder no longer stacks every window in the same spot with only the last one visible: the first document window is centred and each one after it steps down and to the right, the way macOS places documents. The diagonal returns to the top of the screen rather than walking off it, and starts over once the last window closes

## [1.2.0] — 2026-09-16

### Added

- A library image remembers the size it was last resized to: drag it out again and it arrives at that size, fitted to the page. Objects already placed keep their own sizes, rotation is not remembered, and images pasted from other applications are unaffected
- An application icon: the signed page from `pSGNF.jpg` on a rounded blue square, in the app's own accent colour. macOS 26 draws it from an Icon Composer document and it fills the icon tile the way the system's own apps do; older macOS falls back to the image set beside it. The Windows icon and the Welcome screen logo are cut from what the system composes, so all three match
- A View menu with Zoom In (Cmd+=), Zoom Out (Cmd+-), Fit Width (Cmd+0) and Go to Page (Cmd+G). The zoom controls on screen already worked; their shortcuts did not, and Go to Page could not be opened at all
- Rotate the page in view left or right, from a two-part control at the left of the toolbar or from Edit → Rotate Left / Rotate Right (Cmd+L / Cmd+R). The turn is written into the file as the page's rotation, objects on the page turn with it, and the view stays on the page that was turned
- Images larger than 100 MB or 4096x4096 are refused on import and on paste, with a message naming the limit, instead of being decoded into memory
- Cut, Copy and Paste for objects placed on the document, in the Edit menu and on Cmd+X/C/V
- An image copied in another application can be pasted onto the page; it is stored with the document and does not appear in the image library
- An object copied in PDFSign can be pasted into another application, and into another PDFSign window

- Remember last used directory in File->Open dialog
- Delete button in toolbar and Edit menu
- Single top-center rotate handle (replaced corner rotate zones)
- Transparency to selection handles with hover effect
- Drag feedback: the page that will receive a dropped image is outlined while dragging

### Removed

- Reload document, which was unreachable and unsafe: it reopened the file without refreshing the cached bytes every save starts from, so a later save would have written the stale document

### Changed

- The version is 1.2.0, and About PDFSign shows "Version 1.2.0" rather than repeating the build number in brackets after it
- The page that will receive a dropped image is now marked with an outline alone; the translucent wash over it dimmed the very content the drop was being aimed at
- The toolbar Delete button is now greyed out when nothing is selected instead of disappearing, so the rotate control beside it no longer shifts as the selection changes; it also stands apart from Share rather than beside it
- Close All and Quit now wait for the windows to report their saves instead of sleeping five seconds: closing is immediate in the common case, and a slow save on a large document is no longer mistaken for a failure
- Moving, resizing or rotating an object now counts as an unsaved change, so closing no longer discards it in silence and File → Save stays available
- A drop that lands off-page now snaps to the nearest page instead of silently landing on page 1

### Fixed

- The Go to Page dialog is translated instead of showing English text
- A page the file marks as rotated is no longer displayed squeezed into a portrait slot: pages are laid out at the size they are actually shown at
- An object placed on such a page is no longer saved in the wrong corner of it
- An image the library could not store is no longer counted as added
- Cut, Copy and Paste now work in text fields — the image comment, Go to Page and Settings — where Cmd shortcuts previously did nothing at all

- Closing no longer offered to discard a document whose save was merely still running, which could destroy the window mid-write
- Deleting an object that was already saved into the file no longer reports the document as clean, which used to drop the deletion on close
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
