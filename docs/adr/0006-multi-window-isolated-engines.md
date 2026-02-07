# ADR-0006: Multi-Window with Isolated Flutter Engines

## Status

Accepted

## Context

PDFSign needs to support multiple PDF documents open simultaneously, each in its own window. Flutter does not natively support multiple windows. The `desktop_multi_window` package provides multi-window support by spawning separate Flutter engines.

## Decision

Each window (Welcome, PDF Viewer, Settings) runs in its own Flutter engine with isolated Dart memory. Shared state is synchronized through:

- **Isar database** — sidebar images synced in real-time via streams
- **SharedPreferences / UserDefaults** — preferences and singleton tracking
- **WindowBroadcast** — explicit inter-window messages (Save All, Close All, preferences changed)

## Consequences

- Full isolation prevents accidental state sharing between windows
- Each window has independent memory and lifecycle
- Inter-window communication requires explicit mechanisms
- Providers are not shared — each engine has its own `ProviderContainer`
- Increased memory usage (separate Dart VM per window)
- Isar streams provide real-time sync for the sidebar image library
