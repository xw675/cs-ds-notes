---
unit: FIT1008
week: 8
parent: "[[Tree]]"
tags: [CS/DataStructures, OOP/Python, CS/Algorithms, CS/Complexity]
---
# [[Binary Tree]]

**Context:** [[FIT1008_MOC]] · a [[Tree]] where each node has $\le 2$ children · backbone clustering **Traversal** (pre/in/post/level) and the **Expression Tree** specialisation · a complete one is a [[Heap]]

> [!abstract] Quick Revision
> - **🎯 Objective:** tree with ≤ 2 children per node ➔ ops are $O(\text{height})$, so balance decides $O(\log n)$ vs $O(n)$.
> - **📦 Core Components:** **shape families** ➔ full/complete/perfect/balanced | **traversals** ➔ pre/in/post (DFS) + level (BFS) | **Expression Tree** ➔ operators inner, operands leaves.
> - **⚡ Key Constraint:** all traversals $O(n)$; structural ops $O(h)$ ➔ $\Theta(\log n)$ balanced, $\Theta(n)$ degenerate (sorted-input "stick").

## 📝 Core
### 1. The Binary Tree (Shape & Balance)
- **Structure** ➔ each node has `left`, `right` links to child **nodes**; ops cost $O(\text{height})$.
- **Shape families** ➔ **full** (0/2 children) | **complete** (last level filled left = [[Heap]] shape) | **perfect** ($N=2^{k+1}-1$) | **balanced** (heights differ $\le 1$ ⇒ $\Theta(\log N)$).
- **Balance dependency** ➔ same $N$ keys form wildly different heights by **insertion order**; sorted input ➔ height-$N$ stick ($O(N)$, like a [[List (ADT)|LinkList]]).

### 2. Traversals (DFS + BFS)
- **DFS orders** ➔ **preorder** (root,L,R) | **inorder** (L,root,R) | **postorder** (L,R,root) — differ only in *when the root is processed*.
- **Level-order** ➔ BFS by levels using a [[Queue (ADT)]].
- **Uses + reconstruction** ➔ preorder serialises; **inorder of a BST = sorted**; postorder = RPN/free; **(pre+in)** or **(post+in)** is unique, **pre+post is not**.

### 3. Expression Tree (Parse Tree)
- **Structure** ➔ **operands = leaves**, **operators = inner nodes**; compilers build them.
- **Notation by traversal** ➔ preorder→**prefix** | inorder→**infix** (drops brackets) | postorder→**postfix/RPN**.
- **Ordering principle** ➔ by **expression structure**, not by key (unlike a [[Binary Search Tree (BST)]]).

## ⚙️ Core Implementation
### 🔹 Node + recursive size
> [!code]- `BinaryTreeNode` / `BinaryTree`
> ```python
> class BinaryTreeNode(Generic[T]):
>     def __init__(self, item: T = None) -> None:
>         self.item, self.left, self.right = item, None, None   # links to child NODES
>
> class BinaryTree(Generic[T]):
>     def __init__(self) -> None: self.root = None
>     def __len__(self) -> int: return self._len(self.root)
>     def _len(self, c) -> int:
>         return 0 if c is None else 1 + self._len(c.left) + self._len(c.right)
> ```
> 💡 **Common Mistake:** **`left`/`right` are node links, not subtree objects** ➔ the subtree is implied by following links; a perfect tree of height $k$ has $N=2^{k+1}-1$ ⇒ $k=\Theta(\log N)$.

### 🔹 Traversals (recursive DFS + queue-based BFS)
> [!code]- `inorder_aux` / `level_order`
> ```python
> def inorder_aux(self, current, f):          # left, ROOT, right
>     if current is not None:
>         self.inorder_aux(current.left, f)
>         f(current.item)
>         self.inorder_aux(current.right, f)
>
> def level_order(self, f):                   # BFS — uses a Queue, not recursion
>     q = Queue(); q.append(self.root)
>     while not q.is_empty():
>         node = q.serve()
>         if node is not None:
>             f(node.item); q.append(node.left); q.append(node.right)
> ```
> 💡 **Common Mistake:** **DFS recursion is $O(h)$ implicit stack** ➔ convert to an explicit [[Stack (ADT)]], or **Morris traversal** does inorder in $O(1)$ space by threading links; the [[Higher-Order Function]] `f` lets one traversal serve many tasks.

### 🔹 Expression Tree — traversal ⟷ notation
> [!code]- the three readings of `(1/3) + ((6*7)/4)`
> ```text
>               +
>            /     \
>          / \     / \
>         1   3   *   4
>                / \
>               6   7
> Preorder  (root,left,right)  ->  PREFIX:   + / 1 3 / * 6 7 4
> Inorder   (left,root,right)  ->  INFIX:    1 / 3 + 6 * 7 / 4
> Postorder (left,right,root)  ->  POSTFIX:  1 3 / 6 7 * 4 / +   (RPN)
> ```
> 💡 **Common Mistake:** **Postfix/prefix need no parentheses or precedence** ➔ tree structure encodes grouping, so a machine evaluates RPN in one left-to-right pass with a stack.

## ⚖️ Core Decision Matrix
| Aspect | Cost / Result | Trigger / Note |
| :--- | :--- | :--- |
| structural op (balanced) | $O(\log N)$ | height $\Theta(\log N)$ |
| structural op (degenerate) | $O(N)$ | sorted input → "stick" |
| any traversal | $O(N)$ | each node once, best = worst |
| DFS recursion space | $O(h)$ | $O(\log n)$ balanced / $O(n)$ degenerate |
| BFS (level-order) space | $O(\text{width})$ | up to $O(n)$ at widest level |
| Morris inorder space | $O(1)$ | temporary link threading |

> [!NOTE] **When It Flips:** balance is the whole game — without it, sorted/adversarial input ➔ height-$N$ stick ➔ $O(N)$. Specialisations: [[Binary Search Tree (BST)]] (key order → search), **Expression Tree** (structure order → notation), and a *complete* + heap-ordered tree is a [[Heap]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Traversals of the BST `4(2(1,3), 6(5,7))`:

| Step / State | Trigger Op | Order | Sequence Payload |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | tree | — | `4(2(1,3), 6(5,7))` |
| 1 | preorder | root,L,R | `4, 2, 1, 3, 6, 5, 7` |
| 2 | **inorder** | L,root,R | **`1, 2, 3, 4, 5, 6, 7`** (sorted ✓) |
| 3 | postorder | L,R,root | `1, 3, 2, 5, 7, 6, 4` |
| 4 | level-order | by level | `4, 2, 6, 1, 3, 5, 7` |

### Applied Exercise
**Problem:** Reconstruct a tree from preorder `[4,2,1,3,6,5,7]` + inorder `[1,2,3,4,5,6,7]`.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{preorder}[0] &= \text{root} = 4 \\
\text{inorder split at } 4 &: \underbrace{[1,2,3]}_{\text{left}} \mid \underbrace{[5,6,7]}_{\text{right}} \Rightarrow \text{recurse each side}
\end{aligned}
$$
**Final Extracted Output:** preorder fixes roots, inorder splits subtrees ⟹ unique tree; **pre+post** alone is *not* unique.

## 🧠 Active Recall
> [!FAQ]- Why does a BST built from already-sorted keys degrade to $O(n)$, and what determines height generally?
> - **Hint:** Insertion order sets the shape.
> > [!SUCCESS]- Answer
> > - **Short answer:** Each key attaches on the same side ➔ a height-$N$ "stick" identical to a [[List (ADT)|LinkList]] ➔ $O(N)$.
> > - **Why:** **Height drives cost** ➔ balanced order gives $\Theta(\log N)$, sorted gives $\Theta(N)$; every op is $O(\text{height})$, so balance must be maintained.

> [!FAQ]- Distinguish full, complete, perfect, and balanced binary trees.
> - **Hint:** Nest the four shape definitions.
> > [!SUCCESS]- Answer
> > - **Short answer:** **Full** = 0/2 children; **complete** = last level filled left; **perfect** = full + leaves one level; **balanced** = heights differ $\le 1$.
> > - **Why:** **Implication chain** ➔ perfect ⟹ complete and balanced; complete ⟹ balanced; the converses fail.

> [!FAQ]- Given preorder + inorder, reconstruct the tree; why is preorder + postorder insufficient?
> - **Hint:** Roots vs subtree split.
> > [!SUCCESS]- Answer
> > - **Short answer:** Preorder's first element is the root; locate it in inorder to split left/right subtrees, recurse.
> > - **Why:** **Ambiguity** ➔ pre+post can't tell whether a single child is left or right — multiple trees share the same pair.

> [!FAQ]- How do you obtain prefix/infix/postfix from an expression tree, and why are postfix/prefix better for machines?
> - **Hint:** Traversal order = operator placement.
> > [!SUCCESS]- Answer
> > - **Short answer:** preorder→prefix, inorder→infix, postorder→postfix (RPN).
> > - **Why:** **No brackets needed** ➔ operator position encodes grouping, so RPN evaluates in one left-to-right pass with a [[Stack (ADT)]] (pop two per operator, apply, push).
