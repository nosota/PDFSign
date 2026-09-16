# ADR-0010: Page Rotation Written as `/Rotate`

## Status

Accepted.

## Context

Readers need to turn a page that was scanned sideways. The turn has to reach
the saved file, the way Preview does it.

Investigating how the app already handled turned pages uncovered a defect that
had been there all along, and that any rotation feature would have walked
straight into.

**A page the file marks as turned was displayed distorted.** pdfx reports a
page's media box — the page *before* `/Rotate` — but renders it *after*
`/Rotate`. The page column sized a portrait slot and squeezed a landscape image
into it. Measured on 2026-09-16 against a page carrying `/Rotate 90`: the slot
was 595×842 while the bitmap was landscape.

**And a stamp placed on such a page was saved in the wrong place.** Syncfusion's
graphics draw in the page's own unrotated space whatever `/Rotate` says: a
rectangle written at `(0, 0, 120, 60)` renders at the *top right* of the
displayed page, standing on end. Nothing in the save path compensated.

So the question was not only how to store a turn, but which space everything
else is expressed in.

## Decision

A turn is written as the page's **`/Rotate`**, the mechanism the PDF
specification provides, and everything in the editor works in **the page as the
reader sees it**.

- `PdfPageInfo.width`/`height` are the *displayed* sides. A page with
  `/Rotate 90` reports 842×595. Layout, drop placement, pasting and hit-testing
  therefore need to know nothing about rotation, and the distortion is gone.
- `PdfPageInfo.rotation` is how the page stands now; `fileRotation` is what the
  file has. The difference is the unsaved turn, and it is also the number of
  quarter turns the rendered bitmap still needs — applied with a `RotatedBox`,
  so **turning a page costs no re-render and evicts nothing from the cache**.
- `PageRotationTransform` is the only place that maps between the reader's view
  and the file's space. Its 90° case is anchored to the measurement above
  rather than derived on paper.
- Objects on a page are turned with it, keeping their place relative to the
  page's content.
- A page's turn makes the document dirty through `isRotatedFromFile`, not
  through a separate baseline: the page already carries both numbers.

Rotation is read at open with the PDF writer the app already depends on, since
pdfx does not expose it. Measured at 77 ms for a 300-page document.

## Consequences

**What this buys**

- A scanned sideways page finally displays and saves correctly, whether or not
  anybody presses a rotate button.
- The saved file is ordinary: every viewer understands `/Rotate`, and a reader
  can turn the page back in any other tool.
- Nothing in the page column, the drop target or the clipboard learned about
  rotation. They were already written against "the page as displayed"; that
  statement simply became true.

**What it costs**

- **The file is read twice at open** — once by the renderer, once to read the
  page dictionaries. The second read hits the operating system's cache.
- **A page whose rotation cannot be read is shown unturned.** A wrong
  orientation is a visible annoyance; refusing to open the document is a lost
  document.
- **Objects are stored against the current view.** Turning a page rewrites the
  objects on it, so a turn is not free of consequence for them — it is exactly
  as consequential as it looks, which is the point.
- **Rounding.** Positions are doubles and a quarter turn is exact, so four
  turns return an object to its original numbers. Its own angle is wrapped into
  a single turn for the same reason: an angle drifting to 2π would leave a
  visually unchanged document comparing as modified.

## Alternatives considered

**Baking the turn into the page content.** Create a new page with the sides
swapped and draw the old one into it rotated. It would have avoided teaching
the app about `/Rotate` at all. Rejected: it rewrites the page object, losing
annotations and links, and it leaves the display defect in place for pages that
arrive already turned. Avoiding a fix by destroying content is the wrong trade
for a signing tool.

**Turning only the view, not the file.** A fraction of the work, and the reader
would lose the turn on every reopen. Preview does not do this, and it would not
be what was asked for.

**Storing objects in the file's space and mapping for display.** The mirror
image of the decision. Rejected because the editor is all display: every drop,
drag, handle and paste would have to map on the way in, instead of one mapping
on the way out at save time.
