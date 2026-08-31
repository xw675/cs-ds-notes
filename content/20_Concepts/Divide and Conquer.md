---
unit: [FIT1008, FIT2004]
domain: A
week: [1, 2, 7]
parent: "[[Recursion]]"
tags: [CS/Algorithms, CS/Complexity]
---
# [[Divide and Conquer]]

**Context:** [[FIT1008_MOC]], [[FIT2004_MOC]] · a [[Recursion|recursive]] strategy · powers [[Binary Search]], [[Merge Sort]], [[Quick Sort]] · solves the [[Sorting Problem]]
**FIT2004 use:** the examinable examples are [[Merge Sort]] and [[Quick Sort]]; every D&C running time is found by [[Solving Recurrences (Telescoping)|solving the cost recurrence]] $T(n)=a\,T(n/b)+f(n)$, where $a$ counts **recursive calls** and $f(n)$ the combine.

> [!abstract] Quick Revision
> - **🎯 Objective:** divide into subproblems, conquer recursively, combine ➔ most efficient when splits are roughly equal.
> - **📦 Core Components:** **split** ➔ recurse on parts ➔ **combine** | split **balance** sets the depth.
> - **⚡ Key Constraint:** balanced halves → $\Theta(n\log n)$; lopsided → $\Theta(n^2)$; single-half search → $\Theta(\log n)$.

## 📝 Core
### 1. The Strategy (Divide / Conquer / Combine)
- **Divide** ➔ split into subproblems; **conquer** ➔ solve each recursively + *independently*; **combine** ➔ merge solutions. Base case = size $\le1$.
- **Efficiency condition** ➔ best when subproblems are **roughly equal in size** ➔ depth $\Theta(\log n)$.
- **Cost by levels** ➔ total = (levels) × (work per level): balanced $\log_2 n\times\Theta(n)=\Theta(n\log n)$ · lopsided $n\times\Theta(n)=\Theta(n^2)$ · single-half with $\Theta(1)$ work $=\Theta(\log n)$.

### 2. Independence Assumption (vs DP)
- **Assumption** ➔ subproblems are **independent** (non-overlapping), solved once.
- **Overlap break** ➔ $\text{fib}(n)$ recomputing $\text{fib}(n-2)$ ⟹ exponential ➔ use **memoisation / dynamic programming**.

### 3. Adapting D&C to a NEW problem *(the LO1 drill — Applied 2)*
- **Three questions, in order** ➔ (1) does the answer **decompose additively** across the split — within-left $+$ within-right $+$ **cross**? (2) can the cross term be computed in $\Theta(n)$? (3) does the **per-call work shrink** with the subproblem, or does the level sum refuse to decay?
- **Strengthen the recursive contract** ➔ ask the recursion to return *more* than the answer. [[Counting Inversions]] is only $\Theta(n\log n)$ because each call returns a **sorted** subarray as well as a count; that extra guarantee makes the cross term linear.
- **Question (3) is the one that gets skipped** ➔ [[2D Local Maximum (Peak Finding)]] halving on the middle column still costs $\Theta(n\log n)$ because the deciding scan stays full-length. Cutting **both** axes makes level $i$ cost $cn/2^{i}$ ⟹ $\Theta(n)$.
- **On a new problem, the correctness argument is the deliverable** ➔ "why is it safe to discard the other subproblems?" carries more marks than the pseudocode; state it as an explicit claim about what the kept subproblem is guaranteed to contain.

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
| Single half, **shrinking** $\Theta(n)$ work | $cn+\tfrac{cn}2+\tfrac{cn}4+\dots<2cn$ | $\Theta(n)$ — root-dominated | [[2D Local Maximum (Peak Finding)]] |
| Both halves, $\Theta(n)$ combine | $\log_2 n$ × $\Theta(n)$ | $\Theta(n\log n)$ | [[Counting Inversions]] |
| Overlapping subproblems | recompute | exponential → DP | naive [[Recursion\|Fibonacci]] |

> [!NOTE] **When It Flips:** balanced splits give depth $\log_b n$; lopsided ones push depth toward $n$, collapsing $\Theta(n\log n)$ to $\Theta(n^2)$. Space: recursion stack $\Theta(\text{depth})$; merge-style combine adds $\Theta(n)$ scratch, partition-style is in-place.

## 📊 Exam Execution Trace
### Applied Exercise
**Problem:** Derive the balanced vs lopsided D&C recurrences.
$$
\text{balanced: } T(n) = 2T(n/2) + \Theta(n) = \Theta(n\log n) \qquad
\text{lopsided: } T(n) = T(n-1) + \Theta(n) = \Theta(n^2)
$$
**Final Extracted Output:** split balance alone decides $\Theta(n\log n)$ vs $\Theta(n^2)$ — the depth term dominates. (Balanced tree on $n=8$: $\log_2 8+1=4$ levels, each $\Theta(8)$.)

## 🧠 Active Recall
> [!FAQ]- Why is merge sort $\Theta(n\log n)$ but a naïve "process one element then recurse on the rest" is $\Theta(n^2)$?
> - **Hint:** Factor-shrink vs one-element-shrink.
> > [!SUCCESS]- Answer
> > - **Short answer:** halving ⟹ $\log_2 n$ levels × $\Theta(n)$ = $\Theta(n\log n)$; peeling one ⟹ $n$ levels × $\Theta(n)$ = $\Theta(n^2)$.
> > - **Why:** **Balance sets the depth** ➔ shrinking by a constant *factor* vs by *one element* is the whole difference ($\sum_k k = \Theta(n^2)$) — and quicksort's bad pivot realises the lopsided case on an otherwise balanced algorithm.

> [!FAQ]- Divide and conquer assumes independent subproblems — what breaks when they overlap, and what replaces it?
> - **Hint:** Redundant recomputation.
> > [!SUCCESS]- Answer
> > - **Short answer:** overlapping subproblems ⟹ redundant work ⟹ exponential ($O(2^n)$).
> > - **Why:** **Caching** ➔ memoisation / dynamic programming stores each subresult once, restoring polynomial time.
