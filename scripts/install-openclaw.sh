#!/usr/bin/env bash
# Optional: install OpenClaw on an Ubuntu VPS.
# Assumes Node.js is already installed (run install-node.sh first).
# Wraps the manual command in docs/03-install-software.md.

set -euo pipefail

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is not installed. Run install-node.sh first."
  exit 1
fi

echo "Fetching and running the OpenClaw installer..."
curl -fsSL https://openclaw.ai/install.sh | bash

echo "Verifying OpenClaw install..."
openclaw --version

echo
echo "Done. OpenClaw is installed."
echo "Next: create ~/.openclaw/openclaw.json — follow docs/04-connect-claude-api.md."
