# HWR Berlin — Typst-Template

**English version:** → [README-en.md](README-en.md)

Ein Community-Typst-Template für wissenschaftliche Arbeiten an der HWR Berlin (Hochschule für Wirtschaft und Recht), primär für Studierende der *Wirtschaftsinformatik*. Automatisiert Deckblatt, Verzeichnisse, Abkürzungsliste, Ehrenwörtliche Erklärung und mehr — konform mit den HWR-Richtlinien **Stand Januar 2025**, für alle Kohorten.

Du konzentrierst dich auf den Inhalt. Das Template erledigt den Rest:
- Deckblatt mit allen Pflichtangaben
- Inhaltsverzeichnis, Abkürzungsverzeichnis, Abbildungs-/Tabellenverzeichnis
- Seitennummerierung (Römisch → Arabisch, automatischer Wechsel)
- Ehrenwörtliche Erklärung mit 2025 KI-Klausel
- KI-Verzeichnis (wenn KI-Tools genutzt wurden)

> **Etwas funktioniert nicht?** → [Häufige Probleme](#häufige-probleme)

### Inhalt

- [Was ist Typst?](#was-ist-typst)
- [Schritt 1: Typst installieren](#schritt-1-typst-installieren)
- [Schritt 2: Schriftart installieren](#schritt-2-schriftart-installieren)
- [Schritt 3: Projekt einrichten](#schritt-3-projekt-einrichten--zwei-wege)
- [Schritt 4: Schreiben](#schritt-4-schreiben)
- [Schritt 5: PDF erstellen](#schritt-5-pdf-erstellen)
- [Quellen eintragen](#quellen-eintragen)
- [KI-Tools eintragen](#ki-tools-eintragen-pflicht-bei-ki-nutzung)
- [Gruppenarbeit](#gruppenarbeit)
- [Digitale Unterschrift](#digitale-unterschrift-einbinden-optional)
- [Sperrvermerk](#sperrvermerk)
- [Englische Arbeiten](#englische-arbeiten)
- [Mermaid-Diagramme](#mermaid-diagramme-optional)
- [Pretty Mode](#pretty-mode-optional)
- [Gut zu wissen](#gut-zu-wissen)
- [Alle Parameter](#alle-parameter-im-überblick)
- [Häufige Probleme](#häufige-probleme)
- [Lokale Entwicklung](#lokale-entwicklungkompilierung-für-template-entwickler)

---

## Was ist Typst?

Typst ist ein Schreibwerkzeug — ähnlich wie Word, aber du schreibst in reinen Textdateien (`.typ`) statt in einem grafischen Editor. Das Template übernimmt dann automatisch alle Formatierungen. Die fertigen Dateien kompilierst du per Klick oder Befehl zu einer PDF-Datei.

**Vorteil:** Keine manuelle Formatierungsarbeit, kein Verschieben von Seitenumbrüchen, keine Style-Kämpfe — und das PDF ist in Millisekunden gerendert.

**Typst-Referenz und Dokumentation** → [typst.app/docs](https://typst.app/docs)

---

## Schritt 1: Typst installieren

Das Template benötigt **Typst 0.13.1 oder neuer**.

### macOS

1. Öffne das Terminal (Programme → Dienstprogramme → Terminal)
2. Tippe:
   ```
   brew install typst
   ```
   Falls `brew` nicht vorhanden ist: [https://brew.sh](https://brew.sh) — dort den Installationsbefehl kopieren und ausführen, danach nochmals `brew install typst`

### Windows

1. Öffne PowerShell (Startmenü → „PowerShell" suchen)
2. Tippe:
   ```
   winget install --id Typst.Typst
   ```
   Alternativ: Auf [typst.app/download](https://typst.app/download) die Windows-Installationsdatei herunterladen.

### Linux

```bash
# Ubuntu/Debian:
sudo snap install typst

# Arch:
sudo pacman -S typst

# Oder direkt über cargo:
cargo install typst-cli
```

### Prüfen ob Typst funktioniert

Nach der Installation im Terminal eingeben:
```
typst --version
```
→ Es sollte eine Versionsnummer erscheinen (z.B. `typst 0.14.2`). Ein `(unknown hash)` dahinter kann ignoriert werden.

---

## Schritt 2: Schriftart installieren

Das Template verwendet **Times New Roman** (HWR-Vorschrift).

- **Windows/macOS:** Bereits vorinstalliert — kein Handlungsbedarf.
- **Linux:** Im Terminal:
  ```bash
  sudo apt install ttf-mscorefonts-installer   # Ubuntu/Debian
  # oder:
  sudo apt install fonts-liberation
  ```

---

## Schritt 3: Projekt einrichten — zwei Wege

### Weg A — Typst Universe (ein Befehl)

Führe folgenden Befehl im Terminal aus (in dem Verzeichniss, wo du deinen Projektordner willst):
```bash
typst init @preview/easy-wi-hwr:0.1.2 meine-arbeit
```
→ `meine-arbeit` ist der Titel des Ordners und kann angepasst werden

Das erstellt sofort einen fertigen Projektordner mit einer vorausgefüllten `main.typ`.

### Weg B — interaktives Setup-Script (optional, für Einsteiger)

Das Script stellt dir alle Fragen und erstellt eine vollständig ausgefüllte `main.typ` mit deinen Daten.
Du kannst es nach dem ZIP-Download lokal ausführen:

Auf der GitHub-Seite: **Code → Download ZIP** → entpacken, dann:
```bash
# Terminal in den entpackten Ordner öffnen, dann:
bash scripts/init.sh
```

Das Script fragt dich der Reihe nach:
- Wo soll das Projekt erstellt werden?
- Name des Projektordners
- Art der Arbeit (PTB, Hausarbeit, Bachelorarbeit, …)
- Dein Name und Matrikelnummer
- Titel, Prüfer/in, Betrieb, Fachrichtung, Jahrgang
- Gewünschte Anzahl Kapitel

Am Ende hast du einen fertigen Projektordner mit vorausgefüllter `main.typ`.

> **Hinweis:** Lies das Script kurz durch, bevor du es ausführst: [scripts/init.sh](https://github.com/lultoni/easy-wi-hwr/blob/main/scripts/init.sh)

---

## Schritt 4: Schreiben

Öffne den Projektordner in einem Texteditor. Empfohlen: **VS Code** (kostenlos, [code.visualstudio.com](https://code.visualstudio.com)) mit der **Tinymist**-Erweiterung für Syntax-Highlighting, aber es kann auch in jedem anderen Texteditor gemacht werden.

```
meine-arbeit/
├── main.typ            ← deine Metadaten (Titel, Name, …) — hier arbeitest du
├── refs.bib            ← deine Quellen
├── kapitel/
│   ├── 01_einleitung.typ   ← hier schreibst du
│   ├── 02_theoretische_grundlagen.typ
│   └── ...
└── anhang/
    └── beispiel.typ        ← Anhang-Vorlage
```

**Schreiben in den Kapitel-Dateien:**
```typst
= Einleitung

Hier beginnt der Text des ersten Kapitels.

== Hintergrund

*Fettschrift* und _Kursivschrift_ funktionieren so.

Fußnote#footnote[Hier steht der Fußnotentext.] direkt im Text.

Zitat aus einer Quelle: Laut @mustermann2024 gilt...

Abkürzung beim ersten Vorkommen: #abk("KI")
```

**Abkürzungen** funktionieren vollautomatisch:
- Erste Verwendung: `#abk("KI")` → gibt aus „Künstliche Intelligenz (KI)"
- Alle weiteren: `#abk("KI")` → gibt aus „KI"
- Das Abkürzungsverzeichnis wird automatisch erstellt

Die Abkürzungen trägst du einmalig in `main.typ` ein:
```typst
abbreviations: (
  "KI":  "Künstliche Intelligenz",
  "HWR": "Hochschule für Wirtschaft und Recht Berlin",
  "ERP": "Enterprise Resource Planning",
),
```

**Alternative: Alles in einer Datei** — Du kannst auch ohne separate Kapitel-Dateien arbeiten. Lass `chapters:` leer und schreibe deinen gesamten Text direkt in `main.typ` nach dem Einstellungsblock. Zwischen Kapiteln `#pagebreak()` einfügen, damit jedes auf einer neuen Seite beginnt (bei `chapters:` passiert das automatisch):

```typst
#show: hwr.with(
  doc-type: "ptb-1",
  title: "Mein Titel",
  // ... restliche Einstellungen ...
)

= Einleitung

Hier beginnt mein Text direkt in main.typ.

#pagebreak()
= Grundlagen

Zweites Kapitel...
```

Für kürzere Arbeiten (z.B. Hausarbeiten) ist das oft einfacher. Für längere Arbeiten empfehlen sich separate Dateien in `kapitel/`.

---

## Schritt 5: PDF erstellen

```bash
# Im Projektordner (z.B. cd meine-arbeit):

# Einmalig erstellen:
typst compile main.typ

# Mit Live-Kompilierung (aktualisiert bei jedem Speichern):
typst watch main.typ
# Beenden: Ctrl+C
```

Die fertige PDF liegt direkt neben `main.typ`.

### VS Code + Tinymist

Tinymist liefert Syntax-Highlighting und Autocomplete für `.typ`-Dateien. Du kannst auch direkt aus VS Code heraus kompilieren — Tinymist zeigt eine Live-Vorschau im Editor-Fenster.

---

## Quellen eintragen

Quellen gehören in die Datei `refs.bib`. Format-Beispiele (Citavi, Zotero oder Google Scholar können diese Dateien automatisch exportieren):

```bibtex
@book{mustermann2024,
  author    = {Mustermann, Max},
  title     = {Titel des Buches},
  year      = {2024},
  publisher = {Verlag},
}

@online{quelle2024,
  author  = {Autor, Vorname},
  title   = {Titel der Webseite},
  year    = {2024},
  url     = {https://beispiel.de},
  urldate = {2024-01-01},
}
```

Im Text zitierst du mit `@schlüssel`, also z.B. `@mustermann2024`.

---

## KI-Tools eintragen (Pflicht bei KI-Nutzung)

Wenn du KI-Tools wie ChatGPT, Copilot oder DeepL verwendet hast, musst du das laut HWR §3.8 angeben.
In `main.typ`:

```typst
ai-tools: (
  (
    tool:     "ChatGPT 4o",
    usage:    "Textvorschläge, im Text gekennzeichnet",
    chapters: "Kapitel 1, S. 3",
    remarks:  "Prompts: siehe Anhang 1",  // auch "bemerkungen:" funktioniert
  ),
  (
    tool:     "DeepL Translator",
    usage:    "Übersetzung englischer Quellabschnitte",
    chapters: "Gesamte Arbeit",
  ),
),
```

Das KI-Verzeichnis wird automatisch als letztes Anhang-Item eingefügt. Bei `ai-tools: ()` erscheint kein Verzeichnis.

---

## Gruppenarbeit

Einfach weitere Autoren eintragen:

```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678"),
  (name: "Lisa Müller",    matrikel: "87654321"),
),
```

Die Ehrenwörtliche Erklärung wechselt automatisch auf „Wir erklären…" und beide Autoren erhalten ein Unterschriftsfeld.

**Nur eine stellvertretende Unterschrift** (z.B. bei digitaler Abgabe im Namen der Gruppe — bitte mit dem Prüfer abklären):

```typst
group-signature: false,  // nur erster Autor unterschreibt
```

Das Template zeigt dann einen gelben Hinweis im PDF, der daran erinnert, dies mit dem Prüfer abzusprechen.

---

## Digitale Unterschrift einbinden (optional)

Statt einer leeren Linie zum handschriftlichen Unterschreiben kannst du ein Bild deiner Unterschrift einbinden:

1. Unterschrift auf weißem Papier, einscannen oder abfotografieren
2. Als PNG oder SVG unter `images/` im Projektordner speichern
3. In `main.typ` beim Autoren-Eintrag ergänzen:

```typst
authors: (
  (name: "Max Mustermann", matrikel: "12345678", signature: image("images/signatur_max.png")),
),
```

Das Bild erscheint dann automatisch im Unterschriftsfeld der Ehrenwörtlichen Erklärung.

---

## Sperrvermerk

Falls Teile der Arbeit vertraulich sind (§3.2.1):

```typst
// Gesamte Arbeit gesperrt:
confidential: true,

// Nur bestimmte Kapitel:
confidential: (
  chapters: (
    (number: "3", title: "Methodik"),
    (number: "4", title: "Ergebnisse"),
  ),
  filename: "PTB_Mustermann_oeffentlich.pdf",  // optional
),
```

Der Pflichttext wird automatisch eingefügt und erscheint vor dem Deckblatt.

---

## Englische Arbeiten

```typst
lang: "en",
citation-style: "harvard-anglia-ruskin-university",
```

Alle Verzeichnisüberschriften, die Ehrenwörtliche Erklärung und das KI-Verzeichnis wechseln automatisch auf Englisch. Die Harvard-CSL-Datei (Anglia Ruskin University) ist im Template enthalten und wird automatisch geladen — kein manueller Download nötig (HWR §6).

> **Tipp:** Setze `declaration-lang: "de"` damit die Ehrenwörtliche Erklärung auf Deutsch bleibt — das ist rechtlich die sichere Variante. Ob eine englische Erklärung akzeptiert wird, ist nicht verbindlich geklärt.

---

## Mermaid-Diagramme (optional)

Du kannst Mermaid-Diagramme direkt in Typst einbetten — ohne externe Tools. Das Package `mmdr` rendert Mermaid-Syntax nativ im Dokument:

```typst
#import "@preview/mmdr:0.2.1": mermaid

#figure(
  mermaid("graph TD
    A[Literaturrecherche] --> B[Hypothesenbildung]
    B --> C{Quantitativ?}
    C -->|Ja| D[Fragebogen]
    C -->|Nein| E[Interview]
  "),
  caption: [Forschungsprozess.],
)
```

Unterstützt werden 23 Diagramm-Typen: Flowcharts, Sequenzdiagramme, Klassendiagramme, ER-Diagramme, Gantt-Charts, Mindmaps, Pie Charts u.v.m.

> **Hinweis:** `mmdr` nutzt eine Rust-Implementierung von Mermaid — die visuelle Ausgabe kann in Randfällen leicht von mermaid.js abweichen. Wenn du pixelgenaue mermaid.js-Kompatibilität brauchst, rendere die Diagramme extern als SVG und binde sie per `image()` ein.

Details: [typst.app/universe/package/mmdr](https://typst.app/universe/package/mmdr)

---

## Pretty Mode (optional)

Du kannst ein dekoratives Deckblatt und einen Logo-Header aktivieren:

```typst
style: "pretty",
school-logo: image("images/school-logo.svg", height: 1.2cm),
company-logo: image("images/company-logo.svg", height: 1.2cm),
```

**Wichtig:** Der Pretty Mode ist **nicht in den HWR-Richtlinien vorgesehen**. Bitte vor Verwendung mit dem/der Betreuer/in absprechen.

Du kannst auch einzelne Features unabhängig aktivieren:
- `pretty-title: true` — nur dekoratives Deckblatt (Zierlinien, größerer Titel)
- `school-logo:` / `company-logo:` — nur Logo-Header im Haupttext

Standard ist `style: "compliant"` (richtlinienkonform).

---

## Gut zu wissen

**Zitierstil-Wahl:** Standard ist APA (für deutschsprachige Arbeiten). Für englischsprachige Arbeiten: `citation-style: "harvard-anglia-ruskin-university"` — die CSL-Datei ist im Template enthalten. Wenn dein Betreuer einen anderen Stil vorgibt, kannst du eine eigene `.csl`-Datei aus dem [Zotero Style Repository](https://www.zotero.org/styles) herunterladen und per `read()` einbinden:
```typst
citation-style: read("mein-stil.csl"),
```
`read()` wird in `main.typ` aufgelöst — der Pfad ist also relativ zu `main.typ`.

**Abkürzungsverzeichnis erscheint automatisch**, aber nur wenn:
- Abkürzungen in `abbreviations:` eingetragen sind, UND
- `#abk("XY")` mindestens einmal im Text verwendet wird

Nicht verwendete Abkürzungen tauchen im Verzeichnis nicht auf.

**Abbildungs- und Tabellenverzeichnis** erscheinen erst ab 5 Einträgen (HWR-Anforderung). Das Template prüft das automatisch.

**Abgabe als Word + PDF:** Die HWR verlangt bei Bachelorarbeiten beide Formate. Das Template erzeugt nur PDF. Für die Word-Version gibt es mehrere Wege:
- **PDF → Word:** Adobe Acrobat (bestes Ergebnis), oder kostenlose Online-Tools (z.B. SmallPDF, iLovePDF) — Formatierung kann abweichen
- **Pandoc:** `pandoc main.typ -o arbeit.docx` — experimentell, verliert teils Formatierung
- **Copy-Paste:** PDF in Word öffnen (Word kann PDFs importieren) — oft die pragmatischste Lösung für einfache Dokumente

Die Word-Version dient meist nur der Archivierung — die Formatierung muss nicht perfekt sein.

---

## Alle Parameter im Überblick

### Pflichtfelder

| Parameter | Beschreibung |
|---|---|
| `doc-type` | Art der Arbeit: `"ptb-1"`, `"ptb-2"`, `"ptb-3"`, `"hausarbeit"`, `"studienarbeit"`, `"bachelorarbeit"` |
| `title` | Titel der Arbeit |
| `name` | Dein Name (Kurzform für Einzelperson — äquivalent zu `authors: (name: "...", matrikel: "...")`) |
| `matrikel` | Deine Matrikelnummer (zusammen mit `name:` verwenden) |
| `authors` | Alternativ: Array von Autoren: `((name: "...", matrikel: "..."),)` — für Gruppenarbeit oder wenn `name:`/`matrikel:` nicht verwendet |

### Je nach Dokumenttyp Pflicht

| Parameter | Pflicht für | Beschreibung |
|---|---|---|
| `supervisor` | Alle außer Bachelorarbeit | Betreuende/r Prüfer/in mit Titel |
| `company` | Alle außer Bachelorarbeit | Name des Ausbildungsbetriebs |
| `first-examiner` | Bachelorarbeit | Erstgutachter/in mit Titel |
| `second-examiner` | Bachelorarbeit | Zweitgutachter/in mit Titel |

### Optionale Felder

| Parameter | Standard | Beschreibung |
|---|---|---|
| `lang` | `"de"` | Dokumentsprache — `"de"` oder `"en"` |
| `field-of-study` | `"Wirtschaftsinformatik"` | Fachrichtung |
| `cohort` | — | Studienjahrgang, z.B. `"2024"` |
| `semester` | — | Studienhalbjahr, z.B. `"3"` |
| `date` | `auto` | Abgabedatum; `auto` = heutiges Datum, oder manuell: `"15. März 2026"` |
| `abstract` | `none` | Zusammenfassung vor dem Inhaltsverzeichnis |
| `confidential` | `none` | Sperrvermerk — `none`, `true` oder `(chapters: (...), filename: ...)` |
| `abbreviations` | `(:)` | Abkürzungen als Dictionary |
| `glossary` | `()` | Glossareinträge für erklärungsbedürftige Fachbegriffe (ohne eigene Abkürzung) |
| `ai-tools` | `()` | KI-Verzeichnis-Einträge — `(tool, usage, chapters, remarks?)` |
| `chapters` | `()` | Kapitel-Dateien via `include()` in gewünschter Reihenfolge |
| `appendix` | `()` | Anhang-Einträge: `(title: "...", content: include(...))` |
| `show-appendix-toc` | `false` | `true` = optionales Anhangsverzeichnis vor den Anhang-Einträgen (HWR §3.10) |
| `bibliography` | — | `bibliography("refs.bib")` — Titel wird automatisch gesetzt |
| `citation-style` | `"apa"` | Zitierstil: `"apa"` (DE), `"harvard-anglia-ruskin-university"` (EN, mitgeliefert), oder `read("datei.csl")` |
| `heading-depth` | `4` | TOC-Tiefe 1–4 (max. 4 laut HWR) |
| `declaration-lang` | `auto` | Sprache der Ehrenwörtlichen Erklärung — `auto` folgt `lang`, `"de"` immer Deutsch (empfohlen — rechtssicher) |
| `city` | `"Berlin"` | Ort im Unterschriftsfeld der Ehrenwörtlichen Erklärung |
| `group-signature` | `auto` | `auto`/`true` = alle Autoren unterschreiben; `false` = nur erster Autor |
| `style` | `"compliant"` | `"compliant"` (HWR-konform) oder `"pretty"` (dekorativ, mit Betreuer absprechen) |
| `school-logo` | `none` | Logo links im Seitenkopf, z.B. `image("images/logo.png", height: 1.2cm)` |
| `company-logo` | `none` | Logo rechts im Seitenkopf |
| `pretty-title` | `none` | `true` = dekoratives Deckblatt; überschreibt `style:` für das Deckblatt |

### Felder im `authors`-Array

| Feld | Pflicht | Beschreibung |
|---|---|---|
| `name` | Ja | Vollständiger Name |
| `matrikel` | Ja | Matrikelnummer |
| `signature` | Nein | Unterschriften-Bild als Content, z.B. `image("images/signatur.png")` |

---

## Häufige Probleme

| Problem | Lösung |
|---|---|
| `doc-type "..." ist ungültig` | Wert muss exakt `"ptb-1"`, `"ptb-2"`, `"ptb-3"`, `"hausarbeit"`, `"studienarbeit"` oder `"bachelorarbeit"` sein |
| `supervisor ist Pflicht für...` | Für alle Typen außer `"bachelorarbeit"` müssen `supervisor:` und `company:` gesetzt sein |
| `authors must be an array of dicts` | `authors:` muss ein Array sein: `authors: ((name: "...", matrikel: "..."),)` — bei einem Autor das Komma nach der Klammer nicht vergessen! |
| `chapters entries must use include()` | Keine String-Pfade verwenden. Richtig: `chapters: (include("kapitel/01.typ"),)` statt `chapters: ("kapitel/01.typ",)` |
| Times New Roman fehlt (Linux) | `sudo apt install ttf-mscorefonts-installer` |
| Abkürzung erscheint nicht im Verzeichnis | `#abk("XY")` muss im Text vorkommen — nur verwendete Abkürzungen erscheinen |
| KI-Verzeichnis fehlt | `ai-tools:` braucht mindestens einen Eintrag; bei `ai-tools: ()` erscheint kein Verzeichnis |
| Abbildungsverzeichnis fehlt | Erscheint erst ab 5 Abbildungen (HWR-Anforderung) |
| Kapitel erscheint nicht im PDF | Prüfe ob die Datei in der `chapters:`-Liste in `main.typ` eingetragen ist |
| Import-Fehler bei `include()` | Pfade in `chapters:` sind relativ zu `main.typ` — `include("kapitel/01_einleitung.typ")` |
| `signature muss image-Content sein` | Verwende `signature: image("images/sig.png")` statt `signature: "images/sig.png"` |
| Alle Seiten doppelt / seltsame Formatierung | Nur ein `#show: hwr.with(...)` Block pro Datei — kein zweites `#show:` und kein Text davor |

---

## Lokale Entwicklung/Kompilierung (für Template-Entwickler)

Wenn du am Template selbst arbeitest (nicht als Nutzer), musst du die Imports umschalten:

**Schritt 1: Imports auf lokal umstellen**

In `template/main.typ`:
```typst
// Diese Zeile auskommentieren:
// #import "@preview/easy-wi-hwr:0.1.2": hwr, abk, gls, glspl
// Diese Zeile aktivieren:
#import "../lib.typ": hwr, abk, gls, glspl
```

In `template/kapitel/01_einleitung.typ` (und allen anderen Kapitel-Dateien die `abk` nutzen):
```typst
// #import "@preview/easy-wi-hwr:0.1.2": abk
#import "../../lib.typ": abk
```

**Schritt 2: Kompilieren**

```bash
# Repository klonen:
git clone https://github.com/lultoni/easy-wi-hwr.git
cd easy-wi-hwr

# Template kompilieren (--root . ist nötig, damit Typst ../lib.typ auflösen kann):
typst compile --root . template/main.typ

# Live-Preview:
typst watch --root . template/main.typ
```

**Vor dem Commit / Publish:** Imports wieder auf `@preview/` zurückschalten, damit Nutzer keine Fehler bekommen.

---

## Lizenz

MIT — siehe LICENSE
