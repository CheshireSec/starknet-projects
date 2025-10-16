use exercism::acronym;

#[test]
fn test_simple_acronym() {
    // Depending on your std version, both of these might work:
    let phrase: ByteArray = "Race Cars Race Fast";
    // or: let mut phrase = ByteArray::new(); phrase.append_string("Race Cars Race Fast");

    let result = acronym::abbreviate(phrase);
    assert(result == "RCRF", 'expected RCRF');
}
