---
unit: FIT1047
week: 1
parent: "[[Number Systems (Binary and Hexadecimal)]]"
tags: [CS/Systems, CS/Foundations]
aliases: [IEEE 754, Floating Point]
---
# [[Floating Point Numbers (IEEE 754)]]

**Context:** [[FIT1047_MOC]] · binary scientific notation for numbers of varying scale · significand + exponent + sign · why $0.1$ is inexact

> [!abstract] Quick Revision
> - **🎯 Objective:** represent $s \times 2^e$ with fixed-size fields ➔ IEEE 754 double: **52-bit significand + 11-bit exponent + 1 sign bit** $= 64$ bits.
> - **📦 Core Components:** binary point ➔ normalise to $1.xxxx \times 2^e$ ➔ store fraction + exponent (excess-$K$).
> - **⚡ Key Constraint:** finite bits ⟹ rounding — $0.1_{10}$ has **no exact binary form**; errors accumulate.

## 📝 Core
- **Motivation** ➔ integers can't hold $c=3{\times}10^5$ km/s and $t=15{\times}10^{-5}$ s in one scheme (scaling is ad-hoc; rounding gives $t=0$) ➔ scientific notation makes it easy: $t \times c = 45 \times 10^{5-5} = 45$ km.
- **Binary fractions** ➔ positions right of the point weigh $2^{-1}, 2^{-2}, \dots$: $110.01_2 = 4{+}2{+}0.25 = 6.25_{10}$.
- **Normalisation** ➔ shift the point so the number starts "$1.$": $110.01_2 = 1.1001 \times 2^2$ — exponent = shift count.
- **Storage (IEEE 754 double)** ➔ sign $1$ bit · exponent $11$ bits · significand $52$ bits; special FPU hardware computes on these.
- **Exponent encoding** ➔ negative exponents needed ➔ stored in **excess-$K$** (biased), not 2's complement (detail out of W1 scope).
- **Precision trade** ➔ 64-bit float vs 64-bit int: the float spends 12 bits on sign+exponent ⟹ large integers stored as floats lose exactness.
- **The $0.1$ problem** ➔ no finite sum of powers of $2$ equals $10^{-1}$; IEEE 754 stores $\approx 0.10000000000000000555\dots$ — tiny per-operation errors compound ⟹ **never floats for money**.

## 📊 Applied Exercise — encode $6.25_{10}$ (6-bit significand, 4-bit exponent, from lecture)
$$
\begin{aligned}
6.25_{10} &= 110.01_2 && (4 + 2 + \tfrac14) \\
&= 1.1001 \times 2^2 && \text{(normalise: point moves 2 left)} \\
s &= 001001, \quad e = 2 && \text{(exponent stored in excess-}K\text{ in real IEEE 754)}
\end{aligned}
$$
**Final Extracted Output:** significand $001001$, exponent $2$, sign $0$.

## ✍️ Practice
> [!QUESTION]- Convert $10.75_{10}$ to binary, normalise it, and state the significand and exponent. Then explain in one sentence why a banking system must not store balances as floats.
> > [!SUCCESS]- Answer
> > - $10.75 = 1010.11_2 = 1.01011 \times 2^3$ ⟹ significand $01011\dots$, exponent $3$.
> > - Money: decimal fractions like $0.10$ are inexact in binary ⟹ rounding errors accumulate across millions of transactions — use integer cents.
> > - **Key move:** normalise until exactly one $1$ precedes the point; the shift count IS the exponent.

## ⚠️ Common Mistakes
- 💡 **"Looks exact" isn't** ➔ printed $0.1$ hides the stored $0.100000000000000005\dots$; equality tests on floats (`a == 0.3`) fail unpredictably.
- 💡 **Floats don't replace ints** ➔ same 64 bits, but floats trade exactness for range; big integers silently round.
- 💡 **Exponent isn't 2's complement** ➔ IEEE 754 uses excess-$K$ bias — don't decode exponent fields with the signed-integer rules.
