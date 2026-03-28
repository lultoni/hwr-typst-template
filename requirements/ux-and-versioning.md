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
