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
| Sidebar images | Isar database | `~/Library/Application Support/.../isar/` |
| Image files | File system | `~/Library/Application Support/.../images/` |
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
| [USER_GUIDE_RU.md](USER_GUIDE_RU.md) | User documentation (Russian) |

## Key Design Decisions

### 1. Images Copied to App Storage

When adding image to sidebar, it's copied to app storage folder. This ensures:
- Images work even if original file is moved/deleted
- Consistent paths across sessions
- Independence from external file changes

### 2. Original PDF Caching

Original PDF bytes are cached (in memory or temp file) when opening. This allows:
- Multiple Save operations without accumulating embedded images
- Always starting from clean original
- Memory-efficient handling of large files (>50MB → temp file)

### 3. No Cascade Deletion

Deleting sidebar image does NOT delete placed images. This is intentional:
- Placed images are independent copies
- User might want to keep placed images
- Less surprising behavior

### 4. Dirty State Tracking

Only add/duplicate/delete operations mark document as dirty:
- Move, resize, rotate do NOT trigger dirty flag
- Intentional design decision for user experience
- Can be changed if needed

### 5. Window Singleton via Native Storage

Settings window singleton uses native UserDefaults storage:
- Each Flutter engine has isolated Dart memory
- Native storage is shared across all engines
- Provides single source of truth for window ID
