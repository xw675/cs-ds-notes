---
unit: [FIT1008, FIT2004]
domain: A
week: [1, 7]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity, SWE/OOP]
---
# [[Merge Sort]]

**Context:** [[FIT1008_MOC]] · a [[Divide and Conquer]] sort · solves the [[Sorting Problem]] · uses an [[Recursion|Auxiliary Function (Recursion)]] · contrast with [[Quick Sort]]

> [!abstract] Quick Revision
> - **🎯 Objective:** cut in half, sort each, merge two sorted halves ➔ trivial-split / heavy-combine D&C sort.
> - **📦 Core Components:** **Split** ➔ $\Theta(1)$ | **Recurse** ➔ two calls on $n/2$ | **Merge** ➔ $\Theta(n)$, ties left-first ⇒ stable.
> - **⚡ Key Constraint:** **guaranteed $\Theta(n\log n)$ every case** + **stable** ➔ but needs **$\Theta(n)$ scratch**.

## 📝 Core
### 1. The Algorithm (Split → Merge)
- **Trivial split** ➔ cut the array in half (card-pile metaphor).
- **Non-trivial combine** ➔ **merge** two already-sorted halves into one.
- **Apparatus** ➔ one reused **temp array** of size $n$ + `start`/`end` markers; base case = 1-element slice.

### 2. Why $\Theta(n\log n)$ Every Case
- **Level count** ➔ halving ➔ $\log_2 n$ levels.
- **Per-level work** ➔ merge does $\Theta(n)$ total per level ➔ $\Theta(n\log n)$.
- **Order-independent** ➔ best = average = worst; **no $O(n^2)$ case** unlike [[Quick Sort]].

### 3. Stability & Variants
- **Stable tie-break** ➔ take from **left** half (`<=`) ➔ earlier-input keys emitted first.
- **Linked variant** ➔ [[List (ADT)|LinkList]] merges by **relinking** ➔ $\Theta(\log n)$ stack, no scratch.
- **External sort** ➔ sequential access pattern ➔ basis of multiway sorts for data $>$ RAM.

## ⚙️ Core Implementation
### 🔹 `merge_sort` + auxiliary recursion + the $O(n)$ merge
> [!code]- `merge_sort`, `merge_sort_aux`, `merge_arrays`
> ```python
> def merge_sort(array: ArrayR) -> None:
>     tmp = ArrayR(len(array))                       # one temp array, reused
>     merge_sort_aux(array, 0, len(array)-1, tmp)
>
> def merge_sort_aux(array, start, end, tmp) -> None:
>     if not start == end:                           # base: 1 element, sorted
>         mid = (start + end) // 2
>         merge_sort_aux(array, start, mid, tmp)
>         merge_sort_aux(array, mid+1, end, tmp)
>         merge_arrays(array, start, mid, end, tmp)
>         for i in range(start, end+1):
>             array[i] = tmp[i]
>
> def merge_arrays(a, start, mid, end, tmp) -> None: # the O(n) combine
>     ia, ib = start, mid + 1
>     for k in range(start, end+1):
>         if ia > mid:               tmp[k] = a[ib]; ib += 1   # left exhausted
>         elif ib > end:             tmp[k] = a[ia]; ia += 1   # right exhausted
>         elif a[ia] <= a[ib]:       tmp[k] = a[ia]; ia += 1   # '<=' => STABLE
>         else:                      tmp[k] = a[ib]; ib += 1
> ```
> 💡 **Common Mistake:** **Merge `<=` is load-bearing** ➔ `<` emits the right element first on ties, breaking stability; guard empty input (`mid = -1//2 = -1` recurses forever).

## ⚖️ Core Decision Matrix
*(complexity table — Best / Average / Worst Time, Space, Stability.)*

| Algorithm | Best | Average | Worst | Space | Stable | Trait |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Merge Sort** | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n)$ | **Yes** | guaranteed + stable, scratch array |
| [[Quick Sort]] | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n^2)$ | $O(\log n)$ | No | in-place, smaller constant |
| [[Heapsort]] | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $O(1)$ | No | in-place + guaranteed |

> [!NOTE] **When It Flips:** merge sort's space/stability trade is the inverse of quicksort's — pick merge for **worst-case guarantees, stability, linked lists, or external data**; quicksort when in-place + smaller constant outweigh the $\Theta(n^2)$ risk.

## 📊 Exam Execution Trace

### Manual Execution Trace
Merge of two sorted halves `[2, 5]` + `[1, 4]`:

| Step / State | Trigger Op | `a[ia]` | `a[ib]` | Take | `tmp` Payload |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `init` | `2` | `1` | $-$ | `[]` |
| 1 | compare | `2` | `1` | right (1<2) | `[1]` |
| 2 | compare | `2` | `4` | left (2≤4) | `[1,2]` |
| 3 | compare | `5` | `4` | right (4<5) | `[1,2,4]` |
| 4 | drain | `5` | $-$ | left | `[1,2,4,5]` |

### Applied Exercise
**Problem:** Derive merge sort's complexity and show why it has no bad case.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
T(n) &= 2\,T(n/2) + \Theta(n) = \Theta(n)\cdot \underbrace{\log_2 n}_{\text{levels}} \\
&= \Theta(n\log n) \quad(\text{count independent of input order})
\end{aligned}
$$
**Final Extracted Output:** best = average = worst = $\Theta(n\log n)$ — no input degrades it.

## 🧠 Active Recall
> [!FAQ]- Explain merge sort's complexity and why it has no bad case.
> - **Hint:** Tie the recurrence to order-independence.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\log_2 n$ levels × $\Theta(n)$ merge work = $\Theta(n\log n)$.
> > - **Why:** **Order-independent count** ➔ work depends only on $n$, never element order ⟹ best = average = worst, no degrading input.

> [!FAQ]- Merge sort and quicksort are both $\Theta(n\log n)$ average — two situations where merge sort is correct?
> - **Hint:** Identify guarantee/stability/access-pattern needs.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) **Worst-case guarantees** (real-time/adversarial); (2) **stability** (secondary-key sort).
> > - **Why:** **No-$O(n^2)$ + linked/external** ➔ quicksort can hit $\Theta(n^2)$; merge also suits linked lists (relink-merge) and external data (sequential access).

> [!FAQ]- Prove merge sort is stable and identify the exact line responsible.
> - **Hint:** Locate the tie-break in the merge.
> > [!SUCCESS]- Answer
> > - **Short answer:** Ties resolve from the **left** subarray via `a[ia] <= a[ib]`.
> > - **Why:** **Left-first emission** ➔ the left holds earlier-input elements, so equal keys keep order; `<=` → `<` would emit the right first and break stability.
