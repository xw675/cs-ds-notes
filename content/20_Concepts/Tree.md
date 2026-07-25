---
unit: [FIT1008, FIT1058]
week: [8, 12]
parent: "[[Data Structure]]"
tags: [CS/DataStructures, CS/Complexity, Math/GraphTheory]
---
# [[Tree]]

**Context:** [[FIT1008_MOC]], [[FIT1058_MOC]] · a non-linear structure of chained [[Node|nodes]] · graph-theoretically a connected acyclic [[Graph]] · specialised by the [[Binary Tree]] · the object [[Spanning Tree|spanning trees]] and [[Forest|forests]] generalise

> [!abstract] Quick Revision
> - **🎯 Objective:** hierarchical acyclic connected structure ➔ one root, no cycles; the minimal connected graph ($n$ nodes ⇒ $n-1$ edges).
> - **📦 Core Components:** root / leaf / inner node, depth, **height** | **rooted** (FIT1008) vs **unrooted** (FIT1058) | specialised by [[Binary Tree]].
> - **⚡ Key Constraint:** every operation is $O(\text{height})$ ➔ $\Theta(\log n)$ balanced, $\Theta(n)$ degenerate.

## 📝 Core
### 1. The Tree (Rooted, $n-1$ Edges)
- **Structure** ➔ nodes + edges, one **root**, no cycles ➔ formally an **acyclic connected graph**.
- **Rooted (CS)** ➔ root distinguished, edges parent→child ➔ models file systems, org charts, parse trees.
- **Edge count** ➔ exactly **$n-1$ edges** (each non-root has one parent edge); add any edge ⟹ cycle, remove any ⟹ disconnect.

### 2. Vocabulary & Height
- **Terms** ➔ **root** (no parent) | **leaf** (no child) | **inner** (neither) | **subtree** | **depth** (root = 0) | **height** (max depth) | **width**.
- **Performance quantity** ➔ operation cost is $O(\text{height})$ ➔ balanced $\log n$ vs degenerate $n$ (see [[Binary Tree]]).

### 3. Graph-Theoretic View (FIT1058, Unrooted)
- **Unrooted tree** ➔ a connected acyclic [[Graph|graph]] ➔ the **minimal connected** graph.
- **Named theorems** ➔ **(T1)** tree iff minimal connected | **(T2)** $\ge2$ vertices ⟹ a **leaf** (degree-1) | **(T3)** $n$ vertices ⟹ $n-1$ edges (by [[Mathematical Induction|induction]]).

## ⚙️ Core Implementation
*Recursion is natural:* a tree is a node plus subtrees, so [[Recursion]] / structural induction is the standard tool. A *trie* (prefix tree) shares common prefixes (`ta`→`table`/`tap`).

### 🔹 Recursive height
> [!code]- `height(node)`
> ```python
> def height(node) -> int:                    # -1 for empty, else 1 + taller child
>     if node is None:
>         return -1
>     return 1 + max(height(node.left), height(node.right))
> ```
> 💡 **Common Mistake:** **Empty tree returns −1** ➔ so a single node has height 0; operation cost follows a root-to-node path bounded by the height — self-balancing is the entire performance story.

## ⚖️ Core Decision Matrix
*A graph $G=(V,E)$ is a tree iff **any one** equivalent condition holds:*

| # | Characterisation | Consequence |
| :--- | :--- | :--- |
| 1 | connected **and** acyclic | the base definition |
| 2 | connected, $\lvert E\rvert = \lvert V\rvert - 1$ | minimal edges to connect |
| 3 | acyclic, $\lvert E\rvert = \lvert V\rvert - 1$ | maximal edges without a cycle |
| 4 | exactly **one** simple path between any pair | unique routing |
| 5 | add any edge ⟹ cycle; remove any ⟹ disconnect | minimal connected |

> [!NOTE] **When It Flips:** trees are the **minimal connected** graphs ➔ they underlie **spanning trees** (Prim/Kruskal). Cost is $O(\text{height})$: balanced $O(\log n)$, degenerate "stick" $O(n)$ — no better than a [[List (ADT)|LinkList]] (a degenerate tree, one child per node).

## 📊 Exam Execution Trace

### Manual Execution Trace
`height` on `A(B(D,E), C)`:

| Step / State | Trigger Op | Call | Return Payload |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | leaves | `height(D)`/`height(E)` | $1+\max(-1,-1)=0$ |
| 1 | up to B | `height(B)` | $1+\max(0,0)=1$ |
| 2 | up to C | `height(C)` | `0` |
| 3 | root | `height(A)` | $1+\max(1,0)=2$ |

### Applied Exercise
**Problem:** Prove a tree on $n$ vertices has exactly $n-1$ edges.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\textbf{base } (n=1):\;& 0 \text{ edges} = 1-1 \checkmark \\
\textbf{step}:\;& \text{a tree on } n \text{ has a leaf (T2); remove it} \Rightarrow \text{tree on } n-1 \text{ with } (n-1)-1 \text{ edges (IH)} \\
& \text{re-add the leaf + its one edge} \Rightarrow (n-2)+1 = n-1 \text{ edges} \;\checkmark
\end{aligned}
$$
**Final Extracted Output:** $\lvert E\rvert = \lvert V\rvert - 1$ — trees are the minimal connected graphs (Q.E.D.).

## 🧠 Active Recall
> [!FAQ]- Give three equivalent definitions of a tree on $\lvert V\rvert$ vertices and explain why they imply $\lvert E\rvert = \lvert V\rvert - 1$.
> - **Hint:** Equivalent characterisations + the edge count.
> > [!SUCCESS]- Answer
> > - **Short answer:** (a) connected + acyclic; (b) connected, $\lvert E\rvert=\lvert V\rvert-1$; (c) exactly one simple path between any pair.
> > - **Why:** **Parent edges** ➔ each non-root vertex contributes one parent edge, the root none ⟹ $\lvert E\rvert=\lvert V\rvert-1$; fewer disconnects, more creates a cycle.

> [!FAQ]- Why is the *height* the quantity that governs a tree's operation complexity?
> - **Hint:** Operations follow a root-to-node path.
> > [!SUCCESS]- Answer
> > - **Short answer:** Most ops traverse a root-to-node path bounded by the height.
> > - **Why:** **Balance** ➔ balanced height $\Theta(\log n)$ ⟹ $O(\log n)$ ops; degenerate $\Theta(n)$ ⟹ $O(n)$ — controlling height (self-balancing) is the whole story.

> [!FAQ]- Why is recursion the natural paradigm for tree algorithms?
> - **Hint:** A tree is recursively defined.
> > [!SUCCESS]- Answer
> > - **Short answer:** A tree = a node plus subtrees, each itself a tree.
> > - **Why:** **Structural induction** ➔ "process this node, recurse on subtrees", correctness by induction over subtrees with the empty/leaf base case.
