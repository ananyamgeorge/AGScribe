# Costs

Rough monthly math for this setup.

## Single agent on Opus

| Line item | Monthly |
|---|---|
| DigitalOcean 8GB VPS | $48 |
| DigitalOcean snapshot backups | $1.50 |
| Anthropic API (Opus, daily writing) | $10–25 |
| Tailscale (personal use) | $0 |
| Slack (free tier) | $0 |
| **Total** | **~$60–75** |

## Single agent on Sonnet (once you've outgrown Opus defaults)

| Line item | Monthly |
|---|---|
| DigitalOcean 8GB VPS | $48 |
| DigitalOcean snapshot backups | $1.50 |
| Anthropic API (Sonnet, daily writing) | $5–12 |
| Tailscale | $0 |
| Slack | $0 |
| **Total** | **~$55–62** |

## Three-agent team

| Line item | Monthly |
|---|---|
| DigitalOcean 8GB VPS | $48 |
| DigitalOcean snapshots | $1.50 |
| Writer on Opus (daily use) | $15–20 |
| Researcher on Sonnet (on demand) | $3–5 |
| Fact-checker on Sonnet (per chapter) | $1–2 |
| Tailscale | $0 |
| Slack | $0 |
| **Total** | **~$70–77** |

## The spending cap (important)

Set one in Step 4 at Anthropic console → Settings → Limits. $30/month is a reasonable starting cap for a single agent. If the agent goes haywire and loops on a failing task, the bill stops at $30 instead of at the surprise-email threshold.

You can raise the cap later once you know what your normal usage looks like.

## Things that cause big bills

- **Infinite retry loops.** A task fails, the agent retries, it fails again, the agent retries harder. Your SOUL.md should tell the agent to stop after two failures. Check.
- **Loading the whole book every session.** One file per chapter is not an aesthetic choice — it's a cost control. If you stuff everything into one file, you pay to re-read that file every time.
- **Long conversations without restart.** The context keeps growing with every message. Start a new session now and then.
- **Opus on tasks that Sonnet would handle fine.** Every morning brief doesn't need Opus. Research doesn't need Opus. Save Opus for the actual writing.

## Ways to cut the VPS bill

If $48/month feels like too much:

- **Contabo** or **Hetzner** — similar specs for about half the price. The UI is uglier but the computer works the same. Every command in this guide still runs.
- **Smaller droplet** — you can try the $24/month 4GB droplet. Things work, but Opus responses may be slow when the VPS is under load. 8GB is the sweet spot.
- **Don't pay for snapshots** — $1.50 is not nothing over a year. You can skip snapshots if you're confident you won't need to recover. I recommend against this: you will need to recover, eventually.

## Ways to cut the API bill

- Switch daily model to Sonnet. Keep Opus for hard writing only: `openclaw config set agents.defaults.model.primary anthropic/claude-sonnet-4-6`.
- Shorten your SOUL.md. Every word in it is re-read on every conversation.
- Shorten your plan.md. Same reason.
- Trim `continuity.md` periodically. Move finished things into a `done.md` the agent doesn't read.
- Use the team setup. Offload research and fact-checking to Sonnet; only pay Opus for writing.

## What I'd actually do

Start with a single Opus agent. Write three chapters that way. Watch what the $30/month cap spends. Once you see your real numbers, decide:

- If you're at $5/month — great, keep going.
- If you're at $25/month — switch daily tasks to Sonnet.
- If you keep hitting $30 — investigate the loops before raising the cap.

The goal is to notice costs early and adjust, not to optimize before you have data.
