#!/usr/bin/env bash
# Optional: install Node.js on an Ubuntu VPS.
# This wraps the manual commands in docs/03-install-software.md.
# Running this the first time? Follow the docs instead — you'll learn more.

set -euo pipefail

echo "Updating system packages..."
apt update && apt upgrade -y

echo "Installing Node.js (the runtime OpenClaw needs)..."
curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
apt install -y nodejs

echo "Verifying Node.js install..."
node --version

echo
echo "Done. Node.js is installed."
echo "Next: run install-openclaw.sh or follow docs/03-install-software.md."
