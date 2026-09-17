# ADR-0013: A change of protection is held until the document is saved

**Status:** Accepted
**Date:** 2026-09-17

## Context

The lock in the toolbar sets what a document's passwords and permissions are
to be. There are two moments it could act on: at once, rewriting the file as
soon as the panel is accepted, or at the next save, along with everything else
the reader has changed.

Acting at once looks simpler and is not. A save starts from the **original**
bytes the document was read from (ADR-0002), and those bytes are still
encrypted the way the file was when it was opened — with the password the
reader typed to open it, held in `DocumentSecurity.password`. The password
being *set* is a different thing entirely. Writing the new protection to the
file immediately would leave the window holding bytes that want the old
password and a file that wants the new one, and the next `Cmd+S` would have to
know which is which.

It would also make protection the one editing action that cannot be undone,
and the one that writes to disk without being asked to.

## Decision

The panel's answer is stored in `PendingProtection` — a `DocumentProtection`,
or null for a document nobody has asked to change. Nothing is written until a
save. `PdfSaveService.savePdfFromBytes` takes it as `protection` and applies it
to the document it has just placed the objects into, after opening it with
`password` — the old one, whose work is done by then.

This makes protection an ordinary edit:

- **It makes the document dirty.** `protectionChanged` compares the pending
  protection against `SavedProtection`, the same baseline-and-comparison shape
  the placed objects use (ADR-0008). Asking for a protection the document
  already has therefore reports the document clean.
- **It is undoable.** The pending protection is part of `EditorSnapshot`, so
  ⌘Z takes it back with everything else (ADR-0012).
- **It is what the lock shows.** `documentIsProtected` prefers the pending
  protection to the document's own: the button should say what the file will
  carry, not what is still on disk.

### What survives a save

The pending protection **stays pending** after a save to the same file. The
original bytes have not changed, so the next save starts from the old
protection again and has to apply the new one again. Only `SavedProtection`
moves. Save As is the exception: the window turns to a file that already
carries the protection, so both are cleared and the window reopens the new file
with the new password — empty when there is none.

### Why the document is not rewritten to match

After a save, the window still shows the document it opened, with the old
protection in `DocumentSecurity.current` and the new one pending. Reopening the
file to make the two agree was rejected: it would throw away the render cache
and the scroll position for a change the reader cannot see, and the panel
already prefers the pending value when it opens.

## Consequences

- Protection can be set on a document, undone, set differently, and only the
  last of it ever reaches the disk.
- Closing without saving leaves the file exactly as it was — the same promise
  every other edit makes.
- **Protection cannot be fully removed.** Syncfusion's `PdfSecurity` has no way
  to take an `/Encrypt` dictionary out of a document; it can only be given
  passwords and flags. "Remove Protection" therefore writes empty passwords
  and every permission granted: the file opens for anyone, in any reader,
  with nothing withheld, but it is still an encrypted PDF and a tool that
  reports on encryption will still say so. Pressing Remove on a document that
  had no protection at all encrypts it in this same open way. Recorded in
  `REQUIREMENTS §13.16`.
- The algorithm follows the document: one that arrived AES-128 is written back
  AES-128, so the readers it was made for can still open it. Protection this
  app adds to a document that had none is AES-256.
- **Encryption alone cannot be what the app reacts to.** Because a file this
  app has removed protection from is still encrypted, "is it encrypted" no
  longer separates a protected document from an open one. What the lock shows,
  and whether the owner password is asked for, therefore turn on what the
  document *withholds* — see `DocumentSecurity.protectionNeedsOwnerPassword`.
  A document that withholds nothing is treated as open however it is
  encrypted, which is the only reading under which this app's own output
  behaves like what it says it is.
