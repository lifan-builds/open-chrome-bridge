# Open Chrome Bridge

**Connect Claude Code, Codex CLI, and other MCP-capable coding agents to the Chrome tabs you already have open.**

Open Chrome Bridge is a lightweight MCP setup and Claude Code skill for agentic browser work in your real Chrome profile: logged-in apps, local dev servers, dashboards, console output, network traffic, screenshots, Lighthouse, and performance traces.

It is not another browser automation framework. It is the missing “use my existing Chrome” bridge: one portable [`chrome-devtools-mcp`](https://www.npmjs.com/package/chrome-devtools-mcp) command, host-specific examples, safer agent instructions, and recovery docs.

## Quick start

The portable MCP server command is:

```bash
npx -y chrome-devtools-mcp@latest --autoConnect
```

Add it to your MCP host as a stdio server named `chrome-devtools`.

```text
name: chrome-devtools
command: npx
args: -y chrome-devtools-mcp@latest --autoConnect
```

Then ask your agent:

```text
List my open Chrome tabs and inspect the selected tab without changing anything.
```

## Requirements

- Google Chrome.
- Node.js with `npx` available.
- An MCP-capable agent host.
- Chrome remote-debugging permission when Chrome prompts for it.
- The `chrome-devtools` MCP server configured with `--autoConnect`.

## Why it exists

Most coding agents can write code, but they often lose the browser context developers actually use: the already-authenticated app tab, the local frontend running on a random port, the failing dashboard, the console error, or the network request you are staring at.

Open Chrome Bridge packages that workflow so agents can inspect the browser you are already using instead of launching a separate empty browser profile.

## Positioning

Use Open Chrome Bridge when you want:

- already-open local Chrome tabs;
- local dev and authenticated app debugging;
- broad existing-tab discovery;
- text snapshots, screenshots, console, and network inspection;
- Lighthouse and performance traces when your host exposes those tools;
- a low additional trust surface with no bridge daemon or browser extension from this repo.

Use alternatives when you need:

- durable background browser sessions;
- extension-level page overlays or browser UX;
- browser-enforced per-agent tab isolation;
- built-in PDF export;
- hosted browser fleets;
- repeatable fresh-browser automation.

## What it enables

- List and select open Chrome tabs.
- Read text snapshots of pages.
- Click, type, and fill forms when explicitly requested.
- Capture screenshots.
- Inspect console messages and network requests.
- Run Lighthouse and performance traces when your host exposes those MCP tools.
- Recover from common Chrome remote-debugging connection failures.

## Capability comparison

| Need | Open Chrome Bridge fit |
| --- | --- |
| Inspect already-open authenticated Chrome tabs | Strong |
| Discover many existing Chrome tabs | Strong |
| Console/network/performance debugging | Strong |
| Agent-managed tab grouping | Workflow convention |
| Browser-enforced agent tab isolation | Not in scope |
| Browser extension UI or overlays | Not in scope |
| Built-in PDF export | Not currently built in |
| Long-running local browser daemon | Not in scope |

See [`references/capability-matrix.md`](references/capability-matrix.md) for a fuller comparison against daemon/extension bridges, Playwright-style automation, and hosted browser services.

## Supported hosts

| Host | Support | Setup |
| --- | --- | --- |
| Claude Code | First-class | MCP config plus the included `SKILL.md` adapter |
| Codex CLI | Supported | Add `chrome-devtools` under `[mcp_servers]` in `~/.codex/config.toml` |
| Claude Desktop and other `mcpServers` hosts | Supported when stdio MCP tools are available | Use the `mcpServers` JSON shape |
| Generic MCP agents and IDEs | Supported when they run stdio MCP servers | Use the command, args, or generic JSON example |

MCP hosts use different config names, but the stable pieces are always:

- server name: `chrome-devtools`
- command: `npx`
- args: `-y chrome-devtools-mcp@latest --autoConnect`

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

Use the optional installer:

```bash
./scripts/install-skill.sh
```

Or clone this repo and copy the skill manually.

macOS/Linux:

```bash
git clone https://github.com/lifan-builds/open-chrome-bridge.git
mkdir -p ~/.claude/skills/open-chrome-bridge
cp open-chrome-bridge/SKILL.md ~/.claude/skills/open-chrome-bridge/SKILL.md
```

Windows PowerShell:

```powershell
git clone https://github.com/lifan-builds/open-chrome-bridge.git
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\skills\open-chrome-bridge"
Copy-Item "open-chrome-bridge\SKILL.md" "$env:USERPROFILE\.claude\skills\open-chrome-bridge\SKILL.md"
```

Restart Claude Code or start a new session if the skill is not immediately visible.

## Codex CLI setup

Add this to `~/.codex/config.toml`, or merge it with your existing MCP server list:

```toml
[mcp_servers.chrome-devtools]
command = "npx"
args = ["-y", "chrome-devtools-mcp@latest", "--autoConnect"]
enabled = true
startup_timeout_ms = 20000
```

See [`examples/codex-cli.config.toml`](examples/codex-cli.config.toml).

## Other MCP-capable agents

Use the raw command from [`examples/mcp-command.txt`](examples/mcp-command.txt), the UI fields from [`examples/mcp-ui-fields.txt`](examples/mcp-ui-fields.txt), or adapt one of these common config shapes:

`mcpServers` shape:

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

`servers` shape:

```json
{
  "servers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest", "--autoConnect"]
    }
  }
}
```

See [`examples/generic-mcp-agent.json`](examples/generic-mcp-agent.json).

## Lightweight doctor

Run the optional read-only diagnostic script:

```bash
./scripts/doctor.sh
```

It checks local prerequisites and prints next steps. It does not install packages, edit config, launch Chrome, install a daemon, or install a browser extension.

## Example prompts

- “List my open Chrome tabs.”
- “Inspect this tab without changing anything.”
- “Take a text snapshot of the selected Chrome tab.”
- “Show console errors for the current tab.”
- “List recent network requests on this page.”
- “Use the already-open logged-in dashboard tab and summarize the visible status.”
- “Create a new agent-owned tab for this task and record its page id.”
- “Open the local dev server tab and tell me what is visibly broken.”

More copy-paste recipes are in [`examples/prompt-recipes.md`](examples/prompt-recipes.md). Workflow guidance is in [`references/workflows.md`](references/workflows.md).

## Safety and privacy

This project is intentionally designed to work with your real Chrome profile. That is powerful, but it means open tabs may be authenticated and sensitive.

Agents should not submit forms, publish content, send messages, buy items, delete data, change account settings, upload files, trigger workflows, or reveal private data unless you explicitly ask for that specific action. See [`references/privacy-and-safety.md`](references/privacy-and-safety.md).

## Troubleshooting

If the MCP server cannot connect to Chrome, open this page in Chrome and allow remote debugging:

```text
chrome://inspect/#remote-debugging
```

Then retry your host's MCP status check and list pages again. More detail is in [`references/troubleshooting.md`](references/troubleshooting.md) and [`references/chrome-remote-debugging.md`](references/chrome-remote-debugging.md).

## Repository contents

- [`SKILL.md`](SKILL.md): Claude Code skill adapter and operating guide.
- [`examples/`](examples): host-specific configs, UI fields, and prompt recipes.
- [`references/`](references): capability matrix, workflows, setup, privacy, and troubleshooting notes.
- [`scripts/`](scripts): optional lightweight install and diagnostic helpers.
- [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json): Claude plugin packaging metadata.

## License

MIT
