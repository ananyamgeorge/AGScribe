# Step 10 — Build the workspace

By the end of this step, your VPS will have all the folders the agent needs, ready for the content files that come in the next five steps.

## The folders you're creating

```
~/.openclaw/workspace/
├── SOUL.md                 (Step 11)
├── HEARTBEAT.md            (Step 12)
└── book/
    ├── chapters/           (where chapters will live — empty for now)
    ├── research/           (where research notes will live — empty for now)
    ├── drafts/             (where rough drafts will live — empty for now)
    ├── template.md         (Step 13)
    ├── continuity.md       (Step 14)
    └── plan.md             (Step 15)
```

## SSH to the VPS

Using your Tailscale IP (not the old public IP):

```
ssh root@YOUR_TAILSCALE_IP
```

## Create all the folders at once

```
mkdir -p ~/.openclaw/workspace/book/chapters
mkdir -p ~/.openclaw/workspace/book/research
mkdir -p ~/.openclaw/workspace/book/drafts
```

`mkdir -p` means "make the folder, and any missing parent folders, and don't complain if it already exists." It's safe to run multiple times.

## Verify

```
ls ~/.openclaw/workspace/book/
```

Should print:

```
chapters  drafts  research
```

If you see an error or nothing shows up, check you didn't typo the path.

## What's not here yet

- `SOUL.md` — next step.
- `HEARTBEAT.md` — step after that.
- `template.md`, `continuity.md`, `plan.md` — the three steps after that.

You're building these up one at a time so you can test each piece. If you'd rather, you can skip ahead and copy the whole `workspace/` folder from this repo in one go — see the "shortcut" section at the bottom of this page. But I recommend doing each step individually the first time. You'll understand what each file does.

## Shortcut: copy the whole workspace from this repo

If you already know you want the whole book-writing template and don't want to go step by step, and your laptop has the repo cloned, you can copy the prepared files up to the VPS in one command. From your **Mac terminal** (not SSH'd into the VPS):

```
scp -r workspace/ root@YOUR_TAILSCALE_IP:~/.openclaw/
```

(Run this from the root of the repo.)

Then SSH into the VPS and open `book/plan.md` to replace the example bread-baking plan with your own.

## Confirm it worked

- [ ] `~/.openclaw/workspace/book/chapters` exists.
- [ ] `~/.openclaw/workspace/book/research` exists.
- [ ] `~/.openclaw/workspace/book/drafts` exists.

## What's next

[Step 11 — Create SOUL.md](11-create-soul.md)
