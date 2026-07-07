---
name: open-chrome-bridge
description: Use when the user wants to inspect, navigate, or control already-open Google Chrome tabs through the chrome-devtools MCP server. Covers listing tabs, selecting existing pages, clicking/typing, screenshots, console/network inspection, performance checks, safe tab ownership, and recovery when auto-connect fails.
---

# Open Chrome Bridge

This is the Claude Code skill adapter for Open Chrome Bridge. It helps Claude Code control an already-open local Google Chrome session through the `chrome-devtools` MCP server. The same MCP command can also be used by Codex CLI and other MCP-capable agents.

Use this skill when the user asks to:

- inspect or control opened Chrome tabs
- use an agent with an existing Chrome browser session
- operate a logged-in website already open in Chrome
- take screenshots or text snapshots of Chrome pages
- inspect browser console messages or network requests
- run Lighthouse or performance diagnostics
- diagnose `chrome-devtools` MCP auto-connect failures

## Requirements

Claude Code must have this MCP server configured:

```text
chrome-devtools: npx -y chrome-devtools-mcp@latest --autoConnect
```

The local setup should attach to an existing Google Chrome session after Chrome remote debugging is allowed.

## Standard workflow

1. Check MCP status if needed:

   ```bash
   claude mcp list
   ```

   Expected healthy line:

   ```text
   chrome-devtools: npx -y chrome-devtools-mcp@latest --autoConnect - ✔ Connected
   ```

2. Use `mcp__chrome-devtools__list_pages` to see open tabs.

3. Use `mcp__chrome-devtools__select_page` before interacting with a specific tab.

4. Prefer `mcp__chrome-devtools__take_snapshot` over screenshots for page understanding and element UIDs.

5. Use Chrome DevTools MCP tools directly for browser actions:

   - `navigate_page`, `new_page`, `reload`
   - `click`, `fill`, `fill_form`, `type_text`, `press_key`, `hover`, `upload_file`
   - `take_snapshot`, `take_screenshot`, `wait_for`
   - `list_console_messages`, `get_console_message`
   - `list_network_requests`, `get_network_request`
   - `evaluate_script`, `emulate`
   - `performance_start_trace`, `performance_stop_trace`, `lighthouse_audit`, `take_heapsnapshot`

## Tab inventory protocol

When a task may involve multiple tabs:

1. List pages first.
2. Report candidate tabs by page id, title, URL origin, and reason for selection.
3. Ask the user to choose if more than one tab could match.
4. Select by page id before every interaction.
5. Re-list pages after navigation, reload, long pauses, or any sign that the selected page changed.

## Agent-owned tab protocol

When the user wants isolated agent work without a daemon or browser extension:

1. Ask whether to use an existing tab or create a new agent-owned tab.
2. If creating a tab, use `new_page` and record its page id, title, and URL.
3. Treat that page id as the agent-owned tab for the task.
4. Do not close, navigate away from, or mutate unrelated tabs.
5. If another agent may be active, announce the intended tab before acting.

## Action reporting

For browser actions, report briefly:

- selected page id and title when available
- action category: read-only, navigation, form input, state-changing, diagnostic
- whether the action may affect remote/shared state
- observed result
- next safe step or blocker

Ask for explicit confirmation before state-changing actions such as submitting forms, posting content, changing settings, buying items, deleting records, uploading files, or triggering production workflows.

## Multi-agent etiquette

If multiple agents may use Chrome:

- Keep each agent's active tab set explicit in the conversation.
- Prefer new agent-owned tabs for exploratory work.
- Never close tabs unless the user asks.
- Re-list pages before acting if the task resumed after a delay.
- Use snapshots before clicks when possible.

## Known limitations

- Some sites reject synthetic clicks or input and require manual user interaction.
- Cross-origin iframe behavior may vary; navigate directly to the iframe URL when needed and safe.
- The MCP host must expose the `chrome-devtools` tools for this skill to work.
- Snapshots can go stale after page changes; take a fresh snapshot before acting.
- Open Chrome Bridge does not provide browser-enforced tab isolation, a persistent daemon, a browser extension, or built-in PDF export.

## Recovery when connection fails

If `claude mcp list` or browser tools fail with `DevToolsActivePort` missing or Chrome remote-debugging permission errors:

1. Ask the user to open this in Chrome:

   ```text
   chrome://inspect/#remote-debugging
   ```

2. Have them allow/enable remote debugging.

3. Retry `claude mcp list` and then `mcp__chrome-devtools__list_pages`.

If tools are connected but a page action fails, re-list pages, re-select the intended tab, take a fresh snapshot, and retry only if the action is still safe.

## Safety and privacy

- Treat open tabs as potentially authenticated and sensitive.
- Prefer read-only inspection until the user explicitly requests an action.
- Do not submit forms, post content, buy items, delete data, upload files, trigger workflows, or perform account actions unless the user explicitly requests that specific action.
- Prefer reading snapshots and asking before taking actions that change remote/shared state.
- Do not expose cookies, tokens, session storage, local storage, or private page contents unless the user specifically asks for the data and it is necessary for the task.

## Reporting

When successful, report the selected tab and observed result briefly. If blocked, report whether the issue is MCP config, Chrome permission, missing tab, stale snapshot, page state, site behavior, or host tool exposure.
