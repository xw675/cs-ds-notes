---
unit: FIT1047
week: 3
parent: "[[Combinational Circuits (Adders, Decoders, MUX, ALU)]]"
tags: [CS/Systems, CS/Hardware]
aliases: [SR Latch, D Flip-Flop, Registers, Register File]
---
# [[Sequential Circuits (Latches, Flip-Flops, Registers)]]

**Context:** [[FIT1047_MOC]] · circuits that REMEMBER — output depends on input *history* via feedback · this is how memory and CPU registers exist · registers star in [[Fetch-Decode-Execute and RTL (Control)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** feedback loop ➔ 1-bit memory (SR latch) ➔ clocked storage (D flip-flop) ➔ $n$ flip-flops = a register ➔ registers + select lines = register file.
> - **⚡ Key Constraint:** SR latch input $S{=}R{=}1$ is **forbidden**; combinational circuits compute, sequential circuits remember — the exam discriminator.

## 📝 Core
### 1. From Feedback to the SR Latch
- **Step 1 remember forever** ➔ feed output back into input: once 1, always 1.
- **Step 2/3 set–reset** ➔ SR latch: $S$ sets $Q{=}1$, $R$ resets $Q{=}0$, $S{=}R{=}0$ holds the previous $Q(t)$; $S{=}R{=}1$ **forbidden** (both feedback paths fight).

### 2. D Flip-Flop (the clean 1-bit memory)
- **Inputs** ➔ $D$ = data to store + a control signal (write enable / clock): "read or write?".
- **Output** ➔ the stored bit; eliminates the forbidden state by deriving $S,R$ from a single $D$.

### 3. Registers (the CPU's own memory)
- **Register** ➔ $n$ D flip-flops storing one $n$-bit word — the fastest memory, inside the CPU.
- **MARIE's special-purpose set** ➔ **PC** (address of next instruction) · **IR** (current instruction) · **MAR** (memory address to access) · **MBR** (value read/written) · general-purpose: **AC** accumulator.
- **Register file** ➔ collection of registers + control lines selecting which register reads/writes; one word in, one word out.

## ⚖️ Core Decision Matrix — SR latch behaviour
| $S$ | $R$ | $Q(t{+}1)$ | Meaning |
| :-- | :-- | :-- | :-- |
| $0$ | $0$ | $Q(t)$ | hold (memory!) |
| $1$ | $0$ | $1$ | set |
| $0$ | $1$ | $0$ | reset |
| $1$ | $1$ | — | **forbidden** |

## ⚠️ Common Mistakes
- 💡 **Combinational vs sequential** ➔ "output = function of inputs" vs "output depends on input SEQUENCE (state)"; adders can't remember, latches can.
- 💡 **The hold row is the point** ➔ $S{=}R{=}0$ preserving $Q(t)$ IS the memory; students often describe set/reset and forget hold.

## 🧠 Active Recall
> [!FAQ]- Why can't a combinational circuit implement memory, and what circuit trick fixes that?
> > [!SUCCESS]- Answer
> > - **Short answer:** Combinational outputs are pure functions of current inputs — no state; feeding an output BACK into an input creates state.
> > - **Why:** **Feedback loop** ➔ the SR latch's cross-coupled structure holds $Q$ stable under $S{=}R{=}0$, storing one bit indefinitely.

> [!FAQ]- Name MARIE's five key registers and their one-line jobs.
> > [!SUCCESS]- Answer
> > - **Short answer:** PC → next instruction's address; IR → current instruction; MAR → memory address for load/store; MBR → data buffer to/from memory; AC → arithmetic accumulator.
> > - **Why:** **RTL preview** ➔ every [[Fetch-Decode-Execute and RTL (Control)|fetch-decode-execute]] step is a transfer between exactly these registers.
