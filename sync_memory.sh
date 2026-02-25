#!/bin/bash
# Jarvis Auto-Sync Script 🦾
WORKSPACE_DIR="/Users/devtar/.openclaw/workspace"
cd $WORKSPACE_DIR

# Check for changes
if [[ -n $(git status -s) ]]; then
  echo "📦 Changes detected, syncing memory..."
  git add .
  git commit -m "🧠 Auto-sync memory: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  echo "✅ Sync complete!"
else
  echo "💤 No changes to sync."
fi
