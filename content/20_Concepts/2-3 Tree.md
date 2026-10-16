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
> - **🎯 Objective:** every leaf on the **same level** ➔ height $O(\log N)$ by construction; insert bottom-up by **split $+$ promote**, delete **top-down** by **rotate / merge** so the target leaf is never a 2-node.
> - **📦 Core Components:** **2-node** ➔ 1 key, 2 children | **3-node** ➔ 2 keys, 3 children | temporary **4-node** ➔ 3 keys, split as soon as the operation passes back through it.
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
- **Propagate** ➔ the parent may now be a 4-node ⟹ split again; repeat until no 4-node remains. A **root split** creates a new root ⟹ height $+1$, the only way the tree gains height.

![[2-3 Tree Split-Promotion.png]]

### 3. Delete — Top-Down, Never Enter a 2-Node
- **Invariant** ➔ every node you step **into** holds $\ge2$ keys, so the leaf can always lose one and a parent can always give one down. Fix each child **before** entering it.
- **Root first** ➔ a 2-node root whose children are both 2-nodes is merged with them into a 4-node $[a\ r\ b]$ before the descent.
- **Child is a 2-node, an immediate sibling is a 3-node** ➔ **rotate**: the sibling's nearest key goes **up** into the parent, the parent's separating key comes **down** into the child.
- **Child and its immediate sibling are both 2-nodes** ➔ **merge**: child $+$ separating parent key $+$ sibling ⟹ one temporary **4-node**; the parent loses a key, which the invariant says it can spare.
- **At the leaf** ➔ it holds $\ge2$ keys ⟹ remove the key.
- **On the way back up** ➔ split every 4-node still standing, root included, exactly as in insert. Height shrinks only when a root merge survives to the end.
- **Scope** ➔ the applied sheet examines **leaf** keys only; an internal key is first swapped with its predecessor or successor (sanity check).

## ⚖️ Complexity
*(derived from the balance property)*
| Operation | Time | Why |
| :--- | :--- | :--- |
| Search | $O(\log N)$ | $\le2$ comparisons per node $\times$ height |
| Insert | $O(\log N)$ | descent $+$ at most one $O(1)$ split per level |
| Delete | $O(\log N)$ | descent with at most one $O(1)$ rotate/merge per level $+$ at most one split per level on the way back |

- **Height bound** ➔ every internal node has $\ge2$ children and all leaves are level ⟹ $N\ge2^{h+1}-1$ ⟹ $h\le\log_2(N+1)-1=O(\log N)$; all 3-nodes gives the other extreme $h\approx\log_3 N$.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — applied P5(a)
Start: `[15 51]([3 6]([0],[4],[8 12]),[19 28]([16 18],[23 25],[40]),[60]([59],[65 70]))`

| Step | Op | Event | Changed part |
| :--- | :--- | :--- | :--- |
| i | ins 5 | leaf $[4]$ is a 2-node ➔ $[4\ 5]$ | `[3 6]([0],[4 5],[8 12])` |
| ii | ins 62 | $[62\ 65\ 70]$ ⟹ split, $65$ up into $[60]$ | `[60 65]([59],[62],[70])` |
| iii | del 59 | root and $[60\ 65]$ are 3-nodes ✓ · target $[59]$ and sibling $[62]$ both 2-nodes ⟹ **merge** $[59\ 60\ 62]$, parent $[65]$ ⟹ remove $59$ | `[65]([60 62],[70])` |
| iv | ins 10 | $[8\ 10\ 12]$ ⟹ $10$ up ⟹ $[3\ 6\ 10]$ ⟹ $6$ up ⟹ root $[6\ 15\ 51]$ ⟹ split, $15$ **new root** | `[15]([6]([3](…),[10]([8],[12])),[51](…))` |
| v | del 40 | 2-node root over two 2-nodes ⟹ **root merge** $[6\ 15\ 51]$ · $[19\ 28]$ ✓ · target $[40]$, sibling $[23\ 25]$ ⟹ **rotate** $25$ up, $28$ down ⟹ $[28\ 40]$ ⟹ remove $40$ ⟹ split the leftover root 4-node | `[19 25]([16 18],[23],[28])` |

**Final Extracted Output:** `[15]([6]([3]([0],[4 5]),[10]([8],[12])),[51]([19 25]([16 18],[23],[28]),[65]([60 62],[70])))`

- **Step iii** ➔ the merge creates a 4-node **leaf**; deleting from it leaves a legal 3-node, so nothing is left to split.
- **Step v** ➔ the root merge was temporary — the 4-node root survives the descent untouched and is split on exit, so the height is unchanged. Its LLRB form is [[Left-Leaning Red-Black Tree]] Practice 4.

## ✍️ Practice
> [!QUESTION]- Practice 1: Insert `1, 2, 3, 4, 5, 6, 7` into an empty 2-3 tree. When does the height change?
> - **Hint:** Height only changes on a root split.
> > [!SUCCESS]- Answer
> > - **Splits** ➔ `3` splits $[1\ 2\ 3]$ ⟹ `[2]([1],[3])` (height $1$) · `5` splits $[3\ 4\ 5]$ ⟹ `[2 4]([1],[3],[5])` · `7` splits $[5\ 6\ 7]$, promoting $6$ ⟹ root $[2\ 4\ 6]$ splits ⟹ `[4]([2]([1],[3]),[6]([5],[7]))` (height $2$).
> > - **Why:** **Growth at the root** ➔ splits only push keys up, so every leaf stays at the same depth; only a root split adds a level.

> [!QUESTION]- Practice 2: From `[30 60]([10 20],[40],[70])`, delete `40`.
> - **Hint:** Which sibling of $[40]$ can lend a key?
> > [!SUCCESS]- Answer
> > - **Rotate from the left 3-node** ➔ $20$ goes up, parent key $30$ comes down ⟹ $[30\ 40]$ ⟹ remove $40$ ➔ `[20 60]([10],[30],[70])`.
> > - **Why:** **Rotate before merge** ➔ a sibling with a spare key fixes the child locally; merging would take a parent key for no reason.

> [!QUESTION]- Practice 3 (prep P2): On `[10 30]([4 7]([2],[5],[9]),[22]([12],[25 27]),[40]([35],[42 45]))`, insert $6$, then $7$, then $50$.
> - **Hint:** Where is $7$ found? How many splits does $50$ cause?
> > [!SUCCESS]- Answer
> > - **Insert 6** ➔ path $[10\ 30]\to[4\ 7]\to[5]$; 2-node leaf ⟹ $[5\ 6]$.
> > - **Insert 7** ➔ found in the **internal** node $[4\ 7]$ ⟹ no change; the search never reaches a leaf.
> > - **Insert 50** ➔ $[42\ 45\ 50]$ ⟹ split, $45$ up into the 2-node $[40]$ ⟹ `[40 45]([35],[42],[50])`; parent now a 3-node ⟹ stop, height unchanged.
> > - **Why:** **A split only cascades into a full parent** ➔ promoting into a 2-node absorbs the key.

> [!QUESTION]- Practice 4: From `[4]([2]([1],[3]),[6]([5],[7]))`, delete $1$. Does the height change?
> - **Hint:** Process the root before descending.
> > [!SUCCESS]- Answer
> > - **Root merge** ➔ 2-node root over two 2-nodes ⟹ `[2 4 6]([1],[3],[5],[7])`.
> > - **Merge at the leaf** ➔ target $[1]$, sibling $[3]$ both 2-nodes ⟹ $[1\ 2\ 3]$, parent $[4\ 6]$ ⟹ remove $1$ ⟹ $[2\ 3]$.
> > - **Final** ➔ `[4 6]([2 3],[5],[7])` — no 4-node left to split, so height $2\to1$.
> > - **Why:** **Shrink at the root** ➔ the root merge lowers every leaf by one at once; it is undone on exit only if the root is still a 4-node.

## ⚠️ Common Mistakes
- 💡 **Promoting the new key instead of the median** ➔ the **middle** of the three keys goes up, whichever was inserted.
- 💡 **Stopping after one split** ➔ check the parent; a promotion into a 3-node creates another 4-node.
- 💡 **Fixing the leaf after deleting** ➔ the unit's delete is top-down: rotate or merge **before** entering each 2-node, starting with the root.
- 💡 **Leaving a 4-node behind** ➔ after a delete, split any 4-node still on the path, including a merged root.

## 🧠 Active Recall
> [!FAQ]- How does a 2-3 tree keep every leaf on the same level while inserting only at leaves?
> > [!SUCCESS]- Answer
> > - **Short answer:** a full leaf never grows downward; it splits and pushes its median **up**.
> > - **Why:** **Root-only growth** ➔ new levels are only ever created by a root split, which lowers every leaf by exactly one ⟹ all leaves remain level ⟹ height $O(\log N)$.

> [!FAQ]- During delete, when do you rotate and when do you merge — and why can the parent always afford a merge?
> > [!SUCCESS]- Answer
> > - **Short answer:** rotate when an immediate sibling is a 3-node; merge when it is a 2-node. The parent was itself made $\ge2$ keys before you entered it.
> > - **Why:** **Top-down invariant** ➔ a rotate borrows a spare key through the parent (parent size unchanged); a merge pulls a parent key down into a temporary 4-node, which never empties the parent because it held $\ge2$ keys. Leftover 4-nodes are split on the way back up.
