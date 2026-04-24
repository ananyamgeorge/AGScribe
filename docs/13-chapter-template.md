# Step 13 — The chapter template

By the end of this step, every chapter the agent writes will follow the same skeleton — a structure that forces real value into every chapter and prevents the agent from drifting into essay-mode.

## Why a template

Without a template, the agent will produce beautiful, shapeless prose. Each chapter will sound great on its own and be useless in aggregate. The template forces:

- A single-sentence promise at the start.
- A minimum of theory.
- Concrete steps the reader can follow.
- A gotcha section.
- A test the reader can run to prove it worked.
- A clear "what's next."

Every chapter is a recipe. The reader opens the book hungry and closes it having eaten.

## Copy the default template

From your Mac:

```
scp workspace/book/template.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace/book/template.md
```

Or paste by hand:

```
ssh root@YOUR_TAILSCALE_IP
nano ~/.openclaw/workspace/book/template.md
```

Paste the contents of [`workspace/book/template.md`](../workspace/book/template.md). Save.

## What's in the default template

### Structure sections

1. **The promise** — one paragraph, what the reader will have at the end.
2. **The minimum necessary context** — only the theory needed for this chapter.
3. **The steps** — numbered, small, with expected output.
4. **The gotcha** — the one thing most readers will get stuck on.
5. **Confirm it worked** — a test the reader can run.
6. **What's next** — one sentence on what's now possible.

### Pre-ship checklists

- Outcome checks (the reader would actually have the thing working).
- Usefulness checks (you can name a real reader who needed this).
- Reader-test checks (a beta reader has done it start to finish).

### A beta reader log for every chapter

A table at the bottom where you log what happened when real people tried to follow the chapter. Where they got stuck. What you changed.

### Style rules and banned phrases

Short sentences. Real specifics. No padding. And a banned-phrase list the agent reads before writing.

## Customize the template

The default is opinionated and suits instructional nonfiction. If you're writing fiction, memoir, or something else, you'll want to rewrite it. Changes you might make:

- For memoir: replace "steps" with "scene" and "what the reader can now do" with "what the reader now understands about me."
- For fiction: replace the whole structure with a scene-and-sequel framework.
- For research-heavy nonfiction: add a "citations" section and require every claim to be sourced.

## Restart the gateway

```
openclaw gateway restart
```

## Test it

In Slack:

> Read the chapter template and tell me three things every chapter in my book must have.

The agent should quote back specifics — "a one-sentence promise at the top," "a gotcha section," "a test the reader can run." If you get vague generalities, the template didn't load. Check the filename and restart.

## Confirm it worked

- [ ] `cat ~/.openclaw/workspace/book/template.md` shows the full template.
- [ ] The agent can name specific sections when asked.
- [ ] The agent references the template when you ask it to write.

## What's next

[Step 14 — The continuity tracker](14-continuity-tracker.md)
