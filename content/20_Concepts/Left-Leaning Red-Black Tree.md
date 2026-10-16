---
unit: FIT2004
week: 10
source: [lecture, applied, reading]
domain: A
parent: "[[2-3 Tree]]"
tags: [CS/DataStructures, CS/Algorithms, CS/Complexity]
aliases: [LLRB, LLRB Tree, Red-Black Tree, RB Tree]
---
# [[Left-Leaning Red-Black Tree]]

**Context:** [[FIT2004_MOC]] · a [[2-3 Tree]] drawn with ordinary binary [[Binary Search Tree (BST)|BST]] nodes — a **red** edge glues two keys into one 3-node · sibling: [[AVL Tree]]
**Parent Framework:** [[2-3 Tree]]

> [!abstract] Quick Revision
> - **🎯 Objective:** colour each edge (stored on its child) ➔ red edges cost no height ➔ equal **black** edges on every root-to-leaf path ⟹ the mirrored 2-3 tree is perfectly balanced ⟹ $O(\log N)$.
> - **📦 Core Components:** insert as a **red leaf** ➔ fix bottom-up with **rotate left** (red right link) · **rotate right** (two reds left-left) · **colour flip** (both children red) ➔ root to black.
> - **⚡ Key Constraint:** height here means **black-height** (black edges root ➔ leaf), not the drawn height; check every branch has the same black count after each insert. **No delete** in FIT2004.

## 📝 How It Works
### 1. Colours and Invariants
- **Colour $=$ the connecting edge** ➔ stored on the child of that edge; nodes are drawn coloured only for readability.
- **No red parent with a red child** ➔ two reds in a row would be a 4-node.
- **Left-leaning** ➔ a red link may only be a **left** child.
- **Root is black** ➔ at the end of every operation, a red root is recoloured black.
- **Black-height** ➔ number of black edges from root to leaf, equal on every path $=$ the 2-3 tree's height (a lone root has black-height $0$). Red edges add none, which is what keeps it balanced.

### 2. Ian's Way — 2-3 ⟷ LLRB
| 2-3 tree | LLRB |
| :--- | :--- |
| 2-node $[a]$ | black node $a$ |
| 3-node $[a\ b]$ | black $b$ (the larger key, parent) with **red left child** $a$ |
| temporary 4-node $[a\ b\ c]$ | black $b$ with red $a$ **and** red $c$ |
| split, median promoted | colour flip |
| root split, height $+1$ | red root recoloured black, black-height $+1$ |

- **Use it to verify** ➔ convert your LLRB answer to a 2-3 tree (or vice versa) and check it matches the 2-3 insertion of the same keys.

### 3. Insert — Red Leaf, Then Fix Upward
- **Descend as a BST, insert at a leaf, coloured red** ➔ a red edge cannot change the black-height, so only the colour invariants can break.
- **Left child of a black node** ➔ fine (a 2-node became a 3-node) — panel (a).
- **Right child, left sibling not red** ➔ **rotate left**: the right child becomes the parent and takes its colour, the old parent turns red — panel (b).
- **Right child, left sibling red** ➔ **colour flip**: parent red, both children black — panel (c).
- **Left child of a red left child** ➔ **rotate right** at the grandparent (Ian's AVL trinode restructure: median on top, black, both others red), then flip — panel (d).
- **Right child of a red left child** ➔ **rotate left** at the red parent ⟹ panel (d) — panel (e). Ian's restructure does (e)$+$(d) in one step.
- **Propagate** ➔ a flip turns the parent red, which can create a new violation one level up; keep checking to the root, then recolour the root black.

![[LLRB Insert Fix-ups.png]]

## ⚖️ Complexity
*(derived from the 2-3 correspondence)*
| Operation | Time | Why |
| :--- | :--- | :--- |
| Search | $O(\log N)$ | plain BST search; drawn height $\le2\times$ black-height $+1$ (no two reds in a row) |
| Insert | $O(\log N)$ | descent $+$ $O(1)$ rotations/flips per level on the way up |
| Space | $\Theta(N)$ | one colour bit per node |

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — applied P6, inserts into an empty LLRB *(`r` = red · bh = black-height)*
| Step | Insert | Fix sequence | LLRB after | 2-3 mirror | bh |
| :--- | :--- | :--- | :--- | :--- | :--- |
| a | 40 | red root ⟹ black | `40` | `[40]` | $0$ |
| b | 20 | none — red left child | `40(20r,_)` | `[20 40]` | $0$ |
| c | 5 | rotR@40 ➔ flip@20 ➔ root black | `20(5,40)` | `[20]([5],[40])` | $1$ |
| d | 1 | none | `20(5(1r,_),40)` | `[20]([1 5],[40])` | $1$ |
| e | 32 | none | `20(5(1r,_),40(32r,_))` | `[20]([1 5],[32 40])` | $1$ |
| f | 64 | flip@40 ➔ rotL@20 | `40(20r(5(1r,_),32),64)` | `[20 40]([1 5],[32],[64])` | $1$ |
| g | 13 | flip@5 ➔ rotR@40 ➔ flip@20 ➔ root black | `20(5(1,13),40(32,64))` | `[20]([5]([1],[13]),[40]([32],[64]))` | $2$ |
| h | 5 | duplicate ⟹ unchanged | — | — | $2$ |
| i | 38 | rotL@32 | `20(5(1,13),40(38(32r,_),64))` | `[20]([5]([1],[13]),[40]([32 38],[64]))` | $2$ |
| j | 36 | rotL@32 ➔ rotR@38 ➔ flip@36 | `20(5(1,13),40(36r(32,38),64))` | `[20]([5]([1],[13]),[36 40]([32],[38],[64]))` | $2$ |

- **bh rises only at (c) and (g)** ➔ the steps where a flip pushes red into the root and it is blackened — the 2-3 root split.
- **Step (f)** ➔ the flip at $40$ leaves it a red **right** child of $20$ ⟹ rotate left one level up; the 2-3 view is $[32\ 40\ 64]$ splitting into the root.
- **Step (j)** ➔ the flip leaves $36$ a red **left** child of black $40$ ⟹ legal, stop.

## ✍️ Practice
> [!QUESTION]- Practice 1: Convert the 2-3 tree `[25 50]([20],[30],[55 60])` to an LLRB and state its black-height.
> - **Hint:** Each 3-node becomes its larger key, black, with the smaller as a red left child.
> > [!SUCCESS]- Answer
> > - **LLRB** ➔ `50(25r(20,30),60(55r,_))`.
> > - **Black-height** ➔ $1$ on every path ($50\to25\to20$: red then black; $50\to60\to55$: black then red) $=$ the 2-3 height.
> > - **Why:** **One black edge per 2-3 level** ➔ red edges only join keys inside a node.

> [!QUESTION]- Practice 2: Insert `1, 2, 3, 4, 5, 6, 7` into an empty LLRB. List the fixes and the final tree.
> - **Hint:** Ascending keys always land as a right child.
> > [!SUCCESS]- Answer
> > - **Fixes** ➔ `2` rotL@1 · `3` flip@2, root black · `4` rotL@3 · `5` flip@4 **then** rotL@2 (the flip left $4$ as a red right child) · `6` rotL@5 · `7` flip@6, flip@4, root black.
> > - **Final** ➔ `4(2(1,3),6(5,7))`, all black — the mirror of the 2-3 tree `[4]([2]([1],[3]),[6]([5],[7]))`.
> > - **Why:** **A flip pushes red upward** ➔ the parent can become a red right link, which needs its own rotate left one level up.

> [!QUESTION]- Practice 3 (prep P3): On `19(9(5r(4(1r,_),7),13),36(21r(20,35),37))` insert $12$, then $8$, then $15$.
> - **Hint:** After each flip, look at the node that just turned red and its sibling.
> > [!SUCCESS]- Answer
> > - **Insert 12** ➔ red left child of black $13$ ⟹ valid, no fix.
> > - **Insert 8** ➔ red right child of black $7$, no red left sibling ⟹ **rotate left**: `8(7r,_)`.
> > - **Insert 15** ➔ red right of $13$ beside red $12$ ⟹ **flip@13** ($13$ red) ⟹ $9$ now has red $5$ **and** red $13$ ⟹ **flip@9** ⟹ $9$ is a red **left** child of black $19$ ⟹ valid, stop.
> > - **Final** ➔ `19(9r(5(4(1r,_),8(7r,_)),13(12,15)),36(21r(20,35),37))`, black-height $2$ on every path.
> > - **Why:** **2-3 mirror** ➔ $15$ makes $[12\ 13\ 15]$, $13$ promoted makes $[5\ 9\ 13]$, $9$ promoted makes root $[9\ 19]$ — two splits, two flips, no root split so the root stays black.

> [!QUESTION]- Practice 4 (applied P5b): Convert `[15]([6]([3]([0],[4 5]),[10]([8],[12])),[51]([19 25]([16 18],[23],[28]),[65]([60 62],[70])))` to an LLRB.
> - **Hint:** Work node by node; a 3-node's left and middle children hang under the red key, its right child under the black key.
> > [!SUCCESS]- Answer
> > - **LLRB** ➔ `15(6(3(0,5(4r,_)),10(8,12)),51(25(19r(18(16r,_),23),28),65(62(60r,_),70)))`.
> > - **Check** ➔ black-height $3$ on every path ($15\to51\to25\to19\to18\to16$: black, black, red, black, red) $=$ the 2-3 height.
> > - **Why:** **$[19\ 25]$** ➔ black $25$, red left $19$; $19$ takes $[16\ 18]$ and $[23]$, $25$ keeps $[28]$ on its right.

## ⚠️ Common Mistakes
- 💡 **Measuring height by drawn levels** ➔ count **black** edges only; the drawn tree may be up to twice as tall.
- 💡 **Forgetting the final root recolour** ➔ after a flip at the root it is red; set it black (black-height $+1$).
- 💡 **Putting the red key on the right of a 3-node** ➔ left-leaning: the **smaller** key is the red left child.

## 🧠 Active Recall
> [!FAQ]- Why is a newly inserted node always red?
> > [!SUCCESS]- Answer
> > - **Short answer:** a red edge adds no black-height, so the balance invariant cannot break — only colour rules can, and those are fixed locally.
> > - **Why:** **2-3 view** ➔ inserting red means adding the key **into** an existing node (2 ➔ 3 or 3 ➔ 4-node) rather than creating a new level; a black insert would lengthen one path and break perfect black balance.

> [!FAQ]- Why is inserting as the right child of a black node a problem, but not as the left child?
> > [!SUCCESS]- Answer
> > - **Short answer:** a red right link violates **left-leaning**; it is still a valid 3-node, just drawn the wrong way.
> > - **Why:** **One encoding per 3-node** ➔ rotate left swaps parent and child so the smaller key becomes the red **left** child, restoring the unique 2-3 ⟷ LLRB mapping.
