---
unit: FIT2004
domain: A
week: 4
source: [lecture]
parent: "[[Quickselect]]"
tags: [CS/Algorithms, CS/Complexity]
aliases: [MoM, Median of Medians Pivot, BFPRT]
---
# [[Median of Medians]]

**Context:** [[FIT2004_MOC]] · the **deterministic** pivot rule that converts [[Quickselect]]'s $\Theta(N)$ *expected* into $\Theta(N)$ *worst case* — and [[Quick Sort]]'s $\Theta(N^{2})$ worst case into $\Theta(N\log N)$
**Scope:** the deck's old "not examinable" line is **struck through and replaced with *examinable from 2023 onwards*** — the lecturer points at his hand-execution video and the Sanity Check. Treat it as a **hand skill**: be able to run it on paper and state the recurrence.

> [!abstract] Quick Revision
> - **🎯 Objective:** spend $\Theta(N)$ **choosing** a pivot that is provably near the middle ➔ every partition splits at worst $30/70$, so the recursion can never degenerate.
> - **📦 Core Components:** **groups of $5$** ➔ $\lceil N/5\rceil$ medians | **recursive select** ➔ the median of those medians | **partition** ➔ on that pivot.
> - **⚡ Key Constraint:** it is a **guarantee, not a speed-up** — the constant factor is large enough that a random pivot beats it in practice; reach for it only when a worst-case *bound* is the requirement.

## 📝 Core
- **Procedure** ➔ split into $\lceil N/5\rceil$ groups of $5$ ➔ sort each group by [[Sorting Problem|insertion sort]] and take its median ($O(1)$ per group, $5$ items) ➔ **recursively** [[Quickselect]] the median of those $\lceil N/5\rceil$ medians ➔ use it as the partition pivot.
- **Base case** ➔ $N\le5$ ⟹ insertion-sort the whole thing and return its median directly; this is what terminates the mutual recursion.
- **Co-recursion** ➔ `median_of_medians` calls `quickselect`, and `quickselect` calls `median_of_medians` for its pivot — the lecturer's named term. Both shrink their input every round, so the pair terminates at the $N\le5$ base.
- **The split guarantee** ➔ the median-of-medians $M$ exceeds **half the group medians**, and each such group contributes $3$ of its $5$ elements $\le$ its own median ⟹ $\ge\tfrac{3}{10}$ of the input is $\le M$; symmetrically $\ge\tfrac{3}{10}$ is $\ge M$ ⟹ $M$ sits in the **middle $40\%$**, and neither side of the partition exceeds $\tfrac{7N}{10}$.
- **The recurrence and why it closes** ➔ pivot-finding costs $T(N/5)$, the surviving side costs $T(7N/10)$, partitioning plus the group medians cost $\Theta(N)$:
$$
T(N)=T\!\left(\tfrac{N}{5}\right)+T\!\left(\tfrac{7N}{10}\right)+cN,\qquad \tfrac15+\tfrac{7}{10}=\tfrac{9}{10}<1 \;\Longrightarrow\; T(N)=\Theta(N)
$$
- **Sub-unit shrinkage is the whole proof** ➔ the two subproblems consume only $\tfrac{9}{10}$ of the input, so the per-level work forms a decaying [[Geometric Series]] with $r=\tfrac{9}{10}$, summing to $10cN$ — **root-dominated**, hence linear ➔ [[Solving Recurrences (Telescoping)]].
- **Why groups of $5$** ➔ groups of $3$ give $T(N/3)+T(2N/3)+cN$ with $\tfrac13+\tfrac23=1$ ⟹ all levels equal ⟹ $\Theta(N\log N)$; the fractions must sum to **strictly less than $1$**, and $5$ is the smallest odd group size that achieves it.
- **Where it plugs in** ➔ as [[Quickselect]]'s pivot ⟹ $\Theta(N)$ worst-case selection; as [[Quick Sort]]'s pivot ⟹ $\Theta(N\log N)$ worst-case sorting, i.e. the answer to "how do you ensure the worst case **never** occurs?"

## ⚙️ Core Implementation
### 🔹 The co-recursive pair
> [!code]- `median_of_medians` ⇄ `quickselect` *(lecture pseudocode)*
> ```python
> def median_of_medians(array, lo, hi):
>     n = hi - lo + 1
>     if n <= 5:                                  # BASE CASE -- ends the co-recursion
>         insertion_sort(array, lo, hi)
>         return array[lo + (n - 1) // 2]
>     medians = []
>     for g in range(lo, hi + 1, 5):              # groups of five
>         end = min(g + 4, hi)
>         insertion_sort(array, g, end)           # O(1): at most 5 items
>         medians.append(array[g + (end - g) // 2])
>     # the median of the medians is itself a SELECTION problem
>     return quickselect(medians, 0, len(medians) - 1, (len(medians) + 1) // 2)
>
> def quickselect(array, lo, hi, k):
>     if lo >= hi:
>         return array[k]
>     pivot = median_of_medians(array, lo, hi)    # <- the weaker, guaranteed pivot
>     mid = partition(array, lo, hi, pivot)       # 70:30 in the worst case
>     if mid > k:
>         return quickselect(array, lo, mid - 1, k)   # <= 7n/10 in the worst case
>     elif k > mid:
>         return quickselect(array, mid + 1, hi, k)   # <= 7n/10 in the worst case
>     else:
>         return array[k]
> ```
> 💡 **Common Mistake:** **Omitting the $N\le5$ base case** ➔ without it `median_of_medians` and `quickselect` call each other forever on tiny ranges; the mutual recursion has no other exit.

## 📊 Exam Execution Trace

### Manual Execution Trace
Find the MoM pivot of `12, 3, 45, 7, 19, 22, 8, 31, 1, 27, 14, 40, 5, 25, 33` ($N=15$ ⟹ $3$ groups).

| Group | Items | Sorted (insertion, $\le5$ items) | Median |
| :--- | :--- | :--- | :--- |
| $1$ | `12, 3, 45, 7, 19` | `3, 7, 12, 19, 45` | $12$ |
| $2$ | `22, 8, 31, 1, 27` | `1, 8, 22, 27, 31` | $22$ |
| $3$ | `14, 40, 5, 25, 33` | `5, 14, 25, 33, 40` | $25$ |
| **select** | medians `12, 22, 25` | `12, 22, 25` | **$M=22$** |

**Check the guarantee:** partitioning on $M=22$ gives $8$ elements below and $6$ above — a $53\%\,{:}\,40\%$ split, comfortably inside the promised $30{:}70$ band, and both sides clear the $\tfrac{3N}{10}=4.5$ floor. Note the groups are **not** left sorted in the array; they are sorted only long enough to read a median.

## ⚠️ Common Mistakes
- 💡 **Forgetting the recursive call** ➔ finding the median of the $\lceil N/5\rceil$ medians is itself a selection problem; scanning or sorting them instead costs $\Theta(N\log N)$ and destroys the linear bound.
- 💡 **Selling it as "faster quickselect"** ➔ it is strictly **slower** on typical input; the deliverable is converting an **expected** bound into a **worst-case** one ([[Algorithmic Complexity]]) by removing the $\Theta(N^{2})$ tail, nothing else.
- 💡 **Claiming the pivot is the true median** ➔ it is only guaranteed to lie in the middle $40\%$ — a **constant-fraction** split, which is all the recurrence needs.

## 🧠 Active Recall
> [!FAQ]- Why must the two recursive fractions sum to strictly less than $1$, and what breaks at exactly $1$?
> - **Hint:** Write the per-level work as a series and read the ratio.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\tfrac15+\tfrac{7}{10}=\tfrac{9}{10}<1$ makes the level work **decay** ⟹ root-dominated $\Theta(N)$; at exactly $1$ every level costs $cN$ ⟹ $\Theta(N\log N)$.
> > - **Why:** **The ratio is the regime** ➔ total work is $cN\sum_i r^{i}$ with $r$ the surviving fraction; $r<1$ sums to the constant $\tfrac{1}{1-r}=10$, $r=1$ sums to the number of levels ➔ [[Solving Recurrences (Telescoping)]]. Groups of $3$ land exactly on $r=1$, which is why $5$ is the textbook choice.

> [!FAQ]- Derive the $30\%$ figure that gives the $70{:}30$ worst split.
> - **Hint:** Count medians first, then count within each group.
> > [!SUCCESS]- Answer
> > - **Short answer:** Half the $\lceil N/5\rceil$ group medians are $\le M$, and each of those groups holds $3$ elements $\le$ its own median ⟹ $\tfrac12\cdot\tfrac{N}{5}\cdot3=\tfrac{3N}{10}$ elements are $\le M$; symmetrically $\tfrac{3N}{10}$ are $\ge M$.
> > - **Why:** **$M$ sits in the middle $40\%$** ➔ neither partition side can exceed $N-\tfrac{3N}{10}=\tfrac{7N}{10}$, which is exactly the $T(7N/10)$ term in the recurrence.

> [!FAQ]- `median_of_medians` calls `quickselect` and `quickselect` calls `median_of_medians`. Why does this terminate?
> - **Hint:** Name the base case and what shrinks.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Co-recursion** with a shared base case: at $N\le5$ the median is read off an insertion sort with no further calls.
> > - **Why:** **Both arguments strictly shrink** ➔ `median_of_medians` hands `quickselect` a list of $\lceil N/5\rceil$ medians, and `quickselect` hands back a range of at most $\tfrac{7N}{10}$; every round is smaller, so the $N\le5$ guard is reached ➔ [[Invariant]] (termination is the co-equal obligation).
