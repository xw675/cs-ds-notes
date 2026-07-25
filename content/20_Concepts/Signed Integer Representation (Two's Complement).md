---
unit: FIT1047
week: 1
parent: "[[Number Systems (Binary and Hexadecimal)]]"
tags: [CS/Systems, CS/Foundations]
aliases: [Two's Complement, Sign and Magnitude, Ones' Complement, Overflow]
---
# [[Signed Integer Representation (Two's Complement)]]

**Context:** [[FIT1047_MOC]] · three schemes for negative numbers · why hardware chose 2's complement · overflow detection by sign pattern

> [!abstract] Quick Revision
> - **🎯 Objective:** negate in 2's complement ➔ **flip all bits, add 1** ➔ regular long addition then works for signed arithmetic.
> - **📦 Core Components:** sign-magnitude (two zeros) ➔ 1's complement (flip only, still two zeros) ➔ 2's complement (flip+1, one zero, easy hardware).
> - **⚡ Key Constraint:** overflow rule — same-sign operands producing an opposite-sign result ⟹ overflow; the discarded carry bit is NOT the test.

## 📝 Core
### 1. Sign-and-Magnitude
- **Scheme** ➔ leftmost bit = sign, rest = magnitude: $101_2 = -1$.
- **Drawbacks** ➔ **two zeros** ($000$ and $100$); addition/subtraction and overflow detection hard to implement.

### 2. 1's Complement
- **Scheme** ➔ negative = flip every bit: $-1 = 110_2$ (3-bit).
- **Improvement** ➔ easier arithmetic than sign-magnitude, but **still two zeros** ($000$, $111$).

### 3. 2's Complement (the one computers use)
- **Negation recipe** ➔ flip all bits, then $+1$: $3 = 011 \to 100 + 1 = 101 = -3$.
- **Landmarks (n bits)** ➔ $-1 = 11\dots1$ · smallest $= 100\dots0 = -2^{n-1}$ · largest $= 011\dots1 = 2^{n-1}{-}1$ · **exactly one zero** · leftmost bit still signals sign.
- **Why hardware loves it** ➔ regular long addition works unchanged; overflow detected by sign pattern; no duplicate zero.
- **Range asymmetry** ➔ 3 bits: $-4 \dots +3$ — one more negative than positive value.

## 📊 Exam Execution Trace — overflow detection (3-bit, from lecture)
| Sum | Bits | Result | Signs | Verdict |
| :-- | :-- | :-- | :-- | :-- |
| $(+3)+(+2)$ | $011+010$ | $101 = -3$ | pos+pos → neg | **OVERFLOW** |
| $(-1)+(-4)$ | $111+100$ | $011 = +3$ (carry discarded) | neg+neg → pos | **OVERFLOW** |
| $(-1)+(-2)$ | $111+110$ | $101 = -3$ (carry discarded) | neg+neg → neg | ok ✓ |
**Rule:** overflow ⟺ two same-sign operands yield an opposite-sign result; mixed-sign addition can never overflow.

## ⚖️ Core Decision Matrix
| Scheme | Negation | Zeros | Arithmetic | Range (n bits) |
| :-- | :-- | :-- | :-- | :-- |
| sign-magnitude | flip sign bit | **two** | hard | $-(2^{n-1}{-}1) \dots 2^{n-1}{-}1$ |
| 1's complement | flip all bits | **two** | medium | $-(2^{n-1}{-}1) \dots 2^{n-1}{-}1$ |
| **2's complement** | flip + add 1 | one | long addition works | $-2^{n-1} \dots 2^{n-1}{-}1$ |

## ✍️ Practice 
> [!QUESTION]- Using 4 bits: (a) write $-6$ in 2's complement; (b) compute $(-6) + (+3)$ and state whether it overflows; (c) compute $(+5) + (+4)$ and state whether it overflows.
> > [!SUCCESS]- Answer
> > - (a) $6 = 0110 \to$ flip $1001 \to +1 = 1010 = -6$.
> > - (b) $1010 + 0011 = 1101 = -3$ ✓ no overflow (mixed signs never overflow).
> > - (c) $0101 + 0100 = 1001 = -7$ ✗ **overflow** (pos+pos → neg; $9 > 2^3{-}1$).
> > - **Key move:** verdict comes from the sign pattern, not from any carry.

## ⚠️ Common Mistakes
- 💡 **Discarded carry ≠ overflow** ➔ $(-1)+(-2)$ discards a carry yet is correct; only the sign-pattern rule decides.
- 💡 **Flip+1 is an involution** ➔ applying it twice returns the original — use that to decode a negative pattern back to magnitude.
- 💡 **$-2^{n-1}$ has no positive partner** ➔ negating $100\dots0$ overflows; the range is asymmetric by one.
