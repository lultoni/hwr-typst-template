// pages/appendix.typ
// Anhang-Rendering: user-defined entries (A, B, C...) + KI-Verzeichnis automatisch als letztes
// STR-09: Anhang optional, arabische Seitennummerierung (fortlaufend)
// STR-12: KI-Verzeichnis als letztes Anhang-Item (wenn ai-tools nicht leer)
// api-design §4: KI-Verzeichnis Tabellen-Format; §7: Anhang-Array

#import "@preview/linguify:0.5.0": linguify

// Letters for appendix labeling: A, B, C...
#let _appendix-letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".clusters()

/// Render a single appendix entry with heading and content.
#let _render-entry(letter, title, content) = {
  let label-str = "anhang-" + lower(letter)

  heading(
    level: 1,
    numbering: none,
    outlined: true,
    [#linguify("appendix-label") #letter: #title #label(label-str)]
  )

  content
  pagebreak()
}

/// Render the KI-Verzeichnis (AI Tools Register) table.
/// CNT-10–13: mandatory when AI tools were used
/// Columns: KI-Tool | Einsatzform | Betroffene Teile | Bemerkungen
#let _render-ai-tools(ai-tools, letter) = {
  heading(
    level: 1,
    numbering: none,
    outlined: true,
    [#linguify("appendix-label") #letter: #linguify("ai-tools-title")],
  )

  v(0.5em)

  table(
    columns: (auto, 1fr, auto, auto),
    align: left,
    stroke: 0.5pt,
    // Header
    table.header(
      strong(linguify("ai-col-tool")),
      strong(linguify("ai-col-usage")),
      strong(linguify("ai-col-chapters")),
      strong(linguify("ai-col-remarks")),
    ),
    // Rows
    ..ai-tools.map(entry => (
      entry.at("tool", default: ""),
      entry.at("usage", default: ""),
      entry.at("chapters", default: ""),
      entry.at("bemerkungen", default: "—"),
    )).flatten()
  )

  pagebreak()
}

/// Render the appendix table of contents (Anhangsverzeichnis).
/// Lists all appendix entries with clickable links.
#let _render-appendix-toc(entries) = {
  heading(level: 1, numbering: none, outlined: false)[#linguify("appendix-toc-title")]
  v(1em)

  for (letter, title) in entries {
    let label-str = "anhang-" + lower(letter)
    grid(
      columns: (30pt, 1fr),
      [#linguify("appendix-label") #letter:],
      link(label(label-str))[#title],
    )
    v(0.3em)
  }

  pagebreak()
}

/// Render the full appendix section.
///
/// - appendix: array of (title, content) — user-defined entries
/// - ai-tools: array of (tool, usage, chapters, bemerkungen?) — AI tools register
/// - lang: "de" | "en"
#let render-appendix(appendix, ai-tools, lang) = {
  // Build full entry list (user entries + optional AI tools as last)
  let all-entries = ()
  for (i, entry) in appendix.enumerate() {
    all-entries.push((_appendix-letters.at(i), entry.at("title", default: "")))
  }
  let ai-letter = if ai-tools.len() > 0 {
    _appendix-letters.at(appendix.len())
  } else {
    none
  }
  if ai-letter != none {
    all-entries.push((ai-letter, linguify("ai-tools-title")))
  }

  // Anhangsverzeichnis (TOC for appendix)
  _render-appendix-toc(all-entries)

  // User-defined appendix entries
  for (i, entry) in appendix.enumerate() {
    let letter = _appendix-letters.at(i)
    _render-entry(letter, entry.at("title", default: ""), entry.at("content", default: []))
  }

  // KI-Verzeichnis as last item
  if ai-tools.len() > 0 {
    _render-ai-tools(ai-tools, ai-letter)
  }
}
