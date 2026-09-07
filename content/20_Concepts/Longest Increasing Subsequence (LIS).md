---
unit: FIT2004
week: 7
source: [lecture, applied]
domain: A
parent: "[[Dynamic Programming]]"
tags: [CS/Algorithms]
aliases: [LIS, Longest Increasing Subsequence, Longest Chain, Box Stacking]
---
# [[Longest Increasing Subsequence (LIS)]]

**Context:** [[FIT2004_MOC]] · the *credit-level* classical [[Dynamic Programming|DP]] problem, and the vault's standing counterexample to **"the answer is the last cell"**
**Parent Framework:** [[Dynamic Programming]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\text{DP}[i]=$ the length of the longest increasing subsequence **ending at position $i$** ➔ answer $=\max_i \text{DP}[i]$, **not** $\text{DP}[n]$.
> - **📦 Core Components:** $n$ subproblems ➔ each scans all earlier positions $O(n)$ ⟹ $\Theta(n^{2})$ time, $\Theta(n)$ space.
> - **⚡ Key Constraint:** the subproblem must be **anchored** — *"ending at $i$"* — because a free-floating *"LIS of $a[1..i]$"* cannot be extended, since it does not say what the last element is.

## 📝 How It Works
### 1. Why the Subproblem Must Be Anchored
- **The observation** ➔ take an LIS $a_{j_1},\dots,a_{j_k}$; every **prefix** of it $a_{j_1},\dots,a_{j_{k-1}}$ is itself a **longest** increasing subsequence *among those ending at position $j_{k-1}$*.
- **The proof shape** ➔ if it were not longest, swapping in the longer one would give a longer LIS overall — contradiction. That is the optimal-substructure argument, and it is what forces the anchor.
- **What the anchor buys** ➔ knowing the last element lets you test extendability with a single comparison $a[j]<a[i]$; without it there is nothing to compare against.
- **What the anchor costs** ➔ the answer is no longer a single cell. $\text{DP}[n]$ is the LIS ending at the **last** element, and the true LIS need not include it ➔ **scan the table**.

### 2. The Recurrence
$$
\text{DP}[i]=1+
\begin{cases}
0 & a[i]\le a[j]\ \text{for all } j<i \\
\displaystyle\max_{\substack{1\le j<i\\ a[j]<a[i]}}\text{DP}[j] & \text{otherwise}
\end{cases}
$$
- **Read it aloud** ➔ *"element $i$ itself, plus the best chain I can hang it onto."*
- **The base is inside the general case** ➔ the first clause is the **edge case**: no smaller predecessor exists, so $\text{DP}[i]=1$ *(the singleton subsequence)*. Writing it as $\text{DP}[1]=1$ only is wrong — any $i$ can be a minimum-so-far.
- **Strict $<$, not $\le$** ➔ the problem says *strictly increasing*; $\le$ silently solves the non-decreasing problem and duplicates get chained.
- **Answer** ➔ $\displaystyle\max_{1\le i\le n}\text{DP}[i]$.

### 3. Complexity, and Where Each Factor Comes From
- **Subproblems** ➔ $n$, one per position ⟹ auxiliary space $\Theta(n)$ *(1-D MEMO ➔ [[Dynamic Programming]] §5)*.
- **Work per subproblem** ➔ the inner $\max$ scans every $j<i$ ⟹ $O(n)$.
- **Total** ➔ $n\times O(n)=\Theta(n^{2})$ time. The final $\max$ scan adds $\Theta(n)$ and is dominated.
- **No best/worst split** ➔ both loops are input-independent, so best $=$ average $=$ worst $=\Theta(n^{2})$; only the *reconstruction* length varies.

### 4. Reconstruction — Which Elements, Not Just How Many
- **Store the argmax** ➔ `pred[i] = the j that achieved the maximum`, `None` when the edge case fired.
- **Start at the argmax of the whole table**, not at $n$ — the single most common LIS bug.
- **Backtrack and reverse** ➔ the same breadcrumb walk as [[Dijkstra's Algorithm|Dijkstra]]'s `previous` ➔ [[Dynamic Programming]] §7.
- **Ties give different, equally valid answers** ➔ state your tie-break rule *(e.g. smallest $j$)* before hand-tracing, exactly as for a [[Minimum Spanning Tree|MST]] trace.

### 5. LIS in Disguise — the Box-Stacking Reduction *(applied P17)*
- **Problem** ➔ $n$ box types, each rectangular; a box may sit on another **iff** both base dimensions are **strictly** smaller; boxes may be rotated and reused. Maximise tower height.
- **Kill the rotation first** ➔ make **six** copies of every box, one per orientation ⟹ $6n$ boxes and no rotation logic. The constant $6$ vanishes into the bound.
- **Reuse becomes impossible for free** ➔ base dimensions must strictly decrease going up, so no box type can recur; the copies make that automatic.
- **The recurrence is LIS with a 2-D order**
$$
\text{DP}[i]=h_i+
\begin{cases}
0 & \text{no box } j \text{ with } w_j<w_i \text{ and } l_j<l_i \\
\displaystyle\max_{\substack{1\le j\le 6n\\ w_j<w_i,\ l_j<l_i}}\text{DP}[j] & \text{otherwise}
\end{cases}
$$
- **Same shape, three substitutions** ➔ *"length $+1$"* becomes *"height $+h_i$"*; the scalar test $a[j]<a[i]$ becomes the **pair** test $w_j<w_i \wedge l_j<l_i$; the answer is still $\max_i\text{DP}[i]$, never $\text{DP}[6n]$.
- **Cost** ➔ $O(n)$ subproblems $\times$ $O(n)$ scan $=\Theta(n^{2})$.
- **The transferable move (LO1)** ➔ *longest chain under any strict partial order* is LIS; recognising the order is the whole problem.

## ⚙️ Core Implementation
### 🔹 LIS with reconstruction
> [!code]- Code
> ```python
> def lis(a):                                  # a[0..n-1], strictly increasing
>     n = len(a)
>     DP   = [1] * n                           # edge case: every element alone
>     pred = [None] * n
>     for i in range(1, n):
>         for j in range(0, i):                # O(n) work per subproblem
>             if a[j] < a[i] and DP[j] + 1 > DP[i]:
>                 DP[i]   = DP[j] + 1
>                 pred[i] = j
>
>     best = 0                                 # SCAN - the answer is not DP[n-1]
>     for i in range(1, n):
>         if DP[i] > DP[best]:
>             best = i
>
>     seq = []                                 # backtrack, then reverse
>     k = best
>     while k is not None:
>         seq.append(a[k])
>         k = pred[k]
>     lo, hi = 0, len(seq) - 1
>     while lo < hi:
>         seq[lo], seq[hi] = seq[hi], seq[lo]
>         lo += 1
>         hi -= 1
>     return DP[best], seq
> ```
> 💡 **Common Mistake:** **Returning `DP[n-1]`** ➔ that is the LIS *ending at the last element*. On $\{1,2,3,0\}$ it returns $1$ instead of $3$.
> 💡 **Common Mistake:** **Using `a[j] <= a[i]`** ➔ solves the **non-decreasing** problem; on $\{5,5,5\}$ it answers $3$ where the strict answer is $1$.

> [!NOTE] 🔭 **Beyond the lecture** *(not in the slides)*: LIS also has an $O(n\log n)$ solution that keeps the smallest possible tail for each achievable length and places each element by [[Binary Search|binary search]]. FIT2004's applied sheet asks for $O(n^{2})$; do not offer the faster one as the unit's method.

## ⚖️ Complexity
| Case | Time | Auxiliary space | Trigger |
| :--- | :--- | :--- | :--- |
| Best $=$ Average $=$ Worst | $\Theta(n^{2})$ | $\Theta(n)$ | two nested loops, no early exit — input-independent |
| Reconstruction pass | $O(n)$ | $\Theta(n)$ for `pred` | the chain is at most $n$ long |
| Box stacking *(§5)* | $\Theta(n^{2})$ | $\Theta(n)$ | $6n$ boxes ⟹ the $6$ is a constant |

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
$a=\{0,8,4,12,2,10,6,14,1,9,5,13,3,11,7,15\}$ *(the applied sheet's instance)*. Tie-break: **smallest $j$**.

| $i$ | $a_i$ | Candidates $j$ with $a_j<a_i$ *(best $\text{DP}[j]$)* | $\text{DP}[i]$ | $\text{pred}[i]$ |
| :--- | :--- | :--- | :--- | :--- |
| $1$ | $0$ | — | $1$ | — |
| $2$ | $8$ | $1{:}0\ (1)$ | $2$ | $1$ |
| $3$ | $4$ | $1{:}0\ (1)$ | $2$ | $1$ |
| $4$ | $12$ | $2{:}8\ (2)$ | $3$ | $2$ |
| $5$ | $2$ | $1{:}0\ (1)$ | $2$ | $1$ |
| $6$ | $10$ | $2{:}8\ (2)$ | $3$ | $2$ |
| $7$ | $6$ | $3{:}4\ (2)$ | $3$ | $3$ |
| $8$ | $14$ | $4{:}12\ (3)$ | $4$ | $4$ |
| $9$ | $1$ | $1{:}0\ (1)$ | $2$ | $1$ |
| $10$ | $9$ | $7{:}6\ (3)$ | $4$ | $7$ |
| $11$ | $5$ | $3{:}4\ (2)$ | $3$ | $3$ |
| $12$ | $13$ | $10{:}9\ (4)$ | $5$ | $10$ |
| $13$ | $3$ | $5{:}2\ (2)$ | $3$ | $5$ |
| $14$ | $11$ | $10{:}9\ (4)$ | $5$ | $10$ |
| $15$ | $7$ | $7{:}6\ (3)$ | $4$ | $7$ |
| $16$ | $15$ | $12{:}13\ (5)$ | $\mathbf{6}$ | $12$ |

**Final Extracted Output:** $\max_i\text{DP}[i]=\mathbf{6}$ at $i=16$; backtracking $16\to12\to10\to7\to5\to1$ yields $\{0,2,6,9,13,15\}$. The sheet's $\{0,2,6,9,11,15\}$ is **equally valid** — the tie at $i=16$ between $j=12\ (13)$ and $j=14\ (11)$ is broken by the stated rule, and both give length $6$.

- **Read the trap** ➔ $\text{DP}[13]=3$ while $\text{DP}[12]=5$: the table is **not monotone**, so the final $\max$ scan is mandatory. Here the argmax happens to land on $i=n$; do not let that coincidence become a habit.
- **Read the shape** ➔ every row is *"my own element, plus the tallest chain among strictly smaller earlier elements"* — the same sentence as box stacking with the order swapped.

### Applied Exercise — turn a stacking problem into LIS *(P17)*
**Problem:** show that $6$ copies per box type make the *"no reuse"* rule automatic.
$$
\begin{aligned}
\text{Stacking rule} &\Rightarrow w_{\text{above}}<w_{\text{below}} \ \text{and}\ l_{\text{above}}<l_{\text{below}} \\
\Rightarrow\ & \text{the base dimensions are } \textbf{strictly decreasing} \text{ up the tower} \\
\Rightarrow\ & \text{no orientation can appear twice, so "as many as you like" is unreachable.}
\end{aligned}
$$
**Final Extracted Output:** the $6n$-copy formulation needs **no** reuse bookkeeping, and $\Theta((6n)^{2})=\Theta(n^{2})$. **The reusable move:** enumerate the finitely many configurations of an object up front, and a constraint that looked stateful becomes a property of the ordering.

## ⚠️ Common Mistakes
- 💡 **Answer $=\text{DP}[n]$** ➔ the anchored subproblem forces a $\max$ scan; this is the single most-marked LIS error and the wrap-up flags it explicitly.
- 💡 **Defining $\text{DP}[i]$ as "the LIS of $a[1..i]$"** ➔ unanchored, so the recurrence cannot test extendability and the definition is unusable. Fix the definition, not the code.
- 💡 **Non-strict comparison** ➔ answers a different problem; state *strictly increasing* in the subproblem sentence.
- 💡 **Quoting $O(n)$ space as $O(n^{2})$** ➔ the MEMO is 1-D; the $n^{2}$ is the inner **scan**, i.e. time ➔ [[Dynamic Programming]] §5.
- 💡 **Reconstructing from $\text{DP}$ alone without `pred`** ➔ possible but fiddly; store the argmax, it is $\Theta(n)$ and free within the existing bound.

## 🧠 Active Recall
> [!FAQ]- Why must the LIS subproblem be *"ending at $i$"*, and what does that cost you when reading the answer?
> > [!SUCCESS]- Answer
> > - **Short answer:** the anchor names the last element, which is the only thing that makes a chain **extendable**; the cost is that the answer becomes $\max_i\text{DP}[i]$ instead of a fixed cell.
> > - **Why:** **Optimal substructure needs the prefix to be optimal *for its endpoint*** ➔ a prefix of an LIS is a longest increasing subsequence ending at that earlier element, else it could be swapped for a longer one. **Extendability is a comparison** ➔ $\text{DP}[i]$ can build on $\text{DP}[j]$ only when $a[j]<a[i]$, which requires knowing $a[j]$ is the chain's last element. **The unanchored definition is not wrong, it is unusable** ➔ *"the LIS of $a[1..i]$"* gives no way to decide whether $a[i]$ can be appended.

> [!FAQ]- You are given boxes with widths, lengths and heights and asked for the tallest legal tower. Reduce it.
> - **Hint:** what is being made longest, and under which order?
> > [!SUCCESS]- Answer
> > - **Short answer:** it is LIS with the scalar order replaced by strict dominance on $(w,l)$ and the $+1$ replaced by $+h_i$; make $6$ oriented copies of each box first.
> > - **Why:** **The rotation is finite** ➔ six orientations per box, so $6n$ items and the recurrence never mentions rotation ➔ the constant is absorbed. **Reuse solves itself** ➔ dimensions strictly decrease up the tower, so no orientation recurs. **The recurrence is unchanged in shape** ➔ $\text{DP}[i]=h_i+\max\{\text{DP}[j]: w_j<w_i,\ l_j<l_i\}$, answer $\max_i\text{DP}[i]$, cost $\Theta(n^{2})$ — recognising *longest chain under a strict partial order* is the LO1 skill being examined.
