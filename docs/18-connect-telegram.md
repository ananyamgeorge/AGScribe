# Step 18 — Connect Telegram

> **Heads up — this section is extrapolated.**
>
> The OpenClaw docs for Telegram integration were not verified while this guide was written. The config shape below is a best-guess extrapolation from the Slack pattern plus the standard Telegram Bot API conventions. **Before trusting it in production, check the current OpenClaw docs at `docs.openclaw.ai/channels/telegram` and diff against what's here.** If OpenClaw has added fields or renamed things, follow the real docs.
>
> If you find a discrepancy, open an issue on this repo so the next person doesn't hit it.

---

By the end of this step, your existing writer agent will also respond to Telegram messages. You'll be able to DM the bot from your phone without needing Slack open.

## Why Telegram

Slack is great at a laptop. Telegram is better on a phone. If you want to send "I just had an idea for chapter 4" while walking the dog, Telegram is faster.

You don't replace Slack. Both channels point at the same agent. Use whichever's handier.

## Create the Telegram bot

1. Open Telegram.
2. Search for `@BotFather` and start a chat.
3. Send `/newbot`.
4. Give it a name (what people see). Example: `My Scribe`.
5. Give it a username ending in `bot`. Example: `myscribe_bot`.
6. BotFather gives you a **token** that looks like `123456789:ABCdef-ghijklMNOpqrsTUVwxyz`. Copy it into your notes.

## Get your Telegram user ID

1. Still in Telegram, search for `@userinfobot` and start a chat.
2. It replies with your user ID — a number like `987654321`. Copy it.

## Add Telegram to the config

SSH to the VPS:

```
ssh root@YOUR_TAILSCALE_IP
vi ~/.openclaw/openclaw.json
```

Add a `telegram` block inside the `channels` section. If you already have `slack` in there, add `telegram` alongside it — both can coexist:

```json
"channels": {
  "slack": {
    "enabled": true,
    "mode": "socket",
    "botToken": "xoxb-...",
    "appToken": "xapp-...",
    "dmPolicy": "allowlist",
    "allowFrom": ["YOUR_SLACK_USER_ID"],
    "channels": {
      "YOUR_CHANNEL_ID": {}
    }
  },
  "telegram": {
    "enabled": true,
    "mode": "polling",
    "botToken": "123456789:ABCdef-ghijklMNOpqrsTUVwxyz",
    "dmPolicy": "allowlist",
    "allowFrom": ["YOUR_TELEGRAM_USER_ID"]
  }
}
```

**Field explanations (extrapolated):**

- `mode: polling` — the agent checks Telegram's servers for new messages every few seconds. No public URL needed. This keeps your VPS invisible behind Tailscale. If OpenClaw supports it and you want lower latency, the alternative is `mode: webhook` with a public URL — but that defeats the invisibility we set up in Step 6, so stick with polling unless you really need it.
- `botToken` — the token from BotFather.
- `dmPolicy: allowlist` — the same guardrail as Slack. Only people in `allowFrom` can talk to the bot.
- `allowFrom` — your Telegram user ID. If you want others to DM the bot later, add their user IDs here.

Save the file (`:wq` in vi).

## Restart the gateway

```
openclaw gateway restart
```

## First-message handshake

Open Telegram. Search for the bot by its username (`@myscribe_bot`). Tap **Start**. Send "hello."

If OpenClaw uses the same pairing flow as Slack, the bot may reply with a pairing code. Back on your VPS, approve it:

```
openclaw pairing approve telegram THE_PAIRING_CODE
```

If OpenClaw doesn't use the pairing flow for Telegram, the bot should just reply once your user ID is in the allowlist.

## Confirm it worked

- [ ] The bot replies in Telegram with a sensible message in your agent's voice.
- [ ] `openclaw logs --tail 20` shows no telegram-related errors.
- [ ] The same agent answers in Slack and Telegram (both channels feed into the same writer).

## The gotcha

**You DM the bot and nothing happens.** The three usual causes:

1. Your Telegram user ID isn't in `allowFrom`. Double-check the number — it's a long integer, not a username.
2. You have `enabled: false` on the telegram block by accident.
3. Polling mode is blocked by the firewall. Outbound HTTPS should be allowed by default on Ubuntu, but if you've customized UFW, make sure outbound 443 works: `ufw status` — there should be no rule denying outbound traffic.

## The bigger gotcha

**"It worked yesterday and now it's silent."** Telegram bots can hit rate limits. If the bot seems frozen, restart the gateway. If the problem persists, check logs for `429 Too Many Requests` from Telegram.

## What's next

[Step 19 — Connect WhatsApp](19-connect-whatsapp.md)
