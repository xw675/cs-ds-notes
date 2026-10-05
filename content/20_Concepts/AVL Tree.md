---
unit: FIT2004
week: 10
source: [lecture, applied, reading]
domain: A
parent: "[[Binary Search Tree (BST)]]"
tags: [CS/DataStructures, CS/Algorithms, CS/Complexity]
aliases: [AVL, Adelson-Velskii Landis Tree, Height-Balanced BST]
---
# [[AVL Tree]]

**Context:** [[FIT2004_MOC]] · the self-balancing [[Binary Search Tree (BST)|BST]] — same search/insert/delete, plus a rebalance pass that caps the height at $O(\log N)$ · siblings in W10: [[2-3 Tree]], [[Left-Leaning Red-Black Tree]]
**Parent Framework:** [[Binary Search Tree (BST)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** BST $+$ the **height-balance invariant** $\lvert h(L)-h(R)\rvert\le1$ at **every** node ➔ height $O(\log N)$ ⟹ search, insert, delete all $O(\log N)$ **worst case** (a plain BST degrades to $O(N)$).
> - **📦 Core Components:** plain BST op ➔ update heights **bottom-up** along the path ➔ first node with $\lvert bf\rvert>1$ ➔ **trinode restructure** (LL/RR single rotation, LR/RL double) ➔ keep climbing.
> - **⚡ Key Constraint:** classify by walking **twice toward the taller side** from the imbalanced node; if the second step is a tie (only happens on **delete**), repeat the first direction ⟹ single rotation, never double.

## 📝 How It Works
### 1. Height and Balance Factor
- **Lecture height convention** ➔ empty $=0$, leaf $=1$, node $=1+\max(h(L),h(R))$. Annotate every node by hand as `h,bf` (the slides' format).
- **Balance factor** ➔ $bf=h(L)-h(R)$ · positive ⟹ left taller · negative ⟹ right taller.
- **AVL** ⟺ $bf\in\{-1,0,1\}$ at every node — recursive, like the BST definition ("true for each subtree as well").
- **Convention-proof** ➔ Ian's hand heights are not the textbook height (leaf $=0$); $bf$ is a **difference**, so it is identical under either convention.

### 2. Operations = BST + Rebalance
- **Search** ➔ identical to BST.
- **Insert** ➔ BST insert, **only at a leaf**.
- **Delete** ➔ only **at a leaf**; a non-leaf key is first swapped with its in-order **predecessor** (biggest in left subtree) **or successor** (smallest in right subtree) — follow the question, be able to do both (they can trigger different rotations ➔ trace step 9).
- **Rebalance** ➔ walk back up the touched path, updating stored heights; the moment a node is imbalanced, restructure it; repeat until the root ("repeat until balanced" — a delete can cascade).

### 3. The Four Imbalance Cases
| Case | $bf(z)$ | Taller child's $bf$ | Fix |
| :--- | :--- | :--- | :--- |
| **LL** | $+2$ | $\ge0$ | rotate **right** at $z$ |
| **RR** | $-2$ | $\le0$ | rotate **left** at $z$ |
| **LR** | $+2$ | $-1$ | rotate left at child ⟹ LL ⟹ rotate right at $z$ |
| **RL** | $-2$ | $+1$ | rotate right at child ⟹ RR ⟹ rotate left at $z$ |

- **Child $bf=0$** ➔ only arises after a delete; it is the "tie ⟹ follow the first traversal" rule, i.e. LL/RR.

### 4. Ian's Way — Trinode Restructure (the PT-03 shortcut)
1. **Find $z$** ➔ the lowest node with $bf<-1$ or $bf>1$.
2. **Two steps down the taller side** ➔ gives the other two nodes; tie on step 2 ⟹ go the same way as step 1.
3. **Median of the three keys** ➔ new subtree root · smaller ➔ its left child · bigger ➔ its right child.
4. **Hang the four leftover subtrees $T_1..T_4$** back in **in-order** (left-to-right) — BST ordering is preserved automatically.
- **Why one recipe covers all four cases** ➔ every case ends in the same shape (diagram right-hand side); only *which* node is the median changes.

![[AVL Trinode Restructure (Ian's Way).png]]

## ⚖️ Complexity
| Operation | Time | Why |
| :--- | :--- | :--- |
| Search | $O(\log N)$ | height $O(\log N)$, unchanged BST walk |
| Insert / delete | $O(\log N)$ | descent $O(\log N)$ $+$ bottom-up check $O(\log N)$ $+$ each restructure $\le2$ rotations $=O(1)$, at most one per level |
| Space | $\Theta(N)$ | one stored height per node; recursive implementation $O(\log N)$ aux stack |

- **Heights are stored, not recomputed** ➔ recomputing $h$ from scratch, as done by hand, would cost $O(N)$; updating only the path is what keeps rebalancing $O(\log N)$.

## ⚖️ Core Decision Matrix
| Tree | Balance definition | Node shape | Rebalancing move | Delete in FIT2004 |
| :--- | :--- | :--- | :--- | :--- |
| **AVL** | $\lvert h(L)-h(R)\rvert\le1$ per node | binary, $+$ height field | rotations (trinode restructure) | ✅ |
| [[2-3 Tree]] | all leaves on the **same level** | 2-node / 3-node | split $+$ promote · merge / rotate | ✅ |
| [[Left-Leaning Red-Black Tree\|LLRB]] | equal **black** edges on every root-to-leaf path | binary, $+$ colour bit | rotate $+$ colour flip | ❌ insert only |

> [!NOTE] **When It Flips:** need plain binary nodes and the tightest height rule ➔ AVL. Need the simplest balance statement (perfectly level leaves) ➔ 2-3. Need the 2-3 guarantee **with** binary nodes and unchanged BST search code ➔ LLRB, its binary encoding.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — insert `50 40 30 60 70 55 35`, then delete `40 30 35`
| Step | Op | $z$ ($bf$) | Two steps | Case ➔ median | Tree after |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1–2 | ins 50, 40 | — | — | — | `50(40,_)` |
| 3 | ins 30 | $50\ (+2)$ | L, L | LL ➔ $40$ | `40(30,50)` |
| 4 | ins 60 | — | — | — | `40(30,50(_,60))` |
| 5 | ins 70 | $50\ (-2)$ | R, R | RR ➔ $60$ | `40(30,60(50,70))` |
| 6 | ins 55 | $40\ (-2)$ | R to 60, L to 50 | RL ➔ $50$ | `50(40(30,_),60(55,70))` |
| 7 | ins 35 | $40\ (+2)$ | L to 30, R to 35 | LR ➔ $35$ | `50(35(30,40),60(55,70))` |
| 8 | del 40, 30 | — | — | leaves, still balanced | `50(35,60(55,70))` |
| 9 | del 35 | $50\ (-2)$ | R to 60, **tie** ⟹ R | RR ➔ $60$ | `60(50(_,55),70)` |

- **Step 6 subtrees** ➔ $T_1=30$, $T_2=\varnothing$ (50's left), $T_3=55$ (50's right), $T_4=70$ — $55$ moves from under $50$ to under $60$.
- **Step 9 tie** ➔ $60$'s children both have height $1$; going L would wrongly do a double rotation. $55$ ($T_2$) becomes $50$'s right child.
- **Then delete 60** ➔ predecessor $55$: `55(50,70)`, no imbalance · successor $70$: `70(50(_,55),_)` is LR at $70$ ➔ `55(50,70)`. Same tree, different work.
- **Prep P1** ➔ insert $5$ into `50(20(10,_),55(52,60))`: $20$ is at $bf=+2$ while the root is only $+1$ ⟹ fix $20$, LL, median $10$ ➔ `50(10(5,20),55(52,60))`. The solution's "rotate the node 10" means $10$ rises to the subtree root.

## ✍️ Practice
> [!QUESTION]- Practice 1: Insert `10, 20, 30, 25, 28` into an empty AVL tree. Name each imbalance and give the final tree.
> - **Hint:** After `30`, which two steps from the root? After `28`, where is the lowest imbalanced node?
> > [!SUCCESS]- Answer
> > - **ins 30** ➔ $z=10\ (-2)$, R, R ⟹ RR ➔ `20(10,30)`.
> > - **ins 25, 28** ➔ `20(10,30(25(_,28),_))`: $30$ has $bf=+2$ (lowest), L to $25$, R to $28$ ⟹ **LR**, median $28$ ➔ `20(10,28(25,30))`.
> > - **Why:** **Lowest first** ➔ the root $20$ is also $-2$ before the fix, but restructuring at $30$ restores its height and the root is balanced again.

> [!QUESTION]- Practice 2 (cascade): From `19(12(9(1,_),15(13,18(17,_))),28(22(20,_),29))`, delete `29`.
> - **Hint:** Fix the lowest imbalance, then recheck every ancestor.
> > [!SUCCESS]- Answer
> > - **Fix 1** ➔ $z=28\ (+2)$, L, L ⟹ LL, median $22$ ➔ `22(20,28)`; the subtree's height drops $3\to2$.
> > - **Fix 2** ➔ now $z=19\ (+2)$: L to $12$ ($bf=-1$), R to $15$ ⟹ **LR**, median $15$; $T_1=$`9(1,_)`, $T_2=13$, $T_3=$`18(17,_)`, $T_4=$`22(20,28)`.
> > - **Final** ➔ `15(12(9(1,_),13),19(18(17,_),22(20,28)))`.
> > - **Why:** **Deletes shorten subtrees** ➔ a restructure after a delete can lower the height and expose an imbalance higher up, so the walk must continue to the root.

## ⚠️ Common Mistakes
- 💡 **Restructuring the highest imbalanced node** ➔ always fix the **lowest** one first, then move up.
- 💡 **Choosing the second step by key instead of height** ➔ step toward the **taller** subtree, not toward the inserted key's side after a delete.
- 💡 **Dropping $T_2$/$T_3$** ➔ the middle subtrees change parent; re-hang all four in in-order and recheck heights.

## 🧠 Active Recall
> [!FAQ]- Why is AVL insert $O(\log N)$ even though checking balance by hand means recomputing every height?
> > [!SUCCESS]- Answer
> > - **Short answer:** the implementation stores heights and only updates the nodes on the touched path.
> > - **Why:** **Path length** ➔ $O(\log N)$ by the invariant; each node update is $O(1)$ from its children's stored heights; each restructure is $\le2$ rotations $=O(1)$ ⟹ $O(\log N)$. Recomputing from scratch would be $O(N)$.

> [!FAQ]- After a delete, the child on the taller side has $bf=0$. Single or double rotation, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** single — follow the first direction again (LL or RR).
> > - **Why:** **Shape** ➔ with both grandchildren equally tall, rotating once at $z$ already balances; a double rotation would lift the wrong grandchild and leave $\lvert bf\rvert=2$ elsewhere.
