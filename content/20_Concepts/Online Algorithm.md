---
unit: FIT2004
domain: A
week: 3
source: [applied]
parent: "[[Algorithm]]"
tags: [CS/Algorithms, CS/Complexity]
aliases: [Online vs Offline Algorithm, Streaming Algorithm, Top-K Streaming]
---
# [[Online Algorithm]]

**Context:** [[FIT2004_MOC]] · the classification that decides **which algorithms are even admissible** — before complexity is discussed at all · drilled through the streaming **$k$-smallest** pattern, whose answer is a size-$k$ [[Heap]] · contrast the offline [[Quickselect]], which needs every item resident

> [!abstract] Quick Revision
> - **🎯 Objective:** process input **one item at a time**, committing without seeing the rest ➔ maintain the answer incrementally instead of computing it once at the end.
> - **📦 Core Components:** **offline** ➔ all $N$ items up front, may re-read freely | **online** ➔ item arrives, act, discard; $N$ may be unknown or unbounded.
> - **⚡ Key Constraint:** for the $k$-smallest, the heap is a **max**-heap, not a min-heap ➔ you need the **worst admitted item** at the root, because the root is the eviction threshold every arrival is tested against.

## 📝 How It Works
### 1. Online vs Offline
- **Offline** ➔ the whole input is available before the algorithm starts ⟹ it may scan repeatedly, sort, index, or partition destructively — [[Merge Sort]], [[Quickselect]], [[Heap|bottom-up `build_heap`]].
- **Online** ➔ items arrive sequentially and the algorithm must hold a **valid answer after every arrival** — [[Sorting Problem|insertion sort]], [[Heap|`add`/rise]], the size-$k$ heap below.
- **Why it matters** ➔ *(1)* the stream may exceed memory ⟹ $\Theta(N)$ space is unaffordable · *(2)* $N$ may be unknown or infinite ⟹ "sort it first" is not an option · *(3)* an answer may be required **now**, at every instant.
- **The classification precedes the bound** ➔ an offline $\Theta(N)$ algorithm is *worse than useless* on a stream while an online $\Theta(N\log k)$ one solves it — feasibility outranks asymptotics ➔ [[Algorithmic Complexity]].

### 2. The Streaming $k$-Smallest
- **Structure** ➔ a **max**-heap capped at size $k$, holding the $k$ smallest items seen so far.
- **Invariant** ➔ *after every arrival, the heap contains exactly the $k$ smallest items of the prefix seen so far, and its root is the largest of them.*
- **Admit** ➔ while the heap holds $<k$ items, insert unconditionally in $\Theta(\log k)$.
- **Test then act** ➔ once full, compare the arrival against the **root** only: arrival $\ge$ root ⟹ **reject in $O(1)$** · arrival $<$ root ⟹ `get_max` to evict, then `add` ⟹ $\Theta(\log k)$.
- **Why the root alone decides** ➔ the root is the **largest** of the current $k$ smallest, i.e. the weakest member. An arrival $\ge$ root is $\ge$ **all** $k$, so it cannot displace any; an arrival $<$ root displaces exactly one, and the root is unambiguously it. Comparing against the other $k-1$ is redundant.
- **The mirror** ➔ $k$ **largest** ⟹ **min**-heap of size $k$. Always heap on the **opposite** extreme to the one you are collecting.
- **Answering "the $k$-th smallest"** ➔ it is the root at termination; the heap yields the whole $k$-set for free, which [[Quickselect]] does not.

### 3. Cost Profile
- **Time $\Theta(N\log k)$** ➔ each arrival costs $O(1)$ to reject or $\Theta(\log k)$ to admit; the reject path dominates once the heap has settled on small values.
- **Space $\Theta(k)$, independent of $N$** ➔ the property that makes the algorithm online at all.
- **Single pass** ➔ each item is examined exactly once and then discarded — the formal statement of "online".

## ⚙️ Core Implementation
### 🔹 Streaming $k$-smallest with a size-$k$ max-heap
> [!code]- `k_smallest_online` — one pass, $O(1)$ rejection, no library calls
> ```python
> def k_smallest_online(stream, k):
>     heap = MaxHeap()                      # add -> rise, get_max -> sink
>     for item in stream:                   # ONE pass; stream length may be unknown
>         if heap.length < k:
>             heap.add(item)                # fill phase: O(log k)
>         elif item < heap.peek_max():      # ONE comparison against the threshold
>             heap.get_max()                # evict the current worst
>             heap.add(item)                # O(log k) only when it actually wins
>         # else: item >= root -> cannot beat any of the k -> DISCARD in O(1)
>     return heap                           # the k smallest; root = the k-th smallest
> ```
> 💡 **Common Mistake:** **Reaching for a min-heap because the goal says "smallest"** ➔ a min-heap exposes the *best* item at the root, which tells you nothing about who to evict; you would scan all $k$ to find the worst, making every arrival $\Theta(k)$.

## ⚖️ Core Decision Matrix
| Strategy | Time | Auxiliary space | Online? | Selection rule |
| :--- | :--- | :--- | :--- | :--- |
| Sort, take first $k$ | $\Theta(N\log N)$ | $\Theta(N)$ | No | the sorted list is wanted anyway |
| [[Quickselect]] | $\Theta(N)$ expected | $O(1)$ | **No** — must partition all $N$ | $N$ resident, one rank, mutation allowed |
| **Size-$k$ max-heap** | $\Theta(N\log k)$ | $\Theta(k)$ | **Yes** | $N$ unknown/unbounded, or $k\ll N$ with a memory cap |
| Full [[Heap]] of $N$, extract $k$ | $\Theta(N+k\log N)$ | $\Theta(N)$ | No | $k$ close to $N$, all items resident |
| Sorted array, insert each arrival | $\Theta(Nk)$ | $\Theta(k)$ | Yes | $k$ tiny (2–3), where shifting beats heap overhead |

> [!NOTE] **When It Flips:** with all $N$ resident and one rank wanted, [[Quickselect]]'s $\Theta(N)$ beats $\Theta(N\log k)$ — take it. The heap wins the moment **either** premise fails: unbounded $N$, a memory cap, or a requirement that the answer be valid at every instant. At $k=N$ the heap degenerates to $\Theta(N\log N)$, i.e. [[Heapsort]] — so $k\ll N$ is the operating assumption.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
Stream $7, 2, 9, 1, 5, 8, 3$ with $k=3$. Heap contents shown as a set; only the root is ordered.

| Step | Arrival | vs root | Action | Heap after | Root (threshold) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — | $\{\,\}$ | — |
| 1 | $7$ | — | fill | $\{7\}$ | $7$ |
| 2 | $2$ | — | fill | $\{7,2\}$ | $7$ |
| 3 | $9$ | — | fill (now full) | $\{9,7,2\}$ | $9$ |
| 4 | $1$ | $1<9$ | evict $9$, add $1$ | $\{7,2,1\}$ | $7$ |
| 5 | $5$ | $5<7$ | evict $7$, add $5$ | $\{5,2,1\}$ | $5$ |
| 6 | $8$ | $8\ge5$ | **reject, $O(1)$** | $\{5,2,1\}$ | $5$ |
| 7 | $3$ | $3<5$ | evict $5$, add $3$ | $\{3,2,1\}$ | $3$ |

**Final:** $\{1,2,3\}$, root $3$ = the $3$rd smallest. The threshold is **monotonically non-increasing** after the fill phase, so rejections get cheaper as the stream runs.

### Applied Exercise
**Problem:** A sensor emits $N=10^{9}$ readings; report the $k=100$ smallest under a memory cap forbidding storage of the stream.
$$
\begin{aligned}
\text{sort-then-take} &: \Theta(N\log N),\ \Theta(N) \text{ space} \;\Longrightarrow\; \textbf{infeasible} \\
\text{quickselect} &: \Theta(N) \text{ time, but requires all } N \text{ resident} \;\Longrightarrow\; \textbf{infeasible} \\
\text{size-}k \text{ max-heap} &: \Theta(N\log k)=\Theta(10^{9}\times 7),\quad S_{\text{aux}}=\Theta(100)
\end{aligned}
$$
**Final Extracted Output:** the size-$k$ max-heap — the only candidate whose space is $\Theta(k)$ rather than $\Theta(N)$. Note the winner is asymptotically **slower** than [[Quickselect]]; the constraint that selects it is space and the online requirement, not speed.

## ⚠️ Common Mistakes
- 💡 **Calling [[Quickselect]] online because it is fast** ➔ it partitions the entire array, so it needs every item before it can emit anything; $\Theta(N)$ time does not make an algorithm streamable.
- 💡 **Comparing the arrival against all $k$ heap items** ➔ destroys the $O(1)$ reject path; the heap exists precisely so that **one** comparison suffices.
- 💡 **Quoting $\Theta(N\log N)$** ➔ the heap is capped at $k$, so operations cost $\Theta(\log k)$; it only degenerates when $k=\Theta(N)$.

## 🧠 Active Recall
> [!FAQ]- To collect the $k$ **smallest** items you use a **max**-heap. Justify the inversion, and state the invariant it maintains.
> - **Hint:** Ask which item you need constant-time access to — the best or the worst.
> > [!SUCCESS]- Answer
> > - **Short answer:** the repeated operation is **eviction of the worst admitted item**, so the worst must be at the root. Invariant: *the heap holds exactly the $k$ smallest of the prefix seen so far*, with the root as their maximum.
> > - **Why:** **The root is the admission threshold** ➔ an arrival $\ge$ root is $\ge$ all $k$, so the $k$ smallest are unchanged and rejection preserves the invariant; an arrival $<$ root belongs in the new $k$ smallest and the old root does not, so the swap preserves it. No third case exists, so one comparison is necessary **and** sufficient. A min-heap would expose the global smallest — an item you never touch — and force a $\Theta(k)$ scan for the victim ➔ [[Invariant]].

> [!FAQ]- Which of insertion sort, [[Merge Sort]] and [[Heap|bottom-up `build_heap`]] are online, and what does that predict about their use on a stream?
> - **Hint:** Ask whether each holds a valid answer after every single arrival.
> > [!SUCCESS]- Answer
> > - **Short answer:** **insertion sort is online**; merge sort and bottom-up heap construction are **offline**.
> > - **Why:** **Incrementality** ➔ insertion sort absorbs a new last element in one pass while keeping the prefix sorted throughout ➔ [[Sorting Problem]]. Merge sort must split the whole array before combining anything, and $\Theta(n)$ `build_heap` requires all elements placed before sinking begins — on a stream it must be replaced by $n$ online `add` calls at $\Theta(n\log n)$ ➔ [[Heap]].
