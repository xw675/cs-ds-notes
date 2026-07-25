---
unit: FIT1047
domain: F
week: [1, 2]
parent: "[[Computer Fundamentals (Bits, Bytes, Words)]]"
tags: [CS/Systems, CS/Hardware]
aliases: [Logic Gates, Transistors, Moore's Law]
---
# [[Transistors and Logic Gates]]

**Context:** [[FIT1047_MOC]] · from electronic switch to computing — triode → transistor → gate → chip · the hardware floor under Week 2's Boolean algebra

> [!abstract] Quick Revision
> - **🎯 Objective:** a transistor is a **switch triggered by a small current** ➔ gates are circuits of switches computing simple functions on 0/1 ➔ chips are billions of gates.
> - **⚡ Key Constraint:** gate behaviour = truth table; NOT/OR/AND are the primitive vocabulary for every Week 2 circuit.

## 📝 Core
- **Digital = two states** ➔ high/low voltage ⟹ 1/0; all digital electronics builds on the *electronic switch*.
- **Vacuum tube (triode)** ➔ charge on the Grid blocks Anode→Cathode current — a switch, hence tube computers (1st gen); but large, hot, burn out.
- **Transistor** ➔ *solid-state* triode made of semiconductor (silicon/germanium); same switching job, tiny and reliable (1956 Nobel for its inventors — physics out of scope).
- **Gate** ➔ an electronic circuit built FROM transistors that computes a simple function on high/low inputs → outputs.
- **Scaling story** ➔ individual transistors → integrated circuits (multiple gates per chip) → whole CPU on a chip → $>50$ billion transistors today.
- **Moore's "law"** ➔ transistor count on a chip doubles roughly every **two years** — an observation, not a law of physics.

## ⚖️ Core Decision Matrix — primitive gates + NAND
| Inputs $A,B$ | NOT $A$ | $A$ OR $B$ | $A$ AND $B$ | $A$ NAND $B$ |
| :-- | :-- | :-- | :-- | :-- |
| $0,0$ | $1$ | $0$ | $0$ | $1$ |
| $0,1$ | $1$ | $1$ | $0$ | $1$ |
| $1,0$ | $0$ | $1$ | $0$ | $1$ |
| $1,1$ | $0$ | $1$ | $1$ | $0$ |
- **In words** ➔ NOT inverts; OR high if *either* input high; AND high only if *both* high; NAND = NOT-AND (gate symbol: AND with a "not" circle on the output).

### Universality (Week 2, Simple Circuits)
- **Gates → functions** ➔ combining gates implements any Boolean function; a chip with multiple gates = integrated circuit.
- **Minimal sets** ➔ any Boolean function needs only $\{$NOT, AND$\}$ or $\{$NOT, OR$\}$ — since $A+B = \overline{\overline{A}\,\overline{B}}$ (De Morgan, [[Boolean Algebra Laws]]).
- **NAND alone suffices** ➔ NAND is a *universal gate*: $X$ AND $Y = (X$ NAND $Y)$ NAND $(X$ NAND $Y)$; NOT and OR follow — one gate type builds a whole computer.

## ⚠️ Common Mistakes
- 💡 **Moore's law is empirical** ➔ calling it a physical law in prose costs precision marks; it's a trend observation about integration density.
- 💡 **Gate ≠ transistor** ➔ a gate is a small *circuit of* transistors; the transistor alone is just the switch.

## 🧠 Active Recall
> [!FAQ]- Trace the chain from vacuum tube to modern CPU, naming what each step improved.
> > [!SUCCESS]- Answer
> > - **Short answer:** triode (switch, but big/hot/fragile) → transistor (solid-state, small, reliable) → integrated circuit (many gates, one chip) → VLSI CPU (billions of transistors).
> > - **Why:** **Same abstraction throughout** ➔ every generation implements the identical primitive — a current-controlled switch — just smaller and denser (Moore's law).

> [!FAQ]- Write the truth table for AND and OR from memory and state the one-line rule for each.
> > [!SUCCESS]- Answer
> > - **Short answer:** AND ➔ $1$ only on $(1,1)$; OR ➔ $0$ only on $(0,0)$.
> > - **Why:** **Truth table = gate spec** ➔ Week 2 Boolean algebra manipulates exactly these functions symbolically.

> [!FAQ]- Why is NAND called a universal gate? Show AND built from NANDs.
> > [!SUCCESS]- Answer
> > - **Short answer:** Every Boolean function can be built from NAND alone: $(X \text{ NAND } Y) \text{ NAND } (X \text{ NAND } Y) = XY$ (a NAND fed into itself acts as NOT).
> > - **Why:** **Functional completeness** ➔ NAND yields NOT (tie inputs), hence AND (invert NAND) and OR (De Morgan) — so $\{$NAND$\}$ generates $\{\neg,\wedge,\vee\}$ ([[Universal Sets of Operations]]).
