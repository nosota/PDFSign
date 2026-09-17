# CLAUDE.md — Authoritative Rules for Claude Code

This file defines **enforceable rules and invariants** for the PDFSign project. It contains policy only. Architecture, explanations, and the inventory of current technical debt live in `docs/` and `REQUIREMENTS.md`.

**Last aligned with the codebase:** 2026-09-17.

A rule here is binding on **new and modified code**. Where existing code violates a rule, the violation is named explicitly as a *grandfathered exception* — touching such a file is an invitation to fix it, not a licence to extend it.

---

## Project Configuration & Environment

- Flutter SDK: **3.24.0+** (stable channel only)
- Dart SDK: **3.5.0+**
- Target platform: **macOS 10.15+, and only macOS**
- Bundle identifier: `com.ivanvaganov.pdfsign`
- No build flavors. A single build configuration.

### Platform Scope

`ios/`, `android/`, `windows/`, and `linux/` contain unmodified Flutter templates. The app depends on macOS-native code for window management, Finder integration, the toolbar, and sub-window drag-and-drop.

- Do **not** add code for, or reason about, other platforms unless explicitly asked.
- Do **not** "fix" the mobile welcome view or the unused router to make them work — they are dead code pending a decision (REQUIREMENTS.md §13.3, §12.10).
- If another platform is ever targeted, platform-abstraction rules must be reinstated in this file first.

---

## Code Style & Engineering Principles

- Act as a senior Flutter engineer with a working understanding of reactive state.
- Follow **Effective Dart**.
- Use **flutter_lints** (`^3.0.2`). See *Lint Policy* below for the enforced bar.
- Code must be self-documenting with meaningful names.
- **Clean Architecture** is mandatory (Domain → Data → Presentation).
- Business logic must be testable without a Flutter widget tree.
- Public APIs require dartdoc comments. Examples where the usage is non-obvious.
- Private members use `_` consistently.
- Apply **SOLID**, **DRY**, **KISS**. Prefer composition to inheritance.

### Size Limits

LOC means source lines: blank lines and comments do not count.

| Unit | Limit |
|------|-------|
| Class | ≤ 200 LOC |
| Method / function | ≤ 30 LOC |
| Widget `build()` | ≤ 50 LOC |
| Widget nesting depth | ≤ 4 levels |
| Cyclomatic complexity | ≤ 10 per method |

**Grandfathered exceptions** — these classes already exceed the limit. Do not grow them; extract when you touch them:

| Class | File | LOC |
|-------|------|-----|
| `_PdfViewerState` | `…/pdf_viewer/pdf_viewer.dart` | 577 |
| `_PlacedImageWidgetState` | `…/pdf_viewer/placed_image_overlay.dart` | 523 |
| `_PdfViewerAppState` | `presentation/apps/pdf_viewer_app.dart` | 424 |
| `_AppMenuBarState` | `presentation/widgets/menus/app_menu_bar.dart` | 358 |
| `PdfPageListState` | `…/pdf_viewer/pdf_page_list.dart` | 266 |

New classes must comply from the first commit.

---

## Architecture Rules — MANDATORY

### Actual Layout

```
lib/
├── core/           # Shared kernel: constants, errors, platform channels,
│                   # router (unused), theme, utils, window management
├── domain/         # Entities and repository interfaces
├── data/           # Data sources, models, repository impls, services
├── presentation/   # apps/, providers/, screens/, widgets/
├── l10n/           # ARB files + generated localizations
└── main.dart       # Entry point and window routing
```

There is no `lib/injection/`. Dependency injection is done with Riverpod providers in `presentation/providers/`. Do not introduce a separate DI directory.

### Layer Dependencies (STRICT)

- **Domain** depends on nothing but `dartz`, `equatable`, `core/errors`, and `dart:` libraries. No Flutter framework imports (`package:flutter/...`) — `dart:ui` value types (`Offset`, `Size`, `Rect`) are permitted and currently used by `PlacedImage`.
- **Data** depends only on Domain and Core.
- **Presentation** depends on Domain and Core. **Exception:** composition-root files may import Data in order to wire implementations to interfaces. Those files are exactly:
  - `presentation/providers/data_source_providers.dart`
  - `presentation/providers/repository_providers.dart`
  - `presentation/providers/editor/original_pdf_provider.dart`
  - `presentation/providers/editor/pdf_save_service_provider.dart`

  No other presentation file may import from `data/`.

  This rule is currently met: the last violation, `pdf_viewer_app.dart` building `PdfSaveService` by hand, was fixed on 2026-09-16.
- **Core** may be used by all layers.
- Circular dependencies are FORBIDDEN.

### Domain Layer

- Entities: immutable, `Equatable`, with `copyWith`.
- Repositories: abstract interfaces only.
- Errors: `Either<Failure, T>` via **dartz**. Never return `null` to signal failure.

### Data Layer

- Repository implementations translate exceptions into typed `Failure` values.
- Data sources are separated by mechanism (Isar, SharedPreferences, pdfx, file picker).
- Models are separate from entities, with explicit `toEntity()` / `fromEntity()`.
- Structured local storage: **Isar**. Scalar preferences: **shared_preferences**. Do not add Hive, sqflite, or another store.
- File paths: always via **path_provider**; never hardcode a directory.
- **No network layer.** The app is fully offline. Do not add `dio`, HTTP clients, or any remote data source.

### Presentation Layer

- **Riverpod** (`flutter_riverpod ^2.5.1`) for state and DI, with `@riverpod` code generation preferred.
- Widgets are `ConsumerWidget` / `ConsumerStatefulWidget`, or use `Consumer`.
- Navigation is **window-based**, not route-based: each document is its own window created through `WindowManagerService`. `go_router` is declared but unused; do not route through it and do not add new routes.
- Form and input validation belongs in dedicated classes, not in `build()`.

---

## State Management Rules — Riverpod

**Provider types in use:**

| Type | Used for |
|------|----------|
| `@Riverpod(keepAlive: true)` | State that must survive rebuilds and disposal: document, placed images, dirty flags, caches, repositories |
| `@riverpod` | Ephemeral state: selection, sidebar width, page rendering |
| `StreamNotifier` | Real-time cross-window sync (`SidebarImages` over Isar) |
| `NotifierProvider` (manual) | Preferences that broadcast across windows |
| `Provider` | Services and computed values |
| `StateProvider` | Trivial UI flags only (`permissionRetryProvider`) |

**Naming:** providers `camelCaseProvider`; notifier classes `PascalCase`; methods verb-based.

**Rules:**

- State must be immutable; update via `copyWith` and reassignment.
- Use `Equatable` for entities, `freezed` for sealed state unions (`PdfViewerState`).
- Providers must not contain UI logic and must not build widgets.
- A provider must not write to another provider during `build()`. Cross-provider coordination goes in a top-level helper that takes `WidgetRef` — see `deleteSelectedImage()`.
- `ref.watch()` for reactive dependencies, `ref.read()` in callbacks, `ref.listen()` for side effects.
- Dispose resources in `ref.onDispose()`.
- Handle every error case; use `AsyncValue` for async state.
- Providers that must be seeded by `main()` throw `UnimplementedError` in their body and are overridden in `ProviderScope` (`sharedPreferencesProvider`, `isarProvider`).

---

## Multi-Window Rules — CRITICAL

Each window runs a **separate Flutter engine with isolated Dart memory** (ADR-0006). This invalidates assumptions that hold in single-window apps.

- Dart singletons, `static` fields, and providers are **per window**. They cannot enforce anything application-wide.
- Application-wide invariants must be held in **native storage** (`UserDefaults`) — see the Settings singleton (ADR-0005) and the open-files registry.
- Cross-window messaging goes through `WindowBroadcast` only. Choose `_broadcast` (excludes self) vs `_broadcastIncludingSelf` deliberately.
- Cross-window data sync for the image library goes through the **Isar stream**, not broadcasts.
- `SharedPreferences` caches per engine. After another window may have written, call `prefs.reload()` before reading.
- Only the focused window may render `PlatformMenuBar`. Never render it unconditionally.
- Never assume a window id. The main window is `"0"` by convention only; this is already fragile in two places (CODE_REVIEW §4.5) — do not add a third.

---

## Widget Rules

- Prefer `const` constructors everywhere possible.
- Extract magic numbers into the existing constant classes: `PdfViewerConstants`, `SidebarConstants`, `SelectionHandleConstants`, `Spacing`, `Radii`, `AppColors`, `AppTypography`. Do not inline new literals.
- Extract complex widgets into their own files.
- `setState` is acceptable in `StatefulWidget`s for **local, non-shared** UI state — hover, focus, drag flags, animation state. Anything another widget or window observes belongs in a provider.
- Respect RTL: the editor forces LTR layout so panels keep their sides; text still inherits direction. Do not remove that `Directionality`.
- **Hit areas must be larger than the visual affordance** for small pointer targets. The established ratios: corner handles 10 px visual / 24 px hit, side handles 10×6 / 20 px, rotation handle 24 px / 32 px. Apply the same principle to any new small control.

---

## PDF Rules

- Rendering and page geometry: **pdfx**. Writing and image embedding: **syncfusion_flutter_pdf**. Do not introduce `syncfusion_flutter_pdfviewer`.
- Never load an entire large PDF into memory unconditionally. Respect the 50 MB threshold in `OriginalPdfStorage`.
- Rendering must stay lazy: visible pages + 2-page buffer, LRU cache of 10, scale quantized to 2 decimals, renders cancelled when scrolled out of view (ADR-0007). Do not bypass `PdfPageCache`.
- **Every save must start from the cached original bytes**, never from the previously saved file (ADR-0002). Breaking this silently corrupts documents through repeated saves.
- Placed objects are stored in **PDF points** (1/72 in) relative to the page's top-left corner, independent of zoom.
- Images imported into the library are copied into app storage with a UUID name (ADR-0001). Never persist a path to a user's original file.

---

## Localization

- All user-facing strings go in `lib/l10n/app_en.arb` and are consumed via `AppLocalizations`. **No hardcoded UI strings.**
- `flutter gen-l10n` output in `lib/l10n/generated/` is generated — never edit it by hand.
- A new locale requires: an `.arb` file **and** an entry in `supportedLocales` in `locale_preference_provider.dart`. Adding only the `.arb` leaves the translation unreachable — that is what kept `ja`, `ko` and `zh` dead until 2026-09-17 (REQUIREMENTS.md §13.5, now closed).
- **A new string goes into every `.arb` file, not only `app_en.arb`.** All 66 files carry all 137 keys as of 2026-09-17; leaving a key out of a locale shows that locale's reader an English string in the middle of their own language.
- RTL (`ar`, `he`, `fa`) must keep working.
- Existing hardcoded strings are listed in REQUIREMENTS.md §13.6. Fix them when you touch the surrounding code; the keys already exist.

---

## Logging & Error Handling

- Use the **Result pattern** (`Either<Failure, T>`) across domain and data layers.
- Never throw or catch bare `Exception`/`Error` as a control-flow mechanism. Use the typed failures in `core/errors/failures.dart` and add a new type rather than reusing a vague one.
- Never classify errors by matching substrings of an exception's `toString()`. The existing case in `PdfDocumentRepositoryImpl` is a known defect (CODE_REVIEW §1.1), not a pattern to copy.
- Never log file contents, file paths of user documents, or clipboard data.
- **Logging must go through a single logger.** `logger: ^2.4.0` is declared for this purpose and is not yet wired up. `kDebugMode` + `print()` is the current state across `core/` and `presentation/apps/` and is **not** to be extended — new diagnostics use the logger.
- User-facing errors must be actionable and localized.

---

## Dependencies

### Current Dependency Set

```yaml
# State & DI
flutter_riverpod, riverpod_annotation, equatable, freezed_annotation
# PDF
pdfx                      # rendering
syncfusion_flutter_pdf    # writing
# Storage
isar, isar_flutter_libs, shared_preferences, path_provider
# Files & input
file_picker, desktop_drop, super_clipboard
# Windowing
desktop_multi_window, window_manager
# Sharing
share_plus
# Utilities
dartz, uuid, intl, json_annotation (codegen), logger (declared, not yet used)
# Declared but unused
go_router, mime
```

### Rules

- Adding a dependency requires a stated justification and a check that no existing dependency covers the need.
- No deprecated or unmaintained packages. Prefer Flutter-team and well-established packages.
- Review licences for commercial compatibility. Syncfusion is used under a Community licence — **never commit a licence key** (one is currently in `TODO.md` and must be removed; REQUIREMENTS.md §13.15).
- `go_router` and `mime` are unused. Either wire them up deliberately or remove them; do not build new code on them casually.

---

## Testing

The project has 349 Dart tests (page-column geometry, drag-and-drop placement, dirty-state policy, the close-everything flow, cut/copy/paste, protected documents, writing protection and permission bits, the protection panel, object restacking, the undo history, dragging out of the library) and 55 native tests (`macos/RunnerTests`, toolbar item management and validation, document-window placement, PDF encryption detection, the restacking, undo and lock controls). Everything else is uncovered, which remains the largest known risk (CODE_REVIEW §5.3). The following is the target state, and applies to code you add or change:

- New business logic (providers, repositories, services, coordinate math) ships with unit tests.
- Test file mirrors source structure; one test file per source file.
- Naming: `test('should ... when ...')`. Arrange-Act-Assert.
- Mock with **mocktail** or **mockito** (both declared).
- Test providers with `ProviderContainer` and `.overrideWith()`.
- Test error cases first, happy path last.
- **Coverage target: 80%.** Current: far below it — two feature areas out of the whole app. Do not report the target as if it were achieved.
- Native code is tested with XCTest in `macos/RunnerTests`, run with
  `xcodebuild test -workspace macos/Runner.xcworkspace -scheme Runner -destination 'platform=macOS'`.
  **AppKit carries state between objects**: `NSToolbar` shares its item set *live* between instances created with the same identifier — removing an item from one window's toolbar removes it from every other window's too. Give each window its own identifier, use a throwaway one in destructive tests, and set `isReleasedWhenClosed = false` on any `NSWindow` a test closes.
- Highest-value targets to cover first: `placed_image_overlay` transform math, `PdfPageCache` eviction and key quantization, `OriginalPdfStorage`, `RecentFilesRepositoryImpl` locking, `PdfSaveService` rotation and embedding.

---

## Lint Policy

Enforced bar, verified with `flutter analyze`:

- **0 errors** — currently met.
- **0 warnings** — currently met. Do not regress it.
- Info-level lints: 1245 at last count. Not a merge gate, but do not increase the count in files you touch.

### Import Convention

Use **`package:pdfsign/...` imports** throughout. This matches 100% of the existing code.

> **Nothing currently enforces this.** `analysis_options.yaml` sets `always_use_package_imports: error` under `analyzer.errors` (line 21), but that key only overrides the *severity* of a diagnostic — the rule is absent from `linter.rules`, so it never runs and the override is a no-op. Meanwhile `prefer_relative_imports` **is** enabled in `linter.rules` (line 152) and argues the opposite, producing 391 of the 1201 info lints.
>
> Until that is resolved: ignore those 391 diagnostics, and do **not** "fix" them by converting imports to relative paths. To make the stated policy real, add `always_use_package_imports` to `linter.rules` and remove `prefer_relative_imports` from it.

---

## Security & Privacy

- The app is **fully offline**: no network requests, no accounts, no telemetry, no analytics, no crash reporting. Do not add any.
- All user data stays in the user's home directory.
- Never log sensitive information or user document contents.
- Sanitize and validate file inputs — verify existence and type before use.
- The app sandbox is deliberately **disabled** to allow reopening recent files (REQUIREMENTS.md §2.2). Do not re-enable it without implementing security-scoped bookmarks first, and note that this blocks Mac App Store distribution.

---

## Git & Version Control

Single-developer project. There is no CI, no pre-commit hooks, and no review gate. Discipline is manual.

- `main` is the working branch. Direct commits to `main` are the norm.
- Use a `feature/` or `fix/` branch for changes that are risky, long-running, or might need to be abandoned.
- Commit messages: **Conventional Commits** (`feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `chore:`). Adherence has been inconsistent; it is required going forward.
- Run `flutter analyze` before committing. Do not commit new errors or warnings.
- Do not commit commented-out code, secrets, or licence keys.
- Tag releases with semantic versioning and update `CHANGELOG.md`.

---

## Documentation

Keep documentation truthful. A document that describes intent rather than reality is worse than no document.

- Update `CHANGELOG.md` with every user-visible change.
- Update `REQUIREMENTS.md` when behaviour changes; add to §13 when you knowingly leave debt behind.
- Update the relevant file in `docs/` when you change a provider, repository, service, entity, or platform channel.
- Record significant design decisions as an ADR in `docs/adr/`. If a decision's stated consequences turn out to be wrong, correct the ADR rather than leaving it — see ADR-0003.
- `TODO.md` is the owner's personal roadmap. **Claude Code must not treat it as a requirements source and must not implement from it unasked.**
- `KNOWN ISSUES.md` lists open defects.

---

## Prohibited Practices — NEVER DO

- ❌ `dynamic` or `Object?` without an explicit, commented reason
- ❌ Ignore analyzer errors or warnings
- ❌ `print()` for new diagnostics (use the logger)
- ❌ Hardcoded user-facing strings (use `AppLocalizations`)
- ❌ Hardcoded magic numbers in widgets (use the constant classes)
- ❌ Mutate state objects in place
- ❌ Make network calls — the app is offline by design
- ❌ Store a path to a user's original image in the library (copy to app storage)
- ❌ Save a PDF from anything other than the cached original bytes
- ❌ Assume Dart state is shared between windows
- ❌ Classify errors by substring-matching exception text
- ❌ Add a locale's `.arb` without adding it to `supportedLocales`
- ❌ Commit secrets, licence keys, or commented-out code
- ❌ Create God classes or God widgets
- ❌ Use global mutable variables for state
- ❌ `!` on a value that has not been null-checked

---

## Checklist Before Declaring Work Done

- [ ] `flutter analyze` — no new errors or warnings
- [ ] Code generation re-run if annotations changed (`dart run build_runner build --delete-conflicting-outputs`)
- [ ] New strings added to `app_en.arb`, not hardcoded
- [ ] New locales added to `supportedLocales`
- [ ] Tests added for new business logic
- [ ] Multi-window implications considered (is this state per-window or app-wide?)
- [ ] Error paths handled with typed failures
- [ ] Documentation updated (`CHANGELOG.md`, `docs/`, `REQUIREMENTS.md` where relevant)
- [ ] No new size-limit violations
- [ ] Verified on macOS — the only supported platform

---

## MCP Rules

MCP provides **capabilities only**, not autonomy.

Claude MUST:
- Modify only files relevant to the task
- Preserve the existing architecture unless explicitly instructed otherwise
- Update tests when changing tested code
- Update documentation when changing public APIs or behaviour

Claude MUST NOT:
- Change project structure without permission
- Add dependencies without justification
- Remove existing tests
- Ignore compilation errors
- Skip error handling
- Implement items from `TODO.md` unasked

---

## Rule Priority

1. Flutter SDK / macOS platform constraints
2. This `CLAUDE.md`
3. Explicit user instructions
4. Industry best practices
5. Team conventions

If a rule is defined here, it overrides all other sources. If a rule here contradicts the observable state of the codebase, say so rather than silently following either one.
