// test-scenarios/test_supervisor_missing.typ
// Error-path test: supervisor is required for ptb-1 but missing
// Expected error: supervisor is required for doc-type "ptb-1"

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "ptb-1",
  title: "Test",
  name: "Max Mustermann",
  matrikel: "12345678",
  company: "Test GmbH",
  // supervisor: intentionally omitted

  chapters: (
    [= Test \ Inhalt.],
  ),
)
