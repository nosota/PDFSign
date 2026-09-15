# ADR-0008: Dirty State Derived From a Baseline

## Status

Accepted. Supersedes [ADR-0004](0004-dirty-state-tracking.md).

## Context

ADR-0004 decided which *operations* mark a document dirty: add, duplicate and
delete did; move, resize and rotate did not. The dirty state was a `bool` set by
hand at each call site.

The stated trade-off was "position/size changes can be lost without a save
prompt", accepted in exchange for fewer prompts during layout adjustments. In
practice the exchange did not hold, and the flag was wrong in two ways.

**Geometry changes were invisible.** In the usual flow the prompt still
appeared, because the drop that created the object had already set the flag. The
policy only took effect *after a save* — and there the consequence was worse
than a missing prompt:

- **File → Save was disabled**, because the menu item is gated on the flag
  (`isSaveEnabled: menuState.isDirty`). The user nudged an object and the app
  reported that there was nothing to save.
- The **window title read "Saved"** while the objects in memory no longer
  matched the file. That is not a missing warning, it is a false statement.
- `Cmd+S` still worked, because the save handler guards on
  `placedImages.isEmpty && !isDirty` and proceeds when objects exist. The menu
  and the keyboard shortcut disagreed — the handler had already stopped
  trusting the flag.

**Deleting a written object reported the document clean.** `deleteSelectedImage`
called `markClean()` whenever the last object was removed. That is correct only
if no save happened in between. After a save the file contains the embedded
object, so removing it makes memory and file differ — yet the document claimed
to be clean and closed without a prompt, keeping an object the user had deleted.

Both defects have the same root: the flag was a set of heuristics maintained by
hand, rather than an answer to the only question that matters.

## Decision

The dirty state is **derived**, not flagged:

```
dirty = current placed objects != objects as of the last write
```

`SavedPlacedImages` holds the baseline — the object list as it stood when the
document was last written, empty for a document not yet saved in this session.
`documentDirty` compares it with `placedImagesProvider` and yields a `bool`, so
every existing consumer (window title, Save menu, close prompt, cross-window
broadcast) is unchanged.

The baseline is updated in exactly two places: a successful **Save** records the
current objects, and **Save As** resets it, because that path clears the page
and starts a new file. Opening a window needs nothing — both sides start empty.

It lives in memory, per window, alongside the objects it describes. Placed
objects are not persisted (REQUIREMENTS §3.4, FR-4.6), so the baseline has
nothing to outlive. It is also free: `PlacedImages` replaces the whole list on
every change and `PlacedImage` is immutable, so a baseline is a reference to a
list that is never mutated, not a copy. This mirrors `OriginalPdfStorage`, which
keeps the file-side baseline for the same reason (ADR-0002).

## Consequences

- Move, resize and rotate mark the document dirty, as every document editor does.
- Removing an object that was already written marks the document dirty, so the
  deletion is no longer discarded in silence.
- Adding an object and removing it again reports clean, which was the point of
  the fix in commit `0d5160d`. It now follows from the rule instead of being a
  special case.
- Dragging an object back to where it was reports clean again, which no
  operation-based policy can express.
- The menu, the title and the close prompt agree with each other, because all
  three read the same derived value.
- Seven hand-written `markDirty()` / `markClean()` calls are gone; there is one
  rule and two baseline updates.
- An accidental one-pixel nudge now marks the document dirty. That is correct —
  something did change — and matches other editors. A dead-zone threshold can be
  added later if it proves annoying in practice.
