# FMT — Formatierungsanforderungen

Diese Datei dokumentiert alle Formatierungsvorgaben aus den HWR-Richtlinien (Januar 2025).
Sie ist die Referenz für Layout-Entscheidungen — Implementierungsdetails (Typst-Code, Package-Konfiguration) stehen in `implementation-insights.md`.

## Schrift & Text

| ID | Anforderung | Wert | Pflicht? | Quelle |
|---|---|---|---|---|
| FMT-01 | Schriftart Body | Times New Roman | Ja | [HWR §3.2.3] |
| FMT-02 | Schriftgröße Body | 12 pt | Ja | [HWR §3.2.3] |
| FMT-03 | Schriftgröße Fußnoten | 10 pt | Ja | [HWR §3.2.3] |
| FMT-04 | Schriftgröße Tabellen-/Abbildungsbeschriftung | 10 pt | Ja | [HWR §3.2.3] |
| FMT-05 | Zeilenabstand | 1,5-zeilig | Ja | [HWR §3.2.3] |
| FMT-06 | Zeilenabstand Fußnoten | 1-zeilig (Ausnahme) | Ja | [HWR §3.2.3] |
| FMT-07 | Zeilenabstand wörtliche Zitate (länger) | 1-zeilig (Ausnahme) | Ja | [HWR §3.4.2] |
| FMT-08 | Textausrichtung | Blocksatz ODER linksbündig | Ja (eines wählen) | [HWR §3.2.3] |
| FMT-09 | Silbentrennung | Aktiviert | Ja | [HWR §3.2.3] |
| FMT-10 | Absatzkennzeichnung | Einheitlicher Abstand ODER Einzug erste Zeile | Ja (eines wählen) | [HWR §3.2.3] |
| FMT-11 | Erste Zeile nach Überschrift | Kein Einzug | Ja | [DECIDED] |
| FMT-12 | Andere Schrift erlaubt | Nur wenn Größe/Abstand angleicht | Bedingt | [HWR §3.2.3] |

**Hinweis FMT-11:** Nicht wörtlich in §3.2.3, aber universelle Satztechnik-Konvention — Template-Entscheidung.

## Seitenränder

| ID | Anforderung | Wert | Pflicht? | Quelle |
|---|---|---|---|---|
| FMT-20 | Rand oben (inkl. Seitenzahl) | ca. 30 mm | Ja | [HWR §3.2.3] |
| FMT-21 | Rand rechts (Korrekturrand) | 30–35 mm | Ja | [HWR §3.2.3] |
| FMT-22 | Rand links | ca. 21 mm | Ja | [HWR §3.2.3] |
| FMT-23 | Rand unten | ca. 20 mm | Ja | [HWR §3.2.3] |

## Seitennummerierung

| ID | Anforderung | Wert | Pflicht? | Quelle |
|---|---|---|---|---|
| FMT-30 | Deckblatt Seitennummer | Nicht sichtbar (wird aber in röm. Zählung einbezogen) | Ja | [HWR §3.2.3] |
| FMT-31 | Vorspann (Verzeichnisse) Nummerierung | Römisch (I, II, III…) fortlaufend | Ja | [HWR §3.2.3] |
| FMT-32 | Haupttext ab erster Textseite | Arabisch (1, 2, 3…) fortlaufend | Ja | [HWR §3.2.3] |
| FMT-33 | Arabische Nummerierung gilt bis | inkl. Anhang und Ehrenwörtlicher Erklärung | Ja | [HWR §3.2.3] |
| FMT-34 | Position der Seitennummer | Oben | Ja | [HWR §3.2.3] |
| FMT-35 | Sperrvermerk-Seite | Keine Nummer, nicht in Zählung | Ja | [HWR §3.2.1] |

**Hinweis FMT-34:** Die Richtlinien schreiben nur "oben" vor. Die konkrete Platzierung (top-right) ist Konvention — `[DECIDED]`.

## Tabellen & Abbildungen

| ID | Anforderung | Wert | Pflicht? | Quelle |
|---|---|---|---|---|
| FMT-40 | Positionierung | Zentriert | Ja | [HWR §3.6] |
| FMT-41 | Tabellen Headerzeile | Tabellen müssen eine Kopfzeile haben ("Überschriften" laut Richtlinie §3.6) | Ja | [HWR §3.6] |
| FMT-41b | Tabellen Beschriftung (Caption) | Unten — analog zu Abbildungen | Konvention | [DECIDED] |
| FMT-42 | Abbildungen Beschriftung | Unten, "Abb. N: Titel" + Quelle | Ja | [HWR §3.6] |
| FMT-43 | Nummerierung | Fortlaufend durch die gesamte Arbeit | Ja | [HWR §3.6] |
| FMT-44 | Quellenangabe | Unmittelbar unter Abb./Tab., mit "Quelle:" | Ja | [HWR §3.6] |
| FMT-45 | Liegende/gefaltete Seiten | Vermeiden; wenn nötig: im Uhrzeigersinn drehbar | Empfehlung | [DECIDED] |
| FMT-46 | Tabellen Rahmung | Vollständig eingerahmt | Ja | [HWR §3.6] |
| FMT-47 | Fußnoten in Tabellen | Mit a, b, c… (nicht 1, 2, 3) | Ja | [HWR §3.6] |

**Hinweis FMT-41b:** §3.6 nennt "Unterschrift" explizit für Abbildungen. Tabellen-Captions werden analog behandelt — bewusste Entscheidung.
**Hinweis FMT-42:** §3.6 verwendet das Wort "Unterschrift" (= darunter). "Unten" ist nicht wörtlich genannt, aber aus dem Begriff abgeleitet.
