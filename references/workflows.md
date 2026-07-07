# Workflows

These workflows help agents approximate Kimi-style session discipline while keeping Open Chrome Bridge lightweight and MCP-native.

## Safe tab inventory

Ask:

```text
List my open Chrome tabs. For each candidate, show page id, title, URL origin, and why it may match. Do not click, type, navigate, submit, or change anything.
```

Expected behavior:

1. Use `list_pages`.
2. Summarize candidates.
3. Ask before selecting if more than one tab may match.

## Existing-tab selection

Ask:

```text
Select the tab for my local dev app, take a text snapshot only, and tell me what you can see. Do not click anything.
```

Expected behavior:

1. Use `list_pages` if the target page id is unknown.
2. Use `select_page`.
3. Use `take_snapshot`.
4. Report page id, title, and visible state.

## Agent-owned new tab

Ask:

```text
Create a new agent-owned tab for this task, record its page id, and only interact with that tab unless I explicitly say otherwise.
```

Expected behavior:

1. Use `new_page`.
2. Record page id, title, and URL.
3. Treat that page id as the task's tab.
4. Re-list pages after navigation or a long pause.

## Multi-agent handoff

Ask:

```text
Use page id <id> as your tab for this task. Re-select it, take a fresh snapshot, and do not touch other tabs.
```

Expected behavior:

1. Select the provided page id.
2. Take a fresh snapshot.
3. Continue only on that page unless the user changes scope.

## Read-only debugging

Ask:

```text
Inspect the selected tab read-only. Summarize visible errors, console errors, and recent failed network requests. Do not click, type, or navigate.
```

Expected behavior:

1. Take a snapshot.
2. List console messages.
3. List network requests.
4. Report failures and next safe steps.

## Console and network triage

Ask:

```text
Show console errors and failed network requests for this tab. Include request URL, status, and likely cause when visible.
```

Expected behavior:

1. Use console tools first.
2. Use network request listing.
3. Fetch details only for relevant failed requests.

## Lighthouse and performance trace

Ask:

```text
Run a Lighthouse snapshot and a short performance trace for this tab. Summarize the main issues and do not change page state beyond reload if needed.
```

Expected behavior:

1. Confirm whether reload is acceptable if the trace requires it.
2. Run Lighthouse or performance trace tools.
3. Summarize metrics and insights.

## Form submission safety

Ask:

```text
Fill this form with test data, but stop before submitting and tell me exactly what would be submitted.
```

Expected behavior:

1. Take a fresh snapshot.
2. Fill fields only if requested.
3. Stop before submit.
4. Ask for explicit confirmation before clicking submit.

## Stale page or stale snapshot recovery

If an element is missing, a click fails, or the page changed:

1. Re-list pages if the selected tab may have changed.
2. Re-select the intended page.
3. Take a fresh snapshot.
4. Retry only if the target is still visible and the action remains safe.
