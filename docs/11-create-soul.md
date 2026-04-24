# Step 11 — Create SOUL.md

By the end of this step, your agent will have a full personality for book writing — opinionated voice, clear rules, and specific things it won't do.

## What you're replacing

In Step 8, you wrote a minimal `soul.md` just to prove the personality file loads. Now you're replacing it with the real one.

## Pick your path

### Path A: use the repo's default SOUL

Copy [`workspace/SOUL.md`](../workspace/SOUL.md) from this repo straight into your VPS. From your **Mac terminal** (not inside SSH):

```
scp workspace/SOUL.md root@YOUR_TAILSCALE_IP:~/.openclaw/workspace/SOUL.md
```

### Path B: paste it in by hand

SSH in:

```
ssh root@YOUR_TAILSCALE_IP
```

Open the file:

```
nano ~/.openclaw/workspace/SOUL.md
```

(Yes, capital letters. OpenClaw reads both but we're using uppercase for the special files to make them stand out in a `ls`.)

Paste the contents of `workspace/SOUL.md` from this repo. Save: **Ctrl + O**, Enter, **Ctrl + X**.

If the old lowercase `soul.md` still exists, delete it so you don't have two conflicting personalities:

```
rm ~/.openclaw/workspace/soul.md
```

## What's in the default SOUL

Read [`workspace/SOUL.md`](../workspace/SOUL.md) before you ship it. The default includes:

- Who the agent is (a collaborator, not a service).
- How chapters work (one file per chapter, read the template and continuity file first).
- Writing rules (short sentences, no em dashes, show don't tell).
- Banned phrases ("I'd be happy to," "great question," etc.).
- Self-verification rules (check your own claims before reporting).
- Cost awareness (don't pad).

**Read every line and change what you disagree with.** This is the file that most shapes the agent's output. If it writes too politely, the fix is here. If it asks too many clarifying questions, the fix is here.

## Common changes you'll want to make

- Replace "the author" with your name.
- If you write in a specific genre, add a line about genre conventions.
- If you have strong stylistic preferences, add a "style" section at the bottom — "always use Oxford comma," "no rhetorical questions," etc.
- If you hate certain words more than the default list, extend the banned phrases list.

## Restart the gateway

```
openclaw gateway restart
```

## Test it

In Slack:

> Read your soul file and tell me three things you refuse to do.

The agent should quote back three rules from the file — specific things like "I won't summarize back what you just said" or "I don't use the word 'delve'."

If the answer is vague or doesn't match your file, the file didn't load. Check the filename (`SOUL.md` exactly, with `.md`) and restart again.

## Confirm it worked

- [ ] `cat ~/.openclaw/workspace/SOUL.md` shows the full book-writing soul.
- [ ] The agent's test reply references specific rules from the file.
- [ ] The agent's tone feels noticeably different from before.

## The gotcha

**The agent ignores the file.** Most common cause: two files with slightly different names in the workspace. `soul.md` and `SOUL.md` may both exist. OpenClaw picks one. Delete the one you don't want:

```
ls ~/.openclaw/workspace/
rm ~/.openclaw/workspace/soul.md
```

Then restart.

## What's next

[Step 12 — Create HEARTBEAT.md](12-create-heartbeat.md)
