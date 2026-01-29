# PDFSign

A macOS application for viewing PDF documents and placing images (stamps, signatures, seals) on them.

## Features

- View PDF documents with continuous scrolling
- Place images (stamps, signatures) on PDF pages
- Multi-window mode — each document opens in its own window
- Image library in sidebar with sync between windows
- 50+ interface languages including RTL (Arabic, Hebrew, Persian)
- Native macOS menu support

## Requirements

- macOS 10.15+
- Flutter SDK 3.24.0+
- Dart SDK 3.5.0+

## Setup

```bash
# Clone the repository
git clone https://github.com/ivanvaganov/PDFSign.git
cd PDFSign

# Install dependencies
flutter pub get

# Generate code (Riverpod, Isar, Freezed)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run -d macos
```

## Build

```bash
# Development build
flutter build macos --debug

# Release build
flutter build macos --release
```

## Project Structure

```
lib/
├── core/           # Shared utilities, platform channels, constants
├── domain/         # Entities, repository interfaces
├── data/           # Repository implementations, data sources, services
├── presentation/   # UI (screens, widgets, providers)
└── main.dart       # Entry point
```

## Documentation
- [Architecture](docs/ARCHITECTURE.md) — system architecture overview
- [Providers](docs/PROVIDERS.md) — Riverpod state management
- [Services](docs/SERVICES.md) — business services
- [Repositories](docs/REPOSITORIES.md) — data layer repositories
- [Entities](docs/ENTITIES.md) — domain entities
- [Platform Channels](docs/PLATFORM_CHANNELS.md) — native macOS integration

## Tech Stack

- **Flutter** — UI framework
- **Riverpod** — state management
- **pdfx** — PDF rendering
- **Syncfusion PDF** — PDF manipulation and saving
- **Isar** — local database for image library
- **desktop_multi_window** — multi-window support

## License

Proprietary. All rights reserved.
