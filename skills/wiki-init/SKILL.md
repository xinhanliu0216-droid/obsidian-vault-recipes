---
name: wiki-init
description: Initialize a new Obsidian LLM Wiki vault with a concise CLAUDE.md, immutable raw layer, wiki directories, index, log, and one selected scenario. Use for a new vault, missing schema, or a request to set up the Karpathy LLM Wiki structure.
---

# Wiki Init

Build the smallest usable Vault after the user confirms the proposed structure.

## Gather

Ask only for missing decisions:

1. What knowledge will accumulate here?
2. What recurring output should the Wiki support?
3. Which primary scenario fits: course, research, product, project, personal, book, or general?
4. Which content is private or outside Agent access?
5. What language and filename convention should be used?

Inspect existing files first so initialization never overwrites a populated Vault.

## Propose

Present:

- Files and directories to create
- Existing files that would be affected
- Selected scenario additions
- Any conflicts or migration decisions

Wait for confirmation before writing.

## Create

Use this stable core:

```text
CLAUDE.md
raw/
wiki/sources/
wiki/entities/
wiki/concepts/
wiki/topics/
wiki/synthesis/
index.md
log.md
```

Keep `CLAUDE.md` under 200 lines. Include goal, permissions, evidence rules, ingest/query/lint workflows, scenario rules, and completion checks.

## Verify

- Existing content was not overwritten.
- `raw/` is explicitly read-only in the Schema.
- `index.md` and `log.md` are at the Vault root.
- The chosen scenario has no unresolved placeholders.
- Report every created file and any remaining user decision.

