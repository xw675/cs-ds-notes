---
unit: FIT1058
domain: D
week: 10
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete]
---
# [[Poisson Distribution]]

**Context:** [[FIT1058_MOC]] · counts independent events in an interval · pmf $e^{-\mu}\mu^k/k!$ · large-$n$ small-$np$ approximation to the [[Binomial Distribution|binomial]]

> [!abstract] Quick Revision
> - **🎯 Objective:** count of rare independent events in an interval ➔ $\mathrm{Pr}(X=k)=e^{-\mu}\mu^k/k!$.
> - **📦 Core Components:** one parameter $\mu$ ➔ $E=\mathrm{Var}=\mu$ ➔ unbounded support.
> - **⚡ Key Constraint:** approximates $\mathrm{Bin}(n,p)$ for large $n$, small $np$ ($\mu=np$).

## 📝 Core
### 1. The Distribution
- **Definition** ➔ $\mathrm{Pr}(X=k)=\frac{e^{-\mu}\mu^k}{k!}$, $k\in\mathbb N_0$, $\mu>0$.
- **One parameter** ➔ $E(X)=\mu$, $\mathrm{Var}(X)=\mu$, $\sigma=\sqrt\mu$.

### 2. When It Arises
- **Count of independent occurrences** ➔ calls, visits, coins, radioactive emissions.
- **Interval-scaled** ➔ $\mu$ scales with interval length.
- **Unbounded** ➔ any nonnegative integer (unlike the binomial's cap).

### 3. Binomial Approximation
- **Condition** ➔ large $n$, small $np$ ⟹ $\mathrm{Bin}(n,p)\approx\mathrm{Poisson}(np)$.
- **Benefit** ➔ trades a two-parameter formula for one.

**Key identities:**

$$\sum_{k=0}^{\infty}\frac{e^{-\mu}\mu^k}{k!}=e^{-\mu}\sum_{k=0}^{\infty}\frac{\mu^k}{k!}=e^{-\mu}e^{\mu}=1$$

## ⚖️ Core Decision Matrix
| Aspect | Poisson | vs Binomial |
| :--- | :--- | :--- |
| parameter | $\mu$ | $n,p$ |
| $E$, $\mathrm{Var}$ | both $\mu$ | $np$, $np(1-p)$ |
| support | unbounded | $\{0,\dots,n\}$ |
| relation | $\approx\mathrm{Bin}$ large $n$ | $\mu=np$ |

> [!NOTE] **When It Flips:** Poisson suits "could be any count" of rare independent events; it is the unbounded limit of the binomial. The $e^x$-series normalisation mirrors the geometric-series argument for other pmfs.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Poisson $\mu=2$ — find $\mathrm{Pr}(X=0)$, $\mathrm{Pr}(X=1)$, $E$, $\mathrm{Var}$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\mathrm{Pr}(X=0) &= e^{-2}\approx0.135,\qquad \mathrm{Pr}(X=1) = 2e^{-2}\approx0.271 \\
E(X) &= \mu = 2,\qquad \mathrm{Var}(X) = \mu = 2
\end{aligned}
$$
**Final Extracted Output:** $\approx0.135$, $\approx0.271$; mean and variance both 2.

## ⚠️ Common Mistakes
- 💡 **$\mu$ is mean AND variance** ➔ the single parameter does double duty; the binomial→Poisson swap needs large $n$ with small $np$.

## 🧠 Active Recall
> [!FAQ]- State the Poisson pmf, show it sums to 1, and give mean and variance.
> - **Hint:** $e^x$ series.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(X=k)=e^{-\mu}\mu^k/k!$; $\sum=e^{-\mu}e^{\mu}=1$; $E=\mathrm{Var}=\mu$.
> > - **Why:** **Power series** ➔ $\sum_k\mu^k/k!=e^{\mu}$.

> [!FAQ]- When does the Poisson distribution arise, and how does it relate to the binomial?
> - **Hint:** Rare independent counts.
> > [!SUCCESS]- Answer
> > - **Short answer:** Counts of independent occurrences in a fixed interval; $\mathrm{Bin}(n,p)\approx\mathrm{Poisson}(np)$ for large $n$, small $np$.
> > - **Why:** **Unbounded limit** ➔ one parameter replaces two.
