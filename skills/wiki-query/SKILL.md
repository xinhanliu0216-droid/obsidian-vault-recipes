---
name: wiki-query
description: Answer questions from an LLM Wiki with page-level evidence, explicit uncertainty, and an optional confirmed write-back of durable insights. Use whenever the user asks the vault a factual, comparative, explanatory, or synthesis question.
---

# Wiki Query

Answer from accumulated Wiki knowledge before reaching for raw sources or the web.

## Retrieve

1. Read `CLAUDE.md` and `index.md`.
2. Search relevant Wiki pages and their linked Source pages.
3. Read raw files only when the Source page lacks necessary detail.
4. Do not use external information unless the user asks and authorizes it.

## Answer

- Lead with the answer, then show supporting pages.
- Distinguish source statements, cross-source synthesis, and inference.
- State what is unknown or contested.
- For comparisons, use the same dimensions for each item.
- Do not cite a page that does not support the nearby claim.

## Optional write-back

Suggest a write-back only when the answer has durable reuse value, such as:

- A recurring comparison
- A new cross-source connection
- A clarified definition
- A documented contradiction

Name the exact file to create or update and summarize the proposed change. Wait for confirmation before writing. Ordinary one-off answers stay in chat.

## Verify

Confirm that each important claim maps to an existing page and that confidence matches the available evidence.

