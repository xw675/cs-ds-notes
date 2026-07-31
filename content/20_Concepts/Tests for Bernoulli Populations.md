---
unit: FIT2086
week: 5
source: [lecture]
domain: D
parent: "[[Hypothesis Testing]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [proportion test, test for a proportion, two-proportion test, Bernoulli test, pooled proportion, binom.test, prop.test, failure rate test]
---
# [[Tests for Bernoulli Populations]]

**Context:** [[FIT2086_MOC]] · [[Hypothesis Testing]] applied to **binary** data — rates, proportions, failure rates · no exact normal sampling distribution exists, so the test is built on [[Central Limit Theorem|the CLT]] · the discrete counterpart of [[Tests for Normal Means (z-test and t-test)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\hat\theta=m/n$ ➔ standardise by the **null's** standard error $\sqrt{\theta_0(1-\theta_0)/n}$ ➔ read the $N(0,1)$ tail ➔ approximate $p$-value.
> - **📦 Core Components:** one population ➔ $\mathrm{se}$ built from $\theta_0$ | two populations ➔ $\mathrm{se}$ built from the **pooled** $\hat\theta_p$.
> - **⚡ Key Constraint:** every $p$-value here is **approximate** and requires a **large sample** — the normal is standing in for a discrete [[Binomial Distribution|binomial]].

## 📝 Core
- **Why it matters** ➔ the natural home of "has the rate changed?" and "is the advertised failure rate met?" — e.g. a supplier guarantees a component failure rate below $\theta_0$ and a customer tests it from a sample.
- **The estimate is a mean** ➔ $\hat\theta=\frac1n\sum_i y_i=\frac{m}{n}$ with $m$ the number of successes ➔ being an average, it inherits asymptotic normality from the CLT.
- **Single-population statistic** ➔ $z_{\hat\theta}=\dfrac{\hat\theta-\theta_0}{\sqrt{\theta_0(1-\theta_0)/n}}\;\dot\sim\;N(0,1)$ under $H_0:\theta=\theta_0$.
- **The null supplies the variance** ➔ a Bernoulli's variance $\theta(1-\theta)$ is a **function of its mean**, so imposing $H_0$ fixes the standard error at $\theta_0$ — no separate variance to estimate, unlike the normal-mean case.
- **Two populations pool under the null** ➔ $H_0:\theta_x=\theta_y$ asserts one common $\theta$, so both samples estimate it: $\hat\theta_p=\dfrac{m_x+m_y}{n_x+n_y}$.
- **Two-population statistic** ➔ $z_{(\hat\theta_x-\hat\theta_y)}=\dfrac{\hat\theta_x-\hat\theta_y}{\sqrt{\hat\theta_p(1-\hat\theta_p)\left(1/n_x+1/n_y\right)}}\;\dot\sim\;N(0,1)$.
- **$p$-values** ➔ same three-way rule as everywhere: two-sided $2P(Z<-\lvert z\rvert)$ · upper $1-P(Z<z)$ · lower $P(Z<z)$ ➔ [[Hypothesis Testing]].
- **Exact alternatives exist** ➔ methods using binomial properties directly; in R `binom.test()` for one sample and `prop.test()` for two ➔ [[R Toolkit (Cheatsheet)]].

## 🧮 Proof Blueprint
**Theorem.** For $Y_1,\dots,Y_n\sim Be(\theta)$ testing $H_0:\theta=\theta_0$, the statistic $z_{\hat\theta}=\dfrac{\hat\theta-\theta_0}{\sqrt{\theta_0(1-\theta_0)/n}}$ is approximately $N(0,1)$ under $H_0$.
**Strategy:** recognise $\hat\theta$ as a sample mean, apply the CLT under the null, then standardise by the null-implied standard error.
$$
\begin{aligned}
\hat\theta &= \frac1n\sum_{i=1}^n Y_i = \frac{m}{n} && \text{(ML estimate = sample mean)}\\
E[Y_i]=\theta_0,\quad V[Y_i] &= \theta_0(1-\theta_0) && \text{(Bernoulli moments under } H_0)\\
\hat\theta-\theta_0 &\xrightarrow{d} N\!\left(0,\frac{\theta_0(1-\theta_0)}{n}\right) && \text{(CLT for an average)}\\
z_{\hat\theta}=\frac{\hat\theta-\theta_0}{\sqrt{\theta_0(1-\theta_0)/n}} &\xrightarrow{d} N(0,1) && \text{(divide by the null standard error)}
\end{aligned}
$$
**Q.E.D.** ➔ convergence is asymptotic, so the resulting $p$-value is **approximate**; the discrete exact test is the reference when $n$ is small or $\theta_0$ near $0$ or $1$.

## 📊 Worked Example — France vs Spain
**Problem:** $n=60$ people surveyed, $m=37$ prefer France. Is there a real preference ($\theta\neq\tfrac12$) or is this chance?
$$
\begin{aligned}
\hat\theta &= \frac{37}{60} \approx 0.6167,\qquad H_0:\theta=\tfrac12 \ \text{ vs } \ H_A:\theta\neq\tfrac12\\
\mathrm{se} &= \sqrt{\frac{(1/2)(1-1/2)}{60}} = \sqrt{\frac{0.25}{60}} = 0.06455\\
z_{\hat\theta} &= \frac{0.6167-0.5}{0.06455} \approx 1.807\\
p &= 2P(Z<-1.807) \approx 0.0707
\end{aligned}
$$
**Final extracted output:** approximate $p=0.0707$ vs **exact** $p=0.0924$ from `binom.test(x=37, n=60, p=0.5)` — both grade as **weak evidence** against a $50/50$ split, but the normal approximation is optimistic by $\approx30\%$ of the $p$-value, which matters when a result sits near a threshold.

## 📊 Worked Example — "Guess the Coin" *(Studio 5)*
**Problem:** a friend tosses a coin $n_x=12$ times giving $m_x=4$ heads. **(a)** Is the coin fair? **(b)** After a distraction, a second sequence of $n_y=12$ gives $m_y=10$ heads — did she swap the coin?
$$
\begin{aligned}
\text{(a)}\quad \hat\theta_x &= \tfrac{4}{12}=\tfrac13, \qquad H_0:\theta=\tfrac12\\
z_{\hat\theta} &= \frac{1/3-1/2}{\sqrt{(1/2)(1/2)/12}} = -1.155 \quad\Rightarrow\quad p = 2P(Z<-1.155) = 0.248\\
\text{(b)}\quad \hat\theta_y &= \tfrac{10}{12}=\tfrac56, \qquad \hat\theta_p=\frac{4+10}{12+12}=\frac{14}{24}=0.5833\\
z_{(\hat\theta_x-\hat\theta_y)} &= \frac{1/3-5/6}{\sqrt{0.5833(1-0.5833)\left(\tfrac1{12}+\tfrac1{12}\right)}} = -2.484 \quad\Rightarrow\quad p = 0.0130
\end{aligned}
$$
**Final extracted output:** **(a)** $p=0.248$ — if the coin were fair, almost $25\%$ of $12$-toss sequences would be at least this lopsided ($\le4$ **or** $\ge8$ heads); **no evidence** against fairness. Exact: `binom.test(4,12,1/2)` $=0.3877$. **(b)** $p=0.0130$ — a difference this large would arise by chance in about $1$ in $77$ repetitions if the coin were unchanged; **moderate–strong** evidence that the coin was swapped. Exact: `prop.test(c(4,10),c(12,12))` $=0.0384$, about $1$ in $26$ — weaker, because the approximation **overstates** the evidence at $n=12$.

### Sensitivity sweep — how much bias before you suspect?
| Heads in $n=12$ | Exact $p$ (`binom.test`) | Evidence grade |
| :--- | :--- | :--- |
| $4$ *(observed)* | $0.3877$ | none |
| $3$ | $0.1460$ | none |
| $2$ | $0.0386$ | **moderate** — this is where suspicion starts |
| $1$ | $0.0063$ | **strong** |

**Reading it:** by symmetry the same grades apply to $10$, $11$ heads. At $n=12$ the discreteness is coarse — a single extra head moves $p$ by a factor of $\approx4$ — which is exactly why the normal approximation cannot be trusted here.

## ⚠️ Common Mistakes
- 💡 **Using $\hat\theta$ in the single-sample standard error** ➔ the denominator is built from the **null** $\theta_0$, because the whole calculation is conducted *assuming $H_0$ true*; substituting $\hat\theta$ is the confidence-interval move, not the testing move.
- 💡 **Using separate $\hat\theta_x,\hat\theta_y$ in the two-sample standard error** ➔ under $H_0$ there is only **one** population proportion, so it is estimated once by pooling all $m_x+m_y$ successes over all $n_x+n_y$ trials.
- 💡 **Trusting the approximation at small $n$ or extreme $\theta_0$** ➔ the CLT justification is asymptotic; use `binom.test`/`prop.test` and report that the normal $p$ is approximate.
- 💡 **Pooling by averaging the two proportions** ➔ $\hat\theta_p\neq\frac{\hat\theta_x+\hat\theta_y}{2}$ unless $n_x=n_y$; pool the **counts**, not the rates.

## 🧠 Active Recall
> [!FAQ]- Why does the single-population test divide by $\sqrt{\theta_0(1-\theta_0)/n}$ rather than $\sqrt{\hat\theta(1-\hat\theta)/n}$, when the normal-mean test happily substitutes $\hat\sigma$?
> > [!SUCCESS]- Answer
> > - **Short answer:** for a Bernoulli the variance is **determined by the mean**, so once $H_0$ fixes $\theta=\theta_0$ it also fixes the variance — there is nothing left to estimate. For a normal, $\mu$ and $\sigma^2$ are **separate** parameters, so $H_0:\mu=\mu_0$ says nothing about $\sigma^2$ and it must be estimated.
> > - **Why:** **A test statistic is computed under the null** ➔ using $\hat\theta$ would mix sample information into a quantity the null has already pinned down, giving the wrong reference distribution.

> [!FAQ]- The approximate test gives $p=0.0707$ and the exact `binom.test` gives $p=0.0924$. Which do you report, and does the conclusion change?
> > [!SUCCESS]- Answer
> > - **Short answer:** report the **exact** $0.0924$ when available; both exceed $0.05$ and grade as **weak evidence**, so the substantive conclusion — no demonstrated preference for France — is unchanged.
> > - **Why:** **The normal is a continuous stand-in for a discrete law** ➔ the approximation error is systematic, not random, and at $n=60$ it moves $p$ by enough that a result landing at $p\approx0.05$ could flip a naive significance verdict. This is exactly why the unit prefers grading evidence to thresholding it.
