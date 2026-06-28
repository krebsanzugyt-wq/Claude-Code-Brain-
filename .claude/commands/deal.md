---
description: Sucht das günstigste Angebot für ein Produkt über mehrere Quellen und speichert den Preisvergleich.
argument-hint: <Produktname>
---

Finde das **günstigste verfügbare Angebot** für: **$ARGUMENTS**

Vorgehen:

1. **Quellen wählen** je nach Produktkategorie — siehe `docs/deal-guide.md` für die
   vertrauenswürdigen Quellen pro Bereich (Elektronik, Alltag/Haushalt, Mode, gemischt).

2. **Parallel recherchieren:** Starte mehrere `price-hunter`-Subagents IN PARALLEL
   (ein Aufruf, mehrere Tool-Calls) — einen pro Quelle/Shop. Jeder liefert: Shop,
   Preis, Versandkosten, Verfügbarkeit, direkter Link, Stand (Datum).

3. **Aggregieren & sortieren:** Fasse die Treffer zusammen, **günstigstes zuerst**.
   Rechne Versand mit ein, wenn bekannt. Dubletten/unplausible Preise aussortieren.

4. **Ausgeben** als Markdown-Tabelle:
   `| Rang | Shop | Preis | Versand | Verfügbarkeit | Link | Stand |`
   Darüber eine Zeile **Bestes Angebot:** Shop – Preis – Link.

5. **Speichern:** Lege die Recherche unter `deals/<slug>-<YYYY-MM-DD>.md` ab
   (Vorlage: `deals/_template.md`). `<slug>` = Produktname klein, mit Bindestrichen.

Wichtig:
- Jeden Preis mit **Quelllink und Datum** belegen — keine erfundenen Preise.
- Wenn `WebSearch`/`WebFetch` nicht verfügbar sind, liegt es an der Netzwerk-Policy
  dieser Umgebung — weise darauf hin statt zu raten.
- Preise sind flüchtig: kurz darauf hinweisen, dass der Nutzer vor Kauf prüfen soll.
