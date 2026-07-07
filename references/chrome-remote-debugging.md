# Chrome remote debugging

Open Chrome Bridge relies on `chrome-devtools-mcp` connecting to your existing Google Chrome session.

The recommended MCP command is:

```bash
npx -y chrome-devtools-mcp@latest --autoConnect
```

`--autoConnect` asks the MCP server to attach to an available local Chrome session instead of making the agent manage a separate browser profile.

## What this does not do

Open Chrome Bridge does not install:

- a browser extension
- a persistent local daemon
- an isolated Chrome profile
- a hosted browser session
- a custom browser automation runtime

It uses the Chrome/DevTools/MCP path exposed by your configured host.

## Allow remote debugging

If the MCP server cannot attach to Chrome, open this page in Chrome:

```text
chrome://inspect/#remote-debugging
```

Allow or enable remote debugging if Chrome prompts you. Then retry your MCP host's status check.

## Host checks

Claude Code:

```bash
claude mcp list
```

Expected:

```text
chrome-devtools: npx -y chrome-devtools-mcp@latest --autoConnect - ✔ Connected
```

Codex CLI:

```toml
[mcp_servers.chrome-devtools]
command = "npx"
args = ["-y", "chrome-devtools-mcp@latest", "--autoConnect"]
enabled = true
```

Other MCP hosts should show a connected stdio server named `chrome-devtools` and expose its browser tools.

## Common blockers

- Chrome is not running.
- The useful tab is in a different Chrome profile or browser variant.
- Chrome remote debugging is blocked by browser or device policy.
- The MCP host started before remote debugging was allowed.
- The host timed out while `npx` downloaded or started the server.
- The selected page changed after the last snapshot.

## Recovery sequence

1. Make sure Google Chrome is running.
2. Open `chrome://inspect/#remote-debugging` in Chrome.
3. Allow remote debugging if prompted.
4. Restart or reconnect your MCP host if needed.
5. Run the MCP status check again.
6. Try listing open Chrome pages.

See [`troubleshooting.md`](troubleshooting.md) for symptom-specific recovery.
