---
unit: FIT1008
domain: A
week: 1
parent: "[[Computational Problem]]"
tags: [CS/Algorithms, CS/Foundations]
---
# [[Algorithm]]

**Context:** [[FIT1008_MOC]] · a finite, halting recipe that solves a [[Computational Problem]] · the *how* to a problem's *what*

> [!abstract] Quick Revision
> - **🎯 Objective:** finite well-defined instruction sequence ➔ maps each valid input to the correct output and always halts.
> - **📦 Core Components:** **Termination** ➔ variant | **Correct I/O** ➔ invariant | **Total correctness** = both.
> - **⚡ Key Constraint:** graded by [[Big-O Notation|asymptotic cost]] ➔ polynomial (tractable, P) vs exponential (intractable, NP-hard).

## 📝 Core
### 1. The Algorithm (Finite, Halting, Correct)
- **Core mechanism** ➔ finite well-defined steps solving a [[Computational Problem]] ➔ correct output + always halts.
- **Two obligations** ➔ **terminates** on every instance AND correct **input→output** relation.
- **Many per problem** ➔ [[Linear Search]] vs [[Binary Search]] ➔ same result, arbitrarily different cost.

### 2. Total Correctness (Partial + Termination)
- **Partial correctness** ➔ *if* it halts, $\text{Post}$ holds ➔ proved by a loop [[Invariant]].
- **Termination** ➔ a **variant** (non-negative integer strictly decreasing) ➔ proves halting.
- **Total** ➔ partial $+$ termination ➔ from any $\text{Pre}$-state, halts in a $\text{Post}$-state.

### 3. Tractability & Determinism
- **Solvable ≠ efficient** ➔ decidable yet possibly no efficient algorithm.
- **Class boundary** ➔ polynomial = **tractable** (P) | only-exponential = **intractable** (NP-hard).
- **Randomised** ➔ trade worst-case guarantee for strong *expected* cost (randomised [[Quick Sort]]).

## ⚙️ Core Implementation
### 🔹 Euclid's algorithm — finite, halting, correct
> [!code]- `gcd` with invariant + variant
> ```python
> def gcd(a, b):                 # Euclid's algorithm
>     while b != 0:              # variant: b strictly decreases => termination
>         a, b = b, a % b
>     return a                   # invariant: gcd(a,b) preserved each step
> # gcd(45, 30) -> 15
> ```
> 💡 **Common Mistake:** **Variant ≠ invariant** ➔ termination needs a strictly-decreasing non-negative measure (here `b`); partial correctness alone does **not** prove halting.

## ⚖️ Core Decision Matrix
| Concept | What it is | Owns | Example |
| :--- | :--- | :--- | :--- |
| [[Computational Problem]] | input→output specification | **lower** bounds | "find $\gcd(a,b)$" |
| **Algorithm** | finite, correct recipe solving it | **upper** bounds | Euclid's algorithm |
| Instance | one concrete input | $-$ | $\gcd(45,30)$ |

> [!NOTE] **When It Flips:** a *specific* algorithm sets an **upper** bound; the *problem* sets the **lower** bound ($\Omega$). When the algorithm's $O$ meets the problem's $\Omega$ ➔ **provably optimal**.

## 📊 Exam Execution Trace

### Manual Execution Trace
`gcd(45, 30)`:

| Step / State | Trigger Op | `a` | `b` | Variant `b` ↓ | Return Payload |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `init` | `45` | `30` | `30` | $-$ |
| 1 | `a,b = b, a%b` | `30` | `15` | `15` | $-$ |
| 2 | `a,b = b, a%b` | `15` | `0` | `0` → halt | $-$ |
| 3 | `return a` | `15` | $-$ | $-$ | `15` |

### Applied Exercise
**Problem:** State the obligations that establish total correctness of `gcd`.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{partial correctness} &= \{\text{Pre}\}\ \text{prog}\ \{\text{Post}\} \implies \text{loop invariant: } \gcd(a,b)\text{ preserved} \\
\text{termination} &= \exists\, v=b \in \mathbb{N},\ v \text{ strictly decreases} \implies \text{halts} \\
\text{total} &= \text{partial} + \text{termination}
\end{aligned}
$$
**Final Extracted Output:** `gcd` is **totally correct** — invariant gives partial correctness, variant `b` gives termination.

## 🧠 Active Recall
> [!FAQ]- Distinguish partial correctness, termination, and total correctness, and name the proof device for each.
> - **Hint:** Separate "correct-if-halts" from "halts", and combine them.
> > [!SUCCESS]- Answer
> > - **Short answer:** Partial = loop **invariant**; termination = strictly-decreasing **variant**; total = both.
> > - **Why:** **Hoare logic** ➔ $\{\text{Pre}\}\,\text{prog}\,\{\text{Post}\}$ + a well-founded measure ⟹ from any pre-state it halts in a valid post-state.

> [!FAQ]- "Solvable" and "efficiently solvable" differ — explain via tractability.
> - **Hint:** Decidability vs polynomial-time feasibility.
> > [!SUCCESS]- Answer
> > - **Short answer:** An algorithm proves **solvable**; **efficiency** depends on asymptotic cost.
> > - **Why:** **P vs NP-hard** ➔ polynomial = tractable; only-exponential-known = intractable — a correct but exponential algorithm shows solvability without tractability.

> [!FAQ]- Why can one problem have many algorithms, and why does it matter?
> - **Hint:** The problem fixes the relation, not the method.
> > [!SUCCESS]- Answer
> > - **Short answer:** A [[Computational Problem]] fixes only input→output ➔ many finite procedures satisfy it.
> > - **Why:** **Asymptotic divergence** ➔ linear vs binary search are both correct but $O(n)$ vs $O(\log n)$ — algorithm choice, not problem choice, drives scalability.
