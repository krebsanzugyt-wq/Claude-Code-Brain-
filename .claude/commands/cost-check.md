---
description: Prüft die aktuelle Session auf Kostenfresser und gibt Spar-Tipps.
---

Analysiere die bisherige Session auf Token-Kostenfresser und gib konkrete,
umsetzbare Tipps. Prüfe insbesondere:

1. Wurden große Dateien komplett gelesen, wo `offset`/`limit` gereicht hätte?
2. Hätte eine breite Suche an den `explorer`-Subagent (Haiku) ausgelagert werden sollen?
3. Ist der Kontext lang genug, dass sich `/compact` lohnt? Oder `/clear` bei Themenwechsel?
4. Sind unnötige MCP-Server/Tools aktiv, die in jedem Turn Kontext kosten?
5. Wird ein zu teures Modell für eine einfache Aufgabe genutzt?

Gib das Ergebnis als kurze, priorisierte Liste aus. Keine langen Erklärungen.
