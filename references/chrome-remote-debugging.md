# Chrome remote debugging

Open Chrome Bridge relies on `chrome-devtools-mcp` connecting to your existing Google Chrome session.

The recommended MCP command is:

```bash
npx -y chrome-devtools-mcp@latest --autoConnect
```

`--autoConnect` asks the MCP server to attach to an available local Chrome session instead of making the agent manage a separate browser profile.

## Allow remote debugging

If the MCP server cannot attach to Chrome, open this page in Chrome:

```text
chrome://inspect/#remote-debugging
```

Allow or enable remote debugging if Chrome prompts you. Then retry your MCP host's status check.

For Claude Code:

```bash
claude mcp list
```

Expected:

```text
chrome-devtools: npx -y chrome-devtools-mcp@latest --autoConnect - ✔ Connected
```

## Recovery sequence

1. Make sure Google Chrome is running.
2. Open `chrome://inspect/#remote-debugging` in Chrome.
3. Allow remote debugging if prompted.
4. Restart or reconnect your MCP host if needed.
5. Run the MCP status check again.
6. Try listing open Chrome pages.
