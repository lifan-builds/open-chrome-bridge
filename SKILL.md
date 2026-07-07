---
name: chrome-opened-control
description: Use when the user wants to inspect, navigate, or control already-open Google Chrome tabs through the chrome-devtools MCP server. Covers listing tabs, selecting existing pages, clicking/typing, screenshots, console/network inspection, performance checks, and recovery when auto-connect fails.
---

# Chrome Opened Control

This skill helps Claude Code control an already-open local Google Chrome session through the `chrome-devtools` MCP server. The underlying MCP setup can also be used by other MCP-capable agents; this `SKILL.md` is the Claude Code runtime package.

Use this skill when the user asks to:

- inspect or control opened Chrome tabs
- use an agent with an existing Chrome browser session
- operate a logged-in website already open in Chrome
- take screenshots or text snapshots of Chrome pages
- inspect browser console messages or network requests
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
   - `click`, `fill`, `fill_form`, `type_text`, `press_key`, `hover`
   - `take_snapshot`, `take_screenshot`
   - `list_console_messages`, `get_console_message`
   - `list_network_requests`, `get_network_request`
   - `performance_start_trace`, `performance_stop_trace`, `lighthouse_audit`

## Recovery when connection fails

If `claude mcp list` or browser tools fail with `DevToolsActivePort` missing or Chrome remote-debugging permission errors:

1. Ask the user to open this in Chrome:

   ```text
   chrome://inspect/#remote-debugging
   ```

2. Have them allow/enable remote debugging.

3. Retry `claude mcp list` and then `mcp__chrome-devtools__list_pages`.

## Safety and privacy

- Treat open tabs as potentially authenticated and sensitive.
- Do not submit forms, post content, buy items, delete data, or perform account actions unless the user explicitly requests that specific action.
- Prefer reading snapshots and asking before taking actions that change remote/shared state.
- Do not expose cookies, tokens, session storage, local storage, or private page contents unless the user specifically asks for the data and it is necessary for the task.

## Reporting

When successful, report the selected tab and observed result briefly. If blocked, report whether the issue is MCP config, Chrome permission, missing tab, page state, or site behavior.
