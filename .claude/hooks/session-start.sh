#!/usr/bin/env bash
#
# SessionStart-Hook für das Claude-Code-Brain.
# Lädt das Langzeitgedächtnis (LEARNINGS.md) automatisch in den Session-Kontext,
# damit Claude ab dem ersten Prompt alle bisherigen Erkenntnisse kennt.
#
# Ausgabe: JSON mit hookSpecificOutput.additionalContext (von Claude Code in den
# Kontext injiziert). Siehe https://docs.claude.com/en/docs/claude-code/hooks
#
set -euo pipefail

# Repo-Wurzel ermitteln (Hook läuft i.d.R. von dort, aber wir sind robust).
ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
LEARNINGS="$ROOT/LEARNINGS.md"

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

CONTEXT="🧠 Claude-Code-Brain aktiv. Lies die folgenden gespeicherten Learnings,
bevor du mit der Arbeit beginnst, und vermeide bekannte Fehler. Halte neue
Erkenntnisse gemäß dem Selbstoptimierungs-Protokoll in CLAUDE.md fest.

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
