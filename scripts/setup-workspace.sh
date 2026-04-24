#!/usr/bin/env bash
# Optional: create the folder structure the writer agent expects.
# Wraps the mkdir commands in docs/10-build-the-workspace.md.
#
# Run this ONLY on your VPS. It creates folders in ~/.openclaw/.
# If you also want the team setup, pass --team as an argument.

set -euo pipefail

TEAM_MODE=false
for arg in "$@"; do
  if [ "$arg" = "--team" ]; then TEAM_MODE=true; fi
done

echo "Creating writer agent workspace..."
mkdir -p ~/.openclaw/workspace/book/chapters
mkdir -p ~/.openclaw/workspace/book/characters
mkdir -p ~/.openclaw/workspace/book/research
mkdir -p ~/.openclaw/workspace/book/drafts

if [ "$TEAM_MODE" = true ]; then
  echo "Creating team workspaces (researcher and fact-checker)..."
  mkdir -p ~/.openclaw/workspace-researcher
  mkdir -p ~/.openclaw/workspace-factchecker

  echo "Setting up shared book folder with symlinks..."
  if [ ! -d ~/shared-book ]; then
    mv ~/.openclaw/workspace/book ~/shared-book
    ln -s ~/shared-book ~/.openclaw/workspace/book
  fi
  ln -sf ~/shared-book ~/.openclaw/workspace-researcher/book
  ln -sf ~/shared-book ~/.openclaw/workspace-factchecker/book
fi

echo
echo "Done. Workspace is set up."
if [ "$TEAM_MODE" = true ]; then
  echo "Team mode: researcher and fact-checker workspaces are linked to the shared book folder."
fi
echo "Next: copy SOUL.md, HEARTBEAT.md, template.md, continuity.md, plan.md into the workspace."
