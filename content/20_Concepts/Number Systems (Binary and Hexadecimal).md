---
unit: FIT1047
domain: [D, F]
week: 1
parent: "[[Computer Fundamentals (Bits, Bytes, Words)]]"
tags: [CS/Systems, CS/Foundations, Math/Discrete]
aliases: [Binary Numbers, Hexadecimal, Base Conversion]
---
# [[Number Systems (Binary and Hexadecimal)]]

**Context:** [[FIT1047_MOC]] · positional notation in bases $2$, $10$, $16$ · **the Assignment 1 hand skill** · basis of [[Signed Integer Representation (Two's Complement)]] and [[Floating Point Numbers (IEEE 754)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** each digit is worth (digit) × (base)$^{\text{position}}$ ➔ convert any direction between binary/decimal/hex + add binary by hand.
> - **📦 Core Components:** weights table (binary→dec) ➔ repeated division (dec→binary) ➔ 4-bits-per-hex-digit (binary↔hex).
> - **⚡ Key Constraint:** $n$ bits represent $2^n$ values ($0$ to $2^n-1$) — the counting question examiners love.

## 📝 Core
- **Positional notation** ➔ $2396_{10} = 2{\times}10^3 + 3{\times}10^2 + 9{\times}10^1 + 6{\times}10^0$; same idea in base 2: $2396_{10} = 100101011100_2$.
- **Binary → decimal** ➔ write weights $2^7 \dots 2^0$ over the bits, add the weights under the 1s.
- **Decimal → binary** ➔ repeated division by 2, remainders read bottom-up (standard method for the A1 skill; slides teach the weights direction — drill both).
- **Capacity** ➔ $n$ bits ⟹ $2^n$ values: 3 bits → $0..7$, 5 bits → $0..31$, 8 bits → $0..255$.
- **Binary addition** ➔ long addition with carries: $1+1=10_2$ (write 0 carry 1).
- **Hex** ➔ base 16, digits $0..9,A..F$; **one hex digit = exactly 4 bits** ➔ group binary in 4s from the right: $1001\,0101\,1100_2 = 95C_{16}$.

## ⚖️ Core Decision Matrix
| Conversion | Method | Micro-example |
| :-- | :-- | :-- |
| binary → decimal | weights table, sum the 1-positions | $11011101_2 = 128{+}64{+}16{+}8{+}4{+}1 = 221$ |
| decimal → binary | ÷2, remainders bottom-up | $13 = 1101_2$ ($13{\to}6r1,6{\to}3r0,3{\to}1r1,1{\to}0r1$) |
| binary → hex | group 4 bits from right → digit each | $100101011100_2 \to 1001\,0101\,1100 \to 95C_{16}$ |
| hex → binary | each digit → 4 bits | $A7_{16} \to 1010\,0111_2$ |
| decimal ↔ hex | via binary (fastest by hand) | $221 \to 11011101_2 \to DD_{16}$ |

## 📊 Exam Execution Trace
### Manual Execution Trace — binary addition $1001_2 + 0101_2$
| Step | Column ($2^k$) | Bits + carry | Write | Carry |
| :-- | :-- | :-- | :-- | :-- |
| 1 | $2^0$ | $1+1$ | $0$ | $1$ |
| 2 | $2^1$ | $0+0+1$ | $1$ | $0$ |
| 3 | $2^2$ | $0+1$ | $1$ | $0$ |
| 4 | $2^3$ | $1+0$ | $1$ | $0$ |
**Result:** $1110_2 = 14_{10}$ ✓ ($9+5$).

## ✍️ Practice 
> [!QUESTION]- (a) Convert $174_{10}$ to binary and hex. (b) How many different values can 6 bits represent, and what is the largest? (c) Add $10111_2 + 1101_2$.
> > [!SUCCESS]- Answer
> > - (a) $174 = 10101110_2 = AE_{16}$ (check: $128{+}32{+}8{+}4{+}2 = 174$).
> > - (b) $2^6 = 64$ values, largest $= 2^6 - 1 = 63$.
> > - (c) $10111_2 + 1101_2 = 100100_2$ ($23 + 13 = 36$ ✓).
> > - **Key move:** always verify by converting back to decimal.

## ⚠️ Common Mistakes
- 💡 **$2^n$ values vs largest value** ➔ $n$ bits give $2^n$ values but the max is $2^n - 1$ (zero occupies a slot).
- 💡 **Group hex from the RIGHT** ➔ padding goes on the left; grouping from the left mangles the number.
- 💡 **Write the base subscript** ➔ $101$ is ambiguous; $101_2 \neq 101_{10} \neq 101_{16}$ — unlabeled bases lose marks.
