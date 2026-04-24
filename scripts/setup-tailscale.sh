#!/usr/bin/env bash
# Optional: install and start Tailscale on an Ubuntu VPS.
# Wraps the commands in docs/06-lock-with-tailscale.md.
#
# This will print an auth URL. Open it in your browser and sign in with
# the SAME account you use on your Mac's Tailscale app. If you use a
# different account, your Mac and VPS won't see each other.

set -euo pipefail

echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo "Bringing Tailscale up — watch for the auth URL..."
tailscale up

echo "Your new private (Tailscale) IP address is:"
tailscale ip -4

echo
echo "Done. Write the Tailscale IP down."
echo "From now on you SSH to that IP, not the public DigitalOcean IP."
echo
echo "Next: install Tailscale on your Mac, sign in with the SAME account,"
echo "then run firewall-lockdown.sh to close the public SSH door."
