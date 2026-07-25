---
unit: FIT1008
domain: A
week: 1
parent: "[[Algorithm]]"
tags: [CS/Algorithms, CS/Foundations]
---
# [[Invariant]]

**Context:** [[FIT1008_MOC]] · the correctness-proof tool behind the elementary sorts, [[Binary Search]], [[Heap]] · induction over iterations

> [!abstract] Quick Revision
> - **🎯 Objective:** a property that stays true at a program point / across an algorithm ➔ the rigorous tool for proving correctness and finding optimisations.
> - **📦 Core Components:** **initialization → maintenance → termination** (induction over iterations).
> - **⚡ Key Constraint:** maintenance + termination ⟹ **partial** correctness; add a **variant** for **total** correctness.

## 📝 Core
### 1. The Invariant (A Property Preserved)
- **Definition** ➔ a property that **remains true** at a program point or throughout an algorithm.
- **Loop invariant** ➔ holds before the loop, preserved by every iteration ➔ still holds at exit.
- **Payoff** ➔ anything provably always-true can be **exploited to skip work** ➔ the basis of every correctness proof.

### 2. The Three-Part Proof
- **Initialization** ➔ $P$ holds before the first iteration.
- **Maintenance** ➔ $P$ before ⟹ $P$ after each iteration.
- **Termination** ➔ loop ends + negated guard ⟹ postcondition.
- **Total correctness** ➔ maintenance + termination give **partial**; a **variant** (non-negative integer measure strictly decreasing, e.g. `end - start`) proves halting ⟹ **total**.

## ⚖️ Core Decision Matrix
| Algorithm | Key loop invariant | What it enables |
| :--- | :--- | :--- |
| [[Sorting Problem|Bubble Sort]] | after pass $i$, the $i$ largest are final at the tail | early-exit ($O(n)$ best) |
| [[Sorting Problem|Selection Sort]] | prefix is sorted **and final** | correctness; blocks adaptivity |
| [[Sorting Problem|Insertion Sort]] | prefix sorted, **not necessarily final** | incremental inserts |
| [[Binary Search]] | target, if present, lies in `[lo, hi]` | shrink-by-half correctness |
| [[Heap]] | every node $\ge$ its children | $O(\log n)$ `get_max` |
| [[Hash Table|Linear Probing]] | key with hash $N$ sits between $N$ and first empty slot | search/delete correctness |

> [!NOTE] **When It Flips:** class invariants generalise to objects — a property every public method preserves (a [[Queue (ADT)|CircularQueue]]'s `front`/`rear`/`count` consistency). Invariants prove *correctness*; [[Big-O Notation|asymptotic analysis]] proves *cost* — the two halves of analysis.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Show the invariant method is induction over iterations.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\textbf{base}\;(\text{initialization}) &: P \text{ holds before iteration } 1 \\
\textbf{step}\;(\text{maintenance}) &: P \text{ before iter } k \Rightarrow P \text{ before iter } k{+}1 \\
\therefore\; & P \text{ holds at every iteration, incl. the last (termination)}
\end{aligned}
$$
**Final Extracted Output:** initialization = base case, maintenance = inductive step ⟹ $P$ at exit gives the postcondition.

## ⚠️ Common Mistakes
- 💡 **Invariant ≠ termination** ➔ it proves correctness *if* the loop halts; you still need a separate **variant** (a strictly-decreasing non-negative measure) for total correctness.

## 🧠 Active Recall
> [!FAQ]- State the three obligations of a loop-invariant proof and which combination gives total vs partial correctness.
> - **Hint:** Partial vs total.
> > [!SUCCESS]- Answer
> > - **Short answer:** Initialization + maintenance + termination; maintenance + termination = **partial**, add a decreasing non-negative **variant** for **total**.
> > - **Why:** **Variant proves halting** ➔ correctness-if-it-halts becomes correct-and-halts.

> [!FAQ]- How does the loop-invariant method relate to mathematical induction?
> - **Hint:** Induction over iteration count.
> > [!SUCCESS]- Answer
> > - **Short answer:** Initialization = base case, maintenance = inductive step ⟹ holds at every iteration including the last.
> > - **Why:** **Discrete index** ➔ exactly induction on the iteration counter.

> [!FAQ]- Why is the *difference* between selection and insertion sort's invariants algorithmically significant?
> - **Hint:** Invariant strength gates optimisation.
> > [!SUCCESS]- Answer
> > - **Short answer:** Selection's prefix is **final** (stronger, blocks reuse); insertion's is "sorted but not final" (permits one-pass insertion).
> > - **Why:** **Sound optimisations** ➔ the weaker invariant makes insertion sort incremental/online; the stronger one forbids it.
