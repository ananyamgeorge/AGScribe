# Step 2 — Walk into the office (SSH)

By the end of this step you'll be able to log into your VPS from your laptop with one command, and you'll have learned the few keyboard shortcuts that will save you an hour per week for the rest of your life.

## What SSH is

SSH stands for Secure Shell. It's a tunnel from your Mac to the rented computer. When you "SSH in," you open a live window into the rented computer — anything you type happens there, not on your Mac.

It's like calling into your office from home. You're still at home, but the phone is picking up at the office desk.

## Log in for the first time

Open Terminal on your Mac. Type this, **replacing the IP with your actual droplet's IP from the previous step**:

```
ssh root@YOUR_VPS_IP
```

For example:

```
ssh root@168.144.67.170
```

Press Enter. It will ask:

```
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Type `yes` and press Enter. This only happens the first time.

If your SSH key is set up correctly, you're in immediately. No password prompt. You'll see something like:

```
root@scribe-vps:~#
```

The prompt has changed. Before, it said something like `ananya@Ananyas-MacBook-Air`. Now it says `root@your-hostname`. That's how you know you're inside the rented computer, not your Mac.

**Everything you type from here on happens on the rented computer.** Not your Mac. Don't mix them up.

## Practice leaving and coming back

Type `exit` and press Enter. You're back on your Mac.

Press the Up arrow. The previous command (`ssh root@...`) pops up. Press Enter. You're back in.

Do this three or four times. Get comfortable with entering and leaving the office. You'll do it hundreds of times.

## Terminal shortcuts worth learning now

You will use these every day. Spend five minutes memorizing them:

- **Up arrow** — previous command. Keep pressing for older ones.
- **Ctrl + U** — erase the current line.
- **Ctrl + C** — cancel whatever is running. The emergency stop button.
- **Ctrl + L** — clear the screen.
- **Tab** — auto-complete. Type a few letters of a filename, press Tab, it completes.
- **exit** — leave the server, return to your Mac.

## The two text editors you'll encounter

### Nano — the simple one

When a step says to edit a file, you'll usually open it with `nano`:

```
nano somefile.txt
```

Inside nano:
- Arrow keys move the cursor.
- Just type to insert.
- **Ctrl + O** then Enter — save.
- **Ctrl + X** — exit.

Nano tells you these shortcuts at the bottom of the screen. It's friendly.

### Vi — the powerful, ugly one

Some steps need Vi. It's older, meaner, and once you're used to it, faster. Survival commands:

- `i` — start typing (enter "insert mode").
- **Escape** — stop typing (leave insert mode).
- `:wq` then Enter — save and quit.
- `:q!` then Enter — quit without saving.
- `x` — delete one character.
- `u` — undo.

If you open Vi by accident and panic, press Escape, then type `:q!` and Enter. That gets you out.

## Confirm it worked

- [ ] You can run `ssh root@YOUR_VPS_IP` and land inside the VPS.
- [ ] Your Terminal prompt changes to `root@hostname:~#` after logging in.
- [ ] You can `exit` and come back.

## The gotcha

**"Permission denied (publickey)."** This means your SSH key isn't set up right. Usually one of:

1. You typed the IP wrong.
2. You pasted a different public key into DigitalOcean than the one on your Mac.
3. Your key was generated as `id_rsa` but you told SSH to look for `id_ed25519` or vice versa.

Fix by re-copying `cat ~/.ssh/id_ed25519.pub` and replacing the SSH key in the DigitalOcean dashboard. Then destroy and recreate the droplet (SSH keys are locked in when the droplet is made).

## What's next

You're inside. The office is empty. Time to furnish it.

[Step 3 — Install the software](03-install-software.md)
