---
unit: FIT1058
week: 10
parent: "[[Binomial Distribution]]"
tags: [Math/Probability, Math/Discrete, Monash/CS_DS]
---
# [[Geometric Distribution]]

**Context:** [[FIT1058_MOC]] · the number of [[Binomial Distribution|trials]] until the first success · pmf $(1-p)^{k-1}p$ · **memoryless** · drives the [[Coupon Collector's Problem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** trials until the first success ➔ $\mathrm{Pr}(X=k)=(1-p)^{k-1}p$.
> - **📦 Core Components:** $E=1/p$ ➔ $\mathrm{Var}=(1-p)/p^2$ ➔ **memoryless**.
> - **⚡ Key Constraint:** memorylessness refutes the "law of averages"; the unique $\mathbb N$-valued such distribution.

## 📝 Core
### 1. The Distribution
- **Definition** ➔ $X\sim\mathrm{Geom}(p)$ = trials up to and including the first success.
- **pmf** ➔ $\mathrm{Pr}(X=k)=(1-p)^{k-1}p$, $k\in\mathbb N$.
- **Moments** ➔ $E(X)=1/p$, $\mathrm{Var}(X)=(1-p)/p^2$.

### 2. Memorylessness
- **Property** ➔ given $X\ge t$, $X-t$ is again $\mathrm{Geom}(p)$ — the wait restarts.
- **Unique** ➔ only $\mathbb N$-valued memoryless distribution.
- **Refutes** ➔ the gambler's "law of averages".

**Key identities:**

$$\mathrm{Pr}(X=k)=(1-p)^{k-1}p,\qquad \sum_{k\ge1}(1-p)^{k-1}p=\frac{p}{1-(1-p)}=1$$

## ⚖️ Core Decision Matrix
| Aspect | Geometric | vs Binomial |
| :--- | :--- | :--- |
| counts | trials to first success | successes in fixed $n$ |
| support | unbounded $\mathbb N$ | $\{0,\dots,n\}$ |
| $E$ | $1/p$ | $np$ |
| memoryless | yes | no |

> [!NOTE] **When It Flips:** smaller $p$ ⟹ longer wait ($E=1/p$). Models loop iterations to a stopping condition, time-to-failure; a sum of geometric waits gives the [[Coupon Collector's Problem]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Fair coin to first Heads, $\mathrm{Geom}(\tfrac12)$:

| Step / State | $k$ | $(1-p)^{k-1}$ | $\mathrm{Pr}(X=k)$ |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | 1 | 1 | $\tfrac12$ |
| 2 | 2 | $\tfrac12$ | $\tfrac14$ |
| 3 | 3 | $\tfrac14$ | $\tfrac18$ |

## ⚠️ Common Mistakes
- 💡 **Law of averages is a fallacy** ➔ a run of failures does not make success "due"; each trial keeps probability $p$ (memorylessness formalises this).

## 🧠 Active Recall
> [!FAQ]- Derive the geometric pmf and show it sums to 1.
> - **Hint:** $k-1$ failures then success.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(X=k)=(1-p)^{k-1}p$; sums to $\tfrac{p}{1-(1-p)}=1$.
> > - **Why:** **Geometric series** ➔ first term $p$, ratio $1-p$; $E=1/p$, $\mathrm{Var}=(1-p)/p^2$.

> [!FAQ]- What is the memoryless property, and why does it refute the "law of averages"?
> - **Hint:** Wait restarts.
> > [!SUCCESS]- Answer
> > - **Short answer:** Given $X\ge t$, $X-t\sim\mathrm{Geom}(p)$ — past failures don't change the future.
> > - **Why:** **Independence** ➔ each trial keeps $p$; success is never "overdue".
