---
unit: FIT1008
week: 2
parent: "[[Data Type]]"
tags: [CS/DataStructures, CS/Abstraction, SWE/OOP]
---
# [[Abstract Data Type (ADT)]]

**Context:** [[FIT1008_MOC]] · the pure-specification rung of the abstraction ladder · becomes a [[Data Type]] once implemented · realised by a [[Data Structure]]

> [!abstract] Quick Revision
> - **🎯 Objective:** specify what a type does (values, meaning, operations), not how ➔ program against the interface, swap implementations freely.
> - **📦 Core Components:** a **contract** ➔ operations + pre/post-conditions + [[Invariant|invariant]], hardened by **encapsulation**.
> - **⚡ Key Constraint:** decouples interface from **cost** ➔ the same ADT has implementations with different complexity profiles.

## 📝 Core
### 1. The ADT (What, Not How)
- **Specification** ➔ values + meaning + operations, **no** implementation ([[Stack (ADT)]] = `push`/`pop`/`peek`, backing irrelevant).
- **Abstraction = ignoring** ➔ the user chooses to ignore the implementation.
- **Encapsulation** ➔ enforces it so callers *cannot* depend on internals.

### 2. The Contract (Design-by-Contract)
- **Contract** ➔ operations + **preconditions** + **postconditions** + an [[Invariant]] each preserves.
- **Substitutability** ➔ any implementation may replace another **if it honours the same contract**.
- **Boundary** ➔ violating encapsulation (poking internals) forfeits substitutability.

## ⚙️ Core Implementation
### 🔹 Programming against the contract
> [!code]- `reverse` depends only on the LIFO interface
> ```python
> def reverse(string: str) -> str:
>     s = ArrayStack(len(string))      # depend on the ADT, not the backing array
>     for char in string: s.push(char)
>     out = ""
>     while not s.is_empty(): out += s.pop()   # LIFO contract only
>     return out
> ```
> 💡 **Common Mistake:** **WHAT decoupled from HOW** ➔ `reverse` works unchanged for **any** Stack implementation; swapping `ArrayStack(n)` for a linked stack changes only the constructor call.

## ⚖️ Core Decision Matrix
| Advantage | What it buys | Trade-off |
| :--- | :--- | :--- |
| **Simplicity** | reason about operations, not bytes | small indirection |
| **Maintainability** | change impl without touching clients | can hide a poor impl choice |
| **Flexibility** | swap array ↔ linked freely | requires honouring the contract |
| **Portability** | one interface across machines/langs | — |

> [!NOTE] **When It Flips:** interface ≠ cost — a [[Priority Queue (ADT)]] is $O(1)$/$O(n)$ as a sorted list but $O(\log n)$/$O(\log n)$ as a [[Heap]]; choosing the implementation to fit the workload is the central design act.

## 📊 Exam Execution Trace

### Manual Execution Trace
Same ADT ([[Priority Queue (ADT)]]), different implementation costs:

| Step / State | Implementation | `add` | `get_max` |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | (ADT interface) | — | — |
| 1 | sorted list | $O(n)$ | $O(1)$ |
| 2 | **[[Heap]]** | $O(\log n)$ | $O(\log n)$ |
| 3 | Fibonacci heap | $O(1)$ amortised | $O(\log n)$ |

### Applied Exercise
**Problem:** Justify why two implementations of an ADT are freely substitutable.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{client depends on} &: \text{contract } C = (\text{ops}, \text{pre}, \text{post}, \text{invariant}) \\
\text{impl}_1, \text{impl}_2 \text{ both honour } C &\Rightarrow \text{client behaves identically} \Rightarrow \text{swap freely}
\end{aligned}
$$
**Final Extracted Output:** substitutability follows from contract conformance, not shared code — the whole point of separating ADT from data structure.

## 🧠 Active Recall
> [!FAQ]- Why can you swap one implementation of an ADT for another without changing client code?
> - **Hint:** Clients depend on the contract, not internals.
> > [!SUCCESS]- Answer
> > - **Short answer:** Any implementation honouring the same operations + pre/post-conditions + invariants behaves identically from outside.
> > - **Why:** **Encapsulation** ➔ stops clients coupling to internals, so a linked stack replaces an array stack with no client change.

> [!FAQ]- The same ADT can have wildly different complexities — give an example and the design lesson.
> - **Hint:** Interface fixes ops, not cost.
> > [!SUCCESS]- Answer
> > - **Short answer:** A [[Priority Queue (ADT)]]: sorted list ($O(1)$ get_max / $O(n)$ add) vs [[Heap]] ($O(\log n)$ both).
> > - **Why:** **Workload-fit** ➔ choose the implementation whose complexity profile matches your operation mix.

> [!FAQ]- "Abstraction is ignoring, not hiding" — how do encapsulation and design-by-contract sharpen this?
> - **Hint:** Convention vs guaranteed boundary.
> > [!SUCCESS]- Answer
> > - **Short answer:** "Ignoring" = relying only on the interface; encapsulation enforces it; design-by-contract makes it precise.
> > - **Why:** **Guaranteed boundary** ➔ pre/post-conditions + invariants turn convention into an enforced boundary, enabling safe swaps and independent reasoning.
