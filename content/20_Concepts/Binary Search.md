---
unit: [FIT1008, FIT2004]
domain: A
week: [2, 3, 4]
source: [lecture]
parent: "[[Divide and Conquer]]"
tags: [CS/Algorithms, CS/Search, CS/Complexity]
---
# [[Binary Search]]

**Context:** [[FIT1008_MOC]], [[FIT2004_MOC]] · the **decrease-and-conquer** search · contrast with [[Linear Search]] · powers `index` in [[Sorted List (ADT)|SortedArrayList]]
**FIT2004 emphasis:** the canonical **best $\ne$ worst** example — an early return exists, so $\Omega(1)$ / $O(\log N)$ cannot collapse into one $\Theta$; it is the *locate* half of [[Output-Sensitive Complexity]]; and W3 makes it the unit's **termination counter-example** ➔ [[Invariant]].

> [!abstract] Quick Revision
> - **🎯 Objective:** find a target in a sorted array by halving the window ➔ $\Theta(\log n)$, exponentially faster than linear search.
> - **📦 Core Components:** window $[lo,hi]$ ➔ probe midpoint ➔ discard half.
> - **⚡ Key Constraint:** needs **order** + **$O(1)$ random access** (no [[List (ADT)|LinkList]]); and the window must **strictly** shrink — the obvious `lo = mid` formulation loops forever.

## 📝 Core
### 1. The Algorithm (Halve the Window)
- **Mechanism** ➔ keep window $[lo,hi]$, probe **midpoint**, discard half (match / keep $[mid{+}1,hi]$ / keep $[lo,mid{-}1]$).
- **Preconditions** ➔ **order** (so "too high/low" is meaningful) + **$O(1)$ random access** to the midpoint.

### 2. Why $\Theta(\log n)$ (the Invariant)
- **Halving** ➔ each pass is $O(1)$ and halves the window ⟹ $n/2^b=1 \Rightarrow b=\log_2 n$ passes.
- **Loop invariant** ➔ *if the key exists in `array[0…N]`, it exists in `array[lo…hi]`* — the `if/else` is exactly what preserves it, and it is deliberately the **weakest** statement implying the postcondition.
- **Best $\ne$ worst, and why** ➔ the `return mid` short-circuits ⟹ best $\Theta(1)$ (target *is* the first midpoint), worst $\Theta(\log n)$ (target absent). Contrast [[Linear Search]]'s recursive form, which has no early exit on a miss.

### 3. The Termination Bug (why `lo = mid` hangs)
- **The naive form** ➔ `while lo < hi: mid = (lo+hi)//2; if key >= array[mid]: lo = mid else: hi = mid` — no early return, because `lo` is reused as the answer index.
- **The stall** ➔ at $lo{=}5,\;hi{=}6$: $mid=\lfloor 11/2\rfloor=5$, so `lo = mid` is a no-op ⟹ **no measure decreases**, the guard stays true, the loop spins forever.
- **The fix** ➔ `while lo < hi - 1`: with `hi` **exclusive**, the space may shrink to size $1$ and exit, `lo` holding the answer index.
- **Why it matters beyond the exam** ➔ a non-terminating branch is input-dependent, so it survives testing; the assignment harness kills the thread on timeout and the mark is lost.

### 4. Boundary Search (the range-reporting entry point)
- **Search for the boundary, not the value** ➔ to report everything in $(X,Y)$, binary-search the **smallest element $>X$** — $X$ itself need not be present.
- **Then scan** ➔ walk forward printing until an element $\ge Y$ ⟹ $\Theta(\log n + W)$ for $W$ reported items ➔ [[Output-Sensitive Complexity]].

## ⚙️ Core Implementation
### 🔹 `index` via binary search (inclusive `high`, early return)
> [!code]- `SortedArrayList.index`
> ```python
> def index(self, item: T) -> int:
>     low, high = 0, len(self) - 1
>     while low <= high:
>         mid = low + (high - low) // 2   # avoids (low+high) overflow in fixed-width ints
>         if self.array[mid] > item:
>             high = mid - 1              # discard right half -- STRICT shrink
>         elif self.array[mid] == item:
>             return mid                  # found
>         else:
>             low = mid + 1               # discard left half -- STRICT shrink
>     raise ValueError("item not in list")  # low > high => absent
> ```
> 💡 **Common Mistake:** **Use `mid = low + (high-low)//2`** ➔ `(low+high)//2` can **overflow** in fixed-width ints; and the data **must be sorted** or discarding a half is unjustified.

### 🔹 Boundary form (exclusive `hi`, no early return)
> [!code]- `binary_search` — the lecture's version, with the terminating guard
> ```python
> def binary_search(array, key):
>     # hi is EXCLUSIVE; we do not exit early because lo IS the answer index
>     lo, hi = 0, len(array)
>     while lo < hi - 1:                  # NOT `lo < hi` -- that never terminates
>         mid = (lo + hi) // 2
>         if key >= array[mid]:
>             lo = mid                    # keep [mid, hi)
>         else:
>             hi = mid                    # keep [lo, mid)
>     return lo if len(array) > 0 and array[lo] == key else -1
> ```
> 💡 **Common Mistake:** **`lo = mid` with guard `lo < hi`** ➔ at $hi = lo+1$ the midpoint *is* `lo`, so the assignment is a no-op ⟹ infinite loop. `mid + 1` or the `hi - 1` guard restores the strictly-decreasing variant.

## ⚖️ Core Decision Matrix
| Aspect | Complexity | Why |
| :--- | :--- | :--- |
| Time — best | $O(\text{Comp})$ | target is the first midpoint |
| Time — worst/avg | $\Theta(\log n)\cdot\text{Comp}$ | window halves each pass |
| Space (iterative) | $O(1)$ | three indices |
| Space (recursive) | $O(\log n)$ | call stack |

> [!NOTE] **When It Flips:** vs [[Linear Search]] ($O(n)$) always better; vs [[Hash Table]] ($O(1)$ expected but unordered) binary search keeps order for predecessor/successor/range queries and in-order iteration. A balanced [[Binary Tree]] is "binary search made dynamic" — $O(\log n)$ search **and** insert/delete, which a sorted array ($O(n)$ inserts) cannot.

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
$$
\text{after } b \text{ passes: } \frac{n}{2^b} \text{ candidates} \;\Rightarrow\; \frac{n}{2^b}=1 \;\Rightarrow\; b = \log_2 n \;\Rightarrow\; \Theta(\log n)
$$
**Final Extracted Output:** halving ⟹ $\log_2 n$ passes of $O(1)$ ⟹ $\Theta(\log n)$ — vs [[Linear Search]]'s $O(n)$, i.e. ~20 vs 1,000,000 passes on a million elements.

## 🧠 Active Recall
> [!FAQ]- Binary search needs sorted data in an array — why each requirement, and what structure relaxes them while keeping $O(\log n)$?
> - **Hint:** Order justifies discarding; array gives the midpoint.
> > [!SUCCESS]- Answer
> > - **Short answer:** **sorted** lets you discard a half; **array** gives $O(1)$ midpoint access.
> > - **Why:** **Dynamic version** ➔ a balanced [[Binary Tree]] keeps $O(\log n)$ search *and* $O(\log n)$ insert/delete, which a sorted array cannot.

> [!FAQ]- Binary search is $\Theta(\log n)$; a hash table is $O(1)$ expected — when would you still choose binary search?
> - **Hint:** Ordered operations.
> > [!SUCCESS]- Answer
> > - **Short answer:** when you need predecessor/successor, range queries, or in-order iteration.
> > - **Why:** **Order preservation** ➔ binary search/BSTs keep key order; hashing scatters keys ($O(n\log n)$ to recover sorted order).

> [!FAQ]- "The window shrinks every iteration, so it terminates." Where does that argument fail?
> - **Hint:** Shrinks, or *strictly* shrinks?
> > [!SUCCESS]- Answer
> > - **Short answer:** with `lo = mid` and $hi = lo+1$, the midpoint equals `lo`, so the window does **not** shrink and the loop never exits.
> > - **Why:** **A variant must strictly decrease** ➔ termination needs $hi-lo$ to drop by at least $1$ every iteration; use `lo = mid + 1`, or guard with `while lo < hi - 1` given an **exclusive** `hi` ➔ [[Invariant]].
