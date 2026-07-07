# Troubleshooting

## Doctor checklist

Run the optional read-only checker:

```bash
./scripts/doctor.sh
```

It checks for Node.js, `npx`, Chrome presence, the canonical MCP command, and Claude Code MCP status when the `claude` CLI is available. It does not install packages, edit config, launch Chrome, or start background services.

## Symptom/fix table

| Symptom | Likely cause | Fix |
| --- | --- | --- |
| MCP server missing | Host config does not include `chrome-devtools` | Add the matching example from `examples/` |
| MCP connected but tools unavailable | Host does not expose stdio MCP tools | Check the host's MCP support and tool list |
| `DevToolsActivePort` error | Chrome remote debugging not allowed | Open `chrome://inspect/#remote-debugging` and allow it |
| No tabs found | Chrome is closed, wrong profile, or host is stale | Open Chrome, verify profile, reconnect host |
| Snapshot is empty or stale | Page changed after the last snapshot | Re-select the page and take a fresh snapshot |
| Click/fill fails | Element moved, iframe, or site blocks synthetic input | Take a fresh snapshot; use manual input if required |
| Console/network show no data | Wrong tab, stale selection, or host limitation | Re-select tab, reload if safe, retry tools |
| Startup timeout | `npx` download or server startup is slow | Increase host timeout if supported |
| Node/`npx` missing | Node.js is not installed or not on PATH | Install Node.js and retry |
| Chrome policy blocks debugging | Managed browser/device policy | Use an allowed browser/profile or ask the admin |

## MCP server is not connected

First confirm your host has a `chrome-devtools` stdio MCP server configured with this command:

```bash
npx -y chrome-devtools-mcp@latest --autoConnect
```

Host-specific checks:

- Claude Code: run `claude mcp list` and look for a connected `chrome-devtools` server.
- Codex CLI: check `~/.codex/config.toml` for `[mcp_servers.chrome-devtools]`.
- Other MCP hosts: use the host's MCP server/status UI or command.

If the server is missing, add it from the matching example in `examples/`.

## `DevToolsActivePort` or remote debugging errors

Open this URL in Chrome:

```text
chrome://inspect/#remote-debugging
```

Allow remote debugging if prompted, then retry the MCP status check.

## No tabs found

- Confirm Google Chrome is open.
- Confirm the target tab is in the Chrome profile the MCP server can attach to.
- Retry listing pages.
- If needed, restart or reconnect the MCP host after allowing remote debugging.

## MCP tools are unavailable

The host must expose tools from the `chrome-devtools` MCP server. Tool names vary by host.

In Claude Code, expected tool names include:

- `mcp__chrome-devtools__list_pages`
- `mcp__chrome-devtools__select_page`
- `mcp__chrome-devtools__take_snapshot`
- `mcp__chrome-devtools__click`
- `mcp__chrome-devtools__fill`
- `mcp__chrome-devtools__list_console_messages`
- `mcp__chrome-devtools__list_network_requests`

If another host shows the server as connected but exposes no browser tools, verify that it supports MCP tool calls from stdio servers.

## Recovery ladder

1. Confirm Google Chrome is running.
2. Open `chrome://inspect/#remote-debugging`.
3. Allow remote debugging if prompted.
4. Restart or reconnect the MCP host.
5. Run the host MCP status check.
6. List pages.
7. Select the intended page.
8. Take a fresh snapshot.
9. If still blocked, collect host, OS, Chrome version, MCP command, and exact error.

## Authenticated page concerns

Authenticated tabs are often sensitive. Follow `references/privacy-and-safety.md`, and do not perform state-changing actions unless the user explicitly requests them.
