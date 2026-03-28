# CNT — Inhaltliche Pflichtanforderungen

Diese Datei dokumentiert die inhaltlichen Pflichtbestandteile akademischer Arbeiten an der HWR Berlin (Januar 2025): was enthalten sein muss, in welcher Form, und mit welcher Rechtsgrundlage.

## Ehrenwörtliche Erklärung (§3.11)

| ID | Anforderung | Pflicht? | Quelle |
|---|---|---|---|
| CNT-01 | Erklärung selbstständiger Anfertigung | Ja | [HWR §3.11] |
| CNT-02 | KI-Klausel: Alle KI-genutzten Abschnitte kenntlich gemacht | Ja (NEU 2025) | [HWR §3.11] |
| CNT-03 | KI-Klausel: Verantwortungsübernahme für KI-Inhalte | Ja (NEU 2025) | [HWR §3.11] |
| CNT-04 | Originale Unterschrift | Ja | [HWR §3.11] |
| CNT-05 | Im Inhaltsverzeichnis mit Seitenangabe gelistet | Ja | [HWR §3.11] |

**Vollständiger Pflichttext:** Gespeichert in `l10n/de.ftl` (DE) und `l10n/en.ftl` (EN), §3.11-konform inkl. KI-Klausel. Singular/Plural-Varianten für Einzel- und Gruppenarbeit via linguify.

## KI-Verzeichnis (§3.8, NEU 2025)

| ID | Anforderung | Pflicht? | Quelle |
|---|---|---|---|
| CNT-10 | KI-Verzeichnis wenn KI genutzt | Ja | [HWR §3.8] |
| CNT-11 | Spalten: KI-Tool, Einsatzform, Betroffene Teile, Bemerkungen | Ja | [HWR §3.8] |
| CNT-12 | Prompts sichern und mit Arbeit einreichen | Ja | [HWR §3.8] |
| CNT-12a | Prompts-Einreichung: Kurze Prompts in `bemerkungen`-Spalte ODER Verweis auf separaten Anhang-Eintrag ("Prompts: siehe Anhang X"). Template erzwingt kein Format. | Ja | [DECIDED] |
| CNT-13 | KI-Nutzung nur mit Erlaubnis des Gutachtenden | Ja | [HWR §3.8] |

Das Template rendert das KI-Verzeichnis automatisch als Tabelle, wenn `ai-tools:` nicht leer ist. API → `requirements/api-design.md` §4.

## Sperrvermerk (§3.2.1, FAQ)

| ID | Anforderung | Pflicht? | Quelle |
|---|---|---|---|
| CNT-20 | Dem Deckblatt vorgeschaltet | Ja (wenn vorhanden) | [HWR §3.2.1] |
| CNT-21 | Nicht in Seitennummerierung einbezogen | Ja | [HWR §3.2.1] |
| CNT-22 | Nur Kapitel sperrbar (keine einzelnen Absätze/Seiten) | Ja | [HWR Anhang] |
| CNT-23 | Gesperrte Kapitel namentlich nennen | Ja | [HWR §3.2.1] |
| CNT-24 | Ungesperrte Version separat als Word+PDF einreichen | Ja | [HWR FAQ] |

**Pflichttext-Vorlage** (aus Anhang Richtlinien):
```
S P E R R V E R M E R K

Folgende/s Kapitel/Passagen unterliegt/unterliegen aufgrund der Verwendung vertraulicher
Daten einem Sperrvermerk und sind/ist ausschließlich für die zuständige Fachleiterin oder
den zuständigen Fachleiter und betreuende Prüferin/Gutachterin oder betreuenden Prüfer/
Gutachter einsichtig zu machen:

[Gliederungsnummer] [Kapitelüberschrift]

Eine Kurzfassung der Arbeit, die ausschließlich die nicht gesperrten Kapitel bzw.
Unterkapitel enthält, wird unter der Bezeichnung [Dateiname] auf beigefügtem Datenträger
zusätzlich zur Verfügung gestellt.
```

Das Template rendert diesen Text automatisch. API (drei Stufen: `none` / `true` / `chapters: (...)`) → `requirements/api-design.md` §5.

## Deckblatt / Titelblatt (Anhang Richtlinien)

| ID | Feld | Pflicht für | Quelle |
|---|---|---|---|
| CNT-30 | Thema / Titel | Alle | [HWR Anhang] |
| CNT-31 | Dokumenttyp | Alle | [HWR Anhang] |
| CNT-32 | Abgabedatum | Alle | [HWR Anhang] |
| CNT-33 | Institution | Alle | [HWR Anhang] |
| CNT-34 | Vorname + Name | Alle | [HWR Anhang] |
| CNT-35 | Bereich | Alle | [HWR Anhang] |
| CNT-36 | Fachrichtung | Alle | [HWR Anhang] |
| CNT-37 | Studienjahrgang | Alle | [HWR Anhang] |
| CNT-38 | Studienhalbjahr | Alle | [HWR Anhang] |
| CNT-39 | Ausbildungsbetrieb | PTB, Hausarbeit, Studienarbeit | [HWR Anhang] |
| CNT-40 | Betreuende/r Prüfer/in | PTB, Hausarbeit, Studienarbeit | [HWR Anhang] |
| CNT-41 | Erstgutachter/in | Bachelorarbeit | [HWR Anhang] |
| CNT-42 | Zweitgutachter/in | Bachelorarbeit | [HWR Anhang] |
| CNT-43 | Matrikelnummer | Alle | [DECIDED] |

**Hinweis CNT-43:** Matrikelnummer erscheint nicht explizit im HWR-Mustermuster, ist aber an der HWR übliche Praxis. Das Template inkludiert sie als Pflichtfeld.

Detaillierte Pflichtfelder je Dokumenttyp → `requirements/document-types.md`.

## Anhang (§3.10)

| ID | Anforderung | Pflicht? | Quelle |
|---|---|---|---|
| CNT-50 | Inhaltsangabe mit Seitenzahlen möglich | Optional | [HWR §3.10] |
| CNT-51 | Formale Anforderungen gelten auch für Anhang | Ja | [HWR §3.10] |
| CNT-52 | KI-Prompts hier einreichen | Ja (wenn KI genutzt) | [HWR §3.8] |
| CNT-53 | Internet-Quellen im Volltext beifügen | Ja | [HWR §3.7] |
| CNT-54 | Protokolle mündlicher Quellen | Ja (wenn mündlich zitiert) | [HWR §3.10] |

## Glossar (FAQ)

| ID | Anforderung | Pflicht? | Quelle |
|---|---|---|---|
| CNT-60 | Position: nach Haupttext, vor Literaturverzeichnis | Optional | [DECIDED — aus HWR FAQ] |
| CNT-61 | Im TOC mit Seitenzahl, aber keine Gliederungsnummer | Ja (wenn vorhanden) | [DECIDED — aus HWR FAQ] |
| CNT-62 | Quellen in Fußnoten und Literaturverzeichnis | Ja | [HWR §3.5] |
