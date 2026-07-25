---
unit: FIT1058
week: 9
parent: "[[Probability]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Mutually Exclusive Events]]

**Context:** [[FIT1058_MOC]] · disjoint events · probability is **additive** over disjoint unions · the probabilistic [[Counting Principles|Addition Principle]]

> [!abstract] Quick Revision
> - **🎯 Objective:** disjoint events ($A\cap B=\emptyset$) ⟹ probability adds ➔ $\mathrm{Pr}(A\sqcup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)$.
> - **📦 Core Components:** pairwise disjoint ➔ additive ➔ decomposition tactic.
> - **⚡ Key Constraint:** add **only** when disjoint; mutually exclusive ≠ independent.

## 📝 Core
### 1. The Definition
- **Disjoint** ➔ $A\cap B=\emptyset$; one occurring prevents the other.
- **Additive** ➔ $\mathrm{Pr}(A\sqcup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)$ (union defined only when disjoint).

### 2. Additivity over $n$ Events
- **Pairwise disjoint** ➔ $\mathrm{Pr}(\bigsqcup_i A_i)=\sum_i\mathrm{Pr}(A_i)$.
- **Foundational** ➔ $\mathrm{Pr}(A)=\sum_{x\in A}\mathrm{Pr}(x)$ is this rule on singletons.

### 3. Tactics & Contrasts
- **Decompose** ➔ split into disjoint simpler events, add.
- **Only if disjoint** ➔ overlap needs $-\mathrm{Pr}(A\cap B)$.
- **≠ independent** ➔ disjoint positive-probability events are dependent.

**Key identities:**

$$A\cap B=\emptyset \Rightarrow \mathrm{Pr}(A\sqcup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)$$
$$\mathrm{Pr}(A_1\sqcup\cdots\sqcup A_n)=\sum_i\mathrm{Pr}(A_i)$$

## ⚖️ Core Decision Matrix
| Relation | Joint | Rule |
| :--- | :--- | :--- |
| mutually exclusive | $\mathrm{Pr}(A\cap B)=0$ | add |
| overlapping | $>0$ | inclusion–exclusion |
| independent | $\mathrm{Pr}(A)\mathrm{Pr}(B)$ | multiply |
| disjoint + positive | dependent | — |

> [!NOTE] **When It Flips:** this is the [[Counting Principles|Addition Principle]] for measures — disjoint "or" adds, mirroring $|A\sqcup B|=|A|+|B|$. "Separate on a Venn diagram" ≠ independent; disjoint positive-probability events are in fact dependent.

## 📊 Exam Execution Trace

### Manual Execution Trace
Two dice, total $\le5$ or $\ge10$:

| Step / State | Event | $\mathrm{Pr}$ | Disjoint? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | total $\le5$ | $\tfrac{10}{36}$ | yes |
| 2 | total $\ge10$ | $\tfrac{6}{36}$ | yes |
| 3 | union | $\tfrac{16}{36}=\tfrac49$ | — |

## ⚠️ Common Mistakes
- 💡 **Add only when disjoint** ➔ $\mathrm{Pr}(A\cup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)$ iff $A\cap B=\emptyset$; else subtract $\mathrm{Pr}(A\cap B)$.

## 🧠 Active Recall
> [!FAQ]- When is $\mathrm{Pr}(A\cup B)=\mathrm{Pr}(A)+\mathrm{Pr}(B)$, and how does it define probability itself?
> - **Hint:** Disjoint additivity.
> > [!SUCCESS]- Answer
> > - **Short answer:** Exactly when $A\cap B=\emptyset$; generalises to pairwise-disjoint families.
> > - **Why:** **Singletons** ➔ $\mathrm{Pr}(A)=\sum_{x\in A}\mathrm{Pr}(x)$ is additivity over disjoint $\{x\}$.

> [!FAQ]- Why are two mutually exclusive events (both positive) necessarily not independent?
> - **Hint:** Zero vs product.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(A\cap B)=0$ but independence needs $\mathrm{Pr}(A)\mathrm{Pr}(B)>0$.
> > - **Why:** **Prevention** ➔ $A$ occurring rules out $B$ — the opposite of no influence.
