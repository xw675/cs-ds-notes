---
unit: FIT1008
week: 4
parent: "[[List (ADT)]]"
tags: [CS/DataStructures, SWE/OOP, CS/Abstraction, CS/Complexity]
---
# [[Sorted List (ADT)]]

**Context:** [[FIT1008_MOC]] · a [[List (ADT)]] under a **sort [[Invariant]]** · backbone clustering its **SortedArrayList** implementation · the motivation for a balanced [[Binary Tree]]

> [!abstract] Quick Revision
> - **🎯 Objective:** list kept in value order ➔ fast $O(\log n)$ search, but user loses position choice (append/insert → add).
> - **📦 Core Components:** **Contract** ➔ `add` + faster `index` | **SortedArrayList** ➔ [[Binary Search]] search, shift-on-insert.
> - **⚡ Key Constraint:** array gives $O(\log n)$ *search* but $O(n)$ *insert* (shift) ➔ $O(\log n)$ for **both** needs a balanced [[Binary Tree]].

## 📝 Core
### 1. Sorted List Contract (Sort Invariant)
- **Sort invariant** ➔ a [[List (ADT)]] whose elements stay in increasing order ([[Invariant]]).
- **Op remap** ➔ `append`/`insert`/`__setitem__` **meaningless** ➔ replaced by a single **`add`**.
- **Not a List subclass** ➔ would break the `List` contract (`insert(i,x)` demands arbitrary placement) ➔ shared fields ≠ "is-a".

### 2. SortedArrayList (Array-Backed)
- **Storage substrate** ➔ fixed [[Array (Data Structure)]] + `length`, elements increasing.
- **Distinctive ops** ➔ `index` via [[Binary Search]] ($O(\log n)$) | `add` = find slot $O(\log n)$ + shift $O(n)$.
- **Shift dominates** ➔ `add` is $\Theta(n)$ unless the item belongs at the very end.

## ⚙️ Core Implementation
### 🔹 SortedArrayList — binary-search `index`, shift-on-`add`
> [!code]- `index` (binary search) + `add`
> ```python
> def index(self, item):                     # Binary Search: O(log n)
>     low, high = 0, len(self) - 1
>     while low <= high:
>         mid = low + (high - low) // 2
>         if self.array[mid] == item: return mid
>         elif self.array[mid] < item: low = mid + 1
>         else: high = mid - 1
>     raise ValueError("item not in list")
>
> def add(self, item):                       # find slot (O(log n)) + make space (O(n))
>     i = self.__index_to_add(item)          # binary-search insertion point
>     self.__make_space(i)                   # shift right (+ resize if full)
>     self.array[i] = item; self.length += 1
> ```
> 💡 **Common Mistake:** **$\log n$ search win is masked in `add`** ➔ the $\Theta(n)$ shift dominates; `add` is $O(\log n)$ only when the item lands at the end.

## ⚖️ Core Decision Matrix
| Variant / Strategy | `index` (search) | `add` | Ordered iteration | Cache / Note |
| :--- | :--- | :--- | :--- | :--- |
| **SortedArrayList** | $O(\log n)$ ([[Binary Search]]) | $O(\log n)$ find + **$O(n)$ shift** | $O(n)$ | random access enables binary search |
| sorted linked list | $O(n)$ (no random access) | $O(n)$ find + $O(1)$ splice | $O(n)$ | fast splice, can't binary-search |
| **balanced BST** | $O(\log n)$ | $O(\log n)$ | $O(n)$ | only one $O(\log n)$ for **both** |

> [!NOTE] **When It Flips:** the array can't make `add` cheap ($O(\log n)$ find but $O(n)$ shift); the sorted linked list is the inverse (slow find, fast splice). Only a **balanced [[Binary Tree]]** links a node in place ➔ $O(\log n)$ insert *and* search.

## 📊 Exam Execution Trace

### Manual Execution Trace
`add(15)` into `[4, 8, 23, 42]`:

| Step / State | Trigger Op | Action | Array Payload |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | start | add 15 | `[4, 8, 23, 42]` |
| 1 | binary-search slot | converge → index 2 | (between 8 and 23) |
| 2 | make-space (shift) | 23,42 moved ($\Theta(n)$) | `[4, 8, _, 23, 42]` |
| 3 | place | `length += 1` | `[4, 8, 15, 23, 42]` |

### Applied Exercise
**Problem:** Show why `add` is $\Theta(n)$ despite an $O(\log n)$ search.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{find slot} &= O(\log n) \quad(\text{binary search}) \\
\text{make space} &= \Theta(n)\;\text{worst (item first)} \;/\; O(1)\;\text{best (item last)} \\
\therefore\; \texttt{add} &= O(\log n) + \Theta(n) = \Theta(n) \quad(\text{shift dominates})
\end{aligned}
$$
**Final Extracted Output:** `add` $= \Theta(n)$ in general — the contiguous-block shift, not the search, is the bottleneck.

## 🧠 Active Recall
> [!FAQ]- Why is a SortedList modelled as a *separate* abstract class rather than a subclass of List?
> - **Hint:** Recognise the broken Liskov substitution.
> > [!SUCCESS]- Answer
> > - **Short answer:** The sort invariant makes `append`/`insert`/`__setitem__` **meaningless** ➔ a new `add` is required.
> > - **Why:** **Contract break** ➔ a subclass "implementing" `insert` by ignoring/ raising violates the `List` contract; shared *fields* ≠ "is-a".

> [!FAQ]- Binary search finds a slot in $O(\log n)$, yet `add` is $O(n)$ — explain, and name the structure that fixes it.
> - **Hint:** Separate find-slot from make-space.
> > [!SUCCESS]- Answer
> > - **Short answer:** `add` = find-slot $O(\log n)$ + **make-space $\Theta(n)$ shift**.
> > - **Why:** **Link-in-place** ➔ a balanced [[Binary Tree]] inserts in $O(\log n)$ by relinking a node, never shifting a contiguous block.

> [!FAQ]- Compare a sorted array and a sorted linked list for maintaining order under inserts.
> - **Hint:** Each is fast at one half, slow at the other.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Array** = $O(\log n)$ search / $O(n)$ insert; **linked** = $O(1)$ splice / $O(n)$ find.
> > - **Why:** **Random access dependency** ➔ binary search needs $O(1)$ midpoint (array only); the linked list can splice cheaply but can't binary-search — a balanced [[Binary Tree]] achieves $O(\log n)$ for both.
