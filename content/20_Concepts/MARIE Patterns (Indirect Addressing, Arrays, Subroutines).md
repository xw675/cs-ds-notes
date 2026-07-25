---
unit: FIT1047
week: 4
parent: "[[MARIE Assembly (Instruction Set and Patterns)]]"
tags: [CS/Systems, CS/Assembly]
type: pattern
aliases: [Indirect Addressing, JnS, MARIE Subroutines, MARIE Arrays]
---
# [[MARIE Patterns (Indirect Addressing, Arrays, Subroutines)]]

**Context:** [[FIT1047_MOC]] · Week 4's three task shapes, all powered by ONE mechanism: *interpret a stored value as an address* · ISA in [[MARIE Assembly (Instruction Set and Patterns)]] · **the heart of Assignment 2**
**Problem it solves:** walk variable-length data (arrays/strings) and call/return from subroutines in MARIE.

> [!abstract] Quick Revision
> - **🎯 Trigger:** fixed address in code ➔ inflexible; `LoadI/StoreI/AddI` deref a **pointer** ($M[M[X]]$) ➔ loops over sequences become possible.
> - **📦 Core Components:** pointer walk (load ptr → `Add One` → store ptr) ➔ termination (counter `SkipCond 400` or 0-terminator `SkipCond 800`... note: skip fires while $AC>0$) ➔ call/return (`JnS`/`JumpI`).
> - **⚡ Key Constraint:** `JnS X` stores the RETURN PC **at X itself** and jumps to $X{+}1$ — so every subroutine starts with a `HEX 0` slot; returning is `JumpI X`.

## 🔧 Pattern 1 — Direct vs Indirect (the mechanism)
- **Direct** ➔ `Load X`: $\text{AC} \leftarrow M[X]$ — the address is frozen into the program.
- **Indirect** ➔ `LoadI X`: read $v = M[X]$, then $\text{AC} \leftarrow M[v]$ — $X$ holds a **pointer**; change $M[X]$ at runtime and the same instruction touches different data.
- **Lecture trace** ➔ with $M[200]=100$ and $M[100]=72$: `LoadI 200` puts $72$ in AC; then `Load 200 / Add One / Store 200` bumps the pointer to $101$ — the next `LoadI 200` reads $M[101]$.

## 🔧 Pattern 2 — Array sum (counter-terminated loop)
```text
      Load  Length          / counter loop: known length
Loop, Load  Temp
      AddI  Start           / Temp += *Start   (indirect!)
      Store Temp
      Load  Start           / Start++          (advance pointer)
      Add   One
      Store Start
      Load  Length          / Length--
      Subt  One
      Store Length
      SkipCond 400          / Length = 0 ? done
      Jump  Loop
      Load  Temp
      Output
      Halt
Start,  Adr Array           / POINTER: address of first element
Length, DEC 5
Array,  DEC 1 / DEC 2 / DEC 3 / DEC 4 / DEC 5   (one per line in real code)
One,    DEC 1
Temp,   DEC 0
```
**Expected output:** $15$. *(Structure per lecture "Adding up an array"; line order reconstructed from the slide fragments — verify against the e-textbook listing.)*

## 🔧 Pattern 3 — 0-terminated string output (sentinel loop, lecture verbatim)
```text
Loop, LoadI StringStart     / AC ← current char
      SkipCond 800          / char > 0 ? skip the Halt
      Halt                  / hit the 0 terminator
      Output
      Load  StringStart     / advance pointer
      Add   One
      Store StringStart
      Jump  Loop
StringStart, Adr String
String, HEX 46 / HEX 49 / HEX 54 ... HEX 0      / "FIT1047", end-marked by 0
One,    DEC 1
```
- **Two termination styles** ➔ explicit `Length` counter vs implicit sentinel (`HEX 0` end marker) — the string pattern needs no length variable.

## 🔧 Pattern 4 — Subroutine call/return (`Double`, lecture verbatim)
```text
/ Main
      Input
      Store DoubleArg       / pass argument via labelled memory
      JnS   Double          / call: M[Double] ← PC, jump Double+1
      Load  DoubleArg       / result returned in the same slot
      Output
      Halt
/ Subroutine
DoubleArg, DEC 0            / argument + result slot
Double,    HEX 0            / RESERVED: return address lands here
      Load  DoubleArg
      Add   DoubleArg
      Store DoubleArg
      JumpI Double          / return: PC ← M[Double]
```
- **Calling convention** ➔ argument in a labelled cell · `JnS` deposits return PC in the `HEX 0` slot · body runs · `JumpI` jumps *through* that slot.

## ✍️ Practice
> [!QUESTION]- Write a subroutine `Triple` that triples `TripleArg`, and a main program that inputs a number, calls it, outputs the result. No peeking at Pattern 4.
> > [!SUCCESS]- Reference solution
> > Same skeleton as `Double` with `Load TripleArg / Add TripleArg / Add TripleArg / Store TripleArg / JumpI Triple`, and `Triple, HEX 0` heading the subroutine.
> > - **Key move:** the `HEX 0` slot BEFORE the first body instruction — forget it and `JnS` overwrites your first instruction with the return address.

> [!QUESTION]- Why does the string loop test `SkipCond 800` but the counter loop `SkipCond 400`? What breaks if a string character were stored as a negative value?
> > [!SUCCESS]- Answer
> > - String: keep looping while char $> 0$, halt on the $0$ sentinel; counter: stop exactly when Length $= 0$.
> > - A negative "char" fails the $>0$ test and terminates early — sentinel loops assume data is strictly positive.
> > - **Key move:** choose the SkipCond constant from the loop's *invariant*, not habit.

## ⚠️ Common Mistakes
- 💡 **`Adr` vs `DEC`** ➔ `Start, Adr Array` stores Array's ADDRESS (a pointer); `DEC` stores a value — mixing them up dereferences garbage.
- 💡 **`JnS` clobbers $M[X]$** ➔ the subroutine label's cell is *live storage* for the return PC; recursive calls therefore break (no stack in MARIE).
- 💡 **Pointer increment is 3 instructions** ➔ `Load ptr / Add One / Store ptr` — there is no `Inc`; forgetting the `Store` loops forever on element 0.
