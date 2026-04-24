# Step 15 — Write the book plan

By the end of this step, your agent will know what book you're writing, who it's for, and what each chapter needs to deliver.

## This file is yours

Of all the files in the workspace, this is the only one the agent doesn't write. You do. The agent reads it to know what comes next.

If you let the agent write the plan, you'll end up with its plan, not yours. That's a different book.

## Start from the example in this repo

The repo contains a fully worked example plan for a book called "How to Start Baking Bread at Home" in [`workspace/book/plan.md`](../workspace/book/plan.md). It's there so you can see what a good plan looks like before you write your own.

Read it first. Notice:

- The title is short and says what the book is.
- The premise is a paragraph, not an essay, and tells a skeptical reader why this book and not some other.
- The audience is specified — both who it's for and who it isn't.
- Each chapter has a title that already names the payoff.
- Each chapter has a two-to-four-line description of what the reader gets from that chapter.
- There's a "notes for the writer" section at the bottom that tells the agent about voice, tone, and things not to do.

## Copy the example to the VPS as a starting point

From your Mac:

```
scp workspace/book/plan.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace/book/plan.md
```

## Replace every word of it

SSH in:

```
ssh root@YOUR_TAILSCALE_IP
nano ~/.openclaw/workspace/book/plan.md
```

Now write your own plan. Some things that help:

### Title

Keep it short. Working titles are fine. You'll revise this many times.

### Premise

Write one paragraph, as if you're pitching a friend in a cafe. Use words like "this is for" and "this isn't for." State what you think is true that most people get wrong.

If you can't write a premise, the book isn't ready to be written. Spend a day thinking before you start.

### Audience

Name three specific people you know who would read this book. If you can't name three, you don't know your audience yet. Go find them and ask them.

### Chapters

Write each chapter as:

```
### Ch N — "Short title naming the payoff"

One sentence on the payoff.

Two or three sentences on what's inside.
```

Ten chapters is a normal target for a first nonfiction book. Too few and the book has no backbone. Too many and you'll lose the will to finish. Bread-baking example in the repo is ten. Adjust based on your topic.

### Notes for the writer

At the bottom, tell the agent anything else it should know:

- Voice references: "write like [authors you admire]."
- Tone: "warm, slightly self-deprecating, no jargon."
- Hard rules: "never write a chapter that doesn't produce something the reader can do."
- Things to avoid: "no pep talks, no fake urgency, no bullet-pointed lists of 'key takeaways.'"

The agent reads this every session. Anything you put here shapes the writing more than you'd think.

## Ask the agent to react to your plan

Once you've got a first draft, save the file and ask in Slack:

> Read the book plan. Tell me three things that are weak about it. Be specific. Don't be nice.

If the agent says "it's great," push back: "no — tell me what's weak." The whole point is to use the agent as a sparring partner before you commit to writing.

## Confirm it worked

- [ ] `cat ~/.openclaw/workspace/book/plan.md` shows your plan, not the bread-baking example.
- [ ] The agent can name your book, its premise, and at least three chapters in its own words.
- [ ] You've stress-tested the plan with the agent at least once.

## What's next

The workspace is fully set up. Now we restart everything and test that the agent can put it all together.

[Step 16 — Restart and test](16-restart-and-test.md)
