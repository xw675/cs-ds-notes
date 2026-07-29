---
unit: [FIT1008, FIT1058, FIT2004]
domain: [A, D]
week: [1, 6]
source: [applied]
parent: "[[Algorithmic Complexity]]"
tags: [Math/Discrete, CS/Complexity, Math/Sequences]
---
# [[Arithmetic Series]]

**Context:** [[FIT1008_MOC]], [[FIT1058_MOC]], [[FIT2004_MOC]] · the sum of an [[Arithmetic, Geometric, and Harmonic Sequences|arithmetic sequence]] · the counting tool behind nested-loop [[Algorithmic Complexity|Time Complexity]]
**FIT2004 use:** the $\Theta(n^2)$ behind shrink-by-one recurrences ($T(n)=T(n-1)+cn$) and behind $n$ sorted insertions into a [[Binary Search Tree (BST)|BST]].

> [!abstract] Quick Revision
> - **🎯 Objective:** sum a constant-difference sequence ➔ $S_n = n\times$ (average of first and last term).
> - **📦 Core Components:** general $S_n=na+\tfrac{n(n-1)}{2}d$ ➔ the $\sum k=\tfrac{n(n-1)}{2}$ case.
> - **⚡ Key Constraint:** $\sum_{k=1}^{n-1}k=\Theta(n^2)$ ➔ why a "shrinking" nested loop is quadratic, not linear.

## 📝 Core
### 1. The Series (Constant Difference)
- **General sum** ➔ from first term $a$, $n$ terms: $S_n=na+\frac{n(n-1)}{2}d$.
- **Algorithm-analysis case** ➔ $1+2+\dots+(n-1)=\frac{n(n-1)}{2}=\frac{n^2-n}{2}=\Theta(n^2)$.
- **Gauss pairing** ➔ $1+(n-1)=2+(n-2)=\dots=n$, over $\tfrac{n-1}{2}$ pairs.

### 2. Reverse-and-Add (FIT1058)
- **Method** ➔ write $S_n$ forwards and backwards, aligned ➔ every column sums to $2a+(n-1)d$.
- **Result** ➔ $2S_n=n(2a+(n-1)d) \Rightarrow S_n=n\cdot\frac{a+(a+(n-1)d)}{2}$.
- **Dominant term** ➔ $na$ linear, $\frac{n(n-1)}{2}d$ **quadratic** ➔ sign of $d$ decides $S_n\to\pm\infty$.

### 3. Which Series a Loop Generates
- **Arithmetic** $\sum k=\Theta(n^2)$ ➔ nested loops whose inner count shrinks by one.
- **Geometric** $\sum 2^i=2^{k+1}-1$ ➔ [[Binary Tree]] node counts, $\log n$ height.

## ⚖️ Core Decision Matrix
| Sum | Closed form | Order |
| :--- | :--- | :--- |
| $\sum_{k=1}^{n} k$ | $\dfrac{n(n+1)}{2}$ | $\Theta(n^2)$ |
| $\sum_{k=1}^{n-1} k$ | $\dfrac{n(n-1)}{2}$ | $\Theta(n^2)$ |
| $\sum_{i=0}^{k} 2^i$ ([[Geometric Series]]) | $2^{k+1}-1$ | $\Theta(2^k)$ |
| $\sum_{k=1}^{n} k^2$ | $\dfrac{n(n+1)(2n+1)}{6}$ | $\Theta(n^3)$ |

> [!NOTE] **When It Flips:** the constant $\tfrac12$ and lower-order $-\tfrac n2$ drop under [[Big-O Notation]], leaving $\Theta(n^2)$ — but the **exact** closed form is needed for tight constants or off-by-one correctness.

## 📊 Exam Execution Trace

### Manual Execution Trace
Counting a shrinking nested loop, $n=5$:

| Step / State | Outer pass | Inner iterations | Running total |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | 0 |
| 1 | 1 | 4 | 4 |
| 2 | 2 | 3 | 7 |
| 3 | 3 | 2 | 9 |
| 4 | 4 | 1 | $10=\frac{5\cdot4}{2}$ |

## ⚠️ Common Mistakes
- 💡 **Shrinking inner count is still $\Theta(n^2)$** ➔ not $\Theta(n)$; a sum of $\Theta(n)$ terms each averaging $\Theta(n)$ is quadratic.

## ✍️ Practice
> [!QUESTION]- Practice 1: Prove $\sum_{i=1}^{n}i=\frac{n(n+1)}{2}$ for $n\ge1$ by induction.
> - **Hint:** In the step, add $k+1$ and factor it out.
> > [!SUCCESS]- Answer
> > - **Basis ($n=1$):** LHS $=1$; RHS $=\frac{1\cdot2}{2}=1$. ✓
> > - **Hypothesis:** assume $\sum_{i=1}^{k}i=\frac{k(k+1)}{2}$ for some $k\ge1$.
> > - **Step:** $$\sum_{i=1}^{k+1}i=\frac{k(k+1)}{2}+(k+1)=\frac{k(k+1)+2(k+1)}{2}=\frac{(k+1)(k+2)}{2}$$ which is the claim at $n=k+1$.
> > - **Short answer:** basis and step hold ⟹ true for all $n\ge1$. **Q.E.D.**
> > - **Why:** **Factor, don't expand** ➔ pulling out $(k+1)$ lands the target form directly; multiplying out to $\frac{k^2+3k+2}{2}$ then re-factoring is the same work done twice.

## 🧠 Active Recall
> [!FAQ]- A nested loop's inner count shrinks by one each pass — why is it $\Theta(n^2)$, not $\Theta(n)$, and what is the exact count?
> - **Hint:** A shrinking sum is still quadratic.
> > [!SUCCESS]- Answer
> > - **Short answer:** Total iterations $=(n-1)+\dots+1=\frac{n(n-1)}{2}=\Theta(n^2)$.
> > - **Why:** **Averaging** ➔ $\Theta(n)$ terms each averaging $\Theta(n)$ ⟹ quadratic, even though no single pass does $n$ work.

> [!FAQ]- Match each series to the algorithm class it powers: arithmetic vs geometric.
> - **Hint:** Series shape ↔ cost shape.
> > [!SUCCESS]- Answer
> > - **Short answer:** Arithmetic $\sum k=\Theta(n^2)$ → quadratic sorts; geometric $\sum 2^i=2^{k+1}-1$ → tree node counts / $\log n$ height.
> > - **Why:** **Loop geometry** ➔ linear-shrink inner loops sum arithmetically; branching structures sum geometrically.

> [!FAQ]- When is the *closed form* needed rather than just the $\Theta$ order?
> - **Hint:** Constants and off-by-one.
> > [!SUCCESS]- Answer
> > - **Short answer:** For exact constants, tight proof bounds, or off-by-one loop reasoning.
> > - **Why:** **Order hides constants** ➔ two $\Theta(n^2)$ algorithms differ by leading coefficient; whether a sum runs to $n$ or $n-1$ changes the exact count.
