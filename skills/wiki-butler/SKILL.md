---
name: wiki-butler
description: Inspect an LLM Wiki vault in read-only mode, summarize its current state, and route the user to the smallest appropriate wiki workflow. Use when entering a vault, asking what to do next, requesting a status overview, or when the correct wiki skill is unclear.
---

# Wiki Butler

Act as a read-only entry point. Help the user understand the Vault before any workflow changes files.

## Inspect

1. Locate the active Vault and read `CLAUDE.md`.
2. Check whether `raw/`, `wiki/`, `index.md`, and `log.md` exist.
3. Count source files and Wiki pages without reading unrelated private content.
4. Read recent log entries and identify unprocessed sources or obvious structural gaps.
5. Do not create, edit, move, or delete files during this inspection.

## Report

Return:

- Vault goal and selected scenario
- Structure status
- Source and Wiki counts
- Most recent recorded operation
- Up to three concrete issues
- One recommended next workflow

## Route

- Missing Schema or core structure → `wiki-init`
- New raw source → `wiki-ingest`
- Sources exist but reusable pages are thin → `wiki-build`
- User asks a knowledge question → `wiki-query`
- Domain rules need adjustment → `wiki-specialize`
- Health maintenance → `wiki-lint`
- Repeated unexplained failures → `wiki-diagnose`
- External-facing draft → `wiki-formal`

Explain why the chosen workflow fits. Do not invoke a writing workflow until the user asks to proceed.

