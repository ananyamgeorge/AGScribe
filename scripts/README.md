# Optional helper scripts

These scripts do **nothing that the guide doesn't already walk you through by hand**. They exist only so you don't have to type the same commands twice if you rebuild your server.

**You don't need any of these.** Every script here is a thin wrapper around commands you'll already find in the docs. The guide's teaching style is "type it yourself so you know what's happening" — following the docs step by step is the recommended path the first time.

When you might reach for these:

- You've already set up one server and want to do it again on a second one.
- Your server was wiped or the snapshot restore isn't enough.
- You want a reference for what you ran, in one place.

## What each script does

| Script | What it does | Maps to docs |
|---|---|---|
| `install-node.sh` | Installs Node.js (the runtime OpenClaw needs) | `docs/03-install-software.md` |
| `install-openclaw.sh` | Fetches and runs the OpenClaw installer | `docs/03-install-software.md` |
| `setup-workspace.sh` | Creates the folders the writer agent expects | `docs/10-build-the-workspace.md` |
| `setup-tailscale.sh` | Installs Tailscale and brings the VPN up | `docs/06-lock-with-tailscale.md` |
| `firewall-lockdown.sh` | Locks the public SSH door, allows only Tailscale | `docs/06-lock-with-tailscale.md` |

## How to run a script

On your VPS, after SSH-ing in:

```
curl -fsSL https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME/main/scripts/install-node.sh | bash
```

Or if you've cloned the repo onto the VPS:

```
bash scripts/install-node.sh
```

## Safety note

Never pipe a script from a random URL straight into bash unless you've read it first. Every script here is short. Open it. Read every line. Then run it.

This is the habit that will save you someday.
