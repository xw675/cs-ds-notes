---
unit: FIT1058
week: 9
parent: "[[Probability]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Independent Events]]

**Context:** [[FIT1058_MOC]] · the occurrence of one does not affect the other · defined by $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\mathrm{Pr}(B)$ · multiplicative, the dual of [[Mutually Exclusive Events|disjoint additivity]]

> [!abstract] Quick Revision
> - **🎯 Objective:** both occur ⟹ product ➔ $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\mathrm{Pr}(B)$.
> - **📦 Core Components:** numerical test ➔ multiplicative over intersections ➔ series/parallel reliability.
> - **⚡ Key Constraint:** independent ≠ mutually exclusive (disjoint positive-probability events are dependent).

## 📝 Core
### 1. The Definition
- **Test** ➔ $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\cdot\mathrm{Pr}(B)$ — purely numerical.
- **Not mechanism** ➔ decided by the numbers, not intuition.
- **Multiplicative** ➔ probability factors over independent intersections (dual of disjoint additivity).

### 2. Test, Don't Guess
- **Looks linked, is independent** ➔ possible when the product equation happens to hold.
- **Looks independent, isn't** ➔ always verify $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\mathrm{Pr}(B)$.

### 3. vs Mutually Exclusive
- **Disjoint** ➔ $\mathrm{Pr}(A\cap B)=0\neq\mathrm{Pr}(A)\mathrm{Pr}(B)$ for positive-probability events ⟹ **dependent**.
- **Exclusivity** ➔ one *prevents* the other, the opposite of independence.

**Key identities:**

$$\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\mathrm{Pr}(B)$$
$$\text{series: } p\cdot p=p^2;\qquad \text{parallel: } 1-(1-p)^2=2p-p^2$$

## ⚖️ Core Decision Matrix
| Structure | Survival | Method |
| :--- | :--- | :--- |
| series (AND) | $p^2$ | multiply |
| parallel (OR) | $2p-p^2$ | complement $1-(1-p)^2$ |
| independent | $\mathrm{Pr}(A)\mathrm{Pr}(B)$ | product |
| mutually exclusive | dependent | — |

> [!NOTE] **When It Flips:** probability is multiplicative over independent intersections (as it is additive over disjoint unions) — the tool for decomposing a complex event into independent pieces; the complement route is quickest for "at least one".

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Two independent parallel links (each survives w.p. $p$) — survival probability, two ways.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{union} &: p+p-p\cdot p = 2p-p^2 \\
\text{complement} &: 1-(1-p)^2 = 2p-p^2
\end{aligned}
$$
**Final Extracted Output:** $2p-p^2$; the complement route is quicker.

## ⚠️ Common Mistakes
- 💡 **Independent ≠ mutually exclusive** ➔ disjoint positive-probability events are *dependent* ($0\neq\mathrm{Pr}(A)\mathrm{Pr}(B)$); "separate on a Venn diagram" is not independence.

## 🧠 Active Recall
> [!FAQ]- Define independence and why mutually exclusive events (positive probability) are never independent.
> - **Hint:** Product vs zero.
> > [!SUCCESS]- Answer
> > - **Short answer:** Independent ⟺ $\mathrm{Pr}(A\cap B)=\mathrm{Pr}(A)\mathrm{Pr}(B)$; disjoint gives $\mathrm{Pr}(A\cap B)=0$.
> > - **Why:** **$>0\neq0$** ➔ exclusivity means $A$ prevents $B$ — strongest dependence.

> [!FAQ]- For two independent links each surviving w.p. $p$, give series and parallel survival.
> - **Hint:** AND multiplies, OR via complement.
> > [!SUCCESS]- Answer
> > - **Short answer:** Series $p^2$; parallel $1-(1-p)^2=2p-p^2$.
> > - **Why:** **Complement simplest** ➔ "at least one" = $1-$"both fail".
