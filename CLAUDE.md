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

## Workflows
- Angebots-/Preissuche: `/deal <Produkt>` — Quellen & Details in `docs/deal-guide.md`,
  Ergebnisse landen in `deals/`.

## Gedächtnis & Selbstoptimierung
- `LEARNINGS.md` ist das Langzeitgedächtnis (append-only). Der `SessionStart`-Hook
  lädt es automatisch — also **kurz & kuratiert halten**, jeder Eintrag kostet Tokens.
- Nicht-offensichtliche Erkenntnis entdeckt? Sofort als Eintrag oben in `LEARNINGS.md`.
- Am Sessionende erinnert der `Stop`-Hook ans Festhalten; `/lernen` destilliert die Session.

## Details — bei Bedarf lesen (NICHT per @import, damit der Basiskontext klein bleibt)
- Konventionen: `docs/conventions.md`
- Kosten-Leitfaden: `docs/cost-guide.md`
- Angebots-Leitfaden: `docs/deal-guide.md`
