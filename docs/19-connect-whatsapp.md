# Step 19 — Connect WhatsApp

> **Heads up — this section is extrapolated and harder than Slack or Telegram.**
>
> WhatsApp is not a single API like Telegram. There are at least two realistic paths: Meta's own Cloud API (direct, free tier, more paperwork) or a provider like Twilio (simpler setup, costs per message). Both involve phone-number verification steps that can take hours or days.
>
> The OpenClaw docs for WhatsApp integration were not verified while this guide was written. The config below is extrapolated from the Slack/Telegram pattern plus general Meta Cloud API conventions. **Before going far down this path, check the current OpenClaw docs at `docs.openclaw.ai/channels/whatsapp`.** If the real integration is different, follow the docs and ignore the shape here.
>
> If you just want to message your agent from your phone, **Telegram is much simpler**. Consider doing Step 18 first and only coming back here if you specifically need WhatsApp.

---

By the end of this step, your agent will respond to WhatsApp messages sent to a dedicated business number.

## You cannot use your personal WhatsApp

WhatsApp's personal accounts can't be controlled by automation. You need WhatsApp Business — either:

- **A separate phone number** (a second SIM or a virtual number).
- **WhatsApp Business with the Cloud API** (Meta's developer-oriented path).
- **A provider like Twilio** that handles the Meta relationship for you.

None of these options let you "just receive messages on your real WhatsApp." Don't expect that.

## Path A: Twilio (simpler, costs per message)

This is the faster path. Twilio charges about $0.005 per message. Fine for a personal bot.

1. Sign up at [twilio.com](https://twilio.com).
2. Follow their "WhatsApp Sandbox" quickstart — it gives you a shared test number you can use for development.
3. Copy your **Account SID**, **Auth Token**, and the **WhatsApp number** (like `whatsapp:+14155238886`).
4. When you're ready for production, apply for your own number through Twilio's WhatsApp onboarding. This takes a few business days and Meta review.

## Path B: Meta Cloud API (free tier, more paperwork)

1. Go to [developers.facebook.com](https://developers.facebook.com).
2. Create a Meta App. Product type: **Business**.
3. Add the **WhatsApp** product.
4. Create or attach a **WhatsApp Business Account**.
5. Get a test phone number from Meta (or verify your own).
6. Copy your **Phone Number ID**, **WhatsApp Business Account ID**, and a **permanent access token**.
7. Set up a webhook URL — and this is where WhatsApp gets awkward on a locked-down VPS. Meta needs a publicly reachable HTTPS endpoint. If your VPS is behind Tailscale, you don't have one.

## The webhook problem on a Tailscale-locked VPS

Meta's WhatsApp integration requires a public URL to send you incoming messages. Your VPS is currently invisible (Step 6). You have three options:

1. **Use a relay service like ngrok, Cloudflare Tunnel, or Tailscale Funnel.** Tailscale Funnel lets you expose one specific port publicly while keeping everything else private. This is the cleanest if you're already on Tailscale.
2. **Open port 443 on your VPS firewall just for WhatsApp.** Works but partially undoes the Tailscale invisibility.
3. **Use a provider like Twilio that handles the webhook for you** (see Path A above).

For a personal book-writing agent, **Path A (Twilio) is usually the right trade-off**. The paperwork for Meta direct is only worth it at scale.

## Config shape (extrapolated)

Add a `whatsapp` block inside `channels` in `~/.openclaw/openclaw.json`.

### For Twilio:

```json
"whatsapp": {
  "enabled": true,
  "provider": "twilio",
  "accountSid": "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "authToken": "your_twilio_auth_token",
  "fromNumber": "whatsapp:+14155238886",
  "webhookUrl": "https://your-public-url.tld/whatsapp/webhook",
  "dmPolicy": "allowlist",
  "allowFrom": ["+15551234567"]
}
```

### For Meta Cloud API:

```json
"whatsapp": {
  "enabled": true,
  "provider": "meta-cloud",
  "phoneNumberId": "1234567890",
  "businessAccountId": "9876543210",
  "accessToken": "EAAG...",
  "verifyToken": "a_random_string_you_invent",
  "webhookUrl": "https://your-public-url.tld/whatsapp/webhook",
  "dmPolicy": "allowlist",
  "allowFrom": ["+15551234567"]
}
```

**Every field name above is extrapolated.** Check the real OpenClaw docs before filling them in.

## Set up the webhook URL

If you're using Twilio, enter the webhook URL in the Twilio sandbox settings.

If you're using Meta Cloud API, enter it in Meta's WhatsApp webhook config and provide the `verifyToken` you made up. Meta will ping the URL once to verify before enabling.

To make your VPS webhook-reachable without losing Tailscale invisibility, use **Tailscale Funnel**:

```
tailscale funnel 18789
```

This exposes just the one port publicly over HTTPS. The rest of your VPS stays invisible. Tailscale assigns you a URL like `https://scribe-vps.tail123abc.ts.net/`. Use that as the webhook base.

## Restart and test

```
openclaw gateway restart
```

WhatsApp the bot:

- Twilio sandbox: follow the onboarding message Twilio sends to connect your phone to the sandbox.
- Meta: from whatever number you added to the allowlist.

Say "hello." The bot should reply.

## Confirm it worked

- [ ] Your phone number is in `allowFrom` (in international format, e.g., `+15551234567`).
- [ ] The webhook URL is reachable — test it with `curl https://your-public-url.tld/whatsapp/webhook` from anywhere. You should get a response (not a connection error).
- [ ] The bot replies in WhatsApp.

## The gotcha

**24-hour message window.** WhatsApp only lets you send free-form replies within 24 hours of the user's last message. Outside that window, you need to use pre-approved message templates (which Meta reviews). For a personal use case, this rarely matters — you'll always be replying to something you just sent — but it's the kind of thing that surprises people.

## The bigger gotcha

**WhatsApp is a lot of setup for a channel you already have on Slack and Telegram.** If you only set this up because it sounded cool, consider skipping it. Slack at the laptop, Telegram at the phone — that covers 95% of book-writing life.

## What's next

You're done with the setup guide. Go write.

See [troubleshooting.md](troubleshooting.md) when things break, [costs.md](costs.md) for managing bills, and [security-layers.md](security-layers.md) for a reminder of what's protecting your setup.
