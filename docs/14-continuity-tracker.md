# Step 14 — The continuity tracker

By the end of this step, your agent will track every metaphor, anecdote, and forward reference it uses across the whole book, so you never accidentally reuse a story or fail to pay off a setup.

## What a continuity tracker does

Writing a book chapter by chapter means losing track of what you've already used. By chapter seven, you may have used the same "like a cup of tea" metaphor three times without noticing. You may have promised in chapter two that "we'll come back to this" and never come back. A reader will notice. A good agent will too, but only if it has somewhere to look.

`continuity.md` is that somewhere.

## Copy the starter file

From your Mac:

```
scp workspace/book/continuity.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace/book/continuity.md
```

The file starts empty. The agent will fill it in as you write.

## What's in it

Sections for:

- **Metaphors used** — one line per metaphor, with the chapter it appeared in. Never reuse.
- **Anecdotes deployed** — same rule for stories.
- **Forward references** — "Chapter X said we'll return to Y. Needs to be addressed by Chapter Z."
- **Callbacks paid off** — forward references that have been closed.
- **Character/concept appearances** — who shows up where.
- **Tone notes** — drift, inconsistencies, voice issues.
- **Author's preferences expressed during sessions** — things you said you liked or didn't.

## Teach the agent to use it

In Slack:

> After every chapter you write or edit, update `book/continuity.md` with any new metaphors, anecdotes, forward references, and callbacks. Never reuse a metaphor already listed. Before starting any chapter, read the continuity file first.

The agent should confirm. From now on, every chapter session starts with a read of the continuity file, and ends with an update to it.

## Plant seeds manually

You can edit `continuity.md` directly whenever you want. Some things worth planting:

- Character names you want to stay consistent.
- Metaphors you already know you want to use in a specific chapter.
- A note saying "never use the word 'journey' — I hate it."

The agent reads the whole file every time it starts a chapter session. Anything you put in there becomes a constraint on its writing.

## Confirm it worked

- [ ] `cat ~/.openclaw/workspace/book/continuity.md` shows the empty skeleton.
- [ ] The agent acknowledged the workflow: read first, update after.

## What's next

Now you write the book plan. This is the one file the agent doesn't author — it's yours, and the agent reads it to know what comes next.

[Step 15 — Write the book plan](15-write-the-book-plan.md)
