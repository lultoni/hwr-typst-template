# UX — Usability & Developer Experience Requirements
> Quelle: Projektziele (User-defined priorities)

## Prio 1: Usability — Fokus aufs Schreiben

Das Template muss so designed sein, dass Studierende sich **voll auf den Inhalt konzentrieren können** — kein Formatierungsaufwand, keine Template-Kenntnisse nötig.

| ID | Anforderung | Priorität | Begründung |
|---|---|---|---|
| UX-01 | `main.typ` ist die einzige Datei die User anfassen | KRITISCH | User soll nur Metadaten + Inhalt eintragen |
| UX-02 | Alle Pflichtfelder haben sprechende Fehler wenn leer | Hoch | Verhindert falsches Abgeben |
| UX-03 | Optionale Felder mit sinnvollen Defaults | Hoch | Keine Konfiguration nötig für Standardfall |
| UX-04 | Einzeilige Aktivierung aller Features (z.B. `confidential: true`) | Hoch | Kein Herumsuchen in Template-Dateien |
| UX-05 | Abkürzungen automatisch verwaltet (`#abk("KI")` → first-use expandiert) | Hoch | Kein manuelles Pflegen des Abkürzungsverzeichnisses |
| UX-06 | Verzeichnisse (Abb., Tab.) generieren sich automatisch — inkl. Bedingungen | Hoch | Kein manuelles Erstellen |
| UX-07 | Seitennummerierung (röm. → arab.) vollautomatisch | KRITISCH | Häufigste Fehlerquelle |
| UX-08 | KI-Verzeichnis als einfache Liste in `main.typ`, Template rendert die Tabelle | Mittel | Formatierungsaufwand abnehmen |
| UX-09 | Beispiel-`main.typ` zeigt alle Features mit Kommentaren | Hoch | Lernkurve minimieren |
| UX-10 | README erklärt Nutzung vollständig — kein externes Wissen nötig | Hoch | Siehe UX-README |

## README-Anforderungen

| ID | Anforderung |
|---|---|
| UX-README-01 | Vollständige Nutzungsanleitung (Quick Start bis Advanced) |
| UX-README-02 | Alle Template-Parameter dokumentiert (Name, Typ, Pflicht?, Default, Beschreibung) |
| UX-README-03 | "Good to know"-Sektion: HWR-Spezifika, Abkürzungsregeln, Zitierstil-Wahl |
| UX-README-04 | Häufige Fehler und Lösungen |
| UX-README-05 | Immer aktuell — nach Feature-Änderungen sofort mitpflegen |

## Versionierung

| ID | Anforderung |
|---|---|
| VER-01 | Semantic Versioning: `MAJOR.MINOR.PATCH` |
| VER-02 | **PATCH** (0.1.x): Bugfixes, Typos, kleine Korrekturen — kein Breaking Change |
| VER-03 | **MINOR** (0.x.0): Neue Features, neue Dokumenttypen, neue Parameter (rückwärtskompatibel) |
| VER-04 | **MAJOR** (x.0.0): Breaking Changes in der API (Parameter umbenannt/entfernt, Verhalten geändert) |
| VER-05 | Version in `typst.toml` ist die einzige Source of Truth |
| VER-06 | Changelog-Eintrag bei jedem MINOR/MAJOR Bump |
| VER-07 | Vor v1.0.0: API darf sich öfter ändern; ab v1.0.0: Breaking Changes nur in MAJOR |
| VER-08 | Release-Trigger: manuell nach Review, nicht automatisch |

**Typst-spezifisch:** Typst Universe verwendet `typst.toml` `version`-Feld — das muss bei jedem Publish aktuell sein.

## v1.0 Scope — Was rein, was nicht

### IN v1.0 (Pflicht für Release)

| Feature | Anforderungs-IDs |
|---|---|
| Alle doc-type-Werte: ptb-1/2/3, hausarbeit, studienarbeit, bachelorarbeit | DOC-* |
| Strukturreihenfolge (Sperrvermerk → Deckblatt → TOC → … → Erklärung) | STR-01–12 |
| Seitennummerierung (none → Römisch → Arabisch) | FMT-30–35 |
| Formatierung (Times New Roman, Margins, 1.5-Spacing, Blocksatz) | FMT-01–23 |
| Ehrenwörtliche Erklärung inkl. KI-Klausel (2025) | CNT-01–05 |
| Sperrvermerk (drei Stufen: none / true / chapters) | CNT-20–24, STR-01 |
| Abkürzungsverzeichnis (automatisch via `#abk()`) | STR-40–45 |
| Abbildungs-/Tabellenverzeichnis (nur wenn ≥5) | STR-05–06 |
| KI-Verzeichnis als Tabelle (automatisch wenn ai-tools nicht leer) | CNT-10–13, STR-12 |
| Bibliographie (APA default, Harvard für EN, custom CSL) | CIT-01–03 |
| Anhang (hybrid: include / image / inline, automatisches Verzeichnis) | CNT-50–54 |
| Lokalisierung DE + EN (via linguify) | IMPL (Package-Entscheidung) |
| Abstract (optional, eigene Seite) | API §8b |
| Glossar (via glossarium, nur wenn befüllt) | CNT-60–62, STR-11 |
| Heading-Tiefe konfigurierbar (1–4, default 4) | STR-21 |
| Datum lokalisiert (auto oder manuell) | API §10 |
| Vollständige Beispiel-main.typ mit Kommentaren | UX-09 |

### OUT of v1.0 (Für spätere Versionen)

| Feature | Begründung | Kandidat für |
|---|---|---|
| `scripts/abk-scan.py` | Optionales Komfort-Tool, Template funktioniert ohne es | v1.1 |
| wordometer (Wortzählung) | Nice-to-have, kein HWR-Pflichtfeature | v1.1 |
| Ungesperrte Version PDF automatisch erzeugen (CNT-24) | Aufgabe des Users, nicht des Templates | Out-of-scope |
| Word-Export | Pandoc-basiert, Out-of-Scope laut STR | Out-of-scope |

**Faustregel:** v1.0 = alles was für eine konforme HWR-Abgabe technisch nötig ist. Komfort-Tools kommen danach.
