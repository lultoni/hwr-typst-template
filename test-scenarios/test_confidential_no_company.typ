// test-scenarios/test_confidential_no_company.typ
// EXPECTED: compile FAILS with message:
//   confidential requires company: — the Sperrvermerk text references the company name.

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "bachelorarbeit",
  title: "Test: Sperrvermerk ohne Firmenname",
  name: "Max Mustermann",
  matrikel: "12345678",
  first-examiner: "Prof. Dr. Muster",
  second-examiner: "Prof. Dr. Müller",

  confidential: true,  // <-- requires company: but bachelorarbeit doesn't need one
)
