// test-scenarios/test_optional_params.typ
// Happy-path test: optional parameters — date string, city override, warnings: false
// Verifies:
//   1. date: "15. März 2026" (manual string) renders without errors
//   2. city: "Hamburg" (non-default city) appears in signature field
//   3. warnings: false suppresses yellow warning blocks
//   4. declaration-lang: "de" with lang: "de" compiles cleanly
//   5. cohort + semester render on title page

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "ptb-1",
  title: "Test: Optionale Parameter",
  name: "Max Mustermann",
  matrikel: "12345678",
  supervisor: "Prof. Dr. Test",
  company: "Test GmbH",

  lang: "de",
  field-of-study: "Wirtschaftsinformatik",
  cohort: "2023",
  semester: "5",

  date: "15. März 2026",   // manual date string instead of auto
  city: "Hamburg",          // non-default city
  warnings: false,          // suppress yellow warning blocks

  declaration-lang: "de",  // explicit, not auto

  heading-depth: 2,

  chapters: (
    [
      = Einleitung

      Test-Kapitel mit optionalen Parametern.
      Datum ist manuell auf "15. März 2026" gesetzt.
      Ort in Unterschriftsfeld ist "Hamburg".

      == Abschnitt

      Abschnitt-Text.
    ],
  ),
)
