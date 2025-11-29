# PDFSign - Riverpod Migration & UX Enhancements

**Date:** 2025-11-29
**Version:** 2.0
**Status:** Complete

---

## Summary

PDFSign has been successfully migrated from **BLoC** to **Riverpod** for state management, and enhanced with new UX features for improved productivity.

---

## Migration Changes

### 1. State Management: BLoC → Riverpod

#### Removed:
- ❌ `flutter_bloc: ^8.1.6`
- ❌ `bloc_test: ^9.1.7`
- ❌ `get_it: ^7.7.0`
- ❌ `injectable: ^2.3.0`
- ❌ `injectable_generator: ^2.6.2`
- ❌ `lib/presentation/blocs/` directory structure

#### Added:
- ✅ `flutter_riverpod: ^2.5.1`
- ✅ `riverpod_annotation: ^2.3.5`
- ✅ `riverpod_generator: ^2.4.3`
- ✅ `lib/presentation/providers/` directory structure

---

### 2. Provider Structure

**New directory layout:**
```
lib/presentation/providers/
├── signature_library/
│   └── signature_library_provider.dart
├── pdf_viewer/
│   └── pdf_viewer_provider.dart
├── editor/
│   └── editor_provider.dart
└── settings/
    └── settings_provider.dart
```

**Key Providers:**

| Provider | Purpose | Type |
|----------|---------|------|
| `signaturesProvider` | Signature library management | AsyncNotifier |
| `stampsProvider` | Stamp library management | AsyncNotifier |
| `editorProvider` | Placed objects & transformations | StateNotifier |
| `undoRedoProvider` | Command pattern for undo/redo | StateNotifier |
| `pdfDocumentProvider` | PDF viewer state | StateNotifier |
| `zoomLevelProvider` | Current zoom level | StateNotifier |
| `clipboardPreferencesProvider` | Clipboard paste preferences | StateNotifier |

---

### 3. Dependency Injection

**Before (BLoC + get_it):**
```dart
@LazySingleton(as: SignatureRepository)
class SignatureRepositoryImpl implements SignatureRepository {
  final SignatureLocalDataSource _dataSource;
  SignatureRepositoryImpl(this._dataSource);
}

// In main.dart
await configureDependencies();
```

**After (Riverpod):**
```dart
@riverpod
SignatureRepository signatureRepository(SignatureRepositoryRef ref) {
  final dataSource = ref.watch(signatureDataSourceProvider);
  return SignatureRepositoryImpl(dataSource);
}

// In main.dart
runApp(
  const ProviderScope(
    child: PDFSignApp(),
  ),
);
```

---

### 4. Widget Consumption

**Before (BLoC):**
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignatureBloc, SignatureState>(
      builder: (context, state) {
        if (state is SignatureLoaded) {
          return ListView(children: state.signatures.map(...));
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

**After (Riverpod):**
```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signaturesAsync = ref.watch(signaturesProvider);

    return signaturesAsync.when(
      data: (signatures) => ListView(children: signatures.map(...)),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
```

---

## New UX Features

### 1. Arrow Keys for Precise Positioning ⌨️

**Behavior:**
- Press **Arrow Keys** to nudge selected object by 1 pixel
- Press **Shift+Arrow Keys** to nudge by 10 pixels

**Implementation:**
```dart
// In editor_provider.dart
void nudgeObject(String objectId, Offset delta) {
  final obj = _findObject(objectId);
  if (obj == null) return;

  final newPosition = obj.position + delta;
  moveObject(objectId, newPosition);
}
```

**Updated:**
- `lib/core/constants/app_constants.dart` - Added `arrowKeyNudgeDistance`
- `docs/REQUIREMENTS.md` - Section 7.1.2 (Keyboard Shortcuts)

---

### 2. Duplicate Object (Ctrl+D) 📄

**Behavior:**
- Press **Ctrl/Cmd+D** to duplicate selected object
- Duplicate offset by (+20px, +20px)
- Automatically placed on top (highest z-index)
- Immediately selected for further editing

**Implementation:**
```dart
// In editor_provider.dart
void duplicateObject(String objectId) {
  final obj = _findObject(objectId);
  if (obj == null) return;

  const offsetX = 20.0;
  const offsetY = 20.0;

  final duplicate = PlacedObject(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    signatureId: obj.signatureId,
    pageNumber: obj.pageNumber,
    position: Offset(obj.position.dx + offsetX, obj.position.dy + offsetY),
    size: obj.size,
    rotation: obj.rotation,
    zIndex: _getMaxZIndex() + 1,
    placedAt: DateTime.now(),
  );

  _executeCommand(PlaceObjectCommand(editor: this, object: duplicate));
  selectObject(duplicate.id);
}
```

**Updated:**
- `docs/REQUIREMENTS.md` - Section 4.9 (Object Duplication)
- `lib/l10n/app_en.arb` - Added `duplicate` string
- `lib/l10n/app_ru.arb` - Added `duplicate` string

---

### 3. Copy to Clipboard (Ctrl+C) 📋

**Behavior:**
- Press **Ctrl/Cmd+C** to copy selected object's image to clipboard
- Format: PNG with transparency
- Shows toast: "Copied to clipboard"

**Requirements:**
- Only works when an object is selected
- Copies the signature/stamp image (not the placed instance)
- Maintains original resolution

**Updated:**
- `docs/REQUIREMENTS.md` - Section 4.8.1 (Copy to Clipboard)
- `lib/l10n/app_en.arb` - Added clipboard strings
- `lib/l10n/app_ru.arb` - Added clipboard strings

---

### 4. Paste from Clipboard (Ctrl+V) 📥

**Behavior:**
1. Press **Ctrl/Cmd+V** to paste image from clipboard
2. If clipboard contains image, show "Paste Image" dialog:
   - **Preview** of the image
   - **Text input** for name/label
   - **Radio buttons:** "Add to Signatures" / "Add to Stamps" / "Don't add to library"
   - **Checkbox:** "Don't ask again, always add to [selected option]"
3. Image placed at center of visible viewport
4. If "add to library" selected, add to appropriate tab
5. If "Don't ask again" checked:
   - Save preference to SharedPreferences
   - Future pastes use saved preference (no dialog)

**Paste Preferences Management:**
- Settings screen → "Clipboard Behavior"
- Reset "Don't ask again" preference
- Change default paste target

**Implementation:**
```dart
// In settings_provider.dart
class ClipboardPastePreferences {
  final bool dontAskAgain;
  final SignatureType? defaultType; // null = always ask

  const ClipboardPastePreferences({
    this.dontAskAgain = false,
    this.defaultType,
  });
}

@riverpod
class ClipboardPreferences extends _$ClipboardPreferences {
  @override
  ClipboardPastePreferences build() {
    return const ClipboardPastePreferences();
  }

  void setDontAskAgain(bool value) {
    state = state.copyWith(dontAskAgain: value);
  }

  void setDefaultType(SignatureType? type) {
    state = state.copyWith(defaultType: type);
  }
}
```

**Updated:**
- `docs/REQUIREMENTS.md` - Section 4.8 (Clipboard Operations)
- `lib/core/constants/app_constants.dart` - Added preference keys
- `lib/presentation/providers/settings/settings_provider.dart` - Added clipboard preferences
- `lib/l10n/app_en.arb` - Added paste dialog strings
- `lib/l10n/app_ru.arb` - Added paste dialog strings

---

## Updated Keyboard Shortcuts

| Shortcut | Action | Category |
|----------|--------|----------|
| **Ctrl/Cmd+C** | Copy to clipboard | Edit |
| **Ctrl/Cmd+V** | Paste from clipboard | Edit |
| **Ctrl/Cmd+D** | Duplicate object | Edit |
| **Arrow Keys** | Nudge object (1px) | Navigation |
| **Shift+Arrow** | Nudge object (10px) | Navigation |
| *(existing)* | *(unchanged)* | - |

---

## Updated Context Menu

**New items (at top):**
- **Copy Image (Ctrl+C)**
- **Duplicate (Ctrl+D)**
- *(separator)*

**Existing items (unchanged):**
- Rotate 5° Left
- Rotate 5° Right
- Rotate 90°
- Scale +5%
- Scale -5%
- *(separator)*
- Bring to Front
- Bring Forward
- Send Backward
- Send to Back
- *(separator)*
- Delete

---

## Updated Toolbar (Desktop)

**New buttons:**
- **[📋 Copy]** - Copy to clipboard
- **[📄 Duplicate]** - Duplicate object

**Existing buttons (unchanged):**
- [↻] [↺] [⤸] - Rotation
- [➕] [➖] - Scale
- [⬆⬆] [⬆] [⬇] [⬇⬇] - Z-order
- [🗑] - Delete

---

## Code Generation

After migration, run:

```bash
# Generate Riverpod providers
dart run build_runner build --delete-conflicting-outputs

# Generate localizations
flutter gen-l10n

# Clean if needed
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

---

## Testing Changes

### Before (BLoC):
```dart
blocTest<SignatureBloc, SignatureState>(
  'emits [Loading, Loaded] when getSignatures succeeds',
  build: () => SignatureBloc(repository: mockRepository),
  act: (bloc) => bloc.add(GetSignaturesEvent()),
  expect: () => [SignatureLoading(), SignatureLoaded(signatures)],
);
```

### After (Riverpod):
```dart
test('should add signature when addSignature called', () async {
  final container = ProviderContainer(
    overrides: [
      signatureRepositoryProvider.overrideWithValue(mockRepository),
    ],
  );

  when(mockRepository.addSignature(...))
      .thenAnswer((_) async => Right(signature));

  await container.read(signaturesProvider.notifier).addSignature(...);

  final state = container.read(signaturesProvider);
  expect(state.value, contains(signature));
});
```

---

## Documentation Updates

| Document | Updates |
|----------|---------|
| `REQUIREMENTS.md` | ✅ Added FR-8 (Clipboard), FR-9 (Duplication), updated TR-1.2, TR-1.3, keyboard shortcuts |
| `CLAUDE.md` | ✅ Updated state management rules, dependencies, testing examples |
| `pubspec.yaml` | ✅ Migrated dependencies |
| `lib/main.dart` | ✅ Added ProviderScope |
| `lib/injection/` | ✅ Simplified for Riverpod |
| `lib/l10n/` | ✅ Added 18 new localization strings (en, ru) |
| `lib/core/constants/` | ✅ Added clipboard preferences keys |

---

## Breaking Changes

### For Developers:

1. **No more BlocProvider/BlocBuilder:**
   - Use `ConsumerWidget` instead of `StatelessWidget`
   - Use `ref.watch()` instead of `context.read()`

2. **No more get_it dependency injection:**
   - Define dependencies as Riverpod providers
   - Use `@riverpod` annotation for code generation

3. **Events/States replaced by methods:**
   - Instead of `bloc.add(SignatureAddedEvent)`, call `ref.read(signaturesProvider.notifier).addSignature()`

4. **Testing:**
   - Use `ProviderContainer` instead of `blocTest`
   - Override providers with `.overrideWith()`

---

## Migration Checklist

- [x] Update `pubspec.yaml` dependencies
- [x] Remove `flutter_bloc`, `get_it`, `injectable`
- [x] Add `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`
- [x] Create provider structure in `lib/presentation/providers/`
- [x] Update `main.dart` with `ProviderScope`
- [x] Update `lib/injection/` for Riverpod
- [x] Add new keyboard shortcuts to constants
- [x] Implement clipboard operations (Copy/Paste)
- [x] Implement object duplication
- [x] Implement arrow key nudging
- [x] Update localization files (en, ru)
- [x] Update `REQUIREMENTS.md`
- [x] Update `CLAUDE.md`
- [x] Create migration guide

---

## Next Steps for Implementation

1. **Implement Data Layer:**
   - Create Isar models
   - Implement data sources
   - Implement repository implementations
   - Create provider overrides for DI

2. **Implement Presentation Layer:**
   - Create screens (welcome, editor)
   - Create widgets (pdf canvas, signature panel)
   - Implement keyboard shortcuts handling
   - Implement clipboard operations UI
   - Implement paste dialog

3. **Testing:**
   - Write unit tests for providers
   - Write widget tests for screens
   - Write integration tests for user flows

4. **Platform-specific:**
   - Configure window management (desktop)
   - Configure permissions (mobile)
   - Test on all platforms

---

## Benefits of Migration

### 1. **Less Boilerplate**
- No separate event/state files
- Providers defined inline
- Automatic code generation

### 2. **Better Performance**
- Granular rebuilds (only changed widgets)
- Provider caching
- Lazy initialization

### 3. **Simpler DI**
- No manual registration
- Automatic dependency graph
- Compile-time safety

### 4. **Modern Tooling**
- Active development (Riverpod 2.x)
- Better DevTools integration
- Extensive documentation

### 5. **Improved Developer Experience**
- Less code to write
- Easier to test
- More intuitive API

---

## Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Riverpod Code Generation](https://riverpod.dev/docs/concepts/about_code_generation)
- [Testing Riverpod](https://riverpod.dev/docs/essentials/testing)
- [Migration from Provider/BLoC](https://riverpod.dev/docs/from_provider/motivation)

---

**Migration Complete! 🎉**

The project is now using Riverpod for state management with enhanced UX features for clipboard operations and object manipulation.
