#!/usr/bin/env bash
set -u

status=0

ok() { printf '✓ %s\n' "$1"; }
warn() { printf '! %s\n' "$1"; }
fail() { printf '✗ %s\n' "$1"; status=1; }

printf 'Open Chrome Bridge doctor\n\n'

if command -v node >/dev/null 2>&1; then
  ok "node found: $(node --version 2>/dev/null)"
else
  fail 'node not found; install Node.js so npx is available'
fi

if command -v npx >/dev/null 2>&1; then
  ok "npx found: $(npx --version 2>/dev/null)"
else
  fail 'npx not found; install Node.js or fix PATH'
fi

case "$(uname -s 2>/dev/null || printf unknown)" in
  Darwin)
    if [ -d '/Applications/Google Chrome.app' ] || [ -d "$HOME/Applications/Google Chrome.app" ]; then
      ok 'Google Chrome app found'
    else
      warn 'Google Chrome app not found in /Applications or ~/Applications'
    fi
    ;;
  Linux)
    if command -v google-chrome >/dev/null 2>&1 || command -v chromium >/dev/null 2>&1 || command -v chromium-browser >/dev/null 2>&1; then
      ok 'Chrome/Chromium executable found'
    else
      warn 'Chrome/Chromium executable not found on PATH'
    fi
    ;;
  *)
    warn 'Chrome presence check is best-effort on this OS'
    ;;
esac

printf '\nCanonical MCP server:\n'
printf '  name: chrome-devtools\n'
printf '  command: npx\n'
printf '  args: -y chrome-devtools-mcp@latest --autoConnect\n'

printf '\nRemote debugging recovery URL:\n'
printf '  chrome://inspect/#remote-debugging\n'

if command -v claude >/dev/null 2>&1; then
  printf '\nClaude Code MCP status:\n'
  mcp_output="$(claude mcp list 2>&1)"
  mcp_code=$?
  if [ "$mcp_code" -eq 0 ]; then
    if printf '%s\n' "$mcp_output" | grep -q 'chrome-devtools'; then
      ok 'chrome-devtools appears in claude mcp list'
    else
      warn 'claude mcp list succeeded, but chrome-devtools was not listed'
    fi
    printf '%s\n' "$mcp_output"
  else
    warn 'claude mcp list failed; check Claude Code MCP config'
    printf '%s\n' "$mcp_output"
  fi
else
  printf '\n'
  warn 'claude CLI not found; skipping Claude Code MCP status check'
fi

printf '\nDoctor complete. This script is read-only and does not edit config, install packages, launch Chrome, install a daemon, or install a browser extension.\n'
exit "$status"
