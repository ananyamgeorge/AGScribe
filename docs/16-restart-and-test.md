# Step 16 — Restart and test

By the end of this step, you'll have proven that every file you built works together, and you'll have a clear workflow for writing a chapter with the agent.

## Restart

```
ssh root@YOUR_TAILSCALE_IP
openclaw gateway restart
```

Wait ten seconds. Check status:

```
openclaw status
```

Gateway should be up. Bot should show connected to Slack.

## The integration test

In Slack, send this verbatim:

> Read your soul file, your heartbeat, the book plan, and the chapter template. Then tell me what you understand about your job. Be specific. Quote from each file.

The agent should come back with four things:

1. Who it is (from `SOUL.md`).
2. What it does on a schedule (from `HEARTBEAT.md`).
3. What the book is (from `plan.md`).
4. What every chapter must have (from `template.md`).

If any of those four are vague or wrong, that file didn't load. Check filenames and case, then restart again.

## The first writing session

Start small. Don't ask for the whole chapter yet. Ask for an outline.

> Read the plan and the template. Propose an outline for chapter 1. Follow the template's structure exactly. No prose yet. Just the skeleton.

The agent should produce:

- A one-sentence promise
- A short "minimum necessary context" plan
- A numbered list of steps
- A proposed gotcha
- A confirm-it-worked test
- A what's-next line

Push back if any section is vague. "The steps are too general. Get specific. What's step 1, literally?"

Once the outline is solid, ask for the chapter:

> Good. Write chapter 1 based on that outline. Save it to `book/chapters/01-your-title.md`. Then update `book/continuity.md` with any metaphors or anecdotes you used.

Verify the save:

```
ls ~/.openclaw/workspace/book/chapters/
cat ~/.openclaw/workspace/book/chapters/01-your-title.md | head -30
```

## The rhythm, once you've got it

**Every session:** start with "What does the morning brief say?" Pick up wherever the brief points.

**Every week:** read the Sunday review. Fix what the agent flagged.

**Every chapter:**

1. Outline.
2. Push back on the outline.
3. Write the draft.
4. Sleep on it.
5. Revise.
6. Read it aloud.
7. Update `continuity.md`.

**Every month:** look at `MEMORY.md`. Add things you've been repeating. Delete things that turned out wrong.

## Confirm it worked

- [ ] The agent correctly describes all four files when asked.
- [ ] You've done a test outline for chapter 1.
- [ ] You've saved at least one file to `book/chapters/`.
- [ ] `continuity.md` has at least one entry in it.

## The gotcha

**The agent produces a chapter that's technically "correct" but feels dead.** This happens. The fix is always in `SOUL.md`. Add specific banned phrases, specific voice cues, specific examples of sentences you want. The agent will match whatever you give it. Vague instructions get vague prose.

## What's next

You have a single writer agent that works. For most books, that's all you need. Come back here a few months from now.

When the single agent starts getting in its own way — research blocks writing, context gets polluted, one model can't be both creative and rigorous — that's when you expand:

[Step 17 — Multi-agent team](17-multi-agent-team.md)

Or, if you want your agent reachable from other channels:

[Step 18 — Connect Telegram](18-connect-telegram.md)  
[Step 19 — Connect WhatsApp](19-connect-whatsapp.md)

If nothing's broken, don't add more pieces. Single agent, one channel, writing every day — that's the win.
