# LEARNINGS — Bekannte Fehlerquellen & Erkenntnisse 🧠

Das **Langzeitgedächtnis** dieses Repos. Wird beim Sessionstart automatisch in
Claudes Kontext geladen und nach jeder Session ergänzt (siehe
`Selbstoptimierungs-Protokoll` in `CLAUDE.md`).

**Append-only:** Neue Einträge oben anhängen, alte nicht löschen (höchstens als
überholt markieren). Format pro Eintrag:

```
### [JJJJ-MM-TT] Kurztitel
- **Problem:** Was ging schief / was war unklar?
- **Ursache:** Warum?
- **Lösung / Regel ab jetzt:** Konkrete Handlungsanweisung für die Zukunft.
- **Tags:** #bereich
```

---

<!-- Neue Einträge ab hier (neueste oben). Beispiel als Vorlage: -->

### [2026-06-27] Hook-Skripte brauchen das Executable-Bit
- **Problem:** Frisch via Write erstellte Hook-Skripte werden von Claude Code
  nicht ausgeführt.
- **Ursache:** Über die Write-/Edit-Tools angelegte Dateien haben kein
  Executable-Bit; `command`-Hooks erwarten ausführbare Skripte.
- **Lösung / Regel ab jetzt:** Nach dem Anlegen/Ändern eines Hook-Skripts immer
  `chmod +x .claude/hooks/<datei>.sh` ausführen und das Bit mit committen.
- **Tags:** #hooks #setup

### [2026-06-27] Brain-Setup initialisiert
- **Problem:** Frische Umgebung hatte keinen Mechanismus, um Erkenntnisse über
  Sessions hinweg zu behalten.
- **Ursache:** Kein persistentes Gedächtnis + kein Auto-Lade-/Festhalte-Loop.
- **Lösung / Regel ab jetzt:** Learnings hierher schreiben; `SessionStart`-Hook
  lädt sie automatisch, `Stop`-Hook erinnert ans Festhalten.
- **Tags:** #setup #meta
