---
unit: FIT1008
domain: A
week: 1
parent: "[[Computational Problem]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity, SWE/OOP]
---
# [[Sorting Problem]]

**Context:** [[FIT1008_MOC]] · a [[Computational Problem]] · backbone clustering the three **elementary $O(n^2)$ sorts** (Bubble/Selection/Insertion) + sort properties **Stability** & **Incrementality** · recursive sorts ([[Merge Sort]], [[Quick Sort]], [[Heapsort]]) referenced

> [!abstract] Quick Revision
> - **🎯 Objective:** rearrange n orderable elements → non-decreasing ➔ correctness = permutation + ordering.
> - **📦 Core Components:** **Bubble** ➔ adaptive, $\Theta(n^2)$ swaps | **Selection** ➔ $\Theta(n)$ swaps, never adaptive | **Insertion** ➔ adaptive + online.
> - **⚡ Key Constraint:** all three $O(n^2)$ worst (arithmetic series $\sum k$) ➔ discriminators are **stability**, **swap count**, **adaptivity**.

## 📝 Core
### 1. The Sorting Problem (Spec)
- **Specification** ➔ input $n$ **orderable** elements ➔ output permutation $a'_0 \le \dots \le a'_{n-1}$.
- **Correctness** ➔ **permutation AND ordering** (ordered-only misses drop/duplicate bugs).
- **Lower bound** ➔ comparison sorts $\Omega(n\log n)$; elementary sorts fail to meet it.

### 2. Bubble Sort
- **Mechanism** ➔ walk L→R, swap each $X>Y$ ➔ largest **bubbles** to the final tail.
- **Adaptivity** ➔ BubbleSort II `swapped` flag ➔ $O(n)$ best on sorted input.
- **Cost profile** ➔ strict `>` ⟹ **stable**; up to $\Theta(n^2)$ swaps (one per inversion).

### 3. Selection Sort
- **Mechanism** ➔ scan suffix for min ➔ **exactly one swap**/pass to leftmost unsorted.
- **Swap-thrift** ➔ $\Theta(n)$ swaps (wins when writes costly: flash, big records).
- **No best case** ➔ comparisons input-independent ➔ best=avg=worst $O(n^2)$; **unstable** (long-distance swap).

### 4. Insertion Sort
- **Mechanism** ➔ sorted prefix; shift larger elements right, drop `temp` into gap.
- **Adaptive + online** ➔ best $O(n)$ (sorted) ➔ absorbs a new last element in one pass.
- **Invariant** ➔ prefix "sorted but **not final**" ➔ basis of [[Sorted List (ADT)|sorted-list `add`]]; strict `>` ⟹ stable.

### 5. Stability (Property)
- **Definition** ➔ equal keys keep input order; observable only sorting **by key**.
- **Universal fix** ➔ index-tag $k_i\to(k_i,i)$ ($O(n)$ space) ➔ why **radix** needs a stable subsort.
- **Bug vector** ➔ `>` vs `>=` is a one-character stability break.

### 6. Incrementality (Property)
- **Definition** ➔ small input change ➔ $O(1)$ rework (sorting's **online** analogue).
- **Insertion yes / Selection no** ➔ append-to-back ➔ one pass; "final" prefix blocks latecomers.
- **Graduate** ➔ frequent updates ➔ balanced [[Binary Tree]]/[[Heap]] ($O(\log n)$/update).

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
> [!code]- `selection_sort` + `find_min`
> ```python
> def selection_sort(the_list):
>     n = len(the_list)
>     for mark in range(n - 1):                  # leftmost unsorted position
>         min_index = find_min(the_list, mark)
>         the_list[mark], the_list[min_index] = the_list[min_index], the_list[mark]  # ONE swap
>
> def find_min(the_list, mark):
>     pos_min = mark
>     for i in range(mark + 1, len(the_list)):
>         if the_list[i] < the_list[pos_min]:
>             pos_min = i
>     return pos_min
> ```
> 💡 **Common Mistake:** **No early-exit path** ➔ comparisons are $\sum k$ regardless of input ⟹ no $O(n)$ best case; the long-distance swap makes it **unstable**.

### 🔹 Insertion Sort (adaptive, online)
> [!code]- `insertion_sort`
> ```python
> def insertion_sort(the_list):
>     n = len(the_list)
>     for mark in range(1, n):                   # first unsorted element
>         temp = the_list[mark]                  # 1. stash it
>         i = mark - 1
>         while i >= 0 and the_list[i] > temp:   # 2. shift larger prefix elems right
>             the_list[i + 1] = the_list[i]      #    (STRICT '>' => stable)
>             i -= 1
>         the_list[i + 1] = temp                 # 3. drop temp into the gap
> ```
> 💡 **Common Mistake:** **Flat "$O(n^2)$" hides the best case** ➔ on sorted input the `while` never fires ⟹ $O(n)$; the weak "sorted-not-final" invariant is what makes it **online**.

## ⚖️ Core Decision Matrix
*(complexity table — Best / Average / Worst Time, Space, Stability.)*

| Algorithm | Best | Average | Worst | Space | Stable | Distinctive trait |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Bubble Sort** (II) | $O(n)$ | $O(n^2)$ | $O(n^2)$ | $O(1)$ | **Yes** | adaptive; $\Theta(n^2)$ swaps |
| **Selection Sort** | $O(n^2)$ | $O(n^2)$ | $O(n^2)$ | $O(1)$ | No | only $\Theta(n)$ swaps |
| **Insertion Sort** | $O(n)$ | $O(n^2)$ | $O(n^2)$ | $O(1)$ | **Yes** | adaptive **and** online |
| [[Merge Sort]] | $O(n\log n)$ | $O(n\log n)$ | $O(n\log n)$ | $O(n)$ | **Yes** | guaranteed, stable, scratch |
| [[Quick Sort]] | $O(n\log n)$ | $O(n\log n)$ | $O(n^2)$ | $O(\log n)$ | No | in-place, fast in practice |
| [[Heapsort]] | $O(n\log n)$ | $O(n\log n)$ | $O(n\log n)$ | $O(1)$ | No | in-place + guaranteed |

> [!NOTE] **When It Flips:** choose an $O(n^2)$ sort when $n$ small (low overhead), nearly-sorted (insertion → $O(n)$), or writes dominate (selection's $\Theta(n)$ swaps); else $O(n\log n)$. All entries carry a $\times\,O(\text{CompEq})$ factor.

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
**Problem:** Derive the worst-case bound of the elementary sorts on reverse-sorted input.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{mark } k \text{ shifts up to } k \text{ elements} &\implies \text{total} = \sum_{k=1}^{n-1} k = \frac{n(n-1)}{2} \\
&= \frac{n^2-n}{2} = \Theta(n^2) \quad(\text{the [[Arithmetic Series]]})
\end{aligned}
$$
**Final Extracted Output:** worst case $= \Theta(n^2)$ for bubble/selection/insertion; bubble & insertion reach $O(n)$ best.

## 🧠 Active Recall
> [!FAQ]- Why must a correct sort satisfy *both* permutation and ordering?
> - **Hint:** Recognise that ordering alone admits element-loss bugs.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Permutation** forces the exact input multiset; **ordering** forces non-decreasing.
> > - **Why:** **Spec completeness** ➔ an ordered output that dropped/duplicated elements still "looks sorted" — only both clauses fully specify correctness.

> [!FAQ]- Bubble, selection, insertion are all $O(n^2)$ — on what grounds distinguish them?
> - **Hint:** Compare by adaptivity, swap count, stability, online-ness — not Big-O.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Selection** = $\Theta(n)$ swaps but never adaptive/unstable; **insertion** = adaptive + online + stable; **bubble** = adaptive + stable but $\Theta(n^2)$ swaps.
> > - **Why:** **Invariant strength** ➔ selection's "final prefix" blocks adaptivity/online use; insertion's "sorted-not-final" permits both.

> [!FAQ]- Prove the elementary sorts are $O(n^2)$, yet bubble/insertion reach $O(n)$ best.
> - **Hint:** Evaluate the nested-loop arithmetic series and identify the short-circuit.
> > [!SUCCESS]- Answer
> > - **Short answer:** Nested loops sum $\sum_{k=1}^{n-1} k = \tfrac{n^2-n}{2} = \Theta(n^2)$.
> > - **Why:** **Short-circuit** ➔ insertion's `while` never fires on sorted input; bubble's `swapped` flag exits after one clean pass ⟹ $O(n)$; selection has no such path.

> [!FAQ]- Sort 10M records by primary then secondary key in $O(n\log n)$ with stability — which algorithm, and how to stabilise quicksort if forced?
> - **Hint:** Match the stability requirement to the algorithm and know the index-tag trick.
> > [!SUCCESS]- Answer
> > - **Short answer:** Use **merge sort** (or Timsort) — guaranteed $\Theta(n\log n)$, naturally stable.
> > - **Why:** **Index tagging** ➔ sort on $(\text{key}, \text{original index})$ so ties break by input order ($O(n)$ space) — converts unstable quicksort to stable.
