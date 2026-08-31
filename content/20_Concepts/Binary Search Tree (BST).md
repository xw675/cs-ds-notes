---
unit: [FIT1008, FIT2004]
domain: A
week: [1, 8]
source: [applied]
parent: "[[Binary Tree]]"
tags: [CS/DataStructures, SWE/OOP, CS/Complexity]
aliases: [BST]
---
# [[Binary Search Tree (BST)]]

**Context:** [[FIT1008_MOC]] · a [[Binary Tree]] with an ordering [[Invariant]] · an alternative implementation of a [[Dictionary (ADT)]] · cost depends on balance

> [!abstract] Quick Revision
> - **🎯 Objective:** left < node < right invariant ➔ search becomes halving, cost $= O(\text{depth})$ — binary search made dynamic.
> - **📦 Core Components:** **search** ➔ go left/right | **insert** ➔ return-and-relink | **delete** ➔ three cases via in-order successor.
> - **⚡ Key Constraint:** $O(\log N)$ balanced, $O(N)$ degenerate ➔ good at search **and** insert/delete, and **ordered** (unlike a hash table).

## 📝 Core
### 1. The BST (Ordering Invariant)
- **Invariant** ➔ for every node, left-subtree keys **less**, right-subtree keys **greater** (keys **unique**).
- **Search halving** ➔ go left/right by comparison ➔ cost $\propto$ depth; key/item kept separate.
- **Balance dependency** ➔ balanced $\Rightarrow O(\log N)$, sorted-insert stick $\Rightarrow O(N)$; self-balancing = **AVL**/**red-black**/**2-3-4**.

### 2. Insert (Return-and-Relink)
- **Mechanism** ➔ recurse left/right by key; at the empty leaf position, create the node.
- **Critical return** ➔ **return `current` and re-assign the link on the way back** (`current.left = insert_aux(...)`, `self.root = insert_aux(...)`).
- **Duplicate** ➔ raise, or `current.item = item` for insert-or-update (`__setitem__`).

### 3. Delete (Three Cases via Successor)
- **Leaf** ➔ null the parent link · **one child** ➔ bypass · **two children** ➔ replace key/item with the **in-order successor** (one step right, then all the way left), then delete it — the successor has no left child, so its removal is the easy case, and the next-largest key preserves left<root<right.

### 4. Building the tree: $n$ insertions into an empty BST *(FIT2004)*
- **Worst case $\Theta(n^2)$** ➔ feed keys **already sorted** ➔ every key descends the growing right spine, the $i$-th insertion walking $i-1$ nodes ⟹ $\sum_{i=1}^{n}\Theta(i)=\Theta(n^2)$ ([[Arithmetic Series]]).
- **Best case $\Theta(n\log n)$** ➔ an arrival order that keeps the tree balanced ⟹ each insertion $\Theta(\log n)$.
- **Per-op worst × $n$ is only an UPPER bound** ➔ "each insertion is $O(n)$, so $n$ of them are $O(n^2)$" is valid but does **not** establish $\Theta(n^2)$; tightness needs a **witness input** on which the worst cases genuinely co-occur, which sorted input supplies. This is the degenerate-chain failure that motivates AVL/red-black balancing.

## ⚙️ Core Implementation
### 🔹 Search + Insert
> [!code]- `find_aux` (search) + `insert_aux` (return-and-relink)
> ```python
> class BinarySearchTreeNode(Generic[K, I]):
>     def __init__(self, key: K, item: I = None) -> None:
>         self.key = key; self.item = item; self.left = None; self.right = None
>
> def __contains__(self, key):                       # SEARCH
>     return self.find_aux(self.root, key)
> def find_aux(self, current, key):
>     if current is None:      return False          # base: empty -> not found
>     elif key == current.key: return True           # base: found
>     elif key < current.key:  return self.find_aux(current.left, key)
>     else:                    return self.find_aux(current.right, key)
>
> def insert_aux(self, current, key, item):
>     if current is None:
>         current = BinarySearchTreeNode(key, item)  # base: leaf position
>     elif key < current.key:
>         current.left  = self.insert_aux(current.left, key, item)
>     elif key > current.key:
>         current.right = self.insert_aux(current.right, key, item)
>     else:
>         raise ValueError("Inserting duplicate item")
>     return current                                 # <-- the crucial return
> ```
> 💡 **Common Mistake:** **`current = Node(...)` only rebinds the local** ➔ the new node is never attached; you must **return `current`** and re-assign the parent's link on the way back up.

### 🔹 Iterating a tree — explicit-stack preorder
> [!code]- stack-driven `__next__`
> ```python
> def __next__(self):                # preorder iterator: own stack, no 'next' link in a tree
>     if not self.stack: raise StopIteration
>     node = self.stack.pop()
>     if node.right: self.stack.push(node.right)   # push right THEN left
>     if node.left:  self.stack.push(node.left)    # so left is processed first
>     return node
> ```
> 💡 **Common Mistake:** **A tree has no single "next" link** ➔ an external [[Iterator]] keeps its own [[Stack (ADT)]]; push right then left to emit **preorder** (the [[Recursion|recursion→explicit-stack]] conversion).

## ⚖️ Core Decision Matrix
| Variant / Strategy | search | insert / delete | Ordered? | Note |
| :--- | :--- | :--- | :--- | :--- |
| **BST (balanced)** | $O(\log N)$ | $O(\log N)$ | **yes** | good at both; range/successor |
| **BST (degenerate)** | $O(N)$ | $O(N)$ | yes | sorted input → [[List (ADT)\|LinkList]] stick |
| [[Sorted List (ADT)\|sorted array]] | $O(\log N)$ | $O(N)$ shift | yes | fast search, slow insert |
| sorted [[List (ADT)\|linked list]] | $O(N)$ | $O(1)$ positioned | yes | fast insert, slow search |
| [[Hash Table]] | $O(1)$ expected | $O(1)$ expected | **no** | fastest, no order/range |

> [!NOTE] **When It Flips:** a BST is good at **both** search and insert/delete, unlike a sorted array/linked list (each wins one); vs a hash table it is slower per op but **traversable in key order** with range/predecessor/successor queries. Correctness = ops **maintain the BST invariant** (BST in ⟹ BST out).

## 📊 Exam Execution Trace

### Manual Execution Trace
Insert `5, 3, 8, 4, 7`, then delete `8` (one child `7`):

| Step / State | Trigger Op | Tree (parenthesised) Payload |
| :--- | :--- | :--- |
| **0 (Init)** | `init` | (empty) |
| 1 | insert 5 | `5` |
| 2 | insert 3 | `5(3,_)` |
| 3 | insert 8 | `5(3, 8)` |
| 4 | insert 4 | `5(3(_,4), 8)` |
| 5 | insert 7 | `5(3(_,4), 8(7,_))` |
| 6 | delete 8 | one child → bypass: `5(3(_,4), 7)` |

## ✍️ Practice
> [!QUESTION]- Practice 1: Insert $n$ items into an initially empty BST. Give the worst-case $\Theta$ time complexity, reasoning precisely.
> - **Hint:** An upper bound from per-op worst cases is not enough — you must exhibit an input that attains it.
> > [!SUCCESS]- Answer
> > - **Upper bound** ➔ with $i-1$ keys present the height is at most $i-1$, so insertion $i$ costs $O(i)$ ⟹ total $O\!\big(\sum_{i=1}^{n} i\big)=O(n^2)$.
> > - **Matching lower bound (the witness)** ➔ feed the keys in **strictly ascending order**: every key exceeds all present, descends the entire right spine, and costs exactly $\Theta(i)$ ⟹ $\sum_{i=1}^{n}\Theta(i)=\Omega(n^2)$.
> > - **Short answer:** upper meets lower ⟹ **worst case $\Theta(n^2)$**.
> > - **Why:** **Worst cases must be simultaneously achievable** ➔ multiplying "$n$ insertions" by "each is $O(n)$" is a legitimate ceiling, but a $\Theta$ claim asserts the ceiling is *reached*; sorted input is the construction that proves it.

## 🧠 Active Recall
> [!FAQ]- A recursive `insert_aux` that does `current = Node(key, item)` "finishes without modifying the tree" — why, and how is it fixed?
> - **Hint:** Local rebinding vs parent-link update.
> > [!SUCCESS]- Answer
> > - **Short answer:** assigning `current` only rebinds the local parameter ➔ the new node is never attached.
> > - **Why:** **Return-and-relink** ➔ return `current` from every branch and re-assign `current.left`/`self.root` on the way back up.

> [!FAQ]- How do you delete a two-child node while keeping the BST invariant, and why is the successor convenient?
> - **Hint:** The in-order successor's structure.
> > [!SUCCESS]- Answer
> > - **Short answer:** replace key/item with the **in-order successor** (min of the right subtree), then delete it.
> > - **Why:** **No left child** ➔ the next-largest key preserves ordering and the successor cannot have a left child, so its removal is the easy leaf/single-child case.

> [!FAQ]- BST ops are $O(\log N)$ best but $O(N)$ worst — what decides which?
> - **Hint:** Cost = depth.
> > [!SUCCESS]- Answer
> > - **Short answer:** cost $= O(\text{depth})$ — balanced gives $\log N$, a sorted-insert stick gives $O(N)$.
> > - **Why:** **Balance is the only variable** ➔ nothing about the search rule changes; only the shape the insertions produced, which is why self-balancing trees exist and why "any BST insertion" admits no single $\Theta$ ➔ [[Big-O Notation]].
