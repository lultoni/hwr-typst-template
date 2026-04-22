// test-scenarios/test_style_invalid.typ
// EXPECTED: compile FAILS with message:
//   style must be "compliant" or "pretty", got: "minimal"

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "ptb-1",
  title: "Test: ungültiger style-Wert",
  name: "Test User",
  matrikel: "99999999",
  supervisor: "Prof. Dr. Test",
  company: "Test GmbH",
  style: "minimal",  // <-- invalid
)
