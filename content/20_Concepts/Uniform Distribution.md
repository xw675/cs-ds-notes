---
unit: FIT1058
week: 10
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete, Monash/CS_DS]
---
# [[Uniform Distribution]]

**Context:** [[FIT1058_MOC]] · equal probability to every integer in $[a,b]$ · models fairness or pure ignorance · the simplest named distribution

> [!abstract] Quick Revision
> - **🎯 Objective:** every integer in $[a,b]$ equally likely ➔ $\mathrm{Pr}(X=x)=\frac1{b-a+1}$.
> - **📦 Core Components:** $E=\frac{a+b}2$ ➔ $\mathrm{Var}=\frac{(b-a+1)^2-1}{12}$.
> - **⚡ Key Constraint:** models genuine fairness **or** pure ignorance (maximally uninformative).

## 📝 Core
### 1. The Distribution
- **Definition** ➔ $X\sim\mathrm{Unif}(a,b)$: $\mathrm{Pr}(X=x)=\tfrac1{b-a+1}$ for $a\le x\le b$, else 0.
- **Count** ➔ $b-a+1$ integers in $[a,b]$.

### 2. Moments
- **Mean** ➔ $E(X)=\frac{a+b}2$ (midpoint, by symmetry).
- **Variance** ➔ $\mathrm{Var}(X)=\frac{(b-a+1)^2-1}{12}$.
- **Check** ➔ $\mathrm{Unif}(1,6)$ = fair die: $E=3.5$, $\mathrm{Var}=\tfrac{35}{12}$.

### 3. Two Motivations
- **Fairness** ➔ die, coin (genuine symmetry).
- **Ignorance** ➔ only the range known ⟹ assume nothing more.

**Key identities:**

$$\mathrm{Pr}(X=x)=\tfrac1{b-a+1}\ (a\le x\le b),\quad E=\tfrac{a+b}2,\quad \mathrm{Var}=\tfrac{(b-a+1)^2-1}{12}$$

## ⚖️ Core Decision Matrix
| Case | $E$ | $\mathrm{Var}$ |
| :--- | :--- | :--- |
| $\mathrm{Unif}(0,1)$ | 0.5 | $\tfrac{3}{12}=\tfrac14$ |
| $\mathrm{Unif}(1,6)$ | 3.5 | $\tfrac{35}{12}$ |
| general | $\frac{a+b}2$ | $\frac{(b-a+1)^2-1}{12}$ |

> [!NOTE] **When It Flips:** uniform over a sample space = [[Probability|Equally Likely Outcomes]]; $\mathrm{Unif}(0,1)$ is a fair [[Binomial Distribution|Bernoulli Trial]]. It is the natural prior when the distribution's shape is entirely unknown.

## 📊 Exam Execution Trace

### Manual Execution Trace
$\mathrm{Unif}(1,6)$:

| Step / State | Quantity | Value |
| :--- | :--- | :--- |
| **0 (Init)** | $b-a+1$ | 6 |
| 1 | $\mathrm{Pr}(X=4)$ | $\tfrac16$ |
| 2 | $E$ | 3.5 |
| 3 | $\mathrm{Var}$ | $\tfrac{35}{12}$ |

## ⚠️ Common Mistakes
- 💡 **Count is $b-a+1$, not $b-a$** ➔ inclusive endpoints; the uniform is the maximally non-committal choice given only the range.

## 🧠 Active Recall
> [!FAQ]- Give the pmf, mean, and variance of $\mathrm{Unif}(a,b)$ and verify on a fair die.
> - **Hint:** Inclusive count.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\tfrac1{b-a+1}$; $E=\tfrac{a+b}2$; $\mathrm{Var}=\tfrac{(b-a+1)^2-1}{12}$; die → $3.5,\tfrac{35}{12}$.
> > - **Why:** **Symmetry** ➔ mean at the midpoint.

> [!FAQ]- What two situations call for a uniform distribution?
> - **Hint:** Fairness or ignorance.
> > [!SUCCESS]- Answer
> > - **Short answer:** Known symmetry (die/coin), or modelling ignorance (only the range known).
> > - **Why:** **Non-committal** ➔ assumes nothing beyond $[a,b]$.
