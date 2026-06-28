# Konventionen

Detailregeln, ausgelagert aus `CLAUDE.md`, damit der Basiskontext klein bleibt.

## Git
- Entwicklung auf Feature-Branches, nie direkt auf dem Default-Branch.
- Commit-Messages: knapp, im Imperativ, erklären *warum* (nicht nur *was*).
- Erst committen/pushen, wenn ausdrücklich gewünscht.

## Stil
- Antworten und Doku knapp und stichpunktartig.
- Bestehende Muster und Utilities wiederverwenden, statt Neues zu erfinden.
- Code soll sich wie der umgebende Code lesen (Naming, Idiome, Kommentar-Dichte).

## Dateien & Struktur
- Globale, projektübergreifende Regeln → `~/.claude/`.
- Projektspezifisches → `.claude/` in diesem Repo.
- Temporäre Dateien nicht committen (siehe `.gitignore`).

## Subagents & Commands
- `explorer` (Haiku): read-only Suche/Erkundung — für Fan-out nutzen.
- `/cost-check`: prüft die Session auf Kostenfresser.
