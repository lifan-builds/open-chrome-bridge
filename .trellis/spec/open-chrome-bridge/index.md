# Open Chrome Bridge Project Specification

This package records stable safety and coordination invariants for maintaining and using Open Chrome Bridge. Operational procedures remain authoritative in the root [`SKILL.md`](../../../SKILL.md) and the tracked [`references/`](../../../references/) documents.

## Pre-Development Checklist

1. Treat browser inspection as read-only by default. Obtain explicit instruction and confirmation before any action that changes page, browser, account, or external state ([`references/privacy-and-safety.md`](../../../references/privacy-and-safety.md), lines 11-39; [`SKILL.md`](../../../SKILL.md), lines 80-90).
2. Never expose cookies, tokens, browser storage, credentials, or private page content in output, logs, examples, fixtures, or tracked files ([`references/privacy-and-safety.md`](../../../references/privacy-and-safety.md), lines 41-45; [`SKILL.md`](../../../SKILL.md), lines 126-132).
3. Before interacting with a page, list the available pages, report and select an explicit page ID, and take a fresh snapshot. Re-list and re-select after navigation, tab changes, handoff, or enough delay that the prior ID may be stale ([`SKILL.md`](../../../SKILL.md), lines 60-68; [`references/workflows.md`](../../../references/workflows.md), lines 19-32 and 49-61).
4. Record tabs created by an agent. Mutate only tabs that the agent owns or that were explicitly assigned to it; handoff must identify the page ID and require a fresh selection and snapshot ([`SKILL.md`](../../../SKILL.md), lines 70-78 and 92-100; [`references/workflows.md`](../../../references/workflows.md), lines 34-61).
5. Keep each agent's tab set explicit, and never close a tab without instruction ([`SKILL.md`](../../../SKILL.md), lines 92-100; [`examples/prompt-recipes.md`](../../../examples/prompt-recipes.md), lines 41-50).
6. Treat tab ownership as a coordination convention, not browser-enforced isolation. Agents sharing one browser can still affect each other's tabs, focus, and state ([`README.md`](../../../README.md), lines 77-84).

## Source and Packaging Boundaries

- Keep the Claude-facing operational skill at root `SKILL.md`; `scripts/install-skill.sh` installs that exact path.
- Keep `.claude-plugin/plugin.json`, examples, and detailed reference procedures in their existing roles. Do not duplicate project rules into Trellis-bundled skills.
- Keep browser profiles, sessions, cookies, tokens, credentials, authentication state, and other runtime state outside the repository.

## Quality Check

Before completing a change:

- confirm read-only defaults, confirmation gates, fresh page-ID selection, tab ownership/handoff, and no-unrequested-close rules remain consistent across affected documentation;
- review every changed and untracked file for cookies, tokens, credentials, private content, browser/session/auth state, and runtime output;
- verify root `SKILL.md`, `.claude-plugin/**`, installer behavior, and unrelated examples/references are unchanged unless the task explicitly owns them;
- run Trellis package discovery and `git diff --check` for specification changes;
- use `./scripts/doctor.sh` only when a non-mutating repository diagnostic is required, and do not escalate its output into browser, MCP, page/tab, session, or authentication probing without explicit task authorization.
