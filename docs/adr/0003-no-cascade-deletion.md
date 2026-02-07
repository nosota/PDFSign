# ADR-0003: No Cascade Deletion of Placed Images

## Status

Accepted

## Context

Users can add images to the sidebar library and then place them on PDF pages. When a sidebar image is deleted, the app must decide whether to also remove all placed instances of that image from open documents.

## Decision

Deleting a sidebar image does NOT delete placed images on PDF pages. Placed images are independent copies that reference their own image file path.

## Consequences

- Less surprising behavior for users — placed images are preserved
- Placed images are independent of the sidebar library
- Users can remove an image from the library while keeping it on documents
- Orphaned placed images reference files that still exist on disk (copied per ADR-0001)
