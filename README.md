# Karpathy Codex Skills

Codex-native adaptation of the Karpathy-inspired coding guardrails from [`forrestchang/andrej-karpathy-skills`](https://github.com/forrestchang/andrej-karpathy-skills).

This repository gives coworkers two things:

- A reusable Codex skill at `skills/karpathy-guidelines`
- A global Codex `AGENTS.md` template at `codex/AGENTS.md`

Use both if you want the behavior available globally. The `AGENTS.md` file acts like the Codex equivalent of a global `CLAUDE.md`; the skill is useful for explicit or automatic skill invocation.

## Install

From a local checkout:

```bash
./scripts/install.sh
```

Or directly from GitHub:

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

## Manual Install

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R skills/karpathy-guidelines "${CODEX_HOME:-$HOME/.codex}/skills/"
cp codex/AGENTS.md "${CODEX_HOME:-$HOME/.codex}/AGENTS.md"
```

If you already have global Codex instructions, merge `codex/AGENTS.md` into your existing `${CODEX_HOME:-$HOME/.codex}/AGENTS.md` instead of replacing it.

## What It Teaches Codex

- Think before coding when assumptions affect scope or behavior
- Prefer the simplest implementation that matches the codebase
- Make surgical changes that trace back to the user request
- Work toward verifiable goals with tests or focused checks
- Report exactly what changed and what was verified

## Files

```text
codex/AGENTS.md
skills/karpathy-guidelines/SKILL.md
skills/karpathy-guidelines/agents/openai.yaml
scripts/install.sh
```

## Attribution

Adapted for Codex from [`forrestchang/andrej-karpathy-skills`](https://github.com/forrestchang/andrej-karpathy-skills), which is based on Andrej Karpathy's observations about common LLM coding pitfalls.
