# ADR-0009: Cut, Copy and Paste Through the System Pasteboard

## Status

Accepted.

## Context

The editor had a copy/paste implementation already: `PdfViewer` kept a
`String? _clipboardImageId` and duplicated that object on paste. It had never
run. `Cmd+C` and `Cmd+V` were handled in a `Focus.onKeyEvent` callback, and with
a `PlatformMenuBar` installed a `Cmd` key equivalent never reaches the widget
tree. Measured on 2026-09-15 against the running app: `PageDown` reached the
handler and scrolled the document, while `Cmd+G`, `Cmd+=` and `Cmd+C` produced
nothing, with faithful modifier synthesis (see REQUIREMENTS §13.11).

So the feature had to be built from the menu inward, and the question of *where
the copied thing lives* was open.

Two things constrain the answer:

- **Each window is a separate Dart isolate** (ADR-0006). A field in a widget's
  state, a `static`, or a provider is per window. Copy in one window and paste
  in another — the ordinary expectation on macOS — cannot work that way.
- **A placed object is not self-contained.** It points at a library row and at a
  file in app storage, and deleting the row deletes the file (§13.1). Something
  copied an hour ago may reference an image that no longer exists.

## Decision

Cut, copy and paste go through the **system pasteboard**, and every `Cmd`
shortcut is an **Edit-menu item**.

A copy writes one pasteboard item with two renditions:

1. `com.ivanvaganov.pdfsign.placed-object` — UTF-8 JSON with the source image
   id, storage path, size, position and rotation. Restores the object exactly.
2. `public.png` or `public.jpeg` — the image itself.

A paste prefers the first and falls back to the second.

An image pasted from another application is **stored with the document, not in
the library**: the bytes go to a `pasted/` folder in app support under a UUID,
and the placed object gets no `sourceImageId`. It still needs a file, because
the object is drawn from its path and `PdfSaveService` reads that path when
embedding it. The folder is swept when the main window starts — the one moment
no document window exists — so a session's scratch files cannot outlive the
session by more than one launch.

Each action asks whether a text field holds the keyboard and, if so, hands the
action to it via `CopySelectionTextIntent` / `PasteTextIntent`.

## Consequences

**What this buys**

- Copy in one window, paste in another, with no broadcast to write or maintain.
  The pasteboard is already shared; `WindowBroadcast` stays out of it.
- An object copied here pastes into Mail, Preview or Pages as an image.
- An image copied anywhere pastes onto the page.
- A paste survives the library row being deleted in between: the bitmap
  rendition is re-stored, and the object comes back at the size and rotation it
  was copied at.
- Pasting a screenshot does not leave anything in the user's collection of
  stamps and signatures.
- Text fields got Cut/Copy/Paste, which had never worked anywhere in the app.

**What it costs**

- **The pasteboard is untrusted input.** Any application can write bytes under
  our type name. `ClipboardPlacedObject.fromJson` validates every field and
  returns null rather than throwing; an unreadable payload is treated as absent
  so the bitmap beside it can still be used.
- **Paste cannot be greyed out accurately.** `PlatformMenuBar` offers no hook to
  revalidate an item as the menu opens, and polling the pasteboard would be
  worse. Paste stays enabled and does nothing when there is nothing usable
  (§13.12). Cut and Copy do follow the selection and the focus.
- **Nothing owns a pasted image's file** the way a library row owns its image,
  so the sweep at startup is what keeps the folder from growing without bound.
  It cannot run while any document window is open: an object pasted in one
  window can be copied into another, so the files are shared for the length of
  a session. A crash therefore leaves files behind until the next cold start.
- **A pasted image cannot be reused later** — it is not in the sidebar to drag
  into a second document. Adding it deliberately is what the Add Image button
  is for.
- **Copying refuses when the source file is gone.** There would be no bytes to
  offer another application and no path worth writing. The alternative,
  writing a payload that cannot be pasted, is worse than saying no.

## Alternatives considered

**Keep the object in memory, per window.** What the dead code did. Simple, and
wrong on ADR-0006: it cannot cross a window, which is most of what the feature
is for.

**Native storage, like the settings singleton (ADR-0005).** Would cross windows.
But it would not cross applications in either direction, and it would need its
own lifetime rules — when is a copied object stale? The pasteboard answers that
already.

**Importing pasted images into the library.** What the first version did, and
what makes the file's lifetime somebody's responsibility for free. Rejected
because it fills the user's collection with one-off screenshots. Keeping the
bytes in memory instead of a file was also considered: it needs no sweep at all,
but it puts byte arrays inside `PlacedImage`, which `documentDirtyProvider`
compares on every change, and it splits drawing, saving and copying into two
paths each.

**A bitmap only, no private format.** Fewer moving parts, and it would still
cross windows. But the size, rotation and library identity would be lost on
every paste, turning a copy into a re-import.
