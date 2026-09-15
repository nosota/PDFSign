# ADR-0004: Dirty State Tracking Policy

## Status

**Superseded by [ADR-0008](0008-dirty-state-derived-from-a-baseline.md)** on
2026-09-15. Kept for the record; the policy below is no longer in force.

The trade-off recorded under Consequences turned out to cost more than it saved:
because the flag only mattered after a save, a move left the document reporting
clean *and* disabled File → Save, while the title still read "Saved". A separate
hole let a delete after a save report clean too. Dirty state is now derived from
a baseline instead of flagged by operation.

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
- Superseded: see ADR-0008 for why this was replaced and what took its place.
