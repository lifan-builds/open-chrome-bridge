#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
SKILL_SRC="$REPO_ROOT/SKILL.md"
SKILL_DIR="$HOME/.claude/skills/open-chrome-bridge"
SKILL_DEST="$SKILL_DIR/SKILL.md"

if [ ! -f "$SKILL_SRC" ]; then
  printf 'Could not find SKILL.md at %s\n' "$SKILL_SRC" >&2
  exit 1
fi

mkdir -p "$SKILL_DIR"
cp "$SKILL_SRC" "$SKILL_DEST"

printf 'Installed Open Chrome Bridge skill to:\n  %s\n\n' "$SKILL_DEST"
printf 'Configure your MCP host with:\n  name: chrome-devtools\n  command: npx\n  args: -y chrome-devtools-mcp@latest --autoConnect\n\n'
printf 'Examples:\n  %s\n  %s\n\n' \
  "$REPO_ROOT/examples/claude-code.mcp.json" \
  "$REPO_ROOT/examples/codex-cli.config.toml"
printf 'This installer does not edit MCP config, install packages, launch Chrome, install a daemon, or install a browser extension.\n'
