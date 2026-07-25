---
unit: FIT1008
week: 7
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity, SWE/OOP]
---
# [[Quick Sort]]

**Context:** [[FIT1008_MOC]] · a [[Divide and Conquer]] sort · solves the [[Sorting Problem]] · uses an [[Recursion|Auxiliary Function (Recursion)]] · contrast with [[Merge Sort]]; falls back to [[Sorting Problem|Insertion Sort]] for tiny arrays

> [!abstract] Quick Revision
> - **🎯 Objective:** partition around a pivot, recurse both sides ➔ heavy-split / trivial-combine D&C sort, no merge.
> - **📦 Core Components:** **Partition** ➔ smaller left, larger right | **Pivot** ➔ lands final | **Recurse** ➔ both sides.
> - **⚡ Key Constraint:** in-place + smallest constant ➔ but $\Theta(n^2)$ on bad pivots; **pivot choice** is the whole game.

## 📝 Core
### 1. The Algorithm (Partition → Recurse)
- **Non-trivial split** ➔ partition: smaller elements left of pivot, larger right.
- **Trivial combine** ➔ pivot already final ➔ just sort each side (no merge).
- **In-place** ➔ `partition`'s returned `boundary` is final, excluded from both recursive calls.

### 2. Average vs Worst (Pivot Choice)
- **Balanced split** ➔ median-ish pivot ➔ $\log_2 n$ levels × $\Theta(n)$ = $\Theta(n\log n)$.
- **Degenerate split** ➔ fixed pivot on sorted input peels off one element ➔ depth $n$, $\Theta(n^2)$.
- **Mitigation** ➔ **median-of-three** or **random** pivot makes lopsided splits improbable.

### 3. Bounding Stack Space
- **Risk** ➔ naïve recursion stacks $O(n)$ frames.
- **Fix** ➔ recurse smaller partition first, loop (tail-call) on larger ➔ depth $\le\log_2 n$ ⇒ $O(\log n)$ space.

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
> 💡 **Common Mistake:** **Worst case needs lopsided-at-every-level** ➔ fixed pivot on sorted input ⟹ $\Theta(n^2)$; median-of-three/random makes it improbable. Cut to [[Sorting Problem|Insertion Sort]] for arrays $\lesssim 20$.

## ⚖️ Core Decision Matrix
*(Domain A complexity table — Best / Average / Worst Time, Space, Stability.)*

| Algorithm | Best | Average | Worst | Space | Stable | Trait |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Quick Sort** | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n^2)$ | $O(\log n)$ | No | in-place, fastest in practice |
| [[Merge Sort]] | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n)$ | **Yes** | guaranteed + stable, scratch |
| [[Heapsort]] | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $O(1)$ | No | in-place + guaranteed |

> [!NOTE] **When It Flips:** quicksort's no-merge, cache-friendly, in-place partition gives the **smallest constant** among $\Theta(n\log n)$ sorts — choose it unless a worst-case *bound* (heapsort) or **stability** (merge sort) is required. A quicksort run mirrors the [[Binary Tree|BST]] shape of inserting the same pivots.

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

### Applied Exercise
**Problem:** Derive the average and worst-case recurrences of quicksort.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{balanced: } T(n) &= 2\,T(n/2) + \Theta(n) = \Theta(n\log n) \\
\text{lopsided: } T(n) &= T(n-1) + \Theta(n) = \Theta(n^2)
\end{aligned}
$$
**Final Extracted Output:** expected $\Theta(n\log n)$ (balanced splits), worst $\Theta(n^2)$ (degenerate pivots).

## 🧠 Active Recall
> [!FAQ]- Why is quicksort $\Theta(n\log n)$ on average despite a $\Theta(n^2)$ worst case?
> - **Hint:** Tie cost to split balance and pivot policy.
> > [!SUCCESS]- Answer
> > - **Short answer:** A reasonable pivot ➔ two equal halves ➔ $\log_2 n$ levels × $\Theta(n)$ = $\Theta(n\log n)$.
> > - **Why:** **Lopsided-at-every-level** ➔ the $\Theta(n^2)$ case needs a maximally bad split each level (fixed pivot on sorted input); random/median-of-three makes it improbable.

> [!FAQ]- Quicksort is in-place yet can use $O(n)$ stack — how do you guarantee $O(\log n)$ space?
> - **Hint:** Control recursion depth via ordering.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Recurse on the smaller partition first, loop on the larger.**
> > - **Why:** **Depth halving** ➔ the explicit recursive call always at least halves ⟹ stack depth $\le\log_2 n$ = $O(\log n)$, still fully in-place.

> [!FAQ]- When is merge sort preferable to quicksort, and vice versa?
> - **Hint:** Map guarantees/stability vs average speed/space.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Merge** for worst-case guarantees, stability, linked lists, external data; **quicksort** for in-memory arrays.
> > - **Why:** **Space/stability trade** ➔ merge guarantees $\Theta(n\log n)$ + stable but $\Theta(n)$ scratch; quicksort is in-place with smaller constants, $\Theta(n^2)$ tamed by randomisation.
