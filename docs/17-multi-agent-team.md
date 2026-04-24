# Step 17 — From one agent to a team

By the end of this step, you'll have three agents working together: a writer who talks to you, a researcher who does background work, and a fact-checker who reviews finished drafts.

## Read this first

**Don't run this step until your single agent is struggling.** Run one agent until you can name the specific pain it's causing. The pain tells you whether a team is actually the right answer.

Most common pains that signal you're ready:

- Research takes an hour and blocks you from writing during that time.
- Chapter five sounds different from chapter one because the agent's context is polluted.
- One model can't be both careful with facts and creative with prose.

If none of those are happening, keep using one agent. Teams cost more and introduce new ways to break.

## The team

Three roles:

| Agent | Role | Model | Talks to you? |
|---|---|---|---|
| `writer` | Writes chapters, manages the book, delegates. | Opus (smart) | Yes — on Slack. |
| `researcher` | Does background research. Saves findings to files. | Sonnet (fast, cheaper) | No. |
| `factchecker` | Reviews finished drafts. Flags unverified claims. | Sonnet | No. |

You only ever talk to the writer. The writer delegates to the other two.

## How agents talk to each other

Two mechanisms, both configured in the team config:

- **sessions_spawn** (delegation). Writer says to researcher: "Research movable type printing. Save to `book/research/ch03-printing.md`." Researcher runs in the background, saves the file, reports back when done.
- **sessions_send** (conversation). Writer says to fact-checker: "Review chapter 4." Fact-checker replies: "Found three unverified claims." Writer replies: "I'll fix two. The third is actually correct, here's the source."

## SSH to the VPS

```
ssh root@YOUR_TAILSCALE_IP
```

## Create the team workspaces

```
mkdir -p ~/.openclaw/workspace-researcher
mkdir -p ~/.openclaw/workspace-factchecker
```

Each agent gets its own workspace. They don't see each other's SOUL.md files.

## Set up the shared book folder

All three agents need access to the same book files. Move the existing book folder out of the writer's workspace and symlink it into all three:

```
mv ~/.openclaw/workspace/book ~/shared-book

ln -s ~/shared-book ~/.openclaw/workspace/book
ln -s ~/shared-book ~/.openclaw/workspace-researcher/book
ln -s ~/shared-book ~/.openclaw/workspace-factchecker/book
```

Now all three agents can read and write the same files. The writer writes chapters. The researcher writes to `book/research/`. The fact-checker writes to `book/research/` with filenames starting `factcheck-`.

## Copy the team SOUL files into place

From your **Mac terminal** (not inside SSH), run these three commands:

```
scp workspace/SOUL.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace/SOUL.md
scp workspace-researcher/SOUL.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace-researcher/SOUL.md
scp workspace-factchecker/SOUL.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace-factchecker/SOUL.md
```

The writer's SOUL already has a "Your team" section at the bottom — that's what tells it to delegate instead of doing research itself.

## Replace the config file

This is the big edit. The old single-agent config goes away. The new one has three agents and tells OpenClaw which one is bound to Slack.

```
vi ~/.openclaw/openclaw.json
```

Press `i`. Select all and delete (in vi: `gg` then `dG`). Paste the contents of [`configs/openclaw-team.json`](../configs/openclaw-team.json) from this repo — with your real API key and Slack tokens filled in. Press Escape, `:wq`, Enter.

## What the new config says in plain English

- `agents.list` — three agents listed. Writer gets Opus. Researcher and fact-checker get Sonnet.
- `subagents.allowAgents` on the writer — the writer is allowed to delegate to the researcher and fact-checker. They can't delegate to each other. The boss sends errands. Everyone else does the errand.
- `tools.agentToAgent.enabled: true` — the three can have conversations with each other. Off by default for safety; we're turning it on on purpose.
- `bindings` — only the writer is bound to Slack. You talk to the writer. The other two are back-office and invisible to you.

## Restart and verify

```
openclaw gateway restart
openclaw agents list --bindings
```

You should see all three agents listed. The writer is bound to Slack. The other two are unbound — they only run when called.

## Test the team

In Slack, message the writer:

> I need research on the history of movable type printing. Ask the researcher to look into it and save the findings to `book/research/movable-type.md`. Tell me when it's done.

Watch the conversation. The writer should:

1. Acknowledge and delegate.
2. Wait for the researcher to finish (usually 1–3 minutes).
3. Report back.

On the VPS, verify:

```
cat ~/shared-book/research/movable-type.md
```

If the file exists with real findings and sources, the team is working.

## The workflow with a team

1. You message the writer on Slack: "Let's work on chapter 5. I need research on the East India Company's trade routes."
2. Writer delegates to researcher. Researcher works in the background. Writer stays responsive to you.
3. Researcher saves findings to `book/research/`. Reports back.
4. Writer reads the research. You and the writer draft chapter 5 together.
5. Once the draft is done, writer sends it to the fact-checker for review.
6. Fact-checker flags unverified claims, saves report to `book/research/factcheck-chapter-05.md`.
7. Writer reads the report. Tells you what the fact-checker found. You decide what to fix.

All you see is one Slack conversation with the writer. Everything else happens behind the scenes.

## Cost with three agents

Rough monthly math:

- Writer (Opus, daily writing): about $15–20.
- Researcher (Sonnet, on-demand research): about $3–5.
- Fact-checker (Sonnet, per-chapter review): about $1–2.

Total: around $20–27/month. About the same as running a single overloaded writer on Opus, but with cleaner context and better output.

## Confirm it worked

- [ ] `openclaw agents list --bindings` shows three agents, writer bound to Slack.
- [ ] The test delegation produced a real file in `~/shared-book/research/`.
- [ ] Fact-check test: give the writer a short draft, ask it to have the fact-checker review, see a file appear in `~/shared-book/research/` starting with `factcheck-`.

## The gotcha

**The writer tries to do research itself.** Check the "Your team" section at the bottom of the writer's SOUL.md. It must say "Don't do research. Don't fact-check. Write." If that line isn't there, the writer will default to doing the research itself because that's the easier path from its point of view. Add the line, restart, and remind it in Slack: "When you need research, delegate to the researcher. Don't do it yourself."

## When to add each agent

- **Month 1:** writer only. Write the first three chapters. Learn the workflow.
- **Month 2:** add the researcher. When research blocks writing sessions.
- **Month 3:** add the fact-checker. When you have five chapters and want systematic fact-checking.

Don't hire before you feel the pain.

## What's next

If you want your agent reachable from other channels:

[Step 18 — Connect Telegram](18-connect-telegram.md)  
[Step 19 — Connect WhatsApp](19-connect-whatsapp.md)

If you're happy with Slack only, you're done with the setup guide. Go write.
