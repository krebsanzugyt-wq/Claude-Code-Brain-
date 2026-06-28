---
description: Destilliert die aktuelle Session in saubere LEARNINGS.md-Einträge
---

Fasse die aktuelle Session zusammen und aktualisiere das Langzeitgedächtnis.

Vorgehen:

1. Gehe die bisherige Session durch und identifiziere **nicht-offensichtliche**
   Erkenntnisse: projektspezifische Gotchas, korrigierte Fehlannahmen,
   Build-/Test-Eigenheiten, API-Quirks, neue Konventionen.
2. Lass Triviales, Einmaliges und Geheimnisse (Tokens, Passwörter) weg.
3. Hänge für jede Erkenntnis **oben** in `LEARNINGS.md` einen Eintrag in genau
   diesem Format an (Datum = heute):

   ```
   ### [JJJJ-MM-TT] Kurztitel
   - **Problem:** …
   - **Ursache:** …
   - **Lösung / Regel ab jetzt:** …
   - **Tags:** #bereich
   ```

4. Falls eine Erkenntnis eine Dauerregel ist (Stack, Naming, Architektur,
   Testing), übertrage sie zusätzlich in den passenden Abschnitt von `CLAUDE.md`.
5. Wenn es nichts Nennenswertes gibt, sag das klar und ändere nichts.

$ARGUMENTS
