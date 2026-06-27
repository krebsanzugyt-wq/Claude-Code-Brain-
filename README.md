# Claude-Code-Brain 🧠

Eine **selbst-optimierende Entwicklungsumgebung** für [Claude Code](https://claude.com/claude-code).
Das Repo gibt Claude ein **persistentes Gedächtnis**: Erkenntnisse aus jeder
Session werden festgehalten und beim nächsten Start automatisch wieder geladen —
Claude wiederholt bekannte Fehler nicht und wird mit der Zeit besser.

> **Warum nicht nur eine statische Regel-Datei?** Klassische KI-Assistenten
> (Copilot/Codeium) lesen zwar eine Instructions-Datei, lernen aber nicht von
> selbst dazu — man muss alles manuell pflegen. Claude Code hat ein echtes
> **Hook-System**. Damit wird das Laden der Learnings **vollautomatisch** und
> das Festhalten weitgehend automatisch.

---

## Wie der Loop funktioniert

```
┌─────────────────────────────────────────────────────────────┐
│  Sessionstart                                                 │
│  └─ SessionStart-Hook lädt LEARNINGS.md in den Kontext  ──┐   │
│                                                            │   │
│  Während der Arbeit                                        ▼   │
│  └─ Claude liest Learnings, vermeidet bekannte Fehler,        │
│     hängt neue Erkenntnisse SOFORT an LEARNINGS.md an         │
│                                                            │   │
│  Sessionende                                               │   │
│  └─ Stop-Hook erinnert einmalig: Learnings destillieren  ─┘   │
│     (oder manuell via /lernen)                                │
└─────────────────────────────────────────────────────────────┘
```

## Dateien

| Datei | Rolle |
|-------|-------|
| `CLAUDE.md` | Das **Brain**: statisches Regelwerk (Stack, Architektur, Naming, Testing) + Selbstoptimierungs-Protokoll. Claude Code liest es automatisch zu jedem Sessionstart. |
| `LEARNINGS.md` | Das **Gedächtnis**: append-only Log mit Erkenntnissen aus früheren Sessions. |
| `.claude/settings.json` | Registriert die Hooks. |
| `.claude/hooks/session-start.sh` | Lädt `LEARNINGS.md` automatisch in den Kontext; scaffoldet die Datei bei Bedarf. |
| `.claude/hooks/session-end.sh` | Stop-Hook: erinnert **einmal** pro Session ans Festhalten der Learnings (loop-sicher). |
| `.claude/commands/lernen.md` | Slash-Command `/lernen`: destilliert die Session manuell in `LEARNINGS.md`. |

## Erste Schritte

1. **Brain ausfüllen:** Ersetze die `<!-- TODO -->`-Platzhalter in `CLAUDE.md`
   durch deine echten Vorgaben (Tech-Stack & Versionen, Architektur, Naming,
   Testing). Je konkreter, desto bessere Vorschläge.
2. **Loslegen:** Starte eine Claude-Code-Session in diesem Repo. Der
   SessionStart-Hook lädt das Gedächtnis automatisch — du musst nichts tun.
3. **Lernen lassen:** Arbeite normal. Claude hängt nicht-offensichtliche
   Erkenntnisse selbst an `LEARNINGS.md` an. Am Sessionende erinnert der
   Stop-Hook ans Destillieren; du kannst auch jederzeit `/lernen` aufrufen.

## Hooks an-/abschalten

- **Abschalten:** Entferne den jeweiligen Eintrag aus `.claude/settings.json`
  (`SessionStart` und/oder `Stop`).
- **Nur den End-Nudge abschalten:** Entferne den `Stop`-Block. Das automatische
  Laden via `SessionStart` bleibt davon unberührt.
- Der Stop-Hook nudgt **maximal einmal pro Session** (Loop-Schutz über
  `stop_hook_active` und eine laufzeitlokale Sentinel-Datei
  `.claude/.session-nudged`, die per `.gitignore` ausgeschlossen ist).

## Verifikation der Hooks (optional)

```bash
# SessionStart: gibt JSON mit additionalContext aus, scaffoldet LEARNINGS.md
bash .claude/hooks/session-start.sh </dev/null | jq .

# Stop: Loop-Guard greift -> exit 0, keine Ausgabe
echo '{"stop_hook_active":true}' | bash .claude/hooks/session-end.sh

# Stop: erster Aufruf -> einmaliger block-Nudge als JSON
rm -f .claude/.session-nudged
echo '{"stop_hook_active":false}' | bash .claude/hooks/session-end.sh | jq .
```

## Hinweise

- Schreibe **keine Geheimnisse** (Tokens, Passwörter) in `CLAUDE.md` oder
  `LEARNINGS.md` — diese Dateien werden eingecheckt.
- `LEARNINGS.md` ist append-only: alte Einträge nicht löschen, höchstens als
  überholt markieren.
