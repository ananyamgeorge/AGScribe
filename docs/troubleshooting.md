# Troubleshooting

When something breaks, run these in order. Most problems resolve at step 3 or 4.

## Step 1 — Run the doctor

```
ssh root@YOUR_TAILSCALE_IP
openclaw doctor --deep --yes
```

This is a self-diagnostic. If it reports red errors, read them carefully. They're usually specific ("API key invalid," "workspace folder not found") and self-explanatory.

## Step 2 — Check gateway status

```
openclaw status
```

If the gateway is down:

```
openclaw gateway start
```

If that doesn't work:

```
openclaw gateway restart
```

## Step 3 — Read the logs

```
openclaw logs --tail 50
```

The answer is usually in the last twenty lines. Look for words like `error`, `failed`, `timeout`, or `unauthorized`.

## Step 4 — Screenshot and ask Claude

Take a screenshot of the error. Go to [claude.ai](https://claude.ai). Paste the screenshot. Ask "What does this error mean and how do I fix it?"

This is the universal recovery move. It works for everything. Your error is almost certainly something that hundreds of others have hit.

## Step 5 — Restore a snapshot

DigitalOcean → your droplet → **Snapshots** → **Restore**. You lose whatever you did since the snapshot was taken. That's the cost. Take snapshots often to make this cheap.

---

## Specific problems

### "The bot doesn't reply in Slack."

Check these in order:

1. Is the gateway running? `openclaw status`.
2. Is your Slack user ID in `allowFrom`? `cat ~/.openclaw/openclaw.json | grep allowFrom`.
3. Did you add the bot to the channel? In Slack: `/invite @your-bot-name`.
4. Did you use the channel ID (not the channel name)?
5. Did you re-install the Slack app after adding permissions?

### "Missing API key for provider OpenAI."

OpenClaw defaults to OpenAI models. You need to explicitly set Claude as primary:

```
openclaw config set agents.defaults.model.primary anthropic/claude-opus-4-6
openclaw gateway restart
```

### "Responses are really slow."

Opus is the smartest Claude model and also the slowest. For daily tasks, switch to Sonnet:

```
openclaw config set agents.defaults.model.primary anthropic/claude-sonnet-4-6
openclaw gateway restart
```

### "I can't SSH in anymore."

Check your Tailscale connection first. On your Mac, look at the Tailscale icon in the menu bar. If it says "Disconnected," click it and reconnect.

If Tailscale is fine but SSH still hangs:

1. The VPS's Tailscale IP may have changed. Use DigitalOcean's web console to log in: droplet → **Access** → **Launch Droplet Console**.
2. Inside the console, run `tailscale ip -4` and note the new IP.
3. Use the new IP to SSH from your Mac.

### "The bot replies but ignores my SOUL.md."

The workspace path in the config probably doesn't match where you saved SOUL.md.

```
cat ~/.openclaw/openclaw.json | grep workspace
ls ~/.openclaw/workspace/
```

Make sure the workspace in the config resolves to the folder that contains `SOUL.md`. Restart after fixing.

### "The agent wrote a file but I can't find it."

The agent may have written to a different folder than you expected. Search:

```
find ~ -name "*.md" -newer ~/.openclaw/openclaw.json 2>/dev/null
```

That lists recently modified markdown files. Look for the one you expected.

Also, if you're using the team setup, remember the book folder is at `~/shared-book/`, not `~/.openclaw/workspace/book/`. The symlink makes them look identical from the agent's point of view.

### "The bot claimed it saved a file but didn't."

This is called hallucination. The agent reported success without actually doing the thing. Your SOUL.md should already have a "verify yourself" section telling the agent to check its own work. If it doesn't, add it.

For now: check manually with `ls` and `cat`. Tell the agent: "That file doesn't exist. Try again and verify with `ls` before telling me it worked."

### "The daily morning brief never arrives."

See `docs/12-create-heartbeat.md` gotchas. Usually the heartbeat isn't hooked into a real scheduler. Ask the agent: "Have you set up a cron job for the morning brief? Show me."

### "I'm being charged more than I expected."

Go to [console.anthropic.com](https://console.anthropic.com) → **Usage**. Look at the daily chart. Big spikes mean the agent ran in a loop.

Immediate fix: lower your spending cap (**Settings** → **Limits** → set it to $10). The agent will hit the cap and stop.

Then investigate: check `openclaw logs --tail 200` for repeated failures. A task that retries endlessly is the usual cause.

### "I think I committed a secret to GitHub."

Rotate immediately. Don't wait.

- Anthropic key: console.anthropic.com → **API Keys** → **Revoke**.
- Slack tokens: api.slack.com/apps → your app → **Regenerate** on each.
- Telegram token: message `@BotFather` → `/revoke` → pick the bot → get a new token.

Then remove the key from git history. If this happened minutes ago and no one's cloned the repo, `git reset --hard HEAD~1 && git push --force` may be enough. If it's been longer, treat the key as compromised forever — rotation is the only real fix.

---

## When to ask for help

If you've tried all five steps at the top and you're still stuck:

- Open an issue on this repo with: your OS, your OpenClaw version (`openclaw --version`), the full error, and what you've already tried.
- Post in the OpenClaw community (wherever that lives).
- Screenshot to Claude — often, a second set of eyes spots it immediately.

Don't debug alone for more than an hour.
