---
unit: FIT2004
domain: [A, D]
week: [1, 2]
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
  - verifying a recurrence by induction
---
# [[Solving Recurrences (Telescoping)]]

**Context:** [[FIT2004_MOC]] · turning a cost recurrence $T(n)$ into a [[Big-O Notation|Big-O]] bound · the analysis half of [[Divide and Conquer]]
**Upstream and downstream:** getting the recurrence *out of the code*, and the **auxiliary space** it costs, live in [[Analysing Recursive Algorithms (Time and Auxiliary Space)]] — this note owns only the solving.

> [!abstract] Quick Revision
> - **🎯 Objective:** a recursive algorithm's running time obeys a **[[Recurrence Relation|recurrence]]** ($T(N)=T(N-1)+c$, $T(N)=T(N/2)+c$, $T(n)=aT(n/b)+f(n)$, …) ➔ solve it for a closed-form growth class by **telescoping**.
> - **📦 Core Components:** **levels** ➔ **substitute** ➔ **general form in $k$** ➔ **fix $k$ from the base** ➔ **closed form** ➔ **complexity** ➔ **verify (base + general)** | with $\ge2$ calls the general form is a **level-sum**, and its **ratio $a/b$** decides the answer.
> - **⚡ Key Constraint:** the **assessed** method is **repeated substitution (telescoping)** in the lecturer's **Steps 0–6b** — marks are for the steps, not the answer. It is the only one of the two methods covering *both* $T(n/b)$ and $T(n-1)$; the Master Theorem is a flagged shortcut with narrower reach.

## 📝 How It Works — the mandated exam format (Steps 0 → 6b)
> [!IMPORTANT] **Write every step, in this order, every time.** A correct $\Theta$ with no general form and no verification earns nothing; 6a+6b together *are* the induction that proves the closed form.

| Step | Name | What must appear on the page |
| :--- | :--- | :--- |
| **0** | Write the levels | the recurrence instantiated at $n$, $n/2$, $n/4$, $n/8$ (or $n{-}1$, $n{-}2$, …) — one line each, **before** any substitution |
| **1** | Substitute and simplify *(a little)* | fold each level into the one above, **one substitution per line**; keep $2cn/2$, $4cn/4$ visible so the series stays readable |
| **2** | Find the pattern to the general | collapse the visible series into the general form in $k$ — $T(n)=2^{k}T(n/2^{k})+kcn$ |
| **3** | Resolve base case | set the argument to the base ($n/2^{k}=1$) and solve for the depth ($k=\log_2 n$) |
| **4** | General ➔ closed form | substitute $k$ back and simplify to a **$T$-free** expression, using $T(1)=b$ |
| **5** | Time complexity | read the dominant term off the closed form ($O(n+n\log_2 n)=O(n\log n)$) |
| **6a** | Verify — base case | evaluate the closed form at $n=1$; it must return $T(1)=b$ |
| **6b** | Verify — general case | substitute the closed form for $T(n/2)$ into the **original** recurrence's RHS; it must reproduce the closed form exactly |

- **Step 0 decides the answer** ➔ four instantiated levels *before* substituting is what makes the series visible at Step 1; jumping straight to "$=2^kT(n/2^k)+kcn$" loses marks even when the bound is right.
- **A threshold base shifts $k$ by a constant, not an order** ➔ guard `if n < 3` gives $n/3^{k}<3 \Rightarrow k=\log_3 n - 1$, still $\Theta(\log n)$. Solve Step 3 with the threshold the code uses, then discard the constant.
- **Step 6b runs on log identities** ➔ $\log_2(n/2)=\log_2 n-1$ is what makes verification close.

## 🧭 Shape recognition
*(Diagnose before expanding: how the argument shrinks fixes the DEPTH, the per-step work fixes what accumulates.)*

| Recurrence shape | Argument shrinks | Depth $k$ | What accumulates | Closed form |
| :--- | :--- | :--- | :--- | :--- |
| $T(N)=T(N-1)+c$ | by $1$ | $N-1$ | $k$ constants | $\Theta(N)$ |
| $T(N)=T(N-1)+cN$ | by $1$ | $N-1$ | **arithmetic series** | $\Theta(N^2)$ |
| $T(N)=T(N/2)+c$ | by factor $2$ | $\log_2 N$ | $k$ constants | $\Theta(\log N)$ |
| $T(N)=T(N/2)+cN$ | by factor $2$ | $\log_2 N$ | **geometric, ratio $\tfrac12$** | $\Theta(N)$ |
| $T(n)=a\,T(n/b)+cn$ | by factor $b$, $a$ ways | $\log_b n$ | **geometric, ratio $a/b$** | see the level-sum below |
| $T(n)=2T(n-1)+a$ | by $1$, **$2$ ways** | $n$ | **geometric, ratio $2$** | $\Theta(2^{n})$ |
| $T(N)=T(N-1)+T(N-2)+c$ | by $1$, **$2$ ways** | $N$ | a **branching tree**, $\Theta(\varphi^{N})$ nodes | $O(2^{N})$ |

- **The one diagnostic** ➔ *subtracting* from the argument gives depth $\Theta(N)$; *dividing* gives depth $\Theta(\log N)$ — everything else is what you sum over that depth.
- **Branching on the SAME argument still telescopes** ➔ $T(n)=aT(n-1)+c$ has one argument per level ⟹ $T(n)=a^{k}T(n-k)+c\sum_{i=0}^{k-1}a^{i}$, collapsed by the [[Geometric Series]]. Only *different* arguments ($T(n-1)+T(n-2)$) break the method — bound those by the tree ($\le 2T(n-1)+c\Rightarrow O(2^{N})$).
- **Branching by subtraction is the catastrophic case** ➔ $a\ge2$ calls each shrinking by a *constant* build a tree of depth $\Theta(N)$ with $\Theta(a^{N})$ nodes ⟹ **exponential**. Naive Fibonacci is exactly $\Theta(\varphi^{N})$, $\varphi=\tfrac{1+\sqrt5}{2}$ ➔ [[Fibonacci Sequence]]; this is the recurrence that motivates memoisation.

## 📊 Worked examples 1 & 2 — subtract vs divide (`power` vs `power_better`)
*(Compressed to show **shape** only — never compress in the exam.)*
$$
\begin{aligned}
\textbf{(1) } T(N) &= T(N-1)+c = T(N-2)+2c = \dots = T(N-k)+kc, && N-k=1 \Rightarrow k=N-1 \\
&= b+(N-1)c = O(N) \\[4pt]
\textbf{(2) } T(N) &= T(N/2)+c = T(N/4)+2c = \dots = T(N/2^{k})+kc, && N/2^{k}=1 \Rightarrow k=\log_2 N \\
&= b+c\log_2 N = O(\log N)
\end{aligned}
$$
- **The lesson** ➔ `power` recurses on $N-1$, `power_better` squares the base and recurses on $N/2$; the halving is exactly why it is exponentially faster.

## ⭐ Worked example 3 — the exam exemplar, all 7 steps ($T(n)=2T(n/2)+cn$, $T(1)=b$, [[Merge Sort]])
*(This is the format every recurrence answer must copy.)*

**Step 0 — write the levels**
$$
\begin{aligned}
T(n) &= 2T(n/2)+cn \\
T(n/2) &= 2T(n/4)+cn/2 \\
T(n/4) &= 2T(n/8)+cn/4 \\
T(n/8) &= 2T(n/16)+cn/8
\end{aligned}
$$

**Step 1 — substitute it in and simplify (a little)**
$$
\begin{aligned}
T(n) &= 2T(n/2)+cn \\
&= 2\big[2T(n/4)+cn/2\big]+cn = 4T(n/4)+2cn/2+cn \\
&= 4\big[2T(n/8)+cn/4\big]+2cn/2+cn = 8T(n/8)+4cn/4+2cn/2+cn \\
&= 16T(n/16)+8cn/8+4cn/4+2cn/2+cn
\end{aligned}
$$

**Step 2 — find the pattern to the general** *(every term collapses to $cn$)*
$$
T(n) = 16\,T(n/16)+cn+cn+cn+cn = 2^{4}\,T(n/2^{4})+4cn = 2^{k}\,T(n/2^{k})+kcn
$$

**Step 3 — resolve base case** ➔ $n/2^{k}=1 \Rightarrow n=2^{k} \Rightarrow k=\log_2 n$

**Step 4 — general ➔ closed form**
$$
T(n) = 2^{\log_2 n}\,T(1)+(\log_2 n)cn = nb + cn\log_2 n
$$

**Step 5 — time complexity** ➔ $O(n+n\log_2 n)=O(n\log n)$

**Step 6a — verify, base case** ➔ $T(1)=1\cdot b + c\cdot1\cdot\log_2 1 = b$ ✅

**Step 6b — verify, general case**
$$
\begin{aligned}
2T(n/2)+cn &= 2\big[\tfrac{n}{2}b + c\tfrac{n}{2}\log_2(n/2)\big]+cn \\
&= nb + cn\big[\log_2 n-\log_2 2+1\big] = nb + cn\log_2 n \quad\text{✅ verified}
\end{aligned}
$$

## 🧮 Proof Blueprint — verifying a GIVEN closed form by induction
*(Applied 2 P3. The closed form is handed to you, so there is nothing to telescope — the marks are entirely in the induction's form.)*

- **Recognise the ask** ➔ *"use mathematical induction to prove that $T(n)=\dots$ is a solution"* ⟹ base case, an explicitly **cited** hypothesis, inductive step. Step 6b is a one-line check; this is the full [[Mathematical Induction]] apparatus.
- **⚡ Induct over the DOMAIN, not over $\mathbb{N}$** ➔ a recurrence in $T(n/2)$ is only defined at $n=2^{k}$, so the successor of $m$ is $2m$, **not** $m+1$ ($T(m+1)$ has no defining equation). State the restriction explicitly — it is a marked step.
- **The step is always: unfold once, invoke the hypothesis, re-fold with log laws** ➔ the constant is absorbed by writing $c=c\log_2 2$.

> **Theorem.** For $T(n)=T(n/2)+c$ ($n>1$), $T(1)=b$: $T'(n)=b+c\log_2 n$ satisfies $T(n)=T'(n)$ for all $n=2^{k}$, $k\ge0$.

**Base** ($k=0$): $T(1)=b=b+c\log_2 1=T'(1)\ \checkmark$
**Step** — assume $T(m)=T'(m)$ for $m=2^{k}$; show $T(2m)=T'(2m)$:
$$
\begin{aligned}
T(2m) &= T(m)+c && \text{(unfold the recurrence once)} \\
&= b+c\log_2 m+c && \text{(inductive hypothesis — cite it)} \\
&= b+c\log_2 m+c\log_2 2 && \text{(}c=c\log_2 2\text{ — the folding move)} \\
&= b+c\log_2(2m) = T'(2m) && \blacksquare
\end{aligned}
$$
- **Where the marks go** ➔ naming the domain restriction · citing the hypothesis at the line that uses it · the $c=c\log_2 2$ rewrite · closing with $T'(2m)$.
- **Reuse** ➔ same recurrence as [[Binary Search]] and fast power, so these three lines discharge several questions.

## 📊 Worked example 4 — shrink-by-one with linear work ($T(n)=T(n-1)+cn$)
The **lopsided** D&C recurrence — one subproblem of size $n-1$, $\Theta(n)$ work to produce it (quicksort's bad pivot):
$$
\begin{aligned}
T(n) &= T(n-1)+cn = T(n-k) + c\sum_{i=0}^{k-1}(n-i), && n-k=1 \Rightarrow k=n-1 \\
&= T(1) + c\sum_{j=2}^{n} j = T(1) + c\Big(\tfrac{n(n+1)}{2}-1\Big) = \Theta(n^2)
\end{aligned}
$$
- **Why quadratic** ➔ the **arithmetic series** $\sum_{j=1}^{n} j=\tfrac{n(n+1)}{2}$ — $n$ levels whose work *decreases linearly* still sum to half the full rectangle ➔ [[Arithmetic Series]].

## ⭐ The general D&C level-sum ($T(n)=a\,T(n/b)+cn$)
Telescoping a multi-call recurrence produces a **sum over levels**; expand the tree instead of the algebra:

| Level $i$ | # subproblems | Size each | Work this level |
| :--- | :--- | :--- | :--- |
| $0$ | $1$ | $n$ | $cn$ |
| $1$ | $a$ | $n/b$ | $cn\,(a/b)$ |
| $i$ | $a^{i}$ | $n/b^{i}$ | $cn\,(a/b)^{i}$ |
| leaves $k=\log_b n$ | $a^{\log_b n}=n^{\log_b a}$ | $1$ | $\Theta(n^{\log_b a})$ |

$$T(n)=\sum_{i=0}^{\log_b n} c\,n\left(\frac{a}{b}\right)^{i} \qquad\text{— a geometric series with ratio } r=\frac{a}{b}$$

- **$r<1$ ($a<b$)** ➔ series **converges** to a constant multiple of its first term ⟹ $\Theta(n)$, **root-dominated**.
- **$r=1$ ($a=b$)** ➔ every level costs $cn$, and there are $\log_b n{+}1$ ⟹ $\Theta(n\log n)$. *(Merge sort: $a{=}b{=}2$.)*
- **$r>1$ ($a>b$)** ➔ the **last term dominates** ⟹ $\Theta\!\big(n^{\log_b a}\big)$, **leaf-dominated**. *($a{=}3,b{=}2 \Rightarrow \Theta(n^{1.585})$.)*

The identity that collapses the leaf case — memorise it, it produces every leaf-dominated exponent:
$$n\left(\frac{a}{b}\right)^{\log_b n} = n\cdot\frac{n^{\log_b a}}{n} = n^{\log_b a}$$

> [!NOTE] **Exponent swap** ➔ $a^{\log_b n} = n^{\log_b a}$ — the step turning a *count of leaves* into a *power of $n$*.
> $$a^{\log_b n} = b^{\,\log_b a\,\cdot\,\log_b n} = n^{\log_b a}$$
> The exponent product is **symmetric**, so $a$ and $n$ trade places — that symmetry *is* the identity.

- **Halving-with-ceiling** ➔ $\log_2\!\left(\frac{k+1}{2}\right)+1=\log_2(k+1)$ ➔ justifies "one more level of halving costs $+1$ to the depth".
- **Instantiations** ➔ $a{=}4,b{=}2\Rightarrow\Theta(n^2)$ · $a{=}3,b{=}2\Rightarrow\Theta(n^{1.585})$ · $a{=}b{=}2\Rightarrow\Theta(n\log n)$ · $a{=}1,b{=}2\Rightarrow\Theta(n)$.

## 🔭 Beyond Week 1 — the Master Theorem *(shortcut, not in the lecture slides)*
> [!NOTE] Covers only the divide-and-conquer family, yields $O$ not $\Theta$, and **no case fits $T(n-1)$** — telescoping covers both shapes and is the required method in assessment.

For $T(n)=a\,T(n/b)+\Theta(n^{d})$ compare $d$ with the critical exponent $\log_b a$:

| Case | Condition | Result | Dominated by |
| :--- | :--- | :--- | :--- |
| 1 | $d<\log_b a$ | $\Theta\!\big(n^{\log_b a}\big)$ | the leaves |
| 2 | $d=\log_b a$ | $\Theta\!\big(n^{d}\log n\big)$ | every level equally |
| 3 | $d>\log_b a$ | $\Theta\!\big(n^{d}\big)$ | the root (combine) |

The three cases are the same **root / equal / leaves** split as the ratio $r=a/b$ above, restated for $d=1$; merge sort ($a{=}b{=}2,d{=}1$) is Case 2, matching the telescoping result.

## ⚠️ Common Mistakes
- 💡 **Skipping Steps 0 and 6** ➔ the marks live in the *derivation*: no instantiated levels and no verification is an unproven assertion, however right the $\Theta$.
- 💡 **Over-simplifying at Step 1** ➔ collapsing $4cn/4$ to $cn$ too early hides the series Step 2 must generalise.
- 💡 **Stopping at the general form** ➔ Step 2 still contains $T(\cdot)$ and an unknown $k$; fix $k$ from the base ($N-k=1$, $n/2^{k}=1$) before reading off any complexity.
- 💡 **With ≥2 calls, sum the level totals** ➔ per-level work is $cn(a/b)^i$, **not** $cn$, unless $a=b$.
- 💡 **Compare $a$ against $b$, not against $2$** ➔ $4T(n/2)$ is leaf-dominated but $2T(n/4)$ ($r=\tfrac12$) is root-dominated $\Theta(n)$.
- 💡 **Reaching for the Master Theorem on a $T(n-1)$ recurrence** ➔ no case applies to an additively-shrinking argument; the answer will be wrong, not merely unjustified.

## ✍️ Practice — the lecturer's drill set
*(Blank page, all seven steps each, then diff against the closed form.)*

| # | Recurrence | Base | Closed form | Complexity |
| :--- | :--- | :--- | :--- | :--- |
| 1 | $T(n)=T(n-1)+n+c$ | $T(0)=b$ | $b+\tfrac{n(n+1)}{2}+nc$ | $\Theta(n^2)$ |
| 2 | $T(n)=T(n-1)+2n+c$ | $T(0)=b$ | $b+n(n+1)+nc$ | $\Theta(n^2)$ |
| 3 | $T(n)=T(n-1)+n+2c$ | $T(0)=b$ | $b+\tfrac{n(n+1)}{2}+2nc$ | $\Theta(n^2)$ |
| 4 | $T(n)=T(n/2)+4c$ | $T(1)=b$ | $b+4c\log_2 n$ | $\Theta(\log n)$ |
| 5 | $T(n)=2T(n/2)+cn$ | $T(1)=b$ | $nb+cn\log_2 n$ | $\Theta(n\log n)$ |
| 6 | $T(n)=2T(n/2)+2cn$ | $T(1)=b$ | $nb+2cn\log_2 n$ | $\Theta(n\log n)$ |
| 7 | $T(n)=4T(n/2)+cn$ | $T(1)=b$ | $n^2b+cn(n-1)$ | $\Theta(n^2)$ |
| 8 | $T(n)=2T(n-1)+a$ | $T(0)=b$ | $2^{n}b+(2^{n}-1)a$ | $\Theta(2^{n})$ |

- **1 vs 2 vs 3 — the constants drill** ➔ doubling per-level work or the constant changes the *coefficient*, never the class.
- **5 vs 6 vs 7 — the ratio drill** ➔ 5 and 6 have $r=1$, 7 has $r=2$ (leaf-dominated); only changing $a$ moves the class.
- **1 vs 8 — the catastrophe drill** ➔ identical shrink and constant work, but a coefficient $2$ on the *recursive call* replaces the arithmetic series with a **geometric** one of ratio $2$ ⟹ $\Theta(n^{2})$ becomes $\Theta(2^{n})$. Branching, not per-level work, makes a recurrence exponential.

## 🥋 Drill — solve cold, then expand

> [!QUESTION]- D1: $T(n)=2T(n/2)+c$ (constant combine, **not** linear) with $T(1)=c$.
> > [!SUCCESS]- Solution
> > $$T(n)=2^{k}T(n/2^{k})+c\sum_{i=0}^{k-1}2^{i},\quad k=\log_2 n \;\Rightarrow\; T(n)=cn+c(n-1)=\Theta(n)$$
> > - **Key move:** $a{=}b{=}2$ but the combine is $\Theta(1)$, so the level-sum has ratio $2$ and is leaf-dominated ⟹ $\Theta(n)$, **not** $\Theta(n\log n)$. Merge sort's $\log$ factor comes from the $\Theta(n)$ merge, not from having two calls.

> [!QUESTION]- D2: $T(n)=4T(n/2)+cn$ — the naive D&C multiplication recurrence.
> > [!SUCCESS]- Solution
> > $$\text{level } i:\; 4^{i}\times c\,n/2^{i} = cn\,2^{i}\;(r=2>1) \;\Rightarrow\; T(n)=cn\sum_{i=0}^{\log_2 n}2^{i}=\Theta(n^{2})$$
> > - **Key move:** $r>1$ ⟹ leaf-dominated $\Theta(n^{\log_2 4})$; the branching factor $a$, not the combine, sets the exponent — cutting $a$ to $3$ drops it to $\Theta(n^{\log_2 3})$ ➔ [[Karatsuba Integer Multiplication]].

> [!QUESTION]- D3: $T(n)=T(n/2)+cn$ with $T(1)=c$ — one recursive call, linear work.
> > [!SUCCESS]- Solution
> > $$T(n)= cn\sum_{i=0}^{\log_2 n}\left(\tfrac12\right)^{i} < 2cn = \Theta(n)$$
> > - **Key move:** $r=\tfrac12<1$ ⟹ the series **converges** ⟹ **root-dominated**; the top-level scan alone accounts for the whole cost.

> [!QUESTION]- D4: $T(n)=2T(n-1)+a$ with $T(0)=b$ — **all seven steps plus both verifications** (Applied 2 P1).
> > [!SUCCESS]- Solution
> > $$\begin{aligned} T(n)&=2\big[2T(n-2)+a\big]+a=2^{2}T(n-2)+(1+2)a \\ &=2^{3}T(n-3)+(1+2+4)a \\ &=2^{k}T(n-k)+\big(2^{k}-1\big)a && (\textstyle\sum_{i=0}^{k-1}2^{i}=2^{k}-1) \\ \text{base: } n-k=0 &\Rightarrow k=n \;\Rightarrow\; T(n)=2^{n}b+(2^{n}-1)a=\Theta(2^{n})\end{aligned}$$
> > **6a** ➔ $T(0)=b+0=b$ ✅ · **6b** ➔ $2\big[2^{n-1}b+(2^{n-1}-1)a\big]+a=2^{n}b+(2^{n}-1)a$ ✅
> > - **Key move:** the accumulating series is $1+2+4+\dots$ — the $r=2$ [[Geometric Series]] corollary, **not** the arithmetic one. Writing $ka$ instead of $(2^{k}-1)a$ destroys the answer.

## 🧠 Active Recall
> [!FAQ]- A question hands you a closed form and says "prove by induction". Why is proving $P(m)\Rightarrow P(m+1)$ the wrong step?
> - **Hint:** Ask where the recurrence is even defined.
> > [!SUCCESS]- Answer
> > - **Short answer:** a recurrence in $T(n/2)$ is only defined at $n=2^{k}$, so $T(m+1)$ has no defining equation; the successor inside that domain is $2m$, and the step to prove is $T(2m)=T'(2m)$.
> > - **Why:** **Induct over the index of the domain** ➔ the induction really runs on $k$ in $n=2^{k}$, and $k\to k+1$ *is* $m\to 2m$. Stating that restriction is a marked step; skipping it leaves a step that cannot be closed.

> [!FAQ]- Two recurrences both make $2$ recursive calls on half-size inputs, yet one is $\Theta(n)$ and the other $\Theta(n\log n)$. What distinguishes them?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **combine cost**. $2T(n/2)+\Theta(1)$ is $\Theta(n)$; $2T(n/2)+\Theta(n)$ is $\Theta(n\log n)$.
> > - **Why:** **Level-sum ratio** ➔ with a $\Theta(1)$ combine the level totals grow geometrically and the $n$ leaves dominate; with a $\Theta(n)$ combine every level costs $cn$ ($r=1$) across $\log_2 n$ levels. The $\log$ factor is bought by the merge, not by the branching.

> [!FAQ]- In the level-sum $T(n)=cn\sum_i (a/b)^i$, why does the ratio $a/b$ alone decide whether the root, the leaves, or every level dominates?
> > [!SUCCESS]- Answer
> > - **Short answer:** a geometric series is controlled by its ratio — $r<1$ converges onto its **first** term (root), $r=1$ makes all $\log_b n$ terms equal, $r>1$ is dominated by its **last** term (leaves) ⟹ $\Theta(n)$, $\Theta(n\log n)$, $\Theta(n^{\log_b a})$.
> > - **Why:** **Branching vs shrinking** ➔ $a$ multiplies the subproblem count per level while $b$ divides their size, so $a/b$ is the net work growth per level and the design question is "does branching outrun shrinking?"
