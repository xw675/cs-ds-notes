---
unit: FIT2004
domain: A
week: 2
source: applied
parent: "[[Divide and Conquer]]"
tags:
  - CS/Algorithms
  - CS/Complexity
aliases:
  - peak finding
  - local maximum in a matrix
  - 2D peak
  - cross method
---
# [[2D Local Maximum (Peak Finding)]]

**Context:** [[FIT2004_MOC]] · Applied 2 Problem 6 — the [[Divide and Conquer]] exercise where the **naive halving is not aggressive enough**, and the correctness argument (not the code) carries the marks.
**Parent Framework:** [[Divide and Conquer]]

> [!abstract] Quick Revision
> - **🎯 Objective:** in an $n\times n$ matrix of **distinct** numbers, return the coordinates of *any* element larger than its (2–4) orthogonal neighbours ➔ in $\Theta(n)$ worst case.
> - **📦 Core Components:** scan a **window frame** (first/middle/last row $+$ column) $\Theta(n)$ ➔ its max $x$ is a peak, **or** a neighbour $y>x$ lies in one quadrant ➔ recurse into that quadrant, $\tfrac n2\times\tfrac n2$.
> - **⚡ Key Constraint:** $\Theta(n)$ on an input of $n^{2}$ cells means the algorithm **cannot read most of the matrix** — so the subproblem must shrink in **both** dimensions. Halving one axis leaves the per-call scan at $\Theta(n)$ forever and costs $\Theta(n\log n)$.

## 📝 How It Works
### 1. Why the two obvious algorithms fail their bound
- **Gradient ascent is $\Theta(n^{2})$** ➔ stepping to the largest neighbour terminates (values strictly increase, grid finite) but a snake-shaped ridge forces a traversal of half the matrix — sheet matrix 1 from the top-left is exactly that adversary.
- **Splitting on the middle column alone is $\Theta(n\log n)$** ➔ the deciding column scan costs $\Theta(n)$ and the sub-matrix is $n\times\tfrac n2$ — the **column never gets shorter**, so $\Theta(n)$ repeats $\log_2 n$ times with no geometric decay.
- **The diagnostic** ➔ a $T(n)=T(n/2)+\Theta(n)=\Theta(n)$ target requires the per-call work itself to halve; only cutting both axes achieves that ($r=\tfrac12$, root-dominated) ➔ [[Solving Recurrences (Telescoping)]].

### 2. The cross method and its correctness argument
- **Step 1 — scan the cross** ➔ middle row and middle column ($2n-1$ cells, $\Theta(n)$); let $x$ be their maximum.
- **Step 2 — test $x$** ➔ if it beats its four neighbours, return its coordinates.
- **Step 3 — follow the escape** ➔ otherwise some neighbour $y>x$ exists, and $y$ must lie **off** the cross (everything on it is $\le x$) ⟹ $y$ sits in one of the four quadrants.
- **Step 4 — recurse into that quadrant $A$** ➔ size $\approx\tfrac n2\times\tfrac n2$.
- **⚡ The correctness claim** ➔ *$A$ is guaranteed to contain a local maximum of the whole matrix $M$.* Run gradient ascent from $y$: values strictly increase, and every cross cell is $<y$, so the walk can **never cross back**; the grid is finite, so it halts at a peak inside $A$. Discarding three quadrants therefore discards nothing needed.

### 3. The window-frame repair
- **The bug in plain cross recursion** ➔ the max $z$ of a *sub-matrix's* cross may beat its neighbours **within the sub-matrix** yet lose to a cell just outside. Sheet witness: $340$ beats $260,235,305$ but is crushed by $503$, which belonged to the previous level's cross.
- **The fix** ➔ scan a **window frame**: the **first, middle and last** rows plus the **first, middle and last** columns, maximising over all six lines — the boundary is then in scope, so nothing beyond the frame can quietly dominate the winner.
- **Cost is unchanged** ➔ six lines of length $\le n$ is still $\Theta(n)$, so the recurrence and the $\Theta(n)$ bound survive.

## ⚖️ Complexity
| Approach | Recurrence | Best / Average / Worst | Auxiliary space | Why it lands there |
| :--- | :--- | :--- | :--- | :--- |
| Gradient ascent (walk uphill) | — | $\Theta(1)$ / — / $\Theta(n^{2})$ | $O(1)$ | a ridge forces a traversal of half the cells |
| Middle-**column** split | $T(n)=T(n/2)+\Theta(n)$, $n$ fixed | $\Theta(n\log n)$ all | $\Theta(\log n)$ frames | column length never shrinks ⟹ $\log_2 n$ scans of cost $\Theta(n)$ |
| **Cross / window frame** | $T(n)=T(n/2)+\Theta(n)$ | $\Theta(n)$ all | $\Theta(\log n)$ frames | $r=a/b=\tfrac12<1$ ⟹ **root-dominated** |

$$T(n)=T(n/2)+cn = cn\sum_{i=0}^{\log_2 n}\left(\tfrac12\right)^{i} < 2cn = \Theta(n)$$

> [!NOTE] **When It Flips:** the entire $\Theta(n\log n)\to\Theta(n)$ gain comes from the **second axis**, not a cleverer scan. Both variants do identical work at the root; only the cross version makes level $i$ cost $cn/2^{i}$, turning the level sum into a convergent [[Geometric Series]].

## 📊 Exam Execution Trace
On sheet matrix 1 ($7\times7$, $0$-indexed). **Every neighbour test is made against the ORIGINAL matrix $M$**, never the sub-matrix — that is the window-frame discipline:

| Step | Sub-matrix | Frame max $x$ (position) | Beaten by? | Action |
| :--- | :--- | :--- | :--- | :--- |
| **0 (Init)** | rows $0..6$, cols $0..6$ | $46$ at $(3,6)$ | $47$ at $(2,6)$ | recurse into the quadrant holding $(2,6)$ |
| 1 | rows $0..2$, cols $4..6$ | $48$ at $(1,6)$ | $49$ at $(0,6)$ | recurse into the quadrant holding $(0,6)$ |
| 2 | row $0$, col $6$ | $49$ at $(0,6)$ | none ($48$ below, $30$ left) | **return $(0,6)$** |

**Read-off:** three levels, scans of length $\approx7,3,1$ — the halving of the *scan* is the whole point; a column-only split would scan $7$ cells at every level.

## ⚠️ Common Mistakes
- 💡 **Claiming $\Theta(n)$ is impossible because the input has $n^{2}$ cells** ➔ reading the whole input is mandatory only when the answer depends on every cell. A peak is a *local* property, so $\Theta(n)$ cells suffice to certify one.
- 💡 **Recursing into the quadrant with the largest cross value instead of the one containing $y$** ➔ the correctness argument is built on $y$ specifically ($y>x\ge$ every cross cell); any other quadrant carries no such guarantee.
- 💡 **Comparing against sub-matrix neighbours** ➔ the $340$-vs-$503$ failure; a candidate must be tested against its neighbours in $M$.
- 💡 **Assuming a unique peak** ➔ the spec asks for *any* local maximum; multiple peaks is the normal case.

## 🧠 Active Recall
> [!FAQ]- Splitting on the middle column halves the matrix every call, yet the algorithm is $\Theta(n\log n)$ rather than $\Theta(n)$. Where does the argument break?
> - **Hint:** Write out the per-level work, not the per-level subproblem count.
> > [!SUCCESS]- Answer
> > - **Short answer:** the sub-matrix is $n\times\tfrac n2$, so the deciding scan is a **full-length column** at every level — $\Theta(n)$ for all $\log_2 n$ levels ⟹ $\Theta(n\log n)$.
> > - **Why:** **Only shrinking work sums geometrically** ➔ $T(n)=T(n/2)+\Theta(n)$ collapses to $\Theta(n)$ only when the $\Theta(n)$ shrinks with the argument; halving one axis halves the *cell count* but not the *scan length*.

> [!FAQ]- Justify discarding three of the four quadrants after finding a neighbour $y>x$.
> - **Hint:** Imagine walking uphill from $y$ and ask what would have to happen to escape.
> > [!SUCCESS]- Answer
> > - **Short answer:** a strictly-increasing walk from $y$ cannot re-enter the cross (every cross cell is $\le x<y$), and a finite grid of distinct values makes it terminate — so a peak of $M$ exists inside the quadrant holding $y$.
> > - **Why:** **The cross is a one-way barrier** ➔ leaving the quadrant would require stepping *down*, which uphill movement forbids. The argument certifies existence without locating the peak — exactly what a D&C correctness proof needs.

> [!FAQ]- Why replace the cross with a window frame, given both cost $\Theta(n)$?
> - **Hint:** Ask what a sub-matrix does *not* know about itself.
> > [!SUCCESS]- Answer
> > - **Short answer:** without the boundary rows and columns, a sub-matrix's local winner may be beaten by a cell just outside it ($340$ against $503$), so the algorithm can return a non-peak.
> > - **Why:** **Correctness needs the boundary in scope** ➔ including the first and last rows/columns restores the invariant "the reported cell beats its neighbours in $M$"; six lines instead of two is a constant factor.
