# ADR-0003: No Cascade Deletion of Placed Images

## Status

Accepted

## Context

Users can add images to the sidebar library and then place them on PDF pages. When a sidebar image is deleted, the app must decide whether to also remove all placed instances of that image from open documents.

## Decision

Deleting a sidebar image does NOT delete placed images on PDF pages. Placed images are independent copies that reference their own image file path.

## Consequences

- Less surprising behavior for users — placed images are not removed from the page
- Placed images are independent of the sidebar library at the *data* level

### Correction (2026-09-15)

An earlier revision of this ADR claimed that orphaned placed images keep working "because the file still exists on disk (copied per ADR-0001)". **That is not what the code does.**

`SidebarImageRepositoryImpl.removeImage()` deletes the Isar row *and* the file in app storage via `ImageStorageService.deleteImage()`. `clearAllImages()` does the same for every file. So deleting a library image leaves any already-placed instance pointing at a deleted path, with two visible effects:

1. The object renders as a broken-image placeholder in the editor.
2. `PdfSaveService` skips it silently — `if (!await imageFile.exists()) continue;` — so it **disappears from the saved PDF without any warning**.

The decision (no cascade deletion of placed objects) still stands, but it is currently incomplete. Resolving it requires one of:

- keeping the file on disk while any open document references it (reference counting), or
- warning the user that placed instances will break, or
- cascading the deletion honestly, so the object disappears from the page too.

Tracked in REQUIREMENTS.md §13.1.
