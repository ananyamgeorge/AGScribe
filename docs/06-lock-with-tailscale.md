# Step 6 — Lock the front door (Tailscale)

By the end of this step, your VPS will not be reachable from the public internet at all. The only way to SSH in is over a private network that only your own devices can see.

## Why this matters

Right now your VPS has a street address (`168.144.67.170`) that every port scanner on the internet can see. The SSH key protects you — nobody can break in without it — but having bots hammering on the door all day is like leaving your car unlocked in a parking lot. Nothing's been stolen yet. Why take the chance.

Tailscale moves your VPS off the public internet and into a private network. The VPS effectively disappears from the map. Only devices signed into your Tailscale account can see it.

## What Tailscale is, in plain English

A VPN — a Virtual Private Network. Normally, computers on the internet talk to each other using public addresses. A VPN lets a group of computers talk to each other using private addresses that outsiders can't reach.

Imagine your office is currently a shop on a busy street. Anyone can walk up and try the door. Tailscale moves your office into a private building with no street entrance. The only way in is a private elevator that only works with your keycard. The building doesn't appear on any map.

Tailscale is free for personal use up to 100 devices. You'll have two (laptop and VPS).

## Install Tailscale on the VPS

SSH in using the **public IP — this is the last time you'll use it**:

```
ssh root@YOUR_VPS_IP
```

Install Tailscale:

```
curl -fsSL https://tailscale.com/install.sh | sh
```

Bring it up:

```
tailscale up
```

It prints an authentication URL. Copy it and paste it into your Mac's browser.

**Important:** when the page asks you to sign in, use an email you want to keep using for this. If you sign into Tailscale on your Mac with a different account, your Mac and VPS will be on different private networks and won't be able to see each other. Pick one email and stick with it.

After you sign in, the VPS shows up in your Tailscale account.

Find your VPS's new private address:

```
tailscale ip -4
```

You'll see something like `100.66.37.125`. Write it down. **This is your VPS's new private address. From now on, you use this address, not the public one.**

## Install Tailscale on your Mac

1. Go to [tailscale.com/download](https://tailscale.com/download) and download the Mac app.
2. Open the DMG. Drag the app to Applications.
3. Launch it.
4. macOS will ask you to **Allow System Extension**. Click **Install Now**.
5. You may need to go to **System Settings → Privacy & Security** and click **Allow** next to the Tailscale extension. macOS might ask twice. This is macOS being protective — not an error.
6. The Tailscale icon appears in your menu bar (top right).
7. Click it → **Log in**. Sign in with the **same email** you used on the VPS.

Wait a few seconds. The VPS should appear in the Tailscale menu.

## Test the private connection

Open a **new terminal tab** on your Mac. Try:

```
ssh root@YOUR_TAILSCALE_IP
```

(Use the `100.x.x.x` address that `tailscale ip -4` printed on the VPS.)

If you land inside the VPS, your private tunnel works.

## Close the public door

Now you're going to lock the public SSH door. **Do not do this before confirming Tailscale works.** If Tailscale fails and you lock the public door at the same time, you'll need to use DigitalOcean's web console to recover. It's possible but annoying.

On the VPS (connected via Tailscale now):

```
ufw allow in on tailscale0
ufw deny 22/tcp
ufw enable
```

**What this does:**

- `ufw` is the VPS firewall — the security desk in the building.
- First line: "allow anyone in through the Tailscale entrance."
- Second line: "lock the public door (SSH port 22)."
- Third line: "start enforcing these rules."

It'll warn that you may lose your SSH session. You won't, because you're in over Tailscale. Type `y` and Enter.

Verify:

```
ufw status
```

You should see:

```
Anywhere on tailscale0     ALLOW       Anywhere
22/tcp                     DENY        Anywhere
```

## Prove the public door is dead

Open another terminal tab on your Mac. Try the old public IP:

```
ssh root@YOUR_OLD_PUBLIC_IP
```

It should hang for thirty seconds and then time out. The public door is gone.

Now try the Tailscale IP again:

```
ssh root@YOUR_TAILSCALE_IP
```

Connects immediately. The private elevator works.

## Confirm it worked

- [ ] `ssh root@OLD_PUBLIC_IP` hangs or times out.
- [ ] `ssh root@TAILSCALE_IP` connects fine.
- [ ] Your Slack bot still replies (Tailscale didn't break OpenClaw's connection to Slack).

## The gotchas

**Tailscale IPs can change** if you log out and back in under a different account. If your SSH suddenly stops working one day, first check `tailscale ip -4` on the VPS (log in via the DigitalOcean console from the browser — they give you a web terminal). The address may have shifted.

**macOS fights Tailscale.** The "Allow System Extension" dialog may appear twice. Click through both. Allow it in System Settings → Privacy & Security. Not an error, just macOS being protective.

**The `tailscale` command doesn't work in your Mac terminal.** That's fine. The Mac uses the menu bar app, not the command line. Just check the Tailscale icon is in the menu bar and says "Connected."

**"I locked myself out."** If you closed the public door before testing Tailscale and now you can't get in, go to DigitalOcean → your droplet → **Access** → **Launch Droplet Console**. That gives you a web terminal where you can fix the firewall (`ufw allow 22/tcp && ufw reload`).

## What's next

The door is locked. Now let's set rules for what the employee is allowed to do inside.

[Step 7 — Security hardening](07-security-hardening.md)
