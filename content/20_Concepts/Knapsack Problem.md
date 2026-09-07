---
unit: FIT2004
week: 7
source: [lecture]
domain: A
parent: "[[Dynamic Programming]]"
tags: [CS/Algorithms]
aliases: [Knapsack, 0/1 Knapsack, Unbounded Knapsack, Bounded Knapsack, Space Saving Trick]
---
# [[Knapsack Problem]]

**Context:** [[FIT2004_MOC]] · *"given a limitation (cost), optimise something (profit)"* — the pass-level [[Dynamic Programming|DP]] where the **state question** *"is the weight alone enough?"* decides between a 1-D array and a 2-D matrix
**Parent Framework:** [[Dynamic Programming]]

> [!abstract] Quick Revision
> - **🎯 Objective:** capacity $C$, items with weight and value ➔ maximise total value subject to total weight $\le C$.
> - **📦 Core Components:** **unbounded** *(items unlimited)* ➔ 1-D `memo[weight]`, $O(NM)$ time, $\Theta(M)$ space | **0/1 / bounded** *(each item once)* ➔ 2-D `DP[item][weight]`, $O(NM)$ time **and** space.
> - **⚡ Key Constraint:** the variant changes the **state**, not the recurrence's spirit. Unlimited items ⟹ the item set never shrinks ⟹ weight alone is a sufficient state. Once each item is single-use, *which items remain* must be in the state, and that is the extra dimension.

## 📝 How It Works
### 1. Same Skeleton as [[Coin Change]]
- **The lecturer's own framing** ➔ *"very similar to the coin change, except: finding **maximum** instead of minimum, and **initialised to 0** instead of $\infty$."*
- **Weight plays the role of value** ➔ coin change sweeps target values $0..M$; knapsack sweeps capacities $0..C$.
- **The item is the choice, not the subproblem** ➔ $N$ items are tried *inside* each cell, exactly as $N$ coins were ➔ [[Dynamic Programming]] §5.
- **Initialise to $0$, not $\infty$** ➔ taking nothing is always legal and worth $0$, so there is no *unreachable* case here; a knapsack can always be left empty.
- **Running example** *(both variants)* ➔ capacity $12$ kg.

| Item | $A$ | $B$ | $C$ | $D$ |
| :--- | :--- | :--- | :--- | :--- |
| Weight | $6$ kg | $1$ kg | $5$ kg | $9$ kg |
| Value | $\$230$ | $\$40$ | $\$350$ | $\$550$ |

### 2. Unbounded — One Dimension Is Enough
- **Why weight alone is a sufficient state** ➔ items are unlimited, so after taking one the set of options is **unchanged**; nothing about the past constrains the future except the remaining capacity.
- **MEMO sentence** ➔ `memo[w] = {the maximum value obtainable with total weight at most w}`.
$$
\text{memo}[w]=\max\Bigl(\underbrace{\text{memo}[w-1]}_{\text{carry the best so far}},\ \max_{\substack{1\le i\le N\\ \text{weight}_i\le w}}\bigl(\text{value}_i+\text{memo}[w-\text{weight}_i]\bigr)\Bigr),\qquad \text{memo}[0]=0
$$
- **The carry term is a correctness fix, not decoration** ➔ without it the table means *"maximum value at total weight **exactly** $w$"*, and the answer breaks when the capacity cannot be filled exactly or the optimum sits below it *(e.g. best at $10$ kg with a $12$ kg bag)*. The lecture gives two repairs: `memo[w] = memo[w-1]` **or** a linear search of the memo for its maximum.
- **Hand-filling rule** ➔ at each weight, test every item: too heavy ⟹ skip; fits ⟹ *"optimal of $(w-\text{weight}_i)$ plus this item's value"*, keep the best.
- **Cost** ➔ $C$ cells $\times$ $N$ items $=O(NM)$ time, $\Theta(M)$ auxiliary.

### 3. 0/1 (Bounded) — the Second Dimension Is the Item Set
- **Why the 1-D table now fails** ➔ having taken item $C$, the option set has changed; a 1-D `memo[w]` cannot tell you whether $C$ is still available, so it would happily take it twice.
- **The lecture's framing** ➔ *"grow from $0$ weight to $C$ weight, **and** grow from a set of $0$ items to a set of $N$ items"* — the rows are $\{\}$, $\{A\}$, $\{A,B\}$, $\{A,B,C\}$, $\{A,B,C,D\}$.
- **MEMO sentence** ➔ `DP[i][w] = {the maximum value using only the first i items, with total weight at most w}`.
$$
\text{DP}[i][w]=
\begin{cases}
0 & i=0 \text{ or } w=0 \\
\text{DP}[i-1][w] & \text{weight}_i>w \\
\max\bigl(\underbrace{\text{DP}[i-1][w]}_{\text{exclude } i},\ \underbrace{\text{value}_i+\text{DP}[i-1][w-\text{weight}_i]}_{\text{include } i}\bigr) & \text{otherwise}
\end{cases}
$$
- **Two base cases, both rows of zeros** ➔ *no item to choose from* and *max weight is $0$*.
- **The exclude branch is the correction the lecture stops to make** ➔ at $\text{DP}[B][6]$ the naive *"$B$ fits, so take it"* gives $40$, but the row above already holds $230$ from item $A$; *"here we can choose **not** to include $B$, having only $A$ in the bag"* ⟹ the cell is $\max(40,230)=230$.
- **Always read from the row ABOVE** ➔ $\text{DP}[i-1][\cdot]$, never the current row. Reading the current row makes the item reusable and silently turns the 0/1 problem back into the unbounded one.
- **Cost** ➔ $O(NM)$ time **and** $O(NM)$ space.

### 4. The Space-Saving Trick — and Why It Is Usually Unusable
- **The observation** ➔ every cell reads only the **row above**, so only two rows are ever live: keep the previous row and the current one and discard the rest.
- **What it buys** ➔ space falls from $O(NM)$ *(the whole matrix)* to two rows; time is unchanged.
- **What it costs** ➔ **reconstruction dies.** Recovering the item set needs the whole matrix to compare each cell with the one above it, so *"in reality we can't do this space saving — because we need it to reconstruct the solution."*
- **The selection rule** ➔ asked only for the **value**, roll the rows; asked *"which items"*, keep the matrix ➔ [[Dynamic Programming]] §7.
- **Generalises** ➔ any DP whose recurrence looks back a bounded number of rows can be rolled, and every one of them loses its breadcrumbs ➔ [[Maximum Subarray Sum]] §2, [[Longest Common Subsequence (LCS)]] §Implementation.

### 5. Reconstruction — Compare Against the Row Above
- **The test** ➔ at $\text{DP}[i][w]$, compare with $\text{DP}[i-1][w]$. **Same value ⟹ item $i$ was excluded** *(move up one row)*; **different ⟹ item $i$ was included** *(record it, move up one row **and** left by $\text{weight}_i$)*.
- **Why the test is sound** ➔ the cell is a $\max$ of exactly those two branches, so a value that differs from the exclude branch can only have come from the include branch — this is [[Dynamic Programming|inclusion–exclusion]], no decision array required.
- **Stop** ➔ when $i=0$ or $w=0$.
- **This is what the lecture calls *backtracking*** ➔ as opposed to a **decision array**, which stores the choice at write time; the array is faster, backtracking uses less auxiliary space at the same complexity ➔ [[Coin Change]] §5.

## ⚙️ Core Implementation
### 🔹 Unbounded knapsack
> [!code]- Code
> ```python
> def knapsack_unbounded(weights, values, C):    # items unlimited
>     memo = [0] * (C + 1)                       # base: empty bag is worth 0
>     for w in range(1, C + 1):
>         memo[w] = memo[w - 1]                  # CARRY: capacity need not be filled
>         for i in range(len(weights)):
>             if weights[i] <= w:
>                 cand = values[i] + memo[w - weights[i]]
>                 if cand > memo[w]:
>                     memo[w] = cand
>     return memo[C]
> ```
> 💡 **Common Mistake:** **Dropping the `memo[w] = memo[w-1]` carry** ➔ the table then means *"best at weight **exactly** $w$"*, and the answer is wrong whenever the capacity cannot be hit exactly. The alternative repair is a final linear scan for $\max_w \text{memo}[w]$ — do one or the other, and say which.

### 🔹 0/1 knapsack, with item reconstruction
> [!code]- Code
> ```python
> def knapsack_01(weights, values, C):           # each item at most once
>     n = len(weights)
>     DP = [[0] * (C + 1) for _ in range(n + 1)]     # row 0 and column 0 are the bases
>     for i in range(1, n + 1):
>         for w in range(0, C + 1):
>             DP[i][w] = DP[i - 1][w]            # exclude item i (ROW ABOVE)
>             if weights[i - 1] <= w:
>                 cand = values[i - 1] + DP[i - 1][w - weights[i - 1]]
>                 if cand > DP[i][w]:
>                     DP[i][w] = cand            # include item i
>
>     chosen = []                                # backtrack: compare with the row above
>     i, w = n, C
>     while i > 0 and w > 0:
>         if DP[i][w] != DP[i - 1][w]:           # different => item i was included
>             chosen.append(i)
>             w -= weights[i - 1]
>         i -= 1
>     return DP[n][C], chosen
> ```
> 💡 **Common Mistake:** **Writing `DP[i][w - weights[i-1]]` instead of `DP[i-1][...]`** ➔ reading the **current** row lets the item be taken again; that single index is the entire difference between 0/1 and unbounded.
> 💡 **Common Mistake:** **Rolling to two rows and then asking for the items** ➔ the reconstruction needs every row ➔ §4.

## ⚖️ Complexity
$N$ items, capacity $M$ *(the lecturer's $C$)*.

| Variant | Time | Auxiliary space | Reconstruction |
| :--- | :--- | :--- | :--- |
| Unbounded | $O(NM)$ | $\Theta(M)$ | decision array $\Theta(M)$, or backtrack |
| 0/1, full matrix | $O(NM)$ | $\Theta(NM)$ | ✅ compare against the row above |
| 0/1, two rows only | $O(NM)$ | $\Theta(M)$ | ❌ **impossible** |
| Brute force | $O(2^{N})$ *(0/1)* | $\Theta(N)$ stack | every subset |

- **All cases coincide** ➔ the loops are input-independent, so best $=$ average $=$ worst for every DP row above.
- **$M$ is a numeric capacity, not an element count** ➔ $O(NM)$ is **pseudo-polynomial**: doubling the capacity's bit-length squares the work. State the unit-cost assumption ➔ [[Algorithmic Complexity]] §Input size.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — unbounded, capacity $12$
| Weight | $0$ | $1$ | $2$ | $3$ | $4$ | $5$ | $6$ | $7$ | $8$ | $9$ | $10$ | $11$ | $12$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Profit** | $0$ | $40$ | $80$ | $120$ | $160$ | $350$ | $390$ | $430$ | $470$ | $550$ | $700$ | $740$ | $\mathbf{780}$ |

**Final Extracted Output:** $\mathbf{\$780}$ from $2\times C + 2\times B$ *(two $5$ kg $+$ two $1$ kg $=12$ kg, $\$700+\$80$)*.

- **Read $w=5$** ➔ five copies of $B$ give $200$; item $C$ alone gives $0+350=350$. The $\max$ takes $350$, and *five $B$s were never the answer* — the cell is a running maximum.
- **Read $w=6$** ➔ $C+B=390$ beats $A=230$ and six $B$s $=240$. **The heaviest single item is rarely the answer.**
- **Read $w=9$** ➔ $D$ alone $=550$ beats $C+4B=510$; but at $w=10$, $2C=700$ beats $D+B=590$. **The optimal item set changes non-monotonically with capacity** — you cannot extend the $w-1$ answer greedily.

### Manual Execution Trace — 0/1, capacity $12$
Rows are the growing item set; every cell reads **only** the row above.

| Items \\ Weight | $0$ | $1$ | $2$ | $3$ | $4$ | $5$ | $6$ | $7$ | $8$ | $9$ | $10$ | $11$ | $12$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $\{\}$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ |
| $\{A\}$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ | $230$ | $230$ | $230$ | $230$ | $230$ | $230$ | $230$ |
| $\{A,B\}$ | $0$ | $40$ | $40$ | $40$ | $40$ | $40$ | $230$ | $270$ | $270$ | $270$ | $270$ | $270$ | $270$ |
| $\{A,B,C\}$ | $0$ | $40$ | $40$ | $40$ | $40$ | $350$ | $390$ | $390$ | $390$ | $390$ | $390$ | $580$ | $620$ |
| $\{A,B,C,D\}$ | $0$ | $40$ | $40$ | $40$ | $40$ | $350$ | $390$ | $390$ | $390$ | $550$ | $590$ | $590$ | $\mathbf{620}$ |

**Backtracking pass** *(compare each cell with the one directly above)*

| At | Cell | Row above | Verdict | Move to |
| :--- | :--- | :--- | :--- | :--- |
| $D,\ w{=}12$ | $620$ | $620$ | **same** ⟹ exclude $D$ | $C,\ w{=}12$ |
| $C,\ w{=}12$ | $620$ | $270$ | **differs** ⟹ include $C$ *(5 kg)* | $B,\ w{=}7$ |
| $B,\ w{=}7$ | $270$ | $230$ | **differs** ⟹ include $B$ *(1 kg)* | $A,\ w{=}6$ |
| $A,\ w{=}6$ | $230$ | $0$ | **differs** ⟹ include $A$ *(6 kg)* | $\{\},\ w{=}0$ ➔ stop |

**Final Extracted Output:** $\{A,B,C\}$ — $6+1+5=12$ kg for $\$230+\$40+\$350=\mathbf{\$620}$, matching the lecture.

- **Read the trap at $\text{DP}[B][6]$** ➔ $B$ fits and offers $40+\text{DP}[A][5]=40$, but excluding $B$ inherits $230$ from item $A$. The cell is $230$; a student who only ever *adds* the fitting item writes $40$ and corrupts every cell to its right.
- **Read the variant difference** ➔ the unbounded answer is $\$780$ and the 0/1 answer is $\$620$ on the **same** items and capacity. Quoting one for the other is a whole-question error.
- **Read row $D$** ➔ $D$ *(9 kg, \$550)* wins at $w=9,10,11$ but is **excluded** at $w=12$, where $\{A,B,C\}$ fills the bag exactly for more.

### Applied Exercise — why unbounded needs one dimension and 0/1 needs two
$$
\begin{aligned}
\textbf{Unbounded: } &\text{after taking item } i,\ \text{the option set is still } \{1..N\} &&\Rightarrow \text{only } w \text{ constrains the future} \Rightarrow \text{1-D} \\
\textbf{0/1: } &\text{after taking item } i,\ \text{the option set is } \{1..N\}\setminus\{i\} &&\Rightarrow w \text{ is } \textbf{not a sufficient state} \Rightarrow \text{add the item index}
\end{aligned}
$$
**Final Extracted Output:** the row index encodes *"only the first $i$ items are on offer"*, and processing items in a fixed order is what makes one index enough instead of a subset. **The reusable move (LO1):** ask *"does my subproblem parameter determine the future?"* — the same question that adds a dimension in [[Dynamic Programming]] §5 and widens a vertex in [[State-Space Graph Modelling]].

## ⚠️ Common Mistakes
- 💡 **Reading the current row in the 0/1 recurrence** ➔ silently solves the unbounded problem; the fix is one index, `DP[i-1][...]`.
- 💡 **Omitting the exclude branch** ➔ *"the item fits, so take it"* discards a better set already found with fewer items; the cell is a $\max$ of **two** branches.
- 💡 **Forgetting the unbounded carry** ➔ the table silently means *exactly $w$*, so an unfillable capacity returns garbage; carry `memo[w-1]` or scan for the max.
- 💡 **Applying the space-saving trick when the items are wanted** ➔ two rows compute the value and destroy the reconstruction ➔ §4.
- 💡 **Calling $O(NM)$ polynomial** ➔ $M$ is a numeric capacity, so this is **pseudo-polynomial**; say so when the capacity is given as a number.
- 💡 **Greedy by value-per-kilogram** ➔ correct for the *fractional* problem only, which this unit does not ask for; on $\{A,B,C,D\}$ at $12$ kg it is not guaranteed ➔ [[Greedy Algorithm]] §5.

## 🧠 Active Recall
> [!FAQ]- Unbounded knapsack uses a 1-D array; 0/1 needs a 2-D matrix. Justify the extra dimension from the subproblem definition.
> > [!SUCCESS]- Answer
> > - **Short answer:** with unlimited items the option set never changes, so the remaining **capacity** fully determines the future; once each item is single-use it does not, and the row index records which items are still on offer.
> > - **Why:** **A state must determine the future** ➔ in the unbounded problem two different histories reaching weight $w$ are interchangeable; in 0/1 they are not, because they may have consumed different items. **The row is "only the first $i$ items"** ➔ fixing an item order turns *"which subset remains"* ($2^{N}$ possibilities) into a single index, which is why the table is $O(NM)$ rather than exponential. **Same question elsewhere** ➔ it is the *"is the vertex a sufficient state?"* test from [[State-Space Graph Modelling]], asked of a DP parameter ➔ [[Dynamic Programming]] §5.

> [!FAQ]- Your 0/1 matrix is filled and the answer is $\$620$. Recover the items without a decision array.
> - **Hint:** the cell is a max of exactly two branches.
> > [!SUCCESS]- Answer
> > - **Short answer:** compare each cell with the one **directly above**; same ⟹ the item was excluded, different ⟹ it was included, so record it and move up one row and left by its weight.
> > - **Why:** **The two branches are exclude and include** ➔ $\text{DP}[i][w]=\max(\text{DP}[i-1][w],\ v_i+\text{DP}[i-1][w-w_i])$, so a value differing from $\text{DP}[i-1][w]$ can only have come from the include branch. **The left step spends the weight** ➔ moving to $w-w_i$ is what stops the same capacity being reused. **Worked** ➔ $D$ excluded at $620=620$, then $C$, $B$ and $A$ all included, giving $\{A,B,C\}$ at exactly $12$ kg. **This is why the matrix must survive** ➔ the two-row space saving deletes the rows this walk reads ➔ §4.

> [!FAQ]- Coin change minimises and knapsack maximises. Name every other difference between the two unbounded recurrences.
> > [!SUCCESS]- Answer
> > - **Short answer:** the initialisation ($\infty$ vs $0$), the meaning of a cell (*exactly* $v$ vs *at most* $w$), and the resulting need for a carry term in knapsack.
> > - **Why:** **Coin change has an unreachable case** ➔ a value no coin combination hits is genuinely $\infty$, so the table starts at $\infty$ and the edge case is real. **A knapsack is never unfillable** ➔ leaving it empty is legal and worth $0$, so there is no $\infty$ and no unreachable edge case. **"At most" needs the carry** ➔ `memo[w] = memo[w-1]` propagates the best-so-far, or you scan the finished table for its maximum; without it the cell means *exactly $w$* and the answer breaks when the capacity cannot be filled exactly ➔ §2.
