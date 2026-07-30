---
unit: FIT1008
domain: A
week: 4
parent: "[[Linked Node Data Structure]]"
tags: [CS/DataStructures, SWE/OOP]
---
# [[Node]]

**Context:** [[FIT1008_MOC]] · the atomic unit of a [[Linked Node Data Structure]] · used by [[List (ADT)|LinkList]] · generalises to [[Binary Tree]]/graphs

> [!abstract] Quick Revision
> - **🎯 Objective:** hold one item + a link to the next node ➔ the building block of non-contiguous chains.
> - **📦 Core Components:** singly / doubly / circular / XOR variants ➔ item ref + $k$ link refs.
> - **⚡ Key Constraint:** $O(1)$ create/splice at a held node, but $O(i)$ to reach index $i$ (no random access) + pointer overhead.

## 📝 Core
### 1. The Node (Item + Link)
- **Composition** ➔ **one item** + a **link** to the next node ➔ chaining builds a list ending in `None`.
- **Enables** ➔ a [[Linked Node Data Structure]] — no contiguous block like an [[Array (Data Structure)]].
- **Generalises** ➔ [[Binary Tree]] (two links), graphs (many links); reaching node $i$ is $O(i)$, no `base + i*size` arithmetic.

### 2. Node Variants
- **Singly** ➔ one forward link ➔ minimal memory, no backward walk, $O(n)$ predecessor.
- **Doubly** ➔ `prev`+`next` ➔ $O(1)$ delete-given-node + backward walk, extra pointer.
- **Circular** ➔ last→head ➔ round-robin iteration.
- **XOR** ➔ `prev XOR next` in one field ➔ space hack that breaks GC.
- **Cost per node** ➔ 1 item ref + $k$ link refs ➔ heavy for tiny payloads; scattered allocation hurts **cache locality**.

## ⚙️ Core Implementation
### 🔹 `Node` and a chain
> [!code]- building `1 -> 2 -> 3`
> ```python
> class Node(Generic[T]):
>     def __init__(self, item: T = None) -> None:
>         self.item = item       # the value
>         self.link = None       # reference to next Node (None = end)
>
> head = Node(1); head.link = Node(2); head.link.link = Node(3)   # 1 -> 2 -> 3
> ```
> 💡 **Common Mistake:** **Pointer overhead + cache misses** ➔ a 1-byte payload may carry 8–16 bytes of pointers; separately-allocated nodes cache-miss per hop (~100× an array's sequential hit) even at the same $O(n)$.

## ⚖️ Core Decision Matrix
| Variant | Links | Buys | Costs |
| :--- | :--- | :--- | :--- |
| **Singly** | `next` | minimal memory | no backward walk, $O(n)$ predecessor |
| **Doubly** | `prev`+`next` | $O(1)$ delete-given-node, bidirectional | extra pointer, double updates |
| **Circular** | last→head | round-robin iteration | termination care |
| node vs [[Array (Data Structure)\|array slot]] | pointer | flexible growth, $O(1)$ splice | $O(i)$ access, poor cache |

> [!NOTE] **When It Flips:** $O(1)$ splice/relink at a held node vs $O(i)$ to reach an arbitrary position, plus per-node pointer overhead and poor locality — arrays win on access + cache, nodes win on growth + splicing.

## 📊 Exam Execution Trace

### Manual Execution Trace
Reaching the 3rd node (index 2):

| Step / State | Current | Hop cost |
| :--- | :--- | :--- |
| **0 (Init)** | `head` (item 1) | — |
| 1 | `head.link` (item 2) | $O(1)$ |
| 2 | `head.link.link` (item 3) | $O(1)$ |
| total | index 2 | $O(i)$ |

### Applied Exercise
**Problem:** Show why index access is $O(i)$, not $O(1)$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{array:}\;& \text{addr} = \text{base} + i\cdot\text{slot} \Rightarrow O(1) \\
\text{linked:}\;& \text{addresses unrelated} \Rightarrow \text{follow } i \text{ links} \Rightarrow O(i)
\end{aligned}
$$
**Final Extracted Output:** no address arithmetic ⟹ traversal is the only route ⟹ $O(i)$ — also why [[Binary Search]] can't run on a linked list.

## 🧠 Active Recall
> [!FAQ]- Compare singly-, doubly-, and circular-linked nodes by capability and cost.
> - **Hint:** Links bought vs pointers paid.
> > [!SUCCESS]- Answer
> > - **Short answer:** Singly = minimal, no backward, $O(n)$ predecessor; doubly = $O(1)$ delete-given-node + bidirectional at one extra pointer; circular = round-robin.
> > - **Why:** **Link layout = capability** ➔ each added link buys an operation and costs update work + memory.

> [!FAQ]- Why do linked nodes lose to arrays on cache performance even at equal Big-O?
> - **Hint:** Locality, not asymptotics.
> > [!SUCCESS]- Answer
> > - **Short answer:** Separately-allocated nodes scatter across the heap ⟹ ~cache miss per hop (~100× a hit).
> > - **Why:** **Contiguity** ➔ an array fetches neighbours per cache line + prefetch; pointer overhead (8–16 B) fits fewer payloads per line.

> [!FAQ]- Why is reaching the $i$-th node $O(i)$ rather than $O(1)$?
> - **Hint:** No address arithmetic.
> > [!SUCCESS]- Answer
> > - **Short answer:** Addresses are unrelated, so there's no `base + i*size` — follow $i$ links, each $O(1)$.
> > - **Why:** **No random access** ➔ this absence is exactly why [[Binary Search]] cannot run on a linked list.
