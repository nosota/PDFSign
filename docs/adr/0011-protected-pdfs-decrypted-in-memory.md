# ADR-0011: Protected PDFs are decrypted in memory for the renderer

**Status:** Accepted
**Date:** 2026-09-16

## Context

PDFSign must open password-protected documents, keep their protection when
saving, and keep it in the copy made for Share.

The two PDF libraries divide the work: pdfx renders, syncfusion writes.
Neither can do this alone.

- **pdfx accepts a password on its Dart API and drops it on macOS.** Its macOS
  implementation opens a `CGPDFDocument` from a path with no password argument
  at all (`SwiftPdfxPlugin.swift`), and returns nothing for any document
  CoreGraphics calls encrypted — including one that needs no password, carrying
  only an owner password to restrict what may be done with it. Those documents
  are opened silently by Preview and were refused outright by PDFSign.
- **syncfusion does take a password**, opens a document with either the user or
  the owner password, and — measured, because its documentation does not say so
  — keeps the original `/Encrypt` when saving: same algorithm, same
  permissions, and both original passwords still working, including the owner
  password, which cannot be derived from the user one.

## Decision

A protected document is opened with syncfusion, and a copy with both passwords
cleared is handed to pdfx in memory. The copy is identical page for page;
only the protection is gone from it.

**The decrypted copy never reaches the disk.** Writing it would leave an
unprotected copy of a protected document behind. Every save still starts from
the original bytes (ADR-0002), read with the same password, and the protection
carries into the saved file by itself.

Whether a file is encrypted at all is asked of CoreGraphics through the
`com.pdfsign/pdf_security` channel, because neither library can answer it:
pdfx only refuses, and syncfusion reports a default algorithm for a plain file
that cannot be told from a real one.

## Alternatives considered

**Patch pdfx to call `unlockWithPassword`.** Five lines of Swift, and the
password already travels to the platform side unused. Rejected because it means
carrying a fork of a third-party plugin for as long as the plugin is used.

**Replace pdfx with pdfrx**, which is built on PDFium and has a real
`passwordProvider`. Rejected for now: it requires Flutter 3.47 and macOS 12
against this project's 10.15, and it has no way to draw an image onto an
existing page — the one thing this app exists to do. Its image APIs are
reachable only from `createFromJpegData`, and are JPEG-only, so a signature
with a transparent background would arrive as a white box. Moving to it would
not remove syncfusion; it would only change which library renders.

## Consequences

- Opening a protected document costs a full decrypt-and-rewrite once: 483 ms
  for a 300-page, 1.3 MB document. Plain documents are unaffected — they are
  still opened straight from the file, so a large one is not pulled into
  memory.
- A protected document is held in memory whatever its size, because it cannot
  be read from the file as it stands. Above the threshold in
  `core/constants/document_memory.dart` the reader is told so.
- Saving costs nothing extra: measured at 36 ms against 38 ms for the same
  document with no encryption at all.
- Certificate-protected documents cannot be opened. syncfusion handles the
  standard security handler only, and says so by refusing.
