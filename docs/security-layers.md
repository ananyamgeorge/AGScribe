# The five layers protecting your setup

A mental map of what's protecting you. Useful to keep in mind when you make changes.

```
Layer 1: Tailscale        The office is invisible. No public address.
Layer 2: UFW firewall     The public SSH door is locked. Only Tailscale enters.
Layer 3: SSH key          Even through Tailscale, you must present the right key.
Layer 4: Slack allowlist  Only your Slack user ID can talk to the bot.
Layer 5: Approval gates   The bot asks before deleting files or spending money.
```

Each layer stops a different kind of attack. Each is independent — breaking one doesn't automatically break the next.

## Layer 1 — Tailscale

**What it stops:** port scanners, random bots trying IP addresses, targeted attacks that depend on finding your server in the first place.

**How to check it's working:** try SSH-ing to your old DigitalOcean public IP. If it times out, Layer 1 is live.

**How it breaks:** you sign into Tailscale on your Mac with a different account than the one on your VPS. Now they can't see each other. Fix by logging both into the same account.

## Layer 2 — UFW firewall

**What it stops:** anyone who somehow discovered your public IP anyway. Even if they find the door, the door's locked.

**How to check:** `ufw status` on the VPS should show port 22 as `DENY`.

**How it breaks:** you install some service (a database, a web app) and open ports for it. Each port opened is a new door. Think twice.

## Layer 3 — SSH key

**What it stops:** password-guessing attacks. Nobody can brute-force their way in.

**How to check:** your key is at `~/.ssh/id_ed25519` (or `id_rsa`) on your Mac. The VPS only lets in the matching public key.

**How it breaks:** you accidentally paste your private key somewhere public, or share your Mac with someone who copies it. Treat the private key like a house key.

## Layer 4 — Slack allowlist

**What it stops:** strangers who find the bot's username in a Slack workspace you share and try to DM it.

**How to check:** `cat ~/.openclaw/openclaw.json | grep -A2 allowFrom`. Your Slack user ID should be the only entry (unless you've added collaborators).

**How it breaks:** you change `dmPolicy` from `"allowlist"` to `"open"` thinking it's convenient. Don't.

## Layer 5 — Approval gates

**What it stops:** the agent itself doing something you didn't authorize — deleting files, sending emails, spending money on third-party APIs.

**How to check:** ask the agent: "Without my approval, which of these can you do: delete a file, send a Slack message to someone other than me, call a new API, spend money on a paid service? List each with yes or no."

If it says "yes" to any destructive action, your approval gates are loose. Tighten them (see `docs/07-security-hardening.md`).

**How it breaks:** you give the agent a broad permission to "do whatever's needed" and it interprets that liberally. Err toward narrower approvals.

---

## What the layers don't protect against

- **A compromised Anthropic API key.** If someone gets your API key, they can run up a bill on your account even without access to your VPS. Set a spending cap. Rotate the key periodically.
- **A compromised Slack token.** If someone gets your bot token, they can post to your Slack workspace. Rotate if you suspect leakage.
- **You publishing a screenshot with your IP and tokens visible.** Easy to do by accident. Double-check screenshots before posting.
- **You running commands you don't understand.** The layers protect against outsiders. They don't protect against yourself.

## If you suspect a breach

1. Rotate the Anthropic API key (console.anthropic.com → Revoke, Create).
2. Rotate Slack tokens (api.slack.com/apps → your app → Regenerate).
3. Rotate SSH keys if you think the private key leaked (make a new one, add to DigitalOcean, remove old one, destroy droplet if really paranoid).
4. Restore to a clean DigitalOcean snapshot from before the suspected breach.
5. Restart from Step 1 if all else fails.

## The habit that saves you

Before you open a permission, run a command, or paste a config, ask yourself: "If this were wrong, what's the worst that happens?" If the answer is "I have to restore a snapshot," you're fine. If the answer is "someone takes over my agent and uses my API key," slow down.
