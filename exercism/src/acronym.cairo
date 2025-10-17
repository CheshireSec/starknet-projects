// v1
//pub fn abbreviate(phrase: ByteArray) -> ByteArray {
//    let mut acronym:ByteArray = "";
//
//    let len: u32 = phrase.len();
//    if len == 0_u32 {
//        return acronym;
//    }

//    // Take the first byte
//    let first = phrase.at(0_u32).unwrap();
//    acronym.append_byte(first); // If this doesn't exist in your std, try `.append` or `.push`
//    let mut idx: u32 = 0_u32;

//    // We'll peek at idx + 1, so only iterate until len - 1
//    while idx + 1_u32 < len {
//        let ch = phrase.at(idx).unwrap();

//        // Use numeric u8 literals: 32 = ' ', 45 = '-'
//        if ch == 32_u8 || ch == 45_u8 {
//            let next = phrase.at(idx + 1_u32).unwrap();
//            acronym.append_byte(next);
//        }

//        idx = idx + 1_u32; // always advance
//    }

//    acronym
//}

/// Returns the uppercase acronym of a ByteArray phrase.
/// Word boundaries are spaces ' ' (0x20) or hyphens '-' (0x2D).
/// Only alphabetic ASCII characters are used as initials.
///
/// Examples:
/// - "Race Cars Travel Fast"  -> "RCTF"
/// - "self-supervised learning" -> "SSL"
pub fn abbreviate(phrase: ByteArray) -> ByteArray {
    let mut out: ByteArray = Default::default();

    // Delimiters.
    const SPACE: u8 = 32_u8; // ' '
    const HYPHEN: u8 = 45_u8; // '-'

    // ASCII ranges.
    const A_UP: u8 = 65_u8; // 'A'
    const Z_UP: u8 = 90_u8; // 'Z'
    const A_LO: u8 = 97_u8; // 'a'
    const Z_LO: u8 = 122_u8; // 'z'
    const CASE_DIFF: u8 = 32_u8; // 'a' - 'A'

    // Helpers as local closures (inlined by the compiler).
    let is_delim = |b: u8| -> bool {
        b == SPACE || b == HYPHEN
    };
    let is_alpha = |b: u8| -> bool {
        (b >= A_UP && b <= Z_UP) || (b >= A_LO && b <= Z_LO)
    };
    let to_upper = |b: u8| -> u8 {
        if b >= A_LO && b <= Z_LO {
            b - CASE_DIFF
        } else {
            b
        }
    };

    let mut take_next = true;
    let mut i: usize = 0;
    let n: usize = phrase.len(); // O(1)

    // Single pass over the bytes: O(n), minimal allocations.
    while i != n {
        if i == n {
            break;
        }
        let b: u8 = phrase.at(i).unwrap();

        if is_delim(b) {
            take_next = true;
        } else {
            if take_next && is_alpha(b) {
                out.append_byte(to_upper(b));
            }
            // Once we see a non-delimiter, we're inside a word.
            take_next = false;
        }

        i += 1;
    }

    out
}

fn main() {
    let s: ByteArray = "Race Cars Travel Fast";
    assert!(abbreviate(s) == "RCTF");
}
