#!/usr/bin/env bash
#
# SessionStart-Hook für das Claude-Code-Brain.
# Zwei Aufgaben, ohne Modellaufrufe:
#   1. Kompakter Repo-Status (Branch + geänderte Dateien) als Hinweis.
#   2. Lädt das Langzeitgedächtnis (LEARNINGS.md) in den Session-Kontext, damit
#      Claude ab dem ersten Prompt alle bisherigen Erkenntnisse kennt.
# Ausgabe als JSON mit hookSpecificOutput.additionalContext.
# Siehe https://docs.claude.com/en/docs/claude-code/hooks
#
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LEARNINGS="$ROOT/LEARNINGS.md"

branch="$(git symbolic-ref --short -q HEAD || git rev-parse --short HEAD 2>/dev/null || echo '?')"
changes="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"

# Gedächtnis-Datei scaffolden, falls sie fehlt.
if [[ ! -f "$LEARNINGS" ]]; then
  cat > "$LEARNINGS" <<'EOF'
# LEARNINGS — Bekannte Fehlerquellen & Erkenntnisse 🧠

Append-only Langzeitgedächtnis. Format pro Eintrag:

### [JJJJ-MM-TT] Kurztitel
- **Problem:** …
- **Ursache:** …
- **Lösung / Regel ab jetzt:** …
- **Tags:** #bereich

---
EOF
fi

# Sentinel des Stop-Hooks für die neue Session zurücksetzen (frischer Start).
rm -f "$ROOT/.claude/.session-nudged" 2>/dev/null || true

LEARNINGS_CONTENT="$(cat "$LEARNINGS")"

CONTEXT="🧠 Claude-Code-Brain | Branch: ${branch} | Geänderte Dateien: ${changes}
Tipp: Breite Suchen an den 'explorer'-Subagent (Haiku) auslagern. /cost-check für Spar-Check.

Lies die folgenden gespeicherten Learnings, bevor du mit der Arbeit beginnst,
und vermeide bekannte Fehler. Halte neue Erkenntnisse gemäß dem Abschnitt
'Gedächtnis & Selbstoptimierung' in CLAUDE.md fest (oder via /lernen).

===== LEARNINGS.md =====
${LEARNINGS_CONTENT}
========================"

# JSON sicher erzeugen (jq falls vorhanden, sonst Python-Fallback).
if command -v jq >/dev/null 2>&1; then
  jq -n --arg ctx "$CONTEXT" \
    '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'
else
  CONTEXT="$CONTEXT" python3 - <<'PY'
import json, os
print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": os.environ["CONTEXT"],
    }
}))
PY
fi
