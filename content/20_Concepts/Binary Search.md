---
unit: FIT1008
domain: A
week: [1, 4]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Search, CS/Complexity]
---
# [[Binary Search]]

**Context:** [[FIT1008_MOC]] · the **decrease-and-conquer** search · contrast with [[Linear Search]] · powers `index` in [[Sorted List (ADT)|SortedArrayList]]

> [!abstract] Quick Revision
> - **🎯 Objective:** find a target in a sorted array by halving the window ➔ $\Theta(\log n)$, exponentially faster than linear search.
> - **📦 Core Components:** window $[lo,hi]$ ➔ probe midpoint ➔ discard half.
> - **⚡ Key Constraint:** needs **order** + **$O(1)$ random access** (no [[List (ADT)|LinkList]]); $\Theta(\log n)$ but can't insert/delete cheaply (a balanced [[Binary Tree]] can).

## 📝 Core
### 1. The Algorithm (Halve the Window)
- **Mechanism** ➔ keep window $[lo,hi]$, probe **midpoint**, discard half (match / keep $[mid{+}1,hi]$ / keep $[lo,mid{-}1]$).
- **Preconditions** ➔ **order** (so "too high/low" is meaningful) + **$O(1)$ random access** to the midpoint.

### 2. Why $\Theta(\log n)$ (the Invariant)
- **Halving** ➔ each pass is $O(1)$ and halves the window ⟹ $n/2^b=1 \Rightarrow b=\log_2 n$ passes.
- **Loop invariant** ➔ *if present, the target's index lies in $[lo,hi]$*; order justifies discarding a half; `hi-lo` strictly shrinks (termination).

## ⚙️ Core Implementation
### 🔹 `index` via binary search
> [!code]- `SortedArrayList.index`
> ```python
> def index(self, item: T) -> int:
>     low, high = 0, len(self) - 1
>     while low <= high:
>         mid = low + (high - low) // 2   # avoids (low+high) overflow in fixed-width ints
>         if self.array[mid] > item:
>             high = mid - 1              # discard right half
>         elif self.array[mid] == item:
>             return mid                  # found
>         else:
>             low = mid + 1               # discard left half
>     raise ValueError("item not in list")  # low > high => absent
> ```
> 💡 **Common Mistake:** **Use `mid = low + (high-low)//2`** ➔ `(low+high)//2` can **overflow** in fixed-width ints; and the data **must be sorted** or discarding a half is unjustified.

## ⚖️ Core Decision Matrix
| Aspect | Complexity | Why |
| :--- | :--- | :--- |
| Time — best | $O(\text{Comp})$ | target is the first midpoint |
| Time — worst/avg | $\Theta(\log n)\cdot\text{Comp}$ | window halves each pass |
| Space (iterative) | $O(1)$ | three indices |
| Space (recursive) | $O(\log n)$ | call stack |

> [!NOTE] **When It Flips:** vs [[Linear Search]] ($O(n)$) always better; vs [[Hash Table]] ($O(1)$ expected but unordered) binary search keeps order for predecessor/successor/range. A balanced [[Binary Tree]] is "binary search made dynamic" — $O(\log n)$ search **and** insert/delete, which a sorted array can't.

## 📊 Exam Execution Trace

### Manual Execution Trace
Search `15` in `[2,5,8,12,15,23,42,50]`:

| Step / State | Trigger Op | `[lo, hi]` | `mid` / `array[mid]` | Action |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | init | `[0, 7]` | — | — |
| 1 | probe | `[0, 7]` | 3 / 12 | 12 < 15 → `lo = 4` |
| 2 | probe | `[4, 7]` | 5 / 23 | 23 > 15 → `hi = 4` |
| 3 | probe | `[4, 4]` | 4 / 15 | **match → return 4** |

### Applied Exercise
**Problem:** Derive the $\Theta(\log n)$ bound.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{after } b \text{ passes: } \frac{n}{2^b} \text{ candidates} \;\Rightarrow\; \frac{n}{2^b}=1 \;\Rightarrow\; b = \log_2 n \;\Rightarrow\; \Theta(\log n)
\end{aligned}
$$
**Final Extracted Output:** halving ⟹ $\log_2 n$ passes of $O(1)$ ⟹ $\Theta(\log n)$ — vs linear search's $O(n)$.

## 🧠 Active Recall
> [!FAQ]- Why is binary search $\Theta(\log n)$, and why is that exponentially better than linear search?
> - **Hint:** Halving vs decrementing the candidate set.
> > [!SUCCESS]- Answer
> > - **Short answer:** Each pass discards half ⟹ $n/2^b=1$ gives $b=\log_2 n$ passes of $O(1)$.
> > - **Why:** **Halve vs decrement** ➔ [[Linear Search]] eliminates one element per step ($O(n)$) — ~20 vs 1,000,000 passes for a million elements.

> [!FAQ]- Binary search needs sorted data in an array — why each requirement, and what structure relaxes them while keeping $O(\log n)$?
> - **Hint:** Order justifies discarding; array gives the midpoint.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Sorted** lets you discard a half; **array** gives $O(1)$ midpoint access.
> > - **Why:** **Dynamic version** ➔ a balanced [[Binary Tree]] keeps $O(\log n)$ search *and* $O(\log n)$ insert/delete, which a sorted array ($O(n)$ inserts) cannot.

> [!FAQ]- Binary search is $\Theta(\log n)$; a hash table is $O(1)$ expected — when would you still choose binary search?
> - **Hint:** Ordered operations.
> > [!SUCCESS]- Answer
> > - **Short answer:** When you need predecessor/successor, range queries, or in-order iteration.
> > - **Why:** **Order preservation** ➔ binary search/BSTs keep key order; hashing scatters keys ($O(n\log n)$ to recover sorted order).
