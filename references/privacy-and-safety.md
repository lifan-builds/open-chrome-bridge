# Privacy and safety

Open Chrome Bridge targets your real, already-open Chrome session. That means pages may contain authenticated accounts, private dashboards, customer data, payment flows, or internal tools.

## Default rules for agents

- Treat every open tab as potentially sensitive.
- Prefer text snapshots over screenshots when possible.
- Ask before interacting with private or high-impact pages.
- Summarize only the data needed for the user's request.

## Do not do without explicit user instruction

Agents should not perform these actions unless the user clearly requests the specific action:

- submit forms
- publish posts or comments
- send emails or direct messages
- buy items or start paid subscriptions
- delete records or files
- change account settings
- change permissions or sharing settings
- trigger deploys or production workflows

## Sensitive data

Do not inspect or reveal cookies, tokens, session storage, local storage, API keys, private page content, or credentials unless the user explicitly asks for that data and it is necessary for the task.

If a page appears to contain sensitive data, report that fact briefly and ask before going deeper.
