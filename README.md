# Open Chrome Bridge

Open Chrome Bridge lets MCP-capable coding agents inspect and control already-open Google Chrome tabs through [`chrome-devtools-mcp`](https://www.npmjs.com/package/chrome-devtools-mcp).

It is built for workflows where the useful browser state already exists in your real Chrome profile: logged-in apps, open dashboards, local dev servers, browser console output, and network activity. Claude Code is the first-class target, but the MCP server command works with other MCP-capable agent platforms too.

## What it enables

- List open Chrome tabs.
- Select an existing tab.
- Read text snapshots of pages.
- Click, type, and fill forms.
- Capture screenshots.
- Inspect console messages and network requests.
- Run Lighthouse and performance traces when your host exposes those MCP tools.
- Recover from common Chrome remote-debugging connection failures.

## Requirements

- Google Chrome.
- Node.js with `npx` available.
- An MCP-capable agent host.
- The `chrome-devtools` MCP server configured with `--autoConnect`.

The portable command is:

```bash
npx -y chrome-devtools-mcp@latest --autoConnect
```

## Claude Code setup

### 1. Configure the MCP server

Add a `chrome-devtools` MCP server to your Claude Code MCP config. Use [`examples/claude-code.mcp.json`](examples/claude-code.mcp.json) as the safe minimal shape:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest", "--autoConnect"]
    }
  }
}
```

Then verify:

```bash
claude mcp list
```

Expected healthy line:

```text
chrome-devtools: npx -y chrome-devtools-mcp@latest --autoConnect - ✔ Connected
```

### 2. Install the Claude Code skill

Clone this repo and copy the skill into Claude Code's skill directory:

```bash
git clone https://github.com/lifan-builds/open-chrome-bridge.git
mkdir -p ~/.claude/skills/open-chrome-bridge
cp open-chrome-bridge/SKILL.md ~/.claude/skills/open-chrome-bridge/SKILL.md
```

Restart Claude Code or start a new session if the skill is not immediately visible.

## Other MCP-capable agents

MCP config schemas vary by host. Some use `mcpServers`, others use `servers`, and some provide a UI for adding stdio MCP servers. The important portable pieces are:

- server name: `chrome-devtools`
- command: `npx`
- args: `-y chrome-devtools-mcp@latest --autoConnect`

See [`examples/generic-mcp-agent.json`](examples/generic-mcp-agent.json) for a generic shape.

## Example prompts

- “List my open Chrome tabs.”
- “Inspect this tab without changing anything.”
- “Take a text snapshot of the selected Chrome tab.”
- “Show console errors for the current tab.”
- “List recent network requests on this page.”
- “Use the already-open logged-in dashboard tab and summarize the visible status.”

## Safety and privacy

This project is intentionally designed to work with your real Chrome profile. That is powerful, but it means open tabs may be authenticated and sensitive.

Agents should not submit forms, publish content, send messages, buy items, delete data, change account settings, or reveal private data unless you explicitly ask for that specific action. See [`references/privacy-and-safety.md`](references/privacy-and-safety.md).

## Troubleshooting

If the MCP server cannot connect to Chrome, open this page in Chrome and allow remote debugging:

```text
chrome://inspect/#remote-debugging
```

Then retry `claude mcp list` and list pages again. More detail is in [`references/troubleshooting.md`](references/troubleshooting.md).

## Repository contents

- [`SKILL.md`](SKILL.md): Claude Code runtime skill.
- [`examples/`](examples): safe MCP configuration examples.
- [`references/`](references): setup, privacy, and troubleshooting notes.

## License

MIT
