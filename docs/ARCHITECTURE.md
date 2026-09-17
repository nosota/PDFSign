# Architecture Overview

PDFSign follows Clean Architecture with Riverpod for state management.

## Project Structure

```
lib/
├── core/                  # Shared utilities
│   ├── constants/         # App constants
│   ├── errors/            # Failure types
│   ├── platform/          # Platform channels
│   └── window/            # Window management
├── domain/                # Business logic (pure Dart)
│   ├── entities/          # Domain entities
│   └── repositories/      # Repository interfaces
├── data/                  # Data layer
│   ├── datasources/       # Data sources (Isar, SharedPreferences)
│   ├── models/            # Data models (serialization)
│   ├── repositories/      # Repository implementations
│   └── services/          # Business services
├── presentation/          # UI layer
│   ├── apps/              # App widgets (Welcome, PDF Viewer, Settings)
│   ├── providers/         # Riverpod providers
│   ├── screens/           # Screen widgets
│   └── widgets/           # Reusable widgets
└── main.dart              # Entry point
```

## Layer Dependencies

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│  (screens, widgets, providers)          │
└─────────────────┬───────────────────────┘
                  │ depends on
                  ▼
┌─────────────────────────────────────────┐
│             Domain Layer                │
│  (entities, repository interfaces)      │
└─────────────────┬───────────────────────┘
                  │ implemented by
                  ▼
┌─────────────────────────────────────────┐
│              Data Layer                 │
│  (implementations, services, models)    │
└─────────────────────────────────────────┘
```

**Rules:**
- Domain layer has NO external dependencies (pure Dart)
- Data layer depends ONLY on Domain
- Presentation layer depends ONLY on Domain
- Core utilities can be used by all layers

## State Management

PDFSign uses **Riverpod** with code generation (`riverpod_annotation`).

### Provider Types Used

| Type | Usage |
|------|-------|
| `@Riverpod(keepAlive: true)` | Persistent state (document, placed images) |
| `@riverpod` | Ephemeral state (selection, UI state) |
| `StreamNotifier` | Real-time sync (sidebar images) |
| `FutureProvider` | Async loading (recent files) |
| `Provider` | Computed values, services |

### Key Providers

- **PdfDocument** — PDF viewing state and navigation
- **PlacedImages** — Images placed on PDF pages
- **SidebarImages** — Image library with multi-window sync
- **EditorSelection** — Selected placed image
- **DocumentDirty** — Unsaved changes tracking

See [PROVIDERS.md](PROVIDERS.md) for complete documentation.

## Multi-Window Architecture

PDFSign supports multiple windows using `desktop_multi_window`:

- **Welcome Window** (ID "0") — Main window, shows on launch
- **PDF Viewer Windows** — One per open document
- **Settings Window** — Singleton, one instance max

Each window runs in a separate Flutter engine with isolated Dart memory.
Document windows are positioned natively by `WindowCascade`, which centres the first and
cascades the rest; the plugin itself gives every window the same frame (REQUIREMENTS §FR-7.9).

### Inter-Window Communication

| Mechanism | Purpose |
|-----------|---------|
| **WindowBroadcast** | Preferences sync, Save All, Close All |
| **Isar Stream** | Sidebar images real-time sync |
| **Native Storage** | Settings singleton, open files tracking |

See [PLATFORM_CHANNELS.md](PLATFORM_CHANNELS.md) for native integration details.

## Data Storage

| Data | Storage | Location |
|------|---------|----------|
| Sidebar images | Isar database | `~/Documents/pdfsign.isar` (via `getApplicationDocumentsDirectory()`) |
| Image files | File system | `~/Library/Application Support/.../images/` (via `getApplicationSupportDirectory()`) |
| Recent files | SharedPreferences | UserDefaults |
| Preferences | SharedPreferences | UserDefaults |

## PDF Processing

| Operation | Library |
|-----------|---------|
| Viewing/Rendering | pdfx |
| Saving with images | Syncfusion PDF |

### Rendering Pipeline

1. **Lazy Loading** — Only visible pages + 2 buffer pages rendered
2. **LRU Cache** — 10 pages cached, scale quantized to 2 decimals
3. **Render Cancellation** — Pages scrolled out of view cancelled

### Page Geometry

`PdfPageLayout` (`presentation/screens/editor/widgets/pdf_viewer/pdf_page_layout.dart`)
is the single source of truth for where pages sit in the scrollable column.
Both `PdfPageList`, which lays the pages out, and `PdfDropTarget`, which
hit-tests them for drag-and-drop, derive their geometry from it, so layout and
hit-testing cannot drift apart.

It precomputes cumulative page offsets once per (document, scale, viewport
width) and answers lookups — page at a point, nearest page, visible range,
page at the viewport centre — by binary search. `PdfPageLayoutCache` keeps the
instance alive across scroll ticks and pointer moves.

### Save Pipeline

1. Read original PDF bytes (from OriginalPdfStorage)
2. Open with Syncfusion PDF
3. For each page with images, draw images using `graphics.drawImage()`
4. Save to output path
5. Images are permanently embedded (not metadata)

## Documentation

| Document | Description |
|----------|-------------|
| [PROVIDERS.md](PROVIDERS.md) | All Riverpod providers with methods |
| [SERVICES.md](SERVICES.md) | Business services documentation |
| [REPOSITORIES.md](REPOSITORIES.md) | Repository interfaces and implementations |
| [ENTITIES.md](ENTITIES.md) | Domain entities |
| [PLATFORM_CHANNELS.md](PLATFORM_CHANNELS.md) | Native macOS integration |
| [adr/](adr/) | Architecture Decision Records |

## Key Design Decisions

Design decisions are documented as Architecture Decision Records in [adr/](adr/):

| ADR | Decision |
|-----|----------|
| [ADR-0001](adr/0001-images-copied-to-app-storage.md) | Images copied to app storage on import |
| [ADR-0002](adr/0002-original-pdf-caching.md) | Original PDF bytes cached for clean saves |
| [ADR-0003](adr/0003-no-cascade-deletion.md) | No cascade deletion of placed images |
| [ADR-0004](adr/0004-dirty-state-tracking.md) | Only add/delete marks document dirty — *superseded by ADR-0008* |
| [ADR-0005](adr/0005-settings-singleton-via-native-storage.md) | Settings singleton via native storage |
| [ADR-0006](adr/0006-multi-window-isolated-engines.md) | Multi-window with isolated Flutter engines |
| [ADR-0007](adr/0007-lazy-pdf-rendering-with-lru-cache.md) | Lazy PDF rendering with LRU cache |
| [ADR-0008](adr/0008-dirty-state-derived-from-a-baseline.md) | Dirty state derived from a baseline, not flagged per operation |
| [ADR-0009](adr/0009-clipboard-via-the-system-pasteboard.md) | Cut/copy/paste through the system pasteboard, driven from the Edit menu |
| [ADR-0010](adr/0010-page-rotation-via-rotate.md) | Page rotation written as `/Rotate`, with the editor working in the page as displayed |
| [ADR-0011](adr/0011-protected-pdfs-decrypted-in-memory.md) | Protected PDFs opened with the writer and rendered from a decrypted copy held in memory |
| [ADR-0012](adr/0012-undo-history-as-snapshots.md) | Undo and redo as snapshots of the editable state rather than a command per action |
