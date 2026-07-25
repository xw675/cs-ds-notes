---
unit: FIT1008
domain: A
week: 9
parent: "[[Heap]]"
tags: [CS/Algorithms, CS/Sorting, CS/Complexity, SWE/OOP]
---
# [[Heapsort]]

**Context:** [[FIT1008_MOC]] · sorts by repeatedly extracting from a [[Heap]] · the in-place specialisation of "[[Priority Queue (ADT)|PQueue]]-sort" · guaranteed-$O(n\log n)$ sibling of [[Quick Sort]]/[[Merge Sort]]

> [!abstract] Quick Revision
> - **🎯 Objective:** heapify the array, repeatedly extract-max to the shrinking tail ➔ selection sort with a fast find_max.
> - **📦 Core Components:** **build heap** ➔ $\Theta(n)$ bottom-up | **extract-max ×$n$** ➔ $O(\log n)$ `sink` each.
> - **⚡ Key Constraint:** **guaranteed $\Theta(n\log n)$** + **$O(1)$ space** (in-place) ➔ but **unstable** and cache-unfriendly.

## 📝 Core
### 1. The Algorithm (Heapify → Extract)
- **Mechanism** ➔ treat array as a [[Heap]] ➔ **heapify**, then repeatedly **extract-max** to the shrinking end.
- **Conceptual root** ➔ [[Sorting Problem|selection sort]] with an $O(\log n)$ `find_max` (not an $O(n)$ scan).
- **Direction** ➔ max-heap sorts **ascending** (max lands at tail); min-heap ➔ descending.

### 2. In-Place vs PQueue-Sort
- **PQueue-sort** ➔ add all $n$ to any [[Priority Queue (ADT)]], `get_max` ×$n$ ➔ needs $O(n)$ extra space.
- **In-place version** ➔ reuse the input array; each `get_max` frees one tail cell (the "hole") ➔ $O(1)$ extra.

### 3. Total Cost = $\Theta(n\log n)$
- **Build** ➔ [[Heap|bottom-up]] is $\Theta(n)$.
- **Extract** ➔ $n$ sinks cost $\Theta(n\log n)$ ➔ total $\Theta(n)+\Theta(n\log n)=\Theta(n\log n)$.
- **No best case** ➔ even pre-sorted input is not faster.

## ⚙️ Core Implementation
### 🔹 In-place `heapsort` (build + extract via `sink`)
> [!code]- `heapsort` with `sink` / `largest_child`
> ```python
> def heapsort(arr):                              # ascending, in place, 1-indexed
>     a = [None] + list(arr); n = len(arr)        # cell 0 unused (parent k//2, children 2k/2k+1)
>
>     def largest_child(k, size):                 # NOTE the size==2*k guard (only-child case)
>         if 2*k == size or a[2*k] > a[2*k+1]:
>             return 2*k
>         return 2*k + 1
>
>     def sink(k, size):
>         while 2*k <= size:                      # k has at least one child
>             c = largest_child(k, size)
>             if a[k] >= a[c]: break              # heap-order restored
>             a[k], a[c] = a[c], a[k]; k = c
>
>     for i in range(n//2, 0, -1):                # 1. build heap bottom-up: O(n)
>         sink(i, n)
>
>     size = n
>     while size > 1:                             # 2. extract-max n-1 times
>         a[1], a[size] = a[size], a[1]           #    max -> end ("the hole")
>         size -= 1
>         sink(1, size)                           #    restore over the shrunk heap: O(log n)
>     return a[1:]
> ```
> 💡 **Common Mistake:** **`2*k == size` guard is essential** ➔ without it a node with only a left child reads `a[2*k+1]` past the heap (`IndexError`); defend with testing, code review, proofs.

## ⚖️ Core Decision Matrix
*(Domain A complexity table — Best / Average / Worst Time, Space, Stability.)*

| Algorithm | Best | Average | Worst | Space | Stable | Trait |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Heapsort** | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $O(1)$ | No | guaranteed **and** in-place |
| [[Quick Sort]] | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n^2)$ | $O(\log n)$ | No | faster in practice (cache) |
| [[Merge Sort]] | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n)$ | **Yes** | guaranteed + stable |

> [!NOTE] **When It Flips:** pick **heapsort** when the worst-case *bound* + $O(1)$ space matter (real-time); **quicksort** when average speed wins (its `sink`'s non-local $k\to2k$ jumps thrash cache); **merge sort** when **stability** is required.

## 📊 Exam Execution Trace

### Manual Execution Trace
Extract phase on max-heap `[_,9,5,6,1,2]` (1-indexed):

| Step / State | Trigger Op | `size` | After `sink(1)` | Sorted Suffix | Return Payload |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | `build` | `5` | `9 5 6 1 2` | $-$ | $-$ |
| 1 | swap 9↔2 | `4` | `6 5 2 1` | `9` | `9` |
| 2 | swap 6↔1 | `3` | `5 1 2` | `6 9` | `6` |
| 3 | swap 5↔2 | `2` | `2 1` | `5 6 9` | `5` |
| 4 | swap 2↔1 | `1` | `1` | `2 5 6 9` → `1 2 5 6 9` | `2` |

### Applied Exercise
**Problem:** Show heapsort's total cost is $\Theta(n\log n)$ and the build never dominates.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
T(n) &= \underbrace{\Theta(n)}_{\text{bottom-up build}} + \underbrace{\sum_{k=1}^{n} \Theta(\log k)}_{n \text{ extractions}} \\
&= \Theta(n) + \Theta(n\log n) = \Theta(n\log n)
\end{aligned}
$$
**Final Extracted Output:** total $\Theta(n\log n)$ — the $\Theta(n)$ build is dominated by the $\Theta(n\log n)$ extraction phase.

## 🧠 Active Recall
> [!FAQ]- Heapsort and quicksort are both in-place. Given a hard real-time deadline, which and why?
> - **Hint:** Trade guaranteed bound against average speed.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Heapsort** — its $\Theta(n\log n)$ is a *guaranteed worst case*.
> > - **Why:** **Bound over average** ➔ [[Quick Sort]] degrades to $\Theta(n^2)$ on adversarial pivots (deadline blown); quicksort wins on average (cache-friendly) but not when the bound is the constraint.

> [!FAQ]- Explain heapsort as "selection sort, improved." What is improved, and how does the complexity change?
> - **Hint:** Identify the `find_max` upgrade.
> > [!SUCCESS]- Answer
> > - **Short answer:** Selection sort's $O(n)$ linear `find_max` becomes an $O(\log n)$ heap `sink`.
> > - **Why:** **Structure swap** ➔ $\sum O(n)=O(n^2)$ becomes $n\times O(\log n)=O(n\log n)$ — the heap makes the max cheap to retrieve.

> [!FAQ]- Why is heapsort's total $\Theta(n\log n)$ and not $\Theta(n\log n)$ *plus* a dominating build term?
> - **Hint:** Compare bottom-up build vs $n$ inserts.
> > [!SUCCESS]- Answer
> > - **Short answer:** Bottom-up build is $\Theta(n)$, dominated by the $\Theta(n\log n)$ extraction phase.
> > - **Why:** **Sum of heights** ➔ build is $\Theta(n)$ ([[Heap|Bottom-Up Heap Construction]]); $n$ successive `add`s would pay $\Theta(n\log n)$ to build — same total, but bottom-up is strictly cheaper.
