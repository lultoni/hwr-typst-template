// test-scenarios/test_authors_conflict.typ
// EXPECTED: compile FAILS with message:
//   Conflict: both top-level name:/matrikel: and authors: are set.

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "ptb-1",
  title: "Test: name: und authors: gleichzeitig gesetzt",
  name: "Max Mustermann",
  matrikel: "12345678",
  authors: (
    (name: "Lisa Müller", matrikel: "87654321"),
  ),
  supervisor: "Prof. Dr. Test",
  company: "Test GmbH",
)
