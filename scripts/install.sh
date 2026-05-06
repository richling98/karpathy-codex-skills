#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
SKILLS_DIR="$CODEX_DIR/skills"
SKILL_NAME="karpathy-guidelines"
TARGET_SKILL_DIR="$SKILLS_DIR/$SKILL_NAME"
TARGET_AGENTS="$CODEX_DIR/AGENTS.md"

mkdir -p "$SKILLS_DIR"

if [ -d "$TARGET_SKILL_DIR" ]; then
  mv "$TARGET_SKILL_DIR" "$TARGET_SKILL_DIR.backup.$(date +%Y%m%d%H%M%S)"
fi

cp -R "$REPO_ROOT/skills/$SKILL_NAME" "$TARGET_SKILL_DIR"

if [ -s "$TARGET_AGENTS" ]; then
  cp "$TARGET_AGENTS" "$TARGET_AGENTS.backup.$(date +%Y%m%d%H%M%S)"
fi

cp "$REPO_ROOT/codex/AGENTS.md" "$TARGET_AGENTS"

echo "Installed $SKILL_NAME to $TARGET_SKILL_DIR"
echo "Installed global Codex instructions to $TARGET_AGENTS"
echo "Restart Codex to load the new skill and instructions."
