#!/usr/bin/env bash
#
# Stop-Hook für das Claude-Code-Brain.
# Erinnert Claude EINMAL pro Session daran, die Erkenntnisse der Session in
# LEARNINGS.md festzuhalten, bevor er stoppt.
#
# Loop-Schutz: Wir respektieren `stop_hook_active` aus der Hook-Eingabe und
# setzen zusätzlich eine Sentinel-Datei, damit pro Session nur EIN Nudge erfolgt.
#
# Deaktivieren: diesen Hook-Eintrag aus .claude/settings.json entfernen.
#
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SENTINEL="$ROOT/.claude/.session-nudged"

INPUT="$(cat 2>/dev/null || true)"

# Wenn dieser Stop bereits durch einen vorherigen Stop-Hook ausgelöst wurde,
# nicht erneut blocken -> Endlosschleife vermeiden.
if printf '%s' "$INPUT" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  exit 0
fi

# Pro Session nur einmal nudgen.
if [[ -f "$SENTINEL" ]]; then
  exit 0
fi
touch "$SENTINEL"

REASON="🧠 Bevor du stoppst: Halte die wichtigsten neuen Erkenntnisse dieser \
Session in LEARNINGS.md fest (Format siehe Dateikopf), falls noch nicht \
geschehen. Nur projektspezifische, nicht-offensichtliche Learnings — keine \
Trivialitäten, keine Geheimnisse. Wenn es nichts Nennenswertes gibt, antworte \
kurz, dass keine neuen Learnings anfielen, und stoppe."

if command -v jq >/dev/null 2>&1; then
  jq -n --arg r "$REASON" '{decision: "block", reason: $r}'
else
  REASON="$REASON" python3 - <<'PY'
import json, os
print(json.dumps({"decision": "block", "reason": os.environ["REASON"]}))
PY
fi
