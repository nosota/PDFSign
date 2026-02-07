# ADR-0001: Images Copied to App Storage

## Status

Accepted

## Context

When a user adds an image (stamp, signature, seal) to the sidebar library, the app needs to reference that image across sessions and windows. If the app stores only the original file path, the image breaks when the source file is moved, renamed, or deleted.

## Decision

When an image is added to the sidebar, it is copied to the app's internal storage folder (`~/Library/Application Support/.../images/`) with a UUID-based filename. The sidebar database (Isar) stores a reference to the copied file, not the original.

## Consequences

- Images remain available even if the original file is moved or deleted
- Consistent paths across sessions and windows
- Independence from external file changes
- Increased disk usage (duplicate of original file)
- `ImageStorageService` manages the lifecycle of copied files
