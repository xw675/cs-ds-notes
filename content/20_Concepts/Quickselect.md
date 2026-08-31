---
unit: FIT2004
domain: A
week: 4
source: [lecture, applied]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Complexity]
aliases: [Quick Select, Selection Problem, k-th Smallest, Order Statistic, K-th Order Statistics]
---
# [[Quickselect]]

**Context:** [[FIT2004_MOC]] · [[Partitioning (Quicksort)]] reused for a **different problem** — find the $k$-th smallest without sorting · the canonical **decrease-and-conquer** win: recurse into **one** side, not both · worst case eliminated by [[Median of Medians]]

> [!abstract] Quick Revision
> - **🎯 Objective:** partition once, then **discard the side that cannot contain rank $k$** ➔ $T(N)=T(N/2)+\Theta(N)=\Theta(N)$ expected, beating sort-then-index's $\Theta(N\log N)$.
> - **📦 Core Components:** **partition** (shared with [[Quick Sort]]) ➔ pivot lands final at index $j$ | **compare $k$ to $j$** ➔ $O(1)$ decision | **one-sided recursion** ➔ the entire difference from quicksort.
> - **⚡ Key Constraint:** $\Theta(N)$ is **expected**, not guaranteed — bad pivots give $T(N)=T(N-1)+\Theta(N)=\Theta(N^{2})$; only a [[Median of Medians]] pivot makes $\Theta(N)$ a worst-case bound.

## 📝 How It Works
### 1. $k$-th Order Statistics — the Problem
- **Specification** ➔ given $N$ unsorted orderable items and a rank $k$, return the element that **would** sit at index $k$ if the list were sorted — without producing the sorted list. Equivalently: return the $k$ **smallest** items, internal order irrelevant.
- **Worked reading** ➔ on `21, 84, 16, 14, 79, 51, 66, 21, 54, 32`: $k=1$ ➔ `14` · $k=2$ ➔ `{14, 16}` · $k=5$ ➔ `{14, 16, 21, 21, 32}`.
- **The whole quartile family is one call** ➔ $Q_1$ at $k=N/4$ · **median** at $k=N/2$ · $Q_3$ at $k=3N/4$ ➔ [[Measures of Spread and Boxplots]]. The median is why it matters — it is the pivot [[Quick Sort]] wants.
- **"Isn't this just partition?"** ➔ yes — a partition already separates *smaller* from *larger* around one element; selection is the question of **driving that partition to the rank you want** ➔ [[Partitioning (Quicksort)]].

### 2. The Baseline — Sort and Slice
- **The obvious algorithm** ➔ sort, then slice the first $k$ ⟹ $O(NM\log N) + O(k)$, $M$ the **cost of one comparison** ➔ [[Sorting Problem]].
- **The linear sorts do not rescue it** ➔ [[Counting Sort]] needs the key range capped; [[Radix Sort]] needs bounded key width — neither can be **assumed** for arbitrary input, so the $\log N$ stands.
- **Sorting is over-solving** ➔ it answers **every** rank at once for $\Theta(N\log N)$; selection answers **one** rank for $\Theta(N)$. Choosing sorting when a single rank is asked is the LO3 error.

### 3. One-Sided Recursion — The Whole Idea
- **Partition tells you the pivot's TRUE rank** ➔ after `partition(lo, hi)` returns boundary $j$, the pivot is at its final sorted index, with **zero** further work.
- **Three-way decision** ➔ $j=k$ ⟹ **done** · $k<j$ ⟹ the answer is in `[lo, j-1]`, throw the right side away · $k>j$ ⟹ recurse on `[j+1, hi]` with $k$ **unchanged** (absolute indices).
- **Why the cost collapses** ➔ [[Quick Sort]] recurses on **both** halves so every level still costs $\Theta(N)$ across $\log N$ levels; quickselect recurses on **one**, so the level costs **halve** — a [[Geometric Series]] with $r=\tfrac12$ summing to $<2N$.

### 4. Cost Profile
- **Best case is $\Theta(N)$, not $\Theta(1)$** ➔ even a first-try hit has already paid for **one full partition** ⟹ the whole input is read no matter what.
- **Expected $\Theta(N)$** ➔ $T(N)=T(N/2)+\Theta(N)$ under balanced pivots ⟹ root-dominated ($r=\tfrac12<1$) ➔ [[Solving Recurrences (Telescoping)]]. *(The lecturer's formal average-case derivation — multiply by $N$, subtract the $(N{-}1)$ instance so the summations cancel — is flagged **NOT EXAMINABLE**.)*
- **Worst $\Theta(N^{2})$** ➔ an extreme pivot every level peels one element ⟹ $T(N)=T(N-1)+cN=\Theta(N^{2})$ by the [[Arithmetic Series]] — same failure mode and same inputs as [[Quick Sort]].
- **Auxiliary space is $O(1)$ when written iteratively** ➔ the recursion is **tail** recursion, so it rewrites as a `while` loop over `lo`/`hi` ⟹ genuinely **in-place**, unlike [[Quick Sort]], whose first call cannot be eliminated.
- **Destructive** ➔ partitioning **permutes the caller's array**; if the original order matters, copy first and pay $\Theta(N)$ space.

### 5. Feeding [[Quick Sort]] a Pivot — the Exact Median Fails
- **The tempting plan** ➔ call quickselect for the exact median, use it as the pivot, and skip quicksort's own partition — quickselect **already partitioned** the range.
- **It does not work** ➔ quickselect's own worst case is $\Theta(N^{2})$, so the pivot-finding call at the root costs $N^{2}$ and the level sum is $N^{2}+\tfrac{N^{2}}{2}+\dots = 2N^{2}$ ⟹ the sort stays $\Theta(N^{2})$. *Derivation in Applied Exercise 2.*
- **The fix is to stop demanding the exact median** ➔ any pivot inside the middle band suffices, because a **constant-fraction** split already gives logarithmic depth ➔ [[Quick Sort]] §3.
- **[[Median of Medians]] delivers exactly that band** ➔ a pivot provably between the $30$th and $70$th percentile, found in $\Theta(N)$ **worst case** ⟹ height $O(\log N)$, partition already done ⟹ $\Theta(N\log N)$ worst-case quicksort. *Lecturer's coda: "in reality, random pivot works well due to probability" — the guarantee is bought with a constant factor nobody pays voluntarily.*

### 6. Adapting Quickselect to a New Problem *(applied W4 — LO1)*
- **The reusable skeleton** ➔ *partition once ➔ read something off the pivot's position ➔ recurse into the single side that can still contain the answer.* Every variant changes only **what is read off** and **which side survives**.
- **Weighted median** ➔ each $a_{i}$ carries weight $w_{i}$ with $\sum w_{i}=1$; the answer is the $a_{k}$ whose left and right weight sums are each $\le\tfrac12$. Swap "compare rank $j$ to $k$" for "compare **weight sums** to $w$": if neither side exceeds $w$ the pivot **is** the answer, otherwise recurse into the heavier side with $w$ reduced by the weight skipped. Same $\Theta(n)$ expected.
- **The $k$ closest to the median** ➔ run quickselect once for the median $m$, then again for the $k$-th smallest $\lvert a_{i}-m\rvert$; take everything strictly below that value and **top up** to $k$ from the ties. Two linear calls ⟹ $\Theta(n)$.
- **Why the top-up is mandatory** ➔ the elements are unique but their **distances** are not ($m+d$ and $m-d$ tie), so "strictly closer than the $k$-th" can yield fewer than $k$; any tied element will do, being equally close.
- **Killing the $\Theta(n)$ space** ➔ do **not** materialise the absolute-difference copy; run a modified quickselect that *interprets* `array[i]` as $\lvert \text{array}[i]-m\rvert$ on the fly ⟹ $O(1)$ extra space beyond the output.
- **Order statistic across two sorted arrays** `[D]` ➔ $\text{order}(a[i])=i+\lvert\{j:b[j]<a[i]\}\rvert$ is **monotone in $i$**, hence binary-searchable: an inner [[Binary Search]] on $b$ inside an outer one on $a$ gives $\Theta(\log n\log m)$; running the **two searches simultaneously** removes the nesting for $\Theta(\log n+\log m)$.

## ⚙️ Core Implementation
### 🔹 Iterative quickselect — $O(1)$ auxiliary
> [!code]- `quickselect` — reuses `partition` from [[Partitioning (Quicksort)]], loops instead of recursing
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
> 💡 **Common Mistake:** **Recursing on both sides "to be safe"** ➔ that is [[Quick Sort]]; it restores the $\Theta(N\log N)$ level sum and throws away the entire point.

### 🔹 Weighted quickselect — the same skeleton, a different read-off
> [!code]- `weighted_quickselect` *(call with $w=\tfrac12$ for the weighted median)*
> ```python
> def weighted_quickselect(array, weight, lo, hi, w):
>     if hi <= lo:
>         return array[lo]
>     pivot = array[lo]
>     j = partition(array, weight, lo, hi, pivot)   # permute weights IN UNISON
>     left = sum_range(weight, lo, j - 1)
>     if left > w:
>         return weighted_quickselect(array, weight, lo, j - 1, w)
>     elif left + weight[j] >= w:
>         return array[j]                            # pivot IS the weighted median
>     else:
>         return weighted_quickselect(array, weight, j + 1, hi,
>                                     w - (left + weight[j]))
> ```
> 💡 **Common Mistake:** **Partitioning the values without the weights** ➔ the weight array must be permuted by the *same* swaps, or every weight attaches to the wrong element after the first call.
> 💡 **Common Mistake:** **Recursing right with the original $w$** ➔ the weight discarded on the left must be **subtracted**, exactly as $k$ would be re-indexed in a relative-index quickselect.

## ⚖️ Core Decision Matrix
| Approach | Time | Auxiliary space | Needs all $N$ upfront? | Selection rule |
| :--- | :--- | :--- | :--- | :--- |
| Sort, then slice | $O(NM\log N)+O(k)$ | $\Theta(N)$ merge · $O(\log N)$ quick | Yes | **many** ranks queried, or the sorted list is wanted anyway |
| **Quickselect** (random pivot) | $\Theta(N)$ best/expected, $\Theta(N^{2})$ worst | $O(1)$ iterative | Yes | **one** rank, array in memory, mutation acceptable |
| Quickselect $+$ [[Median of Medians]] | $\Theta(N)$ **worst** | $O(\log N)$ | Yes | a **guarantee** is required (real-time, adversarial input) |
| Size-$k$ heap ➔ [[Online Algorithm]] | $\Theta(N\log k)$ | $\Theta(k)$ | **No** — streams | $N$ unknown or unbounded, or all $k$ smallest wanted as they arrive |

> [!NOTE] **When It Flips:** quickselect wins while exactly one rank is needed from a resident array. Ask for $\ge\log N$ different ranks and sorting once amortises better; drop the "resident array" assumption and quickselect is unusable at any cost, because it must partition the whole input — that regime belongs to the size-$k$ heap in [[Online Algorithm]].

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
`quickselect([7, 2, 9, 1, 5, 8, 3], k=2)` — the $3$rd smallest. Pivot $=$ middle element of the live window (Lomuto):

| Step | Window `[lo, hi]` | Pivot | Array after partition | Boundary $j$ | Decision |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `[0, 6]` | — | `[7, 2, 9, 1, 5, 8, 3]` | — | — |
| 1 | `[0, 6]` | $1$ | `[1, 2, 9, 7, 5, 8, 3]` | $0$ | $j<k$ ⟹ `lo = 1` |
| 2 | `[1, 6]` | $7$ | `[1, 3, 2, 5, 7, 8, 9]` | $4$ | $k<j$ ⟹ `hi = 3` |
| 3 | `[1, 3]` | $2$ | `[1, 2, 3, 5, 7, 8, 9]` | $1$ | $j<k$ ⟹ `lo = 2` |
| 4 | `[2, 3]` | $3$ | `[1, 2, 3, 5, 7, 8, 9]` | $2$ | $j=k$ ⟹ **return $3$** |

**Window sizes $7\to6\to3\to2$** — discarded halves are never revisited, and the array is left **partially** sorted only: rank $2$ is correct and nothing else is guaranteed.

### Applied Exercise 1 — where quicksort's $\log N$ went
**Problem:** derive quickselect's expected time from its recurrence and contrast the level sum with [[Quick Sort]]'s.
$$
\begin{aligned}
T(N) &= T(N/2) + cN = T(N/2^{k}) + cN\sum_{i=0}^{k-1}2^{-i},\qquad k=\log_2 N \\
&= b + cN\bigl(2-2^{-(k-1)}\bigr) \;<\; b+2cN \;=\; \Theta(N) \\
\text{versus } T_{\text{quicksort}}(N) &= 2T(N/2)+cN \Rightarrow \text{every level costs } cN \Rightarrow \Theta(N\log N)
\end{aligned}
$$
**Final Extracted Output:** $\Theta(N)$ expected — the $\log N$ factor is bought by the **second** recursive call, so deleting it deletes the factor. Same depth, different total. Worst case is still $\Theta(N^{2})$ via $T(N)=T(N-1)+cN$.

### Applied Exercise 2 — why an exact-median pivot does not fix quicksort
**Problem:** quicksort picks its pivot by calling quickselect for the exact median. Bound the result in the worst case.
$$
\text{level } i = \frac{N^{2}}{2^{i}} \;\Longrightarrow\; T(N) = \sum_{i\ge0}\frac{N^{2}}{2^{i}} = 2N^{2} = \Theta(N^{2})
$$
**Final Extracted Output:** the split is now **perfect** at every level and the sort is *still* quadratic — the cost moved from the recursion shape into the **pivot-finding step**. Only a pivot rule linear in the **worst** case ([[Median of Medians]]) closes it, and a merely $30/70$ pivot suffices because constant-fraction splits already give $O(\log N)$ depth.

### Applied Exercise 3 — the probability argument for expected $\Theta(n)$
**Problem:** call a pivot **good** if it falls in the middle $50\%$. Bound quickselect's expected work.
$$
\begin{aligned}
\text{worst good pivot} &: \text{the 25th/75th percentile} \Rightarrow \text{recurse on } 0.75n \\
T(n) &= cn\sum_{i\ge0}0.75^{i} \;\le\; \frac{cn}{1-0.75} = 4cn \\
\Pr[\text{good}] = \tfrac12 &\Rightarrow \mathbb{E}[\text{attempts}] = 2 \Rightarrow \mathbb{E}[T(n)] \le 8cn = O(n)
\end{aligned}
$$
**Final Extracted Output:** $O(n)$ expected. Two reproducible moves: (i) a **constant-fraction** shrink turns level costs into a [[Geometric Series]] summing to a constant multiple of $n$; (ii) a pivot good with probability $p$ costs $1/p$ attempts in expectation, multiplying the bound by a **constant**. The identical argument with both halves kept gives [[Quick Sort]]'s $O(n\log n)$.

## ⚠️ Common Mistakes
- 💡 **Quoting $\Theta(N)$ with no case** ➔ $\Theta(N)$ is the **best/expected** bound; the worst case is $\Theta(N^{2})$ unless you name the pivot policy. "Quickselect is linear" is only true of the [[Median of Medians]] variant ➔ [[Big-O Notation]].
- 💡 **Claiming a best case better than $\Theta(N)$** ➔ hitting $j=k$ on the first try still costs one full partition.
- 💡 **Translating $k$ when recursing right** ➔ with **absolute** indices $k$ never changes; subtracting $j+1$ is only correct if the recursive call re-indexes from $0$. Pick one convention and state it.
- 💡 **Assuming the array is sorted afterwards** ➔ only rank $k$ is final; the two sides are partitioned, not ordered.

## 🧠 Active Recall
> [!FAQ]- Quicksort and quickselect run the identical partition, yet one is $\Theta(N\log N)$ and the other $\Theta(N)$. Where exactly does the $\log N$ go?
> - **Hint:** Count the work per level, not the depth.
> > [!SUCCESS]- Answer
> > - **Short answer:** the $\log N$ is bought by the **second** recursive call, and quickselect does not make it.
> > - **Why:** **Level sums differ** ➔ quicksort keeps both halves so every one of the $\log N$ levels totals $\Theta(N)$; quickselect keeps one, so the levels are $N,\tfrac N2,\tfrac N4,\dots$ — a [[Geometric Series]] with $r=\tfrac12$ summing to $<2N$.

> [!FAQ]- You must return the median of $10^{8}$ sensor readings within a hard time budget. Argue for a pivot policy.
> - **Hint:** Distinguish "improbable" from "impossible".
> > [!SUCCESS]- Answer
> > - **Short answer:** a **random** pivot gives $\Theta(N)$ expected but no bound; a hard budget demands [[Median of Medians]], which makes $\Theta(N)$ the **worst-case** bound.
> > - **Why:** **Randomisation is a probability claim** ➔ it removes the *adversary's* ability to choose a bad input, not the possibility of a bad run. A deterministic constant-fraction split is the only thing converting the expectation into a guarantee — at a large constant factor.

> [!FAQ]- Quickselect is described as in-place while [[Quick Sort]] is not, though both only permute the array. Justify the difference.
> - **Hint:** Ask which recursive call has work waiting after it returns.
> > [!SUCCESS]- Answer
> > - **Short answer:** quickselect's single recursive call is a **tail** call ⟹ rewritable as a loop ⟹ $O(1)$ auxiliary; quicksort's first call is not.
> > - **Why:** **The stack is auxiliary space** ➔ quicksort must return from the left call to make the right one, so $\Theta(\log N)$ frames stay live; quickselect has nothing pending, so `lo`/`hi` reassignment replaces the frame ➔ [[Analysing Recursive Algorithms (Time and Auxiliary Space)]].

> [!FAQ]- Find the $k$ elements closest to the median of $n$ unique integers in $\Theta(n)$, and justify each step.
> - **Hint:** Two selections, then a tie-break you must not skip.
> > [!SUCCESS]- Answer
> > - **Short answer:** quickselect for the median $m$; quickselect again on $\lvert a_{i}-m\rvert$ for the $k$-th smallest distance; take everything strictly smaller and top up from the ties.
> > - **Why:** **Distances need not be unique even when the values are** ➔ $m+d$ and $m-d$ both sit at distance $d$, so the strict set can fall short of $k$; any tied element is equally close. Two $\Theta(n)$ calls are still $\Theta(n)$, and interpreting `array[i]` as its absolute difference from $m$ inside the partition removes the $\Theta(n)$ auxiliary space.
