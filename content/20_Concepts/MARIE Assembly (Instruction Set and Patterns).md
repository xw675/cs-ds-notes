---
unit: FIT1047
domain: F
week: [3, 4]
parent: "[[Von Neumann Architecture and Programs]]"
tags: [CS/Systems, CS/Assembly]
type: pattern
aliases: [MARIE, MARIE Instructions, SkipCond]
---
# [[MARIE Assembly (Instruction Set and Patterns)]]

**Context:** [[FIT1047_MOC]] · **the Assignment 2 "programming interview" skill** · machine model + full W3 instruction set + the branching patterns · execution semantics in [[Fetch-Decode-Execute and RTL (Control)]]
**Problem it solves:** hand-assemble, hand-trace, and write-from-blank small MARIE programs.

> [!abstract] Quick Revision
> - **🎯 Trigger:** every instruction = **4-bit opcode + 12-bit address** in a 16-bit word; only ONE working register (AC) ➔ everything routes through it.
> - **⚡ Key Constraint:** `SkipCond` skips exactly ONE instruction — if/loops are built as `SkipCond` + `Jump` pairs; the condition constants are $000{:}\,AC{<}0$, $400{:}\,AC{=}0$, $800{:}\,AC{>}0$.

## 🧩 Machine Model
- **Memory** ➔ 16-bit words, 12-bit addresses ⟹ max $2^{12}=4096$ locations.
- **One general register** ➔ the accumulator **AC**; special registers per [[Sequential Circuits (Latches, Flip-Flops, Registers)]].
- **Instruction word** ➔ `0001 000110001110` = opcode $0001$ (Load) + address $18E_{16}$: "load M[18E] into AC".
- **Hand-assembly example (workshop)** ➔ `Load A` with label `A` at address $003$ assembles to $1003_{16}$ (opcode nibble + address).

## 🎛 Instruction Set (Week 3 complete)
| Opcode | Assembly | Meaning |
| :-- | :-- | :-- |
| $0001$ | `Load X` | $\text{AC} \leftarrow M[X]$ |
| $0010$ | `Store X` | $M[X] \leftarrow \text{AC}$ |
| $0011$ | `Add X` | $\text{AC} \leftarrow \text{AC} + M[X]$ |
| $0100$ | `Subt X` | $\text{AC} \leftarrow \text{AC} - M[X]$ |
| $0101$ | `Input` | AC ← user input |
| $0110$ | `Output` | print AC |
| $0111$ | `Halt` | stop execution |
| $1000$ | `SkipCond C` | skip next instr. if $C{=}000{:}\,AC{<}0$ · $400{:}\,AC{=}0$ · $800{:}\,AC{>}0$ |
| $1001$ | `Jump X` | $\text{PC} \leftarrow X$ |

### Week 4 additions (indirect + subroutines — patterns in [[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)]])
| Assembly | Meaning |
| :-- | :-- |
| `LoadI X` | $\text{AC} \leftarrow M[M[X]]$ — value at the address stored at $X$ |
| `StoreI X` | $M[M[X]] \leftarrow \text{AC}$ |
| `AddI X` | $\text{AC} \leftarrow \text{AC} + M[M[X]]$ |
| `JnS X` | $M[X] \leftarrow \text{PC}$, then $\text{PC} \leftarrow X{+}1$ — call subroutine |
| `JumpI X` | $\text{PC} \leftarrow M[X]$ — return via stored address |
*(⚠ opcode bits for W4 instructions weren't in the slide text — fill from the Ed e-textbook ISA table before A2.)*
- **Directives so far** ➔ `DEC n` (decimal constant) · `HEX n` (hex constant, `HEX 0` reserves a slot) · `Adr L` (the ADDRESS of label `L` — the pointer initialiser).

## 🔧 Minimal Working Example — add two variables (workshop program)
```text
      Load  A        / AC ← M[A]           (assembles to 1003 if A at 003)
      Add   B        / AC ← AC + M[B]
      Halt
A,    DEC 2          / label A: the decimal constant 2
B,    DEC 3          / label B: 3
```
**Expected outcome:** AC ends holding $5$; `DEC` is an assembler directive placing a decimal value, labels name addresses.

## 🔀 Branching Patterns (SkipCond + Jump — the idiom pair)
*(Constructed from the taught semantics; cross-check exact style against the Ed e-textbook / W4 examples.)*
- **IF AC = 0 THEN do-block** ➔ `SkipCond 400` skips the `Jump Else` that guards the block:
```text
      SkipCond 400   / AC = 0 ? skip next
      Jump  Else     / AC ≠ 0: bypass then-block
      ...then-block...
Else, ...
```
- **Countdown loop shape** ➔ load counter → body → decrement (`Subt One`) → `SkipCond 400` (done?) → `Jump Loop`.

## ✍️ Practice
> [!QUESTION]- Practice 1: hand-assemble `Store A` where label `A` sits at address $01F_{16}$.
> > [!SUCCESS]- Answer
> > - Opcode `Store` $=0010$; address $01F$ ⟹ word $= 0010\,0000\,0001\,1111_2 = 201F_{16}$.
> > - **Key move:** first hex digit IS the opcode nibble; remaining three hex digits are the address.

> [!QUESTION]- Practice 2: write a MARIE program that inputs two numbers and outputs their difference (first − second).
> > [!SUCCESS]- Answer
> > ```text
> >       Input          / AC ← first
> >       Store T1
> >       Input          / AC ← second
> >       Store T2
> >       Load  T1
> >       Subt  T2       / AC ← first − second
> >       Output
> >       Halt
> > T1,   DEC 0
> > T2,   DEC 0
> > ```
> > - **Key move:** one accumulator ⟹ park values in labelled memory (`Store`) before the second `Input` overwrites AC.

## ⚠️ Common Mistakes
- 💡 **AC is always in the middle** ➔ no memory-to-memory moves; every value passes through the accumulator.
- 💡 **SkipCond skips ONE instruction only** ➔ the skipped slot is almost always a `Jump` — skipping a whole block directly is impossible.
- 💡 **The three condition constants** ➔ $000/400/800$ for $<0,\,=0,\,>0$ — memorise as hex, they look arbitrary in decimal.
- 💡 **`DEC` is not an instruction** ➔ assembler directive reserving a data word; putting it in the execution path runs garbage as code (stored-program hazard).
