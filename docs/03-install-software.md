# Step 3 — Furnish the office (install software)

By the end of this step you'll have Node.js and OpenClaw installed on your VPS. The VPS will know how to run your agent, but the agent won't have a brain or a phone yet — those come in the next two steps.

## What you're installing

Two things:

- **Node.js** — the runtime OpenClaw needs. Think of it as the electricity. Nothing else works until this is on.
- **OpenClaw** — the agent framework. Think of it as the employee. Once it's installed, you can start telling it what to do.

## Log in to the VPS

From your Mac:

```
ssh root@YOUR_VPS_IP
```

Everything from here on happens on the VPS.

## Update the system

Before installing anything, check for system updates. This is like doing building maintenance before moving furniture in.

```
apt update && apt upgrade -y
```

Lots of text will scroll. Ignore it unless you see the word `error` in red. If it asks you a question, press Enter to accept the default.

This can take one to five minutes. Wait for the prompt to come back.

## Install Node.js

```
curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
apt install -y nodejs
```

**What this does in plain English:**

The first line uses `curl` — a fishing rod that reaches out to a URL and reels back what's there. The `|` is a pipe, like a chute between two factory machines. The output of `curl` drops straight into `bash`, which runs it.

So: "fetch a setup script from Node's official download site and run it." That script tells your VPS where Node lives. The second line then installs it.

Verify:

```
node --version
```

You should see something like `v24.1.0`. If yes, the electricity is on.

## Install OpenClaw

```
curl -fsSL https://openclaw.ai/install.sh | bash
```

Same pattern. Fishing rod fetches the installer, pipe sends it to bash. Wait for it to finish.

Verify:

```
openclaw --version
```

You should see a version number. The employee has arrived at the office.

## Confirm it worked

- [ ] `node --version` prints a version (any `v24.x` is fine).
- [ ] `openclaw --version` prints a version.

If either command says "command not found," re-run the install line for that tool and try again. If it still doesn't work, screenshot and paste into Claude.

## The gotcha

**"curl: command not found" on a fresh droplet.** Some images don't have `curl` installed. Install it:

```
apt install -y curl
```

Then re-run the Node.js install line.

## Why we skip the setup wizard

OpenClaw has a built-in wizard (`openclaw onboard`) that tries to configure everything interactively. It has had reliability issues. This guide uses manual config throughout — it's not harder, it's more predictable, and when something goes wrong you know exactly which file to fix.

## What's next

The employee exists but has no brain to think with. Next we plug one in.

[Step 4 — Connect the Claude API (give it a brain)](04-connect-claude-api.md)
