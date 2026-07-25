---
unit: FIT1058
week: 1
parent: "[[Power Set]]"
tags: [Math/Combinatorics, Math/Discrete]
---
# [[Binomial Coefficient]]

**Context:** [[FIT1058_MOC]] · counts the size-$k$ [[Subset and Superset|subsets]] of an $n$-set · the size-layers of the [[Power Set]] · obeys Pascal's identity

> [!abstract] Quick Revision
> - **🎯 Objective:** $\binom{n}{k}$ = number of $k$-subsets of an $n$-set ➔ "n choose k".
> - **📦 Core Components:** closed form $\frac{n!}{(n-k)!k!}$ ➔ symmetry ➔ Pascal's identity.
> - **⚡ Key Constraint:** $\sum_k\binom{n}{k}=2^n$ (size-layers of the [[Power Set]]).

## 📝 Core
### 1. The Coefficient
- **Definition** ➔ $\binom{n}{k}$ = number of $k$-element [[Subset and Superset|subsets]] of an $n$-set.
- **Sum** ➔ $\sum_{k=0}^n\binom{n}{k}=2^n$ ([[Power Set]]).

### 2. Closed Form
- **Ordered first** ➔ $n(n-1)\cdots(n-k+1)=\frac{n!}{(n-k)!}$.
- **Correct for order** ➔ each subset counted $k!$ times ⟹ $\binom{n}{k}=\frac{n!}{(n-k)!k!}$.

### 3. Identities
- **Symmetry** ➔ $\binom{n}{k}=\binom{n}{n-k}$ (include vs exclude).
- **Pascal** ➔ $\binom{n}{k}=\binom{n-1}{k-1}+\binom{n-1}{k}$ (contains vs omits a fixed element).

**Key identities:**

$$\binom{n}{k}=\frac{n(n-1)\cdots(n-k+1)}{k!}=\frac{n!}{(n-k)!\,k!}$$
$$\binom{n}{k}=\binom{n}{n-k},\qquad \binom{n}{k}=\binom{n-1}{k-1}+\binom{n-1}{k}$$

## ⚖️ Core Decision Matrix
| Case | Value | Reason |
| :--- | :--- | :--- |
| $\binom{n}{0}$ | 1 | empty subset |
| $\binom{n}{n}$ | 1 | whole set |
| $\binom{n}{1}$ | $n$ | single elements |
| $\binom{n}{n-1}$ | $n$ | leave one out |

> [!NOTE] **When It Flips:** two computation routes — closed form (direct) or Pascal's identity (recursive, no large factorials, good for many coefficients). Outside $0\le k\le n$, $\binom{n}{k}=0$.

## 📊 Exam Execution Trace

### Manual Execution Trace
Pascal's triangle rows:

| Step / State | $n$ | Row |
| :--- | :--- | :--- |
| **0 (Init)** | 0 | 1 |
| 1 | 1 | 1 1 |
| 2 | 2 | 1 2 1 |
| 3 | 3 | 1 3 3 1 |

## ⚠️ Common Mistakes
- 💡 **Divide by $k!$** ➔ ordered selection $\frac{n!}{(n-k)!}$ counts each subset $k!$ times; forgetting the division confuses permutations with combinations.

## 🧠 Active Recall
> [!FAQ]- Derive $\binom{n}{k}=\frac{n!}{(n-k)!\,k!}$ from first principles.
> - **Hint:** Order then correct.
> > [!SUCCESS]- Answer
> > - **Short answer:** Ordered $k$-selections number $\frac{n!}{(n-k)!}$; each subset arises from $k!$ orderings, so divide by $k!$.
> > - **Why:** **Overcount** ➔ combinations = permutations ÷ $k!$.

> [!FAQ]- State and justify Pascal's identity combinatorially.
> - **Hint:** Contains vs omits an element.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\binom{n}{k}=\binom{n-1}{k-1}+\binom{n-1}{k}$: subsets with $b$ ($\binom{n-1}{k-1}$) + subsets without $b$ ($\binom{n-1}{k}$).
> > - **Why:** **Disjoint + exhaustive** ➔ the two cases add; the rule builds Pascal's triangle.

> [!FAQ]- Why does $\binom{n}{k}=\binom{n}{n-k}$, and what are $\binom{n}{0}$ and $\binom{n}{n}$?
> - **Hint:** Include ⟺ exclude.
> > [!SUCCESS]- Answer
> > - **Short answer:** Choosing $k$ to include = choosing $n-k$ to exclude; $\binom{n}{0}=\binom{n}{n}=1$.
> > - **Why:** **Bijection** ➔ one way to choose nothing/everything.
