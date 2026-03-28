# API Design Decisions — Finalized

Diese Datei ist die Single Source of Truth für alle Parameter des `hwr()`-Templates. Änderungen an der öffentlichen API werden hier dokumentiert und müssen mit `lib.typ` übereinstimmen.

## 1. Parameter-Stil: Nested

```typst
#show: hwr.with(
  doc-type: "ptb-1",
  lang: "de",
  title: "Mein Titel",
  author: (
    name: "Max Mustermann",
    matrikel: "12345678",
  ),
  supervisor: "Prof. Dr. Muster",
  company: "Muster GmbH",
)
```

## 2. Mehrere Autoren: Array von Dicts

```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678"),
  (name: "Lisa Müller",    matrikel: "87654321"),
),
```
Immer `authors:` als Array — auch bei Einzelperson kein Sonderfall:
```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678"),
),
```

Optionales `signature:`-Feld pro Autor — wenn angegeben, wird das Bild im Unterschriftsfeld gerendert statt einer leeren Linie:
```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678", signature: "images/signature_max.png"),
  (name: "Lisa Müller",    matrikel: "87654321", signature: "images/signature_lisa.svg"),
),
```
- Pfad relativ zu `main.typ`
- Unterstützte Formate: PNG, SVG, JPEG (alles was Typst `image()` versteht)
- Ohne `signature:`: leere Linie zum handschriftlichen Unterschreiben
- Beispiel-SVG: `template/images/signature_example.svg`

## 3. Abkürzungen: Hybrid + Auto-Detection via Script

### Drei Wege, alle kombinierbar:

**Weg 1 — Zentral in main.typ definieren (werden nur gerendert wenn im Text verwendet):**
```typst
abbreviations: (
  "KI":  "Künstliche Intelligenz",
  "HWR": "Hochschule für Wirtschaft und Recht",
  "PTB": "Praxistransferbericht",
),
```
Nicht verwendete Abkürzungen tauchen im Verzeichnis NICHT auf.

**Weg 2 — Im Fließtext definieren (first-use expandiert automatisch):**
```typst
#abk("API", "Application Programming Interface") // → "Application Programming Interface (API)"
// danach:
#abk("API")  // → "API"
```

**Weg 3 — Script `scripts/abk-scan.py` (v1.1-Kandidat, optional):**

Das Script ist ein Komfort-Tool für spätere Version — das Template funktioniert vollständig ohne es.
Wer Abkürzungen manuell mit `#abk()` einpflegt (Weg 2), braucht das Script nicht.
Details → `requirements/backlog.md`.

### Abkürzungsverzeichnis:
- Alphabetisch sortiert
- Nur verwendete Einträge (aus Weg 1 + 2)
- Keine Seitenangaben (laut Richtlinien STR-41)
- Kein Eintrag für Duden-Abkürzungen (z.B., u.a. usw.) — STR-43

## 4. KI-Verzeichnis: Struct-Array, nur rendern wenn befüllt

```typst
ai-tools: (
  (tool: "ChatGPT 4o",   usage: "Textvorschläge, im Text gekennzeichnet", chapters: "Kapitel 1, S. 3"),
  (tool: "DeepL",        usage: "Übersetzung von Textpassagen",           chapters: "Ganze Arbeit"),
),
```
- Default: `ai-tools: ()` → kein KI-Verzeichnis wird gerendert, kein Anhang-Item
- Wenn befüllt: Tabelle wird automatisch gerendert (Format aus §3.8 der Richtlinien); erscheint als letztes Anhang-Item nach user-definierten `appendix`-Einträgen
- Spalten: KI-Tool | Einsatzform | Betroffene Teile | Bemerkungen
- `bemerkungen` ist optional pro Eintrag (default leer)
- Prompts-Einreichung: User kann Prompts in `bemerkungen` inline angeben ODER auf separaten Anhang-Eintrag verweisen ("Prompts: siehe Anhang X"). Template erzwingt kein Format.

## Anhang-Reihenfolge (Gesamtstruktur)

```
Anhang 1: [erster user-appendix Eintrag]
Anhang 2: [zweiter user-appendix Eintrag]
...
Anhang X: KI-Verzeichnis  ← automatisch als letztes Item (nur wenn ai-tools nicht leer)
```

- Wenn kein `appendix` und kein `ai-tools`: Kein Anhang, kein Anhangsverzeichnis
- Wenn nur `ai-tools`: Anhang enthält nur das KI-Verzeichnis (Anhang A)
- Internet-Quellen (§3.7) und Protokolle mündlicher Quellen (§3.10) kommen als user-definierte `appendix`-Einträge rein — Template generiert diese nicht automatisch

## 5. Sperrvermerk: Drei Stufen

```typst
// Kein Sperrvermerk (default):
confidential: none,

// Gesamte Arbeit gesperrt:
confidential: true,

// Bestimmte Kapitel:
confidential: (
  chapters: (
    (number: "3",   title: "Methodik"),
    (number: "4",   title: "Darstellung der Ergebnisse"),
  ),
  filename: "PTB_Mustermann_public.pdf",  // optional — Dateiname der ungesperrten Version
),
```

- `company` wird automatisch aus dem Top-Level-Parameter `company:` übernommen — keine doppelte Eingabe nötig.
- Template rendert den korrekten Pflichttext aus den Richtlinien (Anhang §CNT-20ff) mit den angegebenen Kapitelbezeichnungen.

## 6. Bibliographie

```typst
#show: hwr.with(
  bibliography: bibliography("refs.bib"),
  citation-style: "apa",
  // citation-style: Zitierformat.
  //   Deutsch (default): "apa"
  //   Englisch (laut HWR §6): "harvard-anglia-ruskin-university"
  //   Eigene CSL-Datei: "/pfad/zur/datei.csl"
  //   Prof hat anderen Stil vorgegeben: entsprechende .csl-Datei verwenden
  //   Mischung innerhalb einer Arbeit ist NICHT erlaubt (§3.4.1)
  //   Im Zweifel: Betreuer fragen.
)
```

### Wann welcher Zitierstil?

| Situation | Stil |
|---|---|
| Deutsche Arbeit, kein besonderes Vorgabe | `"apa"` (default) |
| Englische Arbeit (§6 Richtlinien) | `"harvard-anglia-ruskin-university"` |
| Prof hat konkreten Stil vorgegeben | Entsprechende `.csl`-Datei |
| Ich bin mir nicht sicher | Betreuer fragen — und dann hier eintragen |

Ausführliche Regeldetails → `requirements/citations.md`

### Bibliographie-Datei:

Der Default in `main.typ` ist:
```typst
bibliography: bibliography("refs.bib"),
```

Wenn diese Zeile auskommentiert oder gelöscht wird, sucht das Template automatisch nach `refs.bib` im Projektverzeichnis. Wenn keine `.bib`-Datei vorhanden ist → kein Literaturverzeichnis.

### Bibliographie-Position:
Erscheint automatisch nach dem Haupttext, vor dem Anhang — kein manuelles Platzieren nötig.

### VS Code / Typst LSP:
Die `.bib`-Datei wird in `main.typ` via `bibliography()` übergeben. Das reicht dem Typst LSP für Autocomplete und Validierung.

## 7. Anhang: Hybrid-Array

```typst
appendix: (
  (title: "Interviewtranskript I1",   content: include("anhang/transkript_I1.typ")),
  (title: "Interviewtranskript I2",   content: include("anhang/transkript_I2.typ")),
  (title: "Screenshot Benutzeroberfläche", content: image("anhang/screenshot.png")),
  (title: "Rohdaten Umfrage",         content: include("anhang/rohdaten.typ")),
),
```

### Was als `content` möglich ist:

```typst
// Typst-Datei einbinden (empfohlen für längere Texte):
content: include("anhang/transkript.typ")

// Bild einbinden (für Grafiken, Screenshots, Diagramme):
content: image("anhang/screenshot.png")
content: image("anhang/screenshot.png", width: 100%)

// Inline-Tabelle:
content: table(
  columns: (auto, auto),
  [Spalte A], [Spalte B],
  [Wert 1],   [Wert 2],
)

// Code-Listing:
content: raw(read("anhang/code.py"), lang: "python")

// Beliebiger Typst-Inline-Content:
content: [
  Hier steht Text direkt im Anhang-Eintrag.
  Funktioniert für kurze Anhänge.
]
```

### Best Practices:
- `include()`: Für Interviewtranskripte, Protokolle, längere Tabellen — eigene `.typ`-Datei in `anhang/`
- `image()`: Für Screenshots, Grafiken, eingescannte Dokumente
- `raw(read(...))`: Für Code-Listings als Anhang
- Inline `[...]`: Nur für sehr kurze Anhänge (ein Absatz oder weniger)

### Automatisches Verhalten:
- Kein Typ-System — `content` ist beliebiger Typst-Content
- Anhangsverzeichnis generiert sich automatisch aus den `title`-Feldern
- Jeder Eintrag bekommt automatisch einen Anker: `<anhang-1>`, `<anhang-2>`, ...
- Nummerierung: 1, 2, 3… (Überschriften: "Anhang 1: Interviewtranskript I1") `[DECIDED]`
- Alle Einträge im Anhangsverzeichnis sind klickbar (Hyperlinks zu den Ankern)
- Default: `appendix: ()` → kein user-definierter Anhang
- KI-Verzeichnis (`ai-tools`) erscheint automatisch **nach** allen user-definierten `appendix`-Einträgen

## 8. Glossar

Via `@preview/glossarium` Package. Konfiguration:
```typst
glossary: (
  (key: "api",  short: "API",  long: "Application Programming Interface",  description: "Schnittstelle zur Kommunikation zwischen Softwarekomponenten."),
  (key: "rest", short: "REST", long: "Representational State Transfer",     description: "Architekturstil für verteilte Systeme."),
),
```
Im Text: `#gls("api")` → first-use expandiert, danach kurz.
Glossarverzeichnis: Automatisch, alphabetisch, nur wenn `glossary` nicht leer.

### Wann Glossar, wann Abkürzungsverzeichnis?

**Abkürzungsverzeichnis** (`abbreviations:`):
- NUR für Abkürzungen — Buchstabenfolgen die für einen Begriff stehen (KI, API, HWR, §3.2.2)
- Position: Vorspann, nach Inhaltsverzeichnis (STR-04)
- Kein Eintrag für Duden-Abkürzungen (z.B., u.a., usw.)

**Glossar** (`glossary:`):
- NUR für erklärungsbedürftige Fachbegriffe OHNE eigene Abkürzung
  - Beispiele: "Agile Methodik", "Scrum-Sprint", "Stakeholder"
- Position: Nach Haupttext, vor Literaturverzeichnis (STR-11, CNT-60)
- Quellen für Definitionen in Fußnoten + Literaturverzeichnis belegen (CNT-62)

**Regel: Nie für denselben Begriff in beide Listen eintragen.**
- "API" hat eine Abkürzung → Abkürzungsverzeichnis
- "Stakeholder" hat keine Abkürzung, braucht aber Erklärung → Glossar
- "KI" wird erklärt UND hat eine Abkürzung → Abkürzungsverzeichnis, NICHT Glossar

Beide Verzeichnisse sind separate Listen und werden nie zusammengefasst.

## 8b. Abstract

```typst
abstract: none,  // default: kein Abstract
// oder:
abstract: [
  Diese Arbeit untersucht ...
],
```

- Optional — wird nur gerendert wenn nicht `none`
- Erscheint nach dem Deckblatt, vor dem Inhaltsverzeichnis (Position laut STR-Reihenfolge)
- Eigene Seite mit Überschrift "Abstract" / "Zusammenfassung" (folgt `lang`)
- Seitennummerierung: Römisch (Teil des Vorspanns)
- Kein Heading im TOC — Abstract-Seite taucht nicht im Inhaltsverzeichnis auf
- Keine Längen-Einschränkung vom Template, aber HWR-Empfehlung: ~½ Seite

## 9. Sprache der Ehrenwörtlichen Erklärung: Separat konfigurierbar

```typst
declaration-lang: auto,  // default: folgt docs-Sprache (lang: "de"/"en")
// oder:
declaration-lang: "de",  // immer Deutsch (empfohlen — rechtssicher)
```

**Default: `auto`** — folgt `lang`.

Wenn `declaration-lang: "en"` oder `lang: "en"` mit `declaration-lang: auto`:
Das Template fügt einen **Kommentar in `main.typ`** ein (nicht ins PDF):
```typst
// HINWEIS: Ehrenwörtliche Erklärung auf Englisch.
// Bitte klären ob dies mit Ihrer betreuenden Person zulässig ist.
```
Der Hinweis erscheint NICHT im kompilierten PDF — nur im Quellcode als Erinnerung für den User.

## 10. Datum: Auto mit Überschreibung

```typst
date: auto,           // default: datetime.today(), lokalisiert
// oder:
date: "15. März 2026", // manuell als String
```

Datum-Lokalisierung: Bei `lang: "de"` erscheinen Monatsnamen auf Deutsch; bei `lang: "en"` auf Englisch. Implementierung → `helper/date.typ`.

## 11. Kapitelstruktur: Explizite Reihenfolge via `chapters`-Parameter

Kapitel werden in `kapitel/` abgelegt. Die Reihenfolge wird **explizit** in `main.typ` angegeben.
`include()` wird direkt in `main.typ` aufgerufen (Pfade relativ zu `main.typ`):

```typst
chapters: (
  include("kapitel/01_einleitung.typ"),
  include("kapitel/02_theoretische_grundlagen.typ"),
  include("kapitel/03_methodik.typ"),
  include("kapitel/04_ergebnisse.typ"),
  include("kapitel/05_fazit.typ"),
),
```

**Implementierungsnotiz:** `include()` muss in `main.typ` (nicht in `lib.typ`) aufgerufen werden,
da Typst Pfade relativ zur aufrufenden Datei auflöst. Deshalb übergibt `chapters:` bereits
evaluierten Typst-Content (nicht Dateinamen-Strings).

- Reihenfolge im PDF = Reihenfolge in der Liste. Kein magisches Sortieren.
- Neues Kapitel einfügen = an der gewünschten Stelle in die Liste eintragen.
- Datei existiert aber nicht in der Liste = wird nicht gerendert (kein Fehler, kein Auto-Include).
- Dateiname in der Liste aber Datei fehlt = Typst-Compile-Error (gewollt — verhindert stille Lücken).
- **Nummerierung im Dateinamen ist optional** — `"einleitung.typ"` ist genauso gültig wie `"01_einleitung.typ"`. Die führenden Zahlen helfen nur beim eigenen Überblick im Dateiexplorer.

### Bibliographie-Autocomplete in VS Code:
Die `refs.bib` wird via `bibliography()`-Parameter an `main.typ` übergeben. Typst LSP löst dann Referenzen auf. Kein roter Unterstrich wenn:
1. `refs.bib` existiert
2. Der cite-key im `.bib` vorhanden ist
3. Die `bibliography()`-Übergabe korrekt ist

Keine weitere Konfiguration nötig — das ist Typst-Standard-Verhalten.

## 12. Heading-Tiefe: 4 als Default, 1–4 erlaubt

```typst
heading-depth: 4,  // default
                   // erlaubte Werte: 1–4
                   // Richtlinien §3.3.1 empfehlen max 4 Ebenen
                   // Werte unter 3 sind ungewöhnlich aber erlaubt
```

TOC-Tiefe folgt automatisch `heading-depth`.
Headings tiefer als `heading-depth` werden nicht nummeriert (aber sind erlaubt als unnummerierte Abschnitte).

## 13. Gruppen-Unterschrift: `group-signature`

```typst
group-signature: auto,  // default (= true)
// oder:
group-signature: false, // nur erster Autor unterschreibt
```

- `auto` / `true`: Alle Autoren unterschreiben (Standard)
- `false`: Nur erster Autor unterschreibt (repräsentative Unterschrift bei Gruppenarbeit)
- Bei `false` und mehr als einem Autor: gelber Warnhinweis im kompilierten PDF — User soll mit dem Prüfer abklären ob eine stellvertretende Unterschrift akzeptiert wird. `[DECIDED]`

## 14. Anhangsverzeichnis: `show-appendix-toc`

```typst
show-appendix-toc: false,  // default
// oder:
show-appendix-toc: true,   // optionales Verzeichnis vor den Anhang-Einträgen
```

HWR §3.10 schreibt: "ist es möglich, dem Anhang ein eigenes Verzeichnis voranzustellen." Das ist optional — Default ist `false`. `[HWR §3.10]`

## 15. Unterschriftsort: `city`

```typst
city: "Berlin",  // default — erscheint im Unterschriftsfeld der Ehrenwörtlichen Erklärung
```

Freitext. Standard ist "Berlin" (HWR-Standort), kann überschrieben werden. `[DECIDED]`

---

## Vollständige API-Übersicht (Referenz für Implementierung)

```typst
#show: hwr.with(
  // === PFLICHTFELDER ===
  doc-type: "ptb-1",
  // Werte: "ptb-1" | "ptb-2" | "ptb-3" | "hausarbeit" | "studienarbeit" | "bachelorarbeit"

  title: "Titel der Arbeit",

  authors: (
    (name: "Max Mustermann", matrikel: "12345678"),
  ),

  // === BEDINGT PFLICHT (je nach doc-type) ===
  supervisor: "Prof. Dr. Muster",       // Pflicht für ptb-*/hausarbeit/studienarbeit
  company: "Muster GmbH",              // Pflicht für ptb-*/hausarbeit/studienarbeit
  first-examiner: "Prof. Dr. Muster",  // Pflicht für bachelorarbeit
  second-examiner: "Prof. Dr. Müller", // Pflicht für bachelorarbeit

  // === OPTIONALE FELDER ===
  lang: "de",                // default: "de" | "en"
  field-of-study: "Wirtschaftsinformatik",
  cohort: "2024",            // Studienjahrgang
  semester: "3",             // Studienhalbjahr

  date: auto,                // default: heute (lokalisiert) | manueller String

  abstract: none,            // Content oder none — eigene Seite vor TOC

  confidential: none,        // none | true | (chapters: (...), filename: ...)
                             // company wird automatisch aus company: übernommen

  abbreviations: (),         // Dict: ("KI": "Künstliche Intelligenz", ...)

  glossary: (),              // Array von (key, short, long, description)

  ai-tools: (),              // Array von (tool, usage, chapters, bemerkungen?)

  chapters: (                // include()-Aufrufe in main.typ (Pfade relativ zu main.typ)
    include("kapitel/01_einleitung.typ"),
    include("kapitel/02_grundlagen.typ"),
  ),

  appendix: (),              // Array von (title, content)

  bibliography: bibliography("refs.bib"),  // oder none; auskommentieren = auto-suche refs.bib
  citation-style: "apa",     // "apa" | "harvard-anglia-ruskin-university" | ".csl-Pfad"

  heading-depth: 4,          // 1–4, default 4

  declaration-lang: auto,    // auto | "de" | "en"

  city: "Berlin",            // Ort im Unterschriftsfeld (default: "Berlin")

  show-appendix-toc: false,  // true = optionales Anhangsverzeichnis vor Anhang-Einträgen
                             // (HWR §3.10: "ist es möglich" — nicht Pflicht, default false)

  group-signature: auto,     // auto/true = all authors sign (default)
                             // false = only first author signs (group work)
                             // When false & authors.len() > 1: shows yellow warning block
                             // confirming with examiner about representative signature
)
```
