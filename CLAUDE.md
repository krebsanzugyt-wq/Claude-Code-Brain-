# Claude-Code-Brain — Memory

Kostenoptimierte, wiederverwendbare Claude-Code-Umgebung.
**Diese Datei bewusst kurz und stabil halten** — sie wird in *jeder* Session geladen.
Stabil = Prompt-Cache-Treffer = günstiger pro Turn.

## Zweck
Zentrale Brain-/Template-Umgebung. Globale Regeln gehören nach `~/.claude/`,
Projektspezifisches in dieses `.claude/`. Bei neuen Projekten nur `.claude/` kopieren.

## Kostenregeln (für Claude)
- Breite Suchen / Fan-out an den `explorer`-Subagent (Haiku) auslagern, nicht den
  Hauptkontext fluten.
- Große Dateien gezielt mit `offset`/`limit` lesen — nie ganze Dateien ohne Grund.
- Lange Session → `/compact`. Themenwechsel → `/clear`.
- Antworten knapp halten; keinen Output produzieren, der nicht gebraucht wird.

## Details — bei Bedarf lesen (NICHT per @import, damit der Basiskontext klein bleibt)
- Konventionen: `docs/conventions.md`
- Kosten-Leitfaden: `docs/cost-guide.md`
