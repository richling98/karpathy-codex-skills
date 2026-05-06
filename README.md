# Karpathy-Inspired Codex Guidelines

A Codex-native adaptation of [`forrestchang/andrej-karpathy-skills`](https://github.com/forrestchang/andrej-karpathy-skills), derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on common LLM coding pitfalls.

This repository packages the guidelines in the two formats Codex understands best:

- A reusable Codex skill at `skills/karpathy-guidelines`
- A global Codex instruction file at `codex/AGENTS.md`

Use both if you want the behavior available across projects. The `AGENTS.md` file is the closest Codex equivalent to a global `CLAUDE.md`; the skill gives Codex a named, reusable behavior package it can invoke for coding tasks.

## The Problems

LLM coding agents are useful, but they often fail in predictable ways:

- They make hidden assumptions and keep going instead of asking for clarification.
- They hide uncertainty instead of surfacing ambiguity, inconsistencies, or tradeoffs.
- They overcomplicate solutions with speculative abstractions, excess configurability, and bloated APIs.
- They change nearby code, comments, formatting, or structure that they do not fully understand.
- They treat implementation as the goal instead of defining observable success criteria and verifying the result.

These guidelines are meant to reduce those failures during non-trivial Codex coding work.

## The Solution

Four principles, packaged for Codex:

| Principle | Addresses |
| --- | --- |
| **Think Before Coding** | Wrong assumptions, hidden confusion, missing tradeoffs |
| **Prefer Simplicity** | Overengineering, bloated abstractions, speculative features |
| **Make Surgical Changes** | Unrelated edits, drive-by refactors, accidental churn |
| **Work Toward Verifiable Goals** | Weak success criteria, untested fixes, incomplete loops |

## The Four Principles in Detail

### 1. Think Before Coding

Do not assume silently. Do not hide confusion. Surface meaningful tradeoffs.

Codex should pause when the request, code, or failure mode is ambiguous:

- **State assumptions explicitly** when they affect scope, design, or behavior.
- **Ask for clarification** when guessing could produce the wrong result.
- **Present multiple interpretations** when a request can reasonably mean different things.
- **Push back when warranted** if the requested path is brittle, too broad, or inconsistent with the codebase.

The goal is not to slow down obvious work. The goal is to avoid charging ahead with the wrong interpretation.

### 2. Prefer Simplicity

Write the minimum code that solves the problem and matches the existing codebase.

Codex should avoid:

- Features beyond what was asked
- Abstractions for one-off code
- "Flexible" APIs that no caller needs
- New dependencies when existing helpers are enough
- Defensive handling for impossible scenarios
- Large rewrites when a focused fix would work

The test: would a senior engineer look at the diff and say it is doing more than the request requires? If yes, simplify.

### 3. Make Surgical Changes

Touch only what the task requires.

When editing existing code, Codex should:

- Avoid refactoring adjacent code unless required for the task.
- Avoid reformatting or renaming unrelated code.
- Match existing local style even when another style would be preferable.
- Remove imports, variables, functions, and files made unused by its own edits.
- Mention unrelated dead code or suspicious behavior instead of deleting it.

The test: every changed line should trace back to the user's request or required verification.

### 4. Work Toward Verifiable Goals

Turn implementation requests into success criteria Codex can check.

| Instead of... | Transform to... |
| --- | --- |
| "Fix the bug" | Reproduce or identify the failing path, then verify the fix |
| "Add validation" | Cover invalid inputs, then make the relevant checks pass |
| "Refactor this module" | Establish baseline behavior, change it, then verify behavior is preserved |
| "Clean this up" | Define what better means: fewer duplicates, clearer API, passing tests, or smaller surface area |

For multi-step tasks, Codex should keep a short plan:

```text
1. Inspect the failing path -> verify by finding the caller and expected behavior.
2. Add the minimal fix -> verify with the narrowest relevant test.
3. Check for side effects -> verify with formatting, type checks, or a targeted suite when available.
```

Strong success criteria let Codex loop independently. Weak criteria make it easier for the agent to stop after code changes without proving anything.

## Install

### Option A: Install Both the Skill and Global Instructions

Recommended for most users.

```bash
git clone https://github.com/richling98/karpathy-codex-skills.git
cd karpathy-codex-skills
./scripts/install.sh
```

The installer copies:

- `skills/karpathy-guidelines` to `${CODEX_HOME:-$HOME/.codex}/skills/karpathy-guidelines`
- `codex/AGENTS.md` to `${CODEX_HOME:-$HOME/.codex}/AGENTS.md`

If an existing global `AGENTS.md` exists and is not empty, the installer writes a timestamped backup before replacing it.

Restart Codex after installation so the new skill and global instructions are loaded.

### Option B: Manual Install

Use this if you want to inspect or merge files yourself.

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/karpathy-guidelines "${CODEX_HOME:-$HOME/.codex}/skills/"
cp codex/AGENTS.md "${CODEX_HOME:-$HOME/.codex}/AGENTS.md"
```

If you already have global Codex instructions, merge `codex/AGENTS.md` into your existing `${CODEX_HOME:-$HOME/.codex}/AGENTS.md` instead of replacing it.

### Option C: Per-Project AGENTS.md

Use this if you only want the guidelines in one repository.

```bash
cp codex/AGENTS.md /path/to/your/repo/AGENTS.md
```

For an existing project with an `AGENTS.md`, append or merge the sections manually:

```bash
cat codex/AGENTS.md >> /path/to/your/repo/AGENTS.md
```

Project-level instructions can override or extend global instructions, so this is a good place to add repo-specific testing commands, style rules, and architecture constraints.

## Using the Skill

Once installed, Codex can use the skill automatically when a coding task matches its description. You can also invoke it explicitly:

```text
Use $karpathy-guidelines while refactoring this module.
```

Good prompts:

- `Use $karpathy-guidelines to fix this bug with the smallest safe change.`
- `Use $karpathy-guidelines to review this PR for behavioral risks and missing tests.`
- `Use $karpathy-guidelines while adding validation to this form.`
- `Use $karpathy-guidelines to simplify this implementation without changing behavior.`

## Repository Layout

```text
codex/AGENTS.md
skills/karpathy-guidelines/SKILL.md
skills/karpathy-guidelines/agents/openai.yaml
scripts/install.sh
LICENSE
README.md
```

### `codex/AGENTS.md`

The global instruction template. This is the file coworkers can copy into `${CODEX_HOME:-$HOME/.codex}/AGENTS.md` or into a specific repository as `AGENTS.md`.

### `skills/karpathy-guidelines/SKILL.md`

The Codex skill. It includes YAML frontmatter for discovery and concise instructions for how Codex should behave when the skill triggers.

### `skills/karpathy-guidelines/agents/openai.yaml`

Optional UI metadata for Codex skill lists and chips.

### `scripts/install.sh`

Installer that copies the skill and global `AGENTS.md` template into the current user's Codex directory.

## How to Know It Is Working

You should see:

- Smaller diffs with fewer unrelated edits
- More clarification before implementation when the request is ambiguous
- More explicit assumptions and tradeoffs
- Less speculative architecture and fewer unused extension points
- Focused tests or verification steps for non-trivial changes
- Final responses that clearly report what changed and what was checked

You should not see:

- Large rewrites for small requests
- Formatting churn in unrelated files
- New dependencies without a concrete need
- Hidden assumptions that only become obvious after the diff is wrong
- "Done" responses with no verification details

## Customization

These guidelines are designed to be merged with your own project rules.

For global customization, edit:

```text
${CODEX_HOME:-$HOME/.codex}/AGENTS.md
```

For project-specific customization, edit the repo's `AGENTS.md`:

```markdown
## Project-Specific Guidelines

- Run `npm test` before finalizing changes that touch application logic.
- Use TypeScript strict mode.
- Follow the existing error handling pattern in `src/utils/errors.ts`.
- Do not introduce new dependencies without approval.
```

Keep project-specific rules concrete. Codex follows instructions better when they identify exact commands, paths, and constraints.

## Tradeoff Note

These guidelines bias Codex toward caution and verification. That is useful for real engineering work, but it should not turn obvious one-line changes into ceremony.

For trivial tasks like typo fixes, import cleanup, or mechanical one-line edits, use judgment. The goal is to reduce costly mistakes on meaningful changes, not to slow down simple work.

## Troubleshooting

### The Skill Does Not Appear

Restart Codex after installation. Skills are discovered from `${CODEX_HOME:-$HOME/.codex}/skills`, and a running Codex session may not reload them immediately.

### The Installer Replaced My AGENTS.md

If your previous global `AGENTS.md` was not empty, the installer created a timestamped backup next to it:

```text
${CODEX_HOME:-$HOME/.codex}/AGENTS.md.backup.YYYYMMDDHHMMSS
```

Merge any custom instructions from the backup into the new file.

### I Only Want the Skill

Copy just the skill directory:

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/karpathy-guidelines "${CODEX_HOME:-$HOME/.codex}/skills/"
```

### I Only Want Global Instructions

Copy or merge only the `AGENTS.md` template:

```bash
cp codex/AGENTS.md "${CODEX_HOME:-$HOME/.codex}/AGENTS.md"
```

## Attribution

Adapted for Codex from [`forrestchang/andrej-karpathy-skills`](https://github.com/forrestchang/andrej-karpathy-skills), which packages Karpathy-inspired coding guidance for Claude Code.

Original inspiration: [Andrej Karpathy's post on LLM coding pitfalls](https://x.com/karpathy/status/2015883857489522876).

## License

MIT
