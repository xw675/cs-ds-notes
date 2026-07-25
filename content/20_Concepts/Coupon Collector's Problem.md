---
unit: FIT1058
week: 10
parent: "[[Geometric Distribution]]"
tags: [Math/Probability, Math/Discrete, Monash/CS_DS]
---
# [[Coupon Collector's Problem]]

**Context:** [[FIT1058_MOC]] · expected trials to see **all** $n$ equally likely outcomes · a sum of [[Geometric Distribution|geometric]] waits · answer $nH_n$ via [[Expectation|linearity]]

> [!abstract] Quick Revision
> - **🎯 Objective:** trials until all $n$ outcomes seen ➔ $E(Z)=nH_n$.
> - **📦 Core Components:** stagewise [[Geometric Distribution|geometric]] waits ➔ summed by [[Expectation|linearity]].
> - **⚡ Key Constraint:** $H_n\approx\ln n$ so $E(Z)\approx n\ln n$; the last coupons dominate.

## 📝 Core
### 1. The Problem
- **Setup** ➔ each trial yields one of $n$ equally likely outcomes ($\tfrac1n$, with replacement).
- **$Z$** ➔ trials until **every** outcome has appeared.
- **Answer** ➔ $E(Z)=nH_n$, $H_n=1+\tfrac12+\dots+\tfrac1n$.

### 2. Decompose into Stages
- **Stage $k$** ➔ after $k-1$ distinct, new with probability $1-\tfrac{k-1}n$.
- **Geometric wait** ➔ $X_k\sim\mathrm{Geom}(1-\tfrac{k-1}n)$, $E(X_k)=\tfrac{n}{n-k+1}$.

### 3. Sum by Linearity
- **$Z=\sum X_k$** ➔ $E(Z)=\sum_k\tfrac{n}{n-k+1}=n\sum_j\tfrac1j=nH_n$.
- **Growth** ➔ $H_n\approx\ln n$ ⟹ $E(Z)\approx n\ln n$.

**Key identities:**

$$X_k\sim\mathrm{Geom}\!\left(1-\tfrac{k-1}n\right),\ E(X_k)=\tfrac{n}{n-k+1}$$
$$E(Z)=\sum_{k=1}^n\tfrac{n}{n-k+1}=n\sum_{j=1}^n\tfrac1j=nH_n$$

> [!NOTE] **When It Flips:** another showcase of [[Expectation|linearity]] — a hard distribution's mean via a chain of independent geometric stages. Applications: black-box output coverage, RNG testing, ecology species counts.

## 📊 Exam Execution Trace

### Manual Execution Trace
$n=4$ coupons:

| Step / State | Stage $k$ | success prob | $E(X_k)$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | 1 | 1 | 1 |
| 1 | 2 | $\tfrac34$ | $\tfrac43$ |
| 2 | 3 | $\tfrac24$ | 2 |
| 3 | 4 | $\tfrac14$ | 4 |

## ⚠️ Common Mistakes
- 💡 **The last coupon dominates** ➔ $X_n$ has success probability $\tfrac1n$, so $E(X_n)=n$ alone — most of the wait chases the final few.

## 🧠 Active Recall
> [!FAQ]- Derive $E(Z)=nH_n$ for the coupon collector's problem.
> - **Hint:** Stagewise geometric.
> > [!SUCCESS]- Answer
> > - **Short answer:** $X_k\sim\mathrm{Geom}(1-\tfrac{k-1}n)$, $E(X_k)=\tfrac{n}{n-k+1}$; summing gives $nH_n$.
> > - **Why:** **Linearity** ➔ $E(\sum X_k)=n\sum1/j$.

> [!FAQ]- Roughly how many trials, and which stage dominates?
> - **Hint:** $n\ln n$; last coupon.
> > [!SUCCESS]- Answer
> > - **Short answer:** $E(Z)\approx n\ln n$ (since $H_n\approx\ln n$); the last coupon averages $E(X_n)=n$.
> > - **Why:** **Rare last** ➔ success probability $\tfrac1n$ per trial for the final unseen outcome.
