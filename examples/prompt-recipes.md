# Prompt recipes

Use these prompts with Claude Code, Codex CLI, or another MCP-capable agent after configuring `chrome-devtools`.

## Safe tab inventory

```text
List my open Chrome tabs. For each candidate, show page id, title, URL origin, and why it may match. Do not click, type, navigate, submit, or change anything.
```

## Inspect selected tab read-only

```text
Select page id <id>, take a text snapshot only, and summarize what is visible. Do not click or type.
```

## Debug a local dev page

```text
Find my local dev server tab, take a snapshot, show console errors, and list failed network requests. Do not modify the page.
```

## Show console errors

```text
For the selected tab, list console errors and warnings. Include the message, source if available, and likely next debugging step.
```

## Show failed network requests

```text
For the selected tab, list recent failed network requests. Include method, URL, status, and response detail when available.
```

## Use an authenticated dashboard safely

```text
Use the already-open dashboard tab and summarize the visible status. Treat it as sensitive. Do not click, export, change filters, or reveal private data beyond what is needed for this request.
```

## Create an agent-owned tab

```text
Create a new agent-owned tab for this task, record its page id, title, and URL, and only interact with that tab unless I explicitly say otherwise.
```

## Multi-agent handoff

```text
Continue using page id <id> for this task. Re-select it, take a fresh snapshot, and do not touch any other Chrome tabs.
```

## Lighthouse and performance check

```text
Run a Lighthouse snapshot and a short performance trace for this tab. If a reload is required, ask first. Summarize the biggest accessibility, SEO, best-practice, and performance issues.
```

## MCP recovery

```text
The Chrome tools are failing. Check whether the chrome-devtools MCP server is connected, explain the likely failure mode, and give me the next manual recovery step. Do not change my Chrome settings automatically.
```

## Confirm before submit

```text
Fill this form with the provided test data, stop before submitting, and tell me exactly what would be submitted. Ask for confirmation before clicking any submit or save button.
```
