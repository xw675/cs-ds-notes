---
unit: FIT2004
domain: A
week: 3
source: [lecture, applied]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Complexity]
aliases: [Quick Select, Selection Problem, k-th Smallest, Order Statistic]
---
# [[Quickselect]]

**Context:** [[FIT2004_MOC]] · [[Quick Sort]]'s partition reused for a **different problem** — find the $k$-th smallest without sorting · the canonical **decrease-and-conquer** win: recurse into **one** side, not both · worst case eliminated by [[Median of Medians]]

> [!abstract] Quick Revision
> - **🎯 Objective:** partition once, then **discard the side that cannot contain rank $k$** ➔ $T(N)=T(N/2)+\Theta(N)=\Theta(N)$ expected, beating sort-then-index's $\Theta(N\log N)$.
> - **📦 Core Components:** **partition** (shared with [[Quick Sort]]) ➔ pivot lands final at index $j$ | **compare $k$ to $j$** ➔ $O(1)$ decision | **one-sided recursion** ➔ the entire difference from quicksort.
> - **⚡ Key Constraint:** $\Theta(N)$ is **expected**, not guaranteed — bad pivots give $T(N)=T(N-1)+\Theta(N)=\Theta(N^{2})$; only a [[Median of Medians]] pivot makes $\Theta(N)$ a worst-case bound.

## 📝 How It Works
### 1. The Selection Problem
- **Specification** ➔ given $N$ unsorted orderable items and a rank $k$, return the element that **would** sit at index $k$ if the list were sorted — without producing the sorted list.
- **Median is the special case** ➔ $k=\lfloor N/2\rfloor$; the median is what makes selection worth a dedicated algorithm, because it is the pivot [[Quick Sort]] wants.
- **Sorting is over-solving** ➔ sort-then-index answers **every** rank at once for $\Theta(N\log N)$; selection answers **one** rank for $\Theta(N)$. Choosing sorting when one rank is asked is the LO3 error.

### 2. One-Sided Recursion — The Whole Idea
- **Partition tells you the pivot's TRUE rank** ➔ after `partition(lo, hi)` returns boundary $j$, the pivot is at its final sorted index; everything left of $j$ is smaller, everything right is larger — with **zero** further work.
- **Three-way decision** ➔ $j=k$ ⟹ **done, return it** · $k<j$ ⟹ the answer is in `[lo, j-1]`, **throw the right side away** · $k>j$ ⟹ recurse on `[j+1, hi]` with $k$ **unchanged** (absolute indices).
- **Why the cost collapses** ➔ [[Quick Sort]] recurses on **both** halves so every level still costs $\Theta(N)$ across $\log N$ levels; quickselect recurses on **one**, so the level costs **halve** — a geometric series with $r=\tfrac12$ that sums to $<2N$ ➔ [[Geometric Series]].

### 3. Cost Profile
- **Expected $\Theta(N)$** ➔ $T(N)=T(N/2)+\Theta(N)$ under balanced pivots ⟹ root-dominated regime ($r=a/b=\tfrac12<1$) ⟹ $\Theta(N)$ ➔ [[Solving Recurrences (Telescoping)]].
- **Worst $\Theta(N^{2})$** ➔ an extreme pivot every level peels one element ⟹ $T(N)=T(N-1)+cN=\Theta(N^{2})$ by the [[Arithmetic Series]] — the same failure mode as [[Quick Sort]], reached by the same inputs.
- **Auxiliary space is $O(1)$ when written iteratively** ➔ the recursion is **tail** recursion (nothing happens after the recursive call), so it rewrites as a `while` loop over `lo`/`hi` ⟹ genuinely **in-place**, unlike [[Quick Sort]], whose second call cannot be eliminated.
- **Destructive** ➔ partitioning **permutes the caller's array**; if the original order matters, copy first and pay $\Theta(N)$ space.

## ⚙️ Core Implementation
### 🔹 Iterative quickselect — $O(1)$ auxiliary
> [!code]- `quickselect` — reuses `partition` from [[Quick Sort]], loops instead of recursing
> ```python
> def quickselect(my_list, k):
>     # returns the k-th smallest, k zero-indexed: k=0 is the minimum
>     lo = 0
>     hi = len(my_list) - 1
>     while lo < hi:
>         j = partition(my_list, lo, hi)   # pivot lands FINAL at index j
>         if j == k:
>             return my_list[j]            # exact rank hit -- stop immediately
>         elif k < j:
>             hi = j - 1                   # answer is left; discard [j..hi]
>         else:
>             lo = j + 1                   # answer is right; discard [lo..j]
>     return my_list[lo]                   # window collapsed to one element
> ```
> 💡 **Common Mistake:** **Recursing on both sides "to be safe"** ➔ that is [[Quick Sort]]; it restores the $\Theta(N\log N)$ level sum and throws away the entire point. Only ONE of the two branches may survive the `if`.

## ⚖️ Core Decision Matrix
| Approach | Time | Auxiliary space | Needs all $N$ upfront? | Selection rule |
| :--- | :--- | :--- | :--- | :--- |
| Sort, then index | $\Theta(N\log N)$ | $\Theta(N)$ merge · $O(\log N)$ quick | Yes | **many** ranks queried, or the sorted list is wanted anyway |
| **Quickselect** (random pivot) | $\Theta(N)$ expected, $\Theta(N^{2})$ worst | $O(1)$ iterative | Yes | **one** rank, array in memory, mutation acceptable |
| Quickselect $+$ [[Median of Medians]] | $\Theta(N)$ **worst** | $O(\log N)$ | Yes | a **guarantee** is required (real-time, adversarial input) |
| Size-$k$ heap ➔ [[Online Algorithm]] | $\Theta(N\log k)$ | $\Theta(k)$ | **No** — streams | $N$ unknown or unbounded, or all $k$ smallest wanted, not just the $k$-th |

> [!NOTE] **When It Flips:** quickselect wins while exactly one rank is needed from a resident array. Ask for $\ge\log N$ different ranks and sorting once amortises better; drop the "resident array" assumption and quickselect is unusable at any cost, because it must partition the whole input — that regime belongs to the size-$k$ heap in [[Online Algorithm]].

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
`quickselect([7, 2, 9, 1, 5, 8, 3], k=2)` — the $3$rd smallest. Pivot $=$ middle element of the live window (Lomuto, as in [[Quick Sort]]).

| Step | Window `[lo, hi]` | Pivot | Array after partition | Boundary $j$ | Decision |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `[0, 6]` | — | `[7, 2, 9, 1, 5, 8, 3]` | — | — |
| 1 | `[0, 6]` | $1$ | `[1, 2, 9, 7, 5, 8, 3]` | $0$ | $j<k$ ⟹ `lo = 1` |
| 2 | `[1, 6]` | $7$ | `[1, 3, 2, 5, 7, 8, 9]` | $4$ | $k<j$ ⟹ `hi = 3` |
| 3 | `[1, 3]` | $2$ | `[1, 2, 3, 5, 7, 8, 9]` | $1$ | $j<k$ ⟹ `lo = 2` |
| 4 | `[2, 3]` | $3$ | `[1, 2, 3, 5, 7, 8, 9]` | $2$ | $j=k$ ⟹ **return $3$** |

**Window sizes $7\to6\to3\to2$** — the discarded halves are never revisited, and the array is left **partially** sorted only: rank $2$ is correct, ranks $5$ and $6$ happen to be settled by luck, and nothing else is guaranteed.

### Applied Exercise
**Problem:** Derive quickselect's expected time from its recurrence, and contrast the level sum with [[Quick Sort]]'s.
$$
\begin{aligned}
T(N) &= T(N/2) + cN \\
&= T(N/4) + c\tfrac{N}{2} + cN \;=\; T(N/2^{k}) + cN\sum_{i=0}^{k-1}2^{-i} \\
\text{base } N/2^{k}=1 &\Rightarrow k=\log_2 N \\
T(N) &= b + cN\bigl(2-2^{-(k-1)}\bigr) \;<\; b+2cN \;=\; \Theta(N) \\
\text{versus } T_{\text{quicksort}}(N) &= 2T(N/2)+cN \Rightarrow \text{every level costs } cN \Rightarrow \Theta(N\log N)
\end{aligned}
$$
**Final Extracted Output:** $\Theta(N)$ expected — the $\log N$ factor is bought by the **second** recursive call, so deleting it deletes the factor. Worst case is still $\Theta(N^{2})$ via $T(N)=T(N-1)+cN$.

## ⚠️ Common Mistakes
- 💡 **Quoting $\Theta(N)$ with no case** ➔ $\Theta(N)$ is the **expected/average** bound; the worst case is $\Theta(N^{2})$ unless you name the pivot policy. "Quickselect is linear" is only true of the [[Median of Medians]] variant ➔ [[Big-O Notation]].
- 💡 **Translating $k$ when recursing right** ➔ with **absolute** indices `lo`/`hi`, $k$ never changes; subtracting $j+1$ is only correct if the recursive call re-indexes the sub-array from $0$. Pick one convention and state it.
- 💡 **Assuming the array is sorted afterwards** ➔ only rank $k$ is final; the two sides are partitioned, not ordered — an exam answer that then indexes rank $k{+}1$ for free is wrong.

## 🧠 Active Recall
> [!FAQ]- Quicksort and quickselect run the identical partition, yet one is $\Theta(N\log N)$ and the other $\Theta(N)$. Where exactly does the $\log N$ go?
> - **Hint:** Count the work per level, not the depth.
> > [!SUCCESS]- Answer
> > - **Short answer:** The $\log N$ is bought by the **second** recursive call, and quickselect does not make it.
> > - **Why:** **Level sums differ** ➔ quicksort keeps both halves, so every one of the $\log N$ levels still totals $\Theta(N)$; quickselect keeps one, so the levels are $N,\tfrac N2,\tfrac N4,\dots$ — a [[Geometric Series]] with $r=\tfrac12$ summing to $<2N$. Same depth, different total.

> [!FAQ]- You must return the median of $10^{8}$ sensor readings within a hard time budget. Argue for a pivot policy.
> - **Hint:** Distinguish "improbable" from "impossible".
> > [!SUCCESS]- Answer
> > - **Short answer:** A **random** pivot gives $\Theta(N)$ expected but no bound; a hard budget demands [[Median of Medians]], which makes $\Theta(N)$ the **worst-case** bound.
> > - **Why:** **Randomisation is a probability claim** ➔ it removes the *adversary's* ability to choose a bad input, not the possibility of a bad run. A deterministic constant-fraction split is the only thing that converts the expectation into a guarantee — at a large constant factor, which is why practice still prefers random pivots.

> [!FAQ]- Quickselect is described as in-place while [[Quick Sort]] is not, though both only permute the array. Justify the difference.
> - **Hint:** Ask which recursive call has work waiting after it returns.
> > [!SUCCESS]- Answer
> > - **Short answer:** Quickselect's single recursive call is a **tail** call ⟹ rewritable as a loop ⟹ $O(1)$ auxiliary; quicksort's first call is not.
> > - **Why:** **The stack is auxiliary space** ➔ quicksort must return from the left call to make the right one, so $\Theta(\log N)$ frames stay live; quickselect has nothing pending after its call, so `lo`/`hi` reassignment replaces the frame entirely ➔ [[Analysing Recursive Algorithms (Time and Auxiliary Space)]].
