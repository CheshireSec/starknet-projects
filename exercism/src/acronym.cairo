pub fn abbreviate(phrase: ByteArray) -> ByteArray {
    let mut acronym:ByteArray = "";

    let len: u32 = phrase.len();
    if len == 0_u32 {
        return acronym;
    }

    // Take the first byte
    let first = phrase.at(0_u32).unwrap();
    acronym.append_byte(first); // If this doesn't exist in your std, try `.append` or `.push`
    let mut idx: u32 = 0_u32;

    // We'll peek at idx + 1, so only iterate until len - 1
    while idx + 1_u32 < len {
        let ch = phrase.at(idx).unwrap();

        // Use numeric u8 literals: 32 = ' ', 45 = '-'
        if ch == 32_u8 || ch == 45_u8 {
            let next = phrase.at(idx + 1_u32).unwrap();
            acronym.append_byte(next);
        }

        idx = idx + 1_u32; // always advance
    }

    acronym
}