---
unit: FIT1047
week: 1
parent: "[[Computer Fundamentals (Bits, Bytes, Words)]]"
tags: [CS/Systems, CS/Foundations]
aliases: [ASCII, Unicode, UTF-8]
---
# [[Text Encoding (ASCII and Unicode)]]

**Context:** [[FIT1047_MOC]] · characters become numbers become bits · ASCII (1967) → Unicode codepoints → UTF-8/UTF-16 transfer formats

> [!abstract] Quick Revision
> - **🎯 Objective:** text = a **sequence of encoded characters**; decode hex bytes ↔ characters via the ASCII table.
> - **⚡ Key Constraint:** ASCII is $7$ bits ($+1$ originally for error detection) ⟹ max 128 chars; extended 8-bit sets cap at 256 — hence Unicode.

## 📝 Core
- **ASCII (1967)** ➔ maps English letters, digits $0$–$9$, symbols into a **7-bit** code; the 8th bit originally did simple error detection. Example: `J` $= 4A_{16}$.
- **Text as bytes** ➔ simplest form is a plain sequence of codes: `61 20 73 65 71 …`$_{16}$ decodes to "a sequence of encoded characters".
- **Extended ASCII** ➔ 8th bit repurposed ⟹ 256-char "extended sets" for some European characters — still hopeless for languages with tens of thousands of characters.
- **Unicode** ➔ assigns each character a **codepoint** in $0 \dots 10FFFF_{16}$ ⟹ over a million characters; codepoint ≠ byte encoding.
- **UTF-8** ➔ encodes each codepoint in **1–4 bytes**; ASCII characters keep their single ASCII byte ⟹ every ASCII file is already valid UTF-8; dominant on the Internet.
- **UTF-16** ➔ exactly two bytes per codepoint ⟹ limited to the first $2^{16}$ codepoints.

## ⚠️ Common Mistakes
- 💡 **Codepoint vs encoding** ➔ Unicode assigns numbers; UTF-8/UTF-16 decide the bytes — "Unicode is 2 bytes" conflates the two.
- 💡 **UTF-8 is variable-length** ➔ byte count ≠ character count; slicing bytes mid-character corrupts text.

## 🧠 Active Recall
> [!FAQ]- Why did ASCII's 7 bits become a problem, and how does Unicode + UTF-8 solve it while staying backward compatible?
> > [!SUCCESS]- Answer
> > - **Short answer:** $2^7=128$ (even $2^8=256$ extended) can't cover scripts with tens of thousands of characters; Unicode gives $>10^6$ codepoints and UTF-8 encodes them in 1–4 bytes.
> > - **Why:** **ASCII-compatibility** ➔ UTF-8 maps ASCII codepoints to their original single byte, so legacy ASCII text is valid UTF-8 unchanged.

> [!FAQ]- Decode $4A_{16}$ and encode the idea: how is a whole text stored?
> > [!SUCCESS]- Answer
> > - **Short answer:** $4A_{16}$ = `J`; a text is just the concatenated sequence of each character's code.
> > - **Why:** **Sequence model** ➔ no separators needed in fixed-width ASCII; variable-width UTF-8 instead uses byte-pattern prefixes.
