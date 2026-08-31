---
unit: [FIT1008, FIT2004]
domain: A
week: [1, 3]
source: [lecture, applied]
parent: "[[Computational Problem]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity, SWE/OOP]
---
# [[Sorting Problem]]

**Context:** [[FIT1008_MOC]], [[FIT2004_MOC]] · a [[Computational Problem]] · the three **elementary $O(n^2)$ sorts** (Bubble/Selection/Insertion) + **Stability** & **Incrementality** · recursive sorts ([[Merge Sort]], [[Quick Sort]], [[Heapsort]]) referenced
**FIT2004 emphasis:** every sort is graded on **four** axes — correctness ([[Invariant]]), time, **auxiliary** space, stability — and the suite splits into **comparison-based** (floored at $\Omega(N\log N)$) vs **non-comparison** ([[Counting Sort]], [[Radix Sort]], which break the floor). W3 adds the **engineering** layer: how to *force* stability onto an unstable sort, and what sorting is actually **for** (§8).

> [!abstract] Quick Revision
> - **🎯 Objective:** rearrange $n$ orderable elements → non-decreasing ➔ correctness = **permutation AND ordering** (ordered-only misses drop/duplicate bugs).
> - **📦 Core Components:** **Bubble** ➔ adaptive, $\Theta(n^2)$ swaps | **Selection** ➔ $\Theta(n)$ swaps, never adaptive | **Insertion** ➔ adaptive + online | **non-comparison** ➔ $\Theta(N+M)$ / $\Theta(KN)$.
> - **⚡ Key Constraint:** all three elementary sorts are $O(n^2)$ worst (arithmetic series $\sum k$) ➔ discriminators are **stability**, **swap count**, **adaptivity**; the $\Omega(n\log n)$ floor binds **only** algorithms that compare.

## 📝 Core
### 1. Comparison-Based vs Non-Comparison
- **Comparison-based** ➔ the only access to keys is "is $a<b$?" — bubble, insertion, selection, [[Merge Sort]], [[Quick Sort]], [[Heapsort]].
- **The floor** ➔ every comparison-based sort is $\Omega(N\log N)$ ⟹ $\Theta(N\log N)$ sorts are **provably optimal** within that class.
- **Non-comparison** ➔ [[Counting Sort]] and [[Radix Sort]] use the key **as an array index**, never comparing two items ⟹ the floor does not apply, at the cost of demanding bounded integer keys. **The bound is escaped by narrowing the problem, not by beating it.**
- **Selection rule** ➔ bounded integer keys with range $M \ll N$ ⟹ [[Counting Sort]]; decomposable into $K$ narrow columns ⟹ [[Radix Sort]]; anything else ⟹ a comparison sort.

### 2. Bubble Sort
- **Mechanism** ➔ walk L→R, swap each $X>Y$ ➔ largest **bubbles** to the final tail.
- **Adaptivity** ➔ BubbleSort II `swapped` flag ➔ $O(n)$ best on sorted input.
- **Cost profile** ➔ strict `>` ⟹ **stable**; up to $\Theta(n^2)$ swaps (one per inversion).

### 3. Selection Sort
- **Mechanism** ➔ scan suffix for min ➔ **exactly one swap**/pass to leftmost unsorted ⟹ $\Theta(n)$ swaps (wins when writes are costly: flash, big records).
- **No best case** ➔ the minimum must be located in full every pass ⟹ best $=$ avg $=$ worst $O(n^2)$; **unstable**, because the long-distance swap can throw an equal key backwards (`[4a,2,3,4b,1]` → `[1,2,3,4b,4a]`).
- **Correctness** ➔ two-clause prefix invariant + both counters increment ➔ [[Invariant]].

### 4. Insertion Sort
- **Mechanism** ➔ sorted prefix; shift larger elements right, drop `temp` into the gap.
- **Adaptive + online** ➔ best $O(n)$ (sorted input ⟹ the inner `while` never fires) ➔ absorbs a new last element in one pass.
- **Stability from shifting** ➔ strict `>` means equal keys are never swapped past each other; **shifting** rather than swapping is what preserves order ➔ basis of [[Sorted List (ADT)|sorted-list `add`]].

### 5. Stability (Property)
- **Definition** ➔ equal keys keep input order; observable only when sorting **by key**, and free/unobservable with distinct keys.
- **When it matters** ➔ multi-pass sorting on several keys (sort by name, then by department, names stay ordered within each department) and any [[Radix Sort]] subsort.
- **Mechanism heuristic** ➔ **shifting is stable, long-distance swapping is not**. Bubble/insertion/merge move items past **adjacent** or ordered positions; selection/heap/quicksort throw an item across the array and can hurdle an equal key. `>` vs `>=` is a one-character stability break.
- **Engineering fix A — tuple the index in** ➔ compare on $(k_i, i)$ so ties break by original position; blocked when the container cannot hold tuples.
- **Engineering fix B — a parallel index list** ➔ keep `index_list` alongside the data, consult it **only when `list[a] == list[b]`**, applying every swap to both lists.
- **Time is UNCHANGED by either fix** ➔ when $\text{list}[a]\ne\text{list}[b]$ the index list is never read; when equal, the tie-break compares two **integers** in $O(1)$ ⟹ no factor added to any bound.
- **Space grows by one class at most** ➔ selection sort goes from $O(1)$ auxiliary to $\Theta(N)$; total space was already $\Theta(N)$ ⟹ the **total** bound does not move, only the in-place claim is lost.

### 6. Incrementality (Property)
- **Definition** ➔ small input change ➔ $O(1)$ rework (sorting's **online** analogue) ➔ [[Online Algorithm]].
- **Insertion yes / Selection no** ➔ append-to-back needs one pass; a "final" prefix blocks latecomers. For frequent updates, graduate to a balanced [[Binary Tree]]/[[Heap]] ($O(\log n)$/update).

### 7. The Cost Terms Everyone Drops
- **Comparisons are not $O(1)$** ➔ if comparing costs $O(k)$ (words letter-by-letter, tuples field-by-field), every bound gains a factor: elementary sorts $O(kN^2)$, [[Merge Sort]] $O(kN\log N)$ **· state $k$ or declare it constant**. Input space follows: $N$ strings of length $\le k$ occupy $\Theta(Nk)$.
- **Why an integer comparison IS $O(1)$** ➔ a fixed-width machine word compares in **one hardware instruction**; a $k$-character string must be walked. The asymmetry is architectural — the item type, not the algorithm, decides whether $k$ can be dropped.
- **Comparisons $\ge$ swaps, always** ➔ no algorithm swaps a pair it never compared ⟹ use it as a self-check on a derived answer.
- **The recursion stack is auxiliary space** ➔ $\log N$ levels of frames cost $\Theta(\log N)$, and $\Theta(k\log N)$ if each frame stores $k$ words ⟹ recursive sorts are **not in-place** even when they never allocate scratch. An iterative rewrite is the standard route to $O(1)$ auxiliary — which is why "in-place?" and "recursive?" are nearly the same question.
- **Three auxiliary-space classes, three causes** ➔ $O(1)$ ⟸ iterative, swaps only (elementary sorts, [[Heapsort]]) · $O(\log N)$ ⟸ a **balanced** recursion's frame chain ([[Merge Sort]]'s stack, [[Quick Sort]] recursing smaller-first) · $O(N)$ ⟸ a scratch array ([[Merge Sort]]'s buffer) **or** a degenerate recursion ([[Quick Sort]]'s worst-case stack). Naming the *cause* earns the mark.
- **Best $=$ worst is a diagnostic, not a coincidence** ➔ the cases collapse exactly when *(1)* there is **no early termination** path and *(2)* the **item values cannot change control flow**. Selection sort and [[Merge Sort]] satisfy both; bubble (`swapped` flag) and insertion (inner `while`) violate *(1)*, [[Quick Sort]] violates *(2)* ➔ [[Big-O Notation]].

### 8. What Sorting Is FOR
- **Sorting is rarely the goal** ➔ it is the $\Theta(N\log N)$ preprocessing that makes a later pass **linear**; if the follow-up is not cheaper, the sort was not worth it.
- **Grouping** ➔ equal keys become **contiguous**, so counting occurrences, finding the mode, or aggregating by key collapses to one sequential scan.
- **Deduplication** ➔ duplicates are adjacent after sorting, so **two-pointer compaction** removes them in $\Theta(N)$; deleting in place by shifting the tail costs $\Theta(N)$ per removal, $\Theta(N^{2})$ overall.
- **An "in-place" requirement PICKS THE SORT** ➔ the compaction is already $O(1)$ auxiliary, so the sort is the only term that can break the budget: [[Merge Sort]] spends $\Theta(N)$ on scratch and [[Quick Sort]] $\Theta(\log N)$ on stack ⟹ **[[Heapsort]] is the only valid choice**, the sole $\Theta(N\log N)$ sort with $O(1)$ auxiliary. Naming the sort is the marked step, not the two-pointer loop.
- **Why not a hash set or BST** ➔ both dedup in $\Theta(N)$ expected / $\Theta(N\log N)$ and **preserve input order**, but cost $\Theta(N)$ auxiliary ⟹ disqualified the moment "in-place" appears. Reach for them when order preservation outweighs space.
- **Enabling $O(\log N)$ access** ➔ sortedness is the precondition of [[Binary Search]] and of range reporting in $\Theta(\log N+W)$ ➔ [[Output-Sensitive Complexity]].
- **Order statistics** ➔ sorting answers **every** rank at once; for one rank, [[Quickselect]] does it in $\Theta(N)$ and sorting is over-solving.
- **The amortisation rule** ➔ sort once at $\Theta(N\log N)$ and every subsequent query is cheap; sort per query and the preprocessing is paid again each time.

## ⚙️ Core Implementation
### 🔹 Bubble Sort (II, adaptive)
> [!code]- `bubble_sort` with early-exit flag
> ```python
> def bubble_sort(the_list):
>     n = len(the_list)
>     for mark in range(n - 1, 0, -1):          # tail [mark+1..] is sorted & final
>         swapped = False                       # BubbleSort II: early-exit flag
>         for i in range(mark):                 # scan only the unsorted prefix
>             if the_list[i] > the_list[i + 1]: # STRICT '>' preserves stability
>                 the_list[i], the_list[i+1] = the_list[i+1], the_list[i]
>                 swapped = True
>         if not swapped:                       # a clean pass => already sorted
>             break
> ```
> 💡 **Common Mistake:** **Strict `>` is load-bearing** ➔ `>=` swaps equal neighbours and breaks stability; the `swapped` flag is the *only* source of the $O(n)$ best case.

### 🔹 Selection Sort (min swaps)
> [!code]- `selection_sort` — inline minimum index, one swap per pass
> ```python
> def selection_sort(my_list):
>     for i in range(len(my_list)):              # leftmost unsorted position
>         minimum = i
>         for j in range(i + 1, len(my_list)):   # find the minimum of the suffix
>             if my_list[minimum] > my_list[j]:
>                 minimum = j
>         my_list[i], my_list[minimum] = my_list[minimum], my_list[i]   # ONE swap
> ```
> 💡 **Common Mistake:** **No early-exit path** ➔ comparisons are $\sum k$ regardless of input ⟹ no $O(n)$ best case; the long-distance swap makes it **unstable**.

### 🔹 Insertion Sort (adaptive, online)
> [!code]- `insertion_sort` — shift-left while the left neighbour is greater
> ```python
> def insertion_sort(my_list):
>     for i in range(1, len(my_list)):
>         key = my_list[i]                       # 1. stash it
>         j = i - 1
>         while j >= 0 and key < my_list[j]:     # 2. shift larger prefix elems right
>             my_list[j + 1] = my_list[j]        #    (shift, never swap => stable)
>             j = j - 1
>         my_list[j + 1] = key                   # 3. drop key into the gap
> ```
> 💡 **Common Mistake:** **Flat "$O(n^2)$" hides the best case** ➔ on sorted input the `while` never fires ⟹ $O(n)$; the weak "sorted-not-final" invariant is what makes it **online**.

### 🔹 Two-pointer deduplication (the payoff of sorting)
> [!code]- `dedup_sorted` — read/write pointers, in-place, $\Theta(N)$
> ```python
> def dedup_sorted(my_list):
>     # PRECONDITION: my_list is sorted, so duplicates are ADJACENT.
>     # For an IN-PLACE guarantee the caller must sort with HEAPSORT --
>     # merge sort's scratch and quicksort's stack both break O(1) auxiliary.
>     if len(my_list) == 0:
>         return 0
>     write = 0                                  # last kept unique item
>     for read in range(1, len(my_list)):        # ONE forward scan
>         if my_list[read] != my_list[write]:
>             write = write + 1
>             my_list[write] = my_list[read]     # overwrite, never shift
>     return write + 1                           # new logical length
> ```
> 💡 **Common Mistake:** **Two pointers, not one** ➔ `read` advances every iteration, `write` only on a new value; collapsing them either skips elements or overwrites unread ones.

## ⚖️ Core Decision Matrix
*(Best / Average / Worst time, auxiliary space, stability, in-place. $\times\,O(k)$ comparison cost applies to every comparison-based row.)*

| Algorithm | Best | Average | Worst | Auxiliary space | Stable | In-place | Distinctive trait |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Bubble Sort** (II) | $O(N)$ | $O(N^2)$ | $O(N^2)$ | $O(1)$ | **Yes** | Yes | adaptive; $\Theta(N^2)$ swaps |
| **Selection Sort** | $O(N^2)$ | $O(N^2)$ | $O(N^2)$ | $O(1)$ | No | Yes | only $\Theta(N)$ swaps |
| **Insertion Sort** | $O(N)$ | $O(N^2)$ | $O(N^2)$ | $O(1)$ | **Yes** | Yes | adaptive **and** online |
| [[Heapsort]] | $O(N\log N)$ | $O(N\log N)$ | $O(N\log N)$ | $O(1)$ | No | Yes | in-place **and** guaranteed |
| [[Merge Sort]] | $O(N\log N)$ | $O(N\log N)$ | $O(N\log N)$ | $\Theta(N)$ scratch $+\ \Theta(\log N)$ stack | **Yes** | No | guaranteed, stable |
| [[Quick Sort]] | $O(N\log N)$ | $O(N\log N)$ | $O(N^2)$ — fixable to $O(N\log N)$ | $O(\log N)$ stack | Depends | No | fast in practice; pivot-sensitive |
| [[Counting Sort]] | $\Theta(N{+}M)$ | $\Theta(N{+}M)$ | $\Theta(N{+}M)$ | $\Theta(M)$ · $\Theta(M{+}N)$ stable | engineered | No | **no comparisons**; $M=$ key range |
| [[Radix Sort]] | $\Theta(KN{+}KM)$ | $\Theta(KN{+}KM)$ | $\Theta(KN{+}KM)$ | $\Theta(M{+}N)$ | **required** | No | $K$ stable counting passes, LSD first |

> [!NOTE] **When It Flips:** choose an $O(N^2)$ sort when $N$ is small (low overhead), nearly-sorted (insertion → $O(N)$), or writes dominate (selection's $\Theta(N)$ swaps). Choose a non-comparison sort **only** for bounded integer keys: [[Counting Sort]] while $M \ll N\log N$, [[Radix Sort]] while $K < \log_2 N$. Otherwise the $\Omega(N\log N)$ floor makes [[Merge Sort]]/[[Heapsort]] optimal — merge for stability, heap for $O(1)$ auxiliary.

## 📊 Exam Execution Trace

### Manual Execution Trace
Insertion Sort on `[5, 2, 4, 1]`:

| Step / State | Trigger Op | `mark` | `temp` | Shifts | Array Payload |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `init` | $-$ | $-$ | $-$ | `[5, 2, 4, 1]` |
| 1 | insert | `1` | `2` | `5→` | `[2, 5, 4, 1]` |
| 2 | insert | `2` | `4` | `5→` | `[2, 4, 5, 1]` |
| 3 | insert | `3` | `1` | `5,4,2→` | `[1, 2, 4, 5]` |

### Applied Exercise
**Problem:** Derive the worst-case bound of the elementary sorts on reverse-sorted input, then re-quote it when each comparison costs $O(k)$.
$$
\text{mark } j \text{ shifts up to } j \text{ elements} \implies \sum_{j=1}^{n-1} j = \frac{n(n-1)}{2} = \Theta(n^2) \quad(\text{[[Arithmetic Series]]}); \quad \text{with } O(k)\text{/comparison} \implies \Theta(k n^2)
$$
**Final Extracted Output:** worst case $= \Theta(n^2)$ for bubble/selection/insertion, or $\Theta(kn^2)$ with non-constant comparison cost; bubble & insertion reach $O(n)$ best via their short-circuits, selection has no such path.

## 🧠 Active Recall
> [!FAQ]- Bubble, selection, insertion are all $O(n^2)$ — on what grounds distinguish them?
> - **Hint:** Compare by adaptivity, swap count, stability, online-ness — not Big-O.
> > [!SUCCESS]- Answer
> > - **Short answer:** **selection** = $\Theta(n)$ swaps but never adaptive/unstable; **insertion** = adaptive + online + stable; **bubble** = adaptive + stable but $\Theta(n^2)$ swaps.
> > - **Why:** **Invariant strength** ➔ selection's "final prefix" blocks adaptivity/online use; insertion's "sorted-not-final" permits both ➔ [[Invariant]].

> [!FAQ]- Sort 10M records by primary then secondary key in $O(n\log n)$ with stability — which algorithm, and how to stabilise quicksort if forced?
> - **Hint:** Match the stability requirement to the algorithm and know the index-tag trick.
> > [!SUCCESS]- Answer
> > - **Short answer:** use **merge sort** (or Timsort) — guaranteed $\Theta(n\log n)$, naturally stable.
> > - **Why:** **Forced stability is the fallback, not the plan** ➔ if quicksort is mandated, index-tagging converts it at $\Theta(n)$ space and no time penalty ➔ §5 — at which point merge sort's scratch costs nothing extra, so tagging only pays when the sort itself is fixed.

> [!FAQ]- Every sort we have met is $\Omega(N\log N)$ — so how can [[Radix Sort]] claim $\Theta(KN)$?
> - **Hint:** The floor is a statement about a *class* of algorithms, not about the problem.
> > [!SUCCESS]- Answer
> > - **Short answer:** the floor applies only to **comparison-based** sorts; radix and counting never compare two keys.
> > - **Why:** **Extra assumption buys the speed** ➔ using the key as an array index requires **bounded integer keys**, which a comparison sort does not assume.

> [!FAQ]- Merge sort allocates $\Theta(N)$ scratch and quicksort allocates none — why is quicksort still recorded as *not in-place*?
> - **Hint:** Count every word the algorithm keeps live, not just heap allocations.
> > [!SUCCESS]- Answer
> > - **Short answer:** the **recursion stack** is auxiliary space — $\Theta(\log N)$ live frames ⟹ not $O(1)$ auxiliary.
> > - **Why:** **In-place $\equiv$ $O(1)$ auxiliary** ➔ frames count, and $\Theta(k\log N)$ if each holds $k$ words; an iterative rewrite drops the term, which is why [[Heapsort]] is the in-place $\Theta(N\log N)$ option.
