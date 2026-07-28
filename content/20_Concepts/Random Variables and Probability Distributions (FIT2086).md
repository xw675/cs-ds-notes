---
unit: FIT2086
domain:
  - D
  - E
week: 1
source:
  - lecture
parent: "[[Statistical Modelling and Inference]]"
tags:
  - Math/Probability
  - DataScience/Theory
aliases:
  - random variable FIT2086
  - pmf
  - probability mass function
  - pdf
  - probability density function
  - cdf
  - cumulative distribution function
  - joint distribution
  - marginal distribution
  - sum rule
  - conditional distribution
  - independence
  - quantile function
  - mode
  - event space
  - survival function
---
# [[Random Variables and Probability Distributions (FIT2086)]]

**Context:** [[FIT2086_MOC]] · the probability calculus the whole unit runs on · deepens FIT1058's [[Random Variable]] / [[Conditional Probability]] with **pmf/pdf/cdf/quantile**, **joint–marginal–conditional**, and **iid** — the objects every later week (MLE, CIs, testing, regression) manipulates

> [!abstract] Quick Revision
> - **🎯 Objective:** a **random variable** $X$ takes values from an event space $\mathcal{X}$ with probabilities summing/integrating to $1$ ➔ manipulate one, two or many RVs via the **sum rule** (marginalise) and **product rule** (condition).
> - **📦 Core Components:** **pmf** $p(x)$ (discrete) | **pdf** $f_X(x)$ (continuous) | **cdf** $F_X(x)=P(X\le x)$ | **quantile** $Q(p)=F_X^{-1}(p)$ | **mode** $=\arg\max_x p(x)$.
> - **⚡ Key Constraint:** a density is **not** a probability — $f_X(x)$ may exceed $1$, $P(X=x)=0$, and every continuous answer is an **integral** or a **cdf difference**. Second killer: conditioning divides by the **marginal**, not by the joint total.

## 📝 How It Works

### 1. Discrete random variables and the pmf
- **Random variable** ➔ takes a value from a set $\mathcal{X}$ (the **event space**) with specified probabilities; observing $x\in\mathcal{X}$ is the **event** $X=x$. Capital = the RV, lowercase = the **realisation**.
- **Probability mass function (Def. 6)** ➔ any $p:\mathcal{X}\subseteq\mathbb{Z}\to\mathbb{R}$ with
$$p(x)\ge 0\;\;\forall x\in\mathcal{X}, \qquad \sum_{x\in\mathcal{X}}p(x)=1.$$
- **Event probability** ➔ for $A\subset\mathcal{X}$: $\;P(X\in A)=\sum_{x\in A}p(x)$.
- **Subscript notation** ➔ $p_X$ / $f_X$ / $F_X$ name **which** RV the function belongs to; shorthand $P(X=x)\equiv p(x)$.
- **Union rule (inclusion–exclusion)** ➔ $P(X\in A_1\cup A_2)=P(X\in A_1)+P(X\in A_2)-P(X\in A_1\cap A_2)$, collapsing to plain **additivity** when $A_1\cap A_2=\emptyset$.

### 2. Two (and many) random variables
- **Joint distribution** ➔ over $\mathcal{X}\times\mathcal{Y}$: $p(x,y)=P(X=x,\,Y=y)$ (the probability of $X=x$ **AND** $Y=y$), summing to $1$ over all pairs.
- **Sum rule (marginalisation)** ➔ sum the *unwanted* variable out; the result $p(x)$ is the **marginal**, the probability of $X=x$ **irrespective of** $Y$:
$$p(x)=\sum_{y\in\mathcal{Y}}p(x,y), \qquad p(y)=\sum_{x\in\mathcal{X}}p(x,y).$$
- **Product / conditional rule** ➔ the joint renormalised by the marginal of the conditioning event:
$$p(x\mid y)=\frac{p(x,y)}{p(y)}\;\;(p(y)>0) \qquad\Longleftrightarrow\qquad p(x,y)=p(x\mid y)\,p(y).$$
- **Independence** ➔ $X\perp Y$ iff $p(x,y)=p(x)\,p(y)$ for **all** $(x,y)$; substituting into the conditional rule gives the equivalent test $p(x\mid y)=p(x)$ ➔ *knowing $Y$ tells you nothing new about $X$*. One failing pair kills it.
- **i.i.d.** ➔ $X_1,\dots,X_n$ are **independent and identically distributed** if they are mutually independent **and** $p_{X_1}(x)=p_{X_2}(x)=\dots$ for all $x$, hence
$$p(x_1,\dots,x_n)=\prod_{i=1}^{n}p(x_i).$$
- **Why iid matters** ➔ that product *is* the **likelihood** maximised from Week 3 onward; every estimator in the unit assumes it.

### 3. Continuous random variables and the pdf
- **Density (pdf)** ➔ when $\mathcal{X}\subseteq\mathbb{R}$, $X$ is described by $f_X(x)$ with
$$f_X(x)\ge 0\;\;\forall x\in\mathcal{X}, \qquad \int_{\mathcal{X}}f_X(x)\,dx=1.$$
- **Probabilities are areas** ➔ $\;P(a<X<b)=\int_a^b f_X(x)\,dx$, and generally $P(X\in A)=\int_A f_X(x)\,dx$.
- **$P(X=x)=0$ — the $\delta\to0$ argument** ➔ on $A_\delta=(x_0\pm\tfrac{\delta}{2})$, $\;P(X\in A_\delta)=\int_{A_\delta}f_X\to 0$ as $\delta\to0$: zero width ⟹ zero area, however tall $f_X$ is there. Hence $P(a<X<b)=P(a\le X\le b)$ for continuous $X$ (**false** for discrete).
- **Validity check** ➔ (i) $f_X\ge0$ on its support, (ii) $\int_{\mathbb{R}}f_X=1$ — improper integrals as limits.
- **Both rules carry over unchanged** ➔ $f(x)=\int f(x,y)\,dy$ and $f(x\mid y)=\dfrac{f(x,y)}{f(y)}$ — integration replaces summation, densities replace masses.

### 4. cdf, survival, quantile, mode
- **Cumulative distribution function** ➔ $F_X(x)=P(X\le x)$, non-decreasing from $0$ to $1$:
$$F_X(x)=\int_{-\infty}^{x}f_X(x')\,dx' \quad\text{(continuous)}, \qquad F_X(x)=\sum_{x'\le x}p(x') \quad\text{(discrete)}.$$
- **Recover the density** ➔ $f_X(x)=F_X'(x)$ wherever $F_X$ is differentiable.
- **Interval probability from the cdf** ➔ $P(a<X\le b)=F_X(b)-F_X(a)$ — no integration needed once $F_X$ is known.
- **Survival function** ➔ $P(X>x)=1-F_X(x)$; the standard route into "at least / exceeds" questions and into conditional-tail problems.
- **Quantile function (inverse cdf)** ➔ $Q(p)=\{x\in\mathcal{X}: F_X(x)=p\}$ — *"find the $x$ with probability $p$ below it"*. $Q(0.5)$ is the **median**, $Q(0.25)$ the first quartile, $Q(0.75)$ the third (feeds [[Measures of Spread and Boxplots]]).
- **Mode (Def. 10)** ➔ $\operatorname{mode}[X]=\arg\max_{x\in\mathcal{X}}\{p(x)\}$ — returns the **$x$-value**, not the probability (cf. [[Measures of Centrality]]).

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — joint → marginals → conditionals → independence
Margins filled by the sum rule (bold):

| $p(x,y)$ | $X=1$ | $X=2$ | $X=3$ | **$p(y)$** |
| :--- | :--- | :--- | :--- | :--- |
| $Y=1$ | $0.05$ | $0.15$ | $0.10$ | $\mathbf{0.30}$ |
| $Y=2$ | $0.25$ | $0.15$ | $0.30$ | $\mathbf{0.70}$ |
| **$p(x)$** | $\mathbf{0.30}$ | $\mathbf{0.30}$ | $\mathbf{0.40}$ | $\mathbf{1.00}$ |

| Step | Operation | Computation | Result |
| :--- | :--- | :--- | :--- |
| 1 | Sum rule over $x$ | $0.05+0.15+0.10$ | $p(Y{=}1)=0.30$ |
| 2 | Sum rule over $y$ | $0.05+0.25$ | $p(X{=}1)=0.30$ |
| 3 | Conditional | $0.05/0.30$ | $p(1\mid Y{=}1)\approx0.167$ |
| 4 | Conditional | $0.25/0.70$ | $p(1\mid Y{=}2)\approx0.357$ |
| 5 | Independence | $p(1)p(1)=0.09\neq0.05$ | **not independent** |

### Applied Exercise 1 — build a pmf by counting (two dice)
**Problem:** red + blue fair die; $X=$ sum, $Y=$ max. All $36$ ordered outcomes equally likely ➔ count favourables.

| $x$ | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
| :--- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |
| $36\,p_X(x)$ | 1 | 2 | 3 | 4 | 5 | 6 | 5 | 4 | 3 | 2 | 1 |

**Final Extracted Output:** $p_Y(y)=\dfrac{2y-1}{36}$, since $\{Y\le y\}$ needs both dice $\le y$ ⟹ $y^2-(y-1)^2$ outcomes. **Key move:** enumerate the $6\times6$ grid and *count* — or difference the cdf.

### Applied Exercise 2 — validity, interval probability, cdf
**Problem:** $f_X(x)=\dfrac{1}{3x^4}$ for $x>1$. (i) Is it a pdf? (ii) $P(1\le X\le 2)$? (iii) Find $F_X$.
$$
\begin{aligned}
\text{(i)}\quad f_X(x)&\ge 0 \text{ since } x>1; &
\int_1^{\infty}\!\frac{dx}{3x^4}&=\Big[-\tfrac13 x^{-3}\Big]_1^{\infty}\cdot(-1)=\Big[x^{-3}\Big]^{1}_{\infty}=1-\lim_{x\to\infty}x^{-3}=1\;\checkmark\\
\text{(ii)}\quad P(1\le X\le 2)&=\int_1^2 f_X(x)\,dx=\Big[x^{-3}\Big]^{1}_{2}=1-\tfrac{1}{2^3}=\tfrac{7}{8}\\
\text{(iii)}\quad F_X(t)&=\int_1^t f_X(x)\,dx=1-t^{-3}\;(t\ge1), &F_X(t)&=0\;(t<1)
\end{aligned}
$$**Final Extracted Output:** $F_X(t)=1-t^{-3}$ on $t\ge1$, $0$ otherwise; check $F_X(2)-F_X(1)=\tfrac78-0=\tfrac78$ agrees with (ii).

### Applied Exercise 3 — piecewise pdf (wood strength, N/mm²)
**Problem:** $f_X(x)=\frac{x}{1400}$ on $[0,40)$, $\frac{70-x}{1050}$ on $[40,70]$, $0$ elsewhere. Find $P(20<X<50)$.
$$P(20<X<50)=\int_{20}^{40}\!\frac{x}{1400}dx+\int_{40}^{50}\!\frac{70-x}{1050}dx=\frac{1200}{2800}+\frac{500}{2100}=\frac{2}{3}$$
**Key move:** the interval **straddles a breakpoint** ➔ split at $x=40$, use the branch valid on each piece.

### Applied Exercise 4 — quantiles and a conditional tail (earthquake intensity)
**Problem:** $X\ge0$ with $f_X(x)=0.2e^{-0.2x}$, $F_X(x)=1-e^{-0.2x}$. (i) Quartiles. (ii) $P(X>s+t\mid X>t)$.
$$
\begin{aligned}
\text{(i)}\quad F_X(x)=p &\Rightarrow 1-e^{-0.2x}=p \Rightarrow Q(p)=-5\ln(1-p)\\
Q(0.25)&=-5\ln(0.75)=1.44, &Q(0.5)&=-5\ln(0.5)=3.47, &Q(0.75)&=-5\ln(0.25)=6.93\\[4pt]
\text{(ii)}\quad P(X>s+t\mid X>t)&=\frac{P(\{X>s+t\}\cap\{X>t\})}{P(X>t)}=\frac{P(X>s+t)}{P(X>t)}\\
&=\frac{1-F_X(s+t)}{1-F_X(t)}=\frac{e^{-0.2(s+t)}}{e^{-0.2t}}=e^{-0.2s}=P(X>s)
\end{aligned}
$$**Final Extracted Output:** the tail is **memoryless** — surviving to $t$ gives no information about surviving a further $s$. **Key move:** $\{X>s+t\}\subset\{X>t\}$, so the intersection collapses to the smaller event before any algebra.

## 🖼️ Modelling application — generative AI
- **Joint over images + tags** ➔ image $I$ with tag vector $\mathbf{t}$; the system models $p(I,\mathbf{t})$, then generates by **conditioning** on target tags $\mathbf{t}^{*}$ and sampling
$$p(I^{*}\mid\mathbf{t}^{*})=\frac{p(I^{*},\mathbf{t}^{*})}{\int p(I,\mathbf{t}^{*})\,dI}$$
— product rule on top, continuous sum rule underneath: the whole framework is these two rules on a huge event space.

## ⚠️ Common Mistakes
- 💡 **A density is not a probability** ➔ $f_X(x)$ may exceed $1$ (Uniform on $[0,0.5]$ has $f=2$); only $\int_a^b f_X$ is a probability, and $P(X=x)=0$. Reading $f_X(3)=0.4$ as "a 40% chance" scores zero.
- 💡 **Marginalise the *other* variable** ➔ $p(x)$ comes from summing over $y$; summing over $x$ silently returns $p(y)$ and poisons every conditional built on it.
- 💡 **Conditioning divides by the marginal** ➔ $p(x\mid y)=p(x,y)/p(y)$, needs $p(y)>0$ — not the grand total $1$.
- 💡 **Independence is a factorisation, not intuition** ➔ verify $p(x,y)=p(x)p(y)$ for **all** pairs, or exhibit **one** violating pair to disprove it.
- 💡 **Split piecewise integrals at every breakpoint**; and $\le$ vs $<$ matters **only** for discrete $X$, where $P(X\le x)$ includes the atom $p(x)$.

## 🧠 Active Recall
> [!FAQ]- From a joint distribution $p(x,y)$, how do you obtain a marginal and a conditional, and when are $X,Y$ independent?
> > [!SUCCESS]- Answer
> > - **Short answer:** **marginal** by the sum rule $p(x)=\sum_y p(x,y)$; **conditional** by the product rule $p(x\mid y)=p(x,y)/p(y)$; **independent** iff $p(x,y)=p(x)p(y)$ for all $x,y$ (equivalently $p(x\mid y)=p(x)$).
> > - **Why:** **Sum rule removes a variable, product rule re-weights** ➔ marginalising integrates out the unwanted variable; conditioning renormalises the joint by the probability of the conditioning event; independence is exactly the case where that renormalisation leaves $p(x)$ unchanged.

> [!FAQ]- Why is $f_X(x)$ for a continuous RV allowed to exceed 1, and what does $P(X=x)$ equal?
> > [!SUCCESS]- Answer
> > - **Short answer:** $f_X$ is a **density**, not a probability — only its **integral** over an interval is a probability, and that integral is bounded by $1$. A single point has zero width, so $P(X=x)=0$.
> > - **Why:** **Probability = area under $f_X$** ➔ formally, on $A_\delta=(x_0\pm\delta/2)$ we have $P(X\in A_\delta)=\int_{A_\delta}f_X\to0$ as $\delta\to0$; a tall narrow density can have $f_X>1$ while $\int f_X=1$ overall.

> [!FAQ]- Given only the cdf $F_X$, how do you obtain (a) $P(a<X\le b)$, (b) the median, (c) the density, (d) $P(X>x)$?
> > [!SUCCESS]- Answer
> > - **Short answer:** (a) $F_X(b)-F_X(a)$; (b) $Q(0.5)=F_X^{-1}(0.5)$, solved by setting $F_X(x)=0.5$; (c) $f_X(x)=F_X'(x)$; (d) $1-F_X(x)$.
> > - **Why:** **The cdf accumulates the density** ➔ differencing recovers an interval's mass, differentiating recovers the density pointwise, inverting answers "which value has probability $p$ below it", and the complement gives the survival tail. Worked instance: $F_X(x)=1-e^{-0.2x}\Rightarrow Q(p)=-5\ln(1-p)$, median $3.47$.
