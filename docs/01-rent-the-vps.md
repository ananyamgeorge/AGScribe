# Step 1 — Rent the office (the VPS)

By the end of this step you'll have a rented computer in a data center somewhere in the world, and a way to log into it from your laptop.

## What a VPS is, in plain English

VPS stands for Virtual Private Server. That's a fancy way of saying "a rented computer." Like an Airbnb for computers. You pay monthly. Someone else handles the electricity and cooling. If you stop paying, the computer goes away.

The alternative is buying a Mac Mini and sticking it in your spare room. That's like buying a villa instead of renting an Airbnb. It works, but you have to deal with a lot more. This guide rents.

## Why DigitalOcean

You could rent from many places. We're using DigitalOcean because:

- It's the friendliest for a first-timer.
- Its dashboard is in plain English.
- Every tutorial on the internet assumes you're on DigitalOcean or something very like it.

You could also use Contabo (cheaper, uglier), AWS (fancier, much more complex), or Linode/Akamai (similar to DigitalOcean). If you already have an account with one of those, you can use it. The steps will be 90% the same, and you'll have to translate the remaining 10%.

## Sign up

1. Go to [digitalocean.com](https://digitalocean.com).
2. Click **Sign Up**.
3. Add a credit card.

## Create a Droplet

DigitalOcean calls rented computers "Droplets." Click **Create** → **Droplets**. Pick these settings:

### Operating system

Choose **Ubuntu 24.04 (LTS) x64**.

Ubuntu is the Honda Civic of operating systems. Reliable, well-documented, every tutorial on the internet assumes you're using it. If you pick something else, every command in every tutorial will need translation. Don't do that to yourself.

### Plan / Size

Choose the **Basic** shared-CPU plan, then pick:

- **8 GB RAM**
- **4 CPUs**
- **160 GB SSD disk**
- Approximately **$48/month**

Cheaper plans exist. We tried them. They were too tight. 8 GB gives you room. Think of RAM as desk space: 4 GB is a school desk, 8 GB is an office desk. The 160 GB disk is a filing cabinet you'll never fill.

### Region

Pick the data center closest to where you live. Shorter distance = faster responses when you chat with your agent. If you're in India, pick Bangalore. If you're in the US, pick New York or San Francisco. If you're in Europe, pick Amsterdam or Frankfurt.

### Authentication method

Choose **SSH Key**. **Not password.**

A password is like a combination lock on a gym locker. A million bots on the internet spin combinations all day long. Eventually, they guess yours. An SSH key is like a physical key to a deadbolt. No key, no entry. Nobody can guess one.

### Generate your SSH key (on your Mac)

Open Terminal on your Mac (Applications → Utilities → Terminal). Type:

```
ssh-keygen -t ed25519
```

Press Enter three times (default location, no passphrase, confirm). This creates two files:

- A **private key** — stays on your Mac forever. Never share it.
- A **public key** — you give this to DigitalOcean and anyone else you want to connect to.

### Copy your public key

```
cat ~/.ssh/id_ed25519.pub
```

(If that file doesn't exist because an older ssh-keygen made `id_rsa.pub`, use that path instead.)

Copy everything that prints out — it's one long line starting with `ssh-ed25519` or `ssh-rsa`. Back in DigitalOcean's droplet setup page, click **New SSH Key**, paste the whole line, and give it a name like `my-laptop`.

### Hostname

Pick a short lowercase name. Letters and hyphens only. No spaces. No underscores (DigitalOcean rejects them). No special characters. Something like `bookagent` or `scribe-vps` works.

### Click "Create Droplet"

Wait about sixty seconds. A green dot appears. Under the droplet name, you'll see an IP address — four numbers separated by dots, like `168.144.67.170`. **Copy it and paste it into your notes.** This is the street address of your rented office.

## Take a snapshot immediately

Snapshots are backups. DigitalOcean charges a small amount ($1.50/month) to keep them.

In the droplet sidebar, click **Snapshots**. Call this one `clean-install`. Before every big change you make later in this guide, take a new snapshot. If something goes wrong, you can restore in minutes instead of starting over.

Pay the $1.50. It will save you hours, one day.

## Confirm it worked

- [ ] Your DigitalOcean dashboard shows one droplet with a green dot.
- [ ] You have the droplet's IP address written in your notes.
- [ ] You have a snapshot called `clean-install` listed.

If any of these are false, don't move on. Screenshot what you see, paste into Claude, ask what went wrong.

## The gotcha

**Hostnames with underscores fail silently.** DigitalOcean's web form accepts them but the droplet won't create. If the "Create Droplet" button does nothing when you click it, this is usually why.

## What's next

You have an office. It's sitting empty. Next we walk inside it.

[Step 2 — SSH into the VPS](02-ssh-into-vps.md)
