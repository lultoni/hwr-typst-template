# HWR Berlin — Typst Template

Ein öffentliches Typst-Template für wissenschaftliche Arbeiten an der HWR Berlin (Wirtschaftsinformatik).
Konform mit den HWR-Richtlinien **Stand Januar 2025** — für alle Kohorten.

---

## Quick Start

```typst
#import "@preview/hwr-berlin:0.1.0": hwr, abk

#show: hwr.with(
  doc-type: "ptb-1",
  title:    "Mein Titel",
  authors:  ((name: "Max Mustermann", matrikel: "12345678"),),
  supervisor: "Prof. Dr. Muster",
  company:    "Muster GmbH",
  chapters: (
    include("kapitel/01_einleitung.typ"),
    include("kapitel/02_grundlagen.typ"),
  ),
  bibliography: bibliography("refs.bib"),
)
```

Das war es. Das Template erledigt automatisch:
- Deckblatt, Inhaltsverzeichnis, alle Verzeichnisse
- Seitennummerierung (Römisch → Arabisch → fortlaufend)
- Abkürzungsverzeichnis (nur verwendete Kürzel)
- Ehrenwörtliche Erklärung mit 2025 KI-Klausel
- Abbildungs-/Tabellenverzeichnis (nur wenn ≥ 5 Einträge)

---

## Voraussetzungen

- [Typst](https://typst.app/) ≥ 0.13.1
- Schriftart **Times New Roman** muss installiert sein (Standard auf Windows/macOS; Linux: `sudo apt install fonts-liberation` oder `ttf-mscorefonts-installer`)

---

## Projektstruktur

```
meine-arbeit/
├── main.typ            ← einzige Datei die du anfasst
├── refs.bib            ← deine Bibliographie
├── kapitel/
│   ├── 01_einleitung.typ
│   └── ...
└── anhang/             ← optional
    └── transkript.typ
```

---

## Alle Parameter

### Pflichtfelder

| Parameter | Typ | Beschreibung |
|---|---|---|
| `doc-type` | String | Art der Arbeit — siehe [Dokumenttypen](#dokumenttypen) |
| `title` | String | Titel der Arbeit |
| `authors` | Array | Mindestens ein Eintrag `(name: "...", matrikel: "...")` |

### Bedingt Pflicht

| Parameter | Pflicht für | Typ | Beschreibung |
|---|---|---|---|
| `supervisor` | ptb-*/hausarbeit/studienarbeit | String | Betreuende Prüferin/Prüfer |
| `company` | ptb-*/hausarbeit/studienarbeit | String | Ausbildungsbetrieb |
| `first-examiner` | bachelorarbeit | String | Erstgutachterin/Erstgutachter |
| `second-examiner` | bachelorarbeit | String | Zweitgutachterin/Zweitgutachter |

### Optionale Felder

| Parameter | Default | Typ | Beschreibung |
|---|---|---|---|
| `lang` | `"de"` | `"de"` \| `"en"` | Dokumentsprache |
| `field-of-study` | `"Wirtschaftsinformatik"` | String | Fachrichtung |
| `cohort` | `none` | String | Studienjahrgang (z.B. `"2024"`) |
| `semester` | `none` | String | Studienhalbjahr (z.B. `"3"`) |
| `date` | `auto` | `auto` \| String | Abgabedatum; `auto` = heutiges Datum |
| `abstract` | `none` | Content \| `none` | Zusammenfassung (eigene Seite, kein TOC-Eintrag) |
| `confidential` | `none` | siehe unten | Sperrvermerk |
| `abbreviations` | `(:)` | Dict | Abkürzungen — nur verwendete erscheinen im Verzeichnis |
| `glossary` | `()` | Array | Glossareinträge via glossarium |
| `ai-tools` | `()` | Array | KI-Verzeichnis (Pflicht wenn KI genutzt, §3.8) |
| `chapters` | `()` | Array | `include()`-Aufrufe in Reihenfolge |
| `appendix` | `()` | Array | Anhang-Einträge `(title: "...", content: ...)` |
| `bibliography` | `none` | `bibliography(...)` \| `none` | Literaturverzeichnis |
| `citation-style` | `"apa"` | String | Zitierstil — siehe [Zitierstile](#zitierstile) |
| `heading-depth` | `4` | 1–4 | TOC-Tiefe; max. 4 laut HWR §3.3.1 |
| `declaration-lang` | `auto` | `auto` \| `"de"` \| `"en"` | Sprache der Erklärung; `"de"` empfohlen (rechtssicher) |

---

## Dokumenttypen

| Wert | Deutsch | Bedingt Pflicht |
|---|---|---|
| `"ptb-1"` | Praxistransferbericht I | supervisor, company |
| `"ptb-2"` | Praxistransferbericht II | supervisor, company |
| `"ptb-3"` | Praxistransferbericht III | supervisor, company |
| `"hausarbeit"` | Hausarbeit | supervisor, company |
| `"studienarbeit"` | Studienarbeit | supervisor, company |
| `"bachelorarbeit"` | Bachelorarbeit | first-examiner, second-examiner |

---

## Features im Detail

### Abkürzungen

Zwei Nutzungswege, kombinierbar:

**Zentral in `main.typ` definieren:**
```typst
abbreviations: (
  "KI":  "Künstliche Intelligenz",
  "ERP": "Enterprise Resource Planning",
),
```
Im Text: `#abk("KI")` — expandiert beim ersten Mal zu „Künstliche Intelligenz (KI)", danach nur „KI".

**Inline definieren (ohne zentrale Liste):**
```typst
#abk("API", long: "Application Programming Interface")
// Erstes Vorkommen: "Application Programming Interface (API)"
// Weitere: "API"
```

Nicht verwendete Abkürzungen erscheinen **nicht** im Verzeichnis.
Keine Seitenangaben im Verzeichnis (laut HWR §3.2.2).

### Sperrvermerk

```typst
// Kein Sperrvermerk (default):
confidential: none,

// Gesamte Arbeit gesperrt:
confidential: true,

// Bestimmte Kapitel gesperrt:
confidential: (
  chapters: (
    (number: "3", title: "Methodik"),
    (number: "4", title: "Ergebnisse"),
  ),
  filename: "PTB_Mustermann_public.pdf",  // optional
),
```

Der Pflichttext aus §3.2.1 wird automatisch eingefügt. `company:` wird automatisch übernommen.

### KI-Verzeichnis (§3.8, Pflicht wenn KI genutzt)

```typst
ai-tools: (
  (
    tool:     "ChatGPT 4o",
    usage:    "Textvorschläge, im Text gekennzeichnet",
    chapters: "Kapitel 1, S. 3",
    bemerkungen: "Prompts: siehe Anhang A",  // optional
  ),
  (
    tool:     "DeepL Translator",
    usage:    "Übersetzung englischer Quellabschnitte",
    chapters: "Gesamte Arbeit",
  ),
),
```

Das KI-Verzeichnis erscheint automatisch als **letztes Anhang-Item**. Bei `ai-tools: ()` wird kein Verzeichnis gerendert und kein Anhang-Eintrag erstellt.

### Anhang

```typst
appendix: (
  // Typst-Datei:
  (title: "Interviewtranskript", content: include("anhang/transkript.typ")),
  // Bild:
  (title: "Screenshot Dashboard", content: image("anhang/screenshot.png")),
  // Inline:
  (title: "Rohdaten", content: [Tabelle hier...]),
),
```

Jeder Eintrag bekommt automatisch einen Buchstaben (A, B, C…) und einen Anker für interne Links.
Das Anhangsverzeichnis wird automatisch generiert.

### Mehrere Autoren (Gruppenarbeit)

```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678"),
  (name: "Lisa Müller",    matrikel: "87654321"),
),
```

Die Ehrenwörtliche Erklärung wechselt automatisch auf „Wir erklären…" und enthält eine Signaturzeile pro Autor.

---

## Zitierstile

| Situation | `citation-style` |
|---|---|
| Deutsche Arbeit (default) | `"apa"` |
| Englische Arbeit (HWR §6) | `"harvard-anglia-ruskin-university"` |
| Prof hat Stil vorgegeben | Pfad zur `.csl`-Datei: `"styles/chicago.csl"` |

Im Zweifel: Betreuer fragen. Mischung innerhalb einer Arbeit ist **nicht erlaubt** (§3.4.1).

---

## Glossar (via glossarium)

```typst
glossary: (
  (key: "stakeholder", short: "Stakeholder", long: "Stakeholder",
   description: "Interessengruppen, die von einem Projekt betroffen sind."),
),
```

Im Text: `#gls("stakeholder")`. Erscheint nach dem Haupttext, vor dem Literaturverzeichnis.

**Regel:** Nie denselben Begriff in Glossar UND Abkürzungsverzeichnis eintragen.
- Hat Abkürzung → `abbreviations:` + `#abk()`
- Braucht Erklärung, keine Abkürzung → `glossary:` + `#gls()`

---

## Good to Know

### HWR-Spezifika 2025

- Die **Ehrenwörtliche Erklärung** enthält seit 2025 eine Pflichtklausel zu KI-Nutzung. Das Template fügt sie automatisch ein.
- Das **KI-Verzeichnis** ist Pflicht sobald KI-Tools genutzt wurden — auch für Rechtschreibkorrektur via KI.
- **Abbildungen zählen wie Fließtext** (keine Seiten-Bonus durch Abbildungen, §3.1).
- Verzeichnisse (TOC, Abkürzungen etc.) erhalten **keine Gliederungsnummern**.
- **Sperrvermerk** erscheint vor dem Deckblatt, hat keine Seitennummer, wird nicht in der Seitenzählung mitgezählt.

### Abkürzungsregeln (§3.2.2)

- Nur **fachspezifische** Abkürzungen eintragen — keine Duden-Abkürzungen (z.B., u.a., usw.)
- Keine „Bequemlichkeitsabkürzungen" (BWL, insb. etc.) — diese dürfen nicht abgekürzt werden
- Gesetze: mit vollständigem Titel + Fassung + Quelle
- Sortierung: alphabetisch, keine Seitenangaben

### Datum

```typst
date: auto,           // Heutiges Datum, lokalisiert (z.B. "28. März 2026")
date: "15. März 2026" // Manuell — nützlich für retrospektive Abgaben
```

---

## Häufige Fehler

| Problem | Lösung |
|---|---|
| `doc-type "..." ist ungültig` | Wert muss exakt `"ptb-1"`, `"ptb-2"`, `"ptb-3"`, `"hausarbeit"`, `"studienarbeit"` oder `"bachelorarbeit"` sein |
| `supervisor ist Pflicht für...` | Für alle doc-types außer `bachelorarbeit` muss `supervisor:` und `company:` gesetzt sein |
| Times New Roman fehlt | Auf Linux: `sudo apt install ttf-mscorefonts-installer` oder Liberation Fonts |
| Abkürzung erscheint nicht im Verzeichnis | `#abk("XY")` muss im Text verwendet worden sein — im Verzeichnis erscheinen nur *verwendete* Abkürzungen |
| KI-Verzeichnis fehlt | `ai-tools:` muss mindestens einen Eintrag haben — leere Liste `()` unterdrückt das Verzeichnis |
| `include()` Pfadfehler | `include()` in `chapters:` ist relativ zu `main.typ`, nicht zu `lib.typ` |
| Abbildungsverzeichnis fehlt | Abbildungsverzeichnis erscheint nur ab **5 Abbildungen** (HWR-Anforderung) |

---

## Lizenz

MIT — siehe LICENSE
