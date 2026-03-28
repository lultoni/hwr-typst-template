# STR — Strukturanforderungen
> Quelle: HWR Richtlinien §3.2.1, §3.3 (ab Januar 2025)

## Reihenfolge der Rahmenteile

| ID | Teil | Pflicht? | Bedingung | Seitennummerierung |
|---|---|---|---|---|
| STR-01 | Sperrvermerk | Optional | Nur wenn vertrauliche Daten | Keine Nummer, nicht in Zählung |
| STR-02 | Deckblatt / Titelblatt | Pflicht | — | Röm. (I), aber nicht sichtbar |
| STR-03 | Inhaltsverzeichnis | Pflicht | — | Röm. (II oder folgende) |
| STR-04 | Abkürzungsverzeichnis | Pflicht wenn Abkürzungen | Nur fachspezifische Abkürzungen (nicht Duden-Abkürzungen) | Röm. |
| STR-05 | Abbildungsverzeichnis | Bedingt | Nur ab 5 Abbildungen | Röm. |
| STR-06 | Tabellenverzeichnis | Bedingt | Nur ab 5 Tabellen | Röm. |
| STR-07 | Haupttext (Kapitel 1–n) | Pflicht | — | Arabisch ab 1 |
| STR-08 | Literaturverzeichnis | Pflicht | — | Arabisch |
| STR-09 | Anhang | Optional | — | Arabisch (fortlaufend) |
| STR-10 | Ehrenwörtliche Erklärung | Pflicht | — | Arabisch (fortlaufend) |
| STR-11 | Glossar | Optional | Nur wenn nötig; nach Haupttext, vor Literaturverzeichnis | Arabisch |
| STR-12 | KI-Verzeichnis | Pflicht wenn KI genutzt | Als letztes Item im Anhang (nach user-definierten Anhang-Teilen) | Arabisch |

**Hinweis:** Sperrvermerk, Deckblatt und Inhaltsverzeichnis erscheinen NICHT im Inhaltsverzeichnis selbst.
**Hinweis:** Verzeichnisse (TOC, Abkürzungen, etc.) und Anhang erhalten keine Gliederungsnummern.
**Hinweis:** KI-Verzeichnis erscheint automatisch als letztes Item im Anhang (nach user-definierten `appendix`-Einträgen). Nummerierung: letzter Buchstabe der Anhang-Sequenz (z.B. Anhang C wenn A+B user-defined).
**Hinweis:** Word-Export ist Out-of-Scope für das Template. Richtlinien §3.1 verlangen Word+PDF-Abgabe — User muss Word-Version selbst erstellen (z.B. via Pandoc oder Copy-Paste).

## Gliederungssystem (§3.3.1)

| ID | Anforderung | Wert | Pflicht? |
|---|---|---|---|
| STR-20 | Gliederungsart | Dezimalgliederung | Ja |
| STR-21 | Maximale Gliederungstiefe | 4 Ebenen (1.1.1.1) | Ja |
| STR-22 | Punkt nach letzter Ziffer | Entfällt (z.B. "2.1.2" nicht "2.1.2.") | Ja |
| STR-23 | Mindestanzahl Unterpunkte | Mindestens 2 wenn untergliedert | Ja |
| STR-24 | TOC-Einrückung | Unterpunkte eingerückt | Ja |
| STR-25 | Überschriften im Text | Linksbündig (nicht eingerückt) | Ja |
| STR-26 | Kein Punkt nach Überschriften | — | Ja |
| STR-27 | Seitenangaben im TOC | Alle Positionen mit Seitenangabe | Ja |
| STR-28 | Mindestlänge Kapitel | 1 Seite (PTB: ½ Seite) | Empfehlung |
| STR-29 | Vorspann vor Untergliederung | So kurz wie möglich | Empfehlung |

## Abkürzungsverzeichnis (§3.2.2)

| ID | Anforderung | Wert | Pflicht? |
|---|---|---|---|
| STR-40 | Sortierung | Alphabetisch | Ja |
| STR-41 | Seitenangaben | Keine | Ja |
| STR-42 | Bequemlichkeitsabkürzungen | Verboten (BWL, insb., etc.) | Ja |
| STR-43 | Duden-Abkürzungen | Nicht aufführen (z.B., u.a., usw.) | Ja |
| STR-44 | Gesetze im Abkürzungsverzeichnis | Mit vollständigem Titel + Fassung + Quelle | Ja |
| STR-45 | Format | "ABK Ausgeschriebener Begriff" | Ja |

## Umfangsangaben (§3.1)

| ID | Dokumenttyp | Umfang Haupttext | Bearbeitungszeit |
|---|---|---|---|
| STR-50 | PTB (Praxistransferbericht) | 10 Textseiten (±10%) | 6 Wochen |
| STR-51 | Hausarbeit (Praxistransfer IV) | 20 Textseiten (±10%) | 8 Wochen |
| STR-52 | Bachelorarbeit | 40–50 Textseiten | 10 Wochen |

**Hinweis:** Abbildungen zählen wie Fließtext (keine Seiten-Bonus durch Abbildungen).
**Hinweis:** Abgabe als Word UND PDF in SAM; ehrenwörtliche Erklärung muss unterschrieben sein.
