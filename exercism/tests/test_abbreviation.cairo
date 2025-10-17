use exercism::acronym;

#[test]
fn basic() {
    let s: ByteArray = "Race Cars Travel Fast";
    assert!(acronym::abbreviate(s) == "RCTF");
}

#[test]
fn hyphens() {
    let s: ByteArray = "self-supervised learning";
    assert!(acronym::abbreviate(s) == "SSL");
}

#[test]
fn multiple_delims() {
    let s: ByteArray = "  multiple   spaces --and-- hyphens ";
    assert!(acronym::abbreviate(s) == "MSAH");
}

#[test]
fn empty() {
    let s: ByteArray = "";
    assert!(acronym::abbreviate(s) == "");
}