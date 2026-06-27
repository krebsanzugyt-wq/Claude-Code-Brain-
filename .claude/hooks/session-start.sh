#!/usr/bin/env bash
# Leichter SessionStart-Hook: nur kompakter Repo-Status, keine Modellaufrufe.
set -euo pipefail

branch="$(git symbolic-ref --short -q HEAD || git rev-parse --short HEAD 2>/dev/null || echo '?')"
changes="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"

echo "🧠 Claude-Code-Brain | Branch: ${branch} | Geänderte Dateien: ${changes}"
echo "Tipp: Breite Suchen an den 'explorer'-Subagent (Haiku) auslagern. /cost-check für Spar-Check."
