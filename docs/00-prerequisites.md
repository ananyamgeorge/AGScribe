# Step 0 — What you need before you start

Don't skip this. Every later step assumes you have the things on this page. If you try to start at Step 1 without them, you'll hit a wall in the middle of a different task and have to come back here anyway.

## A Mac or a Linux laptop

This guide is written for Mac. If you're on Linux, nearly everything still works — just replace "Mac" with your laptop, "Terminal" with your terminal emulator, and you're fine.

Windows works too, but the commands are slightly different. If you're on Windows, use WSL (Windows Subsystem for Linux) or expect to translate a few commands yourself. You can do it. It's just not what this guide covers step by step.

## A credit card

You will pay three companies a small amount of money per month:

- **DigitalOcean** — rents you the computer your agent lives on. About $48/month.
- **Anthropic** — rents you the brain your agent uses. About $10–20/month if you set a cap. We'll show you how to set one.
- **Tailscale** — free for personal use. You won't pay them.

Total: under $80/month. Cheaper than a gym membership.

## An email address you actually check

You'll sign up for:
- DigitalOcean (the VPS)
- Anthropic (the API key)
- Slack (if you don't already have it)
- Tailscale (the private network)

Use the same email for all of them. It'll keep your life simple later.

## About two hours

If nothing goes wrong, you can finish the single-agent setup in two hours. The first person who ran this guide took five hours because things broke. That's normal. Budget half a day.

## A willingness to copy commands without fully understanding them

This is the biggest hurdle. You'll be asked to paste commands into a terminal. Some of them look scary. That is fine. Every command in this guide has been tested. The only real rule is: read what you're pasting, don't paste it from random strangers on the internet, and keep going.

If something breaks, screenshot it, paste the screenshot into Claude at claude.ai, and ask what's wrong. That's the universal recovery move. It works for every error in this guide.

## A notebook or notes app

You will collect secret keys and IDs as you go. Before you start, open a note and title it "VPS setup". You'll paste things in there as we go:

- Your DigitalOcean VPS IP address
- Your SSH key location
- Your Anthropic API key
- Your Slack Bot Token
- Your Slack App Token
- Your Slack signing secret
- Your Slack user ID
- Your Slack channel ID
- Your Tailscale IP address

**Do not share this note with anyone. Do not paste it into public places.**

## Next

[Step 1 — Rent the VPS](01-rent-the-vps.md)
