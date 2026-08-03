---
unit: [FIT1008, FIT2004]
domain: A
week: [1, 7]
parent: "[[Recursion]]"
tags: [CS/Algorithms, CS/Complexity]
---
# [[Divide and Conquer]]

**Context:** [[FIT1008_MOC]], [[FIT2004_MOC]] · a [[Recursion|recursive]] strategy · powers [[Binary Search]], [[Merge Sort]], [[Quick Sort]] · solves the [[Sorting Problem]]
**FIT2004 use:** the examinable examples are [[Merge Sort]] and [[Quick Sort]]; every D&C algorithm's running time is found by [[Solving Recurrences (Telescoping)|solving the cost recurrence]] $T(n)=a\,T(n/b)+f(n)$, where $a$ counts **recursive calls** and $f(n)$ the combine.

> [!abstract] Quick Revision
> - **🎯 Objective:** divide into subproblems, conquer recursively, combine ➔ most efficient when splits are roughly equal.
> - **📦 Core Components:** **split** ➔ recurse on parts ➔ **combine** | split **balance** sets the depth.
> - **⚡ Key Constraint:** balanced halves → $\Theta(n\log n)$; lopsided → $\Theta(n^2)$; single-half search → $\Theta(\log n)$.

## 📝 Core
### 1. The Strategy (Divide / Conquer / Combine)
- **Divide** ➔ split into subproblems; **conquer** ➔ solve each recursively + *independently*; **combine** ➔ merge solutions.
- **Base case** ➔ size $\le 1$.
- **Efficiency condition** ➔ best when subproblems are **roughly equal in size** ➔ depth $\Theta(\log n)$.

### 2. Cost by Levels
- **Recursion tree** ➔ total cost = (levels) × (work per level).
- **Balanced** ➔ $\log_2 n$ × $\Theta(n)$ = $\Theta(n\log n)$; **lopsided** ➔ $n$ × $\Theta(n)$ = $\Theta(n^2)$; **single-half** + $\Theta(1)$ work ➔ $\Theta(\log n)$.

### 3. Independence Assumption (vs DP)
- **Assumption** ➔ subproblems are **independent** (non-overlapping), solved once.
- **Overlap break** ➔ $\text{fib}(n)$ recomputing $\text{fib}(n-2)$ ⟹ exponential ➔ use **memoisation / dynamic programming**.

## ⚙️ Core Implementation
*Split/combine trade-off:* [[Merge Sort]] = trivial split, heavy combine; [[Quick Sort]] = heavy split, trivial combine; [[Binary Search]] = single-subproblem "decrease and conquer".

### 🔹 The D&C skeleton
> [!code]- generic divide-and-conquer sort
> ```python
> def sort(array) -> None:
>     if len(array) > 1:                   # base case: len <= 1 already sorted
>         split(array, first_part, second_part)
>         sort(first_part)                 # conquer each half
>         sort(second_part)
>         combine(first_part, second_part)
> ```
> 💡 **Common Mistake:** **Shrink by factor vs by one** ➔ halving gives depth $\log n$, peeling one element gives depth $n$ — the $\Theta(n\log n)$ vs $\Theta(n^2)$ divide and quicksort's bad-pivot degeneration.

## ⚖️ Core Decision Matrix
| Split balance | Levels × work/level | Result | Example |
| :--- | :--- | :--- | :--- |
| Even halves | $\log_2 n$ × $\Theta(n)$ | $\Theta(n\log n)$ | [[Merge Sort]] |
| One side ≈ all | $n$ × $\Theta(n)$ | $\Theta(n^2)$ | [[Quick Sort]] worst |
| Single half, $\Theta(1)$ work | $\log_2 n$ × $\Theta(1)$ | $\Theta(\log n)$ | [[Binary Search]] |
| Overlapping subproblems | recompute | exponential → DP | naive [[Recursion\|Fibonacci]] |

> [!NOTE] **When It Flips:** balanced splits give depth $\log_b n$; lopsided ones push depth toward $n$, collapsing $\Theta(n\log n)$ to $\Theta(n^2)$. Space: recursion stack $\Theta(\text{depth})$; merge-style combine adds $\Theta(n)$ scratch, partition-style is in-place.

## 📊 Exam Execution Trace

### Manual Execution Trace
Recursion tree of a balanced D&C sort on $n=8$:

| Step / State | Level | # subproblems | Size each | Work this level |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | 0 | 1 | 8 | $\Theta(8)$ |
| 1 | 1 | 2 | 4 | $\Theta(8)$ |
| 2 | 2 | 4 | 2 | $\Theta(8)$ |
| 3 | 3 | 8 | 1 | $\Theta(8)$ |

$\log_2 8 + 1 = 4$ levels, each $\Theta(n)$ ⟹ $\Theta(n\log n)$.

### Applied Exercise
**Problem:** Derive the balanced vs lopsided D&C recurrences.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{balanced: } T(n) &= 2T(n/2) + \Theta(n) = \Theta(n\log n) \\
\text{lopsided: } T(n) &= T(n-1) + \Theta(n) = \Theta(n^2)
\end{aligned}
$$
**Final Extracted Output:** split balance alone decides $\Theta(n\log n)$ vs $\Theta(n^2)$ — the depth term dominates.

## 🧠 Active Recall
> [!FAQ]- Why is merge sort $\Theta(n\log n)$ but a naïve "process one element then recurse on the rest" is $\Theta(n^2)$?
> - **Hint:** Factor-shrink vs one-element-shrink.
> > [!SUCCESS]- Answer
> > - **Short answer:** Halving ⟹ $\log_2 n$ levels × $\Theta(n)$ = $\Theta(n\log n)$; peeling one ⟹ $n$ levels × $\Theta(n)$ = $\Theta(n^2)$.
> > - **Why:** **Depth** ➔ shrinking by a constant *factor* vs by *one element* is the whole difference ($\sum_k k = \Theta(n^2)$).

> [!FAQ]- Divide and conquer assumes independent subproblems — what breaks when they overlap, and what replaces it?
> - **Hint:** Redundant recomputation.
> > [!SUCCESS]- Answer
> > - **Short answer:** Overlapping subproblems ⟹ redundant work ⟹ exponential ($O(2^n)$).
> > - **Why:** **Caching** ➔ memoisation / dynamic programming stores each subresult once, restoring polynomial time.

> [!FAQ]- Why does the *balance* of the split determine whether a D&C sort is $\Theta(n\log n)$ or $\Theta(n^2)$?
> - **Hint:** Balance sets recursion depth.
> > [!SUCCESS]- Answer
> > - **Short answer:** Even halving ⟹ depth $\log_2 n$; maximally lopsided ⟹ depth $n$.
> > - **Why:** **Per-level $\Theta(n)$** ➔ $\log_2 n$ × $\Theta(n) = \Theta(n\log n)$ vs $n$ × $\Theta(n) = \Theta(n^2)$ — quicksort's bad pivot realises the latter.
