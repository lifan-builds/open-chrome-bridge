# Troubleshooting

## MCP server is not connected

For Claude Code, run:

```bash
claude mcp list
```

Expected:

```text
chrome-devtools: npx -y chrome-devtools-mcp@latest --autoConnect - ✔ Connected
```

If it is missing, add a `chrome-devtools` MCP server using the example in `examples/claude-code.mcp.json`.

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
- If needed, restart the MCP host after allowing remote debugging.

## MCP tools are unavailable

The host must expose tools from the `chrome-devtools` MCP server. In Claude Code, expected tool names include:

- `mcp__chrome-devtools__list_pages`
- `mcp__chrome-devtools__select_page`
- `mcp__chrome-devtools__take_snapshot`
- `mcp__chrome-devtools__click`
- `mcp__chrome-devtools__fill`
- `mcp__chrome-devtools__list_console_messages`
- `mcp__chrome-devtools__list_network_requests`

Tool names may differ in other MCP hosts.

## Authenticated page concerns

Authenticated tabs are often sensitive. Follow `references/privacy-and-safety.md`, and do not perform state-changing actions unless the user explicitly requests them.
