// template/main.typ — Beispiel-Dokument für das HWR Berlin Typst Template
// Ersetze alle Beispieldaten durch deine eigenen Angaben.
//
// Alle Formatierung erfolgt automatisch. Du arbeitest nur in dieser Datei
// und in deinen Kapiteldateien unter kapitel/.

#import "../lib.typ": hwr, abk, gls, glspl

#show: hwr.with(
  // === PFLICHTFELDER ===
  doc-type: "ptb-1",
  // Erlaubte Werte: "ptb-1" | "ptb-2" | "ptb-3" |
  //                "hausarbeit" | "studienarbeit" | "bachelorarbeit"

  title: "Digitale Transformation im Mittelstand: Chancen und Herausforderungen",

  authors: (
    (name: "Max Mustermann", matrikel: "12345678"),
    // Weitere Autoren bei Gruppenarbeit:
    // (name: "Lisa Müller", matrikel: "87654321"),
  ),

  // === BEDINGT PFLICHT ===
  // Für ptb-*/hausarbeit/studienarbeit:
  supervisor: "Prof. Dr. Anna Muster",
  company:    "Muster GmbH",

  // Für bachelorarbeit (auskommentieren wenn nicht benötigt):
  // first-examiner:  "Prof. Dr. Anna Muster",
  // second-examiner: "Prof. Dr. Ben Beispiel",

  // === OPTIONALE FELDER ===
  lang: "de",                          // "de" (default) | "en"
  field-of-study: "Wirtschaftsinformatik",
  cohort:   "2024",                    // Studienjahrgang
  semester: "3",                       // Studienhalbjahr

  date: auto,                          // auto = heutiges Datum | "15. März 2026" = manuell

  // Abstract (optional — auskommentieren wenn nicht benötigt):
  abstract: [
    Diese Arbeit untersucht die digitale Transformation im deutschen Mittelstand.
    Im Fokus stehen die zentralen Herausforderungen bei der Einführung von
    ERP-Systemen sowie die Erfolgsfaktoren für eine nachhaltige Digitalisierungsstrategie.
  ],

  // Sperrvermerk (auskommentieren wenn nicht benötigt):
  // confidential: none,                            // kein Sperrvermerk (default)
  // confidential: true,                            // gesamte Arbeit gesperrt
  // confidential: (                                // bestimmte Kapitel gesperrt:
  //   chapters: (
  //     (number: "3", title: "Methodik"),
  //     (number: "4", title: "Ergebnisse"),
  //   ),
  //   filename: "PTB_Mustermann_public.pdf",       // optional
  // ),

  // Abkürzungen (werden nur angezeigt wenn im Text mit #abk() verwendet):
  abbreviations: (
    "HWR":  "Hochschule für Wirtschaft und Recht Berlin",
    "KI":   "Künstliche Intelligenz",
    "ERP":  "Enterprise Resource Planning",
    "API":  "Application Programming Interface",
    "PTB":  "Praxistransferbericht",
  ),

  // Glossar (für erklärungsbedürftige Fachbegriffe ohne eigene Abkürzung):
  // glossary: (
  //   (key: "stakeholder", short: "Stakeholder", long: "Stakeholder",
  //    description: "Interessengruppen, die von einem Projekt betroffen sind."),
  // ),

  // KI-Verzeichnis (Pflicht wenn KI-Tools verwendet, §3.8):
  // ai-tools: (),                                  // leer = kein KI-Verzeichnis (default)
  ai-tools: (
    (
      tool:       "ChatGPT 4o",
      usage:      "Textvorschläge für Einleitung, im Text gekennzeichnet",
      chapters:   "Kapitel 1, S. 3",
      bemerkungen: "Prompts: siehe Anhang A",
    ),
    (
      tool:     "DeepL Translator",
      usage:    "Übersetzung englischer Quellabschnitte",
      chapters: "Gesamte Arbeit",
    ),
  ),

  // Kapitel in der gewünschten Reihenfolge:
  // include() wird hier (in main.typ) aufgerufen, daher sind Pfade relativ zu main.typ.
  chapters: (
    include("kapitel/01_einleitung.typ"),
    include("kapitel/02_grundlagen.typ"),
    include("kapitel/03_methodik.typ"),
    include("kapitel/04_ergebnisse.typ"),
    include("kapitel/05_fazit.typ"),
  ),

  // Anhang (optional — auskommentieren wenn nicht benötigt):
  appendix: (
    (title: "Interviewleitfaden",  content: include("anhang/a_interviewleitfaden.typ")),
    (title: "Rohdaten Umfrage",    content: include("anhang/b_rohdaten.typ")),
    (title: "Screenshot Dashboard", content: include("anhang/c_abbildung.typ")),
    // Bild direkt einbinden:
    // (title: "Diagramm", content: image("anhang/diagramm.png")),
  ),

  // Bibliographie:
  bibliography: bibliography("refs.bib"),
  citation-style: "apa",
  // Zitierstile: "apa" (DE default) | "harvard-anglia-ruskin-university" (EN) | "pfad/zur/datei.csl"

  // Weitere Einstellungen:
  heading-depth: 4,       // TOC-Tiefe: 1–4 (default: 4)
  declaration-lang: auto, // auto = folgt lang | "de" = immer Deutsch (rechtssicher)
)

// HINWEIS: Alles ab hier ist Haupttextinhalt.
// Deine Kapitel werden über die chapters:-Liste eingebunden.
// Du kannst hier nichts schreiben — der Inhalt kommt aus kapitel/.
