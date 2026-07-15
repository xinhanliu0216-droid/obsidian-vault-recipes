---
name: wiki-build
description: Turn existing source pages into reusable entity, concept, topic, comparison, or synthesis pages while preserving evidence and avoiding duplicate nodes. Use when the vault has ingested sources but needs cross-source structure, comparisons, or a maintained knowledge graph.
---

# Wiki Build

Create reusable structure from already ingested evidence.

## Select candidates

1. Read `CLAUDE.md`, `index.md`, and relevant Source pages.
2. Search for existing aliases and near-duplicate pages.
3. Prefer candidates that appear across sources, answer recurring questions, or connect several pages.
4. Apply scenario-specific creation conditions.

## Plan

For each candidate, state:

- Proposed page type and filename
- Which existing pages support it
- Why a new page is better than updating an existing page
- Which pages and index entries would change

Wait for confirmation before writing.

## Build

- Keep one stable subject per page.
- Include supporting and conflicting evidence.
- Mark synthesis as draft when evidence is incomplete.
- Add bidirectional contextual links where useful; do not add links only to inflate graph density.
- Avoid copying long source passages.

## Verify

- No duplicate page or alias was introduced.
- Claims link to Source pages.
- New pages have frontmatter, inbound context, and index entries.
- The operation is appended to `log.md`.
- Summarize what became easier to find or answer.

