# HWR Berlin — Typst-Template

Automatische Formatierung für Praxistransferberichte, Haus-/Studien- und Bachelorarbeiten an der HWR Berlin.
Konform mit den HWR-Richtlinien **Stand Januar 2025** — für alle Kohorten.

Du konzentrierst dich auf den Inhalt. Das Template erledigt den Rest:
- Deckblatt mit allen Pflichtangaben
- Inhaltsverzeichnis, Abkürzungsverzeichnis, Abbildungs-/Tabellenverzeichnis
- Seitennummerierung (Römisch → Arabisch, automatischer Wechsel)
- Ehrenwörtliche Erklärung mit 2025 KI-Klausel
- KI-Verzeichnis (wenn KI-Tools genutzt wurden)

---

## Was ist Typst?

Typst ist ein Schreibwerkzeug — ähnlich wie Word, aber du schreibst in reinen Textdateien (`.typ`) statt in einem grafischen Editor. Das Template übernimmt dann automatisch alle Formatierungen. Die fertigen Dateien kompilierst du per Klick oder Befehl zu einer PDF-Datei.

**Vorteil:** Keine manuelle Formatierungsarbeit, kein Verschieben von Seitenumbrüchen, keine Style-Kämpfe.

---

## Schritt 1: Typst installieren

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
→ Es sollte eine Versionsnummer erscheinen (z.B. `typst 0.13.1`).

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

## Schritt 3: Template herunterladen

Auf der GitHub-Seite oben rechts auf **Code → Download ZIP** klicken.
ZIP entpacken — du erhältst einen Ordner `hwr-typst-template-main/` (oder ähnlich).

**Alternativ direkt im Terminal** (macOS/Linux — kein ZIP nötig):

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/lultoni/hwr-typst-template/main/scripts/init.sh)
```

Dieser Befehl lädt das Setup-Script herunter und führt es sofort aus — du wirst nach deinen Daten gefragt und bekommst einen fertigen Projektordner, ohne erst das komplette Repository herunterladen zu müssen.

> Sicherheitshinweis: Bevor du ein Script aus dem Internet direkt ausführst, kannst du es dir unter dem obigen Link ansehen.

---

## Schritt 4: Projekt einrichten — ein einziger Befehl

Öffne ein Terminal im Ordner `hwr-typst-template-main/`:
- **macOS/Linux:** Terminal öffnen, dann `cd /pfad/zum/ordner/hwr-typst-template-main` eingeben.
  Tipp: Den Ordner aus dem Finder ins Terminal-Fenster ziehen — der Pfad wird automatisch eingetragen.
- **Windows:** Im Explorer in den Ordner wechseln, dann Rechtsklick → „Im Terminal öffnen".

Dann:
```bash
bash scripts/init.sh
```

Das Skript fragt dich der Reihe nach nach deinen Daten:
- Name des Projektordners
- Art der Arbeit (PTB, Hausarbeit, Bachelorarbeit, …)
- Dein Name und Matrikelnummer
- Titel der Arbeit
- Betreuende/r Prüfer/in (oder Gutachter für Bachelorarbeit)
- Ausbildungsbetrieb
- Fachrichtung, Jahrgang, Semester
- Gewünschte Anzahl Kapitel

Am Ende hast du einen fertigen Projektordner mit allen Dateien — inklusive vorausgefüllter `main.typ`.

---

## Schritt 5: Schreiben

Öffne den neu erstellten Projektordner in einem Texteditor. Empfohlen: **VS Code** (kostenlos, [code.visualstudio.com](https://code.visualstudio.com)) mit der **Tinymist**-Erweiterung — dann wird die PDF-Vorschau automatisch beim Speichern aktualisiert.

```
DEIN-PROJEKT/
├── main.typ            ← deine Metadaten (Titel, Name, …) — schon ausgefüllt
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

---

## Schritt 6: PDF erstellen

### Im Terminal (empfohlen)

```bash
# Aus dem Ordner hwr-typst-template-main heraus:

# Einmalig erstellen:
typst compile DEIN-PROJEKTNAME/main.typ

# Mit Live-Vorschau (aktualisiert bei jedem Speichern):
typst watch DEIN-PROJEKTNAME/main.typ
# Beenden: Ctrl+C (macOS/Linux) oder Strg+C (Windows)
```

Die fertige PDF liegt direkt neben `main.typ`.

### VS Code + Tinymist

Tinymist liefert Syntax-Highlighting und Autocomplete für `.typ`-Dateien — praktisch beim Schreiben. Für die PDF-Erstellung ist das Terminal der direktere Weg.

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

Die Ehrenwörtliche Erklärung wechselt automatisch auf „Wir erklären…".

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

Alle Verzeichnisüberschriften, die Ehrenwörtliche Erklärung und das KI-Verzeichnis wechseln automatisch auf Englisch.

---

## Alle Parameter im Überblick

### Pflichtfelder

| Parameter | Beschreibung |
|---|---|
| `doc-type` | Art der Arbeit — `"ptb-1"`, `"ptb-2"`, `"ptb-3"`, `"hausarbeit"`, `"studienarbeit"`, `"bachelorarbeit"` |
| `title` | Titel der Arbeit |
| `authors` | Array: `((name: "...", matrikel: "..."),)` |

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
| `date` | `auto` | Abgabedatum; `auto` = heutiges Datum |
| `abstract` | — | Zusammenfassung vor dem Inhaltsverzeichnis |
| `confidential` | — | Sperrvermerk — siehe oben |
| `abbreviations` | `(:)` | Abkürzungen als Dictionary |
| `glossary` | `()` | Glossareinträge (via glossarium) |
| `ai-tools` | `()` | KI-Verzeichnis-Einträge |
| `chapters` | `()` | Kapitel-Dateien via `include()` |
| `appendix` | `()` | Anhang-Einträge: `(title: "...", content: ...)` |
| `bibliography` | — | `bibliography("refs.bib")` |
| `citation-style` | `"apa"` | Zitierstil |
| `heading-depth` | `4` | TOC-Tiefe (max. 4 laut HWR) |
| `declaration-lang` | `auto` | Sprache der Erklärung (`"de"` empfohlen) |

---

## Häufige Probleme

| Problem | Lösung |
|---|---|
| `doc-type "..." ist ungültig` | Wert muss exakt `"ptb-1"`, `"ptb-2"`, `"ptb-3"`, `"hausarbeit"`, `"studienarbeit"` oder `"bachelorarbeit"` sein |
| `supervisor ist Pflicht für...` | Für alle Typen außer `"bachelorarbeit"` müssen `supervisor:` und `company:` gesetzt sein |
| Times New Roman fehlt | Auf Linux: `sudo apt install ttf-mscorefonts-installer` |
| Abkürzung erscheint nicht im Verzeichnis | `#abk("XY")` muss im Text vorkommen — nur verwendete Abkürzungen erscheinen |
| KI-Verzeichnis fehlt | `ai-tools:` braucht mindestens einen Eintrag |
| Abbildungsverzeichnis fehlt | Erscheint erst ab 5 Abbildungen (HWR-Anforderung) |
| PDF wird nicht aktualisiert | `typst compile PROJEKTNAME/main.typ` aus dem Template-Hauptordner ausführen, nicht aus dem Projektunterordner |

---

## Lizenz

MIT — siehe LICENSE
