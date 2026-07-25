---
unit: FIT1008
week: 9
parent: "[[Priority Queue (ADT)]]"
tags: [CS/DataStructures, SWE/OOP, CS/Complexity, Math/Discrete]
---
# [[Heap]]

**Context:** [[FIT1008_MOC]] · the efficient implementation of a [[Priority Queue (ADT)]] · backbone clustering its **bottom-up $\Theta(n)$ construction** · a complete binary tree under two [[Invariant|invariants]]

> [!abstract] Quick Revision
> - **🎯 Objective:** complete + heap-ordered binary tree ➔ $O(\log n)$ add/get_max — the array-backed priority queue.
> - **📦 Core Components:** **complete** ➔ balanced, height $\lfloor\log_2 n\rfloor$ | **heap-order** ➔ parent ≥ child | `add`→**rise**, `get_max`→**sink** | **build** bottom-up.
> - **⚡ Key Constraint:** ops $O(\log n)$, `peek` $O(1)$, **build $\Theta(n)$** (not $n\log n$) ➔ but only min/max, no arbitrary search.

## 📝 Core
### 1. The Heap (Two Invariants)
- **Complete** ➔ every level full except possibly the last, filled left-to-right ➔ balanced.
- **Heap-order** ➔ every node $\ge$ its children ➔ max at the root (min-heap is the dual).
- **Array representation** ➔ 1-indexed, no pointers: $\text{parent}=\lfloor i/2\rfloor$, $\text{children}=2i,2i{+}1$ ➔ cache-friendly vs a pointer [[Binary Tree]].

### 2. Operations (Rise / Sink)
- **`add`** ➔ append at $n{+}1$ then **rise** (swap up while > parent).
- **`get_max`** ➔ return index 1, move last leaf to root, shrink, then **sink**.
- **Sink rule** ➔ swap with the **larger** child (else a bigger sibling stays beneath); both ops are one root-to-leaf path ⇒ $O(\log n)$.

### 3. Bottom-Up Construction ($\Theta(n)$ Heapify)
- **Mechanism** ➔ `sink` each **internal** node right-to-left from $\lfloor n/2\rfloor$ to root (leaves are trivial heaps).
- **Cost** ➔ **$\Theta(n)$, not $O(n\log n)$** — sum of node heights $= 2^h-1-h = N-h = \Theta(N)$.
- **Boundary** ➔ requires all elements up front (**offline**); a stream must use `add`/rise ($O(\log n)$ each).

## ⚙️ Core Implementation
### 🔹 `rise` / `sink`
> [!code]- the two heap-repair primitives
> ```python
> def _rise(self, k):                         # add: swim up while > parent
>     while k > 1 and self.a[k] > self.a[k//2]:
>         self.a[k], self.a[k//2] = self.a[k//2], self.a[k]; k //= 2
>
> def _sink(self, k):                         # get_max: swim down, swap LARGER child
>     while 2*k <= self.n:
>         child = 2*k
>         if child < self.n and self.a[child+1] > self.a[child]: child += 1
>         if self.a[k] >= self.a[child]: break
>         self.a[k], self.a[child] = self.a[child], self.a[k]; k = child
> ```
> 💡 **Common Mistake:** **Swap with the larger child** ➔ the `child += 1` guard (careful at the only-child boundary `child < self.n`); swapping the smaller violates heap-order.

### 🔹 Bottom-up `build_heap`
> [!code]- $\Theta(n)$ heapify
> ```python
> def build_heap(an_array):                 # 1-indexed; cell 0 unused
>     a = [None] + list(an_array); n = len(an_array)
>     for i in range(n // 2, 0, -1):        # last internal node -> root; leaves already heaps
>         sink(a, i, n)                     # each sink: O(height of i)
>     return a
> ```
> 💡 **Common Mistake:** **Start at $\lfloor n/2\rfloor$, go downward** ➔ guarantees both subtrees of node $i$ are valid heaps when sunk, so one sink fixes $i$; inserting one-by-one is $O(n\log n)$.

## ⚖️ Core Decision Matrix
| Operation / Build | Complexity | Trigger / Note |
| :--- | :--- | :--- |
| `add` (rise) | $O(\log n)$ | one root-to-leaf path |
| `get_max` (sink) | $O(\log n)$ | one path |
| `peek` | $O(1)$ | the root |
| **build (bottom-up)** | $\Theta(n)$ | $\sum$ heights $= 2^h-1-h$ |
| build ($n$× `add`) | $O(n\log n)$ | each insert rises to the root |
| [[Heapsort]] | $O(n\log n)$ | in-place, $O(1)$ space, **unstable** |

> [!NOTE] **When It Flips:** a heap is always balanced + constant-space-per-element but supports only **min/max** (`search(x)` is $O(n)$) ➔ use a balanced [[Binary Tree|BST]] when you need search, ordered iteration, or predecessor/successor. Bottom-up build never dominates heapsort: $\Theta(n)+\Theta(n\log n)=\Theta(n\log n)$.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Prove bottom-up heap construction is $\Theta(n)$, not $\Theta(n\log n)$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
S = \sum_{j=0}^{h-1} j\,2^{\,h-1-j} \;\xrightarrow{\;2S-S\;}\; (2^{h-1}+\dots+2^0) - h = (2^h - 1) - h = N - h = \Theta(N)
\end{aligned}
$$
**Final Extracted Output:** build is $\Theta(N)$ — most nodes are near-leaves (sink $O(1)$); the $\log n$ height is paid by very few.

## 🧠 Active Recall
> [!FAQ]- Prove that building a heap from an arbitrary array is $O(n)$, not $O(n\log n)$.
> - **Hint:** Weight node heights by their counts.
> > [!SUCCESS]- Answer
> > - **Short answer:** Total $=\sum_h \frac{n}{2^{h+1}}O(h) = O(n\sum_h h/2^h)$, and $\sum_{h\ge0} h/2^h = 2$.
> > - **Why:** **Convergent series** ➔ $O(2n)=O(n)$; most nodes are leaves/near-leaves with tiny $h$, only the rare top nodes pay $O(\log n)$.

> [!FAQ]- Why start at index $\lfloor n/2\rfloor$ and go downward, and why `sink`?
> - **Hint:** Subtrees must be heaps before fixing their root.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\lfloor n/2\rfloor$ is the last internal node ➔ everything after is a leaf (trivial heap, skipped).
> > - **Why:** **Bottom-up ordering** ➔ iterating $\lfloor n/2\rfloor\to1$ makes both subtrees of $i$ valid heaps when sunk; `sink` (vs `rise`) because $i$ may be too small for its descendants.

> [!FAQ]- Both a heap and a balanced BST give $O(\log n)$ priority operations — when must you use the BST?
> - **Hint:** Heap-order locates only the extreme.
> > [!SUCCESS]- Answer
> > - **Short answer:** When you need **search of arbitrary keys**, **ordered iteration**, or **predecessor/successor**.
> > - **Why:** **Partial vs total order** ➔ a heap only enforces parent ≥ child ⟹ `search(x)` is $O(n)$; a BST maintains full key order ⟹ $O(\log n)$ search/insert/delete *and* min/max.
