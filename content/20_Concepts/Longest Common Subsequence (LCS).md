---
unit: FIT2004
week: 7
source: [applied]
domain: A
parent: "[[Dynamic Programming]]"
tags: [CS/Algorithms]
aliases: [LCS, Shortest Common Supersequence, SCS, Two-Sequence DP, Interleaving, Edit Distance]
---
# [[Longest Common Subsequence (LCS)]]

**Context:** [[FIT2004_MOC]] · the **two-prefix grid** — the shape behind LCS, shortest common supersequence, interleaving and edit distance
**Parent Framework:** [[Dynamic Programming]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\text{DP}[i][j]$ over the prefixes $a[1..i]$ and $b[1..j]$ ➔ **characters match** ⟹ consume both and $+1$; **they differ** ⟹ try dropping each, take the better.
> - **📦 Core Components:** $\Theta(nm)$ subproblems ➔ $O(1)$ each ⟹ $\Theta(nm)$ time and space | answer at $\text{DP}[n][m]$ | $\text{SCS}=n+m-\text{LCS}$.
> - **⚡ Key Constraint:** a **subsequence** deletes but never reorders — it is not a substring. The whole recurrence rests on *"if the two prefixes end in the same character, that character can be taken as the last element of a common subsequence."*

## 📝 How It Works
### 1. Why Prefixes Are the Right Subproblems
- **The observation** ➔ let $c_k$ be the **final** element of an LCS, occurring at position $i_1$ in $a$ and $i_2$ in $b$. Then $c_1\dots c_{k-1}$ must be an LCS of $a[1..i_1-1]$ and $b[1..i_2-1]$ — otherwise a longer one would extend $c$.
- **Consequence** ➔ the subproblems are **prefixes of both sequences**, i.e. a 2-D grid indexed by one cut point per sequence.
- **Edit distance shares this exact grid** ➔ the applied sheet's hint says LCS is *"very similar to the edit distance problem"*, and the [[Dynamic Programming|DP]] lecture **deliberately skips** edit distance, deferring it to the tutorial videos *"linking it up with the longest common subsequence (LCS) problem there"* — so **this note is where edit distance lands**. Same subproblems, different payload: LCS counts matches, edit distance counts insert / delete / replace operations.
- **The MEMO sentence** ➔ `DP[i][j] = {the length of a longest common subsequence of a[1..i] and b[1..j]}` for $0\le i\le n$, $0\le j\le m$.
- **The zero row and column are real cells** ➔ index from $0$, not $1$; an empty prefix is a legitimate subproblem and is where the base case lives.

### 2. The Recurrence
$$
\text{DP}[i][j]=
\begin{cases}
0 & i=0 \text{ or } j=0 \\
1+\text{DP}[i-1][j-1] & a[i]=b[j] \\
\max\bigl(\text{DP}[i-1][j],\ \text{DP}[i][j-1]\bigr) & \text{otherwise}
\end{cases}
$$
- **Match ⟹ consume both** ➔ no need to also try dropping one; keeping a matched pair never loses.
- **Mismatch ⟹ one of them cannot be last** ➔ $a[i]$ and $b[j]$ differ, so at most one can end the common subsequence; try removing each and take the better.
- **Answer** ➔ $\text{DP}[n][m]$ — unlike [[Longest Increasing Subsequence (LIS)|LIS]], no scan, because the subproblem is *not* anchored to a last element.
- **Cost** ➔ $\Theta(nm)$ subproblems $\times$ $O(1)$ $=\Theta(nm)$ time, $\Theta(nm)$ space.

### 3. Shortest Common Supersequence — Solve It by Reduction *(applied P11)*
- **Definition** ➔ a **supersequence** of $a$ contains $a$ as a subsequence; the SCS of $a,b$ is the shortest sequence containing both.
- **The identity** ➔ $\lvert\text{SCS}(a,b)\rvert=n+m-\lvert\text{LCS}(a,b)\rvert$: the SCS must contain the LCS, and every shared character is written **once** instead of twice.
- **So the whole problem is one subtraction** ➔ $\Theta(nm)$, no new algorithm.
- **The direct DP, if asked for it**
$$
\text{DP}[i][j]=
\begin{cases}
i & j=0 \\
j & i=0 \\
1+\text{DP}[i-1][j-1] & a[i]=b[j] \\
1+\min\bigl(\text{DP}[i-1][j],\ \text{DP}[i][j-1]\bigr) & \text{otherwise}
\end{cases}
$$
- **Compare the two recurrences side by side** ➔ the bases change from $0$ to *"copy what is left"*, and the mismatch case flips $\max$ to $1+\min$. Everything else is identical — that similarity **is** the marked observation (LO1).

### 4. Interleaving — the Same Grid With the Third Index Deleted *(applied P13)*
- **Problem** ➔ given $A$ ($n$), $B$ ($m$) and $C$ ($n+m$), decide whether $C$ interleaves $A$ and $B$.
- **The naive subproblem carries three indices** ➔ `DP[i][j][k] = {can A[i..n] and B[j..m] be interleaved to form C[k..n+m]?}` ⟹ $O(nm(n+m))$ subproblems.
- **The elimination** ➔ having consumed up to $i$ in $A$ and $j$ in $B$, you are **necessarily** at position $i+j-1$ in $C$ ⟹ $k$ is redundant, and $\text{DP}[i][j]$ suffices ➔ $\Theta(nm)$. Same move as the ferry problem ➔ [[Dynamic Programming]] §5.
- **The recurrence is a boolean `or`** ➔ try taking the next character from $A$, and from $B$; either working is enough.
$$
\text{DP}[i][j]=
\begin{cases}
\textbf{True} & i=n+1 \text{ and } j=m+1 \\
\text{DP}[i+1][j]\ \textbf{ or }\ \text{DP}[i][j+1] & A[i]=C[i{+}j{-}1] \text{ and } B[j]=C[i{+}j{-}1] \\
\text{DP}[i+1][j] & A[i]=C[i{+}j{-}1] \\
\text{DP}[i][j+1] & B[j]=C[i{+}j{-}1] \\
\textbf{False} & \text{otherwise}
\end{cases}
$$
- **Answer** ➔ $\text{DP}[1][1]$; $\Theta(nm)$ subproblems at $O(1)$.

## ⚙️ Core Implementation
### 🔹 LCS length $+$ reconstruction
> [!code]- Code
> ```python
> def lcs(a, b):                                # a[0..n-1], b[0..m-1]
>     n, m = len(a), len(b)
>     DP = [[0] * (m + 1) for _ in range(n + 1)]     # row/col 0 = base case
>     for i in range(1, n + 1):
>         for j in range(1, m + 1):
>             if a[i - 1] == b[j - 1]:
>                 DP[i][j] = DP[i - 1][j - 1] + 1
>             elif DP[i - 1][j] >= DP[i][j - 1]:
>                 DP[i][j] = DP[i - 1][j]
>             else:
>                 DP[i][j] = DP[i][j - 1]
>
>     seq = []                                  # backtrack from the corner
>     i, j = n, m
>     while i > 0 and j > 0:
>         if a[i - 1] == b[j - 1]:
>             seq.append(a[i - 1])
>             i -= 1
>             j -= 1
>         elif DP[i - 1][j] >= DP[i][j - 1]:
>             i -= 1
>         else:
>             j -= 1
>     lo, hi = 0, len(seq) - 1
>     while lo < hi:
>         seq[lo], seq[hi] = seq[hi], seq[lo]
>         lo += 1
>         hi -= 1
>     return DP[n][m], seq
> ```
> 💡 **Common Mistake:** **Off-by-one between the table and the strings** ➔ $\text{DP}$ is $(n{+}1)\times(m{+}1)$ but the strings are $0$-indexed, so cell $[i][j]$ compares `a[i-1]` with `b[j-1]`. Mixing the two conventions mid-loop is the standard grid bug ➔ [[Dynamic Programming]] §9.
> 💡 **Common Mistake:** **Backtracking with a different tie-break than the fill** ➔ the reconstruction must follow the same $\ge$ / $>$ rule the fill used, or it walks off the optimal path and returns a shorter subsequence than $\text{DP}[n][m]$ claims.

> [!NOTE] 🔭 **Beyond the lecture** *(not in the slides)*: only the previous row is ever read, so the **length** can be computed in $\Theta(\min(n,m))$ space with two rolling rows. Reconstruction still needs the full table, so do not offer the rolling version when the question asks *which* characters.

## ⚖️ Complexity
| Problem | Time | Auxiliary space | Answer cell |
| :--- | :--- | :--- | :--- |
| LCS length | $\Theta(nm)$ | $\Theta(nm)$ | $\text{DP}[n][m]$ |
| LCS reconstruction | $+\ O(n+m)$ | table reused | walk back from $[n][m]$ |
| SCS by reduction | $\Theta(nm)$ | $\Theta(nm)$ | $n+m-\text{DP}[n][m]$ |
| Interleaving *(3 indices)* | $O(nm(n{+}m))$ | $O(nm(n{+}m))$ | — **do not stop here** |
| Interleaving *(2 indices)* | $\Theta(nm)$ | $\Theta(nm)$ | $\text{DP}[1][1]$ |

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
$a=\texttt{GAC}$ *(rows)*, $b=\texttt{AGCAT}$ *(columns)*. Matches are **bold**.

| | $\varnothing$ | $A$ | $G$ | $C$ | $A$ | $T$ |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $\varnothing$ | $0$ | $0$ | $0$ | $0$ | $0$ | $0$ |
| $G$ | $0$ | $0$ | $\mathbf{1}$ | $1$ | $1$ | $1$ |
| $A$ | $0$ | $\mathbf{1}$ | $1$ | $1$ | $\mathbf{2}$ | $2$ |
| $C$ | $0$ | $1$ | $1$ | $\mathbf{2}$ | $2$ | $2$ |

**Final Extracted Output:** $\text{DP}[3][5]=\mathbf{2}$. Backtracking with tie-break *"prefer up on $\ge$"*: $(3,5)\to(2,5)\to(2,4)$ **match $A$** $\to(1,3)\to(1,2)$ **match $G$** $\to(0,1)$, reversed $=\texttt{GA}$. Also valid: $\texttt{AC}$ — ties give different LCSs of the same length. $\lvert\text{SCS}\rvert=3+5-2=\mathbf{6}$, e.g. $\texttt{AGCACT}$.

- **Read the shape** ➔ a match steps **diagonally**; a mismatch steps **up or left**. A diagonal step is the only one that emits a character.
- **Read the trap** ➔ the table is non-decreasing left-to-right and top-to-bottom, so the corner really is the maximum — this is exactly why LCS needs no scan and [[Longest Increasing Subsequence (LIS)|LIS]] does.

### Applied Exercise — derive the SCS identity *(P11)*
**Problem:** prove $\lvert\text{SCS}(a,b)\rvert=n+m-\lvert\text{LCS}(a,b)\rvert$.
$$
\begin{aligned}
\text{A supersequence must contain every character of } a \text{ and of } b &\Rightarrow \lvert S\rvert\ge n+m-(\text{characters shared}) \\
\text{Characters can only be shared along a } \textbf{common subsequence} &\Rightarrow \text{shared}\le\lvert\text{LCS}\rvert \\
\text{Interleaving } a \text{ and } b \text{ around an LCS achieves it} &\Rightarrow \lvert S\rvert = n+m-\lvert\text{LCS}\rvert
\end{aligned}
$$
**Final Extracted Output:** the SCS problem is $\Theta(nm)$ **without a new recurrence**. **The reusable move (LO1):** before writing a DP, check whether the quantity asked for is an arithmetic function of one you already know how to compute.

## ⚠️ Common Mistakes
- 💡 **Treating subsequence as substring** ➔ a subsequence may skip; a substring may not. The recurrence for contiguous ranges is a different note ➔ [[Interval Dynamic Programming]].
- 💡 **Also trying the drop-one branches on a match** ➔ harmless but wasteful, and it invites a wrong `max` that undercounts; on $a[i]=b[j]$ the diagonal branch is provably optimal.
- 💡 **Keeping the third index in the interleaving problem** ➔ $O(nm(n{+}m))$ where $\Theta(nm)$ was asked for; $k=i+j-1$ is forced ➔ [[Dynamic Programming]] §5.
- 💡 **Reporting the LCS as unique** ➔ the *length* is unique, the *subsequence* is not — say *"an"* LCS, and state your tie-break, exactly as for an [[Minimum Spanning Tree|MST]].
- 💡 **Rolling the rows and then asking for the characters** ➔ the $\Theta(\min(n,m))$-space version destroys the reconstruction path.

## 🧠 Active Recall
> [!FAQ]- Why does LCS read its answer at $\text{DP}[n][m]$ while [[Longest Increasing Subsequence (LIS)|LIS]] needs a scan over the whole table?
> > [!SUCCESS]- Answer
> > - **Short answer:** LCS's subproblem is **not anchored** — $\text{DP}[i][j]$ already means *"the best over all common subsequences of these prefixes"*, so the full-prefix cell dominates every other.
> > - **Why:** **The table is monotone** ➔ extending a prefix can never shorten the best common subsequence, so $\text{DP}[n][m]\ge\text{DP}[i][j]$ for all $i,j$. **LIS's cells are incomparable** ➔ *"ending at $i$"* pins the last element, so a long chain ending early is invisible from the last cell. **The lesson generalises** ➔ decide *where the answer lives* when you write the MEMO sentence; an anchored definition always costs a scan ➔ [[Dynamic Programming]] §3.

> [!FAQ]- Given an LCS routine, how long does the shortest common supersequence take, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\Theta(nm)$ — it is $n+m-\lvert\text{LCS}\rvert$, one subtraction after the LCS run.
> > - **Why:** **The SCS must contain both sequences in order** ➔ every character of $a$ and of $b$ appears, so the only saving is characters written once instead of twice. **Shared characters form a common subsequence** ➔ so the maximum possible saving is exactly $\lvert\text{LCS}\rvert$, and it is achievable by interleaving the two around that LCS. **Writing the direct DP is also fine** ➔ the recurrence is LCS with $\max$ replaced by $1+\min$ and the bases replaced by *"copy what remains"* — but the reduction is the answer that shows you saw the structure.
