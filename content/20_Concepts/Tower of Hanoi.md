---
unit: FIT1008
domain: A
week: 6
parent: "[[Recursion]]"
tags: [CS/Algorithms, SWE/OOP, CS/Complexity]
---
# [[Tower of Hanoi]]

**Context:** [[FIT1008_MOC]] · the classic **binary** [[Recursion]] ([[Recursion|Recursion Notation]]) · a [[Divide and Conquer]]-style problem with exponential cost

> [!abstract] Quick Revision
> - **🎯 Objective:** move $n$ discs source→destination (never larger-on-smaller) ➔ canonical binary recursion whose exponential cost is intrinsic.
> - **📦 Core Components:** move top $n-1$ aside ➔ move bottom disc ➔ restack the $n-1$.
> - **⚡ Key Constraint:** exactly $2^n-1$ moves $=\Theta(2^n)$ (provably optimal for 3 pegs); only $\Theta(n)$ stack.

## 📝 Core
### 1. The Problem & Recursive Solution
- **Rules** ➔ move $n$ discs source→destination, never larger-on-smaller; 3 pegs, spare = "the other peg".
- **Binary recursion** ➔ clear top $n-1$ to spare ➔ move bottom disc ➔ restack the $n-1$.

### 2. Cost: $2^n - 1$ and Optimality
- **Recurrence** ➔ $T(1)=1,\ T(n)=2T(n-1)+1$ → $T(n)=2^n-1$.
- **Provably minimal** ➔ moving the bottom disc *forces* all $n-1$ onto the spare first ($\ge T(n-1)$) then onto it after ($\ge T(n-1)$) ➔ $\ge 2T(n-1)+1$.

### 3. Binary but Not Overlapping
- **Distinct subproblems** ➔ two calls per level (like naive [[Recursion|Fibonacci]]), but they use **different pegs**.
- **No memoisation** ➔ $2^n-1$ moves are genuinely required **output**; space is $\Theta(n)$ (one live path), not $\Theta(2^n)$.

## ⚙️ Core Implementation
### 🔹 `tower_Hanoi` (binary, direct recursion)
> [!code]- recursive disc moves
> ```python
> def tower_Hanoi(n, from_peg, to_peg):
>     via = the_other_peg(from_peg, to_peg)          # the unused peg of {1,2,3}
>     if n == 1:
>         print(f"{from_peg} -> {to_peg}")           # base: move the single disc
>     else:
>         tower_Hanoi(n-1, from_peg, via)            # 1. clear the top n-1
>         print(f"{from_peg} -> {to_peg}")           # 2. move the bottom disc
>         tower_Hanoi(n-1, via, to_peg)              # 3. restack the n-1
> ```
> 💡 **Common Mistake:** **Exponential time/output ≠ exponential space** ➔ the call tree has $2^n-1$ nodes but only one path is live, so stack is $\Theta(n)$; an iterative version emits the identical sequence with $\Theta(1)$ control state.

## ⚖️ Core Decision Matrix
| Aspect             | Tower of Hanoi                 | naive [[Recursion\|Fibonacci]] |
| :----------------- | :----------------------------- | :----------------------------- |
| Recursion shape    | binary, direct                 | binary, direct                 |
| Subproblems        | **distinct** (different pegs)  | **overlapping** (recomputed)   |
| Time               | $\Theta(2^n)$ (= output size)  | $\Theta(\varphi^n)$            |
| Memoisation helps? | **No** — output is exponential | **Yes** → $\Theta(n)$          |
| Space (stack)      | $\Theta(n)$                    | $\Theta(n)$                    |

> [!NOTE] **When It Flips:** vs [[Divide and Conquer]] — Hanoi divides into two subproblems + a $\Theta(1)$ combine, but the subproblems are size $n-1$ (not $n/2$), hence exponential not log-linear.

## 📊 Exam Execution Trace

### Manual Execution Trace
`tower_Hanoi(3, A, C)` (7 moves = $2^3-1$):

| Step / State | Trigger Op | Move | Sub-call |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | call | — | clear top 2 (A→B uses C) |
| 1 | move | A → C | |
| 2 | move | A → B | |
| 3 | move | C → B | |
| 4 | move | A → C | move bottom disc |
| 5 | move | B → A | restack 2 (B→C uses A) |
| 6 | move | B → C | |
| 7 | move | A → C | |

### Applied Exercise
**Problem:** Solve the move-count recurrence and confirm optimality.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
T(n) &= 2T(n-1)+1 = 2^{n-1}+2^{n-2}+\dots+1 \\
&= \sum_{k=0}^{n-1} 2^{k} = 2^n - 1 \quad(\text{geometric series; matches the } 2T(n-1)+1 \text{ lower bound})
\end{aligned}
$$
**Final Extracted Output:** exactly $2^n-1$ moves — the provable minimum for 3 pegs (Q.E.D.).

## 🧠 Active Recall
> [!FAQ]- Derive the exact move count and prove it is optimal.
> - **Hint:** Recurrence + a matching lower bound.
> > [!SUCCESS]- Answer
> > - **Short answer:** $T(n)=2T(n-1)+1 = 2^n-1$ (geometric series / induction).
> > - **Why:** **Forced moves** ➔ moving the bottom disc forces all $n-1$ onto the spare and back ($\ge 2T(n-1)+1$), so $2^n-1$ is minimal.

> [!FAQ]- Hanoi and naive Fibonacci are both exponential binary recursions — why can memoisation rescue one but not the other?
> - **Hint:** Distinct vs overlapping subproblems.
> > [!SUCCESS]- Answer
> > - **Short answer:** Fibonacci recomputes the same subproblems (cacheable → $\Theta(n)$); Hanoi's subproblems are distinct.
> > - **Why:** **Exponential output** ➔ Hanoi must *emit* $2^n-1$ moves — no caching can reduce the output size.

> [!FAQ]- Hanoi's time is $\Theta(2^n)$ — why is its space only $\Theta(n)$, and what does an iterative version reveal?
> - **Hint:** One live root-to-leaf path.
> > [!SUCCESS]- Answer
> > - **Short answer:** The call tree has $2^n-1$ nodes but only one path is active ⟹ stack $\Theta(n)$.
> > - **Why:** **Inherent to the moves** ➔ an iterative version emits the same sequence with $\Theta(1)$ control state — the exponential is in the moves, not the recursion.
