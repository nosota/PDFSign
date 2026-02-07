# ADR-0005: Settings Window Singleton via Native Storage

## Status

Accepted

## Context

PDFSign uses `desktop_multi_window` where each window runs in a separate Flutter engine with isolated Dart memory. This means Dart-level singletons and static variables cannot enforce that only one Settings window exists across all windows.

## Decision

The Settings window singleton is enforced via native UserDefaults (macOS) storage. When a Settings window opens, its window ID is stored in UserDefaults. Before opening a new Settings window, the app checks UserDefaults for an existing ID and focuses that window instead.

## Consequences

- Native storage is shared across all Flutter engines — single source of truth
- Works regardless of which window triggers "Open Settings"
- Race conditions handled with native-level checks
- Platform-specific implementation (UserDefaults on macOS)
