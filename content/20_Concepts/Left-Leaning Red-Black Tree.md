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
- **Black-height** ➔ number of black edges from root to leaf, equal on every path $=$ the 2-3 tree's height. Red edges add none, which is what keeps it balanced.

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
### Manual Execution Trace — insert `50 30 40 20 10 60 55 25` *(`r` = red; same keys as the [[2-3 Tree]] trace)*
| Step | Insert | Situation | Fix sequence | LLRB after | 2-3 mirror |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 50 | root | recolour black | `50` | `[50]` |
| 2 | 30 | left of black | none | `50(30r,_)` | `[30 50]` |
| 3 | 40 | right of red $30$ | (e) rotL@30 ➔ (d) rotR@50 ➔ (c) flip@40 ➔ root black | `40(30,50)` | `[40]([30],[50])` |
| 4 | 20 | left of black | none | `40(30(20r,_),50)` | `[40]([20 30],[50])` |
| 5 | 10 | left of red $20$ | (d) rotR@30 ➔ (c) flip@20; at $40$ only a red left | `40(20r(10,30),50)` | `[20 40]([10],[30],[50])` |
| 6 | 60 | right of black, no red sibling | (b) rotL@50 | `40(20r(10,30),60(50r,_))` | `[20 40]([10],[30],[50 60])` |
| 7 | 55 | right of red $50$ | rotL@50 ➔ rotR@60 ➔ flip@55 ➔ **flip@40** ➔ root black | `40(20(10,30),55(50,60))` | `[40]([20]([10],[30]),[55]([50],[60]))` |
| 8 | 25 | left of black | none | `40(20(10,30(25r,_)),55(50,60))` | `[40]([20]([10],[25 30]),[55]([50],[60]))` |

- **Step 7** ➔ the flip at $55$ makes it red beside red $20$ ⟹ a second flip at $40$ — the LLRB form of the 2-3 double split.
- **Check** ➔ final black-height $2$ on every path (e.g. $40\to20\to30\to25$: two black edges, one red) $=$ 2-3 height $2$.

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
