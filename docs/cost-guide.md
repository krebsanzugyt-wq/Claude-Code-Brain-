# Kosten-Leitfaden für Claude Code

Praktische Checkliste, um Token-Kosten niedrig zu halten. Wird **bei Bedarf** gelesen
(nicht dauerhaft in den Kontext geladen).

## 1. Prompt-Caching verstehen (größter Hebel)
- Claude cached den stabilen Anfang des Kontexts (System-Prompt, CLAUDE.md, Tools).
- **Stabilität spart Geld:** Cache-Treffer kosten einen Bruchteil von frischen Input-Tokens.
- Deshalb: `CLAUDE.md` kurz und selten ändern. Keine volatilen Daten (Timestamps,
  Zähler) in dauerhaft geladene Dateien schreiben.

## 2. Kontext schlank halten
- Große Dateien mit `offset`/`limit` lesen statt komplett.
- `Grep`/`Glob` statt ganze Verzeichnisse einlesen.
- `/compact` bei langen Sessions (fasst zusammen, behält Faden).
- `/clear` bei echtem Themenwechsel (startet frisch, voller Cache-Reset).

## 3. Fan-out an billige Modelle auslagern
- Breite Suchen über viele Dateien → `explorer`-Subagent (läuft auf **Haiku**).
- Der Subagent liest die Dateien, der teure Hauptkontext bekommt nur das Ergebnis.

## 4. Modellwahl nach Aufgabe
- **Haiku**: Suche, Klassifikation, einfache Edits, Boilerplate.
- **Sonnet**: Standard-Entwicklung, gutes Preis-/Leistungsverhältnis (Default hier).
- **Opus**: nur für wirklich harte Architektur-/Reasoning-Aufgaben.

## 5. Nebenaufrufe abschalten (siehe `.claude/settings.json` → `env`)
- `DISABLE_NON_ESSENTIAL_MODEL_CALLS=1` — keine Titel-/Flavor-Generierung.
- `DISABLE_TELEMETRY=1`, `DISABLE_ERROR_REPORTING=1` — kein unnötiger Traffic.
- Optional `CLAUDE_CODE_MAX_OUTPUT_TOKENS=<n>` — Output-Obergrenze (kann lange
  Antworten abschneiden — bewusst setzen).

## 6. Tool-/MCP-Kontext minimal halten
- Jeder aktive MCP-Server fügt Tool-Definitionen zum Kontext hinzu → kostet Token in
  *jedem* Turn. Nur Server aktivieren, die du wirklich brauchst (`.mcp.json`).

## Schnell-Check
- Ist CLAUDE.md unter ~40 Zeilen? ✅
- Lade ich Details nur bei Bedarf statt per @import? ✅
- Nutze ich `explorer` für breite Suchen? ✅
- Sind unnötige MCP-Server deaktiviert? ✅
