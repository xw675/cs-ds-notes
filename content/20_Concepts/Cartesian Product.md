---
unit: FIT1058
week: 1
parent: "[[Set (Mathematics)]]"
tags: [Math/SetTheory, Math/Combinatorics, Math/Discrete]
---
# [[Cartesian Product]]

**Context:** [[FIT1058_MOC]] · builds [[Set (Mathematics)|sets]] of ordered tuples · cardinality multiplies · underlies $A^k$ in [[Sets of Strings]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $A\times B$ = all ordered pairs, first from $A$, second from $B$ ➔ order matters.
> - **📦 Core Components:** ordered pair $(a,b)$ ➔ $\lvert A\times B\rvert=\lvert A\rvert\lvert B\rvert$ ➔ $n$-tuples.
> - **⚡ Key Constraint:** **not commutative** ($A\times B\neq B\times A$); multiplicative growth, not exponential.

## 📝 Core
### 1. The Product (Ordered Tuples)
- **Ordered pair** ➔ $(a,b)$, order matters ($(a,b)\neq(b,a)$ unless $a=b$).
- **Definition** ➔ $A\times B=\{(a,b):a\in A,b\in B\}$.
- **Contrast a set** ➔ tuples are ordered; set elements are not.

### 2. Cardinality Multiplies
- **Product rule** ➔ $\lvert A\times B\rvert=\lvert A\rvert\cdot\lvert B\rvert$ (independent choices).
- **$n$ factors** ➔ length-$n$ tuples, $\lvert A_1\times\cdots\times A_n\rvert=\prod_i\lvert A_i\rvert$.

### 3. Geometry & Strings
- **Spaces** ➔ $\mathbb R\times\mathbb R$ = plane, $\mathbb R^3$ = 3-D space.
- **Strings** ➔ length-$k$ string over $A$ = element of $A^k$, so $\lvert A^k\rvert=\lvert A\rvert^k$ ([[Sets of Strings]]).

**Key identities:**

$$\lvert A\times B\rvert=\lvert A\rvert\cdot\lvert B\rvert,\qquad \lvert A_1\times\cdots\times A_n\rvert=\prod_{i=1}^n\lvert A_i\rvert$$
$$A\times B\neq B\times A \text{ (in general)},\qquad \lvert A^k\rvert=\lvert A\rvert^k$$

## ⚖️ Core Decision Matrix
| Constructor | Size | Growth |
| :--- | :--- | :--- |
| $A\times B$ | $\lvert A\rvert\lvert B\rvert$ | multiplicative |
| $A^k$ | $\lvert A\rvert^k$ | polynomial in $\lvert A\rvert$ |
| [[Power Set]] $\mathcal P(A)$ | $2^{\lvert A\rvert}$ | exponential |

> [!NOTE] **When It Flips:** the two principal set constructors grow very differently — Cartesian product multiplies sizes, the power set exponentiates. Product is not commutative but its cardinality is order-independent.

## 📊 Exam Execution Trace

### Manual Execution Trace
$A=\{1,2\}$, $B=\{x,y\}$:

| Step / State | Quantity | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $A\times B$ | $\{(1,x),(1,y),(2,x),(2,y)\}$ |
| 2 | $\lvert A\times B\rvert$ | $2\cdot2=4$ |
| 3 | $B\times A$ | $\{(x,1),(x,2),(y,1),(y,2)\}\neq A\times B$ |

## ⚠️ Common Mistakes
- 💡 **Not commutative** ➔ $(a,b)$ and $(b,a)$ are different tuples; $A\times B$ and $B\times A$ have equal size but differ as sets.

## 🧠 Active Recall
> [!FAQ]- Why is $\lvert A\times B\rvert=\lvert A\rvert\cdot\lvert B\rvert$, and why are the elements *ordered* pairs?
> - **Hint:** Independent choice + role.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\lvert A\rvert$ choices for the first component, $\lvert B\rvert$ for the second ⟹ product; components have distinct roles.
> > - **Why:** **Ordered** ➔ $(a,b)\neq(b,a)$; a set would ignore that order.

> [!FAQ]- How does a length-$k$ string over $A$ relate to a Cartesian product, and its count?
> - **Hint:** String = tuple.
> > [!SUCCESS]- Answer
> > - **Short answer:** A length-$k$ string is a $k$-tuple in $A^k=A\times\cdots\times A$.
> > - **Why:** **Product rule** ➔ $\lvert A^k\rvert=\lvert A\rvert^k$.
