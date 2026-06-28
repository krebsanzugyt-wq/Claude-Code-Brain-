# Claude-Code-Brain

Eine **kostenoptimierte, wiederverwendbare Claude-Code-Umgebung**. Jede Datei ist so
gewählt, dass sie die Token-Kosten senkt — durch kleinen, stabilen Kontext, Auslagern
teurer Arbeit an günstige Modelle und Abschalten unnötiger Nebenaufrufe.

## Aufbau

```
.
├── CLAUDE.md                 # Kern-Memory, bewusst kurz & stabil (jede Session geladen)
├── LEARNINGS.md              # Langzeitgedächtnis, append-only (auto-geladen beim Start)
├── docs/
│   ├── cost-guide.md         # Kosten-Checkliste (bei Bedarf gelesen)
│   └── conventions.md        # Detailregeln (bei Bedarf gelesen)
├── .claude/
│   ├── settings.json         # Modell, Kosten-Flags, Permissions, SessionStart-/Stop-Hook
│   ├── agents/explorer.md    # Read-only Such-Subagent auf Haiku
│   ├── commands/cost-check.md# /cost-check Slash-Command
│   ├── commands/lernen.md    # /lernen — destilliert die Session in LEARNINGS.md
│   └── hooks/
│       ├── session-start.sh  # Statushinweis + lädt LEARNINGS.md, keine Modellaufrufe
│       └── session-end.sh    # Stop-Hook: erinnert 1× pro Session ans Festhalten
├── .mcp.json                 # Leeres MCP-Template (keine aktiven Server)
└── .gitignore
```

## Selbst-optimierendes Gedächtnis

Das Repo merkt sich Erkenntnisse über Sessions hinweg:

- **`LEARNINGS.md`** — append-only Langzeitgedächtnis. Der `SessionStart`-Hook lädt
  es automatisch in den Kontext, damit bekannte Fehler nicht wiederholt werden.
- **`Stop`-Hook** — erinnert einmal pro Session daran, neue Learnings festzuhalten
  (loop-sicher via Sentinel-Datei).
- **`/lernen`** — destilliert die laufende Session in saubere `LEARNINGS.md`-Einträge.

Kuratiert halten: Die Datei wird jede Session geladen, also nur nicht-offensichtliche
Learnings — keine Trivialitäten, keine Geheimnisse.

## Warum das Kosten spart

| Datei | Kostenwirkung |
|---|---|
| `CLAUDE.md` | Kurz & stabil → Prompt-Cache-Treffer, günstiger Input pro Turn |
| `docs/*.md` | Details werden **nicht** per `@import` dauerhaft geladen, nur bei Bedarf gelesen |
| `settings.json` → `env` | `DISABLE_NON_ESSENTIAL_MODEL_CALLS` & Co. sparen Nebenaufrufe |
| `settings.json` → `model` | Standard **Sonnet** statt Opus — gutes Preis-/Leistungsverhältnis |
| `agents/explorer.md` | Breite Suchen laufen auf **Haiku**, nicht im teuren Hauptkontext |
| `.mcp.json` (leer) | Keine aktiven MCP-Server → kein Tool-Kontext-Bloat pro Turn |
| `settings.json` → `permissions` | Read-only-Befehle erlaubt → weniger Genehmigungs-Roundtrips |

## Ein Repo oder mehrere?

**Empfehlung: ein zentrales Repo** plus User-Level-Config.

- **`~/.claude/`** — globale Regeln, die in *jedem* Projekt gelten. Einmal pflegen.
- **Dieses Repo** — zentrale Brain-/Template-Umgebung + Wissen + projektspezifische `.claude/`.
- **Neue Projekte** — einfach das `.claude/`-Verzeichnis hierher kopieren.

Mehrere Repos lohnen sich erst bei echten, getrennten Software-Projekten. Wissen/Config
**nicht** über viele Repos zersplittern — das bläht den Kontext auf und kostet mehr.

## Quickstart

1. Repo klonen, mit `claude` öffnen.
2. `CLAUDE.md` an dein Projekt anpassen — **kurz halten**.
3. Bei breiten Suchen den `explorer`-Subagent nutzen.
4. `/cost-check` ausführen, um die Session auf Kostenfresser zu prüfen.
5. MCP-Server nur in `.mcp.json` aktivieren, wenn wirklich gebraucht.
