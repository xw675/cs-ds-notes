---
unit: FIT2004
week: 7
source: [lecture, applied]
domain: A
parent: "[[Algorithm]]"
tags: [CS/Algorithms]
aliases: [DP, DPA, Memoization, Memoisation, Optimal Substructure, Overlapping Subproblems, Tabulation, Decision Array]
---
# [[Dynamic Programming]]

**Context:** [[FIT2004_MOC]] · **PT-02's entire subject** — brute force made cheap by never recomputing a subproblem; the sibling paradigm to [[Greedy Algorithm|greedy]] and [[Divide and Conquer|divide & conquer]]
**Parent Framework:** [[Algorithm]]

> [!abstract] Quick Revision
> - **🎯 Objective:** the lecture's **DPA**: take the problem ➔ **break it down** *(subproblems that are optimal and overlap)* ➔ **memoise** ➔ **reconstruct** *(decision array or backtracking)*.
> - **📦 Core Components:** **overlapping subproblems** ➔ reuse instead of recompute | **optimal substructure** ➔ an optimum is built from optima of subproblems.
> - **⚡ Key Constraint:** the marks are in the **recurrence relation**, and this recurrence describes the **output** stored in the MEMO — a different animal from PT-01's *time-complexity* [[Recurrence Relation|recurrence]]. Confusing the two answers the wrong question fluently.

## 📝 How It Works
### 1. Brute Force, But Smarter *(the paradigm)*
- **Why it is brute force** ➔ it still considers **every combination / choice**; the choices are what the subproblems enumerate. *"Can we brute force everything? Yes — but brute forcing needs too much effort."*
- **Why it is faster** ➔ it **does not recompute**. A subproblem solved once is read from the table forever after.
- **What it costs** ➔ **memoisation**: the table is auxiliary space that brute-force recursion never paid for.
- **The self-check** ➔ **auxiliary space $\le$ time** — every cell must be written at least once, so a DP whose quoted time is below its table size is arithmetically impossible ([[Algorithmic Complexity]] §6).
- **Why DP is hard** ➔ *"it isn't easy to break problems down."* The cure the lecturer prescribes is **practice on the classical problems** *(§11)*, not a formula.

### 2. The Two Ingredients — and the Paradigm Boundary *(LO1)*
- **Overlapping subproblems** ➔ the same subproblem is reached by many different choice sequences, so storing its answer pays for itself.
- **Optimal substructure** ➔ an optimal solution to the whole contains optimal solutions to its parts, so a table of sub-optima suffices.
- **vs [[Divide and Conquer]] — the lecture's exact answer** ➔ the two skeletons *look* identical *(take a big thing, divide, solve the smaller one, combine back up)*. The difference is **two words** inserted into the third step: the sub-solutions are **OPTIMAL**, and they are **reusable because the subproblems overlap**. D&C's subproblems are **disjoint** — [[Merge Sort]]'s halves share nothing — so there is nothing to reuse and no notion of an optimal subsolution.
- **vs [[Greedy Algorithm|greedy]]** ➔ greedy needs optimal substructure **and** the greedy-choice property, and commits irrevocably. DP keeps **every** subproblem's answer and combines them later, which is exactly what buys correctness when no ranking rule is safe *(weighted interval scheduling · [[Coin Change]] on $\{1,5,6,9\}$ · the coin game)*.
- **[[Dijkstra's Algorithm|Dijkstra]] is both** ➔ DP in its reuse of sub-minima, greedy in its finalisation. [[Bellman-Ford]] and [[Floyd-Warshall]] drop the greedy half and are pure DP.

### 3. Fibonacci — the Motivating Example
- **The repetition is the opportunity** ➔ expanding $F(6)$ recursively recomputes $F(4)$ twice, $F(3)$ three times, $F(2)$ five times. *"We are repeating — adding complexity!"*
- **The everyday analogy** ➔ compute $12\times12$ **once**, then reuse it for $12\times13$ and $12\times14$. That reuse **is** memoisation.
- **Top-down** ➔ start at the top, keep breaking into smaller problems *(the smallest is the base case)*, then solve upward **reusing the stored results**. The shape is the recursion tree with a memo attached.
- **Bottom-up** ➔ start **from the base case**, solve it, use it for the next bigger case, and continue until the final one. The shape is a loop over a table.
- **What memoisation buys here** ➔ each $F(k)$ is computed once ⟹ $\Theta(N)$ time, against the naive branching recursion's $O(2^{N})$ ➔ [[Fibonacci Sequence]] for the closed forms and the doubling identities.
- **Why it is the right first example** ➔ one parameter, one obvious base case, and the repeated subtree is visible on a slide — everything after this differs only in how hard the *subproblem definition* is.

### 4. The MEMO **Is** the Subproblem Definition
- **Write it as an English sentence in braces, always** ➔ `DP[i] = {the maximum profit obtainable from a subset of the houses [1..i]}`. If you cannot write that sentence, you do not have a DP yet.
- **The MEMO's dimensions are the subproblem's parameters** ➔ one index per thing the answer genuinely depends on; a wrong dimension count is a wrong subproblem definition, not a coding slip.
- **The MEMO shows how the solution is formed from subsolutions** ➔ the recurrence is read off the definition, never invented alongside it.
- **Iterate steps 1–2 of the recipe** ➔ *"while some definitions seemed correct, it isn't the case always"* — brute-force first, then define, then re-check the definition against the brute force.
- **Locate the answer at definition time** ➔ is it the final cell ([[Coin Change]], the salesman, [[Longest Common Subsequence (LCS)|LCS]]) or a **scan** over the table? Not always the last position — [[Longest Increasing Subsequence (LIS)|LIS]] is the standing counterexample.

### 5. The Recurrence — Three Groups of Cases
- **Base case(s)** ➔ the initial values you write in directly; each has exactly **one** optimal solution with **no ambiguity**, and they always exist because backtracking must terminate somewhere.
- **General case** ➔ the subproblems proper; the value comes from other subproblems' solutions, and this line is where the **decision** (`max` / `min` / sum / boolean `or`) is written. It usually contains the final answer.
- **Edge case(s)** ➔ boundary subproblems that *look* general but need **no decision**, like the base cases — a grid's top row and rightmost column, a value below the smallest coin, a knapsack with no capacity left. They may overlap with the other two depending on how you write it.
- **Order matters when cases overlap** ➔ if two cases can both fire, say *"cases are read top to bottom, first match wins"* (the wildcard-matching problem does exactly this).
- **The canonical worked recurrence** ➔ [[Coin Change]] §2 — every PT-02 problem so far has been that shape in costume.

### 6. Sizing the MEMO ⟹ Sizing the Complexity
- **Auxiliary space $=$ the table** ➔ 1-D $O(N)$ · 2-D $O(N\cdot M)$ · 3-D $O(N\cdot M\cdot L)$; these dimensions **are** the number of subproblems.
- **Time $=$ subproblems $\times$ work per subproblem** ➔ [[Coin Change]] has $M$ subproblems *(plus $1$ for $v=0$)* and scans all $N$ coins at each ⟹ $O(NM)$; the salesman's $n$ subproblems each cost $O(1)$ ⟹ $\Theta(n)$.
- **The choice set is not a dimension** ➔ coins and items are the *choices combined inside* a subproblem. Miscounting them as a dimension is the highest-frequency complexity error in this topic.
- **The table is a lower bound on time** ➔ filling every cell costs $\ge1$ step each ➔ §1's self-check.
- **A redundant parameter can be deleted** *(applied P8, P13 — the `[D]` move)* ➔ if one index is **derivable** from the others, drop it and recompute it. The ferry problem's $\text{DP}[i,L_1,L_2]$ collapses to $\text{DP}[i,L_1]$ because $L_2=2L-L_1-\sum_{j<i}\ell_j$, turning $O(nL^{2})$ into $\Theta(nL)$; the interleaving problem's $\text{DP}[i,j,k]$ collapses to $\text{DP}[i,j]$ because $k=i+j-1$. **Precompute the prefix sums in $\Theta(n)$** so the recomputation stays $O(1)$.
- **The mirror move — add a dimension when the state is insufficient** ➔ if the optimum must revisit a position, the position is **not a sufficient state** *(applied P7: `DPleft` and `DPright`, because which side of the street you are on changes your options)*. This is the same question that separates unbounded from 0/1 [[Knapsack Problem|knapsack]], and it is [[State-Space Graph Modelling]]'s test applied to a DP parameter.

### 7. Top-Down vs Bottom-Up
- **Complexity-wise they are the same** ➔ both fill the same table with the same recurrence, and *"technically both are interchangeable."*
- **Top-down** ➔ large problem to small, so **recursion** with a memo is natural; **might save some computations**, since only the subproblems the recurrence actually reaches are ever visited.
- **Bottom-up** ➔ small to large, so **iteration**; **might save space, especially since there is no recursion** *(no $\Theta(\text{depth})$ call stack)*, and it makes the fill order explicit.
- **The lecturer's habit** ➔ *"I only use bottom-up"*, while noting some problems are more intuitive top-down.
- **Fill order is a correctness condition, not a style choice** ➔ a bottom-up loop must visit each cell **after** every cell it reads. The grid recurrences below index $i+1$ and $j+1$, so the loops run **downward**; [[Interval Dynamic Programming|interval DP]] must loop on range **length**.
- **Sentinel discipline for a memo** ➔ the *"not yet computed"* marker must lie **outside** the answer's range, which is why [[Coin Change]] initialises to $-1$ and never to $\infty$.

### 8. Reconstruction — Decision Array vs Backtracking
- **The question is usually "which", not "how much"** ➔ [[Coin Change|coin change]] *"what are the coins?"* · [[Knapsack Problem|knapsack]] *"what are the items?"* · edit distance *"what were the insert/delete/replace operations?"*
- **Decision array** ➔ at the moment you write a cell, also record the **decision** that produced it *(which coin, which item, which predecessor)*, then walk those records back from the answer cell.
- **Store the final decision only, never the whole combination** ➔ writing the full coin list at every value is $O(N^{2})$ *"a waste of memory"*; remembering the **last coin added** is $\Theta(M)$ and determines the rest by recursion.
- **Backtracking** ➔ store nothing extra and re-derive each decision from the table: *"which case could have produced this cell?"* This is what the lecture calls **leaving breadcrumbs**.
- **Inclusion–exclusion is the backtracking test** ➔ compare a cell with the cell the *skip* branch would have produced. [[Knapsack Problem|0/1 knapsack]] compares against the **row above** *(same ⟹ excluded)*; the salesman takes house $i$ **iff** $\text{DP}[i]>\text{DP}[i-1]$.
- **Step size encodes the constraint** ➔ after taking house $i$ jump to $i-2$ *(neighbour $i-1$ is now illegal)*; after including a knapsack item, move up a row **and** left by its weight.
- **The trade-off, as stated** ➔ **backtracking saves space** *(less auxiliary space, same space complexity)*; **the decision array saves time** *(faster, because the decision is read rather than re-derived)* — but either way *"the time complexity lies in finding the solution still."*
- **Reconstruction is what kills space-saving tricks** ➔ rolling a 2-D table down to two rows computes the value and deletes the breadcrumbs ➔ [[Knapsack Problem]] §4.

### 9. Subproblem Shapes That Keep Recurring *(the applied sheet, curated)*
- **Prefix / suffix, one sequence** ➔ `DP[i]` over $[1..i]$ or $[i..n]$; take-or-skip decisions. *(salesman houses · [[Coin Change]] · [[Longest Increasing Subsequence (LIS)|LIS]])*
- **Partition a sequence — try every cut** ➔ `DP[i] = best over j > i of (cost of the block [i..j-1] + DP[j])`. One shape covers **word break** *(min words forming the suffix $S[i..n]$)*, **text justification** *(min $\sum(w-\text{len})^{3}$)* and the **umbrella walk** *(min energy from important point $i$)*. Cost per subproblem is $O(n)$ ⟹ $O(n^{2})$ unless the block cost can be made $O(1)$.
- **Two prefixes, one grid** ➔ `DP[i][j]` over prefixes of two sequences ➔ [[Longest Common Subsequence (LCS)]].
- **A contiguous range** ➔ `DP[i][j]` over $a[i..j]$ ➔ [[Interval Dynamic Programming]].
- **Capacity against an item set** ➔ `DP[i][w]` ➔ [[Knapsack Problem]].
- **A 2-D grid with directional moves** ➔ `DP[i][j]` over cells, recursing on the legal moves ➔ §10.
- **A rooted tree** ➔ `DP[v]` over subtrees, combining children *(applied P20: the message broadcast, children served in **descending** $\text{DP}$ order, $\Theta(n)$ with [[Counting Sort|counting sort]])*.

### 10. Grid DP — Two Problems, One Recurrence *(applied P2, P3)*
- **Count the paths** ➔ `DP[i][j] = {the number of valid paths from cell (i,j) to (n,n)}`, moving up or right, blocked cells excluded:
$$
\text{DP}[i,j]=
\begin{cases}
1 & (i,j)=(n,n) \\
0 & (i,j)\ \text{is blocked} \\
\text{DP}[i,j+1] & i=n \\
\text{DP}[i+1,j] & j=n \\
\text{DP}[i+1,j]+\text{DP}[i,j+1] & \text{otherwise}
\end{cases}
$$
- **Why the two path sets do not overlap** ➔ paths through $(i+1,j)$ and through $(i,j+1)$ are disjoint, because a valid path cannot use both; so the counts **add** rather than needing inclusion–exclusion.
- **Collect the most money** ➔ the same skeleton with $\max$ instead of $+$ and the cell's value added: $\text{DP}[i,j]=c_{i,j}+\max(\text{DP}[i,j+1],\text{DP}[i+1,j])$, with the top row and rightmost column as edge cases and $\text{DP}[n,n]=c_{n,n}$.
- **Answer** ➔ $\text{DP}[1,1]$ in both; $n^{2}$ subproblems at $O(1)$ ⟹ $O(n^{2})$ time and space.
- **Symmetry** ➔ defining $\text{DP}'[i,j]$ as *paths from $(1,1)$ to $(i,j)$* and reading $\text{DP}'[n,n]$ is equally valid — the base and edge cases mirror. **Pick one direction and keep the indices consistent**; mixing them is the classic grid bug.
- **The three edge cases are the boundary** ➔ top row ($i=n$) and rightmost column ($j=n$) have only one legal move, so they are decision-free ➔ §5.

### 11. The Classical Problem Roster *(know where each one lives)*
| Problem | Tier | Shape | Note |
| :--- | :--- | :--- | :--- |
| [[Fibonacci Sequence\|Fibonacci]] | pass | 1-D, one predecessor pair | the motivating example ➔ §3 |
| [[Coin Change]] | pass | 1-D over value, $N$ choices | **PT-02's costume of choice** |
| [[Knapsack Problem\|Unbounded knapsack]] | pass | 1-D over weight | coin change with $\max$, init $0$ |
| [[Knapsack Problem\|0/1 knapsack]] | pass | 2-D, items $\times$ weight | the row is *"which items are on offer"* |
| Rod cutting | pass | 1-D over length | on the wrap-up's list; **not in the lecture deck** — it is unbounded knapsack with length as weight |
| Edit distance | pass | 2-D, two prefixes | **deliberately skipped in the lecture**, covered in the tutorial videos **linked to** [[Longest Common Subsequence (LCS)\|LCS]] |
| [[Longest Common Subsequence (LCS)\|LCS]] | credit | 2-D, two prefixes | the sheet's hint calls it *"very similar to edit distance"* |
| [[Longest Increasing Subsequence (LIS)\|LIS]] | credit | 1-D, **anchored** | answer is a scan, not the last cell |
| Matrix chain multiplication | credit | range, split at $k$ | ➔ [[Interval Dynamic Programming]] §5 |
| Everything on the applied sheet | credit$+$ | various | ➔ §9 and [[FIT2004 Unit Cheatsheet]] §1️⃣2️⃣ |

## ⚙️ Core Implementation
### 🔹 The salesman's houses — fill $+$ inclusion–exclusion backtracking *(applied P1)*
> [!code]- Code
> ```python
> def salesman(c):                     # c[1..n], profit from house i
>     n = len(c) - 1
>     DP = [0] * (n + 1)               # DP[0] = 0            (base)
>     DP[1] = c[1]                     #                      (base)
>     for i in range(2, n + 1):        # general case
>         skip = DP[i - 1]
>         take = DP[i - 2] + c[i]
>         DP[i] = take if take > skip else skip
>
>     houses = []                      # rebuild WITHOUT a decision array
>     i = n
>     while i > 0:
>         if DP[i] > DP[i - 1]:        # branch 2 won => house i was sold to
>             houses.append(i)
>             i -= 2                   # neighbour i-1 is now illegal
>         else:
>             i -= 1
>     return DP[n], houses
> ```
> 💡 **Common Mistake:** **Decrementing by $1$ after taking house $i$** ➔ house $i-1$ is its neighbour and cannot also be sold to; the step size **is** the constraint, and $-1$ silently produces an illegal set with a legal-looking total.
> 💡 **Common Mistake:** **Testing $\text{DP}[i]\ge\text{DP}[i-1]$** ➔ on a tie the skip branch is the one that won, so a non-strict test invents a house that was never sold to.

## ⚖️ Core Decision Matrix
| Situation | Paradigm | Why | Deliverable |
| :--- | :--- | :--- | :--- |
| Subproblems **disjoint**, no optimisation | [[Divide and Conquer]] | nothing repeats ⟹ no table pays for itself | the split/combine step |
| Optimal substructure $+$ **greedy-choice property** | [[Greedy Algorithm\|Greedy]] | one irrevocable choice per step skips the search | the exchange / stays-ahead **proof** |
| Optimal substructure, **no** safe ranking rule | **Dynamic programming** | keep every subproblem's answer, decide later | the **recurrence relation** |
| Overlapping subproblems, no optimisation *(counting)* | **Dynamic programming** | reuse still removes the exponential | the recurrence, with $+$ not $\max$ |
| Neither property holds | brute force / backtracking | exhaustive $2^{N}$ or $N!$ | the search-space bound |

> [!NOTE] **When It Flips:** the boundary between [[Greedy Algorithm|greedy]] and DP is the **greedy-choice property alone** — both need optimal substructure. Weighted interval scheduling keeps the substructure and loses the choice property, so it flips to DP; [[Coin Change|coin change]] on $\{1,5,6,9\}$ and the coin game flip for the same reason.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — the salesman, $n=10$
$c=[50,10,12,65,40,95,100,12,20,30]$, $\text{DP}[i]=\max(\text{DP}[i-1],\ \text{DP}[i-2]+c_i)$ for $i>1$, $\text{DP}[1]=c_1$, $\text{DP}[0]=0$.

| $i$ | $c_i$ | $\text{DP}[i-1]$ *(skip)* | $\text{DP}[i-2]+c_i$ *(take)* | $\text{DP}[i]$ | Winner |
| :--- | :--- | :--- | :--- | :--- | :--- |
| $1$ | $50$ | — | — | $50$ | base |
| $2$ | $10$ | $50$ | $0+10=10$ | $50$ | skip |
| $3$ | $12$ | $50$ | $50+12=62$ | $62$ | **take** |
| $4$ | $65$ | $62$ | $50+65=115$ | $115$ | **take** |
| $5$ | $40$ | $115$ | $62+40=102$ | $115$ | skip |
| $6$ | $95$ | $115$ | $115+95=210$ | $210$ | **take** |
| $7$ | $100$ | $210$ | $115+100=215$ | $215$ | **take** |
| $8$ | $12$ | $215$ | $210+12=222$ | $222$ | **take** |
| $9$ | $20$ | $222$ | $215+20=235$ | $235$ | **take** |
| $10$ | $30$ | $235$ | $222+30=252$ | $\mathbf{252}$ | **take** |

**Backtracking pass** *(inclusion–exclusion, no decision array)*

| $i$ | $\text{DP}[i]$ vs $\text{DP}[i-1]$ | Action | Next $i$ |
| :--- | :--- | :--- | :--- |
| $10$ | $252>235$ | take $10$ | $8$ |
| $8$ | $222>215$ | take $8$ | $6$ |
| $6$ | $210>115$ | take $6$ | $4$ |
| $4$ | $115>62$ | take $4$ | $2$ |
| $2$ | $50\not>50$ | skip | $1$ |
| $1$ | $50>0$ | take $1$ | $-1$ ➔ stop |

**Final Extracted Output:** $\mathbf{\$252}$ from houses $\{1,4,6,8,10\}$ — matching the sheet. Note the **greedy trap**: house $7$ has the largest single profit ($100$) and is **not** in the optimum.

- **Read the trap** ➔ the *taken* set is not the set of rows where "take" won during the fill; only the backtracking pass identifies it. Row $9$'s take branch won yet house $9$ is not sold to.

### Applied Exercise — the PT-02 recurrence-selection question *(sample [PT2W8])*
**Problem:** microwave keys $K=\{1,10,60\}$, each pressable any number of times. $\text{minPresses}[t]=$ the minimum key presses to enter time $t$. Select the correct clauses.
$$
\text{minPresses}[t]=
\begin{cases}
0 & t=0 \quad\textbf{(base)} \\
\infty & t<0 \quad\textbf{(edge — an overshoot is illegal, not free)} \\
\displaystyle\min_{k\in K}\bigl(\text{minPresses}[t-k]\bigr)+1 & \text{otherwise}\quad\textbf{(general)}
\end{cases}
$$
**Final Extracted Output:** clauses **(a), (g), (i)**. **Why each rival dies:** `∞ if t ≤ 0` contradicts the $t=0$ base · `1 if t=0` charges a press for entering nothing · `max` maximises presses · $\sum$ counts every key instead of choosing one · dropping the $+1$ forgets to charge for the press just made. **Sanity check the definition, not the algebra:** $t=25\Rightarrow7$ presses *(two $10$s, five $1$s)*.
- **The transferable move** ➔ this is [[Coin Change]] with $c=K$ and $v=t$. **Every PT-02 problem is a classical problem in costume** — identify the costume first ➔ §11.

## ⚠️ Common Mistakes
- 💡 **Writing a time-complexity recurrence instead of an output recurrence** ➔ PT-01's $T(n)=2T(n/2)+\Theta(n)$ describes *cost*; PT-02's $\text{DP}[i]=\dots$ describes *the answer stored in cell $i$*. Same word, different object.
- 💡 **Counting the choice set as a MEMO dimension** ➔ [[Coin Change|coin change]] is $\Theta(M)$ **space**, not $O(NM)$; the $N$ coins are work *inside* each subproblem, so they appear in the **time** only.
- 💡 **Calling DP "just divide and conquer with a cache"** ➔ the lecture's answer is *"NO"*: D&C subproblems are disjoint and carry no notion of an optimal subsolution ➔ §2.
- 💡 **Assuming the answer is the last cell** ➔ true for [[Coin Change|coin change]] and the salesman, **false** for [[Longest Increasing Subsequence (LIS)|LIS]] and [[Maximum Subarray Sum|maximum subarray]]. Locate the answer when you define the MEMO, not when you debug.
- 💡 **Skipping the edge cases** ➔ a general case that indexes $\text{DP}[i+1]$ on the last row is an out-of-bounds read or a silent wrong answer; the boundary is a *case*, not an implementation detail.
- 💡 **Returning the value when the question asked for the combination** ➔ *"which houses / coins / items"* needs a decision array or a backtracking pass ➔ §8.
- 💡 **Quoting bottom-up as "faster than top-down"** ➔ same complexity; top-down wins only when subproblems can be **skipped**, bottom-up wins on the missing recursion stack and on clarity.

## 🧠 Active Recall
> [!FAQ]- Divide & conquer also splits, solves and recombines. State the lecture's precise reason DP is not the same thing.
> > [!SUCCESS]- Answer
> > - **Short answer:** two words in the third step — the sub-solutions are **optimal**, and they are **reusable because the subproblems overlap**.
> > - **Why:** **D&C subproblems are disjoint** ➔ [[Merge Sort]]'s two halves share no element, so a memo would never be read twice and buys nothing. **D&C has no optimisation notion** ➔ *"the optimal solution to the smaller one"* is meaningless when the subproblem is *sort this half*; DP subproblems each carry a best value that the parent selects among. **The consequence for you** ➔ before writing a table, check that the same subproblem really is reached by many choice paths — no overlap means you have written recursion with extra steps.

> [!FAQ]- What exactly does the MEMO buy you, and what does it cost? State the invariant that links the two.
> > [!SUCCESS]- Answer
> > - **Short answer:** it buys the removal of recomputation on **overlapping subproblems**; it costs auxiliary space equal to the number of subproblems, and **auxiliary space $\le$ time** always.
> > - **Why:** **DP is still brute force** ➔ it enumerates every choice, so the exponent has to be killed somewhere else — the kill is reuse, not a smaller search space. **The table's dimensions are the subproblem parameters** ➔ 1-D $O(N)$, 2-D $O(NM)$, 3-D $O(NML)$, and that count is also the **lower bound on time**, since every cell must be written. **Time $=$ cells $\times$ work per cell** ➔ [[Coin Change|coin change]] is $\Theta(M)$ space and $O(NM)$ time, and the gap between the two is exactly the per-cell coin scan.

> [!FAQ]- Both greedy and DP require optimal substructure. Give a problem where greedy fails, name the missing property, and say what DP does instead.
> - **Hint:** the failure is always a first choice you cannot undo.
> > [!SUCCESS]- Answer
> > - **Short answer:** [[Coin Change|coin change]] on $\{1,5,6,9\}$ wanting $12$ — greedy takes $9{+}1{+}1{+}1$; it lacks the **greedy-choice property**, so DP prices both branches before committing.
> > - **Why:** **The counterexample** ➔ no optimal solution contains the $9$, so an irrevocable largest-first pick cannot be repaired; the optimum is $6+6$. **The missing property named** ➔ optimal substructure survives *(the best way to make $12$ does contain the best way to make $12-c$)*, only the choice property dies ➔ [[Greedy Algorithm]] §2. **The game version** ➔ the coin game fails for the same reason on $2,100,1,1$, and its subproblems are contiguous ranges ➔ [[Interval Dynamic Programming]].

> [!FAQ]- You have the optimal value but the question asks *which items*. Compare your two options and say what each costs.
> > [!SUCCESS]- Answer
> > - **Short answer:** a **decision array** *(record the choice as you write each cell)* or **backtracking** *(re-derive it from the table)*. The array saves time, backtracking saves auxiliary space at the same space complexity.
> > - **Why:** **Store the final decision, never the whole combination** ➔ writing the full coin list per value is $O(N^{2})$ *"a waste of memory"*; the **last coin added** is $\Theta(M)$ and determines everything before it. **Backtracking uses inclusion–exclusion** ➔ compare the cell with what the skip branch would have given: [[Knapsack Problem|0/1 knapsack]] compares against the **row above**, the salesman tests $\text{DP}[i]>\text{DP}[i-1]$, and the step size *(up a row and left by the weight; $i-2$ not $i-1$)* carries the constraint. **Either way the emit cost stands** ➔ *"the time complexity lies in finding the solution still."*

> [!FAQ]- Your 2-D table only ever reads the row above, so you roll it down to two rows. What did you just break?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **reconstruction** — you can still report the optimal value, but not which items produced it.
> > - **Why:** **Backtracking walks the rows you deleted** ➔ recovering the choice at row $i$ needs $\text{DP}[i-1][\cdot]$, and then $\text{DP}[i-2][\cdot]$, all the way to the base ➔ [[Knapsack Problem]] §5. **So the trick is conditional** ➔ *"in reality we can't do this space saving, because we need it to reconstruct the solution."* **State the rule** ➔ asked for the value, roll; asked for the combination, keep the matrix — or pay for a decision array instead, which survives the rolling because it is written at fill time.
