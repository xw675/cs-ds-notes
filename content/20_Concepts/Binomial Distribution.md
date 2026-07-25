---
unit: FIT1058
week: 10
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete]
aliases: [Bernoulli Trial, Bernoulli Distribution]
---
# [[Binomial Distribution]]

**Context:** [[FIT1058_MOC]] · Bernoulli trial (one success/failure experiment) + binomial (successes across $n$ i.i.d. trials) · pmf uses the [[Binomial Coefficient]] · mean/variance via [[Expectation|linearity]] of indicator sums

> [!abstract] Quick Revision
> - **🎯 Objective:** Bernoulli atom: $X\in\{0,1\}$, $\mathrm{Pr}(X=1)=p$ ➔ sum $n$ i.i.d. atoms ⟹ $\mathrm{Pr}(Z=k)=\binom{n}{k}p^k(1-p)^{n-k}$.
> - **📦 Core Components:** $E(X)=p$, $\mathrm{Var}(X)=p(1-p)$ ➔ $E(Z)=np$ (linearity) ➔ $\mathrm{Var}(Z)=np(1-p)$ (independence).
> - **⚡ Key Constraint:** indicator-sum trick beats brute-force pmf algebra; linearity needs no independence, variance does.

## 📝 Core

### 1. The Bernoulli Atom (Single Trial)
- **Definition** ➔ $X=1$ with probability $p$ (success), $X=0$ with $1-p$ — any two-outcome experiment (coin, pass/fail, on/off).
- **Moments** ➔ $E(X)=p$; $\mathrm{Var}(X)=E(X^2)-E(X)^2=p-p^2=p(1-p)$ (since $X^2=X$); variance max at $p=\tfrac12$, zero at $p\in\{0,1\}$.
- **Sequences** ➔ i.i.d. = same $p$, independent trials; the atom of binomial (count successes) and [[Geometric Distribution|geometric]] (wait for first).

### 2. The Binomial Distribution
- **Definition** ➔ $Z\sim\mathrm{Bin}(n,p)$ = number of successes in $n$ i.i.d. Bernoulli trials.
- **pmf derivation** ➔ one specific $k$-success sequence has $p^k(1-p)^{n-k}$; $\binom{n}{k}$ placements ([[Binomial Coefficient]]) ⟹ $\mathrm{Pr}(Z=k)=\binom{n}{k}p^k(1-p)^{n-k}$.

### 3. Moments via Indicator Sums
- **Decompose** ➔ $Z=\sum_{i=1}^n X_i$ with Bernoulli $X_i$.
- **$E(Z)=np$** ➔ sum of means ([[Expectation|linearity]] — no independence needed).
- **$\mathrm{Var}(Z)=np(1-p)$** ➔ variances add only under [[Independent Events|independence]]; $\sigma=\sqrt{np(1-p)}$.
- **Approximation** ➔ large $n$, small $np$ ⟹ [[Poisson Distribution|Poisson]]($np$).

## 📊 Exam Execution Trace & Applied Exercises

### 1. Manual Execution Trace Layout
$Z\sim\mathrm{Bin}(4,\tfrac12)$:

| Step / State | Quantity | Value |
| :--- | :--- | :--- |
| 1 | $\mathrm{Pr}(Z=2)=\binom42(\tfrac12)^4$ | $6\cdot\tfrac1{16}=\tfrac38$ |
| 2 | $E(Z)=np$ | $2$ |
| 3 | $\mathrm{Var}(Z)=np(1-p)$ | $1$ ($\sigma=1$) |

> [!NOTE] **When It Flips:** the indicator sum is the showcase of linearity — instant $E=np$. Binomial fixes $n$ and counts successes; the [[Geometric Distribution|geometric]] fixes the first success and varies the trial count.

## ⚠️ Common Mistakes
- 💡 **Linearity needs no independence, variance does** ➔ $E=np$ always holds; $\mathrm{Var}=np(1-p)$ requires independent trials.
- 💡 **Renaming success swaps $p\leftrightarrow1-p$** ➔ which outcome is "success" is a modelling choice; keep it fixed through the calculation.

## 🧠 Active Recall
> [!FAQ]- Derive the binomial pmf $\binom{n}{k}p^k(1-p)^{n-k}$.
> - **Hint:** One sequence × count.
> > [!SUCCESS]- Answer
> > - **Short answer:** A specific $k$-success sequence has $p^k(1-p)^{n-k}$; there are $\binom{n}{k}$ such sequences.
> > - **Why:** **Mutually exclusive** ➔ sequences are disjoint events; multiply within, add across placements.

> [!FAQ]- How do linearity and independence give $E=np$ and $\mathrm{Var}=np(1-p)$?
> - **Hint:** Indicator decomposition.
> > [!SUCCESS]- Answer
> > - **Short answer:** $Z=\sum X_i$; $E(Z)=\sum p=np$; $\mathrm{Var}(Z)=\sum p(1-p)=np(1-p)$.
> > - **Why:** **Independence for variance only** ➔ expectation is linear unconditionally; covariances must vanish for variances to add.

> [!FAQ]- Why is $\mathrm{Var}(X)=p(1-p)$ for a single Bernoulli trial, and where is it maximised?
> - **Hint:** Exploit $X^2=X$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $E(X^2)=E(X)=p$ ⟹ $\mathrm{Var}=p-p^2=p(1-p)$; maximised at $p=\tfrac12$.
> > - **Why:** **Maximum uncertainty** ➔ a fair trial is the least predictable; degenerate $p\in\{0,1\}$ gives zero variance.
