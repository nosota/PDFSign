# ADR-0007: Lazy PDF Rendering with LRU Cache

## Status

Accepted

## Context

PDF documents can have hundreds of pages. Rendering all pages up front would consume excessive memory and delay initial display. A strategy is needed to render only what the user sees while keeping recently viewed pages cached.

## Decision

PDF pages are rendered lazily:

- Only visible pages plus a 2-page buffer are rendered
- An LRU cache holds up to 10 rendered page images
- Zoom scale is quantized to 2 decimal places to maximize cache hits
- Pages scrolled out of the visible area have their render tasks cancelled

## Consequences

- Fast initial display — only visible pages rendered
- Bounded memory usage — max 10 pages in cache
- Scale quantization avoids re-rendering for minor zoom changes
- Render cancellation prevents wasted work during fast scrolling
- Slight delay when scrolling to uncached pages
