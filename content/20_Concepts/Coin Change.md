---
unit: FIT2004
week: 7
source: [lecture]
domain: A
parent: "[[Dynamic Programming]]"
tags: [CS/Algorithms]
aliases: [Coin Change Problem, Minimum Coins, Making Change, Decision Array]
---
# [[Coin Change]]

**Context:** [[FIT2004_MOC]] · the lecture's **first full [[Dynamic Programming|DP]]**, and the shape **PT-02 questions wear as a costume** — also where the *decision array* is introduced
**Parent Framework:** [[Dynamic Programming]]

> [!abstract] Quick Revision
> - **🎯 Objective:** `MinCoins[v] = {the fewest coins summing to exactly v}` ➔ for each value, try **every** coin and take $1+\text{MinCoins}[v-c_i]$ at its cheapest.
> - **📦 Core Components:** $V$ subproblems ➔ $N$ coins tried at each ⟹ $O(NM)$ time, $\Theta(M)$ space *(lecturer's $N=$ coins, $M=$ target value)*.
> - **⚡ Key Constraint:** **greedy is wrong.** On $\{1,5,6,9\}$ wanting $12$, greedy takes $9{+}1{+}1{+}1=4$ coins; the optimum is $6{+}6=2$. Coins are unlimited, so this is the **unbounded** shape ➔ [[Knapsack Problem]].

## 📝 How It Works
### 1. Three Attempts, in the Lecture's Order
- **Brute force** ➔ try every combination, keep the smallest. *"Will it work? Of course!"* — and it is exponential, which is the motivation for everything after it.
- **Greedy** ➔ take the biggest coin that fits, then fill the balance. **Does not always work**: currency $\{1,5,6,9\}$, target $12$ ⟹ greedy $9+1+1+1$ *(4 coins)* vs optimal $6+6$ *(2 coins)*.
- **Why greedy dies here** ➔ committing to the $9$ leaves a remainder that only $1$s can pay; the greedy-choice property fails, but **optimal substructure survives** ⟹ DP ➔ [[Greedy Algorithm]] §2.
- **Dynamic programming** ➔ solve every value from $0$ up to the target, reusing the smaller answers. The lecture shrinks the demo from $\{1,5,10,50\}$/$110$ to $\{1,5,6,9\}$/$12$ *"easier for me to visualise"* — **do the same in an exam**: a small instance you can finish beats a large one you cannot.

### 2. The Subproblem and the Recurrence
- **MEMO sentence** ➔ `MinCoins[v] = {the minimum number of coins needed to make the value v}`, for $0\le v\le M$.
- **The value is the subproblem; the coins are the choices** ➔ $M+1$ cells *(the $+1$ is the $v=0$ base case)*, and the $N$ coins are the work **inside** each cell. Counting the coins as a dimension is the standard complexity error ➔ [[Dynamic Programming]] §5.
$$
\text{MinCoins}[v]=
\begin{cases}
0 & v=0 \\
\infty & v>0 \text{ and } v<c[i]\ \text{for all } i \\
\displaystyle\min_{\substack{1\le i\le N\\ c[i]\le v}}\bigl(1+\text{MinCoins}[v-c[i]]\bigr) & \text{otherwise}
\end{cases}
$$
- **Base** ➔ $v=0$ costs $0$ coins, unambiguously.
- **Edge** ➔ no coin fits ⟹ $\infty$, meaning *unreachable*. $\infty$ is a **legitimate answer**, not a placeholder — which is exactly why it cannot double as the "not yet computed" marker *(§4)*.
- **General** ➔ *"which coin did I add last?"* Every choice of last coin reduces the problem to a value already solved.
- **Answer** ➔ $\text{MinCoins}[M]$, a fixed cell.

### 3. Filling the Table by Hand
- **Sweep values upward, and at each value loop over every coin** ➔ *"we will loop through this over and over considering the coins."*
- **Every write is a comparison against what is already there** ➔ at $v=5$ the table holds $5$ *(five $1$s)* and the coin $5$ offers $0+1=1$; the $\min$ takes $1$.
- **Early termination on a sorted coin list** ➔ once $c[i]>v$ the rest of a sorted list cannot fit either, so break. It does not change $O(NM)$ but it is the lecturer's stated optimisation.
- **Cost** ➔ $M$ values $\times$ $N$ coins $=O(NM)$ time, $\Theta(M)$ auxiliary — *"still much faster than brute force."*

### 4. Top-Down vs Bottom-Up — and the Sentinel Trap
- **The lecture gives the top-down form** ➔ recursive, memoised, initialised to $-1$ for *"not computed yet"*.
- **$-1$, never $\infty$** ➔ $\infty$ is a real answer for an unreachable value, so using it as the sentinel makes an unreachable subproblem look uncomputed and it is recomputed forever. **Pick a sentinel outside the answer's range.**
- **The bottom-up body is the same expression** ➔ $1+\text{Memo}[v-c[i]]$; only the control flow changes.
- **The trade-off as stated** ➔ *top-down might save some computations* *(it only visits reachable subproblems)* · *bottom-up might save space, especially since there is no recursion* *(no $\Theta(\text{depth})$ call stack)*.
- **The lecturer's own habit** ➔ *"I only use bottom-up"*, while noting some problems are more intuitive top-down and the two are technically interchangeable.

### 5. Reconstruction — the Decision Array *(the lecture's vehicle for it)*
- **Storing the whole combination per cell is $O(N^{2})$** ➔ writing $\{6,1\}$, $\{6,1,1\}$, $\{9\}$… at every value duplicates the prefix over and over.
- **Store only the LAST coin added** ➔ one value per cell ⟹ $\Theta(M)$, and the full combination is recovered by walking backwards.
- **The walk** ➔ from $v=M$, emit $\text{coin}[v]$, jump to $v-\text{coin}[v]$, repeat until $v=0$.
- **Worked** ➔ $\text{coin}[12]=6\Rightarrow v=6$; $\text{coin}[6]=6\Rightarrow v=0$. **Coins $=\{6,6\}$.**
- **Decision array vs [[Dynamic Programming|backtracking]]** ➔ the array is **faster** *(the decision is read, not re-derived)*; backtracking uses **less auxiliary space** at the **same** space complexity. Both still pay $O(\text{answer length})$ to emit the solution ➔ [[Dynamic Programming]] §8.

## ⚙️ Core Implementation
### 🔹 Top-down, memoised *(the lecture's algorithm)*
> [!code]- Code
> ```python
> # Memo[v] = -1 means "not yet computed".
> # -1 and NOT infinity: infinity is a legal ANSWER (value unreachable).
> def coin_change_top_down(coins, M):
>     memo = [-1] * (M + 1)
>     memo[0] = 0
>
>     def solve(value):
>         if memo[value] != -1:
>             return memo[value]
>         min_coins = INF
>         for i in range(len(coins)):            # N choices inside ONE subproblem
>             if coins[i] <= value:
>                 c = 1 + solve(value - coins[i])
>                 if c < min_coins:
>                     min_coins = c
>         memo[value] = min_coins
>         return memo[value]
>
>     return solve(M)
> ```
> 💡 **Common Mistake:** **Using $\infty$ as the "uncomputed" sentinel** ➔ an unreachable value legitimately stores $\infty$, so the memo test never fires on it and the subproblem is recomputed on every path — the memoisation silently stops working.

### 🔹 Bottom-up, with the decision array
> [!code]- Code
> ```python
> def coin_change(coins, M):                     # coins sorted ascending
>     memo = [INF] * (M + 1)
>     coin = [None] * (M + 1)                    # DECISION ARRAY: last coin added
>     memo[0] = 0
>
>     for v in range(1, M + 1):
>         for i in range(len(coins)):
>             if coins[i] > v:
>                 break                          # sorted => nothing later fits either
>             if memo[v - coins[i]] != INF and memo[v - coins[i]] + 1 < memo[v]:
>                 memo[v] = memo[v - coins[i]] + 1
>                 coin[v] = coins[i]
>
>     if memo[M] == INF:
>         return INF, []                         # value not representable
>     chosen = []                                # walk the breadcrumbs back
>     v = M
>     while v > 0:
>         chosen.append(coin[v])
>         v -= coin[v]
>     return memo[M], chosen
> ```
> 💡 **Common Mistake:** **Skipping the `memo[v - coins[i]] != INF` guard** ➔ $\infty+1$ with a large-integer sentinel becomes a finite-looking number and claims an unreachable value is payable.
> 💡 **Common Mistake:** **Storing the whole coin list per cell** ➔ $O(N^{2})$ space where $\Theta(M)$ suffices; the last coin alone determines the rest.

## ⚖️ Complexity
$N$ coin denominations, target value $M$.

| Approach | Time | Auxiliary space | Note |
| :--- | :--- | :--- | :--- |
| Brute force | exponential | $\Theta(M)$ stack | every combination |
| Greedy | $\Theta(N\log N + M)$ | $\Theta(1)$ | **incorrect** on $\{1,5,6,9\}$, target $12$ |
| DP, bottom-up | $O(NM)$ | $\Theta(M)$ | best $=$ average $=$ worst |
| DP, top-down | $O(NM)$ | $\Theta(M)$ $+$ $\Theta(M)$ stack | may skip unreachable subproblems |
| $+$ decision array | $O(NM)$ | $\Theta(M)$ extra | reconstruction in $O(\text{coins used})$ |
| $+$ full combination per cell | $O(NM)$ | $O(N^{2})$ | **do not** — the lecture's rejected version |

- **Both parameters must be named** ➔ $O(NM)$ is meaningless without *"$N$ denominations, $M$ target value"*; $M$ is a **numeric value**, so its bit-length matters if the input is a number ➔ [[Algorithmic Complexity]] §Input size.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Currency $\{1,5,6,9\}$, target $12$.

| Value $v$ | $0$ | $1$ | $2$ | $3$ | $4$ | $5$ | $6$ | $7$ | $8$ | $9$ | $10$ | $11$ | $12$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Number of coins** | $0$ | $1$ | $2$ | $3$ | $4$ | $1$ | $1$ | $2$ | $3$ | $1$ | $2$ | $2$ | $\mathbf{2}$ |
| **Last coin added** | — | $1$ | $1$ | $1$ | $1$ | $5$ | $6$ | $1$ | $1$ | $9$ | $5$ | $6$ | $6$ |

**Final Extracted Output:** $\text{MinCoins}[12]=\mathbf{2}$; backtracking the decision array $12\xrightarrow{6}6\xrightarrow{6}0$ gives **coins $\{6,6\}$**.

- **Read the overwrite** ➔ $v=5$ is first written as $5$ *(five $1$s)* and then **beaten** by the coin $5$ at $1$; $v=6$ likewise falls from $2$ *(5+1)* to $1$ *(the coin 6)*. Every cell is a running minimum, not a single write.
- **Read the non-monotonicity** ➔ $\text{MinCoins}[8]=3$ while $\text{MinCoins}[9]=1$. A bigger target can be **cheaper**; never assume the row rises.
- **Read the greedy failure right off the table** ➔ greedy would go $12\to9$ *(then $3$)*, landing on $\text{MinCoins}[3]=3$ for a total of $4$. The DP finds $6+6$.

### Applied Exercise — the PT-02 costume test
**Problem:** microwave keys $K=\{1,10,60\}$, minimum presses to enter time $t$. Show it is coin change.
$$
\begin{aligned}
\text{coins } c &\longleftrightarrow \text{keys } K \\
\text{target value } M &\longleftrightarrow \text{time } t \\
\text{"which coin last"} &\longleftrightarrow \text{"which key pressed last"}
\end{aligned}
$$
**Final Extracted Output:** $\text{minPresses}[t]=0$ if $t=0$; $\infty$ if $t<0$; else $\min_{k\in K}(\text{minPresses}[t-k])+1$ — sanity-checked at $t=25\Rightarrow7$ *(two $10$s, five $1$s)*. **The reusable move (LO1):** name the classical problem **before** writing anything; every PT-02 question is one of the pass-level six wearing different nouns ➔ [[Dynamic Programming]] §4.

## ⚠️ Common Mistakes
- 💡 **Assuming greedy works because it works on real currency** ➔ $\{1,5,10,50\}$ happens to be *canonical*; the exam picks $\{1,5,6,9\}$ precisely because it is not. Never claim greedy without a proof ➔ [[Greedy Algorithm]] §5.
- 💡 **$\infty$ as the memo sentinel** ➔ collides with the legitimate *unreachable* answer; use $-1$.
- 💡 **Quoting $O(M)$ time** ➔ that is the table **size**; each cell tries $N$ coins, so time is $O(NM)$ and space is $\Theta(M)$.
- 💡 **Reporting only the count when asked for the coins** ➔ keep the decision array *(or backtrack)*; *"what are the coins?"* is a different question ➔ §5.
- 💡 **Storing the full combination at every value** ➔ $O(N^{2})$ space for information the last-coin array already determines.

## 🧠 Active Recall
> [!FAQ]- Why can the memo not be initialised to $\infty$, when $\infty$ is the natural "no answer" value?
> > [!SUCCESS]- Answer
> > - **Short answer:** because $\infty$ is a **legitimate answer** — an unreachable value really does cost $\infty$ coins — so it cannot also mean *"not computed yet"*.
> > - **Why:** **The memo test asks a different question** ➔ `if memo[v] != sentinel` must distinguish *"I have solved this"* from *"I have not looked"*; if the sentinel is a possible result, an unreachable subproblem is re-expanded on every path and the memoisation is silently disabled. **$-1$ works because counts are non-negative** ➔ pick any value outside the answer's range. **The same discipline elsewhere** ➔ guard $\infty$ arithmetic in [[Bellman-Ford]] for exactly the same reason.

> [!FAQ]- Currency $\{1,5,6,9\}$, target $12$. Give the greedy answer, the optimal answer, and say precisely which property greedy lacks.
> > [!SUCCESS]- Answer
> > - **Short answer:** greedy gives $9+1+1+1$ *(4 coins)*, the optimum is $6+6$ *(2 coins)*; greedy lacks the **greedy-choice property**.
> > - **Why:** **Optimal substructure still holds** ➔ the best way to make $12$ does contain the best way to make $12-c$ for the last coin $c$, which is exactly what the DP exploits. **What fails is the first commitment** ➔ no optimal solution contains the $9$, so an irrevocable largest-first choice cannot be repaired later. **The paradigm consequence** ➔ substructure without the choice property is the definition of a DP problem ➔ [[Dynamic Programming]] §3.

> [!FAQ]- You have the table of minimum counts. The question asks *which coins*. Two options — name them and price them.
> > [!SUCCESS]- Answer
> > - **Short answer:** a **decision array** storing the last coin added per value, or **backtracking** from the table by re-deriving each decision.
> > - **Why:** **The decision array is faster and $\Theta(M)$** ➔ one extra cell per value; the walk $12\xrightarrow{6}6\xrightarrow{6}0$ reads the answer rather than recomputing it. **Backtracking uses less auxiliary space at the same complexity** ➔ no second array, but each step re-tests the coins to find which one produced the cell. **What you must never do** ➔ store the whole coin list per cell, which is $O(N^{2})$ for information the last coin already determines.
