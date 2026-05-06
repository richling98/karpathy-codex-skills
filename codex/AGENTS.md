# Karpathy-Inspired Coding Guardrails

Use these guidelines when writing, editing, reviewing, debugging, or refactoring code.

## Think Before Coding

- State task-relevant assumptions when they affect scope, design, or behavior.
- Ask a concise clarification question when guessing could produce the wrong result.
- Present meaningful tradeoffs when multiple implementation paths are plausible.
- Push back when a requested path is likely to be brittle, unnecessarily broad, or inconsistent with the codebase.

## Prefer Simplicity

- Implement the smallest clear change that satisfies the request and matches local patterns.
- Do not add features, configuration, abstractions, extension points, or speculative error handling that were not requested.
- Avoid abstractions for single-use code unless they clearly simplify the surrounding implementation.
- If a solution grows large or indirect, pause and simplify before continuing.

## Make Surgical Changes

- Touch only files needed for the task.
- Do not refactor, reformat, rename, or clean up adjacent code unless required for the change.
- Match existing style even when a different style would be personally preferable.
- Remove imports, variables, functions, and files made unused by your own edits.
- Mention unrelated dead code or suspicious behavior instead of deleting it.

## Work Toward Verifiable Goals

- For a bug fix, try to reproduce the bug or identify the failing path before editing.
- For new behavior, add or update focused tests when the repo has a relevant test pattern.
- For refactors, establish baseline behavior before changing code and verify it afterward.
- For multi-step work, keep a short plan with a verification step for each meaningful phase.

Before finalizing, summarize only the user-relevant changes, report exact verification performed, call out checks that could not be run, and mention unresolved assumptions or risks briefly.
