---
unit: FIT1058
week: 8
parent: "[[Counting Principles]]"
tags: [Math/Combinatorics, Math/Discrete, Monash/CS_DS]
---
# [[Selection (Counting Framework)]]

**Context:** [[FIT1058_MOC]] · choosing $r$ from $n$ objects · classified by **order** × **replacement** · unifies $n^r$, falling factorial, $\binom{n}{r}$, and [[Stars and Bars|stars-and-bars]]

> [!abstract] Quick Revision
> - **🎯 Objective:** count ways to pick $r$ from $n$ ➔ by two yes/no questions: order? replacement?.
> - **📦 Core Components:** ordered/with $n^r$ ➔ ordered/without $(n)_r$ ➔ unordered/without $\binom{n}{r}$ ➔ unordered/with $\binom{r+n-1}{r}$.
> - **⚡ Key Constraint:** identify the cell first; order divides ordered counts by $r!$.

## 📝 Core
### 1. Two Questions
- **Order?** ➔ ordered vs unordered.
- **Replacement?** ➔ with vs without reuse.
- **Result** ➔ the $2\times2$ gives four formulas.

### 2. The Four Cells
- **Ordered, with** ➔ $n^r$ (strings/functions).
- **Ordered, without** ➔ $(n)_r=\frac{n!}{(n-r)!}$ (queues/injections).
- **Unordered, without** ➔ $\binom{n}{r}=\frac{(n)_r}{r!}$ (committees/subsets).
- **Unordered, with** ➔ $\binom{r+n-1}{r}$ ([[Stars and Bars]], multisets).

### 3. The Falling Factorial
- **$(n)_r$** ➔ shrinking option count $n,n-1,\dots,n-r+1$ ($r$ factors).
- **÷ $r!$** ➔ removes ordering ⟹ $\binom{n}{r}$ ([[Binomial Coefficient]]).

**Key identities:**

$$\text{ordered: } n^r \text{ (with)},\ (n)_r=\tfrac{n!}{(n-r)!} \text{ (without)}$$
$$\text{unordered: } \binom{r+n-1}{r} \text{ (with)},\ \binom{n}{r}=\tfrac{(n)_r}{r!} \text{ (without)}$$

## ⚖️ Core Decision Matrix
| | Without replacement | With replacement |
| :--- | :--- | :--- |
| **Ordered** | $(n)_r=\frac{n!}{(n-r)!}$ | $n^r$ |
| **Unordered** | $\binom{n}{r}$ | $\binom{r+n-1}{r}$ |

> [!NOTE] **When It Flips:** ordered counts exceed their unordered partners by exactly $r!$ (the orderings of the chosen items), so $\binom{n}{r}=(n)_r/r!$. Each cell was met before: $n^r$ = functions/strings, $(n)_r$ = injections, $\binom{n}{r}$ = subsets.

## 📊 Exam Execution Trace

### Manual Execution Trace
$n=5$, $r=3$, all four modes:

| Step / State | Mode | Formula | Count |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | ordered, with | $5^3$ | 125 |
| 2 | ordered, without | $(5)_3$ | 60 |
| 3 | unordered, without | $\binom{5}{3}$ | 10 |
| 4 | unordered, with | $\binom{7}{3}$ | 35 |

## ⚠️ Common Mistakes
- 💡 **Replacement's "simpler" side flips** ➔ for *ordered*, with-replacement ($n^r$) is simpler; for *unordered*, without-replacement ($\binom{n}{r}$) is simpler and the with-replacement case needs the bijection trick.

## 🧠 Active Recall
> [!FAQ]- Give the four selection counts for choosing $r$ from $n$.
> - **Hint:** Order × replacement.
> > [!SUCCESS]- Answer
> > - **Short answer:** $n^r$ (ord/with), $(n)_r$ (ord/without), $\binom{n}{r}$ (unord/without), $\binom{r+n-1}{r}$ (unord/with).
> > - **Why:** **÷$r!$** ➔ order divides the ordered counts down to unordered.

> [!FAQ]- Why is $\binom{n}{r}=(n)_r/r!$, and which two questions decide the formula?
> - **Hint:** Remove ordering.
> > [!SUCCESS]- Answer
> > - **Short answer:** Each unordered choice arises from $r!$ ordered arrangements; divide to remove order.
> > - **Why:** **Two questions** ➔ does order matter, is replacement allowed — select one of four cells.
