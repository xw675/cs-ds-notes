---
unit: FIT1047
week: 3
parent: "[[Transistors and Logic Gates]]"
tags: [CS/Systems, CS/Hardware]
aliases: [Half Adder, Full Adder, Multiplexer, Decoder, ALU]
---
# [[Combinational Circuits (Adders, Decoders, MUX, ALU)]]

**Context:** [[FIT1047_MOC]] · output = pure function of current inputs (no memory) · gates from [[Transistors and Logic Gates]] assembled into arithmetic hardware · contrast [[Sequential Circuits (Latches, Flip-Flops, Registers)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** four building blocks ➔ **adder** (arithmetic), **decoder** (1-of-$2^n$ activation), **MUX** (input selection), **ALU** (all ops in parallel + MUX picks by op-code).
> - **⚡ Key Constraint:** half adder = XOR (result) + AND (carry); full adder adds a carry-IN — chaining $n$ full adders = ripple-carry adder.

## 📝 Core
### 1. Adders
- **Half adder (2 one-bit inputs)** ➔ Result $= X \oplus Y$, Carry-out $= XY$ — read straight off $1{+}1=10_2$ ([[Number Systems (Binary and Hexadecimal)]]).
- **Full adder (3 inputs: $X, Y$, carry-in)** ➔ handles $1{+}1{+}1=11_2$; built from two half adders + OR.
- **Ripple-carry adder** ➔ chain $n$ full adders, each carry-out feeding the next carry-in ⟹ adds two $n$-bit numbers.

### 2. Decoder
- **Job** ➔ activate exactly ONE of $2^n$ outputs based on an $n$-bit input: input $10_2$ ⟹ only $D_2$ high.
- **Table (2-bit)** ➔ $AB{=}00{\to}D_0$, $01{\to}D_1$, $10{\to}D_2$, $11{\to}D_3$ — one-hot output.

### 3. Multiplexer (MUX)
- **Job** ➔ SELECT one of several inputs onto one output; built as decoder (choose) + AND gates (gate the chosen line) + OR (combine).
- **Duality** ➔ decoder activates an output line; MUX selects an input line — the two directions of "1-of-$n$".

### 4. ALU (Arithmetic-Logic Unit)
- **Role** ➔ fundamental computation block of every CPU (modern CPUs/GPUs carry many).
- **Operations** ➔ integer add/subtract (sometimes multiply), comparisons, bitwise AND/OR/NOT, shifts.
- **Interface** ➔ inputs: two $n$-bit operands + an **op-code**; outputs: $n$-bit result + status (overflow/error).
- **Trick** ➔ compute ALL operations in parallel, then a MUX selects the wanted result by op-code (lecture example: $00{:}A{+}B$, $01{:}A{-}B$, $10{:}A{+}1$, $11$: comparison).

## ⚠️ Common Mistakes
- 💡 **Half vs full adder** ➔ the difference is exactly the carry-IN input; a ripple chain needs FULL adders everywhere except (optionally) position 0.
- 💡 **ALU doesn't "choose then compute"** ➔ it computes everything and *selects* — that's why the MUX is the punchline of the whole week.

## 🧠 Active Recall
> [!FAQ]- Derive the half-adder gates from the 2-bit addition table, then explain what the full adder adds and why ripple-carry needs it.
> > [!SUCCESS]- Answer
> > - **Short answer:** Result column matches XOR, carry column matches AND; the full adder's third input accepts the previous position's carry-out — without it, chained addition can't propagate carries.
> > - **Why:** **$1{+}1{+}1 = 11_2$** ➔ three-input rows force both a result and a carry, satisfied by two half adders + OR.

> [!FAQ]- How does an ALU use a decoder/MUX to execute the right operation?
> > [!SUCCESS]- Answer
> > - **Short answer:** All operation circuits run in parallel on the operands; the op-code drives a MUX that forwards exactly one result.
> > - **Why:** **Selection beats gating computation** ➔ combinational logic is always-on; correctness comes from choosing outputs, not switching circuits off.
