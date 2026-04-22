// test-scenarios/test_signature_string_invalid.typ
// Error-path test: signature: as string path instead of image() must fail with clear message
// Expected error: signature must be image content, not a string path

#import "../lib.typ": hwr

#show: hwr.with(
  doc-type: "ptb-1",
  title: "Test",
  name: "Max Mustermann",
  matrikel: "12345678",
  signature: "images/signature.svg",  // wrong: must be image(), not a string
  supervisor: "Prof. Dr. Test",
  company: "Test GmbH",

  chapters: (
    [= Test \ Inhalt.],
  ),
)
