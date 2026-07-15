---
name: wiki-ingest
description: Ingest one or a small batch of raw documents into an existing LLM Wiki by creating source pages, updating related pages, index, and append-only log with traceable evidence. Use when the user adds material, asks to process a PDF/article/note, or wants a source incorporated into the wiki.
---

# Wiki Ingest

Integrate sources without changing the raw layer.

## Prepare

1. Read `CLAUDE.md` and `index.md`.
2. Confirm the requested files are under `raw/`.
3. Check whether each source was already ingested.
4. Read the selected scenario rules.
5. For a large batch, propose smaller batches before processing.

## Plan before writing

List:

- Source pages to create
- Existing Wiki pages to update
- New reusable pages, with creation reason
- Index and log changes

Wait for confirmation if any file will be written.

## Ingest

- Preserve the source title, author, date, and location when available.
- Set `source_file` to the relative `raw/` path.
- Separate source statements, Agent inference, and unknowns.
- Link important facts to the Source page.
- Update an existing concept or entity instead of creating a synonym page.
- Record real conflicts rather than replacing the older claim.
- Append one structured log entry.

## Verify

- Hash or timestamp checks show the raw source did not change.
- Every new important claim has a Source link.
- New pages have required frontmatter and at least one meaningful wikilink.
- `index.md` lists new pages once.
- Report created, updated, skipped, and unresolved items.

