---
name: wiki-specialize
description: Adapt a general LLM Wiki schema to a real domain or scenario by adding the smallest set of page types, creation conditions, query rules, and tests. Use when the vault changes purpose, combines scenarios, or repeatedly needs domain-specific behavior.
---

# Wiki Specialize

Change the Schema based on observed needs, not a generic industry checklist.

## Diagnose the need

1. Read the current `CLAUDE.md` and relevant log entries.
2. Ask for examples of failed or missing behavior.
3. Identify whether the fix belongs in always-on rules, a path rule, a Skill, or a one-off prompt.
4. Reuse an existing scenario rule when possible.

## Propose the minimum change

Show:

- Existing rule and observed failure
- Proposed replacement or addition
- Any conflicting rule
- A realistic test prompt and expected file result
- Estimated effect on `CLAUDE.md` length

Wait for confirmation before editing rules.

## Apply

- Preserve the Vault's goal and permission boundaries.
- Prefer verifiable conditions over broad adjectives.
- Define new page types only when they will be reused.
- Keep private or device-specific preferences out of shared Schema.
- Move long workflows into a Skill rather than growing `CLAUDE.md`.

## Verify

Run the new test in a temporary or explicitly approved area. Compare against the failure example, update the Schema log, and remove any rule made redundant by this change.

