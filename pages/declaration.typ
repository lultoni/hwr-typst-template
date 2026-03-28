// pages/declaration.typ
// Ehrenwörtliche Erklärung mit 2025 KI-Klausel (Pflicht §3.11)
// CNT-01–05: Pflichtinhalt inkl. KI-Passagen-Kennzeichnung und Verantwortungsübernahme
// STR-10: Immer letztes Element des Dokuments
// declaration-lang: folgt entweder doc-lang oder eigenem Override

#import "@preview/linguify:0.5.0": linguify, linguify-raw

/// Render the declaration of authorship page.
///
/// - authors: array of (name, matrikel)
/// - decl-lang: "de" | "en" — language for the declaration text
/// - lang: "de" | "en" — document language (for labels if different)
#let render-declaration(authors, decl-lang, lang) = {
  // Force declaration language for this page only
  set text(lang: decl-lang)

  heading(level: 1, numbering: none, outlined: true)[#linguify("declaration-title")]

  v(1.5em)

  // Pflichttext §3.11 — aus l10n, mit Pluralisierung für Gruppen
  // linguify-raw returns the FTL string; eval() converts it to Typst content
  let decl-text = context eval(
    "[" + linguify-raw("declaration-text", args: (author-count: authors.len())) + "]"
  )
  set par(justify: true)
  decl-text

  v(3cm)

  // Unterschriften-Zeilen — eine pro Autor
  for a in authors {
    grid(
      columns: (1fr, 1fr),
      column-gutter: 2em,
      [
        #linguify("declaration-place-date") \
        #v(1.5cm)
        #line(length: 100%)
      ],
      [
        #linguify("declaration-signature") — #a.name \
        #v(1.5cm)
        #line(length: 100%)
      ],
    )
    v(1em)
  }
}
