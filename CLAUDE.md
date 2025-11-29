# # CLAUDE.md — Authoritative Rules for Claude Code

This file defines **enforceable rules and invariants** for the Flutter PDF signature/stamp project. It MUST contain policy only. Architecture diagrams, usage examples, workflows, and explanations MUST live in `docs/`.

## Project Configuration & Environment

- Flutter SDK: **3.24.0+** (stable channel only)
- Dart SDK: **3.5.0+**
- Minimum target versions:
  - iOS: **13.0**
  - Android: **API 24** (Android 7.0)
  - macOS: **10.15**
  - Windows: **10 (1809)+**
  - Linux: **Ubuntu 20.04+**
- Build flavors: **development**, **staging**, **production**
- Code coverage minimum: **80%**

## Code Style & Engineering Principles

- Act as a senior Flutter engineer with deep understanding of reactive programming
- Follow **Effective Dart** guidelines strictly
- Use **flutter_lints** package with zero warnings/errors tolerance
- Code must be self-documenting with meaningful names
- **Clean Architecture** is mandatory (Domain → Data → Presentation)
- All business logic MUST be testable and platform-agnostic
- Public APIs REQUIRE dartdoc comments with examples
- Private members use `_` prefix consistently
- Class size ≤ **200 LOC**
- Method size ≤ **30 LOC**
- Cyclomatic complexity ≤ **10** per method
- Widget build methods ≤ **50 LOC**
- Extract complex widgets into separate files
- Prefer composition over inheritance
- Apply **SOLID**, **DRY**, **KISS** principles rigorously

## Architecture Rules — MANDATORY

### Clean Architecture Layers

```
lib/
├── core/           # Shared kernel (errors, utils, constants)
├── domain/         # Business logic (entities, repositories, use cases)
├── data/           # Data sources and repository implementations  
├── presentation/   # UI layer (screens, widgets, state management)
└── injection/      # Dependency injection configuration
```

### Layer Dependencies (STRICT)

- **Domain layer**: NO dependencies (pure Dart)
- **Data layer**: depends ONLY on Domain
- **Presentation layer**: depends ONLY on Domain
- **Core**: can be used by all layers
- Circular dependencies are FORBIDDEN

### Domain Layer Rules

- Entities: immutable data classes with business rules
- Repositories: abstract interfaces only
- Use Cases: single responsibility, one public method `call()` or `execute()`
- No Flutter dependencies allowed
- All classes must be unit testable
- Use `Either<Failure, Success>` for error handling (dartz/fpdart)

### Data Layer Rules

- Repository implementations with error handling
- Data sources: separate Remote/Local/Cache
- DTOs/Models: separate from domain entities
- Mappers: explicit entity ↔ model conversion
- Network calls: use **dio** with interceptors
- Local storage: use **Hive** or **Isar** for structured data
- File operations: use **path_provider** properly

### Presentation Layer Rules

- **BLoC pattern** for state management (flutter_bloc: ^8.1.0+)
- One BLoC per feature/screen
- BLoCs communicate via repositories only
- Widgets must be stateless when possible
- Separate presentation logic from UI
- Form validation in dedicated classes
- Navigation via **go_router** with type-safe routes

## State Management Rules — BLoC Pattern

- Events: immutable, past-tense naming (`SignatureAdded`, `PdfLoaded`)
- States: immutable, present-tense naming (`Loading`, `Loaded`, `Error`)
- Use `Equatable` for all events and states
- Use `freezed` for complex state classes
- BLoCs must NOT contain UI logic
- BLoCs must NOT directly access other BLoCs
- Use repository pattern for BLoC communication
- Emit new state instances (no state mutation)
- Handle all error cases explicitly

## Widget Development Rules

### Widget Structure

- Prefer `const` constructors everywhere possible
- Extract magic numbers to named constants
- Separate business logic from presentation
- Create custom widgets for repeated UI patterns
- Maximum widget nesting depth: **4 levels**

### Widget Categories

- **Page**: Full screen with Scaffold
- **View**: Major screen section
- **Component**: Reusable UI element
- **Atom**: Smallest UI unit (button, text field)

### Responsive Design

- Use `LayoutBuilder` for responsive layouts
- Support portrait and landscape orientations
- Test on phones, tablets, and desktop
- Use `MediaQuery` sparingly (prefer inherited solutions)
- Implement adaptive layouts for different screen sizes

## PDF Handling Specific Rules

### PDF Operations

- Use **pdf** package for generation/manipulation
- Use **printing** package for platform printing
- Use **pdfx** or **syncfusion_flutter_pdfviewer** for viewing
- All PDF operations in isolated compute functions
- Stream large PDF files, never load entirely in memory
- Cache rendered pages for performance

### Signature & Stamp Management

- Signatures stored as vector paths when possible
- Stamps as PNG with transparency (max 512x512)
- Support undo/redo with command pattern
- Validate signature/stamp boundaries
- Implement collision detection for placement
- Store placement history for reproducibility

### File Operations

- Check permissions before file access
- Use **file_picker** for cross-platform selection
- Implement proper error handling for I/O
- Clean temporary files on app lifecycle
- Respect platform-specific storage guidelines

## Testing Requirements — MANDATORY

### Test Coverage

- Unit tests: **≥80%** coverage
- Widget tests: all public widgets
- Integration tests: critical user flows
- Golden tests: for custom painted widgets

### Testing Rules

- Test file mirrors source structure
- One test file per source file
- Test naming: `test('should ... when ...')`
- Arrange-Act-Assert pattern
- Mock external dependencies with **mockito**
- Use **bloc_test** for BLoC testing
- Test error cases first, happy path last

## Dependency Management

### Allowed Core Dependencies

```yaml
dependencies:
  # State Management
  flutter_bloc: ^8.1.0
  equatable: ^2.0.0
  
  # Navigation  
  go_router: ^14.0.0
  
  # DI
  get_it: ^7.6.0
  injectable: ^2.3.0
  
  # PDF
  pdf: ^3.10.0
  printing: ^5.11.0
  pdfx: ^2.6.0  # or syncfusion_flutter_pdfviewer
  
  # Storage
  hive_flutter: ^1.1.0
  path_provider: ^2.1.0
  
  # Network
  dio: ^5.4.0
  
  # Utilities
  dartz: ^0.10.1  # or fpdart
  freezed_annotation: ^2.4.0
  json_annotation: ^4.8.0

dev_dependencies:
  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  mockito: ^5.4.0
  bloc_test: ^9.1.0
```

### Dependency Rules

- NO deprecated packages
- NO packages with <90% popularity
- Security audit before adding dependencies
- Prefer Flutter team or Google packages
- Document why each dependency is needed
- Review licenses for commercial compatibility

## Platform-Specific Rules

### Mobile (iOS/Android)

- Request permissions gracefully with rationale
- Handle permission denial with fallbacks
- Implement proper app lifecycle handling
- Support both orientations unless specified
- Follow platform UI guidelines (Cupertino/Material)

### Desktop (Windows/macOS/Linux)

- Implement proper window management
- Support keyboard shortcuts
- Implement drag-and-drop for files
- Provide native menu bars
- Support multi-window if applicable

## Performance Requirements

- App launch time: **<2 seconds**
- PDF load time: **<3 seconds** for 10MB file
- Frame rate: **60 FPS** minimum
- Memory usage: **<200MB** for typical session
- Use `const` widgets to reduce rebuilds
- Implement pagination for large lists
- Lazy load heavy resources
- Profile with Flutter DevTools regularly

## Security & Privacy

- Never log sensitive information
- Sanitize all file inputs
- Implement certificate pinning for HTTPS
- Store sensitive data encrypted
- Clear sensitive data from memory after use
- Implement app-level authentication if needed
- Follow GDPR/privacy requirements

## Localization & Accessibility

- Support RTL languages from day one
- Use **intl** package for i18n
- Extract all strings to ARB files
- Implement semantic labels for accessibility
- Test with screen readers
- Support Dynamic Type/font scaling
- Minimum touch target: **48x48** logical pixels

## Git & Version Control

- Branch naming: `feature/`, `bugfix/`, `hotfix/`, `release/`
- Commit messages: Conventional Commits format
- One feature per PR
- PR requires 100% passing tests
- No direct commits to `main`/`develop`
- Use `.gitignore` for Flutter/Dart properly
- Tag releases with semantic versioning

## Error Handling & Logging

- Use **Result** pattern (Either/Result types)
- Never use generic `Exception` or `Error`
- Create specific exception classes
- Log errors with stack traces
- Implement crash reporting (Firebase Crashlytics)
- User-facing errors must be actionable
- Implement retry mechanisms for network failures

## Documentation Requirements

- README.md with setup instructions
- API documentation for public interfaces
- Architecture Decision Records (ADRs) in `docs/adr/`
- Update documentation with code changes
- Document non-obvious business rules
- Maintain changelog (CHANGELOG.md)
- Document environment variables

## Build & Release Process

- Use **flutter_flavorizr** for build flavors
- Implement CI/CD with GitHub Actions/Codemagic
- Automated testing on PR
- Code signing for all platforms
- Obfuscate production builds
- Generate and archive symbol files
- Version bumping automated
- Release notes generated from commits

## Prohibited Practices — NEVER DO

- ❌ Use `dynamic` or `Object?` without explicit reason
- ❌ Ignore linter warnings
- ❌ Use `print()` for logging (use proper logger)
- ❌ Hardcode strings/values in widgets
- ❌ Access BLoCs directly from widgets (use context)
- ❌ Mutate state objects
- ❌ Use `setState` in large widgets
- ❌ Make network calls from widgets
- ❌ Store sensitive data in plain text
- ❌ Use absolute paths for imports
- ❌ Mix UI and business logic
- ❌ Create God classes or God widgets
- ❌ Use global variables for state
- ❌ Commit commented code
- ❌ Use `!` operator without null check

## Code Review Checklist

Before ANY code review, ensure:

- [ ] All tests pass
- [ ] Code coverage ≥80%
- [ ] No linter warnings
- [ ] Documentation updated
- [ ] No hardcoded values
- [ ] Error handling implemented
- [ ] Memory leaks checked
- [ ] Performance profiled
- [ ] Accessibility verified
- [ ] Works on all target platforms

## MCP Rules for Flutter Development

MCP provides **capabilities only**, not autonomy.

Claude MUST:

- Modify only files relevant to the task
- Preserve architecture unless explicitly instructed
- Update tests when changing code
- Update documentation when changing public APIs

Claude MUST NOT:

- Change project structure without permission
- Add dependencies without justification
- Remove existing tests
- Ignore compilation errors
- Skip error handling
- Create platform-specific code without abstraction

## Rule Priority

1. Flutter SDK / Platform constraints
2. This `CLAUDE.md`
3. Explicit user instructions
4. Industry best practices
5. Team conventions

If a rule is defined here, it overrides all other sources.

## Enforcement

Violations of these rules should be caught by:

1. Pre-commit hooks
2. CI/CD pipeline
3. Code review process
4. Automated linting

Non-compliance blocks merge to main branch.