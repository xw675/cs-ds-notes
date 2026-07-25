---
unit: FIT1058
week: 10
parent: "[[Expectation]]"
tags: [Math/Probability, Math/Discrete, Monash/CS_DS]
---
# [[Variance and Standard Deviation]]

**Context:** [[FIT1058_MOC]] · measures of **spread** of a [[Random Variable]] around its mean · variance $=E((X-\mu)^2)$ · bounded deviation via Chebyshev

> [!abstract] Quick Revision
> - **🎯 Objective:** spread of $X$ around $\mu$ ➔ $\mathrm{Var}(X)=E((X-\mu)^2)=E(X^2)-E(X)^2$.
> - **📦 Core Components:** variance ➔ $\sigma=\sqrt{\mathrm{Var}}$ (same units) ➔ Chebyshev bound.
> - **⚡ Key Constraint:** variance adds only for **independent** variables; Chebyshev is universal but loose.

## 📝 Core
### 1. The Measures
- **Variance** ➔ $\mathrm{Var}(X)=E((X-\mu)^2)=E(X^2)-E(X)^2$ (average squared deviation).
- **Standard deviation** ➔ $\sigma=\sqrt{\mathrm{Var}(X)}$ — same units as $X$.

### 2. Computing & Combining
- **Two forms** ➔ $\sum_k(k-\mu)^2\mathrm{Pr}(X=k)$ or $E(X^2)-\mu^2$ (often easier).
- **Additive if independent** ➔ $\mathrm{Var}(X+Y)=\mathrm{Var}(X)+\mathrm{Var}(Y)$ (unlike expectation, needs independence).

### 3. Chebyshev's Inequality
- **Universal bound** ➔ $\mathrm{Pr}(|X-\mu|\ge t\sigma)\le\tfrac1{t^2}$ for any $X$, any $t>0$.
- **No shape needed** ➔ holds for every distribution.

**Key identities:**

$$\mathrm{Var}(X)=E((X-\mu)^2)=E(X^2)-\mu^2,\qquad \sigma=\sqrt{\mathrm{Var}(X)}$$
$$\mathrm{Pr}(|X-\mu|\ge t\sigma)\le\frac1{t^2}$$

## ⚖️ Core Decision Matrix
| Quantity | Units | Note |
| :--- | :--- | :--- |
| variance | squared $X$-units | second moment |
| $\sigma$ | $X$-units | interpretable scale |
| $\mathrm{Var}(X+Y)$ | — | additive if independent |
| Chebyshev | — | general, loose |

> [!NOTE] **When It Flips:** squaring weights far-out values heavily, so variance is sensitive to extremes. Chebyshev holds for *every* distribution (the fallback when shape is unknown); well-behaved distributions admit tighter bounds. Binomial variance $np(1-p)$ follows by additivity over independent trials.

## 📊 Exam Execution Trace

### Manual Execution Trace
Fair die ($\mu=3.5$):

| Step / State | $k$ | $(k-3.5)^2$ | weighted |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | 1,6 | 6.25 each | $\tfrac{12.5}{6}$ |
| 2 | 2,5 | 2.25 each | $\tfrac{4.5}{6}$ |
| 3 | 3,4 | 0.25 each | $\tfrac{0.5}{6}$ |

## ⚠️ Common Mistakes
- 💡 **Variance additivity needs independence** ➔ $\mathrm{Var}(X+Y)=\mathrm{Var}(X)+\mathrm{Var}(Y)$ only for independent $X,Y$; expectation adds unconditionally.

## 🧠 Active Recall
> [!FAQ]- Give the two variance formulas, why $\sigma$ is needed, and the independence caveat.
> - **Hint:** Second moment + units.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Var}(X)=E((X-\mu)^2)=E(X^2)-\mu^2$; $\sigma=\sqrt{\mathrm{Var}}$ restores $X$-units.
> > - **Why:** **Additivity** ➔ $\mathrm{Var}(X+Y)=\mathrm{Var}(X)+\mathrm{Var}(Y)$ only if independent.

> [!FAQ]- State Chebyshev's Inequality and its virtue and limitation.
> - **Hint:** Universal but loose.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(|X-\mu|\ge t\sigma)\le\tfrac1{t^2}$ for any distribution.
> > - **Why:** **Fallback** ➔ holds regardless of shape; specific distributions give tighter bounds.
