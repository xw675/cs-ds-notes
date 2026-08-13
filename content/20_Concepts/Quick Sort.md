---
unit: [FIT1008, FIT2004]
domain: A
week: [7, 3]
source: [lecture, applied]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity, SWE/OOP]
aliases: [Quicksort, Partition, Lomuto Partition, Hoare Partition]
---
# [[Quick Sort]]

**Context:** [[FIT1008_MOC]] · a [[Divide and Conquer]] sort · solves the [[Sorting Problem]] · uses an [[Recursion|Auxiliary Function (Recursion)]] · contrast with [[Merge Sort]]; falls back to [[Sorting Problem|Insertion Sort]] for tiny arrays
**FIT2004 emphasis:** the three W3 design questions — **how to partition efficiently** (Lomuto vs Hoare vs 3-way), **how to choose a good pivot** (fixed → median-of-three → random → [[Median of Medians]]), and **how to ensure the worst case never occurs** · the same partition drives [[Quickselect]]

> [!abstract] Quick Revision
> - **🎯 Objective:** partition around a pivot, recurse both sides ➔ heavy-split / trivial-combine D&C sort, no merge.
> - **📦 Core Components:** **Partition** ➔ smaller left, larger right | **Pivot** ➔ lands final | **Recurse** ➔ both sides.
> - **⚡ Key Constraint:** in-place + smallest constant ➔ but $\Theta(N^{2})$ on bad pivots; **pivot choice** is the whole game — and only a [[Median of Medians]] pivot converts "improbable" into "impossible".

## 📝 Core
### 1. The Algorithm (Partition → Recurse)
- **Non-trivial split** ➔ partition: smaller elements left of pivot, larger right.
- **Trivial combine** ➔ pivot already final ➔ just sort each side (no merge).
- **In-place** ➔ `partition`'s returned `boundary` is final, excluded from both recursive calls.
- **Mirror of [[Merge Sort]]** ➔ merge sort splits trivially and combines expensively; quicksort splits expensively and combines for free. Both pay $\Theta(N)$ per level — the difference is *where*.

### 2. Partitioning Efficiently
- **Lomuto (single pointer)** ➔ one left-to-right scan, `boundary` marks the end of the "smaller" run, one swap per smaller element ⟹ simplest to write and to trace, but performs **more swaps** than necessary.
- **Hoare (two pointers)** ➔ pointers walk inward from both ends and swap only **out-of-place pairs** ⟹ roughly $3\times$ fewer swaps; the catch is that it returns a **split point**, not the pivot's final index, so the recursive calls are `(start, j)` and `(j+1, end)` — never `j-1`.
- **3-way / Dutch national flag** ➔ partition into $<$, $=$, $>$ and recurse only on the outer two ⟹ the **all-duplicates** input drops from $\Theta(N^{2})$ to $\Theta(N)$; the standard fix when the key domain is small.
- **The efficiency question is about swaps, not comparisons** ➔ all three schemes make $\Theta(N)$ comparisons per level; they differ in **writes**, which is what matters when records are large ➔ [[Sorting Problem]].

### 3. Pivot Selection
- **Balanced split** ➔ median-ish pivot ➔ $\log_2 N$ levels × $\Theta(N)$ = $\Theta(N\log N)$.
- **Degenerate split** ➔ fixed pivot on sorted input peels off one element ➔ depth $N$, $\Theta(N^{2})$.
- **Balance need not be perfect** ➔ even a fixed $1:9$ split gives depth $\log_{10/9}N=\Theta(\log N)$ ⟹ still $\Theta(N\log N)$; only a split that is lopsided by a **constant number of elements at every level** reaches $\Theta(N^{2})$.

| Pivot policy | Cost to choose | Worst case | Triggered by | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| First / last element | $O(1)$ | $\Theta(N^{2})$ | **already-sorted** input | never — sorted input is the common case, not a rare one |
| Middle element | $O(1)$ | $\Theta(N^{2})$ | organ-pipe / crafted input | acceptable for coursework; still constructible |
| Median-of-three | $O(1)$ | $\Theta(N^{2})$ | a crafted "killer" sequence | the practical library default |
| **Random** | $O(1)$ + RNG | $\Theta(N^{2})$, probability $\to 0$ | an unlucky run only | removes the **adversary**, not the possibility |
| [[Median of Medians]] | $\Theta(N)$ per level | $\Theta(N\log N)$ | nothing | when a **guarantee** is contractually required |

### 4. Ensuring the Worst Case Never Occurs
- **Randomisation is a probability claim** ➔ it makes the $\Theta(N^{2})$ input impossible to *construct in advance*, since the split no longer depends on the input's arrangement; it does **not** bound any individual run.
- **[[Median of Medians]] is a guarantee** ➔ a provable $30/70$ split at every level ⟹ $T(N)=T(N/10)+T(9N/10)+\Theta(N)$-style balance ⟹ $\Theta(N\log N)$ **worst case**, at a constant factor large enough that practice still prefers random pivots.
- **Introsort — the engineering answer** ➔ run randomised quicksort but **count the recursion depth**; if it exceeds $\approx 2\log_2 N$, abandon and finish with [[Heapsort]] ⟹ $\Theta(N\log N)$ worst case at quicksort's average constant. *(🔭 Beyond the lecture — not in the slides; named only because it is what real libraries ship.)*
- **The exam framing** ➔ "how do you ensure the worst case never occurs?" is asking you to distinguish **expected** from **worst-case** bounds, then name a mechanism that upgrades one to the other ➔ [[Algorithmic Complexity]].

### 5. Bounding Stack Space
- **Risk** ➔ naïve recursion stacks $O(N)$ frames on a degenerate split — this is why quicksort's **auxiliary space is $O(N)$ in the worst case**, not $O(\log N)$.
- **Fix** ➔ recurse smaller partition first, loop (tail-call) on larger ➔ depth $\le\log_2 N$ ⇒ $O(\log N)$ space **in every case**, independent of pivot quality.
- **Not in-place either way** ➔ in-place $\equiv O(1)$ auxiliary, and live frames count; only [[Heapsort]] achieves $O(1)$ among the $\Theta(N\log N)$ sorts ➔ [[Sorting Problem]].

### 6. Stability
- **Unstable as written** ➔ partition swaps across long distances, throwing equal keys past one another — the same mechanism that makes [[Sorting Problem|selection sort]] unstable.
- **"Depends on the partition"** ➔ an **out-of-place** partition that copies items into two buffers in input order **is** stable, at $\Theta(N)$ extra space per level; the in-place swap-based schemes are not.
- **Universal fallback** ➔ index-tagging works here as on any comparison sort, at $\Theta(N)$ space and no change to the time bound ➔ [[Sorting Problem]] §6 owns the mechanism.

## ⚙️ Core Implementation
### 🔹 `quick_sort` + Lomuto `partition`
> [!code]- `quick_sort`, `quick_sort_aux`, `partition`
> ```python
> def quick_sort(array: ArrayR) -> None:
>     quick_sort_aux(array, 0, len(array)-1)
>
> def quick_sort_aux(array, start, end) -> None:
>     if start < end:
>         boundary = partition(array, start, end)  # pivot lands at boundary, final
>         quick_sort_aux(array, start, boundary-1)
>         quick_sort_aux(array, boundary+1, end)
>
> def partition(array, start, end) -> int:         # Lomuto scheme
>     mid = (start + end) // 2
>     pivot = array[mid]
>     swap(array, start, mid)                       # park pivot at start
>     boundary = start
>     for k in range(start+1, end+1):
>         if array[k] < pivot:
>             boundary += 1
>             swap(array, k, boundary)
>     swap(array, start, boundary)                  # pivot to its final slot
>     return boundary
> ```
> 💡 **Common Mistake:** **Worst case needs lopsided-at-every-level** ➔ fixed pivot on sorted input ⟹ $\Theta(N^{2})$; median-of-three/random makes it improbable. Cut to [[Sorting Problem|Insertion Sort]] for arrays $\lesssim 20$.

### 🔹 Hoare `partition` — fewer swaps, different contract
> [!code]- `hoare_partition` — two pointers converging; returns a SPLIT POINT
> ```python
> def hoare_partition(array, start, end) -> int:
>     pivot = array[(start + end) // 2]             # value, NOT parked at an end
>     i = start - 1
>     j = end + 1
>     while True:
>         i = i + 1
>         while array[i] < pivot:                   # stop on the first item >= pivot
>             i = i + 1
>         j = j - 1
>         while array[j] > pivot:                   # stop on the first item <= pivot
>             j = j - 1
>         if i >= j:
>             return j                              # split is [start..j] and [j+1..end]
>         swap(array, i, j)                         # ONE swap fixes TWO wrong items
>
> def quick_sort_hoare(array, start, end) -> None:
>     if start < end:
>         j = hoare_partition(array, start, end)
>         quick_sort_hoare(array, start, j)         # NOTE: j, not j-1
>         quick_sort_hoare(array, j+1, end)
> ```
> 💡 **Common Mistake:** **Recursing on `(start, j-1)` after Hoare** ➔ Lomuto's `boundary` is the pivot's **final index** and is excluded; Hoare's `j` is a **boundary between two sides** and must be **included** on the left. Copying Lomuto's call shape drops an element and the sort silently loses data.

## ⚖️ Core Decision Matrix
*(Domain A complexity table — Best / Average / Worst Time, Space, Stability.)*

| Algorithm | Best | Average | Worst | Auxiliary space | Stable | Trait |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Quick Sort** | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N^{2})$ | $O(\log N)$ smaller-first · $O(N)$ naive | No | in-place, fastest in practice |
| Quick Sort $+$ [[Median of Medians]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $O(\log N)$ | No | worst case **eliminated**, large constant |
| [[Merge Sort]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N)$ | **Yes** | guaranteed + stable, scratch |
| [[Heapsort]] | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $\Theta(N\log N)$ | $O(1)$ | No | in-place + guaranteed |
| [[Quickselect]] | $\Theta(N)$ | $\Theta(N)$ | $\Theta(N^{2})$ | $O(1)$ iterative | — | **one rank only**, not a sort |

> [!NOTE] **When It Flips:** quicksort's no-merge, cache-friendly, in-place partition gives the **smallest constant** among $\Theta(N\log N)$ sorts — choose it unless a worst-case *bound* ([[Heapsort]]) or **stability** ([[Merge Sort]]) is required. A quicksort run mirrors the [[Binary Tree|BST]] shape of inserting the same pivots. Switch to a 3-way partition once duplicate keys are common, and to [[Quickselect]] the moment only one rank is wanted rather than the whole order.

## 📊 Exam Execution Trace

### Manual Execution Trace
`partition([7,2,9,1,5])`, pivot `= array[mid] = 9` (parked at start); all others `< 9` so `boundary` advances to the end:

| Step / State | Trigger Op | `array[k]` | `< pivot(9)?` | `boundary` | Array Payload |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | park pivot | $-$ | $-$ | `0` | `[9,2,7,1,5]` |
| 1 | scan | `2` | yes | `1` | `[9,2,7,1,5]` |
| 2 | scan | `7` | yes | `2` | `[9,2,7,1,5]` |
| 3 | scan | `1` | yes | `3` | `[9,2,7,1,5]` |
| 4 | scan | `5` | yes | `4` | `[9,2,7,1,5]` |
| 5 | place pivot | $-$ | $-$ | `4` | `[5,2,7,1,9]` (9 final) |

**Read the split:** the pivot landed at index $4$ of $5$, i.e. a $4:0$ partition — the **degenerate** case in miniature. One such level is harmless; $N$ of them in a row is the $\Theta(N^{2})$ worst case.

### Applied Exercise
**Problem:** Derive quicksort's average and worst-case recurrences, then show that a fixed $1:9$ split is still $\Theta(N\log N)$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{balanced: } T(N) &= 2\,T(N/2) + \Theta(N) = \Theta(N\log N) \\
\text{lopsided: } T(N) &= T(N-1) + \Theta(N) = \Theta(N^{2}) \quad(\text{[[Arithmetic Series]]}) \\
1:9\text{ split: } T(N) &= T(N/10) + T(9N/10) + cN \\
\text{depth} &= \log_{10/9} N = \frac{\log_2 N}{\log_2(10/9)} = \Theta(\log N),\quad \text{work per level} \le cN \\
&\Rightarrow T(N) = \Theta(N\log N)
\end{aligned}
$$
**Final Extracted Output:** expected $\Theta(N\log N)$, worst $\Theta(N^{2})$ — and the boundary between them is **constant-fraction vs constant-size** splits, not "balanced vs unbalanced". Any split that removes a fixed *proportion* keeps the depth logarithmic.

## 🧠 Active Recall
> [!FAQ]- Why is quicksort $\Theta(N\log N)$ on average despite a $\Theta(N^{2})$ worst case?
> - **Hint:** Tie cost to split balance and pivot policy.
> > [!SUCCESS]- Answer
> > - **Short answer:** A reasonable pivot ➔ two equal halves ➔ $\log_2 N$ levels × $\Theta(N)$ = $\Theta(N\log N)$.
> > - **Why:** **Lopsided-at-every-level** ➔ the $\Theta(N^{2})$ case needs a maximally bad split each level (fixed pivot on sorted input); random/median-of-three makes it improbable. A merely *unequal* split does not suffice — $1:9$ is still logarithmic in depth.

> [!FAQ]- "Ensure the worst case never occurs." Distinguish what randomisation gives you from what [[Median of Medians]] gives you.
> - **Hint:** One statement quantifies over inputs, the other over runs.
> > [!SUCCESS]- Answer
> > - **Short answer:** Randomisation makes the bad case **unconstructible**; [[Median of Medians]] makes it **impossible**.
> > - **Why:** **Expected vs worst-case bound** ➔ with a random pivot the split no longer depends on the input's arrangement, so no adversary can pre-build a killer input — but an unlucky run is still permitted, and $\Theta(N^{2})$ remains the worst-case bound. A deterministic $30/70$ guarantee changes the bound itself to $\Theta(N\log N)$, at a constant so large that practice keeps randomisation ➔ [[Algorithmic Complexity]].

> [!FAQ]- Quicksort is in-place yet can use $O(N)$ stack — how do you guarantee $O(\log N)$ space?
> - **Hint:** Control recursion depth via ordering.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Recurse on the smaller partition first, loop on the larger.**
> > - **Why:** **Depth halving** ➔ the explicit recursive call always at least halves ⟹ stack depth $\le\log_2 N$ = $O(\log N)$, still fully in-place. Without it, the degenerate split stacks $N$ frames and the auxiliary space is $\Theta(N)$ — the figure the sorting summary table records for quicksort's worst case.

> [!FAQ]- Your input is a million records over only three distinct keys. Predict quicksort's behaviour and fix it.
> - **Hint:** Ask what a two-way partition does with a run of equal keys.
> > [!SUCCESS]- Answer
> > - **Short answer:** Two-way partitioning degenerates towards $\Theta(N^{2})$; a **3-way (Dutch national flag)** partition makes it $\Theta(N)$.
> > - **Why:** **Equal keys are re-partitioned forever** ➔ a $<$/$\ge$ split cannot retire duplicates, so they recur down the tree; separating $<$, $=$, $>$ retires the entire equal block at its level and recurses only on the outer two, so with $d$ distinct keys the depth is $O(\log d)$, not $O(\log N)$.

> [!FAQ]- When is merge sort preferable to quicksort, and vice versa?
> - **Hint:** Map guarantees/stability vs average speed/space.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Merge** for worst-case guarantees, stability, linked lists, external data; **quicksort** for in-memory arrays.
> > - **Why:** **Space/stability trade** ➔ merge guarantees $\Theta(N\log N)$ + stable but $\Theta(N)$ scratch; quicksort is in-place with smaller constants, $\Theta(N^{2})$ tamed by randomisation. Quicksort can be made stable only by partitioning out-of-place or index-tagging, both costing $\Theta(N)$ — at which point merge sort's advantage is free.
