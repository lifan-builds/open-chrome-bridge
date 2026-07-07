# Capability matrix

This matrix compares practical approaches for agentic browser work. It is not a claim that every competitor has every feature; verify specific products before making security or purchasing decisions.

Open Chrome Bridge is strongest when the useful browser state already exists in local Chrome and the user wants an MCP host to inspect it with a low additional trust surface.

| Capability | Open Chrome Bridge | Daemon/extension bridge | Playwright-style automation | Hosted browser service |
| --- | --- | --- | --- | --- |
| Uses already-open local Chrome tabs | Strong | Often strong | Usually separate profile | Usually separate hosted browser |
| Broad existing-tab discovery | Strong | Varies by product/session model | Weak by default | Weak by default |
| Text snapshots for agents | Strong via MCP | Varies | Requires tooling setup | Varies |
| Click/fill/type | Strong when host exposes tools | Strong | Strong | Strong |
| Console/network inspection | Strong | Varies | Strong with setup | Varies |
| Lighthouse/performance tracing | Strong when host exposes tools | Varies | Possible with extra setup | Varies |
| Session/tab grouping | Workflow convention | Often stronger | Scripted contexts | Service-specific |
| Browser-enforced agent tab scope | Not in scope | Often stronger | Strong through isolated contexts | Strong through isolated sessions |
| PDF export | Not currently built in | Often stronger | Strong | Often supported |
| Persistent background daemon | No | Usually yes | Optional | Yes, remote |
| Browser extension required | No | Often yes | No | No local extension |
| Local trust surface | Low: MCP server process, no repo daemon/extension | Higher: daemon and extension | Medium: automation runtime | Depends on provider/API key |
| Best for | Local dev, debugging, authenticated existing tabs | Integrated browser-agent UX | Repeatable automation and tests | Remote browser tasks at scale |

## Choose Open Chrome Bridge when

- You already have the useful page open in Chrome.
- You want to debug a local dev app with console, network, snapshots, screenshots, Lighthouse, or traces.
- You want Claude Code, Codex CLI, or another MCP host to inspect the browser with minimal extra software.
- You prefer no project-specific daemon and no project-specific browser extension.

## Choose another approach when

- You need durable background browser sessions.
- You need built-in PDF export as a primary workflow.
- You need browser-enforced per-agent isolation.
- You need a hosted browser fleet or remote sessions.
- You need repeatable test automation across fresh browser profiles.
- You need extension-level UI overlays or page annotations.

## Non-goals

- No local daemon.
- No browser extension.
- No custom Chrome profile/session manager.
- No background scheduler.
- No built-in PDF export unless upstream MCP exposes it as a stable tool.
- No replacement for Playwright, Puppeteer, browser-use, Stagehand, Browserbase, or hosted browser platforms.
