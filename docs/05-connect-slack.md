# Step 5 — Give it a phone (connect Slack)

By the end of this step, you'll be able to send a message to a bot on Slack and have your agent answer.

This is the longest step in the guide because Slack has a lot of settings. Go slowly. Tick off each checkbox before moving to the next.

## Create a Slack workspace (if you don't have one)

If you already have a workspace where you want the bot, skip this. Otherwise, go to [slack.com](https://slack.com), click **Create a new workspace**, pick a name, and invite yourself.

## Create the Slack app

1. Go to [api.slack.com/apps](https://api.slack.com/apps).
2. Click **Create New App** → **From scratch**.
3. Name it something descriptive, like `scribe-bot`.
4. Pick the workspace you want.
5. Click **Create App**.

## Save these values now

On the landing page of your new app, find and copy these four values into your notes. Some are shown only once.

- **App ID**
- **Client ID**
- **Client Secret** (click **Show**)
- **Signing Secret** (click **Show**)

## Add permissions (Bot Token Scopes)

Left sidebar → **OAuth & Permissions** → scroll down to **Bot Token Scopes** → **Add an OAuth Scope**.

Add every one of these. Missing one will cause a silent failure later:

- `app_mentions:read`
- `channels:history`
- `channels:read`
- `chat:write`
- `groups:history`
- `groups:read`
- `im:history`
- `im:read`
- `im:write`
- `mpim:history`
- `reactions:read`
- `users:read`

## Install the app to your workspace

Scroll up on that same page. Click **Install to Workspace**. Approve the permissions. Slack gives you a **Bot User OAuth Token** that starts with `xoxb-`. Copy it into your notes.

## Enable Socket Mode

Socket Mode is what lets the bot work without you exposing a public URL for Slack to hit. Slack's servers and your VPS open a private connection. Nothing else on the internet can reach your bot.

1. Left sidebar → **Socket Mode** → toggle it **on**.
2. It'll ask you to generate an **App-Level Token**.
3. Name it `scribe-socket`.
4. Under scopes, add `connections:write`.
5. Click **Generate**.
6. A token that starts with `xapp-` appears. Copy it into your notes.

## Subscribe to events

1. Left sidebar → **Event Subscriptions** → toggle **on**.
2. Scroll to **Subscribe to bot events** → **Add Bot User Event**.
3. Add these three:
   - `message.im` (direct messages)
   - `app_mention` (when someone @-mentions the bot in a channel)
   - `message.channels` (messages in channels the bot is in)
4. Click **Save Changes** at the bottom of the page.

## Reinstall the app

After any permission or event change, Slack makes you reinstall. Left sidebar → **Install App** → **Reinstall to Workspace**. Approve again.

## Enable messaging in the app home

1. Left sidebar → **App Home**.
2. Scroll to **Show Tabs**.
3. Under the **Messages** tab, toggle **Allow users to send Slash commands and messages from the messages tab** to **on**.

Without this, you can't DM the bot. The bot will receive mentions but DMs will do nothing. It's easy to miss.

## Get your Slack user ID

1. In Slack, click your own avatar (top right).
2. Click **Profile**.
3. Click the three dots (**More**).
4. Click **Copy member ID**.

You'll get something like `U01ABC23DEF`. Paste into your notes.

## Get the channel ID for the channel you want the bot in

1. Invite the bot to a channel first: in the channel's message box, type `/invite @scribe-bot` (or whatever you named your bot).
2. Right-click the channel name in the sidebar → **View channel details**.
3. Scroll to the bottom. Copy the **Channel ID** (looks like `C08R3EJ46D`).

**Always use the channel ID.** Never use the channel name (like `#general`). Channel names can contain characters that break things. Channel IDs are safe.

## Add Slack to the OpenClaw config

SSH to your VPS and edit the config:

```
ssh root@YOUR_VPS_IP
vi ~/.openclaw/openclaw.json
```

Press `i`. Replace the whole file with this block — it's the single-agent config from `configs/openclaw-single.json` in this repo. **Fill in every placeholder with the real values from your notes:**

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
  },
  "channels": {
    "slack": {
      "enabled": true,
      "mode": "socket",
      "botToken": "xoxb-YOUR-BOT-TOKEN",
      "appToken": "xapp-YOUR-APP-TOKEN",
      "dmPolicy": "allowlist",
      "allowFrom": ["YOUR_SLACK_USER_ID"],
      "channels": {
        "YOUR_CHANNEL_ID": {}
      }
    }
  }
}
```

Press Escape. Type `:wq`. Enter.

**What each new field does:**

- `mode: socket` — use Socket Mode, the private connection we set up.
- `botToken` — the `xoxb-` token from Slack.
- `appToken` — the `xapp-` token.
- `dmPolicy: allowlist` — only people in `allowFrom` can DM the bot. Important: without this, anyone who finds the bot can talk to it.
- `allowFrom` — your Slack user ID. Just you, for now.
- `channels` — channels the bot is active in. Key is the channel ID. Empty object `{}` means "use defaults."

## Restart the gateway

```
openclaw gateway restart
```

## The pairing handshake

Go to Slack. Open a DM with your bot. Type **hello** and press Enter.

The first time, the bot will reply something like:

> OpenClaw: access not configured. Pairing code: `XXXX-XXXX`

Copy that pairing code. Back on your VPS terminal, run:

```
openclaw pairing approve slack XXXX-XXXX
```

Now add yourself to the allowlist permanently:

```
openclaw config set channels.slack.allowFrom '["YOUR_SLACK_USER_ID"]'
openclaw gateway restart
```

Back in Slack, say hello again. This time, the bot answers.

**Your agent just picked up the phone.**

## Confirm it worked

- [ ] You can DM the bot and it responds with a sensible message.
- [ ] The response takes 2–15 seconds (Opus thinks hard — that's normal).
- [ ] No errors in `openclaw logs --tail 20`.

## The gotcha

**The bot receives messages but doesn't reply.** Check:

1. Did you add the bot to the channel? `/invite @your-bot-name` in Slack.
2. Did you use the channel ID, not the channel name?
3. Is your Slack user ID in the `allowFrom` list?
4. Did you re-install the Slack app after changing scopes?

If none of those fix it, check the logs: `openclaw logs --tail 50`. The last 20 lines usually say exactly what's wrong.

## What's next

Your office has a street address that anyone on the internet can find. Before we do anything else, we make it invisible.

[Step 6 — Lock the door (Tailscale)](06-lock-with-tailscale.md)
