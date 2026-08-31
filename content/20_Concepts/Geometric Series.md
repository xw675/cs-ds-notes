---
unit: [FIT1058, FIT2004]
domain: D
week: [1, 6]
source: [applied]
parent: "[[Summation Notation]]"
tags: [Math/Discrete, Math/Sequences]
---
# [[Geometric Series]]

**Context:** [[FIT1058_MOC]], [[FIT2004_MOC]] · the sum of a [[Arithmetic, Geometric, and Harmonic Sequences|geometric sequence]] · finite closed form + convergent infinite case · companion to [[Arithmetic Series]]
**FIT2004 use:** the engine of every divide-and-conquer level-sum ([[Solving Recurrences (Telescoping)]]) — $r=2$ counts the nodes/leaves of a [[Binary Tree|complete binary tree]], $r=\tfrac12$ **bounds total recursion work by a constant multiple of the top level**.

> [!abstract] Quick Revision
> - **🎯 Objective:** sum $a+ar+\dots+ar^{n-1}$ ➔ $S_n=a\frac{r^n-1}{r-1}$ ($r\neq1$).
> - **📦 Core Components:** finite closed form ➔ infinite $\frac{a}{1-r}$ if $|r|<1$.
> - **⚡ Key Constraint:** converges **iff** $|r|<1$; $r=1$ handled separately ($S_n=na$).

## 📝 Core
### 1. The Series and its closed form
- **Definition** ➔ first term $a$, ratio $r$: $S_n=\sum_{i=0}^{n-1}ar^i$; closed form $S_n=a\frac{r^n-1}{r-1}$ ($r\neq1$), $S_n=na$ if $r=1$.
- **The derivation (multiply by $r$)** ➔ $rS_n=S_n-a+ar^n$ ⟹ $(r-1)S_n=a(r^n-1)$ — multiplying by $r$ shifts the terms by one and cancels the middle.
- **Infinite case** ➔ $|r|<1 \Rightarrow r^n\to0 \Rightarrow S_\infty=\frac{a}{1-r}$; $|r|\ge1$ diverges ($r=-1$ has no limit). Arithmetic series never converge — their terms do not decay.

$$S_n=a\cdot\frac{r^n-1}{r-1}\ (r\neq1),\qquad S_\infty=\frac{a}{1-r}\ (|r|<1)$$

### 2. The Two Corollaries Algorithm Analysis Uses
Both drop out of $\sum_{i=0}^{n}r^{i}=\frac{r^{n+1}-1}{r-1}$ by substituting $r$ — **no new induction needed**.

- **$r=2$ — doubling/branching** ➔ $\displaystyle\sum_{i=0}^{n}2^{i}=2^{n+1}-1$ ➔ nodes of a complete [[Binary Tree]] of height $n$; the leaf level alone exceeds all levels above it combined ($2^n > 2^n-1$) — why leaf-dominated recursions are $\Theta(\text{leaves})$.
- **$r=\tfrac12$ — halving/shrinking** ➔ $\displaystyle\sum_{i=0}^{n}\frac{1}{2^{i}}=2-\frac{1}{2^{n}}<2$ ➔ a **strict, $n$-independent** bound: work that halves each level totals **less than twice the first level**.
- **Why the strict finite bound matters** ➔ it converts "$\log n$ levels of shrinking work" into $\Theta(\text{top level})$ *without* an infinite-series limit argument — the move behind $\Theta(n)$ auxiliary space for shrinking recursive frames and $T(n)=T(n/2)+cn=\Theta(n)$.

> [!NOTE] **When It Flips:** $r>1$ makes the **last** term dominate (leaf-heavy recursion trees, $S_n=\Theta(r^n)$); $r<1$ makes the **first** term dominate and caps the whole sum at a constant multiple of it (root-heavy recursions, shrinking stack frames); $r=1$ makes all levels equal.

## 📊 Exam Execution Trace

### Manual Execution Trace
$a=3,r=2$, 5 terms:

| Step / State | $i$ | term | running $S$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | 0 | 3 | 3 |
| 1 | 1 | 6 | 9 |
| 2 | 2 | 12 | 21 |
| 3 | 3,4 | 24,48 | 45,93 |

## ⚠️ Common Mistakes
- 💡 **$r=1$ breaks the formula** ➔ the denominator $r-1=0$; then every term is $a$ so $S_n=na$. The infinite sum needs the *strict* $|r|<1$.
- 💡 **Don't re-induct for a corollary** ➔ $\sum2^{i}$ and $\sum2^{-i}$ are **substitutions** into the general closed form; a fresh induction wastes exam time unless explicitly demanded.

## ✍️ Practice
> [!QUESTION]- Practice 1: Prove $\sum_{i=0}^{n}r^{i}=\frac{r^{n+1}-1}{r-1}$ for $n\ge0,\ r\neq1$ by induction.
> - **Hint:** In the step, add $r^{k+1}$ to the hypothesis over a common denominator.
> > [!SUCCESS]- Answer
> > - **Basis ($n=0$):** LHS $=r^{0}=1$; RHS $=\frac{r^{1}-1}{r-1}=1$. ✓
> > - **Hypothesis:** assume $\sum_{i=0}^{k}r^{i}=\frac{r^{k+1}-1}{r-1}$ for some $k\ge0$.
> > - **Step:** $$\sum_{i=0}^{k+1}r^{i}=\frac{r^{k+1}-1}{r-1}+r^{k+1}=\frac{r^{k+1}-1+r^{k+1}(r-1)}{r-1}=\frac{r^{k+2}-1}{r-1}$$
> > - **Short answer:** basis and step hold ⟹ true for all $n\ge0$, $r\neq1$. **Q.E.D.**
> > - **Why:** **$r\neq1$ is a hypothesis, not a footnote** ➔ the algebra divides by $r-1$ at every line; at $r=1$ the statement is replaced by $S_n=n+1$.

> [!QUESTION]- Practice 2: Without a new induction, obtain (a) $\sum_{i=0}^{n}2^{i}$ and (b) a constant bound on $\sum_{i=0}^{n}2^{-i}$. State the $r$ used.
> - **Hint:** Substitute into Practice 1's result and simplify.
> > [!SUCCESS]- Answer
> > - **(a) $r=2$:** $\sum_{i=0}^{n}2^{i}=\frac{2^{n+1}-1}{2-1}=2^{n+1}-1$.
> > - **(b) $r=\tfrac12$:** $\sum_{i=0}^{n}2^{-i}=\frac{1-(1/2)^{n+1}}{1/2}=2-2^{-n}<2$ for all $n\ge1$ — strict, and independent of $n$.
> > - **Why:** **Same identity, opposite regimes** ➔ $r>1$ makes the **last** term dominate; $r<1$ makes the **first** term dominate and caps the sum at a constant multiple of it.
