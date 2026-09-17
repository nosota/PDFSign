# ADR-0012: The undo history is snapshots, not commands

**Status:** Accepted
**Date:** 2026-09-17

## Context

Undo and redo have to cover every change a reader can make to a document:
placing an object, moving, resizing and rotating one, deleting, cutting and
pasting, restacking within a page, and turning a page.

That state lives in two providers. The objects are in `PlacedImages`; the turn
each page is shown at is in the document held by `PdfDocument`. Turning a page
changes both at once, because the objects standing on it are carried round with
it through a coordinate transform.

## Decision

Each step stores an **immutable snapshot** of the editable state — the object
list, the rotation of every page, and what was selected. Undo restores the
previous snapshot; redo restores the next.

A command for each action, with an `undo()` of its own, was the alternative.
It was rejected because a command has to *say how to reverse itself*, and the
actions here include turning a page, which moves every object on it through
`PageRotationTransform`. An inverse written by hand for that is a quiet way to
corrupt a document — this project has already had one such defect, where a
page's rotation was counted twice and a stamp came out standing on end, and it
was found only by a pixel probe. Restoring a snapshot is an assignment and
cannot be got subtly wrong.

**Snapshots are almost free here.** `PlacedImage` is immutable and
`PlacedImages` replaces the whole list on every change rather than mutating it,
so a snapshot is a reference to a list nobody will alter — the same argument
ADR-0008 makes for the baseline the dirty state is measured against. Fifty
snapshots share every object that did not change between them; what is actually
copied is one list of pointers and one list of page rotations per step.

### What a step is

- An action that happens at once — a drop, a paste, a delete, a restack, a page
  turn — is recorded with `recordHistoryStep`.
- A gesture that reports over many frames opens a step on its first report and
  closes it when the gesture ends, so a whole drag is one step rather than
  sixty. Opening is idempotent, which is what lets the resize handles — which
  report no start of their own — open it from the drag itself.
- A step that ends where it began is dropped. A drag that went nowhere, or an
  object sent to a front it was already at, is not something a reader can
  undo, and an entry for it would make the next ⌘Z appear to do nothing.

### What the snapshot deliberately leaves out

- **What the file says each page's rotation is.** That is the baseline a save
  writes against; restoring it would tell the document it had been saved when
  it had not. Pages are *turned* back to their recorded angle through the same
  transform an ordinary turn uses, so their displayed sides stay consistent.
- **The selection, when comparing.** Selecting something is not a change to the
  document. It is stored, so an undo puts the reader back where they were, but
  it never makes a step of its own.

### What is outside the history

The image library in the right-hand panel. It lives in Isar and is shared by
every open window, so a ⌘Z in one document would change the panel in another.
The size a library image remembers from the last resize is left alone for the
same reason.

## Consequences

- Undoing past a save is allowed, and the document correctly becomes unsaved
  again — which falls out of ADR-0008 without any code.
- The history is per window and per document: it is forgotten when a document
  is opened, and when Save As turns the window to a new file.
- Fifty steps, per `REQUIREMENTS §12.2`.
- Every action has to record its step. Nothing enforces that automatically: a
  guard that watched the providers would have had to depend on them, which is
  exactly the coupling `EditorHistory` is built to avoid. Each action is
  covered instead by a test asserting it takes one step and no more, and a new
  action needs one too.
