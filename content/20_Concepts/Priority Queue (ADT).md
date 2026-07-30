---
unit: FIT1008
domain: A
week: 9
parent: "[[Abstract Data Type (ADT)]]"
tags: [CS/DataStructures, SWE/OOP, CS/Complexity, CS/Abstraction]
---
# [[Priority Queue (ADT)]]

**Context:** [[FIT1008_MOC]] · a [[Queue (ADT)]] ordered by **importance, not arrival** · best implemented by a [[Heap]] · contrast linear impls

> [!abstract] Quick Revision
> - **🎯 Objective:** removal returns the highest-priority element ➔ FIFO [[Queue (ADT)]] is the special case where priority = waiting time.
> - **📦 Core Components:** `add` ➔ `get_max` ➔ `decrease_key` (for graph algorithms).
> - **⚡ Key Constraint:** every *linear* impl is stuck with one $O(N)$ op; only a [[Heap]] / balanced tree makes **both** $O(\log n)$.

## 📝 Core
### 1. The Priority Queue (Priority-Ordered Removal)
- **Mechanism** ➔ each element has a **priority**; removal returns the **highest** (or lowest — dual).
- **Core ops** ➔ `add(element)` and `get_max()` (remove-and-return the top).
- **No general search** ➔ elements comparable by priority; only the extreme is cheap.

### 2. Why a Heap (and `decrease_key`)
- **Both fast** ➔ linear structures trade `add` vs `get_max`; a [[Heap]] makes **both** $O(\log n)$ via partial (heap) order.
- **`decrease_key`** ➔ raise an element's priority ➔ used by **Dijkstra**/**Prim**.
- **Heap choice** ➔ binary heap: decrease-key $O(\log V)$ → Dijkstra $O((V+E)\log V)$; **Fibonacci heap:** $O(1)$ amortised → $O(E+V\log V)$ (optimal); **$d$-ary heap** tunes branching.

## ⚙️ Core Implementation
### 🔹 The interface
> [!code]- `add` / `get_max`
> ```python
> pq.add(element)     # enqueue with a priority
> top = pq.get_max()  # serve the most important; raises if empty
> ```
> 💡 **Common Mistake:** **Only the extreme is touched** ➔ a priority queue needs **no full ordering**; a heap's partial order gives $O(\log n)$ both ways, which a fully-sorted list ($O(n)$ insert) can't match.

## ⚖️ Core Decision Matrix
| Implementation | `get_max()` | `add` | `decrease_key` |
| :--- | :--- | :--- | :--- |
| Unsorted array / [[List (ADT)\|LinkList]] | $O(n)$ | $O(1)$ | $O(1)$ |
| Sorted array / list | $O(1)$ | $O(n)$ | $O(n)$ |
| Balanced BST ([[Binary Tree]]) | $O(\log n)$ | $O(\log n)$ | $O(\log n)$ |
| **Binary [[Heap]]** | $O(\log n)$ | $O(\log n)$ | $O(\log n)$ |
| Fibonacci heap | $O(\log n)$ amort. | $O(1)$ amort. | $O(1)$ amort. |

(all × $O(\text{CompEq})$.)

> [!NOTE] **When It Flips:** linear structures trade `add` vs `get_max`; only **non-linear** structures (heap, balanced tree) make both fast. Applications: Dijkstra/Prim, event-driven simulation, Huffman coding, OS scheduling, A* search.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Show why a sorted list can't replace a heap.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{sorted list}:\;& \texttt{get\_max}=O(1),\ \texttt{add}=O(n)\ (\text{find slot} + \text{shift}) \\
\text{heap}:\;& \texttt{get\_max}=\texttt{add}=O(\log n)\ (\text{partial order suffices})
\end{aligned}
$$
**Final Extracted Output:** the heap balances both ops at $O(\log n)$; the sorted list is stuck with one $O(n)$ operation.

## 🧠 Active Recall
> [!FAQ]- Dijkstra does $V$ inserts, $V$ extract-mins, $E$ decrease-keys — compare a binary vs Fibonacci heap and when the difference matters.
> - **Hint:** decrease-key cost dominates on dense graphs.
> > [!SUCCESS]- Answer
> > - **Short answer:** Binary: all $O(\log V)$ ⟹ $O((V+E)\log V)$; Fibonacci: decrease-key $O(1)$ amort. ⟹ $O(E+V\log V)$ (optimal).
> > - **Why:** **Dense wins** ➔ Fibonacci helps when $E\gg V$; on sparse graphs the binary heap's smaller constants usually win in practice.

> [!FAQ]- Why can't a priority queue just be a kept-sorted list?
> - **Hint:** Full order is overkill.
> > [!SUCCESS]- Answer
> > - **Short answer:** Sorted list gives $O(1)$ `get_max` but $O(n)$ `add` (find slot + shift).
> > - **Why:** **Partial order suffices** ➔ only the extreme is touched, so a heap's parent≥child order achieves $O(\log n)$ for *both*.

> [!FAQ]- A heap gives `get_max` in $O(\log n)$ but no efficient `search(x)` — why, and what if you need both?
> - **Hint:** Partial order locates only the extreme.
> > [!SUCCESS]- Answer
> > - **Short answer:** Parent≥child says nothing about where arbitrary $x$ sits ⟹ `search` is $O(n)$.
> > - **Why:** **Use a BST** ➔ a balanced BST (ordered map) gives $O(\log n)$ for min/max, search, insert, and delete alike.
