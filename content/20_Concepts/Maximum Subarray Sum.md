---
unit: FIT2004
week: 7
source: [applied]
domain: A
parent: "[[Dynamic Programming]]"
tags: [CS/Algorithms]
aliases: [Maximum Subarray, Kadane's Algorithm, Maximum Sum Submatrix, Prefix Sums]
---
# [[Maximum Subarray Sum]]

**Context:** [[FIT2004_MOC]] · the applied sheet's cleanest **$\Theta(n^{2})\to\Theta(n)$** upgrade — and the vault's home for **prefix sums**, which several other DPs depend on
**Parent Framework:** [[Dynamic Programming]]

> [!abstract] Quick Revision
> - **🎯 Objective:** find the **contiguous** non-empty $a[i..j]$ of maximum sum ➔ $\Theta(n^{2})$ by prefix sums over all intervals, $\Theta(n)$ by anchoring the subproblem at its **right end**.
> - **📦 Core Components:** prefix sums $\text{DP}[i]=\sum_{k\le i}a_k$ ➔ any interval in $O(1)$ | anchored $\text{DP}'[j]$ ➔ *"best sum **ending at** $j$"* ➔ the greedy restart.
> - **⚡ Key Constraint:** the subarray is **non-empty**, so an all-negative input answers with its **largest single element**, never $0$. Initialising the running maximum to $0$ is the marked error.

## 📝 How It Works
### 1. Prefix Sums — the $\Theta(n^{2})$ Solution *(applied P6a)*
- **The identity** ➔ $\text{sum}(a[i..j])=\text{sum}(a[1..j])-\text{sum}(a[1..i-1])$, so **every** interval sum is one subtraction once the prefixes are known.
- **The subproblem** ➔ `DP[i] = {the sum of the elements in a[1..i]}` for $0\le i\le n$:
$$
\text{DP}[i]=
\begin{cases}
0 & i=0 \\
\text{DP}[i-1]+a_i & \text{otherwise}
\end{cases}
$$
- **The answer** ➔ $\displaystyle\max_{0\le i<j\le n}\bigl(\text{DP}[j]-\text{DP}[i]\bigr)$; the strict $i<j$ is what keeps the subarray non-empty.
- **Cost** ➔ $\Theta(n)$ to build the table $+$ $\Theta(n^{2})$ intervals at $O(1)$ each $=\Theta(n^{2})$. **Naively this is $\Theta(n^{3})$** — recomputing each interval sum by a scan — so the prefix table alone removes a whole factor of $n$.
- **Reuse this table everywhere** ➔ the ferry problem needs $\sum_{j<i}\ell_j$ in $O(1)$, and text justification needs the running line length; both precompute prefix sums exactly like this ➔ [[Dynamic Programming]] §5.

### 2. Anchoring the Right End — the $\Theta(n)$ Solution *(applied P6b)*
- **The greedy observation** ➔ looking at index $j$, if the best sum finishing at $j-1$ is **positive** it is worth extending; if it is $\le0$ it can only hurt, so **restart** at $a_j$.
- **The subproblem must force $a_j$ in** ➔ `DP'[j] = {the maximum sum of a subarray ENDING at position j}`, i.e. $\displaystyle\max_{1\le i\le j}\sum_{k=i}^{j}a_k$ — $a_j$ is a member by construction.
$$
\text{DP}'[j]=
\begin{cases}
0 & j=0 \\
\text{DP}'[j-1]+a_j & \text{DP}'[j-1]>0 \\
a_j & \text{otherwise}
\end{cases}
$$
- **The answer is a scan** ➔ $\displaystyle\max_{1\le j\le n}\text{DP}'[j]$, not $\text{DP}'[n]$ — the anchor forces it, exactly as in [[Longest Increasing Subsequence (LIS)|LIS]].
- **Cost** ➔ $n$ subproblems at $O(1)$ $=\Theta(n)$ time.
- **$\Theta(1)$ auxiliary space** ➔ each subproblem reads only its predecessor, so keep `prev` and `best` in two variables and never build the array. That space-saving trick applies to **any** DP whose recurrence looks back a constant distance.
- **Where the greed lives** ➔ this is DP with a **greedy element** bolted on: the restart decision is made locally and never revisited, which is legal here because a non-positive prefix provably cannot help any later subarray ➔ [[Greedy Algorithm]] §2.

### 3. The 2-D Generalisation — Maximum Sum Submatrix *(applied P14, `[D]`)*
- **$O(n^{4})$ by 2-D prefix sums** ➔ `DP[i][j] = {the sum of the submatrix A[1..i][1..j]}`, built by **inclusion–exclusion**:
$$
\text{DP}[i][j]=
\begin{cases}
0 & i=0 \text{ or } j=0 \\
A[i][j]+\text{DP}[i-1][j]+\text{DP}[i][j-1]-\text{DP}[i-1][j-1] & \text{otherwise}
\end{cases}
$$
- **Why the subtraction** ➔ the two rectangles $[1..i-1][1..j]$ and $[1..i][1..j-1]$ overlap in $[1..i-1][1..j-1]$, which would otherwise be counted twice. **Draw the four rectangles** — the picture is the derivation.
- **Any submatrix in $O(1)$** ➔ $\text{sum}(A[i..j][k..l])=\text{DP}[j][l]-\text{DP}[i-1][l]-\text{DP}[j][k-1]+\text{DP}[i-1][k-1]$; there are $O(n^{4})$ submatrices ⟹ $\Theta(n^{2})+O(n^{4})=O(n^{4})$.
- **$O(n^{3})$ by reduction to the 1-D case** ➔ a maximum-sum submatrix starts at **some** row $i$ and has **some** height $h$. Fix both, **compress** rows $i..i{+}h{-}1$ into a single row of column sums, and run §2's $\Theta(n)$ algorithm on it.
- **The compression is incremental** ➔ growing the height by one costs $O(n)$ *(add the next row to the previous compressed row)*, so the whole sweep is $O(n)$ starting rows $\times$ $O(n)$ heights $\times$ $O(n)$ scan $=O(n^{3})$.
- **The pattern generalises** ➔ the $k$-D problem compresses to $(k-1)$-D, giving $O(n^{2k-1})$: $O(n)$ in 1-D, $O(n^{3})$ in 2-D, $O(n^{5})$ in 3-D.

## ⚙️ Core Implementation
### 🔹 $\Theta(n)$, $\Theta(1)$ auxiliary, with the index range
> [!code]- Code
> ```python
> def max_subarray(a):                    # a[0..n-1], non-empty subarray required
>     best  = a[0]                        # NOT 0 - handles the all-negative case
>     best_lo = best_hi = 0
>     cur   = a[0]                        # DP'[j] for the current j
>     cur_lo = 0
>     for j in range(1, len(a)):
>         if cur > 0:
>             cur = cur + a[j]            # extending still pays
>         else:
>             cur = a[j]                  # restart: the prefix can only hurt
>             cur_lo = j
>         if cur > best:                  # SCAN - the answer is not DP'[n-1]
>             best = cur
>             best_lo, best_hi = cur_lo, j
>     return best, best_lo, best_hi
> ```
> 💡 **Common Mistake:** **`best = 0` and `cur = 0`** ➔ on an all-negative array this returns the empty subarray. The spec says non-empty, so seed both from $a[0]$.
> 💡 **Common Mistake:** **Testing `cur >= 0`** ➔ a zero prefix is neutral; the sheet's rule is `DP'[j-1] > 0`, and a non-strict test just lengthens the reported range without changing the sum. Harmless for the value, wrong for the indices.

> [!NOTE] 🔭 **Beyond the lecture** *(not in the slides)*: §2 is commonly called **Kadane's algorithm**; the applied sheet derives it from scratch and does not name it, so derive it rather than citing it.

## ⚖️ Complexity
| Approach | Time | Auxiliary space | Answer location |
| :--- | :--- | :--- | :--- |
| Naive all-intervals, sum by scan | $\Theta(n^{3})$ | $\Theta(1)$ | — |
| Prefix sums $+$ all intervals *(P6a)* | $\Theta(n^{2})$ | $\Theta(n)$ | $\max(\text{DP}[j]-\text{DP}[i])$, $i<j$ |
| Anchored right end *(P6b)* | $\Theta(n)$ | $\Theta(1)$ | $\max_j \text{DP}'[j]$ — **scan** |
| Submatrix, 2-D prefix sums *(P14.1)* | $O(n^{4})$ | $\Theta(n^{2})$ | $\max$ over all $O(n^{4})$ rectangles |
| Submatrix, row compression $+$ 1-D *(P14.2)* | $O(n^{3})$ | $\Theta(n)$ | $\max$ over start row $\times$ height |
| $k$-D generalisation | $O(n^{2k-1})$ | $\Theta(n^{k-1})$ | recursive compression |

- **All cases coincide** ➔ every version has fixed loop bounds and no early exit, so best $=$ average $=$ worst.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
$a=[-2,\,1,\,-3,\,4,\,-1,\,2,\,1,\,-5,\,4]$.

| $j$ | $a_j$ | $\text{DP}'[j-1]$ | $>0$? | Rule fired | $\text{DP}'[j]$ | best so far |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $1$ | $-2$ | $0$ | no | restart | $-2$ | $-2$ |
| $2$ | $1$ | $-2$ | no | restart | $1$ | $1$ |
| $3$ | $-3$ | $1$ | yes | extend | $-2$ | $1$ |
| $4$ | $4$ | $-2$ | no | restart | $4$ | $4$ |
| $5$ | $-1$ | $4$ | yes | extend | $3$ | $4$ |
| $6$ | $2$ | $3$ | yes | extend | $5$ | $5$ |
| $7$ | $1$ | $5$ | yes | extend | $\mathbf{6}$ | $\mathbf{6}$ |
| $8$ | $-5$ | $6$ | yes | extend | $1$ | $6$ |
| $9$ | $4$ | $1$ | yes | extend | $5$ | $6$ |

**Final Extracted Output:** maximum sum $\mathbf{6}$, achieved by $a[4..7]=[4,-1,2,1]$ *(the restart at $j=4$ fixes the left end)*.

- **Read the trap** ➔ $\text{DP}'[9]=5\ne6$: the anchored subproblem means the last cell is **not** the answer. The running `best` is mandatory.
- **Read the left endpoint** ➔ it is the position of the most recent **restart**, which is why `cur_lo` is updated only in the `else` branch.
- **Read the negative case** ➔ on $[-3,-1,-7]$ every step restarts, $\text{DP}'=[-3,-1,-7]$ and the answer is $-1$ — the largest single element, exactly as the spec demands.

### Applied Exercise — from $\Theta(n^{2})$ to $\Theta(n)$ in one sentence *(P6)*
**Problem:** name the change of subproblem that removes the factor of $n$, and justify the greedy step.
$$
\begin{aligned}
\text{P6a: } \text{DP}[i]&=\text{sum of } a[1..i] &&\Rightarrow \text{answer needs a } \textbf{pair} \ (i,j)\Rightarrow O(n^{2})\ \text{combinations} \\
\text{P6b: } \text{DP}'[j]&=\text{best sum } \textbf{ending at } j &&\Rightarrow \text{answer needs a } \textbf{single}\ j\Rightarrow O(n)\ \text{subproblems} \\
\text{Greedy step: } &\text{DP}'[j-1]\le0 \Rightarrow \forall i\le j-1,\ \textstyle\sum_{k=i}^{j}a_k\le a_j &&\Rightarrow \text{restarting loses nothing.}
\end{aligned}
$$
**Final Extracted Output:** $\Theta(n)$ time, $\Theta(1)$ auxiliary. **The reusable move (LO1):** when the answer is indexed by a *pair*, try re-defining the subproblem so one of the two indices is **implied** — here, by forcing $a_j$ to be the last element.

## ⚠️ Common Mistakes
- 💡 **Initialising the maximum to $0$** ➔ silently allows the empty subarray and returns $0$ on all-negative input.
- 💡 **Answer $=\text{DP}'[n]$** ➔ anchored subproblem ⟹ scan. Same failure mode as [[Longest Increasing Subsequence (LIS)|LIS]].
- 💡 **Quoting $\Theta(n)$ space for the fast version** ➔ the recurrence looks back **one** cell, so it is $\Theta(1)$ auxiliary; quoting the array you did not need is a lost mark.
- 💡 **Forgetting the $-\text{DP}[i-1][k-1]$ term in 2-D** ➔ inclusion–exclusion has **four** terms; three of them is the classic off-by-a-rectangle.
- 💡 **Calling the $O(n^{3})$ submatrix method "just Kadane in 2-D"** ➔ the work is the **row compression** *(and its $O(n)$ incremental update)*; the 1-D routine is the black box being reused.

## 🧠 Active Recall
> [!FAQ]- The $\Theta(n^{2})$ version already computes every interval in $O(1)$. Where does the remaining $n$ go, and how is it removed?
> > [!SUCCESS]- Answer
> > - **Short answer:** it is in the **pair** $(i,j)$ — $O(n^{2})$ intervals to try. Re-anchoring the subproblem at its right end makes $i$ implicit, leaving $O(n)$ subproblems.
> > - **Why:** **Prefix sums fix the *cost per interval*, not the *number* of intervals** ➔ they take $\Theta(n^{3})$ down to $\Theta(n^{2})$ and stop there. **Forcing $a_j$ into the subarray removes the left index** ➔ $\text{DP}'[j]$ is a single-parameter subproblem, and the left endpoint is recovered later from where the restart happened. **The greedy step is what makes it $O(1)$ per subproblem** ➔ a non-positive best-ending-at-$(j{-}1)$ can never help, so exactly one comparison decides extend-vs-restart ➔ [[Dynamic Programming]] §5.

> [!FAQ]- You have an $O(n)$ maximum-subarray routine. Get the maximum-sum **submatrix** of an $n\times n$ matrix in $O(n^{3})$.
> - **Hint:** what does the answer's *shape* let you fix?
> > [!SUCCESS]- Answer
> > - **Short answer:** fix the start row and the height, **compress** those rows into one row of column sums, and run the 1-D routine on it.
> > - **Why:** **The answer has a top and a bottom** ➔ $O(n)$ choices of start row $\times$ $O(n)$ choices of height covers every possible vertical extent, and the remaining freedom is purely horizontal — which is exactly the 1-D problem. **Compression is incremental** ➔ growing the height by one adds the next row to the running compressed row in $O(n)$, so no height is recomputed from scratch. **Multiply the three factors** ➔ $O(n)\cdot O(n)\cdot O(n)=O(n^{3})$, beating the $O(n^{4})$ prefix-sum enumeration, and the same *"compress one dimension away"* trick gives $O(n^{2k-1})$ in $k$ dimensions.
