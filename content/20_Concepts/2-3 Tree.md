---
unit: FIT2004
week: 10
source: [lecture, applied, reading]
domain: A
parent: "[[Tree]]"
tags: [CS/DataStructures, CS/Algorithms, CS/Complexity]
aliases: [2-3 Search Tree, Two-Three Tree]
---
# [[2-3 Tree]]

**Context:** [[FIT2004_MOC]] · a search tree whose nodes hold **1 or 2 keys**, so it can stay **perfectly** balanced — the model that [[Left-Leaning Red-Black Tree|LLRB]] encodes in binary nodes, and the base case of the B-tree (FIT3155) · sibling: [[AVL Tree]]
**Parent Framework:** [[Tree]]

> [!abstract] Quick Revision
> - **🎯 Objective:** every leaf on the **same level** ➔ height $O(\log N)$ by construction; insert by **split $+$ promote**, delete by **rotate / merge**, both propagating to the root.
> - **📦 Core Components:** **2-node** ➔ 1 key, 2 children | **3-node** ➔ 2 keys, 3 children | temporary **4-node** ➔ 3 keys, exists only mid-insert.
> - **⚡ Key Constraint:** keys enter and leave **only at a leaf**; the tree grows and shrinks **at the root**, never at the leaves — that is why leaves stay level.

## 📝 How It Works
### 1. Structure and Balance
- **Ordering** ➔ 2-node $[a]$: left $<a<$ right · 3-node $[a\ b]$: left $<a<$ middle $<b<$ right.
- **Balance $=$ all leaves at the same level** ➔ the definition itself, not a tolerance like AVL's $\lvert bf\rvert\le1$.
- **Height** ➔ edges from root to any leaf (a lone root has height $0$); the LLRB **black-height** matches it.
- **Search** ➔ compare against $\le2$ keys per node, descend into the matching child.

### 2. Insert — Split and Promote
- **Descend to the leaf** ➔ key met **anywhere** on the path, internal nodes included ⟹ stop, tree unchanged.
- **Leaf is a 2-node** ➔ insert in order ⟹ 3-node, done.
- **Leaf is a 3-node** ➔ insert in order ⟹ 4-node $[a\ b\ c]$ ⟹ **split**: median $b$ moves **up** into the parent, $a$ and $c$ become two 2-nodes.
- **Propagate** ➔ the parent may now be a 4-node ⟹ split again; repeat until no 4-node remains. A **root split** creates a new root ⟹ height $+1$.

![[2-3 Tree Split-Promotion.png]]

### 3. Delete — Rotate or Merge
- **Move the key to a leaf** ➔ a non-leaf key is swapped with its in-order **predecessor or successor** (as in [[AVL Tree|AVL]] / BST), then removed from the leaf.
- **Leaf is a 3-node** ➔ remove the key, done.
- **Leaf is a 2-node** ➔ removing it would empty a node, so first give the leaf a second key:
	- **Rotate** — an adjacent sibling is a 3-node ➔ the parent key between them comes **down** into the leaf, the sibling's nearest key goes **up** to replace it.
	- **Merge** — no sibling can spare a key ➔ the parent key comes **down** and merges with the 2-node sibling; the parent loses a key.
- **Propagate** ➔ an emptied parent is repaired the same way one level up; an emptied **root** is removed ⟹ height $-1$.

## ⚖️ Complexity
*(derived from the balance property)*
| Operation | Time | Why |
| :--- | :--- | :--- |
| Search | $O(\log N)$ | $\le2$ comparisons per node $\times$ height |
| Insert | $O(\log N)$ | descent $+$ at most one $O(1)$ split per level |
| Delete | $O(\log N)$ | descent $+$ at most one $O(1)$ rotate/merge per level |

- **Height bound** ➔ every internal node has $\ge2$ children and all leaves are level ⟹ $N\ge2^{h+1}-1$ ⟹ $h\le\log_2(N+1)-1=O(\log N)$; all 3-nodes gives the other extreme $h\approx\log_3 N$.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — insert `50 30 40 20 10 60 55 25`
| Step | Insert | Leaf before | Event | Tree after |
| :--- | :--- | :--- | :--- | :--- |
| 1–2 | 50, 30 | $[50]$ | 2-node ➔ 3-node | `[30 50]` |
| 3 | 40 | $[30\ 50]$ | 4-node $[30\ 40\ 50]$ ⟹ split, **new root** | `[40]([30],[50])` |
| 4 | 20 | $[30]$ | ➔ 3-node | `[40]([20 30],[50])` |
| 5 | 10 | $[20\ 30]$ | $[10\ 20\ 30]$ ⟹ split, $20$ up | `[20 40]([10],[30],[50])` |
| 6 | 60 | $[50]$ | ➔ 3-node | `[20 40]([10],[30],[50 60])` |
| 7 | 55 | $[50\ 60]$ | $[50\ 55\ 60]$ ⟹ $55$ up ⟹ root $[20\ 40\ 55]$ ⟹ split, $40$ **new root** | `[40]([20]([10],[30]),[55]([50],[60]))` |
| 8 | 25 | $[30]$ | ➔ 3-node | `[40]([20]([10],[25 30]),[55]([50],[60]))` |

- **Step 7** ➔ the only cascade: two splits in one insert, height $1\to2$. Same sequence in [[Left-Leaning Red-Black Tree|LLRB]] must produce the mirror of every row.

### Applied Exercise — delete `10`, then delete `40` (successor) from the step-8 tree
- **Delete 10** ➔ leaf $[10]$ is a 2-node; adjacent sibling $[25\ 30]$ is a 3-node ⟹ **rotate**: parent key $20$ down, $25$ up ➔ `[40]([25]([20],[30]),[55]([50],[60]))`.
- **Delete 40, successor** ➔ swap with $50$ (smallest in right subtree); leaf $[50]$ empties; sibling $[60]$ is a 2-node ⟹ **merge** $55$ down ➔ $[55\ 60]$; parent $[55]$ now empty; its sibling $[25]$ is a 2-node ⟹ **merge** root $50$ down ➔ $[25\ 50]$; root empty ⟹ removed.

**Final Extracted Output:** `[25 50]([20],[30],[55 60])` — height $2\to1$. *(Predecessor $30$ instead also cascades: `[30 55]([20 25],[50],[60])`.)*

## ✍️ Practice
> [!QUESTION]- Practice 1: Insert `1, 2, 3, 4, 5, 6, 7` into an empty 2-3 tree. When does the height change?
> - **Hint:** Height only changes on a root split.
> > [!SUCCESS]- Answer
> > - **Splits** ➔ `3` splits $[1\ 2\ 3]$ ⟹ `[2]([1],[3])` (height $1$) · `5` splits $[3\ 4\ 5]$ ⟹ `[2 4]([1],[3],[5])` · `7` splits $[5\ 6\ 7]$, promoting $6$ ⟹ root $[2\ 4\ 6]$ splits ⟹ `[4]([2]([1],[3]),[6]([5],[7]))` (height $2$).
> > - **Why:** **Growth at the root** ➔ splits only push keys up, so every leaf stays at the same depth; only a root split adds a level.

> [!QUESTION]- Practice 2: From `[30 60]([10 20],[40],[70])`, delete `40`.
> - **Hint:** Which sibling of $[40]$ can lend a key?
> > [!SUCCESS]- Answer
> > - **Rotate from the left 3-node** ➔ parent key $30$ comes down, $20$ goes up ➔ `[20 60]([10],[30],[70])`.
> > - **Why:** **Rotate before merge** ➔ a sibling with a spare key fixes the leaf locally; merging would steal a parent key for no reason.

> [!QUESTION]- Practice 3 (prep P2): On `[10 30]([4 7]([2],[5],[9]),[22]([12],[25 27]),[40]([35],[42 45]))`, insert $6$, then $7$, then $50$.
> - **Hint:** Where is $7$ found? How many splits does $50$ cause?
> > [!SUCCESS]- Answer
> > - **Insert 6** ➔ path $[10\ 30]	o[4\ 7]	o[5]$; 2-node leaf ⟹ $[5\ 6]$.
> > - **Insert 7** ➔ found in the **internal** node $[4\ 7]$ ⟹ no change; the search never reaches a leaf.
> > - **Insert 50** ➔ $[42\ 45\ 50]$ ⟹ split, $45$ up into the 2-node $[40]$ ⟹ `[40 45]([35],[42],[50])`; parent now a 3-node ⟹ stop, height unchanged.
> > - **Why:** **A split only cascades into a full parent** ➔ promoting into a 2-node absorbs the key.

## ⚠️ Common Mistakes
- 💡 **Promoting the new key instead of the median** ➔ the **middle** of the three keys goes up, whichever was inserted.
- 💡 **Stopping after one split** ➔ check the parent; a promotion into a 3-node creates another 4-node.
- 💡 **Deleting an internal key in place** ➔ swap to a leaf first (predecessor or successor, as the question says).

## 🧠 Active Recall
> [!FAQ]- How does a 2-3 tree keep every leaf on the same level while inserting only at leaves?
> > [!SUCCESS]- Answer
> > - **Short answer:** a full leaf never grows downward; it splits and pushes its median **up**.
> > - **Why:** **Root-only growth** ➔ new levels are only ever created by a root split, which lowers every leaf by exactly one ⟹ all leaves remain level ⟹ height $O(\log N)$.

> [!FAQ]- When does deletion use a rotate and when a merge?
> > [!SUCCESS]- Answer
> > - **Short answer:** rotate when an adjacent sibling is a 3-node; merge when every adjacent sibling is a 2-node.
> > - **Why:** **Key budget** ➔ a rotate borrows a spare key through the parent (parent unchanged in size); a merge consumes a parent key, which can empty the parent and propagate up to the root, shrinking the height.
