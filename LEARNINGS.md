# LEARNINGS — Bekannte Fehlerquellen & Erkenntnisse 🧠

Das **Langzeitgedächtnis** dieses Repos. Wird beim Sessionstart automatisch in
Claudes Kontext geladen und nach jeder Session ergänzt (siehe Abschnitt
*Gedächtnis & Selbstoptimierung* in `CLAUDE.md`).

**Append-only:** Neue Einträge oben anhängen, alte nicht löschen (höchstens als
überholt markieren). **Kurz halten** — diese Datei wird in *jeder* Session
geladen, also kostet jeder Eintrag Tokens. Nur nicht-offensichtliche Learnings.

```
### [JJJJ-MM-TT] Kurztitel
- **Problem:** Was ging schief / was war unklar?
- **Ursache:** Warum?
- **Lösung / Regel ab jetzt:** Konkrete Handlungsanweisung für die Zukunft.
- **Tags:** #bereich
```

---

<!-- Neue Einträge ab hier (neueste oben). -->

### [2026-06-28] deals/ ist für ALLE Recherchen, nicht nur Preis-Deals
- **Problem:** Unklar, wohin ein Produkt-Feature-Vergleich (Garmin Forerunner) ohne
  Preisbezug gehört — es gibt keinen `vergleiche/`-Ordner.
- **Ursache:** `deals/` heißt nach Preis-Deals, ist aber laut Konvention die
  einheitliche Ablage für jegliche Recherche-Ergebnisse.
- **Lösung / Regel ab jetzt:** Recherche-/Vergleichsdokumente nach `deals/` legen,
  Namensschema `<slug>-<YYYY-MM-DD>.md`. Bei reinen Spec-Vergleichen ohne Live-Daten
  oben klaren Vorbehalt setzen (Wissensstand statt Live, vor Kauf prüfen).
- **Tags:** #konventionen #deals

### [2026-06-28] Stop-Hook-Sentinel muss in .gitignore
- **Problem:** Nach jeder Session taucht `.claude/.session-nudged` als untracked
  Datei auf und der git-check-Hook mahnt zum Committen.
- **Ursache:** Der Stop-Hook (`session-end.sh`) legt diese Sentinel-Datei zur
  Loop-Vermeidung an — sie ist rein session-lokal, gehört aber nicht ins Repo.
- **Lösung / Regel ab jetzt:** `.claude/.session-nudged` ist in `.gitignore`.
  Beim Hinzufügen weiterer runtime-Sentinels diese ebenfalls ignorieren.
- **Tags:** #hooks #git

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
