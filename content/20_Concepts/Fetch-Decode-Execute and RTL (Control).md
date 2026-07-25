---
unit: FIT1047
domain: F
week: 3
parent: "[[Von Neumann Architecture and Programs]]"
tags: [CS/Systems, CS/Architecture]
aliases: [Fetch-Decode-Execute, RTL, Control Unit, Clock]
---
# [[Fetch-Decode-Execute and RTL (Control)]]

**Context:** [[FIT1047_MOC]] · how the control unit actually runs a program — the cycle + Register Transfer Language · **the A2/exam hand-trace skill** · registers from [[Sequential Circuits (Latches, Flip-Flops, Registers)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** every instruction = **fetch (steps 1–4) → decode (5–6 as needed) → execute (instruction-specific)**, one register transfer per clock cycle.
> - **📦 Core Components:** clock (oscillator, cycles, GHz) ➔ RTL steps ➔ control signals (which register/memory/ALU mode per step).
> - **⚡ Key Constraint:** fetch is ALWAYS the same 4 steps; decode steps 5–6 vary by instruction (both / only 5 / neither) — knowing which is where marks are won.

## 📝 Core
- **Control unit** ➔ coordinates registers, ALU, memory per instruction via three phases: fetch → decode → execute.
- **Clock** ➔ oscillator flipping 0↔1; each flip = a cycle; cycles/second in Hz (modern: GHz). Unit convention: **one register/memory/ALU transfer per cycle** (real instructions vary — memory loads can cost hundreds).
- **Control signals** ➔ physical wires selecting: which register reads/writes, memory read-or-write, ALU operation — set by (current phase, current instruction).

### The RTL steps
| Phase | Step | RTL | Meaning |
| :-- | :-- | :-- | :-- |
| Fetch | 1 | $\text{MAR} \leftarrow \text{PC}$ | address of next instruction |
| Fetch | 2 | $\text{MBR} \leftarrow M[\text{MAR}]$ | read instruction word |
| Fetch | 3 | $\text{IR} \leftarrow \text{MBR}$ | latch it as current instruction |
| Fetch | 4 | $\text{PC} \leftarrow \text{PC}+1$ | point at the next one |
| Decode | 5 | $\text{MAR} \leftarrow X$ | operand address from IR |
| Decode | 6 | $\text{MBR} \leftarrow M[\text{MAR}]$ | read the operand |
| Execute | 7+ | instruction-specific | e.g. $\text{AC} \leftarrow \text{AC}+\text{MBR}$ |

- **Decode variability** ➔ `Add X` needs 5 AND 6; `Jump X` needs only 5 (then $\text{PC} \leftarrow \text{MAR}$); some instructions need neither.
- **Signals per step** ➔ e.g. $\text{MBR} \leftarrow M[\text{MAR}]$: register file writes MBR + memory in read mode; $\text{AC} \leftarrow \text{AC}+\text{MBR}$: read AC, write AC, ALU in Add mode.

## 📊 Exam Execution Trace — complete `Add X` (7 cycles)
| Cycle | RTL | Phase |
| :-- | :-- | :-- |
| 1 | $\text{MAR} \leftarrow \text{PC}$ | fetch |
| 2 | $\text{MBR} \leftarrow M[\text{MAR}]$ | fetch |
| 3 | $\text{IR} \leftarrow \text{MBR}$ | fetch |
| 4 | $\text{PC} \leftarrow \text{PC}+1$ | fetch |
| 5 | $\text{MAR} \leftarrow X$ | decode |
| 6 | $\text{MBR} \leftarrow M[\text{MAR}]$ | decode |
| 7 | $\text{AC} \leftarrow \text{AC}+\text{MBR}$ | execute |

## ✍️ Practice
> [!QUESTION]- Write the full RTL sequence for `Jump X`, and state how many cycles it takes under the unit's one-transfer-per-cycle convention.
> > [!SUCCESS]- Answer
> > - Steps 1–4 (fetch, identical always) → 5: $\text{MAR} \leftarrow X$ → 6: $\text{PC} \leftarrow \text{MAR}$ — **6 cycles**, and memory is NOT read for an operand.
> > - **Key move:** Jump manipulates PC, so decode step 6 ($\text{MBR} \leftarrow M[\text{MAR}]$) is skipped — no data needed.

## ⚠️ Common Mistakes
- 💡 **PC increments during FETCH (step 4)** ➔ before execute; a Jump then *overwrites* the incremented PC — tracing PC wrongly is the classic error.
- 💡 **MBR is the only door to memory** ➔ all reads/writes pass MAR (address) + MBR (data); RTL that moves memory straight into AC is invalid.
- 💡 **Clock speed ≠ instructions/second** ➔ one instruction spans several cycles (Add = 7 here); GHz counts cycles.
