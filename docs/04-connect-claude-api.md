# Step 4 — Give it a brain (connect Claude)

By the end of this step, your OpenClaw install will have an Anthropic API key, a config file pointing at a specific Claude model, and a running gateway that stays up even after you log out.

## What's going on

OpenClaw is the employee. Claude is the brain the employee rents from Anthropic. Without an API key, the employee has no way to think.

You're going to:
1. Create an API key at Anthropic.
2. Set a spending limit so you can't get a surprise bill.
3. Paste the key into an OpenClaw config file.
4. Start the gateway (the piece that listens for messages).

## Get your Anthropic API key

1. Open [console.anthropic.com](https://console.anthropic.com) in your browser.
2. Sign in (use the same email you used for DigitalOcean if you can — keeps your life simple).
3. In the left sidebar, click **API Keys**.
4. Click **Create Key**.
5. Name it something memorable, like `scribe-vps`.
6. Click **Create**.
7. A long string starting with `sk-ant-...` appears. **Copy it immediately** and paste it into your notes. Anthropic only shows it once. If you close the window, you'll have to make a new one.

## Set a spending limit (important)

This is the step that saves you from horror stories. Set a monthly cap so the bill can't run away.

1. In the Anthropic console, click **Settings**.
2. Click **Limits** (may be called "Usage limits").
3. Set a **monthly limit** of **$30**.
4. Save.

$30 is enough to write a whole book with careful usage. If the agent goes haywire and runs in a loop, the bill stops at $30. You can raise the cap later when you know what you're doing.

## Create the config file

SSH into your VPS (if you're not already in):

```
ssh root@YOUR_VPS_IP
```

First, make sure the OpenClaw config folder exists:

```
mkdir -p ~/.openclaw
```

Open the config file with `vi`:

```
vi ~/.openclaw/openclaw.json
```

(If you hate `vi`, use `nano ~/.openclaw/openclaw.json` instead. Same outcome.)

Press `i` to enter insert mode, then paste this exact block. **Replace the placeholder API key with the real one you just copied:**

```json
{
  "gateway": {
    "mode": "local",
    "port": 18789
  },
  "providers": {
    "anthropic": {
      "apiKey": "sk-ant-YOUR-ACTUAL-KEY-HERE"
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-opus-4-6"
      }
    }
  }
}
```

Press Escape. Type `:wq`. Press Enter. File saved.

## Why Claude Opus

Opus is the smartest available Claude model. For your first week, you want the best brain so you can see what's actually possible. Later, you'll probably switch to Sonnet for daily tasks — faster, cheaper, still very good — and keep Opus for hard writing.

To switch models later:

```
openclaw config set agents.defaults.model.primary anthropic/claude-sonnet-4-6
openclaw gateway restart
```

## Start the gateway

The gateway is the piece that listens for incoming messages and routes them to the agent. Start it:

```
openclaw gateway start
```

Now install it as a daemon so it stays up even after you close your SSH session:

```
openclaw gateway install
```

## Check everything

Run the built-in health check:

```
openclaw doctor --deep --yes
```

This prints a list of checks. Most output is green checkmarks. Warnings (yellow) are fine to ignore. If you see actual red errors, screenshot them and paste into Claude.

## Confirm it worked

- [ ] `openclaw doctor --deep --yes` completes without red errors.
- [ ] The gateway is running: `openclaw status` shows it as `up`.
- [ ] Your Anthropic console shows the API key was used recently (after `openclaw doctor` runs, the API gets called).

## The gotcha

**"Missing API key for provider OpenAI."** OpenClaw defaults to OpenAI models. If you see this error, it means your config didn't make the Claude model the primary. Re-open the config, make sure the `model.primary` line says `anthropic/claude-opus-4-6` exactly, save, and restart the gateway:

```
openclaw gateway restart
```

## What's next

Your agent has a brain. It still has no way for you to talk to it. Next we give it a phone.

[Step 5 — Connect Slack](05-connect-slack.md)
