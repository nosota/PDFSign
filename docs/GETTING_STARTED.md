# Getting Started with PDFSign Development

This document outlines the next steps for implementing the PDFSign application based on the generated skeleton.

## Current State

✅ **Completed:**
- Project structure (Clean Architecture)
- Core layer (errors, constants, theme)
- Domain layer (entities, repositories, use cases)
- Dependency injection setup
- Localization infrastructure (en, ru)
- Main entry point
- Requirements specification
- Configuration files

⏳ **Remaining:**
- Data layer implementation
- Presentation layer (BLoCs, screens, widgets)
- Platform-specific code
- Tests
- Full use case implementations

---

## Next Steps

### Phase 1: Data Layer Implementation (Priority: HIGH)

#### 1.1 Create Data Models

Create Isar models for signature storage:

```dart
// lib/data/models/signature_item_model.dart
@collection
class SignatureItemModel {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String name;
  @Enumerated(EnumType.name)
  late SignatureType type;
  late List<byte> imageData;
  late int order;
  late DateTime createdAt;
  late String originalFileName;
  late String mimeType;

  // Mapper methods to/from domain entity
  SignatureItem toEntity() { ... }
  factory SignatureItemModel.fromEntity(SignatureItem entity) { ... }
}
```

#### 1.2 Implement Data Sources

**Local Data Source (Isar):**
```dart
// lib/data/datasources/local/signature_local_datasource.dart
abstract class SignatureLocalDataSource {
  Future<List<SignatureItemModel>> getSignatures();
  Future<List<SignatureItemModel>> getStamps();
  Future<SignatureItemModel> addSignature(...);
  Future<void> updateItem(SignatureItemModel item);
  Future<void> deleteItem(String id);
}

class SignatureLocalDataSourceImpl implements SignatureLocalDataSource {
  final Isar isar;
  // Implementation using Isar queries
}
```

**PDF Data Source (Syncfusion):**
```dart
// lib/data/datasources/storage/pdf_datasource.dart
abstract class PdfDataSource {
  Future<int> openPdf({required String path, String? password});
  Future<void> closePdf();
  Future<Uint8List> renderPage({required int pageNumber, int dpi});
  Future<void> savePdf({...});
}

class PdfDataSourceImpl implements PdfDataSource {
  // Implementation using syncfusion_flutter_pdf
}
```

**Settings Data Source (SharedPreferences):**
```dart
// lib/data/datasources/local/settings_local_datasource.dart
abstract class SettingsLocalDataSource {
  Future<List<RecentFileModel>> getRecentFiles();
  Future<void> addRecentFile(RecentFileModel file);
  Future<String> getLanguage();
  Future<void> setLanguage(String languageCode);
  // ... other settings
}
```

#### 1.3 Implement Repositories

```dart
// lib/data/repositories/signature_repository_impl.dart
@LazySingleton(as: SignatureRepository)
class SignatureRepositoryImpl implements SignatureRepository {
  final SignatureLocalDataSource _localDataSource;

  const SignatureRepositoryImpl(this._localDataSource);

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

  // Implement other methods...
}
```

---

### Phase 2: Presentation Layer (Priority: HIGH)

#### 2.1 Create BLoCs

**Signature Library BLoC:**
```dart
// lib/presentation/blocs/signature_library/signature_library_bloc.dart
part 'signature_library_event.dart';
part 'signature_library_state.dart';

class SignatureLibraryBloc extends Bloc<SignatureLibraryEvent, SignatureLibraryState> {
  final GetSignatures _getSignatures;
  final AddSignature _addSignature;
  final DeleteItem _deleteItem;

  SignatureLibraryBloc({
    required GetSignatures getSignatures,
    required AddSignature addSignature,
    required DeleteItem deleteItem,
  }) : _getSignatures = getSignatures,
       _addSignature = addSignature,
       _deleteItem = deleteItem,
       super(const SignatureLibraryInitial()) {
    on<LoadSignaturesEvent>(_onLoadSignatures);
    on<AddSignatureEvent>(_onAddSignature);
    on<DeleteSignatureEvent>(_onDeleteSignature);
  }

  // Event handlers...
}
```

**PDF Viewer BLoC:**
```dart
// lib/presentation/blocs/pdf_viewer/pdf_viewer_bloc.dart
class PdfViewerBloc extends Bloc<PdfViewerEvent, PdfViewerState> {
  final OpenPdf _openPdf;
  final ClosePdf _closePdf;
  final RenderPage _renderPage;

  // Implementation...
}
```

**Editor BLoC:**
```dart
// lib/presentation/blocs/editor/editor_bloc.dart
class EditorBloc extends Bloc<EditorEvent, EditorState> {
  final List<PlacedObject> _placedObjects = [];
  final List<EditorCommand> _undoStack = [];
  final List<EditorCommand> _redoStack = [];

  // Handles:
  // - Placing objects
  // - Moving objects
  // - Rotating objects
  // - Scaling objects
  // - Z-order management
  // - Undo/Redo
}
```

#### 2.2 Create Screens

**Welcome Screen (Desktop):**
```dart
// lib/presentation/screens/welcome/welcome_screen.dart
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Logo
            // "Open PDF" button
            // Recent files list
          ],
        ),
      ),
    );
  }
}
```

**Editor Screen:**
```dart
// lib/presentation/screens/editor/editor_screen.dart
class EditorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: PdfCanvasWidget(), // PDF viewer + placed objects
          ),
          SignaturePanelWidget(), // Right panel with tabs
        ],
      ),
    );
  }
}
```

#### 2.3 Create Widgets

**PDF Canvas Widget:**
```dart
// lib/presentation/widgets/pdf_canvas/pdf_canvas_widget.dart
class PdfCanvasWidget extends StatefulWidget {
  // Displays PDF pages + placed objects
  // Handles zoom, scroll, selection
}
```

**Signature Panel Widget:**
```dart
// lib/presentation/widgets/signature_panel/signature_panel_widget.dart
class SignaturePanelWidget extends StatelessWidget {
  // Tabs (Signatures/Stamps)
  // List of items with drag handles
  // Add button
}
```

**Selection Handles Widget:**
```dart
// lib/presentation/widgets/common/selection_handles_widget.dart
class SelectionHandlesWidget extends StatelessWidget {
  // 8 resize handles + 1 rotation handle
  // Selection box
}
```

---

### Phase 3: Routing (Priority: MEDIUM)

#### 3.1 Configure go_router

```dart
// lib/core/router/app_router.dart
final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/editor',
      name: 'editor',
      builder: (context, state) {
        final path = state.extra as String;
        return EditorScreen(pdfPath: path);
      },
    ),
  ],
);
```

Update `lib/main.dart`:
```dart
MaterialApp.router(
  routerConfig: goRouter,
  // ...
)
```

---

### Phase 4: Platform-Specific Code (Priority: MEDIUM)

#### 4.1 Desktop Window Configuration

**Windows:**
```dart
// windows/runner/main.cpp
// Set minimum window size, initial size
```

**macOS:**
```dart
// macos/Runner/MainFlutterWindow.swift
// Configure window properties
```

**Linux:**
```dart
// linux/my_application.cc
// Set window properties
```

#### 4.2 Mobile Configuration

**Android:**
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<!-- Add file access permissions -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

**iOS:**
```xml
<!-- ios/Runner/Info.plist -->
<!-- Add photo library usage description -->
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to select signature images</string>
```

---

### Phase 5: Testing (Priority: HIGH)

#### 5.1 Unit Tests

Create tests for:
- All use cases
- All repositories
- All BLoCs
- Utility functions

Example:
```dart
// test/unit/domain/usecases/signature/get_signatures_test.dart
void main() {
  late MockSignatureRepository mockRepository;
  late GetSignatures usecase;

  setUp(() {
    mockRepository = MockSignatureRepository();
    usecase = GetSignatures(mockRepository);
  });

  test('should return list of signatures from repository', () async {
    // Arrange
    final tSignatures = [/* test data */];
    when(mockRepository.getSignatures())
        .thenAnswer((_) async => Right(tSignatures));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(Right(tSignatures)));
    verify(mockRepository.getSignatures());
    verifyNoMoreInteractions(mockRepository);
  });
}
```

#### 5.2 Widget Tests

Test all custom widgets:
```dart
// test/widget/widgets/signature_panel_test.dart
void main() {
  testWidgets('SignaturePanelWidget displays signatures', (tester) async {
    // Build widget
    await tester.pumpWidget(
      MaterialApp(
        home: SignaturePanelWidget(signatures: testSignatures),
      ),
    );

    // Verify
    expect(find.text('Подписи'), findsOneWidget);
    expect(find.byType(SignatureCardWidget), findsNWidgets(2));
  });
}
```

#### 5.3 Integration Tests

Test full user flows:
```dart
// test/integration/open_and_save_pdf_test.dart
void main() {
  testWidgets('Open PDF, add signature, and save', (tester) async {
    // 1. Launch app
    // 2. Tap "Open PDF"
    // 3. Select PDF file
    // 4. Drag signature to PDF
    // 5. Save
    // 6. Verify saved
  });
}
```

---

### Phase 6: Code Generation (Priority: HIGH)

Run code generation for:

1. **Injectable (DI):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Localization:**
   ```bash
   flutter gen-l10n
   ```

3. **Isar (Database):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

---

## Development Workflow

### Daily Development

1. **Start with a feature:**
   - Create BLoC events/states
   - Implement BLoC logic
   - Create UI widgets
   - Write tests

2. **Run tests frequently:**
   ```bash
   flutter test
   ```

3. **Check code quality:**
   ```bash
   flutter analyze
   ```

4. **Test on multiple platforms:**
   ```bash
   flutter run -d windows
   flutter run -d macos
   flutter run -d android
   ```

### Before Committing

```bash
# Format code
dart format .

# Analyze
flutter analyze

# Run tests
flutter test

# Check coverage
flutter test --coverage
```

---

## Recommended Implementation Order

1. **Week 1:**
   - ✅ Data models (Isar)
   - ✅ Local data sources
   - ✅ Repository implementations
   - ✅ Initialize Isar database in main.dart

2. **Week 2:**
   - ✅ Signature Library BLoC
   - ✅ Welcome screen
   - ✅ Signature panel widget
   - ✅ File picker integration

3. **Week 3:**
   - ✅ PDF data source (Syncfusion)
   - ✅ PDF Viewer BLoC
   - ✅ PDF canvas widget
   - ✅ Basic PDF viewing

4. **Week 4:**
   - ✅ Editor BLoC
   - ✅ Drag-and-drop logic
   - ✅ Selection handles
   - ✅ Transform operations

5. **Week 5:**
   - ✅ Z-order management
   - ✅ Undo/Redo
   - ✅ Save PDF functionality
   - ✅ Password handling

6. **Week 6:**
   - ✅ Mobile UI (bottom sheet, gestures)
   - ✅ Floating toolbar
   - ✅ Context menus

7. **Week 7-8:**
   - ✅ Testing (unit, widget, integration)
   - ✅ Platform-specific configurations
   - ✅ Performance optimization
   - ✅ Documentation

---

## Quick Reference

### Important Files

- **Main entry:** `lib/main.dart`
- **DI setup:** `lib/injection/injection_container.dart`
- **Theme:** `lib/core/theme/app_theme.dart`
- **Constants:** `lib/core/constants/app_constants.dart`
- **Localization:** `lib/l10n/app_en.arb`, `lib/l10n/app_ru.arb`

### Key Commands

```bash
# Get dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run on device
flutter run

# Run tests
flutter test

# Build release
flutter build <platform> --release

# Analyze code
flutter analyze

# Format code
dart format .
```

---

## Resources

- **Requirements:** `docs/REQUIREMENTS.md`
- **Flutter Docs:** https://docs.flutter.dev/
- **BLoC Library:** https://bloclibrary.dev/
- **Syncfusion PDF:** https://help.syncfusion.com/flutter/pdf/overview
- **Isar Database:** https://isar.dev/

---

## Support

For questions or issues during development:
1. Check `docs/REQUIREMENTS.md` for specifications
2. Review Flutter documentation
3. Consult Syncfusion documentation for PDF operations

---

**Good luck with development! 🚀**
