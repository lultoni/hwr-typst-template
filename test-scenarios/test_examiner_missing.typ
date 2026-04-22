// test-scenarios/test_examiner_missing.typ
// Error-path test: first-examiner is required for bachelorarbeit but missing
// Expected error: first-examiner is required for doc-type "bachelorarbeit"

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "bachelorarbeit",
  title: "Test",
  name: "Max Mustermann",
  matrikel: "12345678",
  // first-examiner: intentionally omitted
  second-examiner: "Prof. Dr. Müller",

  chapters: (
    [= Test \ Inhalt.],
  ),
)
