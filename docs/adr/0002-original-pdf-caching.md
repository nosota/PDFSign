# ADR-0002: Original PDF Caching

## Status

Accepted

## Context

When saving a PDF with embedded images, Syncfusion PDF modifies the document in place. If the user saves multiple times, each save would re-embed previously embedded images, causing file bloat and quality loss.

## Decision

Original PDF bytes are cached by `OriginalPdfStorage` when a document is opened:

- Files <50 MB are cached in memory
- Files ≥50 MB are cached in a temporary file

Every save operation starts from the cached original, not the previously saved version.

## Consequences

- Multiple Save operations do not accumulate embedded images
- Each save always starts from a clean original
- Memory-efficient handling for large files (temp file fallback)
- Temporary files are cleaned up on document close or app exit
- Slight memory overhead for small files (kept in RAM)
