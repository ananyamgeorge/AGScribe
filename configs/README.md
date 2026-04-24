# Config templates

Two starting-point configs for your OpenClaw install. Copy whichever one fits, paste into `~/.openclaw/openclaw.json` on your VPS, then replace the placeholders with your real values.

## `openclaw-single.json`

One agent, connected to Slack. Start here. This is what you use in Steps 1–8 of the guide. It's enough to get a book-writing agent running.

## `openclaw-team.json`

Three agents — a writer, a researcher, and a fact-checker. Use this only after you've run the single-agent setup for a few weeks and actually feel the need for more hands. Covered in `docs/17-multi-agent-team.md`.

## Placeholders you must replace

| Placeholder | Where to get it |
|---|---|
| `sk-ant-YOUR-ACTUAL-KEY-HERE` | console.anthropic.com → API Keys → Create Key |
| `xoxb-YOUR-BOT-TOKEN` | Slack app → OAuth & Permissions → Bot User OAuth Token |
| `xapp-YOUR-APP-TOKEN` | Slack app → Basic Information → App-Level Tokens |
| `YOUR_SLACK_USER_ID` | Slack → your profile → More → Copy member ID (looks like `U01ABC23DEF`) |
| `YOUR_CHANNEL_ID` | Slack channel → right-click → View channel details → scroll down |

## Don't commit your filled-in config

The real config contains secret keys. Never paste it into a public repo or screenshot. If you ever suspect a key leaked, rotate it immediately — Anthropic console has a "Revoke" button, Slack has "Regenerate" under each token.

## Agent IDs are placeholders

`writer`, `researcher`, `factchecker` are the default names in this template. Rename them if you want. If you do, update every file that references them: `bindings`, `allowAgents`, `allow`, and the workspace folder paths.
