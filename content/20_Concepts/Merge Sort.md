---
unit: [FIT1008, FIT2004]
domain: A
week: [1, 4, 7]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity, SWE/OOP]
---
# [[Merge Sort]]

**Context:** [[FIT1008_MOC]] · a [[Divide and Conquer]] sort · solves the [[Sorting Problem]] · uses an [[Recursion|Auxiliary Function (Recursion)]] · contrast with [[Quick Sort]] · the merge generalises from $2$ to $k$ lists in [[K-way Merge]]
**FIT2004 use:** the merge is also an **instrumentation point** — threading a counter through it solves an apparently unrelated problem in $\Theta(N\log N)$ ➔ [[Counting Inversions]]

> [!abstract] Quick Revision
> - **🎯 Objective:** cut in half, sort each, merge two sorted halves ➔ trivial-split / heavy-combine D&C sort.
> - **📦 Core Components:** **Split** ➔ $\Theta(1)$ | **Recurse** ➔ two calls on $n/2$ | **Merge** ➔ $\Theta(n)$, ties left-first ⇒ stable.
> - **⚡ Key Constraint:** **guaranteed $\Theta(n\log n)$ every case** + **stable** ➔ but needs **$\Theta(n)$ scratch**.

## 📝 Core
### 1. The Algorithm (Split → Merge)
- **Trivial split** ➔ cut the array in half; **non-trivial combine** ➔ **merge** two already-sorted halves.
- **Apparatus** ➔ one reused **temp array** of size $n$ + `start`/`end` markers; base case = 1-element slice.

### 2. Why $\Theta(n\log n)$ Every Case
- **Level count × per-level work** ➔ halving gives $\log_2 n$ levels, the merge does $\Theta(n)$ per level ➔ $\Theta(n\log n)$.
- **Order-independent** ➔ the count depends only on $n$, never element order ⟹ best = average = worst; **no $O(n^2)$ case** unlike [[Quick Sort]].

### 3. Stability & Variants
- **Stable tie-break** ➔ take from **left** half (`<=`) ➔ earlier-input keys emitted first.
- **Linked variant** ➔ [[List (ADT)|LinkList]] merges by **relinking** ➔ $\Theta(\log n)$ stack, no scratch.
- **External sort** ➔ sequential access pattern ➔ basis of multiway sorts for data $>$ RAM.

### 4. The Hybrid Cut-off *(applied W4)*
- **The engineering trick** ➔ stop recursing at subproblem size $k$ and finish with **insertion sort**, fast on small nearly-sorted ranges with tiny constants ([[Sorting Problem]]).
- **Merging part** ➔ recursion stops when $n(\tfrac12)^{d}=k$ ⟹ $d=\log_{2}\frac{n}{k}$ levels × $\Theta(n)$ ⟹ $\Theta\!\left(n\log\frac{n}{k}\right)$.
- **The tail** ➔ $\Theta(n/k)$ subproblems of size $k$, each $\Theta(k^{2})$ worst case ⟹ $\Theta(nk)$.
- **Total $\Theta\!\left(nk+n\log\frac{n}{k}\right)$** ➔ raising $k$ buys fewer merge levels and pays quadratically in the tail, so it is asymptotically **worse** for growing $k$; $k$ is held at a small **constant** (libraries use $\approx10$–$32$), where the bound collapses back to $\Theta(n\log n)$ with a smaller constant factor. A **constant-factor** optimisation, never a class change.

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
$$
T(n) = 2\,T(n/2) + \Theta(n) = \Theta(n)\cdot \underbrace{\log_2 n}_{\text{levels}} = \Theta(n\log n)
$$
**Final Extracted Output:** the level count and per-level work are both independent of input order ⟹ best = average = worst = $\Theta(n\log n)$; no input degrades it.

## 🧠 Active Recall
> [!FAQ]- Merge sort and quicksort are both $\Theta(n\log n)$ average — name two situations where merge sort is the correct pick.
> - **Hint:** Identify guarantee/stability/access-pattern needs.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) **worst-case guarantees** (real-time/adversarial); (2) **stability** (secondary-key sort).
> > - **Why:** **No-$O(n^2)$ + linked/external** ➔ quicksort can hit $\Theta(n^2)$; merge also suits linked lists (relink-merge, no scratch) and external data (sequential access).

> [!FAQ]- Prove merge sort is stable and identify the exact line responsible.
> - **Hint:** Locate the tie-break in the merge.
> > [!SUCCESS]- Answer
> > - **Short answer:** ties resolve from the **left** subarray via `a[ia] <= a[ib]`.
> > - **Why:** **Left-first emission** ➔ the left holds earlier-input elements, so equal keys keep order; `<=` → `<` would emit the right first and break stability.

> [!FAQ]- Why does the hybrid cut-off at size $k$ not improve merge sort's complexity class?
> - **Hint:** Write both terms and let $k$ grow.
> > [!SUCCESS]- Answer
> > - **Short answer:** total is $\Theta(nk+n\log\frac{n}{k})$ — the insertion-sort tail grows **linearly in $k$** while the saved merge levels only shrink **logarithmically**.
> > - **Why:** **Constant-factor optimisation** ➔ at constant $k$ both terms collapse to $\Theta(n\log n)$ with a smaller leading constant; letting $k$ grow with $n$ makes it strictly worse.
