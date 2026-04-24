# Step 7 — Security hardening

By the end of this step, your agent will have approval gates for risky actions, hard cost limits so a runaway loop can't burn through your API budget, and a verified allowlist so only you can talk to it.

## What we're doing

Your office is now invisible (Tailscale) and the door is locked (UFW firewall). Now we're setting rules for the employee inside the office. Even a well-meaning employee can do something expensive or destructive if you don't give it guardrails.

This step is the shortest in the guide because you mostly just ask the agent to do it.

## Ask the agent to harden itself

Open Slack. Send this message to the bot verbatim:

> Please read the official OpenClaw security documentation at https://docs.openclaw.ai/security and apply all recommended settings to my installation. Specifically:
>
> 1. Enable approval gates. You must ask me before sending messages on my behalf, deleting files, or making network requests to new domains.
>
> 2. Set cost guardrails. If a task fails three times in a row, stop. No single task runs longer than 10 minutes without my explicit approval.
>
> 3. Verify the allowlist DM policy is active on all channels.
>
> 4. Confirm when done. List exactly what you changed.

The agent will read the docs, apply settings, and report back. Read its report carefully. If anything doesn't match what you asked for, push back: "You didn't set the cost guardrails. Please do it now."

## What you're looking for in the report

- A clear line saying approval gates are enabled.
- A clear line saying the DM allowlist is active.
- A specific numeric cost cap (e.g., "10-minute per-task limit" or "3-failure limit").
- A list of exact config file changes made.

If the agent says "I've applied all recommended settings" without specifics, that's not good enough. Ask it to list what it changed, file by file.

## Verify by reading the config

The agent's just-trust-me report is not enough. Read the config yourself:

```
ssh root@YOUR_TAILSCALE_IP
cat ~/.openclaw/openclaw.json
```

Look for a `security` or `approvals` block. Look for a `limits` block. Look for the DM `allowlist` entries.

If something is missing, tell the agent: "The config doesn't show approval gates. Add them now and show me the resulting file."

## Why this matters more than it sounds

The common failure mode with agents is not malicious behavior. It's accidental loops. A task fails, the agent retries, it fails again, the agent retries harder, and three hours later you have a $40 bill.

Approval gates and cost guardrails are not security theater. They are budget protection.

## Confirm it worked

- [ ] The agent replied with a specific list of changes, not vague reassurance.
- [ ] `cat ~/.openclaw/openclaw.json` shows security-related fields.
- [ ] The `dmPolicy` is `"allowlist"` and your user ID is in `allowFrom`.

## The gotcha

**"I can't find the docs" / the agent fabricates settings.** If the docs URL is unreachable or outdated, the agent may invent plausible-sounding but wrong config fields. Read the config yourself. If a field looks invented, remove it. The Slack setup from Step 5 is the minimum you need. Extra fields that break parsing will silently disable the channel.

## What's next

You've built the engine. Now we give it a personality.

[Step 8 — Give it a personality](08-give-it-a-personality.md)
