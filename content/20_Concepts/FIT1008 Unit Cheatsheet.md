---
unit: FIT1008
domain: A
parent: "[[FIT1008_MOC]]"
tags: [CS/Algorithms, CS/DataStructures]
type: cheatsheet
aliases: [FIT1008 Exam Crib, Algorithms Cheatsheet]
---
# [[FIT1008 Unit Cheatsheet]]

**Context:** [[FIT1008_MOC]] · the WHOLE unit in one re-read — complexity (W1) → ADTs (W2–5) → recursion + sorts (W6–7) → trees, heaps, hashing (W8–11). Mid-sem test = W1–5; exam = everything, weighted to W6–11.

> [!abstract] Quick Revision
> - **🎯 Objective:** every exam question reduces to ➔ state the invariant, pick the implementation, justify with a Best/Worst complexity bound.
> - **⚡ Key Constraint:** array vs linked are MIRROR images — random access vs structural edit; every ADT decision question is this trade-off wearing a costume.

## 1️⃣ Foundations & Complexity (W1)
- **Algorithm** ➔ finite, well-defined, halts, correct I/O; **total correctness = invariant (partial) + variant (termination)**. Invariant proof = initialization → maintenance → termination.
- **Problem vs algorithm bounds** ➔ **lower bound belongs to the PROBLEM** (comparison sorting $\Omega(n\log n)$ — no algorithm beats it); upper bound is exhibited by a specific algorithm; matching them proves optimality.
- **Big-O algebra** ➔ keep dominant term, drop constants; $O$ = upper, $\Omega$ = lower, $\Theta = O \cap \Omega$; unqualified "complexity" = **worst case**. Ladder: $1 \prec \log n \prec n \prec n\log n \prec n^2 \prec 2^n$; polynomial vs exponential = the tractability frontier.
- **Arithmetic series** ➔ $\sum_{k=1}^{n-1}k = \frac{n(n-1)}{2} = \Theta(n^2)$ — WHY a shrinking nested loop is quadratic, not linear.
- **Search** ➔ linear $O(n)$, works on any iterable, no precondition · binary $\Theta(\log n)$, needs **sorted + $O(1)$ random access** (never on a LinkList).

## 2️⃣ ADT Master Table (W2–5)
**ADT = contract (values + operations + invariant), implementation fixes the cost.** Same interface, opposite cost profiles — the exam question is always "which implementation for THIS workload".

| ADT ➔ discipline | Implementation | Costs (the discriminators) |
| :-- | :-- | :-- |
| [[Stack (ADT)]] ➔ LIFO, top only | ArrayStack | all ops $O(1)$; fixed capacity or amortised grow; wasted slack |
|  | LinkStack | all ops $O(1)$; never full; one pointer/node overhead — crossover ≈ half-full array |
| [[Queue (ADT)]] ➔ FIFO, two moving ends | LinearQueue | $O(1)$ but **leaks space** (front creeps) |
|  | CircularQueue | mod-arithmetic ring, $O(1)$, no waste |
|  | LinkQueue | front+rear pointers, $O(1)$, unbounded |
| [[List (ADT)]] ➔ any position | ArrayList | `__getitem__` $O(1)$ · insert/delete $O(n)$ shift · append $O(1)$ **amortised** |
|  | LinkList | reach index $i$ = $O(i)$ · relink at held node $O(1)$ |
| [[Sorted List (ADT)]] ➔ value order | SortedArrayList | search $O(\log n)$ (binary) · **insert $O(n)$** (shift) — both $O(\log n)$ needs a balanced tree |
| [[Set (ADT)]] ➔ membership + algebra | ArraySet | any type, $O(N)$ scans |
|  | BVSet ([[Bit Vector]]) | ints only; $O(1)$ ops, word-parallel $\cup\cap\setminus$; cost scales with **universe**, not count |

- **Dynamic resizing** ➔ grow by a **constant factor** ⟹ append $O(1)$ amortised (single append can be $O(N)$); **additive growth fails** — $\Theta(n^2)$ total.
- **Slicing** ➔ Python slice **copies** ($O(k)$ time+space); NumPy slices are $O(1)$ views.
- **Iterators (W5)** ➔ [[Iterable]] `__iter__` returns a fresh [[Iterator]] (`__next__` or `StopIteration`); $O(1)$ per step, $O(1)$ space, **single-use**, fail-fast on mutation. LinkListIterator = $O(1)$ mutate-in-traversal. [[Generator Expression]] = lazy, $O(1)$ memory, no `len`/indexing.

## 3️⃣ Recursion (W6)
- **Anatomy** ➔ base case + recursive call + **convergence to base** + combine; correctness by induction, cost by recurrence.
- **Stack hazard** ➔ $\Theta(\text{depth})$ frames, **no Python TCO** ⟹ overflow; fix forward with an **accumulator**, or backward with an explicit [[Stack (ADT)]].
- **[[Tower of Hanoi]]** ➔ move $n{-}1$ aside · move bottom · restack ⟹ exactly $2^n - 1$ moves $= \Theta(2^n)$, provably optimal; stack depth only $\Theta(n)$.
- **[[Divide and Conquer]] depth rule** ➔ balanced halves → $\Theta(n\log n)$; lopsided split → $\Theta(n^2)$; single-half recurse → $\Theta(\log n)$.

## 4️⃣ Sorting Suite (W1 basics + W7 recursive + W9 heapsort)
| Sort | Best | Worst | Space | Stable | The one thing to say |
| :-- | :-- | :-- | :-- | :-- | :-- |
| Bubble | $\Theta(n)$ (adaptive) | $\Theta(n^2)$ | $O(1)$ | ✔ | swap-heavy; early-exit flag gives the $\Theta(n)$ best |
| Selection | $\Theta(n^2)$ | $\Theta(n^2)$ | $O(1)$ | ✘ | only $\Theta(n)$ **swaps** — never adaptive |
| Insertion | $\Theta(n)$ (adaptive) | $\Theta(n^2)$ | $O(1)$ | ✔ | **online**; best on nearly-sorted |
| Merge | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $\Theta(n)$ scratch | ✔ (ties left-first) | trivial split / heavy combine; guaranteed every case |
| Quick | $\Theta(n\log n)$ | $\Theta(n^2)$ bad pivots | $O(\log n)$ stack | ✘ | heavy split / trivial combine; in-place, smallest constants; **pivot is the whole game** |
| Heap | $\Theta(n\log n)$ | $\Theta(n\log n)$ | $O(1)$ | ✘ | selection sort with a fast find_max; guaranteed + in-place, cache-unfriendly |

- **Correctness = permutation + ordering** — both clauses, or the answer is incomplete.

## 5️⃣ Trees, Heaps, Hashing (W8–11)
- **[[Tree]]** ➔ connected + acyclic, $n$ nodes ⟹ $n-1$ edges; **every structural op is $O(\text{height})$** — $\Theta(\log n)$ balanced, $\Theta(n)$ degenerate. Traversals (pre/in/post DFS + level BFS) all $\Theta(n)$.
- **[[Binary Search Tree (BST)]]** ➔ invariant left < node < right; search = halving; insert = return-and-relink; delete = 3 cases via **in-order successor**. Sorted input ⟹ degenerate "stick" $O(n)$. vs hash table: $O(\log n)$ but **ordered** (range/successor queries).
- **[[Heap]]** ➔ complete (height $\lfloor\log_2 n\rfloor$, array-backed: children of $i$ at $2i,2i{+}1$) + heap-order (parent ≥ child). `add` → **rise**; `get_max` → **sink**; peek $O(1)$; **bottom-up build $\Theta(n)$, NOT $n\log n$**. Only min/max — no arbitrary search.
- **[[Priority Queue (ADT)]]** ➔ every linear implementation has one stuck $O(N)$ op; only heap/balanced tree gets **both** add and get_max to $O(\log n)$. FIFO queue = PQ where priority = waiting time.
- **[[Dictionary (ADT)]]** ➔ keyed lookup: hash-backed $O(1)$ expected, unordered · tree-backed $O(\log n)$, ordered.
- **[[Hash Table]]** ➔ key → index; expected $\Theta(1+\alpha)$, worst $O(n)$; hinges on uniform hash + bounded load factor $\alpha$ (rehash trigger). Collision resolution: chaining vs open addressing/linear probing (clustering hazard).

## ⚠️ Top Cross-Unit Traps
- 💡 **"$O(1)$ insert" needs the node in hand** ➔ LinkList insert-at-index is $O(i)$ walk + $O(1)$ relink = $O(i)$.
- 💡 **Amortised ≠ every-call** ➔ one append may cost $O(N)$; the SEQUENCE averages $O(1)$ — say "amortised" explicitly.
- 💡 **Binary search on a LinkList** ➔ invalid — no $O(1)$ random access; the $\log n$ dies in the walk.
- 💡 **Heap build $\Theta(n)$** ➔ writing $n\log n$ for bottom-up heapify is the classic W9 deduction.
- 💡 **Invariant proves partial correctness only** ➔ termination needs a separate variant (strictly decreasing, non-negative).
- 💡 **No magic methods in answers** ➔ Domain A rule: raw index/pointer code, never `.sort()`/`min()`/`sum()`.
