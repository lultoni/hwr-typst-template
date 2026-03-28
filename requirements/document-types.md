# DOC — Dokumenttyp-spezifische Anforderungen
> Quelle: HWR Richtlinien §3.1, §3.11, Anhang (ab Januar 2025)
> Ergänzt durch: ptb-typst-template-main (Praxisbeispiel)

## Übersicht: Dokumenttypen

| Typ | Kürzel | Umfang | Bearbeitungszeit | Besonderheiten |
|---|---|---|---|---|
| Praxistransferbericht | PTB | 10 Seiten ±10% | 6 Wochen | Ausbildungsbetrieb Pflicht; Kapitel-Mindestlänge ½ Seite |
| Hausarbeit (Praxistransfer IV) | HA | 20 Seiten ±10% | 8 Wochen | Ausbildungsbetrieb Pflicht |
| Studienarbeit | SA | (wie HA) | — | — |
| Bachelorarbeit | BA | 40–50 Seiten | 10 Wochen | Erst-/Zweitgutachter; kein Ausbildungsbetrieb; Methodikbeschreibung in Einleitung |

## PTB — Praxistransferbericht

### Titelblatt-Felder (Pflicht)
| ID | Feld | Pflicht |
|---|---|---|
| DOC-PTB-01 | Thema | Ja |
| DOC-PTB-02 | "Praxistransferbericht I/II/III" | Ja |
| DOC-PTB-03 | Abgabedatum ("vorgelegt am…") | Ja |
| DOC-PTB-04 | Institution | Ja |
| DOC-PTB-05 | Vorname Name | Ja |
| DOC-PTB-06 | Bereich | Ja |
| DOC-PTB-07 | Fachrichtung | Ja |
| DOC-PTB-08 | Studienjahrgang | Ja |
| DOC-PTB-09 | Studienhalbjahr | Ja |
| DOC-PTB-10 | Ausbildungsbetrieb | Ja |
| DOC-PTB-11 | Betreuende/r Prüfer/in | Ja |
| DOC-PTB-12 | Matrikelnummer | Ja (Praxis) |

### Strukturempfehlung PTB (aus Referenztemplate)
1. Einleitung (Hinleitung, Zielformulierung, Aufbau) — 1 Seite
2. Theoretische Grundlagen
3. Methodik / Vorgehensweise
4. Darstellung der Ergebnisse
5. Bewertung der Ergebnisse
6. Schlussbetrachtung / Fazit + Ausblick — 1 Seite
7. Literaturverzeichnis
8. Anhang (KI-Verzeichnis, Protokolle, Internetquellen)
9. Ehrenwörtliche Erklärung

## Studienarbeit

### Titelblatt-Felder
Identisch mit Hausarbeit (DOC-PTB-01 bis DOC-PTB-12, `supervisor` + `company` Pflicht).
Dokumenttyp-Label: "Studienarbeit".

| ID | Anforderung |
|---|---|
| DOC-SA-01 | Gleiche Pflichtfelder wie Hausarbeit — `supervisor` und `company` sind Pflicht |
| DOC-SA-02 | Richtlinien nennen Studienarbeit nicht separat; wird analog Hausarbeit behandelt |

## Hausarbeit

### Titelblatt-Felder
Gleich wie PTB (DOC-PTB-01 bis DOC-PTB-12).
Dokumenttyp: "Hausarbeit" (nicht "PTB").

## Bachelorarbeit

### Titelblatt-Felder (Pflicht)
| ID | Feld | Pflicht |
|---|---|---|
| DOC-BA-01 | Thema | Ja |
| DOC-BA-02 | "Bachelorarbeit" | Ja |
| DOC-BA-03 | Abgabedatum | Ja |
| DOC-BA-04 | Institution | Ja |
| DOC-BA-05 | Vorname Name | Ja |
| DOC-BA-06 | Bereich | Ja |
| DOC-BA-07 | Fachrichtung | Ja |
| DOC-BA-08 | Studienjahrgang | Ja |
| DOC-BA-09 | Studienhalbjahr | Ja |
| DOC-BA-10 | Erstgutachter/in | Ja |
| DOC-BA-11 | Zweitgutachter/in | Ja |
| DOC-BA-12 | Matrikelnummer | Ja (Praxis) |
| DOC-BA-13 | KEIN Ausbildungsbetrieb-Feld | Ja (weglassen) |

### Besonderheiten Bachelorarbeit
| ID | Anforderung |
|---|---|
| DOC-BA-20 | Methodikbeschreibung und Grobgliederung in der Einleitung (bei anderen optional) |
| DOC-BA-21 | Thema in Absprache mit Erst-/Zweitgutachter |
| DOC-BA-22 | 40–50 Seiten strikt (kein reiner Theorie- ODER Praxisbericht) |

## Template API-Design: `doc_type` Parameter

```typst
// Mögliche Werte für den doc_type Parameter
"ptb-1"        // Praxistransferbericht I
"ptb-2"        // Praxistransferbericht II
"ptb-3"        // Praxistransferbericht III
"hausarbeit"   // Hausarbeit / Praxistransfer IV
"studienarbeit"
"bachelorarbeit"
```

### Bedingte Felder je Typ:

| Feld | ptb-* | hausarbeit | studienarbeit | bachelorarbeit |
|---|---|---|---|---|
| `company` (Ausbildungsbetrieb) | Pflicht | Pflicht | Pflicht | **Nein** |
| `supervisor` (Betreuende/r Prüfer/in) | Pflicht | Pflicht | Pflicht | **Nein** |
| `first-examiner` (Erstgutachter/in) | Nein | Nein | Nein | **Pflicht** |
| `second-examiner` (Zweitgutachter/in) | Nein | Nein | Nein | **Pflicht** |
| `semester` (Studienhalbjahr-Nr.) | Pflicht | Pflicht | Pflicht | Pflicht |
| Mindestseitenlänge Kapitel | ½ Seite | 1 Seite | 1 Seite | 1 Seite |
