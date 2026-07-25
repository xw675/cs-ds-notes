---
unit: FIT1058
domain: D
week: 1
parent: "[[Set (Mathematics)]]"
tags: [Math/SetTheory, Math/Combinatorics, Math/Discrete]
---
# [[Power Set]]

**Context:** [[FIT1058_MOC]] · the [[Set (Mathematics)|set]] of all [[Subset and Superset|subsets]] of a set · size $2^n$ · refined by size via the [[Binomial Coefficient]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\mathcal P(B)$ = all subsets of $B$ ➔ including $\emptyset$ and $B$.
> - **📦 Core Components:** $\lvert\mathcal P(B)\rvert=2^{\lvert B\rvert}$ ➔ binary-choice argument ➔ $\sum_k\binom{n}{k}=2^n$.
> - **⚡ Key Constraint:** exponential blow-up — $\lvert B\rvert=20$ gives over a million subsets.

## 📝 Core
### 1. The Power Set (All Subsets)
- **Definition** ➔ $\mathcal P(B)=\{A:A\subseteq B\}$ — its elements are themselves sets.
- **Cardinality** ➔ $\lvert\mathcal P(B)\rvert=2^{\lvert B\rvert}$ (exponential).
- **Edge case** ➔ $\mathcal P(\emptyset)=\{\emptyset\}$, size $2^0=1$.

### 2. Why $2^n$ (Binary Choice)
- **Per element** ➔ include or exclude, $2$ independent options.
- **Product rule** ➔ $\underbrace{2\times\cdots\times 2}_{n}=2^n$ subsets.

### 3. Maximum vs Maximal
- **Maximum** ➔ largest *size* of any qualifying subset (global).
- **Maximal** ➔ cannot be enlarged while keeping the property (local).
- **Relation** ➔ maximum ⟹ maximal, not conversely (dually minimum/minimal).

**Key identities:**

$$\lvert\mathcal P(B)\rvert=2^n,\qquad \sum_{k=0}^{n}\binom{n}{k}=2^n$$
$$\mathcal P(\{a,b\})=\{\emptyset,\{a\},\{b\},\{a,b\}\}$$

## ⚖️ Core Decision Matrix
| Notion | Meaning | Example |
| :--- | :--- | :--- |
| maximum | largest size anywhere | maximum clique |
| maximal | can't be extended | maximal clique |
| minimum | smallest size | — |
| minimal | can't be shrunk | — |

> [!NOTE] **When It Flips:** subsets split by size — $\binom{n}{k}$ per layer, summing to $2^n$ ([[Binomial Coefficient]]). Contrast the [[Cartesian Product]]: its size $\lvert A\rvert\lvert B\rvert$ multiplies, whereas the power set's $2^{\lvert B\rvert}$ is exponential.

## 📊 Exam Execution Trace

### Manual Execution Trace
$\mathcal P(\{a,b,c\})$ by size:

| Step / State | Size $k$ | Subsets | $\binom{3}{k}$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | 0 | $\emptyset$ | 1 |
| 2 | 1 | $\{a\},\{b\},\{c\}$ | 3 |
| 3 | 2 | $\{a,b\},\{a,c\},\{b,c\}$ | 3 |
| 4 | 3 | $\{a,b,c\}$ | 1 |

## ⚠️ Common Mistakes
- 💡 **Elements of $\mathcal P(B)$ are sets** ➔ $\emptyset$ and $B$ are members; and enumerating $\mathcal P(B)$ is infeasible for large $B$ (over $10^6$ subsets at $\lvert B\rvert=20$).

## 🧠 Active Recall
> [!FAQ]- Prove that a set with $n$ elements has exactly $2^n$ subsets.
> - **Hint:** Independent binary choice.
> > [!SUCCESS]- Answer
> > - **Short answer:** Each element is independently "in" or "out" ⟹ $2^n$ subsets by the product rule.
> > - **Why:** **Edge check** ➔ $\emptyset$ gives $2^0=1$, $\mathcal P(\emptyset)=\{\emptyset\}$.

> [!FAQ]- Distinguish a *maximal* subset from a *maximum* subset (clique example).
> - **Hint:** Local vs global.
> > [!SUCCESS]- Answer
> > - **Short answer:** Maximal = can't be enlarged; maximum = largest anywhere.
> > - **Why:** **Maximum ⟹ maximal** ➔ a maximal clique may be far smaller than the maximum clique.

> [!FAQ]- How do the binomial coefficients relate to the power-set size?
> - **Hint:** Layer by size.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\binom{n}{k}$ subsets of each size $k$; disjoint layers cover $\mathcal P(B)$.
> > - **Why:** **Sum** ➔ $\sum_{k=0}^{n}\binom{n}{k}=2^n$.
