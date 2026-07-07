# Privacy and safety

Open Chrome Bridge targets your real, already-open Chrome session. That means pages may contain authenticated accounts, private dashboards, customer data, payment flows, or internal tools.

## Trust surface

This repo does not install a browser extension, persistent daemon, hosted browser, or custom Chrome profile manager. It relies on your MCP host running `chrome-devtools-mcp` against local Chrome.

That keeps the additional trust surface small, but the tools are still powerful because they can inspect and interact with real authenticated tabs.

## Safe read-only defaults

Prefer read-only actions until the user explicitly requests a change:

- list open tabs
- select a tab by page id
- take text snapshots
- inspect console messages
- inspect network metadata
- take screenshots only when text snapshots are insufficient
- run Lighthouse or performance diagnostics when reload/state impact is acceptable

## Do not do without explicit user instruction

Agents should not perform these actions unless the user clearly requests the specific action:

- submit forms
- click destructive or high-impact buttons
- confirm modals
- publish posts or comments
- send emails or direct messages
- buy items or start paid subscriptions
- delete records or files
- change account settings
- change permissions or sharing settings
- upload files
- download/export sensitive files
- trigger deploys or production workflows
- run admin dashboard operations

## Sensitive data

Do not inspect or reveal cookies, tokens, session storage, local storage, API keys, private page content, or credentials unless the user explicitly asks for that data and it is necessary for the task.

If a page appears to contain sensitive data, report that fact briefly and ask before going deeper.

## Multi-agent safety

When multiple agents may use Chrome:

- use explicit page ids
- re-list pages before acting after delays
- prefer agent-owned new tabs for exploratory work
- never close tabs unless the user asks
- do not assume another agent's selected page is still safe to use

## When not to use Open Chrome Bridge

Use a different approach or require direct user supervision for:

- unattended high-impact workflows
- banking, payment, or production-admin flows
- strict browser-enforced agent isolation
- durable background browser automation
- PDF-first export workflows
- extension-only UI instrumentation or browser overlays
- tasks where manual trusted user input is required
