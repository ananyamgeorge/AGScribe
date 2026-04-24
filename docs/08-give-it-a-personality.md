# Step 8 — Give it a personality

By the end of this step, your agent will know who it is, how you want it to write, and what it is not allowed to do. A starter personality that you'll refine over time.

## What you're doing

Until now, your agent is generic. It will reply like an assistant from a support center. That's not what you hired it for.

You're going to write a short markdown file called `SOUL.md`. The agent reads this at the start of every conversation. It is the personality file. Edit it rarely. When you do, the agent's personality changes overnight.

This step creates a minimal `SOUL.md` just to test that personality loading works. In Step 11, you'll replace it with the full book-writing personality from this repo.

## Create the workspace folder

SSH into the VPS:

```
ssh root@YOUR_TAILSCALE_IP
```

Create the workspace folder (where the agent keeps all its files):

```
mkdir -p ~/.openclaw/workspace
```

## Write a minimal SOUL.md

Open the file:

```
nano ~/.openclaw/workspace/soul.md
```

Paste this minimal version to test the loading works:

```markdown
# Identity

You are the writer agent. You help the author work on their book.

# How we work

The author sends ideas, chapter drafts, and research. You help them
think, organize, write, and edit.

# Writing style

Short declarative sentences.
Prose, not bullet points.
Don't end things neatly.

# What not to do

Don't summarize back what I just said.
Don't ask me what I want to do next unless I'm stuck.
Don't write more than 500 words unless I ask for more.
Don't say "great idea" or "let me help you with that."

# Verify yourself

Before you tell me you did something, check that you actually did
it. If you claim you saved a file, list the workspace to confirm.
```

Save: **Ctrl + O**, Enter, **Ctrl + X**.

## Create the book folder structure

```
mkdir -p ~/.openclaw/workspace/book/chapters
mkdir -p ~/.openclaw/workspace/book/characters
mkdir -p ~/.openclaw/workspace/book/research
```

These are where the agent will keep chapter drafts, character notes, and research. Empty for now.

## Restart the gateway

The agent needs to reload its workspace to pick up the new files:

```
openclaw gateway restart
```

## Say hello

Open Slack. Message your bot:

> Read your soul file and tell me who you are.

The bot should respond with its identity — something like "I'm your writer agent. I help you work on your book." If it does, the personality file is loading.

If the bot still answers like a generic assistant, the workspace path in the config is probably wrong. Check:

```
cat ~/.openclaw/openclaw.json
```

The default workspace should resolve to `~/.openclaw/workspace`. If you have a custom path set, make sure it matches where you just created files.

## Confirm it worked

- [ ] `~/.openclaw/workspace/soul.md` exists and contains your text.
- [ ] The book folders (`chapters/`, `characters/`, `research/`) exist.
- [ ] The bot answers to the personality in `soul.md`, not as a generic assistant.

## The gotcha

**The agent partly responds in the new personality and partly in the old.** This usually means you edited `soul.md` but didn't restart the gateway, or you have two workspaces and the agent is reading the wrong one. Run `openclaw gateway restart` and try again.

## What's next

You've got a minimal personality. Now you're going to learn the full file system the agent uses — and then replace this starter soul with the real book-writing personality.

[Step 9 — The files that make an agent](09-agent-files-explained.md)
