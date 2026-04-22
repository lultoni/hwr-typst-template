// test-scenarios/test_chapters_string_invalid.typ
// Error-path test: chapters: with string paths instead of include() must fail with clear message
// Expected error: chapters entries must use include(), not string paths

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "ptb-1",
  title: "Test",
  name: "Max Mustermann",
  matrikel: "12345678",
  supervisor: "Prof. Dr. Test",
  company: "Test GmbH",

  chapters: (
    "kapitel/01_einleitung.typ",  // wrong: must be include("kapitel/01_einleitung.typ")
  ),
)
