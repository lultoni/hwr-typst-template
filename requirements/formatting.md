# FMT — Formatierungsanforderungen
> Quelle: HWR Richtlinien §3.2.3 (ab Januar 2025)

## Schrift & Text

| ID | Anforderung | Wert | Pflicht? | Typst-Umsetzung |
|---|---|---|---|---|
| FMT-01 | Schriftart Body | Times New Roman | Ja | `set text(font: "Times New Roman")` |
| FMT-02 | Schriftgröße Body | 12 pt | Ja | `set text(size: 12pt)` |
| FMT-03 | Schriftgröße Fußnoten | 10 pt | Ja | `set footnote(text(size: 10pt))` |
| FMT-04 | Schriftgröße Tabellen-/Abbildungsbeschriftung | 10 pt | Ja | caption-Stil setzen |
| FMT-05 | Zeilenabstand | 1,5-zeilig | Ja | `set par(leading: 0.65em)` + `set block(spacing: ...)` |
| FMT-06 | Zeilenabstand Fußnoten | 1-zeilig (Ausnahme) | Ja | Fußnoten-Override |
| FMT-07 | Zeilenabstand wörtliche Zitate (länger) | 1-zeilig (Ausnahme) | Ja | blockquote-Stil |
| FMT-08 | Textausrichtung | Blocksatz ODER linksbündig | Ja (eines wählen) | `set par(justify: true)` |
| FMT-09 | Silbentrennung | Aktiviert | Ja | Standard in Typst via `set text(lang: "de")` |
| FMT-10 | Absatzkennzeichnung | Einheitlicher Abstand ODER Einzug erste Zeile | Ja (eines wählen) | `set par(first-line-indent: ...)` |
| FMT-11 | Erste Zeile nach Überschrift | Kein Einzug | Ja | `show heading: ...` reset first-line-indent |
| FMT-12 | Andere Schrift erlaubt | Nur wenn Größe/Abstand angleicht | Bedingt | Hinweis in Doku |

## Seitenränder

| ID | Anforderung | Wert | Pflicht? |
|---|---|---|---|
| FMT-20 | Rand oben (inkl. Seitenzahl) | ca. 30 mm | Ja |
| FMT-21 | Rand rechts (Korrekturrand) | 30–35 mm | Ja |
| FMT-22 | Rand links | ca. 21 mm | Ja |
| FMT-23 | Rand unten | ca. 20 mm | Ja |

**Typst-Umsetzung:**
```typst
set page(margin: (top: 30mm, right: 35mm, bottom: 20mm, left: 21mm))
```

## Seitennummerierung

| ID | Anforderung | Wert | Pflicht? |
|---|---|---|---|
| FMT-30 | Deckblatt Seitennummer | Nicht sichtbar (wird aber in röm. Zählung einbezogen) | Ja |
| FMT-31 | Vorspann (Verzeichnisse) Nummerierung | Römisch (I, II, III…) fortlaufend | Ja |
| FMT-32 | Haupttext ab erster Textseite | Arabisch (1, 2, 3…) fortlaufend | Ja |
| FMT-33 | Arabische Nummerierung gilt bis | inkl. Anhang und Ehrenwörtlicher Erklärung | Ja |
| FMT-34 | Position der Seitennummer | Oben | Ja |
| FMT-35 | Sperrvermerk-Seite | Keine Nummer, nicht in Zählung | Ja |

## Tabellen & Abbildungen

| ID | Anforderung | Wert | Pflicht? |
|---|---|---|---|
| FMT-40 | Positionierung | Zentriert | Ja |
| FMT-41 | Tabellen Beschriftung | Oben, "Tabelle N: Titel" | Ja |
| FMT-42 | Abbildungen Beschriftung | Unten, "Abb. N: Titel" + Quelle | Ja |
| FMT-43 | Nummerierung | Fortlaufend durch die gesamte Arbeit | Ja |
| FMT-44 | Quellenangabe | Unmittelbar unter Abb./Tab., mit "Quelle:" | Ja |
| FMT-45 | Liegende/gefaltete Seiten | Vermeiden; wenn nötig: im Uhrzeigersinn drehbar | Empfehlung |
| FMT-46 | Tabellen Rahmung | Vollständig eingerahmt | Ja |
| FMT-47 | Fußnoten in Tabellen | Mit a, b, c… (nicht 1, 2, 3) | Ja |
