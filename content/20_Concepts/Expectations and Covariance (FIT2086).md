---
unit: FIT2086
domain: D
week: 2
source:
  - lecture
parent: "[[Random Variables and Probability Distributions (FIT2086)]]"
tags:
  - Math/Probability
  - DataScience/Theory
aliases:
  - expected value
  - E[f(X)]
  - linearity of expectation
  - covariance
  - correlation
  - weak law of large numbers
  - WLLN
  - existence of expectations
---
# [[Expectations and Covariance (FIT2086)]]

**Context:** [[FIT2086_MOC]] · summarises a distribution by **numbers** ➔ deepens FIT1058's [[Expectation]] / [[Variance and Standard Deviation]] with $E[f(X)]$, **population** covariance/correlation (cf. the sample version in [[Association Between Variables]]), the **WLLN** linking $\bar x$ to $\mu$, and the fact that expectations **need not exist**

> [!abstract] Quick Revision
> - **🎯 Objective:** $E[X]=\sum_{x\in\mathcal{X}}x\,p(x)$ (integral if continuous) ➔ a probability-weighted average; every summary (variance, covariance, moments) is an expectation of some $f$.
> - **📦 Core Components:** $E[f(X)]=\sum f(x)p(x)$ ➔ $V[X]=E[X^2]-E[X]^2$ ➔ $\operatorname{cov}(X,Y)=E[XY]-E[X]E[Y]$ ➔ $\operatorname{corr}\in[-1,1]$.
> - **⚡ Key Constraint:** **linearity is unconditional, factorisation is not** — $E[f(X)+g(Y)]$ always splits, $E[f(X)g(Y)]$ (hence $V[X+Y]=V[X]+V[Y]$) needs independence. Second killer: $\operatorname{corr}=0$ does **not** imply independence.

## 📝 How It Works

### 1. Expected value
- **Discrete / continuous** ➔ $E[X]=\sum_{x\in\mathcal{X}}x\,p(x)$ and $E[X]=\int x\,p(x)\,dx$ — the average over $\mathcal{X}$ **weighted by** $p(x)$.
- **Function of an RV** ➔ $E[f(X)]=\sum_{x\in\mathcal{X}}f(x)\,p(x)$: reweight $f(x)$, do **not** transform the probabilities.
- **Linearity (Fact 1)** ➔ $E[c\,f(X)+d]=c\,E[f(X)]+d$ for constants $c,d$ not depending on $X$ ➔ constants slide out, additive shifts pass straight through.

### 2. Variance and standard deviation
- **Definition** ➔ $V[X]=E\!\left[(X-E[X])^2\right]=\sum_{x\in\mathcal{X}}(x-E[X])^2p(x)$ — the **expected squared deviation** around the mean; larger $V$ ⟹ mass spread more thinly across the axis.
- **Computational form** ➔ expand and use linearity:
$$V[X]=E\!\left[X^2-2XE[X]+E[X]^2\right]=E[X^2]-2E[X]^2+E[X]^2=E[X^2]-E[X]^2$$
- **Standard deviation** ➔ $\sqrt{V[X]}$ — restores the units of $X$.
- **Scaling under a linear map** ➔ $V[cX+d]=c^2V[X]$ (the shift $d$ moves the mean, never the spread).

### 3. Covariance and correlation
- **Covariance** ➔ $\operatorname{cov}(X,Y)=E[(X-E[X])(Y-E[Y])]=E[XY]-E[X]E[Y]$ — the two-variable analogue of variance ($\operatorname{cov}(X,X)=V[X]$).
- **Correlation** ➔ $\operatorname{corr}(X,Y)=\dfrac{\operatorname{cov}(X,Y)}{\sqrt{V[X]\,V[Y]}}$ — the scale-free normalisation.
- **Sign reading** ➔ positive ⟹ $x>E[X]$ makes $y>E[Y]$ likely; negative ⟹ $x>E[X]$ makes $y<E[Y]$ likely.
- **Ranges** ➔ $\operatorname{cov}\in(-\infty,\infty)$ and **depends on the units** of $X,Y$; $\operatorname{corr}\in[-1,1]$ and is **independent of scale** ➔ only correlation is comparable across variables.
- **One-way implication** ➔ $X\perp Y\Rightarrow\operatorname{cov}=\operatorname{corr}=0$; the **converse is false** — correlation measures *linear* association only.

### 4. Two random variables
- **Joint expectation** ➔ $E[f(X,Y)]=\sum_{x\in\mathcal{X}}\sum_{y\in\mathcal{Y}}f(x,y)\,p(x,y)$.
- **Fact 1 — sums always split** ➔ $E[f(X)+g(Y)]=E[f(X)]+E[g(Y)]$ for **all** RVs, dependent or not.
- **Fact 2 — products split only under independence** ➔ $E[f(X)g(Y)]=E[f(X)]\,E[g(Y)]$, whence
$$V[X+Y]=V[X]+V[Y] \qquad (X\perp Y)$$

### 5. Weak Law of Large Numbers
- **Statement** ➔ for $X_1,\dots,X_n$ with $E[X_i]=\mu$ and any $\varepsilon>0$:
$$P\!\left(\left|\frac{X_1+\cdots+X_n}{n}-\mu\right|>\varepsilon\right)\to 0 \quad\text{as } n\to\infty$$
- **Reading** ➔ the **sample mean** $\bar x=\frac1n\sum x_i$ (a statistic — see [[Measures of Centrality]]) converges to the **theoretical mean** $E[X]$ as the sample grows ➔ this is the licence to estimate $\mu$ by $\bar x$ at all, and the engine behind every Monte Carlo estimate in [[R Simulation and Random Sampling]].
- **Convergence RATE is set by the variance** *(Studio 2 simulation)* ➔ $V[\bar X_n]=\sigma^2/n$, so **less variable data converges sooner**: Bernoulli running means for $\theta=0.9$ ($\sigma^2=0.09$) settle onto their line visibly faster and tighter than $\theta=0.5$ ($\sigma^2=0.25$, the **maximum-variance** Bernoulli). The WLLN promises *that* it converges; $\sigma^2/n$ says *how fast* — and is exactly the estimator variance of [[Estimator Quality (Bias, Variance, MSE)]].

### 6. Existence of expected values
- **Finite $\mathcal{X}$** ➔ $E[X]$ always exists.
- **Infinite $\mathcal{X}$ ($\mathbb{Z}$ or $\mathbb{R}$)** ➔ existence is **not guaranteed**; heavy tails make the defining sum/integral diverge.
- **Counterexample** ➔ $p(x)=\dfrac{2}{\pi(1+x^2)}$ (Cauchy shape) gives $\displaystyle E[X]=\int_{-\infty}^{\infty}\frac{2x}{\pi(1+x^2)}\,dx=\infty$ — positive and negative parts each diverge, so the integral never converges.
- **Quantiles always exist** ➔ when the mean fails, the **median** $Q(0.5)$ still summarises location.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — $E$, $V$ and $E[f(X)]$ from a pmf
$P(X{=}1)=0.5$, $P(X{=}2)=0.4$, $P(X{=}3)=0.1$:

| Step | Quantity | Computation | Result |
| :--- | :--- | :--- | :--- |
| 1 | $E[X]$ | $1(0.5)+2(0.4)+3(0.1)$ | $1.6$ |
| 2 | $V[X]$ (definition) | $(1-1.6)^2(0.5)+(2-1.6)^2(0.4)+(3-1.6)^2(0.1)$ | $0.44$ |
| 3 | $E[X^2]$ | $1(0.5)+4(0.4)+9(0.1)$ | $3.0$ |
| 4 | $V[X]$ (short form) | $3.0-1.6^2$ | $0.44$ ✓ |
| 5 | $E[\log X]$ | $\log 1(0.5)+\log 2(0.4)+\log 3(0.1)$ | $0.3871$ |

**Key move:** step 4 confirms $E[X^2]-E[X]^2$ agrees with the definition — always the faster route once $E[X^2]$ is available.

### Applied Exercise — linear transformation (°C ➔ °F)
**Problem:** $C$ has $E[C]=31$, $V[C]=5$. Find the mean and variance in Fahrenheit, $F=1.8C+32$.
$$
\begin{aligned}
E[F] &= E[1.8C+32] = 1.8\,E[C]+32 = 1.8(31)+32 = 87.8\ \text{°F}\\
V[F] &= V[1.8C+32] = 1.8^2\,V[C] = 3.24(5) = 16.2
\end{aligned}
$$
**Final Extracted Output:** $E[F]=87.8$, $V[F]=16.2$ — the $+32$ shifts the mean and is **invisible** to the variance.

## ⚠️ Common Mistakes
- 💡 **$E[f(X)]\ne f(E[X])$ unless $f$ is linear** ➔ $E[\log X]=0.3871$ above while $\log E[X]=\log 1.6=0.470$. Non-linear $f$ needs the [[Taylor Approximation of Expectations|Taylor approximation]].
- 💡 **Zero correlation ≠ independence** ➔ $Y=X^2+\text{noise}$ gives $\operatorname{corr}(X,Y)=0$ despite obvious association; a *deterministic* circular relation also gives $0$. Correlation sees only the **linear** component.
- 💡 **Variance additivity needs independence** ➔ $V[X+Y]=V[X]+V[Y]$ follows from Fact 2, not from linearity; without independence a $2\operatorname{cov}(X,Y)$ term survives.
- 💡 **Don't assume $E[X]$ exists** ➔ on infinite $\mathcal{X}$ check convergence before quoting a mean; heavy-tailed models genuinely have none.

## 🧠 Active Recall
> [!FAQ]- Which expectation identities hold unconditionally, and which require independence?
> > [!SUCCESS]- Answer
> > - **Short answer:** **sums always, products only under independence** — $E[c f(X)+d]=cE[f(X)]+d$ and $E[f(X)+g(Y)]=E[f(X)]+E[g(Y)]$ hold for all RVs; $E[f(X)g(Y)]=E[f(X)]E[g(Y)]$ and its corollary $V[X+Y]=V[X]+V[Y]$ require $X\perp Y$.
> > - **Why:** **Linearity is a property of the sum/integral** ➔ $\sum_x\sum_y(f(x)+g(y))p(x,y)$ marginalises each term separately regardless of $p(x,y)$'s structure; the product $\sum_x\sum_y f(x)g(y)p(x,y)$ only factors into $\left(\sum_x f(x)p(x)\right)\left(\sum_y g(y)p(y)\right)$ when $p(x,y)=p(x)p(y)$.

> [!FAQ]- Why does $\operatorname{corr}(X,Y)=0$ fail to establish independence, and what does correlation actually measure?
> > [!SUCCESS]- Answer
> > - **Short answer:** correlation measures **linear** association only; a perfectly deterministic but non-monotone relation such as $Y=X^2$ has $\operatorname{corr}(X,Y)=0$ while $X$ and $Y$ are fully dependent.
> > - **Why:** **$\operatorname{cov}=E[XY]-E[X]E[Y]$ is a single scalar** ➔ for a symmetric $X$ about $0$, positive and negative products cancel exactly, driving the covariance to $0$ although $p(x,y)\ne p(x)p(y)$. The implication runs one way: independence ⟹ zero correlation, never the reverse.

> [!FAQ]- What does the weak law of large numbers assert, and why can an expectation fail to exist?
> > [!SUCCESS]- Answer
> > - **Short answer:** WLLN ➔ $P(|\bar X_n-\mu|>\varepsilon)\to0$ as $n\to\infty$ for any $\varepsilon>0$: the sample mean converges to $E[X]$. Existence fails when $\mathcal{X}$ is infinite and the tails are heavy enough that $\sum x\,p(x)$ or $\int x\,p(x)dx$ diverges.
> > - **Why:** **Finite $\mathcal{X}$ ⟹ a finite sum ⟹ $E[X]$ exists** ➔ over $\mathbb{Z}$ or $\mathbb{R}$ convergence must be checked, e.g. $p(x)=\frac{2}{\pi(1+x^2)}$ decays only as $x^{-2}$, so $x\,p(x)\sim x^{-1}$ and the integral diverges. Quantiles are defined by the cdf and therefore always exist — the median is the safe fallback summary.
