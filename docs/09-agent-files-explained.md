# Step 9 — The files that make an agent

You have a running agent. Before you start writing, you need to understand what the agent reads, when, and why. This step is short and has no commands — just the mental model you need before the next four steps.

## The workspace

Everything the agent reads and writes lives in one folder: `~/.openclaw/workspace/`.

Think of it as the agent's desk. Everything on the desk is fair game. Everything outside the desk is invisible.

Inside the workspace, OpenClaw reads a handful of special files at the start of every conversation. Four of them matter right now:

## SOUL.md

**Who the agent is.** Personality, voice, what it refuses to do.

You edit this file rarely. When you do, the agent's behavior changes overnight. Treat it like the character sheet for a role-playing game. If your agent is drifting — being too polite, writing too long, saying "great idea" when you hate that — the fix is usually in `SOUL.md`.

## HEARTBEAT.md

**What the agent does on a schedule, without being asked.**

This is the difference between a reactive assistant (answers when you ask) and a proactive employee (does things on its own). `HEARTBEAT.md` is where you tell it:

- "Every morning at 8am, send me a status of the book."
- "Every Sunday, review all the chapters and flag inconsistencies."

You write the schedule in plain English. The agent interprets and runs it.

## MEMORY.md

**What the agent has learned over time.**

The agent writes to this file. It's where it stores:

- Preferences you've expressed during sessions.
- Decisions you've made that it should remember.
- Patterns it's noticed.

You can also edit this file directly to plant memories. "The protagonist's name is Anna, not Anya" — write that into `MEMORY.md` and the agent stops getting it wrong.

This file grows. After a few weeks, the agent gets noticeably better because it remembers what you liked last time.

## TOOLS.md (optional)

**What tools the agent can use.** Web search, file creation, shell commands.

For now, the defaults are fine. You won't need to edit this file for a long time. Mentioning it only so you know it exists.

## Beyond those four: the book folder

Inside `~/.openclaw/workspace/book/`, you'll have:

- `plan.md` — the book plan. **You write this.** The agent reads it.
- `template.md` — the chapter template. What every chapter's skeleton looks like.
- `continuity.md` — metaphors used, anecdotes deployed, forward references. The agent updates this after every chapter.
- `chapters/` — one file per chapter.
- `research/` — research findings (from the researcher agent in Part III, or from the writer if you stay solo).
- `drafts/` — rough drafts and working notes.

## The big design decision: one file per chapter

This matters more than it sounds. **Never** put your whole book in one file.

If the whole book is one file, the agent loads everything every time it works on anything. By chapter five, its working memory is polluted: metaphors bleed across chapters, tone drifts, research from chapter two gets confused with an argument in chapter seven.

One file per chapter means the agent loads only what it needs. Clean memory. Better writing.

## What the agent reads when you ask it to write

In a typical writing session, when you say "let's work on chapter 3," the agent will:

1. Read `SOUL.md` — for personality.
2. Read `MEMORY.md` — for what you've told it before.
3. Read `book/plan.md` — for what chapter 3 is supposed to be about.
4. Read `book/template.md` — for structure.
5. Read `book/continuity.md` — to avoid reusing metaphors.
6. Read `book/chapters/03-*.md` — the actual chapter.

It does **not** read chapters 1, 2, or 4. This is the whole point.

## What's next

Now we build the folder structure properly and create each of these files.

[Step 10 — Build the workspace](10-build-the-workspace.md)
