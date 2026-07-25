---
unit: FIT1008
week: 2
parent: "[[Data Structure]]"
tags: [CS/DataStructures, OOP/Python]
---
# [[Array (Data Structure)]]

**Context:** [[FIT1008_MOC]] · the contiguous archetype of a [[Data Structure]] · the storage behind [[Stack (ADT)|ArrayStack]], hash tables, heaps, dynamic lists

> [!abstract] Quick Revision
> - **🎯 Objective:** fixed-size contiguous block of equal-sized slots ➔ element $k$'s address is pure arithmetic, giving $O(1)$ access.
> - **📦 Core Components:** address arithmetic ➔ cache locality ➔ row-major multidim layout.
> - **⚡ Key Constraint:** $O(1)$ access but **fixed capacity** ($O(n)$ grow/copy) + $O(n)$ middle insert — mirror of a [[List (ADT)|LinkList]].

## 📝 Core
### 1. The Array (Contiguous, $O(1)$ Access)
- **Structure** ➔ fixed-size contiguous block of equal-sized slots ➔ element $k$'s address is arithmetic ⟹ **$O(1)$ access**.
- **`ArrayR`** ➔ FIT1008's fixed-size *referential* array (references to any object); slots start as shared `None`.
- **Boundary** ➔ **cannot be size 0** (hence `ArrayStack.MIN_CAPACITY = 1`).

### 2. Address Arithmetic & Locality
- **Formula** ➔ $\text{addr}(A[k]) = \text{base} + k\cdot\text{slot\_size}$ — one multiply-add, no scan.
- **Cache locality** ➔ a fetch loads a whole **cache line** (~64 B) ⟹ sequential access prefetches neighbours.
- **Multidim** ➔ **row-major** $\text{addr}(A[i][j])=\text{base}+(i\cdot\text{cols}+j)\cdot\text{slot\_size}$; column-major of a row-major array thrashes the cache.

## ⚙️ Core Implementation
### 🔹 `ArrayR` — fixed-size referential array
> [!code]- access / set / capacity
> ```python
> from referential_array import ArrayR
> array = ArrayR(4)        # fixed size 4, slots = None
> array[3] = value         # SET   — O(1)
> element = array[2]       # ACCESS — O(1): base + 2*slot_size
> length = len(array)      # capacity — O(1) (stored)
> ```
> 💡 **Common Mistake:** **Construction is $O(n)$, access is $O(1)$** ➔ `ArrayR(n)` initialises all $n$ slots (linear), but access computes one address; algorithms amortise the allocation over many constant-time accesses.

## ⚖️ Core Decision Matrix
| Operation | Complexity | Reason |
| :--- | :--- | :--- |
| access / set `array[i]` | $O(1)$ | address arithmetic |
| `len(array)` | $O(1)$ | stored |
| create `ArrayR(n)` | $O(n)$ | initialise $n$ slots |
| insert/delete in middle | $O(n)$ | shift elements |
| grow beyond capacity | $O(n)$ | reallocate + copy ([[Dynamic Array Resizing]]) |

> [!NOTE] **When It Flips:** $O(1)$ random access + cache-friendliness vs **fixed capacity** (growth = full copy) and $O(n)$ structural edits — the mirror image of a [[List (ADT)|LinkList]]. ADTs built on it: [[Stack (ADT)|ArrayStack]], [[List (ADT)|ArrayList]], [[Hash Table]], [[Heap]].

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Derive the 1-D and 2-D (row-major) address formulas.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{1-D:}\;& \text{addr}(A[k]) = \text{base} + k\cdot\text{slot\_size} \\
\text{2-D (row-major):}\;& \text{addr}(A[i][j]) = \text{base} + (i\cdot\text{cols} + j)\cdot\text{slot\_size}
\end{aligned}
$$
**Final Extracted Output:** consecutive $j$ are adjacent in memory ⟹ row-major (inner $j$) traversal is cache-optimal.

## 🧠 Active Recall
> [!FAQ]- Two $O(n)$ traversals — array vs linked list — differ several-fold in speed. Explain via the memory hierarchy.
> - **Hint:** Contiguity vs scatter.
> > [!SUCCESS]- Answer
> > - **Short answer:** Array elements are contiguous (cache-line fetch brings neighbours); linked nodes scatter ⟹ a cache miss per hop (~100×).
> > - **Why:** **Constant factor** ➔ same Big-O, but spatial locality wins big — a constant the asymptotic model omits.

> [!FAQ]- Why does iterating a 2-D array in the "wrong" order tank performance?
> - **Hint:** Row-major memory order.
> > [!SUCCESS]- Answer
> > - **Short answer:** Consecutive $j$ are adjacent; row-by-row (inner $j$) is sequential, column-by-column (inner $i$) jumps `cols` slots.
> > - **Why:** **Cache misses** ➔ column-major access misses on nearly every read — often an order-of-magnitude slowdown.

> [!FAQ]- Why is `ArrayR(n)` construction $O(n)$ but element access $O(1)$?
> - **Hint:** Initialise-all vs compute-one.
> > [!SUCCESS]- Answer
> > - **Short answer:** Construction initialises all $n$ slots (linear); access computes one address and reads it (constant).
> > - **Why:** **Amortisation** ➔ the linear allocation is spread over many $O(1)$ accesses.
