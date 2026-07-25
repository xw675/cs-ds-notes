---
unit: FIT1047
domain: F
week: 3
parent: "[[Computer Fundamentals (Bits, Bytes, Words)]]"
tags: [CS/Systems, CS/Architecture]
aliases: [Von Neumann, Machine Code, ISA, Assembly Language]
---
# [[Von Neumann Architecture and Programs]]

**Context:** [[FIT1047_MOC]] · the blueprint of every modern computer + what a program actually is · concretised by MARIE ([[MARIE Assembly (Instruction Set and Patterns)]]) · executed by [[Fetch-Decode-Execute and RTL (Control)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** Von Neumann = **CPU (ALU + registers + control) + memory + I/O**, with memory holding **both data AND program code**.
> - **📦 Core Components:** machine code ➔ ISA ➔ assembly (mnemonics) ➔ compilers/interpreters bridge to high-level languages.
> - **⚡ Key Constraint:** "stored program" is THE idea — instructions live in the same addressed memory as data, moved over a bus.

## 📝 Core
### 1. The Architecture
- **CPU** ➔ ALU (arithmetic + Boolean ops) · registers (fast temporary storage, data movement) · control unit (switches every component per instruction).
- **Memory** ➔ stores data **and** program code; a sequence of addressed "boxes" ($0,1,2,\dots$), each holding one word; CPU reads/writes via a **bus**.
- **I/O** ➔ everything else attached: keyboard, screen, disk, sensors, USB…
- **MARIE** ➔ *Machine Architecture that is Really Intuitive and Easy* — simulator with all components; 16-bit data words, 12-bit address bus, 16-bit data bus.

### 2. Programs: Machine Code up to Python
- **CPUs execute ONLY machine code** ➔ sequences of instructions, stored in memory, one-or-more words each; architecture-specific (phone ≠ laptop code).
- **ISA** ➔ the instruction set a CPU type understands: maths ops, data movement (memory↔registers↔I/O), conditionals/jumps.
- **Assembly language** ➔ one **mnemonic** per machine instruction (`Load`, `Add`, `Store`, `Jump`); the **assembler** translates 1-to-1 to machine code — readable machine code, nothing more.
- **Compiler** ➔ translates high-level → lower-level (C/C++ → machine code; Java → bytecode for an interpreter).
- **Interpreter** ➔ a machine-code program that executes high-level code directly (Python) — some languages use both stages.

## ⚖️ Core Decision Matrix
| Layer | Example | Executed by | Portable? |
| :-- | :-- | :-- | :-- |
| high-level | Python / Java / C++ | via interpreter / compiler | yes |
| assembly | `Load 0xA003, R0` | assembler → machine code | no (per-ISA) |
| machine code | `0001000110001110` | CPU directly | no (per-ISA) |

## ⚠️ Common Mistakes
- 💡 **Assembly ≠ high-level** ➔ 1-to-1 with machine instructions; a compiler does real translation, an assembler only renames.
- 💡 **Data vs code is a convention** ➔ the same 16-bit word in memory is an instruction OR a number depending on how execution reaches it — the stored-program idea's double edge.

## 🧠 Active Recall
> [!FAQ]- Draw the Von Neumann block diagram from memory and state each component's one-line job.
> > [!SUCCESS]- Answer
> > - **Short answer:** CPU {ALU: compute · registers: fast temporaries · control: orchestrate} ↔ bus ↔ memory (code + data) ↔ I/O.
> > - **Why:** **Stored program** ➔ keeping instructions in general memory is what makes the machine *re-programmable* rather than re-wired.

> [!FAQ]- Trace "Hello World" in Python down to silicon: name every translation layer.
> > [!SUCCESS]- Answer
> > - **Short answer:** Python source → interpreter (itself machine code) executes it; compiled languages: C++ source → compiler → ISA-specific machine code → fetch-decode-execute.
> > - **Why:** **ISA as contract** ➔ all software ultimately becomes instructions from the CPU's instruction set — the meeting point of software and hardware.
