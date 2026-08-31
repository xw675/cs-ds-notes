---
unit: [FIT1058, FIT2004]
domain: D
week: [1, 6]
parent: "[[Sequence (Mathematics)]]"
tags: [Math/Discrete, Math/Sequences]
---
# [[Recurrence Relation]]

**Context:** [[FIT1058_MOC]], [[FIT2004_MOC]] · defines a [[Sequence (Mathematics)|sequence]] from earlier terms · base case(s) + general case · turned into a closed form by [[Mathematical Induction]]
**FIT2004 use:** a recursive algorithm's running time obeys a recurrence ($T(N)=T(N/2)+c$, $T(n)=a\,T(n/b)+f(n)$) — solved for a Big-O class by **telescoping** in [[Solving Recurrences (Telescoping)]].

> [!abstract] Quick Revision
> - **🎯 Objective:** each term as an expression in previous terms ➔ base case(s) + general case.
> - **📦 Core Components:** base case + general rule ➔ must determine every term uniquely.
> - **⚡ Key Constraint:** a $k$-step rule needs $k$ base cases; closed form via explore–formulate–prove.

## 📝 Core
### 1. The Definition
- **Recurrence** ➔ each term from **previous** terms; **base case** ➔ finitely many initial terms given explicitly; **general case** ➔ a rule for a generic term.

### 2. Base Case Is Essential
- **Rule alone defines nothing** ➔ $f_n=f_{n-1}+2$ gives odds from $f_1=1$, evens from $f_1=0$ — same rule, different sequence.
- **Depth = base count** ➔ a $k$-step rule needs $k$ base cases; $f_n=4f_{n-2}$ with only $f_1$ fixes just the odd positions.

### 3. Recurrence → Closed Form
- **Explore ➔ formulate ➔ prove** ➔ compute first terms, guess the pattern, prove by [[Mathematical Induction]].

> [!NOTE] **When It Flips:** the recurrence is easiest to *write*; the closed form reveals **growth** and gives any term directly. When no closed form exists ([[Fibonacci Sequence|Fibonacci]] at first), bounds can still be proved by induction. The programming analogue is [[Recursion]].

## 📊 Exam Execution Trace

### Manual Execution Trace
$f_1=1,\ f_n=2f_{n-1}+1$:

| Step / State | $n$ | $f_{n-1}$ | $f_n=2f_{n-1}+1$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | 1 | — | 1 |
| 1 | 2 | 1 | 3 |
| 2 | 3 | 3 | 7 |
| 3 | 4 | 7 | 15 |

## 🧠 Active Recall
> [!FAQ]- Describe explore–formulate–prove and apply it to $f_1=1,\ f_n=2f_{n-1}+1$.
> - **Hint:** Guess then induct.
> > [!SUCCESS]- Answer
> > - **Short answer:** explore $1,3,7,15$; formulate $2^n-1$; prove by induction (basis + step).
> > - **Why:** **Closed form** ➔ converts a backward-looking rule into a formula valid for all $n$, which is what exposes the growth class.

> [!FAQ]- Why does $f_n=4f_{n-2}$ need two base cases?
> - **Hint:** Depth = base count.
> > [!SUCCESS]- Answer
> > - **Short answer:** the rule reaches two terms back, so $f_1$ alone determines only odd-indexed terms; $f_2$ is needed for the even ones.
> > - **Why:** **$k$-step ⟹ $k$ bases** ➔ fewer leaves whole residue classes of the index undefined.
