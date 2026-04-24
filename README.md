# AG Scribe — a book-writing agent you run yourself

A step-by-step guide and template project for building your own OpenClaw-based book-writing agent. The agent lives on a VPS you rent, talks to you on Slack, and helps you write a book one chapter at a time.

This is written for **people who have never opened a terminal before**. Every step assumes no prior knowledge. If a sentence starts sounding technical, it's followed by a plain-English translation.

## What you'll have at the end

- A rented computer in a data center that runs 24/7.
- An AI agent on that computer that answers your Slack messages.
- A private network that makes your VPS invisible to the public internet.
- A writer agent with a personality, a daily schedule, a chapter template, and a continuity tracker.
- A workflow for writing one book chapter at a time without losing your mind.

Optional later: add a researcher agent and a fact-checker agent, or connect Telegram and WhatsApp alongside Slack.

## What it costs

Roughly **$60–80 per month** total. See `docs/costs.md` for a full breakdown. You set a hard spending cap on the API, so you can't get a surprise bill.

## How long it takes

Two to five hours for the single-agent setup. Budget half a day. Things will break along the way. That's normal. Screenshot what you see, paste into Claude, ask, keep going.

## The mental model

Think of it as hiring a remote employee who lives in an office you rent.

- **The office** — a VPS. A rented computer in a data center. You pay monthly. Like Airbnb for computers.
- **The receptionist** — the OpenClaw gateway. Sits at the front desk. When a Slack message arrives, it walks the message to the right employee.
- **The employee** — the agent. It reads messages, thinks about them (by calling Claude, the brain it rents from Anthropic), and writes back. It also keeps files in a workspace folder (the filing cabinet).
- **The employee's personality** — a single markdown file called `SOUL.md`. Edit this to change how your agent behaves.
- **The employee's daily habits** — `HEARTBEAT.md`. A schedule of things the agent does without being asked.

The whole pattern: **teach it a skill, then put that skill to work on a schedule.**

## Before you start

Read `docs/00-prerequisites.md`. Collect the things on that page. Then start at Step 1.

## The step-by-step guide

### Part I — build the agent

1. [Rent the VPS](docs/01-rent-the-vps.md)
2. [SSH into the VPS](docs/02-ssh-into-vps.md)
3. [Install the software](docs/03-install-software.md)
4. [Connect the Claude API](docs/04-connect-claude-api.md)
5. [Connect Slack](docs/05-connect-slack.md)
6. [Lock it down with Tailscale](docs/06-lock-with-tailscale.md)
7. [Security hardening](docs/07-security-hardening.md)
8. [Give it a personality](docs/08-give-it-a-personality.md)

### Part II — make it write a book

9. [The files that make an agent](docs/09-agent-files-explained.md)
10. [Build the workspace](docs/10-build-the-workspace.md)
11. [Create SOUL.md](docs/11-create-soul.md)
12. [Create HEARTBEAT.md](docs/12-create-heartbeat.md)
13. [The chapter template](docs/13-chapter-template.md)
14. [The continuity tracker](docs/14-continuity-tracker.md)
15. [Write the book plan](docs/15-write-the-book-plan.md)
16. [Restart and test](docs/16-restart-and-test.md)

### Part III — grow (optional)

17. [Add a researcher and fact-checker](docs/17-multi-agent-team.md)
18. [Connect Telegram](docs/18-connect-telegram.md)
19. [Connect WhatsApp](docs/19-connect-whatsapp.md)

### Reference

- [Troubleshooting](docs/troubleshooting.md)
- [Costs](docs/costs.md)
- [The five security layers](docs/security-layers.md)

## What's in this repo

```
.
├── README.md                       # you are here
├── LICENSE                         # MIT
├── .gitignore
├── docs/                           # the step-by-step guide
├── configs/                        # ready-to-edit config templates
│   ├── openclaw-single.json
│   ├── openclaw-team.json
│   └── README.md
├── workspace/                      # the writer agent's files
│   ├── SOUL.md
│   ├── HEARTBEAT.md
│   └── book/
│       ├── template.md
│       ├── continuity.md
│       └── plan.md                 # a worked example — replace with yours
├── workspace-researcher/           # for the team setup
│   └── SOUL.md
├── workspace-factchecker/          # for the team setup
│   └── SOUL.md
└── scripts/                        # optional convenience wrappers
    ├── install-node.sh
    ├── install-openclaw.sh
    ├── setup-workspace.sh
    ├── setup-tailscale.sh
    ├── firewall-lockdown.sh
    └── README.md
```

## Things to know before you start

**This guide uses manual config throughout.** OpenClaw has a setup wizard (`openclaw onboard`) but it has had reliability issues. Every config change in this guide is done by hand. It's not harder and you'll understand what's happening.

**The agent and book are customizable, not locked in.** The agent IDs (`writer`, `researcher`, `factchecker`), the example book topic (bread baking), and every SOUL.md rule are starting points. Change them to fit your own project once you have the basic setup running.

**The Telegram and WhatsApp sections are extrapolated.** Meta and Telegram's APIs are well known, but the exact OpenClaw config shape for those channels wasn't verified while this guide was written. Check the current OpenClaw docs before relying on those sections in production. See the banner at the top of each of those files.

**The universal recovery move.** When something breaks that the docs don't answer: screenshot the error, paste it into Claude at claude.ai, ask what it means and how to fix it. This is the single most valuable habit in this whole guide.

## How to use this repo as a starting point

1. **Fork or clone it.** `git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git`.
2. **Don't fill in the configs locally unless you're ready.** The real `openclaw.json` contains secret keys. Keep your filled-in copies out of git.
3. **Follow `docs/00-prerequisites.md` and walk through the numbered steps.**
4. **When you change the example book plan to your own book, keep the change private** — it's your book, not a template.
5. **If you fix something in the docs or find a gotcha, open a PR.** The next person will thank you.

## Contributing

Pull requests welcome. Particularly helpful:

- Gotchas you hit that aren't in the docs.
- OpenClaw version-specific quirks (the guide will drift as OpenClaw changes).
- Cleaner wording for anything a non-technical reader got stuck on.
- Verified config shapes for Telegram and WhatsApp (please link to the real docs).

## License

MIT. See `LICENSE`.

## Acknowledgments

This guide started as a hand-written walk-through for a friend learning this from zero. It's published in that voice on purpose. If a section sounds warm instead of formal, that's why.
