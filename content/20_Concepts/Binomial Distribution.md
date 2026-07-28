---
unit: [FIT1058, FIT2086]
domain: D
week: [2, 10]
source: [lecture]
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete]
aliases: [Bernoulli Trial, Bernoulli Distribution, Bin(theta n), Be(theta), dbinom]
---
# [[Binomial Distribution]]

**Context:** [[FIT1058_MOC]], [[FIT2086_MOC]] · Bernoulli trial (one success/failure experiment) + binomial (successes across $n$ i.i.d. trials) · pmf uses the [[Binomial Coefficient]] · mean/variance via [[Expectation|linearity]] of indicator sums · the two-outcome member of the [[Parametric Probability Distributions|parametric zoo]]

> [!abstract] Quick Revision
> - **🎯 Objective:** Bernoulli atom: $X\in\{0,1\}$, $\mathrm{Pr}(X=1)=p$ ➔ sum $n$ i.i.d. atoms ⟹ $\mathrm{Pr}(Z=k)=\binom{n}{k}p^k(1-p)^{n-k}$.
> - **📦 Core Components:** $E(X)=p$, $\mathrm{Var}(X)=p(1-p)$ ➔ $E(Z)=np$ (linearity) ➔ $\mathrm{Var}(Z)=np(1-p)$ (independence).
> - **⚡ Key Constraint:** indicator-sum trick beats brute-force pmf algebra; linearity needs no independence, variance does.

## 📝 Core

### 1. The Bernoulli Atom (Single Trial)
- **Definition** ➔ $X=1$ with probability $p$ (success), $X=0$ with $1-p$ — any two-outcome experiment (coin, pass/fail, on/off).
- **Compact pmf form** ➔ $p(x\mid\theta)=\theta^{x}(1-\theta)^{1-x}$ on $x\in\{0,1\}$, written $X\sim Be(\theta)$ in FIT2086's $\theta\in[0,1]$ notation ➔ the exponents act as **selectors**, collapsing to $\theta$ at $x=1$ and $1-\theta$ at $x=0$.
- **Moments** ➔ $E(X)=p$; $\mathrm{Var}(X)=E(X^2)-E(X)^2=p-p^2=p(1-p)$ (since $X^2=X$); variance max at $p=\tfrac12$ (value $0.25$), zero at $p\in\{0,1\}$.
- **Sequences** ➔ i.i.d. = same $p$, independent trials; the atom of binomial (count successes) and [[Geometric Distribution|geometric]] (wait for first).

### 2. The Binomial Distribution
- **Definition** ➔ $Z\sim\mathrm{Bin}(n,p)$ (FIT2086 writes $M\sim Bin(\theta,n)$) = the number of successes $m(\mathbf{x})=\sum_{j=1}^{n}x_j$ across $n$ i.i.d. Bernoulli trials; the count $M$ is itself an RV over $\{0,1,\dots,n\}$.
- **pmf derivation** ➔ one specific $k$-success sequence has probability $\prod_{i=1}^{n}p(x_i\mid\theta)=p^k(1-p)^{n-k}$; $\binom{n}{k}$ placements ([[Binomial Coefficient]]) ⟹ $\mathrm{Pr}(Z=k)=\binom{n}{k}p^k(1-p)^{n-k}$.
- **Why the coefficient is needed** ➔ for $1\le k\le n-1$ **several** sequences carry $k$ successes; $k=2,n=4$ admits the six orderings $1100,1010,1001,0110,0101,0011$ ⟹ $p(m{=}2\mid\theta)=\binom42\theta^2(1-\theta)^2$.
- **Additivity in $n$** *(FIT2086)* ➔ $M_1\sim Bin(\theta,n_1)$ and $M_2\sim Bin(\theta,n_2)$ with the **same** $\theta$ ⟹ $M_1+M_2\sim Bin(\theta,n_1+n_2)$ — immediate from the definition as a sum of Bernoulli variates, so pooling batches simply adds trial counts.

### 3. Moments via Indicator Sums
- **Decompose** ➔ $Z=\sum_{i=1}^n X_i$ with Bernoulli $X_i$.
- **$E(Z)=np$** ➔ sum of means ([[Expectation|linearity]] — no independence needed).
- **$\mathrm{Var}(Z)=np(1-p)$** ➔ variances add only under [[Independent Events|independence]]; $\sigma=\sqrt{np(1-p)}$.
- **Approximation** ➔ large $n$, small $np$ ⟹ [[Poisson Distribution|Poisson]]($np$).
- **Shape** ➔ mass skewed toward $np$; $\theta$ and $1-\theta$ produce mirror-image distributions.

## 📊 Exam Execution Trace & Applied Exercises

### 1. Manual Execution Trace Layout
$Z\sim\mathrm{Bin}(4,\tfrac12)$:

| Step / State | Quantity | Value |
| :--- | :--- | :--- |
| 1 | $\mathrm{Pr}(Z=2)=\binom42(\tfrac12)^4$ | $6\cdot\tfrac1{16}=\tfrac38$ |
| 2 | $E(Z)=np$ | $2$ |
| 3 | $\mathrm{Var}(Z)=np(1-p)$ | $1$ ($\sigma=1$) |

### 2. Applied Exercise — telephone sales *(FIT2086)*
**Problem:** each call yields a sale with probability $0.08$, independently; the salesman makes $12$ calls, so $M\sim Bin(0.08,12)$. Find (i) $E[M]$; (ii) $P(M\le2)$; (iii) $P(M\ge2)$.
$$
\begin{aligned}
\text{(i)}\quad E[M] &= n\theta = 12(0.08) = 0.96\\
\text{(ii)}\quad P(M\le2) &= \sum_{m=0}^{2}\binom{12}{m}(0.08)^{m}(0.92)^{12-m}\\
&= \underbrace{(0.92)^{12}}_{0.3677}+\underbrace{12(0.08)(0.92)^{11}}_{0.3837}+\underbrace{66(0.08)^2(0.92)^{10}}_{0.1835}\;=\;0.9348\\
\text{(iii)}\quad P(M\ge2) &= 1-P(M\le1) = 1-(0.3677+0.3837) = 0.2487
\end{aligned}
$$**Final Extracted Output:** $0.96$ expected sales; $P(M\le2)\approx0.935$; $P(M\ge2)\approx0.249$. **Key move:** "**2 or more**" is the complement of $M\le1$, **not** of $M\le2$ — the boundary value $m=2$ sits inside *both* one-sided events, so $P(M\le2)+P(M\ge2)>1$.

> [!NOTE] **When It Flips:** the indicator sum is the showcase of linearity — instant $E=np$. Binomial fixes $n$ and counts successes; the [[Geometric Distribution|geometric]] fixes the first success and varies the trial count.

## ⚙️ In R
> [!code]- The `binom` suffix (details ➔ [[R Simulation and Random Sampling]])
> ```r
> dbinom(2, size = 12, prob = 0.08)        # P(M = 2)   = 0.1835
> pbinom(2, size = 12, prob = 0.08)        # P(M <= 2)  = 0.9348
> pbinom(1, 12, 0.08, lower.tail = FALSE)  # P(M >= 2)  = 0.2487
> qbinom(0.95, size = 12, prob = 0.08)     # quantile
> rbinom(10, size = 12, prob = 0.08)       # 10 random counts
> rbinom(10, size = 1,  prob = 0.08)       # BERNOULLI draws: size = 1
> ```
> 💡 **Common Mistake:** **Bernoulli has no separate R family** ➔ generate it as a binomial with `size = 1`. And `pbinom(q)` is $P(M\le q)$ **inclusive** — for $P(M\ge2)$ pass `q = 1` with `lower.tail = FALSE`.

## ⚠️ Common Mistakes
- 💡 **Linearity needs no independence, variance does** ➔ $E=np$ always holds; $\mathrm{Var}=np(1-p)$ requires independent trials.
- 💡 **Renaming success swaps $p\leftrightarrow1-p$** ➔ which outcome is "success" is a modelling choice; keep it fixed through the calculation.
- 💡 **Additivity requires a shared $\theta$** ➔ $M_1+M_2\sim Bin(\theta,n_1+n_2)$ holds only when both batches share the success probability; differing $\theta$ leaves no binomial at all.

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
> > - **Short answer:** $E(X^2)=E(X)=p$ ⟹ $\mathrm{Var}=p-p^2=p(1-p)$; maximised at $p=\tfrac12$ (value $0.25$).
> > - **Why:** **Maximum uncertainty** ➔ a fair trial is the least predictable; degenerate $p\in\{0,1\}$ gives zero variance.
