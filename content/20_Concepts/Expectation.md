---
unit: FIT1058
week: 10
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Expectation]]

**Context:** [[FIT1058_MOC]] · the probability-weighted average of a [[Random Variable]] · linear over sums (even dependent ones) · a measure of location alongside [[Median and Mode]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $E(X)=\sum_k k\,\mathrm{Pr}(X=k)$ ➔ probability-weighted average.
> - **📦 Core Components:** weighted sum ➔ linearity ➔ product needs independence.
> - **⚡ Key Constraint:** $E(X+Y)=E(X)+E(Y)$ **always**; $E(XY)=E(X)E(Y)$ **only** if independent.

## 📝 Core
### 1. The Mean
- **Definition** ➔ $E(X)=\sum_k k\,\mathrm{Pr}(X=k)$ — average weighted by probability.
- **Generalises** ➔ ordinary average (equal weights $\tfrac1n$) to any distribution.

### 2. Key Properties
- **Constant/scaling** ➔ $E(c)=c$, $E(\alpha X)=\alpha E(X)$.
- **Linearity** ➔ $E(X+Y)=E(X)+E(Y)$ for **any** variables (no independence).
- **Product** ➔ $E(XY)=E(X)E(Y)$ only if [[Independent Events|independent]].

### 3. Limitations
- **Can be untypical** ➔ $E$ may sit far from every value (skew/outliers).
- **Use median then** ➔ [[Median and Mode|median]] better represents "typical".

**Key identities:**

$$E(X)=\sum_k k\,\mathrm{Pr}(X=k),\qquad E(X+Y)=E(X)+E(Y)\ (\text{any }X,Y)$$
$$E(XY)=E(X)E(Y)\ (\text{independent only})$$

> [!NOTE] **When It Flips:** linearity splits a complex variable into simple summands — a [[Binomial Distribution|binomial]] $Z=\sum X_i$ of [[Binomial Distribution|Bernoullis]] gives $E(Z)=np$ instantly. $E$ can lie far from every value (skewed data), where the median is more representative.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Find $E(X)$ for a fair die, then $E(Z)$ for the two-dice total by linearity.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
E(X) &= \sum_{k=1}^6 k\cdot\tfrac16 = 3.5 \\
E(Z) &= E(X)+E(Y) = 3.5+3.5 = 7\ (\text{no independence needed})
\end{aligned}
$$
**Final Extracted Output:** $E(X)=3.5$, $E(Z)=7$ without touching $Z$'s triangular distribution.

## ⚠️ Common Mistakes
- 💡 **Linearity needs no independence** ➔ $E(X+Y)=E(X)+E(Y)$ holds even for dependent variables; only the *product* rule requires independence.

## 🧠 Active Recall
> [!FAQ]- Define $E(X)$ and state linearity — does it need independence?
> - **Hint:** Additive always.
> > [!SUCCESS]- Answer
> > - **Short answer:** $E(X)=\sum_k k\,\mathrm{Pr}(X=k)$; $E(X+Y)=E(X)+E(Y)$ for any variables.
> > - **Why:** **Product differs** ➔ $E(XY)=E(X)E(Y)$ needs independence.

> [!FAQ]- When is expectation a poor "typical" value, and what is better?
> - **Hint:** Skew/outliers.
> > [!SUCCESS]- Answer
> > - **Short answer:** With outliers $E$ can lie far from every value ($1,2,3,4,90$ → $E=20$).
> > - **Why:** **Median robust** ➔ barely moves with extremes (but has no linearity).
