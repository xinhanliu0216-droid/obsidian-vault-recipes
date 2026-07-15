---
name: wiki-diagnose
description: Diagnose repeated or unclear LLM Wiki failures by tracing symptoms to schema, source quality, workflow, structure, retrieval, or tool configuration. Use when lint does not explain the problem, Agent behavior drifts, or the same failure survives multiple rule changes.
---

# Wiki Diagnose

Find the root cause before proposing more rules. Remain read-only unless the user separately approves a repair.

## Reproduce

1. Ask for one concrete failed prompt and the unexpected file or answer.
2. Read the instructions that were loaded for that path.
3. Inspect relevant sources, Wiki pages, index, log, and Skill.
4. Determine whether the failure is repeatable or a one-off output.

## Classify

- Schema: missing, vague, conflicting, too long, or not loaded
- Source: absent, poor quality, ambiguous, or outdated
- Workflow: a step was skipped or confirmation boundary unclear
- Structure: duplicate pages, wrong path, index drift
- Retrieval: relevant pages were not found or evidence was too broad
- Tooling: CLI path, permissions, provider, Skill discovery, or plugin state

## Report

Provide:

- Observed symptom
- Direct evidence
- Most likely root cause and alternatives
- One minimal experiment to distinguish them
- Smallest safe repair
- Regression test

Avoid recommending a full rebuild until a smaller experiment has failed. Do not add several rules at once because that hides which change worked.

