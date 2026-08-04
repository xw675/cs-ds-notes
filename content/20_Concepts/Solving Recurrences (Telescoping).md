---
unit: FIT2004
domain: [A, D]
week: 1
source: [lecture, applied]
parent: "[[Big-O Notation]]"
tags:
  - CS/Algorithms
  - CS/Complexity
  - Math/Analysis
aliases:
  - solving recurrences
  - telescoping
  - repeated substitution
  - recurrence analysis
  - T(n) recurrence
  - recursion tree
  - master theorem
---
# [[Solving Recurrences (Telescoping)]]

**Context:** [[FIT2004_MOC]] · turning a recursive algorithm's cost recurrence $T(n)$ into a [[Big-O Notation|Big-O]] bound · the analysis half of [[Divide and Conquer]] (the maths of [[Recurrence Relation]] applied to running time)
**Upstream and downstream:** getting the recurrence *out of the code*, and the **auxiliary space** the same recursion costs, live in [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] — this note owns only the solving.

> [!abstract] Quick Revision
> - **🎯 Objective:** a recursive algorithm's running time obeys a **recurrence** ($T(N)=T(N-1)+c$, $T(N)=T(N/2)+c$, $T(n)=aT(n/b)+f(n)$, …) ➔ solve it for a closed-form growth class by **telescoping**.
> - **📦 Core Components:** **expand** ➔ **general form in $k$** ➔ **fix $k$ from the base** ➔ **back-substitute** | with $\ge2$ calls the general form is a **level-sum**, and its **ratio $a/b$** decides the answer.
> - **⚡ Key Constraint:** the **assessed** method is **repeated substitution (telescoping)** — expand a few steps, spot the **general form** in $k$, fix $k$ from the **base case**, back-substitute. It is the only one of the two that covers *both* $T(n/b)$ and $T(n-1)$; the Master Theorem below is a lecturer-flagged shortcut with strictly narrower reach.

## 📝 Telescoping — the lecture method (5 steps)
1. **Write** the recurrence and its base case (e.g. $T(N)=T(N-1)+c$, $T(1)=b$).
2. **Expand** two or three steps by substituting the recurrence into itself.
3. **Spot the general form** after $k$ steps (a formula in $N$ and $k$).
4. **Fix $k$** from the base case (choose $k$ so the argument reaches the base, e.g. $N-k=1$).
	- **A threshold base shifts $k$ by a constant, not by an order** ➔ if the guard is `if n < 3` then $n/3^{k}<3 \Rightarrow k=\log_3 n - 1$, and the $-1$ is absorbed: still $\Theta(\log_3 n)=\Theta(\log n)$. Solve with the threshold the code actually uses, then discard the constant.
5. **Back-substitute** $k$ to get the closed form, then read off the Big-O.

## 🧭 Shape recognition
*(Diagnose before expanding: how the argument shrinks fixes the DEPTH, the per-step work fixes what accumulates.)*

| Recurrence shape | Argument shrinks | Depth $k$ | What accumulates | Closed form |
| :--- | :--- | :--- | :--- | :--- |
| $T(N)=T(N-1)+c$ | by $1$ | $N-1$ | $k$ constants | $\Theta(N)$ |
| $T(N)=T(N-1)+cN$ | by $1$ | $N-1$ | **arithmetic series** | $\Theta(N^2)$ |
| $T(N)=T(N/2)+c$ | by factor $2$ | $\log_2 N$ | $k$ constants | $\Theta(\log N)$ |
| $T(N)=T(N/2)+cN$ | by factor $2$ | $\log_2 N$ | **geometric, ratio $\tfrac12$** | $\Theta(N)$ |
| $T(n)=a\,T(n/b)+cn$ | by factor $b$, $a$ ways | $\log_b n$ | **geometric, ratio $a/b$** | see the level-sum below |
| $T(N)=T(N-1)+T(N-2)+c$ | by $1$, **$2$ ways** | $N$ | a **branching tree**, $\Theta(\varphi^{N})$ nodes | $O(2^{N})$ |

- **The one diagnostic** ➔ *subtracting* from the argument gives depth $\Theta(N)$; *dividing* gives depth $\Theta(\log N)$ — everything else is what you sum over that depth.
- **Branching by subtraction is the catastrophic case** ➔ $a\ge2$ calls that each shrink by a *constant* build a tree of depth $\Theta(N)$ with $\Theta(a^{N})$ nodes ⟹ **exponential**. Naive Fibonacci's $T(N)=T(N-1)+T(N-2)+c$ counts nodes, so it is bounded above by the full binary tree $2^{N}$ (exactly $\Theta(\varphi^{N})$, $\varphi=\tfrac{1+\sqrt5}{2}$ — see [[Fibonacci Sequence]]). This is the recurrence that motivates memoisation and dynamic programming.
- **This shape does NOT telescope cleanly** ➔ with two *different* arguments there is no single general form in $k$; bound it instead by the tree ($T(N)\le 2T(N-1)+c\Rightarrow O(2^{N})$).

## 📊 Worked example 1 — linear `power` ($T(N)=T(N-1)+c$)
Algorithm: `power(x, N)` returns `x * power(x, N-1)`, base `power(x,1)=x`.
$$
\begin{aligned}
T(N) &= T(N-1)+c \\
&= T(N-2)+c+c \\
&= T(N-3)+c+c+c \\
&\;\;\vdots \\
&= T(N-k)+k c && \text{(general form)} \\
\text{base: } N-k=1 &\Rightarrow k=N-1 && \text{(fix } k\text{)} \\
T(N) &= T(1)+(N-1)c = b+Nc-c = O(N) && \text{(back-substitute)}
\end{aligned}
$$

## 📊 Worked example 2 — logarithmic `power_better` ($T(N)=T(N/2)+c$)
Algorithm: repeatedly squares the base and halves $N$ — `power_better(x*x, N/2)`.
$$
\begin{aligned}
T(N) &= T(N/2)+c = T(N/4)+2c = T(N/8)+3c \\
&= T(N/2^{k})+k c && \text{(general form)} \\
\text{base: } N/2^{k}=1 &\Rightarrow 2^{k}=N \Rightarrow k=\log_2 N \\
T(N) &= T(1)+c\log_2 N = O(\log N)
\end{aligned}
$$
- **The lesson** ➔ *subtracting* from $N$ each step (Example 1) gives $O(N)$; *dividing* $N$ each step (Example 2) gives $O(\log N)$ — the halving is exactly why `power_better` beats `power`.

## 📊 Worked example 3 — divide-and-conquer ($T(n)=2T(n/2)+\Theta(n)$, [[Merge Sort]])
Telescoping still works when there is more than one recursive call — expand and sum the per-level work:
$$
\begin{aligned}
T(n) &= 2T(n/2)+cn = 2\big(2T(n/4)+c\tfrac{n}{2}\big)+cn = 4T(n/4)+2cn \\
&= 2^{k}T(n/2^{k}) + k\,cn && \text{(general form: } cn \text{ per level} \times k \text{ levels)} \\
\text{base: } n/2^{k}=1 &\Rightarrow k=\log_2 n \\
T(n) &= n\,T(1) + cn\log_2 n = \Theta(n\log n)
\end{aligned}
$$

## 📊 Worked example 4 — shrink-by-one with linear work ($T(n)=T(n-1)+cn$)
The **lopsided** D&C recurrence — one subproblem of size $n-1$, $\Theta(n)$ work to produce it (quicksort's bad pivot, selection-sort-shaped recursion):
$$
\begin{aligned}
T(n) &= T(n-1)+cn = T(n-2)+c(n-1)+cn = T(n-3)+c(n-2)+c(n-1)+cn \\
&= T(n-k) + c\sum_{i=0}^{k-1}(n-i) && \text{(general form)} \\
\text{base: } n-k=1 &\Rightarrow k=n-1 \\
T(n) &= T(1) + c\sum_{j=2}^{n} j = T(1) + c\Big(\tfrac{n(n+1)}{2}-1\Big) = \Theta(n^2)
\end{aligned}
$$
- **Why it is quadratic** ➔ the **arithmetic series** $\sum_{j=1}^{n} j=\tfrac{n(n+1)}{2}=\Theta(n^2)$ — $n$ levels whose work *decreases linearly* still sum to $\Theta(n^2)$, half the full rectangle. This is the derivation behind the $\Theta(n^2)$ lopsided row in [[Divide and Conquer]].

## ⭐ The general D&C level-sum ($T(n)=a\,T(n/b)+cn$)
Telescoping a multi-call recurrence produces a **sum over levels**; expand the tree instead of the algebra:

| Level $i$ | # subproblems | Size each | Work this level |
| :--- | :--- | :--- | :--- |
| $0$ | $1$ | $n$ | $cn$ |
| $1$ | $a$ | $n/b$ | $cn\,(a/b)$ |
| $2$ | $a^2$ | $n/b^2$ | $cn\,(a/b)^2$ |
| $i$ | $a^{i}$ | $n/b^{i}$ | $cn\,(a/b)^{i}$ |
| leaves $k=\log_b n$ | $a^{\log_b n}=n^{\log_b a}$ | $1$ | $\Theta(n^{\log_b a})$ |

$$T(n)=\sum_{i=0}^{\log_b n} c\,n\left(\frac{a}{b}\right)^{i} \qquad\text{— a geometric series with ratio } r=\frac{a}{b}$$

- **$r<1$ (i.e. $a<b$)** ➔ series **converges** to a constant multiple of its first term ⟹ $\Theta(n)$, **root-dominated** (the top-level combine is the whole cost).
- **$r=1$ (i.e. $a=b$)** ➔ **every level costs the same** $cn$, and there are $\log_b n{+}1$ of them ⟹ $\Theta(n\log n)$. *(Merge sort: $a{=}b{=}2$.)*
- **$r>1$ (i.e. $a>b$)** ➔ the **last term dominates** ⟹ $\Theta\!\big(n(a/b)^{\log_b n}\big)=\Theta\!\big(n^{\log_b a}\big)$, **leaf-dominated**. *($a{=}3,b{=}2$, $r=\tfrac32>1$ ⟹ $\Theta(n^{\log_2 3})\approx\Theta(n^{1.585})$.)*

The identity that collapses the leaf case — worth memorising, it produces every leaf-dominated exponent:
$$n\left(\frac{a}{b}\right)^{\log_b n} = n\cdot\frac{a^{\log_b n}}{b^{\log_b n}} = n\cdot\frac{n^{\log_b a}}{n} = n^{\log_b a}$$

### 🔹 The two log identities it rests on
> [!NOTE] **Exponent swap** ➔ $a^{\log_b n} = n^{\log_b a}$ for any base $b>1$ — the step that turns a *count of leaves* into a *power of $n$*.
> $$a^{\log_b n} = \big(b^{\log_b a}\big)^{\log_b n} = b^{\,\log_b a\,\cdot\,\log_b n} = \big(b^{\log_b n}\big)^{\log_b a} = n^{\log_b a}$$
> The product in the exponent is **symmetric**, so $a$ and $n$ may trade places — that symmetry *is* the identity.

- **Halving-with-ceiling** ➔ $\log_2\!\left(\frac{k+1}{2}\right)+1=\log_2(k+1)$, since $\log_2\frac{k+1}{2}=\log_2(k+1)-\log_2 2=\log_2(k+1)-1$ ➔ justifies "one more level of halving costs $+1$ to the depth", the step that makes depth $=\log_2 n$ rather than an unevaluated recursion.

- **Instantiations** ➔ $a{=}4,b{=}2\Rightarrow\Theta(n^{\log_2 4})=\Theta(n^2)$ · $a{=}3,b{=}2\Rightarrow\Theta(n^{\log_2 3})\approx\Theta(n^{1.585})$ · merge sort $a{=}b{=}2\Rightarrow\Theta(n\log n)$ · a single half with $\Theta(n)$ work $a{=}1,b{=}2\Rightarrow\Theta(n)$.

## 🔭 Beyond Week 1 — the Master Theorem *(shortcut, not in the lecture slides)*
> [!NOTE] A lookup that skips the algebra for the divide-and-conquer family only. **Cite telescoping in assessment** — the lecturer scoped the two methods explicitly:
>
> | | Telescoping | Master Theorem |
> | :--- | :--- | :--- |
> | $T(n/b)$ — divide | ✅ | ✅ |
> | $T(n-1)$ — shrink by one | ✅ | ❌ **no case fits** |
> | Bound it yields | closed form ⟹ $\Theta$ | $O$ only |
> | Assessment status | **required** | supplementary |

For $T(n)=a\,T(n/b)+\Theta(n^{d})$ compare $d$ with the critical exponent $\log_b a$:

| Case | Condition | Result | Dominated by |
| :--- | :--- | :--- | :--- |
| 1 | $d<\log_b a$ | $\Theta\!\big(n^{\log_b a}\big)$ | the leaves |
| 2 | $d=\log_b a$ | $\Theta\!\big(n^{d}\log n\big)$ | every level equally |
| 3 | $d>\log_b a$ | $\Theta\!\big(n^{d}\big)$ | the root (combine) |

Quick checks: merge sort $a{=}2,b{=}2,d{=}1\Rightarrow\log_2 2{=}1$ = Case 2 ⟹ $\Theta(n\log n)$; $a{=}3,b{=}2,d{=}1$ with $\log_2 3\approx1.585{>}1$ = Case 1 ⟹ $\Theta(n^{1.585})$ — matching the telescoping results above. The three cases are the same **root / equal / leaves** split as the ratio $r=a/b$ above, restated for $d=1$.

## ⚠️ Common Mistakes
- 💡 **Fix $k$ from the base case** ➔ the general form has an unknown depth $k$; you must set it so the recursion reaches the base (e.g. $N-k=1$ or $n/2^{k}=1$) before reading off the complexity.
- 💡 **Subtract vs divide changes the class** ➔ $T(N)=T(N-1)+c\Rightarrow O(N)$ but $T(N)=T(N/2)+c\Rightarrow O(\log N)$; check whether the argument shrinks additively or multiplicatively.
- 💡 **With ≥2 calls, sum the level totals** ➔ don't forget the $a^{i}$ multiplier on each level's work; the per-level totals are $cn(a/b)^i$, **not** $cn$, unless $a=b$.
- 💡 **Decreasing per-level work is not free** ➔ $T(n)=T(n-1)+cn$ is $\Theta(n^2)$, not $\Theta(n)$ — the arithmetic series still costs half the rectangle.
- 💡 **Compare $a$ against $b$, not against $2$** ➔ the regime is set by the ratio $a/b$; $4T(n/2)$ is leaf-dominated but $2T(n/4)$ ($r=\tfrac12$) is root-dominated $\Theta(n)$.
- 💡 **Reaching for the Master Theorem on a $T(n-1)$ recurrence** ➔ no case of it applies to an additively-shrinking argument; the answer will be wrong, not merely unjustified. Telescope instead.

## 🥋 Drill — solve cold, then expand
*(Revision protocol: blank page → telescope to a closed form → expand and diff. Naming the growth class without the general-form line earns nothing.)*

> [!QUESTION]- D1: $T(n)=2T(n/2)+c$ (constant combine, **not** linear) with $T(1)=c$.
> > [!SUCCESS]- Solution
> > $$\begin{aligned} T(n)&=2T(n/2)+c=4T(n/4)+2c+c=\dots=2^{k}T(n/2^{k})+c\sum_{i=0}^{k-1}2^{i} \\ \text{base: } n/2^{k}=1 &\Rightarrow k=\log_2 n \\ T(n)&=n\,T(1)+c(2^{\log_2 n}-1)=cn+cn-c=\Theta(n)\end{aligned}$$
> > - **Key move:** $a{=}2,b{=}2$ but the combine is $\Theta(1)$, so the level-sum is **geometric with ratio $2$** and leaf-dominated ⟹ $\Theta(n^{\log_2 2})=\Theta(n)$ — **not** $\Theta(n\log n)$. The $\log$ factor in merge sort comes from the $\Theta(n)$ merge, not from having two calls.

> [!QUESTION]- D2: $T(n)=4T(n/2)+cn$ — the naive D&C multiplication recurrence.
> > [!SUCCESS]- Solution
> > $$\begin{aligned} \text{level } i:\;& 4^{i}\text{ subproblems}\times c\,n/2^{i} = cn\,2^{i} && (r=a/b=2>1) \\ T(n)&=cn\sum_{i=0}^{\log_2 n}2^{i}=cn\big(2^{\log_2 n+1}-1\big)=\Theta(n\cdot n)=\Theta(n^{2})\end{aligned}$$
> > - **Key move:** $r>1$ ⟹ leaf-dominated ⟹ $\Theta(n^{\log_2 4})=\Theta(n^2)$ — the branching factor $a$, not the combine, sets the exponent; cutting $a$ to $3$ would drop it to $\Theta(n^{\log_2 3})$.

> [!QUESTION]- D3: $T(n)=T(n/2)+cn$ with $T(1)=c$ — one recursive call, linear work.
> > [!SUCCESS]- Solution
> > $$\begin{aligned} T(n)&=cn+c\tfrac{n}{2}+c\tfrac{n}{4}+\dots = cn\sum_{i=0}^{\log_2 n}\left(\tfrac12\right)^{i} < 2cn = \Theta(n)\end{aligned}$$
> > - **Key move:** $r=\tfrac12<1$ ⟹ the series **converges** ⟹ **root-dominated** $\Theta(n)$; the top-level scan alone accounts for the whole cost, and the $\log_2 n$ levels contribute only a constant factor $<2$.

## 🧠 Active Recall
> [!FAQ]- Solve $T(N)=T(N/2)+c$ by telescoping and give the complexity.
> > [!SUCCESS]- Answer
> > - **Short answer:** expanding gives $T(N)=T(N/2^{k})+kc$; the base case $N/2^{k}=1$ fixes $k=\log_2 N$, so $T(N)=T(1)+c\log_2 N=O(\log N)$.
> > - **Why:** **Halving depth is logarithmic** ➔ each step divides the argument by $2$ and adds constant work, so it takes $\log_2 N$ steps to reach the base and the total is $\Theta(\log N)$ — this is why `power_better` is exponentially faster than the $O(N)$ `power`.

> [!FAQ]- Why does `power` cost $O(N)$ but `power_better` only $O(\log N)$, in terms of their recurrences?
> > [!SUCCESS]- Answer
> > - **Short answer:** `power` recurses on $N-1$ ($T(N)=T(N-1)+c$), telescoping to $T(N)=T(1)+(N-1)c=O(N)$; `power_better` recurses on $N/2$ ($T(N)=T(N/2)+c$), telescoping to $O(\log N)$.
> > - **Why:** **Additive vs multiplicative shrink** ➔ subtracting $1$ needs $\sim N$ steps to reach the base, while halving needs only $\sim\log_2 N$; the constant per-step work then sums to $O(N)$ vs $O(\log N)$.

> [!FAQ]- Two recurrences both make $2$ recursive calls on half-size inputs, yet one is $\Theta(n)$ and the other $\Theta(n\log n)$. What distinguishes them?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **combine cost**. $2T(n/2)+\Theta(1)$ is $\Theta(n)$; $2T(n/2)+\Theta(n)$ is $\Theta(n\log n)$.
> > - **Why:** **Level-sum ratio** ➔ with $\Theta(1)$ combine the level totals *grow* geometrically ($1,2,4,\dots$) and the $n$ leaves dominate ⟹ $\Theta(n)$; with $\Theta(n)$ combine every level costs exactly $cn$ ($r=a/b=1$) and there are $\log_2 n$ of them ⟹ $\Theta(n\log n)$. The $\log$ factor is bought by the merge, not by the branching.

> [!FAQ]- In the level-sum $T(n)=cn\sum_i (a/b)^i$, why does the ratio $a/b$ alone decide whether the root, the leaves, or every level dominates?
> > [!SUCCESS]- Answer
> > - **Short answer:** a geometric series is controlled by its ratio — $r<1$ converges onto its **first** term (root), $r=1$ makes all $\log_b n$ terms equal, $r>1$ is dominated by its **last** term (leaves), giving $\Theta(n)$, $\Theta(n\log n)$, $\Theta(n^{\log_b a})$ respectively.
> > - **Why:** **Branching vs shrinking** ➔ $a$ multiplies the subproblem count per level while $b$ divides their size; $a/b$ is the net work growth per level down the tree, so the algorithm's whole design question is "does branching outrun shrinking?"
