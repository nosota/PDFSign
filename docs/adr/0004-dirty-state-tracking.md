# ADR-0004: Dirty State Tracking Policy

## Status

Accepted

## Context

The app needs to track whether a document has unsaved changes to show the save confirmation dialog and enable/disable the Save menu item. The question is which operations should mark the document as "dirty."

## Decision

Only operations that change the set of placed images mark the document as dirty:

- **Dirty:** add, duplicate, delete placed images
- **Not dirty:** move, resize, rotate placed images

## Consequences

- Moving or resizing an image without adding/removing does not prompt for save
- Reduces unnecessary save prompts during layout adjustments
- Trade-off: position/size changes can be lost without a save prompt
- This policy can be changed if user feedback indicates it should be stricter
