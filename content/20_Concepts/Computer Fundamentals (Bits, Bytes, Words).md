---
unit: FIT1047
week: 1
parent: "[[FIT1047_MOC]]"
tags: [CS/Systems, CS/Foundations]
aliases: [Bits and Bytes, Word Size]
---
# [[Computer Fundamentals (Bits, Bytes, Words)]]

**Context:** [[FIT1047_MOC]] · what every modern computer IS, and the units all data reduces to · feeds [[Number Systems (Binary and Hexadecimal)]] and [[Transistors and Logic Gates]]

> [!abstract] Quick Revision
> - **🎯 Objective:** all modern computers = digital + electronic circuits + **stored programs** ➔ everything reduces to bits.
> - **⚡ Key Constraint:** bit → byte (8 bits, smallest addressable unit) → word (architecture-defined, 32/64-bit) — computers move/process/store **whole words**.

## 📝 Core
- **Universal traits** ➔ basically all modern computers are *digital* (0s/1s), use *electronic circuits* for computation, and are *controlled by stored programs*; most have **CPU + RAM + I/O**, many networked.
- **Why 0/1** ➔ electronic circuits reliably distinguish two states (high/low) ➔ representation question ("how to encode data in bits?" → number systems, encodings) + computation question ("how to compute on bits?" → Boolean logic, circuits).
- **Bit** ➔ one binary digit ($0$ or $1$) — the smallest unit of data.
- **Byte** ➔ convention: $8$ bits; for many machines the smallest individually addressable memory unit.
- **Word** ➔ a block of bits of architecture-specific size; modern CPUs use $32$ or $64$ bits — the natural unit the CPU moves, processes and stores.
- **Generations (context only, not assessed)** ➔ vacuum tubes (1945–53) → transistors (1954–65) → integrated circuits (1965–80) → VLSI (1980–now) → 5th gen (quantum?).

## ⚠️ Common Mistakes
- 💡 **Byte ≠ word** ➔ byte is fixed at $8$ bits by convention; word size varies by architecture — quoting "a word is 8 bits" loses marks.

## 🧠 Active Recall
> [!FAQ]- What three properties do essentially all modern computers share, and why do they use 0s and 1s?
> > [!SUCCESS]- Answer
> > - **Short answer:** digital, electronic-circuit-based computation, stored-program control; two states because circuits distinguish high/low reliably.
> > - **Why:** **Two sub-problems follow** ➔ representing information in bits (encodings) and computing with bits (Boolean circuits) — the unit's Week 1–2 arc.

> [!FAQ]- Define bit, byte and word, and state which one is architecture-dependent.
> > [!SUCCESS]- Answer
> > - **Short answer:** bit = one binary digit; byte = $8$ bits (smallest memory unit); word = architecture-defined block ($32$/$64$ bits on modern CPUs).
> > - **Why:** **Word is the CPU's native unit** ➔ moves/processes/stores complete words, which is why word size defines an architecture.
