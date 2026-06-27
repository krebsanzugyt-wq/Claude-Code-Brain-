# Claude-Code-Brain 🧠

Dies ist die zentrale Regel- und Gedächtnisdatei für dieses Projekt. Claude Code
liest sie **automatisch zu Beginn jeder Session**. Halte sie aktuell — sie ist
die "Konfiguration", die bestimmt, wie gut Claude in diesem Repo arbeitet.

> Fülle die `<!-- TODO -->`-Platzhalter mit deinen echten Projektvorgaben. Je
> konkreter, desto besser die Vorschläge.

---

## 1. Tech-Stack & Versionen

<!-- TODO: Sprachen, Frameworks und exakte Versionen eintragen. Verhindert,
     dass veralteter oder inkompatibler Code vorgeschlagen wird. -->

- Sprache: <!-- z.B. TypeScript 5.x -->
- Runtime: <!-- z.B. Node 20 LTS -->
- Frameworks: <!-- z.B. React 18, Express 4 -->
- Paketmanager: <!-- z.B. pnpm -->

## 2. Architektur-Prinzipien

<!-- TODO: Struktur- und Designvorgaben. -->

- <!-- z.B. Feature-basierte Ordnerstruktur statt nach Dateityp -->
- <!-- z.B. Keine Business-Logik in UI-Komponenten -->

## 3. Naming Conventions & Typisierung

<!-- TODO: Klare, überprüfbare Regeln. -->

- <!-- z.B. PascalCase für Komponenten/Typen, camelCase für Funktionen -->
- <!-- z.B. Keine `any`-Typen; bei Unsicherheit `unknown` + Narrowing -->

## 4. Testing-Regeln

<!-- TODO: Wie Tests geschrieben werden. -->

- <!-- z.B. Test-Framework, Coverage-Ziel, Fokus auf Verhalten statt Implementierung -->

---

## 5. Selbstoptimierungs-Protokoll (nicht löschen)

Dieses Repo ist ein **selbst-optimierendes Brain**. Halte dich an diesen Loop:

1. **Lesen:** Lies zu Beginn jeder Aufgabe `LEARNINGS.md`. Dort stehen
   Erkenntnisse aus früheren Sessions — wiederhole bekannte Fehler nicht.
2. **Festhalten (in-flow):** Sobald du eine **nicht-offensichtliche** Lösung,
   einen Stolperstein, eine Konvention oder eine Eigenheit dieses Projekts
   entdeckst, hänge **sofort** einen Eintrag an `LEARNINGS.md` an. Format und
   Beispiel stehen im Kopf dieser Datei.
3. **Destillieren (am Sessionende):** Wenn die Aufgabe fertig ist oder der
   Stop-Hook dich daran erinnert, fasse die wichtigsten neuen Erkenntnisse der
   Session zu sauberen `LEARNINGS.md`-Einträgen zusammen. Du kannst dafür auch
   den Slash-Command `/lernen` nutzen.

Was als Learning taugt: projektspezifische Gotchas, Build-/Test-Eigenheiten,
falsche Annahmen die korrigiert wurden, Performance-Fallen, API-Quirks.
Was **nicht** hineingehört: triviales Allgemeinwissen, einmalige Tippfehler,
Geheimnisse/Tokens.
