---
unit: FIT2102
week: 1
source: [lecture]
domain: [F, H]
parent: "[[Von Neumann Architecture and Programs]]"
tags: [CS/Languages, CS/Architecture]
aliases: [Levels of Abstraction, Abstraction Ladder, Machine Language, Assembly Language, High-Level Language]
---
# [[Levels of Abstraction (Machine to High-Level)]]

**Context:** [[FIT2102_MOC]] · why high-level languages exist at all — the ladder [[Programming Paradigms]] climbs away from · hardware detail in [[Von Neumann Architecture and Programs]], executed by [[Fetch-Decode-Execute and RTL (Control)]], hand-traced in FIT1047 as [[MARIE Assembly (Instruction Set and Patterns)]]
**Course notes:** Chapter 1.

> [!abstract] Quick Revision
> - **🎯 Objective:** machine → assembly → high-level ➔ each rung buys **human meaning** by adding a translation step, and each rung departs further from the [[Von Neumann Architecture and Programs|von Neumann]] machine.
> - **⚡ Key Constraint:** **assembly is a rename, not an abstraction** — its operations map **one-to-one** onto machine operations, so it inherits the machine's execution model wholesale.

## 📝 Core
- **Machine language** ➔ operations and their arguments (**operands**) represented as binary numbers, executed either directly in hardware or by a **microprogram embedded in the microprocessor**.
- **Assembly language** ➔ still needs a translator, but operations correspond **one-to-one** with machine operations. What it actually buys: naming operations and memory locations **symbolically**; defining **procedures** (a later addition); conveniences for arrays and macros.
- **High-level language** ➔ a **compiler or interpreter** transforms human-readable instructions into machine operations — the first rung where one line of source need not be one machine operation.
- **C sits between** ➔ more understandable syntax than assembly, but still close to the machine **execution model**.
- **This was once the working level** ➔ Margaret Hamilton's team built the Apollo flight software at the machine level; complexity at that rung is possible, merely brutal.
- **Where the unit goes** ➔ each language studied later departs further from von Neumann architecture, ending at a genuinely different **model of computation** (the lambda calculus) rather than a friendlier notation for the same one.

## 🗺️ Layer & Dataflow
| Rung | Unit of expression | Translated by | Relation to machine ops | Portable? |
| :-- | :-- | :-- | :-- | :-- |
| high-level | statement / expression | compiler **or** interpreter | many-to-many | yes |
| assembly | `[label:] mnemonic [operands]` | assembler | **one-to-one** | no (per-ISA) |
| machine | binary opcode + operands | — (hardware / microprogram) | is the machine op | no (per-ISA) |

- **The von Neumann model** ➔ a model of computation closely matching real hardware (control unit · ALU · memory · input · output). It shares with the **Turing Machine** an **imperative, "instruction-following"** paradigm — exactly the assumption the lambda calculus drops.
- **Hardware context** ➔ CPU = ALU (arithmetic/logic) · CU (control) · registers · clock (synchronises the CPU with the rest of the system); wired by the **data bus** (moves instructions and operands), **address bus** (names the location to read/write), and **control bus**.

## 🚫 Not Examinable *(per the slide markers)*
The W1 deck explicitly stamps **"Not Examinable"** on: the instruction execution cycle; x86 data registers (`RAX`/`EAX`/`AX`/`AH`/`AL` and friends); the MASM `.386` / `main PROC` skeleton; and the arithmetic (`mov`, `add`, `sub`, `mul`, `div`, `xor`), jump (`jmp`, `loop`, `cmp`, `je`), stack (`push`, `pop`) and procedure (`call`, `ret`) tables. Read once for the feel of the rung; **spend no revision time here.** The assessable claim is the ladder and its consequences, above.

## ⚠️ Common Mistakes
- 💡 **Treating "needs a compiler" as the dividing line** ➔ assembly needs a translator too. The line is **one-to-one vs not**: an assembler renames, a compiler genuinely translates.
- 💡 **Reading "abstraction" as "convenience"** ➔ the payoff is *distance from the execution model*. C has friendlier syntax than assembly but has barely moved from the machine's model — which is why it is not a paradigm shift.

## 🧠 Active Recall
> [!FAQ]- Why does assembly language not count as a real abstraction over the machine, despite being human-readable?
> - **Hint:** Count the machine operations per line.
> > [!SUCCESS]- Answer
> > - **Short answer:** Its operations map **one-to-one** onto machine operations, so it inherits the machine's execution model unchanged.
> > - **Why:** **Renaming vs translating** ➔ assembly buys symbolic names for operations and memory locations, plus procedures and array/macro conveniences — real ergonomics, zero new semantics. A high-level language's compiler or interpreter can turn one construct into many machine operations, which is what lets it express a *different* model of computation.

> [!FAQ]- What does the von Neumann model share with the Turing Machine, and why does FIT2102 raise it in Week 1?
> > [!SUCCESS]- Answer
> > - **Short answer:** Both are **imperative, instruction-following** models — state plus a sequence of steps that mutate it.
> > - **Why:** **Setting up the contrast** ➔ naming the shared assumption early makes the unit's destination legible. The **lambda calculus** is an alternative model of computation with no instruction pointer and no mutable store, so the declarative styles in [[Programming Paradigms]] are not stylistic preferences but a different foundation.
