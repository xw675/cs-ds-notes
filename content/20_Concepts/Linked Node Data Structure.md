---
unit: FIT1008
domain: A
week: 4
parent: "[[Data Structure]]"
tags: [CS/DataStructures, CS/Complexity]
---
# [[Linked Node Data Structure]]

**Context:** [[FIT1008_MOC]] · the non-contiguous alternative to an [[Array (Data Structure)]] · made of [[Node]]s · realised as [[List (ADT)|LinkList]]

> [!abstract] Quick Revision
> - **🎯 Objective:** store a collection as a chain of [[Node]]s ➔ no contiguity, no random access; reach a position by walking links.
> - **📦 Core Components:** singly / doubly / circular / **sentinel** variants.
> - **⚡ Key Constraint:** $O(1)$ insert/delete **at a held node** vs $O(i)$ to **reach index $i$** — the exact mirror of an array.

## 📝 Core
### 1. The Structure (Chain, No Random Access)
- **Composition** ➔ chain of [[Node]]s, each item + a **link** to the next ➔ **not contiguous**, **no random access**.
- **Fundamental trade** ➔ $O(1)$ insert/delete **at a held node** (rewire links) vs $O(i)$ to **reach index $i$** ➔ arrays are the mirror image.

### 2. The Linked-List Family
- **Singly** ➔ $O(1)$ head, $O(n)$ tail/predecessor.
- **Doubly** ➔ `prev`+`next` ➔ $O(1)$ delete-given-node + $O(1)$ tail (with tail pointer) ➔ deque/LRU.
- **Circular** ➔ tail→head ➔ round-robin.
- **Sentinel** ➔ dummy head/tail nodes ➔ remove empty-list/head-insertion special cases (every real node has a predecessor).

## ⚖️ Core Decision Matrix
| Operation | [[Array (Data Structure)]] | Linked nodes |
| :--- | :--- | :--- |
| access index $i$ | $O(1)$ | $O(i)$ |
| insert/delete at a known node | $O(n)$ (shift) | $O(1)$ (relink) |
| insert/delete at index $i$ | $O(n)$ | $O(i)$ walk + $O(1)$ relink |
| memory | one block (+ spare); [[Dynamic Array Resizing]] | per-node pointer; grows freely |
| cache locality | excellent | poor (pointer chasing) |

> [!NOTE] **When It Flips:** prefer linked for frequent front/held-node insert-delete with little indexed access (stacks, queues, LRU caches, adjacency lists); prefer array for random access, binary search, cache-sensitive scans.

## 📊 Exam Execution Trace

### Manual Execution Trace
Insert at index $i$ decomposed:

| Step / State | Phase | Cost |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | walk head → node $i{-}1$ | $O(i)$ |
| 2 | rewire `new.link`, `prev.link` | $O(1)$ |
| total | insert-at-index | $O(i)$ |

## ⚠️ Common Mistakes
- 💡 **"$O(1)$ insert" needs the node in hand** ➔ reaching index $i$ first is still $O(i)$, so insert-at-index is $O(i)$, not $O(1)$.

## 🧠 Active Recall
> [!FAQ]- State the array-vs-linked trade-off across access, structural edits, and cache behaviour.
> - **Hint:** They optimise opposite operations.
> > [!SUCCESS]- Answer
> > - **Short answer:** Array = $O(1)$ access, $O(n)$ insert/delete, great locality; linked = $O(i)$ access, $O(1)$ held-node edit, poor locality.
> > - **Why:** **Contiguity vs pointers** ➔ array needs resizing to grow; linked grows a node at a time at one pointer per element.

> [!FAQ]- What do sentinel (dummy) nodes buy, and why are they used in production?
> - **Hint:** Remove edge cases.
> > [!SUCCESS]- Answer
> > - **Short answer:** Every *real* node always has a predecessor/successor ⟹ head insertion and empty-list handling stop being special cases.
> > - **Why:** **Fewer null checks** ➔ eliminates a class of off-by-one/null-pointer bugs at the cost of one or two extra nodes.

> [!FAQ]- Why can't binary search run on a linked list, and what's the consequence for a sorted one?
> - **Hint:** No $O(1)$ midpoint.
> > [!SUCCESS]- Answer
> > - **Short answer:** Reaching the middle is $O(n)$, so a sorted linked list stays $O(n)$ for search.
> > - **Why:** **Only splice survives** ➔ it keeps $O(1)$ splice once positioned; for lookups use a SortedArrayList or balanced BST.
