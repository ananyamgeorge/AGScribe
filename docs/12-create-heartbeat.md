# Step 12 — Create HEARTBEAT.md

By the end of this step, your agent will have a daily morning brief, a Sunday weekly review, and a routine of saving things to memory after every session.

## What heartbeats are for

A reactive agent only answers when you talk to it. That's fine for a chat tool. It's not enough for a writing partner.

A proactive agent has habits. It checks on things without being asked. It reminds you. It notices drift.

`HEARTBEAT.md` is where you teach it those habits.

## Copy the default heartbeat

From your Mac:

```
scp workspace/HEARTBEAT.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace/HEARTBEAT.md
```

Or paste by hand via `nano` like in the previous step.

## What the default heartbeat does

Read [`workspace/HEARTBEAT.md`](../workspace/HEARTBEAT.md). The default includes:

### Morning brief (every day, 08:00 local)

The agent reads your plan and your chapters folder. It counts words. It compares what exists against the plan. It sends you a short Slack message:

- Chapters completed with word counts
- Next chapter to write
- Continuity notes
- Total word count

Like a project manager's standup, one per day, under 200 words.

### Weekly review (every Sunday, 10:00 local)

The agent reads every chapter and the continuity tracker. It looks for:

- Metaphors used more than once
- Tone inconsistencies
- Forward references that never got paid off
- Chapters that are way longer or shorter than average

Then it flags what it found in a Slack message.

### After-session updates

After a writing session, the agent saves:

- New metaphors and anecdotes to `continuity.md`
- Preferences you expressed during the session to `MEMORY.md`

## Set your timezone

The default says `08:00 local`. You need to tell the agent your actual timezone. In Slack, say:

> My timezone is Asia/Kolkata. Update the heartbeat to use absolute times in my timezone.

Use the timezone name appropriate for where you live — e.g., `America/New_York`, `Europe/London`, `Australia/Sydney`. The agent should edit the heartbeat file and confirm.

## Restart the gateway

```
openclaw gateway restart
```

## Test the morning brief manually

You don't have to wait until 8 AM. In Slack, say:

> Run the morning brief now, as if it's 8 AM today.

The agent should produce a brief. Because you have no chapters yet, it'll mostly say "no chapters written yet, next to write is Chapter 1." That's fine — it proves the brief works.

## Confirm it worked

- [ ] `cat ~/.openclaw/workspace/HEARTBEAT.md` shows the schedule.
- [ ] The manual morning brief produces a structured message, not prose.
- [ ] The agent knows your timezone.

## The gotcha

**The agent sends the morning brief at the wrong time, or not at all.** OpenClaw's schedule handling depends on the agent being told to act on the heartbeat. If it's not firing:

1. Ask the agent: "What does your heartbeat say? Quote it back." — this forces a re-read.
2. Verify the timezone is set correctly.
3. Some versions of OpenClaw require an explicit cron-like scheduler config outside the workspace file. If the brief never fires on its own, ask the agent to set up the schedule in its own config.

## What's next

[Step 13 — The chapter template](13-chapter-template.md)
