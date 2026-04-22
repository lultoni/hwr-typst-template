// test-scenarios/test_doctype_invalid.typ
// Error-path test: doc-type with invalid value must fail with clear message
// Expected error: doc-type "masterarbeit" is invalid. Allowed values: ptb-1, ptb-2, ...

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "masterarbeit",
  title: "Test",
  name: "Max Mustermann",
  matrikel: "12345678",
  supervisor: "Prof. Dr. Test",
  company: "Test GmbH",

  chapters: (
    [= Test \ Inhalt.],
  ),
)
