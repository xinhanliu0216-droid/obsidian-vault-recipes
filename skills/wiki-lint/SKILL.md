---
name: wiki-lint
description: Run a read-only health check on an LLM Wiki for broken links, orphan pages, duplicate concepts, missing evidence, stale synthesis, index drift, and schema conflicts. Use after ingestion, on a maintenance cadence, or before trusting a major synthesis.
---

# Wiki Lint

Inspect first. Do not mix diagnosis and repair.

## Choose scope

- After ingest: touched files, raw integrity, evidence links, index, log
- Weekly: broken links, orphan pages, duplicate names, unverified items
- Monthly: stale synthesis, unresolved contradictions, unused or conflicting rules
- Structural change: full Vault and scenario acceptance cases

If the user does not specify scope, choose the smallest scope that answers the concern.

## Inspect

1. Read the Schema and index.
2. Check required frontmatter and relative source paths.
3. Find unresolved wikilinks and pages missing from the index.
4. Find concepts with similar names before calling them duplicates.
5. Check whether synthesis pages include current evidence and conflicts.
6. Check that `raw/` was not modified by recorded workflows.

## Report

Group findings by:

- Blocking: source loss, fabricated evidence, privacy exposure
- Important: broken traceability, contradictory rules, stale key conclusion
- Maintenance: orphan, naming drift, missing index entry

For every finding include evidence, impact, and the smallest repair.

## Repair

Do not edit during the report. Offer a file-by-file repair plan and wait for confirmation. After repair, rerun only the affected checks and append one log entry.

