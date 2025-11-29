# PDFSign

A cross-platform (Desktop and Mobile) Flutter application for adding signature and stamp images to PDF documents while preserving the original PDF structure.

## Features

- 📄 **PDF Viewing** - Continuous scrolling with zoom controls
- ✍️ **Signature & Stamp Library** - Manage your signatures and stamps
- 🎯 **Drag & Drop** - Easy placement on PDF pages
- 🔄 **Transform Objects** - Move, rotate, scale, and adjust z-order
- ↩️ **Undo/Redo** - 50 levels of history
- 💾 **Preserve PDF Structure** - Keeps text, links, forms, and metadata
- 🔒 **Password-Protected PDFs** - Supports encrypted documents
- 🌍 **Localization** - English and Russian
- 🎨 **Modern UI** - Light, minimalist design

## Platforms

- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ iOS
- ✅ Android

## Prerequisites

### Required

- **Flutter SDK**: 3.24.0 or higher (stable channel)
- **Dart SDK**: 3.5.0 or higher

### Platform-Specific Requirements

#### iOS Development
- macOS with Xcode 13.0+
- CocoaPods

#### Android Development
- Android Studio or Android SDK
- Java JDK 11+

#### Desktop Development
- **Windows**: Visual Studio 2019+ with C++ desktop development
- **macOS**: Xcode 13.0+
- **Linux**:
  ```bash
  sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
  ```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/pdfsign.git
cd pdfsign
```

### 2. Install Flutter

Follow the official Flutter installation guide:
https://docs.flutter.dev/get-started/install

Verify your installation:
```bash
flutter doctor
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Generate Code

The project uses code generation for dependency injection, localization, and serialization:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Configure Syncfusion License

**Important**: This application uses Syncfusion Community License (free for companies with < $1M annual revenue).

1. Register at https://www.syncfusion.com/account/claim-license-key
2. Get your Community License key
3. Open `lib/core/constants/app_constants.dart`
4. Replace the empty `syncfusionLicenseKey` with your key:
   ```dart
   static const String syncfusionLicenseKey = 'YOUR_LICENSE_KEY_HERE';
   ```
5. Uncomment the license registration in `lib/main.dart`:
   ```dart
   SyncfusionLicense.registerLicense(AppConstants.syncfusionLicenseKey);
   ```

## Running the Application

### Desktop

```bash
# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

### Mobile

```bash
# iOS (requires macOS)
flutter run -d ios

# Android
flutter run -d android
```

### Select Device

To see available devices:
```bash
flutter devices
```

## Development

### Project Structure

The project follows **Clean Architecture** with the following structure:

```
lib/
├── core/               # Shared utilities, constants, theme
├── domain/             # Business logic (entities, repositories, use cases)
├── data/               # Data sources and repository implementations
├── presentation/       # UI layer (BLoCs, screens, widgets)
├── injection/          # Dependency injection configuration
└── l10n/              # Localization files (ARB)
```

### Code Generation

Whenever you modify files with annotations (`@injectable`, `@freezed`, etc.):

```bash
dart run build_runner watch
```

Or for a one-time build:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Localization

To add or modify translations:

1. Edit `lib/l10n/app_en.arb` (English)
2. Edit `lib/l10n/app_ru.arb` (Russian)
3. Run code generation:
   ```bash
   flutter gen-l10n
   ```

### Linting

Check code quality:

```bash
flutter analyze
```

The project uses strict linting rules defined in `analysis_options.yaml`.

## Testing

### Run All Tests

```bash
flutter test
```

### Run with Coverage

```bash
flutter test --coverage
```

### View Coverage Report

```bash
# Install coverage tools
dart pub global activate coverage

# Generate HTML report
genhtml coverage/lcov.info -o coverage/html

# Open report (macOS/Linux)
open coverage/html/index.html
```

**Target Coverage**: 80%+

## Building for Release

### Desktop

```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

Builds are located in `build/{platform}/release/`

### Mobile

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (requires macOS)
flutter build ios --release
```

## Architecture

### Clean Architecture Layers

1. **Domain Layer** (Pure Dart)
   - Entities: Core business objects
   - Repositories: Abstract interfaces
   - Use Cases: Business logic

2. **Data Layer**
   - Models: Data transfer objects
   - Data Sources: Local storage (Isar), file system
   - Repository Implementations

3. **Presentation Layer**
   - BLoCs: State management
   - Screens: Full-page widgets
   - Widgets: Reusable UI components

### State Management

- **Pattern**: BLoC (Business Logic Component)
- **Package**: `flutter_bloc`
- **Principles**:
  - Events are immutable, past-tense
  - States are immutable, present-tense
  - BLoCs don't access other BLoCs directly

### Dependency Injection

- **Package**: `get_it` + `injectable`
- **Registration**: Automatic via annotations
- **Access**: `getIt<Type>()`

## Key Dependencies

| Package | Purpose |
|---------|---------|
| `syncfusion_flutter_pdf` | PDF manipulation |
| `syncfusion_flutter_pdfviewer` | PDF rendering |
| `flutter_bloc` | State management |
| `go_router` | Navigation |
| `get_it` | Dependency injection |
| `isar` | Local database |
| `file_picker` | File selection |
| `dartz` | Functional programming (Either) |

See `pubspec.yaml` for the complete list.

## Troubleshooting

### Flutter Doctor Issues

Run `flutter doctor -v` to diagnose platform setup issues.

### Code Generation Fails

```bash
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Syncfusion License Error

Ensure you've:
1. Registered for a Community License
2. Added the key to `app_constants.dart`
3. Uncommented the registration in `main.dart`

### Platform-Specific Issues

**macOS/iOS**: Enable signing in Xcode
**Android**: Check `android/app/build.gradle` for correct SDK versions
**Linux**: Ensure all required libraries are installed

## Documentation

- **Requirements**: `docs/REQUIREMENTS.md`
- **Architecture Decisions**: `docs/adr/` (to be created)
- **API Docs**: Generate with `dart doc`

## Contributing

1. Follow the coding style in `analysis_options.yaml`
2. Write tests for new features (target: 80%+ coverage)
3. Update localization files for new strings
4. Run linter before committing: `flutter analyze`
5. Follow Clean Architecture principles

## License

This project uses Syncfusion Community License.
Annual revenue must be less than $1 million USD.

See [Syncfusion License Agreement](https://www.syncfusion.com/products/communitylicense) for details.

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Syncfusion Flutter PDF](https://help.syncfusion.com/flutter/pdf/overview)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## Support

For issues and feature requests, please use the GitHub issue tracker.

---

**Version**: 1.0.0
**Status**: In Development
