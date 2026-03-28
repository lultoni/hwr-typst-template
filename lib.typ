// HWR Berlin — Typst Template
// Compliant with HWR Richtlinien January 2025 (all cohorts / Wirtschaftsinformatik)
//
// Public API:
//   #show: hwr.with(...)
//
// All parameters: see requirements/api-design.md

#import "@preview/linguify:0.5.0": linguify, linguify-raw, set-database, load-ftl-data
#import "@preview/glossarium:0.5.10": make-glossary, print-glossary, gls, glspl

#import "helper/date.typ": format-date

// ---------------------------------------------------------------------------
// Internal stub page renderers — replaced in Phase 2 by real implementations
// ---------------------------------------------------------------------------

#let _stub-confidentiality(confidential, company, title, authors, date, lang) = []
#let _stub-title-page(doc-type, title, authors, supervisor, company, first-examiner, second-examiner, field-of-study, cohort, semester, date, lang) = []
#let _stub-abstract(abstract, lang) = []
#let _stub-indices(abbreviations, glossary, lang) = []
#let _stub-body-chapters(chapters) = []
#let _stub-glossary-section(glossary, lang) = []
#let _stub-appendix(appendix, ai-tools, lang) = []
#let _stub-declaration(authors, declaration-lang, lang) = []

// ---------------------------------------------------------------------------
// Validation helpers
// ---------------------------------------------------------------------------

#let _assert-not-none(value, name) = {
  assert(value != none, message: name + " ist ein Pflichtfeld und darf nicht none sein.")
}

#let _assert-doc-type(doc-type) = {
  let valid = ("ptb-1", "ptb-2", "ptb-3", "hausarbeit", "studienarbeit", "bachelorarbeit")
  assert(
    doc-type in valid,
    message: "doc-type \"" + doc-type + "\" ist ungültig. Erlaubte Werte: " + valid.join(", "),
  )
}

#let _validate(doc-type, title, authors, supervisor, company, first-examiner, second-examiner) = {
  _assert-doc-type(doc-type)
  _assert-not-none(title, "title")
  assert(authors.len() > 0, message: "authors muss mindestens einen Eintrag enthalten.")

  let needs-supervisor = doc-type in ("ptb-1", "ptb-2", "ptb-3", "hausarbeit", "studienarbeit")
  if needs-supervisor {
    assert(
      supervisor != none,
      message: "supervisor ist Pflicht für doc-type \"" + doc-type + "\".",
    )
    assert(
      company != none,
      message: "company ist Pflicht für doc-type \"" + doc-type + "\".",
    )
  }

  if doc-type == "bachelorarbeit" {
    assert(
      first-examiner != none,
      message: "first-examiner ist Pflicht für bachelorarbeit.",
    )
    assert(
      second-examiner != none,
      message: "second-examiner ist Pflicht für bachelorarbeit.",
    )
  }
}

// ---------------------------------------------------------------------------
// Main template function
// ---------------------------------------------------------------------------

/// Main entry point for the HWR Berlin Typst template.
///
/// Usage:
///   #show: hwr.with(
///     doc-type: "ptb-1",
///     title: "Mein Titel",
///     authors: ((name: "Max Mustermann", matrikel: "12345678"),),
///     supervisor: "Prof. Dr. Muster",
///     company: "Muster GmbH",
///   )
///
/// See requirements/api-design.md for the full parameter reference.
#let hwr(
  // === PFLICHTFELDER ===
  doc-type: none,
  title: none,
  authors: (),

  // === BEDINGT PFLICHT (je nach doc-type) ===
  supervisor: none,
  company: none,
  first-examiner: none,
  second-examiner: none,

  // === OPTIONALE FELDER ===
  lang: "de",
  field-of-study: "Wirtschaftsinformatik",
  cohort: none,
  semester: none,
  date: auto,

  abstract: none,
  confidential: none,

  abbreviations: (:),
  glossary: (),
  ai-tools: (),

  chapters: (),
  appendix: (),

  bibliography: none,
  citation-style: "apa",

  heading-depth: 4,
  declaration-lang: auto,

  // show-rule body (passed automatically by #show: hwr.with(...))
  body,
) = {

  // --- Validation ---
  _validate(doc-type, title, authors, supervisor, company, first-examiner, second-examiner)

  // --- Resolve date ---
  let resolved-date = format-date(date, lang: lang)

  // --- Resolve declaration language ---
  let decl-lang = if declaration-lang == auto { lang } else { declaration-lang }

  // --- linguify: configure l10n database ---
  // load-ftl-data reads l10n/de.ftl and l10n/en.ftl and registers both languages.
  // linguify() then picks the correct language based on the active text lang.
  show: set-database.with(eval(load-ftl-data("./l10n", ("de", "en"))))

  // --- Global page setup ---
  set page(
    paper: "a4",
    margin: (top: 30mm, right: 35mm, bottom: 20mm, left: 21mm),
    numbering: none,
  )

  // --- Global text & paragraph setup ---
  set text(font: "Times New Roman", size: 12pt, lang: lang)

  // 1.5-line spacing:
  // Typst "leading" is the distance from baseline to baseline of adjacent lines.
  // For 12pt text, 1.5× = 18pt. Typst default leading is ~0.65em.
  // We set leading to 0.65em (approx 7.8pt on top of 12pt cap-height) which together
  // with the 12pt font produces the ~18pt line rhythm expected by HWR.
  // Additionally, set paragraph spacing equal to one line (matching Word's 1.5 spacing).
  set par(justify: true, leading: 0.65em)
  set block(spacing: 1.5em)

  // Footnotes and captions: 10pt (FMT-07, FMT-08)
  show footnote.entry: set text(size: 10pt)
  show figure.caption: set text(size: 10pt)

  // Heading numbering: decimal system "1.1.1" up to heading-depth (STR-20, STR-21)
  // Headings deeper than heading-depth remain unnumbered.
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() <= heading-depth {
      n.map(str).join(".") + "  "
    }
  })

  // TOC depth follows heading-depth
  set outline(depth: heading-depth, indent: 1em)

  // --- glossarium setup (must be before body) ---
  if glossary.len() > 0 {
    show: make-glossary
  }

  // ---------------------------------------------------------------------------
  // Document structure
  // ---------------------------------------------------------------------------

  // 1. Sperrvermerk (vor Deckblatt, keine Seitennummer, nicht in Zählung — CNT-20, STR-01)
  if confidential != none {
    _stub-confidentiality(confidential, company, title, authors, resolved-date, lang)
  }

  // 2. Deckblatt: Seitenzähler startet bei I (röm.), aber Nummer nicht sichtbar (STR-02)
  counter(page).update(1)
  set page(numbering: none)
  _stub-title-page(
    doc-type, title, authors,
    supervisor, company, first-examiner, second-examiner,
    field-of-study, cohort, semester, resolved-date, lang,
  )

  // 3. Vorspann: Römische Seitennummerierung sichtbar (STR-03 ff.)
  set page(numbering: "I")

  // 3a. Abstract (optional, eigene Seite, kein TOC-Eintrag — api-design §8b)
  if abstract != none {
    _stub-abstract(abstract, lang)
  }

  // 3b. Verzeichnisse: TOC, Abkürzungen, Abb.-/Tab.-Verzeichnis (STR-03–STR-06)
  _stub-indices(abbreviations, glossary, lang)

  // 4. Haupttext: Arabische Seitennummerierung ab 1 (STR-07)
  counter(page).update(1)
  set page(numbering: "1")
  _stub-body-chapters(chapters)
  body

  // 5. Glossar (nach Haupttext, vor Literaturverzeichnis — STR-11)
  if glossary.len() > 0 {
    _stub-glossary-section(glossary, lang)
  }

  // 6. Literaturverzeichnis (STR-08)
  // The user passes: bibliography: bibliography("refs.bib")
  // citation-style is applied via the style parameter — since we cannot modify the
  // bibliography() call after the fact, we render it directly and rely on the
  // citation-style parameter being documented for the user to set correctly.
  // Phase 4 will revisit if a cleaner override mechanism is needed.
  if bibliography != none {
    bibliography
  }

  // 7. Anhang: user-Einträge + KI-Verzeichnis automatisch als letztes Item (STR-09, STR-12)
  if appendix.len() > 0 or ai-tools.len() > 0 {
    _stub-appendix(appendix, ai-tools, lang)
  }

  // 8. Ehrenwörtliche Erklärung (immer zuletzt — STR-10)
  _stub-declaration(authors, decl-lang, lang)
}
