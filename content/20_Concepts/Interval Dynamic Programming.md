---
unit: FIT2004
week: 7
source: [applied]
domain: A
parent: "[[Dynamic Programming]]"
tags: [CS/Algorithms]
aliases: [Interval DP, Range DP, Longest Palindromic Subsequence, Coin Game, Matrix Chain Multiplication, Adversarial DP]
---
# [[Interval Dynamic Programming]]

**Context:** [[FIT2004_MOC]] · the fourth [[Dynamic Programming|DP]] subproblem shape — `DP[i][j]` over a **contiguous range** $a[i..j]$, filled by **increasing length**, not by increasing index
**Parent Framework:** [[Dynamic Programming]]

> [!abstract] Quick Revision
> - **🎯 Objective:** when a decision **shrinks a range from either end** or **splits it at a cut point**, the subproblem is the range itself ➔ $\Theta(n^{2})$ cells, filled shortest-first.
> - **📦 Core Components:** shrink-from-both-ends ➔ palindromes, the coin game | split-at-$k$ ➔ boolean parenthesisation, matrix chain multiplication.
> - **⚡ Key Constraint:** the **fill order is by range length**, because $\text{DP}[i][j]$ reads strictly shorter ranges. A plain `for i / for j` loop reads unwritten cells and is the defining bug of this shape.

## 📝 How It Works
### 1. Recognising the Shape
- **The trigger** ➔ every legal move removes an element from the **left end**, the **right end**, or splits the range in two. What survives is always a **contiguous** $a[i..j]$.
- **Subproblem count** ➔ $\binom{n}{2}+n=\Theta(n^{2})$ ranges ⟹ auxiliary space $\Theta(n^{2})$; the table is **upper-triangular** *(only $i\le j$ is meaningful)*.
- **Cost** ➔ $\Theta(n^{2})$ if each range decides in $O(1)$ *(shrink)*; $\Theta(n^{3})$ if each range tries every cut $k$ *(split)*.
- **Answer** ➔ $\text{DP}[1][n]$ — the full range — so no scan, unlike the anchored shapes ([[Longest Increasing Subsequence (LIS)|LIS]], [[Maximum Subarray Sum]]).
- **Empty-range convention** ➔ define $\text{DP}[i][j]=0$ for $i>j$; the shrink recurrences below index $\text{DP}[i+1][j-1]$, which is empty when $j=i+1$.
- **Contrast with [[Longest Common Subsequence (LCS)|LCS]]** ➔ that grid indexes **two prefixes of two sequences**; this one indexes **one range of one sequence**. Same $\Theta(n^{2})$, different meaning — say which you are doing.

### 2. Shrink From Both Ends — Longest Palindromic *Subsequence* *(applied P10a)*
- **The structure** ➔ $a[1..n]$ is a palindrome **iff** $a_1=a_n$ **and** $a[2..n-1]$ is a palindrome; an empty or single-element sequence is one.
- **The decision** ➔ if the two ends match, use **both**; otherwise at least one is unusable, so drop each in turn and take the better.
$$
\text{DP}[i][j]=
\begin{cases}
1 & i=j \\
2+\text{DP}[i+1][j-1] & a[i]=a[j] \\
\max\bigl(\text{DP}[i+1][j],\ \text{DP}[i][j-1]\bigr) & \text{otherwise}
\end{cases}
$$
- **Answer** ➔ $\text{DP}[1][n]$; $\Theta(n^{2})$ subproblems at $O(1)$ ⟹ $\Theta(n^{2})$ time and space.
- **Worked micro-example** ➔ on $5,3,2,3,5$ the ends match at every level ⟹ $2+2+1=5$, the whole sequence.

### 3. Substring $\ne$ Subsequence *(applied P10b, P10c)*
- **The longest palindromic *substring* is contiguous** ➔ a different problem, and **not** solved by the DP above.
- **$\Theta(n^{2})$ without DP** ➔ a palindrome is symmetric about a middle, so try every centre and expand while the characters match: $n$ element-centres *(odd lengths)* $+$ $n$ gap-centres *(even lengths)*, each expanding $O(n)$.
- **The two loops are separate** ➔ odd uses `a[i-j] == a[i+j]` and reports $2j+1$; even uses `a[i-j+1] == a[i+j]` and reports $2j$. Handling only one halves your answers on the wrong inputs.
- **$O(n)$ `[D]`** ➔ pad with a separator so every palindrome is odd-length, then store $\text{DP}[i]=$ the **radius** of the largest palindrome centred at $i$ and reuse symmetry: for $j$ inside a known palindrome centred at $i$, its mirror $2i-j$ gives $\text{DP}[j]$ in $O(1)$ unless the mirror reaches the boundary. **Amortised argument:** non-constant work always pushes the rightmost reach further right, and that reach moves $\le n$ times in total.

### 4. Adversarial Interval DP — the Coin Game *(applied P9)*
- **Problem** ➔ a row of coins $a_1..a_n$; players alternately take the **first** or the **last** coin; both play optimally; you move first. Maximise **your** total.
- **Greedy fails** ➔ on $2,100,1,1$ taking the larger end ($2$) exposes the $100$; taking the $1$ from the right guarantees you the $100$ whatever the opponent does ➔ [[Greedy Algorithm]] §2.
- **The state is the remaining range** ➔ whatever has been taken, the rest is always a contiguous $a[i..j]$. `DP[i][j] = {the maximum score obtainable playing FIRST on a[i..j]}`.
- **The zero-sum flip** ➔ if you take $a_i$, your opponent then plays first on $a[i+1..j]$ and scores $\text{DP}[i+1][j]$, so **you** get everything else: $\text{sum}(a[i..j])-\text{DP}[i+1][j]$. Taking $a_j$ gives $\text{sum}(a[i..j])-\text{DP}[i][j-1]$.
- **$\max$ becomes $\min$** ➔ $\max(S-x,\ S-y)=S-\min(x,y)$, because the $-$ sign reverses the comparison:
$$
\text{DP}[i][j]=
\begin{cases}
a_i & i=j \\
\text{sum}(a[i..j])-\min\bigl(\text{DP}[i+1][j],\ \text{DP}[i][j-1]\bigr) & \text{otherwise}
\end{cases}
$$
- **Keep it $O(1)$ per cell** ➔ precompute prefix sums so $\text{sum}(a[i..j])=\text{DP}_{\text{pre}}[j]-\text{DP}_{\text{pre}}[i-1]$ ➔ [[Maximum Subarray Sum]] §1. Without them each cell costs $O(n)$ and the bound becomes $\Theta(n^{3})$.
- **Cost** ➔ $\Theta(n^{2})$ time and space; answer $\text{DP}[1][n]$.

### 5. Split at a Cut Point — the $\Theta(n^{3})$ Family *(applied P19)*
- **The trigger** ➔ the range is not shrunk but **divided**, and the division point is itself a choice. `DP[i][j] = best over all cuts k in [i, j-1] of (DP[i][k] combined with DP[k+1][j])`.
- **Boolean parenthesisation** ➔ count the parenthesisations of $e_1\circ_1 e_2\dots\circ_{n-1}e_n$ that evaluate to **True**. The key observation: **some operator is evaluated last**, so try each $\circ_k$ as the final one.
- **Two payloads, not one** ➔ you need the True-count **and** the False-count of each subexpression, because $\vee$ can be made true by a False left operand: $\text{DP}[i][j][v]$ for $v\in\{\textbf{T},\textbf{F}\}$.
- **The combination rules** ➔ for $\wedge$: $\text{True}=T_1T_2$, $\text{False}=T_1F_2+F_1T_2+F_1F_2$; for $\vee$: $\text{True}=T_1T_2+T_1F_2+F_1T_2$, $\text{False}=F_1F_2$.
- **Cost** ➔ $O(n^{2})$ ranges $\times$ $O(n)$ cut points $=O(n^{3})$; the $\{T,F\}$ dimension is a constant $2$.
- **Same shape, credit-level classic** ➔ **matrix chain multiplication** *(named in the wrap-up)* is this recurrence with "number of scalar multiplications" as the payload and $\min$ as the decision.

## ⚙️ Core Implementation
### 🔹 The coin game — fill by increasing range length
> [!code]- Code
> ```python
> def coin_game(a):                          # a[0..n-1]
>     n = len(a)
>     pre = [0] * (n + 1)                    # prefix sums: O(1) range sums
>     for i in range(n):
>         pre[i + 1] = pre[i] + a[i]
>
>     DP = [[0] * n for _ in range(n)]
>     for i in range(n):
>         DP[i][i] = a[i]                    # base: one coin, take it
>
>     for length in range(2, n + 1):         # LENGTH-FIRST, not index-first
>         for i in range(0, n - length + 1):
>             j = i + length - 1
>             total = pre[j + 1] - pre[i]
>             left  = DP[i + 1][j]           # opponent plays first on a[i+1..j]
>             right = DP[i][j - 1]
>             DP[i][j] = total - (left if left < right else right)
>     return DP[0][n - 1]
> ```
> 💡 **Common Mistake:** **Looping `for i / for j`** ➔ $\text{DP}[i][j]$ reads $\text{DP}[i+1][j]$, which a row-major sweep has not written yet. The outer loop **must** be the range length; every interval DP shares this.
> 💡 **Common Mistake:** **Writing $\max(\text{DP}[i+1][j],\text{DP}[i][j-1])$** ➔ those are the **opponent's** scores. Factoring out the minus sign turns your $\max$ into a $\min$ over theirs — dropping that flip is the single marked error in this problem.
> 💡 **Common Mistake:** **Summing $a[i..j]$ inside the loop** ➔ turns $\Theta(n^{2})$ into $\Theta(n^{3})$; precompute the prefix sums.

## ⚖️ Complexity
| Problem | Subproblems | Work per subproblem | Time | Auxiliary space |
| :--- | :--- | :--- | :--- | :--- |
| Longest palindromic **subsequence** | $\Theta(n^{2})$ | $O(1)$ | $\Theta(n^{2})$ | $\Theta(n^{2})$ |
| Longest palindromic **substring** *(centres)* | — *(not DP)* | $O(n)$ per centre | $\Theta(n^{2})$ | $\Theta(1)$ |
| Longest palindromic **substring** `[D]` | $\Theta(n)$ radii | $O(1)$ amortised | $\Theta(n)$ | $\Theta(n)$ |
| Coin game *(adversarial)* | $\Theta(n^{2})$ | $O(1)$ **with prefix sums** | $\Theta(n^{2})$ | $\Theta(n^{2})$ |
| Boolean parenthesisation *(split)* | $\Theta(n^{2})$ | $O(n)$ cuts | $O(n^{3})$ | $\Theta(n^{2})$ |

- **The discriminator between $n^{2}$ and $n^{3}$** ➔ *shrink* recurrences look at $O(1)$ successors; *split* recurrences look at $O(n)$ cut points. Read the recurrence, not the problem statement.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace — the coin game
Coins $a=[6,\,9,\,1,\,2,\,16,\,8]$. Filled by increasing range length; $S=\text{sum}(a[i..j])$.

| Length | Range $[i..j]$ | $S$ | $\text{DP}[i{+}1][j]$ | $\text{DP}[i][j{-}1]$ | $S-\min$ | $\text{DP}[i][j]$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $1$ | each $[i..i]$ | — | — | — | — | $6,\ 9,\ 1,\ 2,\ 16,\ 8$ |
| $2$ | $[1..2]$ | $15$ | $9$ | $6$ | $15-6$ | $9$ |
| $2$ | $[2..3]$ | $10$ | $1$ | $9$ | $10-1$ | $9$ |
| $2$ | $[3..4]$ | $3$ | $2$ | $1$ | $3-1$ | $2$ |
| $2$ | $[4..5]$ | $18$ | $16$ | $2$ | $18-2$ | $16$ |
| $2$ | $[5..6]$ | $24$ | $8$ | $16$ | $24-8$ | $16$ |
| $3$ | $[1..3]$ | $16$ | $9$ | $9$ | $16-9$ | $7$ |
| $3$ | $[2..4]$ | $12$ | $2$ | $9$ | $12-2$ | $10$ |
| $3$ | $[3..5]$ | $19$ | $16$ | $2$ | $19-2$ | $17$ |
| $3$ | $[4..6]$ | $26$ | $16$ | $16$ | $26-16$ | $10$ |
| $4$ | $[1..4]$ | $18$ | $10$ | $7$ | $18-7$ | $11$ |
| $4$ | $[2..5]$ | $28$ | $17$ | $10$ | $28-10$ | $18$ |
| $4$ | $[3..6]$ | $27$ | $10$ | $17$ | $27-10$ | $17$ |
| $5$ | $[1..5]$ | $34$ | $18$ | $11$ | $34-11$ | $23$ |
| $5$ | $[2..6]$ | $36$ | $17$ | $18$ | $36-17$ | $19$ |
| $6$ | $[1..6]$ | $42$ | $19$ | $23$ | $42-19$ | $\mathbf{23}$ |

**Final Extracted Output:** $\text{DP}[1][6]=\mathbf{23}$ — matching the sheet. The opponent therefore scores $42-23=19$.

- **Read the trap** ➔ at $[1..6]$ the $\min$ picks $\text{DP}[2][6]=19$, i.e. **taking the left coin $a_1=6$**. The larger end is $a_6=8$, so the optimal first move is the *smaller* coin.
- **Read the fill order** ➔ every row uses only values from shorter ranges; the length column **is** the dependency order.

### Applied Exercise — kill the greedy strategy *(P9a)*
**Problem:** show that *"always take the more valuable end"* is not optimal.
$$
\begin{aligned}
a&=[2,\ 100,\ 1,\ 1] \\
\text{Greedy: } & \text{take } 2 \Rightarrow [100,1,1] \Rightarrow \text{opponent takes } 100 \Rightarrow \text{you finish with } 2+1=3. \\
\text{Optimal: } & \text{take the right } 1 \Rightarrow [2,100,1];\ \text{either opponent move leaves you the } 100.
\end{aligned}
$$
**Final Extracted Output:** greedy $3$ vs optimal $\ge101$. **The reusable move (LO1):** in a two-player game the state is *what remains*, and *what remains* is a contiguous range — so the paradigm is interval DP, and the opponent's optimum enters your recurrence with a **minus sign**.

## ⚠️ Common Mistakes
- 💡 **Index-major fill order** ➔ `for i / for j` reads shorter ranges that have not been computed. Loop on **length** first, always.
- 💡 **Forgetting the $\max\to\min$ flip in an adversarial DP** ➔ $\max(S-x,S-y)=S-\min(x,y)$; keeping $\max$ silently models a cooperative opponent.
- 💡 **Recomputing range sums** ➔ $\Theta(n^{3})$ where $\Theta(n^{2})$ was asked for; prefix sums are $\Theta(n)$ up front.
- 💡 **Applying the subsequence recurrence to a substring question** ➔ contiguity changes the problem; the DP above answers *subsequence* only ➔ §3.
- 💡 **Omitting the empty-range convention** ➔ $\text{DP}[i][j]=0$ for $i>j$ is what makes $2+\text{DP}[i+1][j-1]$ correct on an adjacent matching pair.

## 🧠 Active Recall
> [!FAQ]- Why must an interval DP be filled by increasing range length, and what goes wrong otherwise?
> > [!SUCCESS]- Answer
> > - **Short answer:** every cell reads **strictly shorter** ranges, so length is the topological order of the dependency graph; a row-major sweep reads unwritten cells.
> > - **Why:** **The recurrences index $[i+1][j]$, $[i][j-1]$ and $[i+1][j-1]$** ➔ all are shorter by at least one, and two of them sit in a *later* row than $[i][j]$ under row-major order. **A bottom-up fill order is a correctness condition** ➔ not a style choice ➔ [[Dynamic Programming]] §6. **Top-down memoised recursion avoids the issue entirely** ➔ recursion visits dependencies on demand, which is one reason to prefer it when the fill order is awkward.

> [!FAQ]- Two players alternate taking the first or last coin of a row, both optimal. Define the subproblem and explain the sign.
> - **Hint:** what does your opponent's best score do to yours?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\text{DP}[i][j]=$ your best score playing **first** on $a[i..j]$, and it equals $\text{sum}(a[i..j])-\min(\text{DP}[i+1][j],\ \text{DP}[i][j-1])$.
> > - **Why:** **The remaining coins are always contiguous** ➔ removals only ever happen at the two ends, so the range is a sufficient state and there are $\Theta(n^{2})$ subproblems. **The game is zero-sum over the range** ➔ after your move, your opponent plays first on the rest and scores $\text{DP}[\cdot]$; everything else in the range is yours, hence $S-\text{DP}[\cdot]$. **The sign flips the optimisation** ➔ maximising $S-x$ means minimising $x$, so your $\max$ over your two moves becomes a $\min$ over their two resulting scores.

> [!FAQ]- You see a range subproblem whose recurrence tries **every** cut point $k$ inside $[i,j]$. What is the bound, and name the classic instances.
> > [!SUCCESS]- Answer
> > - **Short answer:** $O(n^{3})$ — $\Theta(n^{2})$ ranges $\times$ $O(n)$ cuts — with **matrix chain multiplication** and **boolean parenthesisation** as the standard instances.
> > - **Why:** **The cut is itself a decision** ➔ unlike the shrink recurrences, which look at a constant number of successors, a split must price all $j-i$ ways of dividing the range. **The observation that licenses it** ➔ *something* is done last (the final operator, the final multiplication), and trying each candidate covers every possibility exactly once. **The payload varies, the shape does not** ➔ counting for parenthesisation, $\min$ scalar multiplications for matrix chain — recognising the shape is the LO1 skill ➔ [[Dynamic Programming]] §8.
