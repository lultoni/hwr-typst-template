# DOC — Dokumenttyp-spezifische Anforderungen

Diese Datei dokumentiert die Unterschiede zwischen den vier Dokumenttypen, die das Template unterstützt: welche Felder Pflicht sind, welche Seitenumfänge gelten, und welche Besonderheiten zu beachten sind. Die vollständige API → `requirements/api-design.md`.

## Übersicht: Dokumenttypen

| Typ | API-Wert | Umfang | Bearbeitungszeit | Besonderheiten | Quelle |
|---|---|---|---|---|---|
| Praxistransferbericht I | `"ptb-1"` | 10 Seiten ±10% | 6 Wochen | Ausbildungsbetrieb Pflicht; Kapitel-Mindestlänge ½ Seite | [HWR §3.1] |
| Praxistransferbericht II | `"ptb-2"` | 10 Seiten ±10% | 6 Wochen | wie PTB-1 | [HWR §3.1] |
| Praxistransferbericht III | `"ptb-3"` | 10 Seiten ±10% | 6 Wochen | wie PTB-1 | [HWR §3.1] |
| Hausarbeit (Praxistransfer IV) | `"hausarbeit"` | 20 Seiten ±10% | 8 Wochen | Ausbildungsbetrieb Pflicht | [HWR §3.1] |
| Studienarbeit | `"studienarbeit"` | 20 Seiten ±10% | 8 Wochen | Analog Hausarbeit | [DECIDED] |
| Bachelorarbeit | `"bachelorarbeit"` | 40–50 Seiten | 10 Wochen | Erst-/Zweitgutachter; kein Ausbildungsbetrieb | [HWR §3.1] |

## Bedingte Pflichtfelder je Dokumenttyp

| Feld | `ptb-*` | `hausarbeit` | `studienarbeit` | `bachelorarbeit` | Quelle |
|---|---|---|---|---|---|
| `company` (Ausbildungsbetrieb) | Pflicht | Pflicht | Pflicht | **Nein** | [HWR §3.1] |
| `supervisor` (Betreuende/r Prüfer/in) | Pflicht | Pflicht | Pflicht | **Nein** | [HWR §3.1] |
| `first-examiner` (Erstgutachter/in) | Nein | Nein | Nein | **Pflicht** | [HWR §3.1] |
| `second-examiner` (Zweitgutachter/in) | Nein | Nein | Nein | **Pflicht** | [HWR §3.1] |
| `semester` (Studienhalbjahr-Nr.) | Pflicht | Pflicht | Pflicht | Pflicht | [HWR Anhang] |
| Mindestseitenlänge Kapitel | ½ Seite | 1 Seite | 1 Seite | 1 Seite | [HWR §3.3.1] |

## PTB — Praxistransferbericht

### Titelblatt-Pflichtfelder
| ID | Feld | Quelle |
|---|---|---|
| DOC-PTB-01 | Thema | [HWR Anhang] |
| DOC-PTB-02 | "Praxistransferbericht I/II/III" | [HWR Anhang] |
| DOC-PTB-03 | Abgabedatum ("vorgelegt am…") | [HWR Anhang] |
| DOC-PTB-04 | Institution | [HWR Anhang] |
| DOC-PTB-05 | Vorname Name | [HWR Anhang] |
| DOC-PTB-06 | Bereich | [HWR Anhang] |
| DOC-PTB-07 | Fachrichtung | [HWR Anhang] |
| DOC-PTB-08 | Studienjahrgang | [HWR Anhang] |
| DOC-PTB-09 | Studienhalbjahr | [HWR Anhang] |
| DOC-PTB-10 | Ausbildungsbetrieb | [HWR Anhang] |
| DOC-PTB-11 | Betreuende/r Prüfer/in | [HWR Anhang] |
| DOC-PTB-12 | Matrikelnummer | [DECIDED] |

### Empfohlene Kapitelstruktur PTB
1. Einleitung (Hinleitung, Zielformulierung, Aufbau) — ca. 1 Seite
2. Theoretische Grundlagen
3. Methodik / Vorgehensweise
4. Darstellung der Ergebnisse
5. Bewertung der Ergebnisse
6. Schlussbetrachtung / Fazit + Ausblick — ca. 1 Seite
7. Literaturverzeichnis
8. Anhang (KI-Verzeichnis, Protokolle, Internetquellen)
9. Ehrenwörtliche Erklärung

Diese Struktur ist eine Empfehlung aus dem ptb-Referenztemplate — `[STYLE]`. Die HWR schreibt keine feste Kapitelstruktur vor.

## Hausarbeit / Studienarbeit

Titelblatt-Felder identisch mit PTB (DOC-PTB-01 bis DOC-PTB-12). Dokumenttyp-Label: "Hausarbeit" bzw. "Studienarbeit".

| ID | Anforderung | Quelle |
|---|---|---|
| DOC-SA-01 | Studienarbeit hat gleiche Pflichtfelder wie Hausarbeit — `supervisor` und `company` sind Pflicht | [DECIDED] |
| DOC-SA-02 | Richtlinien nennen Studienarbeit nicht separat; wird analog Hausarbeit behandelt | [DECIDED] |

## Bachelorarbeit

### Titelblatt-Pflichtfelder
| ID | Feld | Quelle |
|---|---|---|
| DOC-BA-01 | Thema | [HWR Anhang] |
| DOC-BA-02 | "Bachelorarbeit" | [HWR Anhang] |
| DOC-BA-03 | Abgabedatum | [HWR Anhang] |
| DOC-BA-04 | Institution | [HWR Anhang] |
| DOC-BA-05 | Vorname Name | [HWR Anhang] |
| DOC-BA-06 | Bereich | [HWR Anhang] |
| DOC-BA-07 | Fachrichtung | [HWR Anhang] |
| DOC-BA-08 | Studienjahrgang | [HWR Anhang] |
| DOC-BA-09 | Studienhalbjahr | [HWR Anhang] |
| DOC-BA-10 | Erstgutachter/in | [HWR Anhang] |
| DOC-BA-11 | Zweitgutachter/in | [HWR Anhang] |
| DOC-BA-12 | Matrikelnummer | [DECIDED] |
| DOC-BA-13 | KEIN Ausbildungsbetrieb-Feld | [HWR §3.1] |

### Besonderheiten Bachelorarbeit
| ID | Anforderung | Quelle |
|---|---|---|
| DOC-BA-20 | Methodikbeschreibung und Grobgliederung in der Einleitung | [HWR §3.1] |
| DOC-BA-21 | Thema in Absprache mit Erst-/Zweitgutachter | [HWR §3.1] |
| DOC-BA-22 | 40–50 Seiten strikt (kein reiner Theorie- ODER Praxisbericht) | [HWR §3.1] |
