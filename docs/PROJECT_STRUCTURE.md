# PDFSign Project Structure

This document provides a detailed overview of the project's file and folder structure.

## Directory Tree

```
PDFSign/
├── android/                    # Android platform code
├── ios/                        # iOS platform code
├── linux/                      # Linux platform code
├── macos/                      # macOS platform code
├── windows/                    # Windows platform code
├── web/                        # Web platform code (not used in Phase 1)
│
├── assets/                     # Static assets
│   ├── images/                # App images, logos
│   └── fonts/                 # Custom fonts (if any)
│
├── docs/                       # Documentation
│   ├── REQUIREMENTS.md        # Full requirements specification
│   ├── GETTING_STARTED.md     # Development guide
│   ├── PROJECT_STRUCTURE.md   # This file
│   └── adr/                   # Architecture Decision Records (future)
│
├── lib/                        # Main application code
│   ├── core/                  # Core/shared layer
│   │   ├── constants/
│   │   │   └── app_constants.dart        # App-wide constants
│   │   ├── errors/
│   │   │   ├── failures.dart             # Failure classes
│   │   │   └── exceptions.dart           # Exception classes
│   │   ├── theme/
│   │   │   ├── app_theme.dart            # Theme configuration
│   │   │   └── app_colors.dart           # Color palette
│   │   ├── utils/
│   │   │   └── typedef.dart              # Type aliases
│   │   └── widgets/
│   │       └── (shared widgets)          # Reusable widgets
│   │
│   ├── domain/                # Domain/business logic layer
│   │   ├── entities/
│   │   │   ├── signature_item.dart       # Signature/stamp entity
│   │   │   ├── placed_object.dart        # Placed object on PDF
│   │   │   └── recent_file.dart          # Recent file entity
│   │   ├── repositories/
│   │   │   ├── signature_repository.dart  # Signature repository interface
│   │   │   ├── pdf_repository.dart       # PDF repository interface
│   │   │   └── settings_repository.dart  # Settings repository interface
│   │   └── usecases/
│   │       ├── signature/
│   │       │   ├── get_signatures.dart   # Get all signatures
│   │       │   ├── add_signature.dart    # Add new signature
│   │       │   └── ...                   # Other signature use cases
│   │       ├── pdf/
│   │       │   ├── open_pdf.dart         # Open PDF file
│   │       │   ├── save_pdf.dart         # Save PDF with objects
│   │       │   └── ...                   # Other PDF use cases
│   │       └── document/
│   │           └── ...                    # Document management use cases
│   │
│   ├── data/                  # Data layer
│   │   ├── models/
│   │   │   ├── signature_item_model.dart # Signature item data model
│   │   │   ├── recent_file_model.dart    # Recent file data model
│   │   │   └── ...                       # Other models
│   │   ├── datasources/
│   │   │   ├── local/
│   │   │   │   ├── signature_local_datasource.dart  # Isar DB operations
│   │   │   │   └── settings_local_datasource.dart   # SharedPreferences
│   │   │   └── storage/
│   │   │       └── pdf_datasource.dart    # PDF file operations
│   │   └── repositories/
│   │       ├── signature_repository_impl.dart  # Signature repo implementation
│   │       ├── pdf_repository_impl.dart        # PDF repo implementation
│   │       └── settings_repository_impl.dart   # Settings repo implementation
│   │
│   ├── presentation/          # Presentation/UI layer
│   │   ├── blocs/
│   │   │   ├── signature_library/
│   │   │   │   ├── signature_library_bloc.dart
│   │   │   │   ├── signature_library_event.dart
│   │   │   │   └── signature_library_state.dart
│   │   │   ├── pdf_viewer/
│   │   │   │   ├── pdf_viewer_bloc.dart
│   │   │   │   ├── pdf_viewer_event.dart
│   │   │   │   └── pdf_viewer_state.dart
│   │   │   └── editor/
│   │   │       ├── editor_bloc.dart
│   │   │       ├── editor_event.dart
│   │   │       └── editor_state.dart
│   │   ├── screens/
│   │   │   ├── welcome/
│   │   │   │   └── welcome_screen.dart       # Desktop welcome screen
│   │   │   └── editor/
│   │   │       ├── editor_screen.dart        # Main editor screen
│   │   │       ├── desktop_editor_layout.dart
│   │   │       └── mobile_editor_layout.dart
│   │   └── widgets/
│   │       ├── common/
│   │       │   ├── loading_indicator.dart
│   │       │   ├── error_dialog.dart
│   │       │   └── selection_handles.dart
│   │       ├── signature_panel/
│   │       │   ├── signature_panel.dart
│   │       │   ├── signature_card.dart
│   │       │   └── signature_bottom_sheet.dart  # Mobile
│   │       └── pdf_canvas/
│   │           ├── pdf_canvas.dart
│   │           ├── pdf_page_widget.dart
│   │           └── placed_object_widget.dart
│   │
│   ├── injection/             # Dependency injection
│   │   ├── injection_container.dart        # DI configuration
│   │   └── injection_container.config.dart # Generated DI code
│   │
│   ├── l10n/                  # Localization
│   │   ├── app_en.arb         # English translations
│   │   └── app_ru.arb         # Russian translations
│   │
│   └── main.dart              # Application entry point
│
├── test/                       # Tests
│   ├── unit/                  # Unit tests
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── data/
│   │       ├── models/
│   │       ├── datasources/
│   │       └── repositories/
│   ├── widget/                # Widget tests
│   │   └── widgets/
│   └── integration/           # Integration tests
│       └── app_test.dart
│
├── .gitignore                 # Git ignore rules
├── analysis_options.yaml      # Linter configuration
├── l10n.yaml                  # Localization configuration
├── pubspec.yaml               # Dependencies and project metadata
├── README.md                  # Project overview and setup
└── CLAUDE.md                  # Development rules and guidelines
```

---

## Layer Descriptions

### Core Layer (`lib/core/`)

**Purpose:** Shared utilities, constants, and configurations used across all layers.

**Key Files:**
- `constants/app_constants.dart` - Application-wide constants (limits, sizes, keys)
- `errors/failures.dart` - Failure classes for error handling
- `errors/exceptions.dart` - Exception classes thrown by data sources
- `theme/app_theme.dart` - Material theme configuration
- `theme/app_colors.dart` - Color palette definitions
- `utils/typedef.dart` - Common type aliases

**Rules:**
- No dependencies on other layers
- Pure Dart only (no Flutter dependencies preferred)
- Can be used by any layer

---

### Domain Layer (`lib/domain/`)

**Purpose:** Business logic and rules. Platform-independent.

#### Entities (`lib/domain/entities/`)
Pure business objects with no external dependencies.

- `signature_item.dart` - Represents a signature or stamp in the library
- `placed_object.dart` - Represents a signature/stamp placed on a PDF page
- `recent_file.dart` - Represents a recently opened PDF file

#### Repositories (`lib/domain/repositories/`)
Abstract interfaces defining data operations. Implementations are in the data layer.

- `signature_repository.dart` - Operations for signature library
- `pdf_repository.dart` - Operations for PDF files
- `settings_repository.dart` - Operations for app settings

#### Use Cases (`lib/domain/usecases/`)
Single-responsibility classes encapsulating business operations.

**Structure:**
```dart
class UseCase {
  final Repository _repository;

  UseCase(this._repository);

  ResultFuture<ReturnType> call(Params params) async {
    // Business logic here
    return _repository.method(params);
  }
}
```

**Examples:**
- `signature/get_signatures.dart` - Retrieve all signatures
- `signature/add_signature.dart` - Add new signature to library
- `pdf/open_pdf.dart` - Open and validate PDF file
- `pdf/save_pdf.dart` - Save PDF with placed objects

**Rules:**
- NO Flutter dependencies
- NO platform-specific code
- ONLY depends on repository interfaces
- 100% unit test coverage required

---

### Data Layer (`lib/data/`)

**Purpose:** Data sources and repository implementations.

#### Models (`lib/data/models/`)
Data transfer objects with serialization logic.

**Key Features:**
- JSON serialization (if needed)
- Database annotations (Isar)
- Conversion to/from domain entities

**Example:**
```dart
@collection
class SignatureItemModel {
  Id id = Isar.autoIncrement;
  late String uuid;
  // ... other fields

  // Convert to domain entity
  SignatureItem toEntity() => SignatureItem(...);

  // Create from domain entity
  factory SignatureItemModel.fromEntity(SignatureItem entity) => ...;
}
```

#### Data Sources (`lib/data/datasources/`)

**Local Data Sources:**
- `local/signature_local_datasource.dart` - Isar database operations
- `local/settings_local_datasource.dart` - SharedPreferences operations

**Storage Data Sources:**
- `storage/pdf_datasource.dart` - PDF file operations (Syncfusion)

**Responsibilities:**
- Direct database/file/API access
- Throw exceptions on errors
- No business logic

#### Repositories (`lib/data/repositories/`)
Implementations of domain repository interfaces.

**Responsibilities:**
- Coordinate data sources
- Transform exceptions to failures
- Return `Either<Failure, Success>`

**Pattern:**
```dart
@LazySingleton(as: SignatureRepository)
class SignatureRepositoryImpl implements SignatureRepository {
  final SignatureLocalDataSource _localDataSource;

  @override
  ResultFuture<List<SignatureItem>> getSignatures() async {
    try {
      final models = await _localDataSource.getSignatures();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
```

---

### Presentation Layer (`lib/presentation/`)

**Purpose:** UI and state management.

#### BLoCs (`lib/presentation/blocs/`)
State management using the BLoC pattern.

**Structure per BLoC:**
```
bloc_name/
├── bloc_name_bloc.dart      # Main BLoC class
├── bloc_name_event.dart     # Event classes
└── bloc_name_state.dart     # State classes
```

**Key BLoCs:**
- `signature_library/` - Manages signature/stamp library
- `pdf_viewer/` - Manages PDF viewing and rendering
- `editor/` - Manages object placement, transforms, undo/redo

**Rules:**
- Events are immutable, past-tense (`SignatureAdded`, `PdfOpened`)
- States are immutable, present-tense (`Loading`, `Loaded`, `Error`)
- BLoCs don't access other BLoCs directly
- Use repositories via use cases only

#### Screens (`lib/presentation/screens/`)
Full-screen widgets, typically with a Scaffold.

**Desktop Screens:**
- `welcome/welcome_screen.dart` - Initial screen with "Open PDF" + recent files

**Shared Screens:**
- `editor/editor_screen.dart` - Main editing interface
- `editor/desktop_editor_layout.dart` - Desktop-specific layout
- `editor/mobile_editor_layout.dart` - Mobile-specific layout

#### Widgets (`lib/presentation/widgets/`)
Reusable UI components.

**Common Widgets:**
- `common/loading_indicator.dart` - Loading spinner
- `common/error_dialog.dart` - Error display
- `common/selection_handles.dart` - Transform handles for selected objects

**Feature Widgets:**
- `signature_panel/` - Right panel with signatures/stamps (desktop)
- `signature_panel/signature_bottom_sheet.dart` - Bottom sheet (mobile)
- `pdf_canvas/` - PDF viewer canvas with placed objects

**Widget Principles:**
- Prefer `const` constructors
- Extract complex widgets to separate files
- Keep build methods < 50 lines
- Stateless when possible

---

### Injection Layer (`lib/injection/`)

**Purpose:** Dependency injection configuration.

**Files:**
- `injection_container.dart` - Manual configuration
- `injection_container.config.dart` - Generated by `injectable`

**Usage:**
```dart
// In main.dart
await configureDependencies();

// In widgets/BLoCs
final useCase = getIt<UseCase>();
```

**Annotations:**
- `@singleton` - Single instance for entire app lifetime
- `@lazySingleton` - Created on first access, then reused
- `@injectable` - Factory (new instance each time)

---

### Localization (`lib/l10n/`)

**Files:**
- `app_en.arb` - English translations
- `app_ru.arb` - Russian translations

**Usage in code:**
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Text(AppLocalizations.of(context)!.openPdf)
```

**Adding new strings:**
1. Add to `app_en.arb`:
   ```json
   "myNewString": "Hello World",
   "@myNewString": {
     "description": "Greeting message"
   }
   ```
2. Add to `app_ru.arb`:
   ```json
   "myNewString": "Привет Мир"
   ```
3. Run `flutter gen-l10n`

---

## Test Structure (`test/`)

### Unit Tests (`test/unit/`)
Test individual classes in isolation.

**Coverage target:** 80%+

**Structure mirrors `lib/` structure:**
```
test/unit/
├── domain/
│   ├── entities/
│   ├── repositories/  # Mock tests (verify calls)
│   └── usecases/      # Use case logic tests
└── data/
    ├── models/        # Model conversion tests
    ├── datasources/   # Data source tests (with mocks)
    └── repositories/  # Repository implementation tests
```

### Widget Tests (`test/widget/`)
Test widgets in isolation.

**Structure:**
```
test/widget/
└── widgets/
    ├── common/
    ├── signature_panel/
    └── pdf_canvas/
```

### Integration Tests (`test/integration/`)
Test full user flows.

**Examples:**
- Open PDF and add signature
- Undo/redo operations
- Save modified PDF

---

## Platform-Specific Code

### Android (`android/`)
- `app/build.gradle` - Build configuration
- `app/src/main/AndroidManifest.xml` - Permissions, activities
- `app/src/main/kotlin/` - Native Kotlin code (if needed)

### iOS (`ios/`)
- `Runner.xcworkspace` - Xcode project
- `Runner/Info.plist` - App configuration, permissions
- `Podfile` - CocoaPods dependencies

### Desktop
- `windows/` - Windows C++ runner
- `macos/` - macOS Swift runner
- `linux/` - Linux C++ runner

---

## Configuration Files

### `pubspec.yaml`
Project metadata and dependencies.

**Sections:**
- `dependencies:` - Runtime dependencies
- `dev_dependencies:` - Development tools
- `flutter:` - Flutter-specific configuration (assets, fonts)

### `analysis_options.yaml`
Dart analyzer and linter rules.

**Key features:**
- Strict linting (follows `flutter_lints`)
- Custom rules for clean code
- Excludes generated files

### `l10n.yaml`
Localization configuration.

**Settings:**
- ARB file location
- Output class name
- Synthetic package setting

---

## Generated Files (Excluded from Git)

These files are generated and should NOT be committed:

```
*.g.dart                    # JSON serialization
*.freezed.dart              # Immutable classes
*.config.dart               # Dependency injection
lib/generated/              # Flutter generated code
.dart_tool/                 # Dart tools
build/                      # Build artifacts
```

**Regenerate with:**
```bash
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

---

## Key Principles

### Clean Architecture
```
Domain Layer (Business Logic)
    ↑
Data Layer (Data Sources)
    ↑
Presentation Layer (UI)
```

**Dependency Rule:** Dependencies point INWARD only.
- Presentation depends on Domain
- Data depends on Domain
- Domain depends on NOTHING

### SOLID Principles

**S**ingle Responsibility - Each class has one reason to change
**O**pen/Closed - Open for extension, closed for modification
**L**iskov Substitution - Derived classes substitutable for base classes
**I**nterface Segregation - Many specific interfaces > one general interface
**D**ependency Inversion - Depend on abstractions, not concretions

### Project-Specific Rules

1. **No hardcoded strings** - Use localization
2. **No magic numbers** - Define constants
3. **Prefer const** - Use const constructors
4. **Extract complex logic** - Keep methods < 30 LOC
5. **Document public APIs** - Use dartdoc comments

---

## Quick Navigation

| I want to... | Go to... |
|--------------|----------|
| Add a new entity | `lib/domain/entities/` |
| Create a use case | `lib/domain/usecases/` |
| Implement data fetching | `lib/data/datasources/` |
| Create a new screen | `lib/presentation/screens/` |
| Add a reusable widget | `lib/presentation/widgets/common/` |
| Define a new color | `lib/core/theme/app_colors.dart` |
| Add a constant | `lib/core/constants/app_constants.dart` |
| Add a translation | `lib/l10n/app_en.arb` and `app_ru.arb` |
| Configure DI | `lib/injection/injection_container.dart` |

---

**Happy coding! 🎉**
