#!/usr/bin/env bash
# Optional: close the public SSH door. Only accept connections over Tailscale.
# Wraps the ufw commands in docs/06-lock-with-tailscale.md.
#
# DO NOT RUN THIS until you have confirmed you can SSH in via the Tailscale IP.
# If Tailscale is broken and you lock the public door, you lose access to
# your server. You can recover from a DigitalOcean console, but it is a pain.
#
# Confirmation required: pass --i-have-tested-tailscale to run.

set -euo pipefail

if [[ "${1:-}" != "--i-have-tested-tailscale" ]]; then
  cat <<EOF
Refusing to run without confirmation.

Before running this script, SSH to your VPS using the Tailscale IP (100.x.x.x)
from a fresh terminal. If that works, come back and run:

  bash firewall-lockdown.sh --i-have-tested-tailscale

If it doesn't work, fix Tailscale first. See docs/06-lock-with-tailscale.md.
EOF
  exit 1
fi

echo "Allowing all traffic on the Tailscale interface..."
ufw allow in on tailscale0

echo "Denying public SSH (port 22)..."
ufw deny 22/tcp

echo "Enabling the firewall..."
ufw --force enable

echo
echo "Firewall is live. Current rules:"
ufw status

echo
echo "Done. The public door is closed."
echo "From another terminal, test that SSH over the public IP times out,"
echo "and SSH over the Tailscale IP still connects."
