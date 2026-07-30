---
unit: [FIT1058, FIT2086]
domain: D
week: [2, 3, 10]
source: [lecture, applied]
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete]
aliases: [discrete uniform, continuous uniform, U(a,b), U(k), runif, uniform cdf]
---
# [[Uniform Distribution]]

**Context:** [[FIT1058_MOC]], [[FIT2086_MOC]] · equal probability to every outcome in a bounded range · models fairness or pure ignorance · the simplest named [[Parametric Probability Distributions|parametric family]] — **discrete** on $\{a,\dots,b\}$, **continuous** on $[a,b]$

> [!abstract] Quick Revision
> - **🎯 Objective:** every outcome in the range equally likely ➔ discrete $\mathrm{Pr}(X=x)=\frac1{b-a+1}$; continuous $p(x)=\frac1{b-a}$ on $[a,b]$.
> - **📦 Core Components:** both give $E=\frac{a+b}2$ ➔ variance differs: discrete $\frac{(b-a+1)^2-1}{12}$ vs continuous $\frac{(b-a)^2}{12}$.
> - **⚡ Key Constraint:** models genuine fairness **or** pure ignorance (maximally uninformative); the discrete and continuous variance formulas are **not** interchangeable.

## 📝 Core
### 1. The Discrete Distribution
- **Definition** ➔ $X\sim\mathrm{Unif}(a,b)$: $\mathrm{Pr}(X=x)=\tfrac1{b-a+1}$ for $a\le x\le b$, else 0.
- **Count** ➔ $b-a+1$ integers in $[a,b]$.
- **Generalised support** ➔ for any finite $\mathcal{X}\subseteq\mathbb{Z}$, $P(X=k\mid\mathcal{X})=\tfrac{1}{|\mathcal{X}|}$ — the set need not be contiguous.

### 2. Moments
- **Mean** ➔ $E(X)=\frac{a+b}2$ (midpoint, by symmetry) — need not be an integer.
- **Variance** ➔ $\mathrm{Var}(X)=\frac{(b-a+1)^2-1}{12}$.
- **Check** ➔ $\mathrm{Unif}(1,6)$ = fair die: $E=3.5$, $\mathrm{Var}=\tfrac{35}{12}$.
- **Alternative parameterisation** ➔ on $\{1,2,\dots,k\}$ written $X\sim U(k)$: $P(X=x)=\tfrac1k$, $E=\tfrac{k+1}2$, $\mathrm{Var}=\tfrac{k^2-1}{12}$ (the $a=1,b=k$ case).

### 3. Two Motivations
- **Fairness** ➔ die, coin (genuine symmetry).
- **Ignorance** ➔ only the range known ⟹ assume nothing more.

### 4. Continuous Uniform *(FIT2086)*
- **Density** ➔ $X\sim U(a,b)$ with
$$p(x\mid a,b)=\begin{cases}0 & x<a\\[3pt] \dfrac{1}{b-a} & a\le x\le b\\[5pt] 0 & x>b\end{cases}$$
- **Parameters read geometrically** ➔ $a$ sets the **start**, $w=b-a$ the **width**; height $=1/w$, so a narrow interval has density $>1$ (a density is not a probability — [[Random Variables and Probability Distributions (FIT2086)]]).
- **Mean** ➔ $E[X]=\dfrac{a+b}{2}=a+\dfrac{w}{2}$ — the midpoint, as in the discrete case.
- **Variance** ➔ $V[X]=\dfrac{(b-a)^2}{12}=\dfrac{w^2}{12}$ ➔ **no $+1$**, unlike the discrete formula.
- **Probabilities are length ratios** ➔ $P(X<c)=\dfrac{c-a}{b-a}$ for $a\le c\le b$: integrating a constant density just measures a sub-interval.
- **cdf derivation** ➔ $\displaystyle P(X<x)=\int_a^x\frac{1}{b-a}\,dx'=\frac{1}{b-a}\left[x'\right]_a^x=\frac{x-a}{b-a}$ ➔ **linear** in $x$, from $0$ at $a$ to $1$ at $b$.
- **"Fraction of the way along" shortcut** ➔ any bound expressed as a weighted midpoint reads off instantly: $\frac{a+b}{2}$ is halfway ⟹ $P=\tfrac12$; $\frac{a+3b}{4}$ is three-quarters along ⟹ $P(X\in[\tfrac{a+3b}{4},b])=\tfrac14$. No integration required.
- **Outside the support the probability is exactly $0$** ➔ for $X\sim U(a,b)$ with $a,b>0$: $P(X>2b)=0$ (since $2b>b$) and $P(X\in[0,a])=0$ (the interval ends where the support starts) ➔ **check the support before computing anything**.

**Key identities:**

$$\text{discrete: }\ \mathrm{Pr}(X=x)=\tfrac1{b-a+1},\quad E=\tfrac{a+b}2,\quad \mathrm{Var}=\tfrac{(b-a+1)^2-1}{12}$$
$$\text{continuous: }\ p(x)=\tfrac1{b-a}\ (a\le x\le b),\quad E=\tfrac{a+b}2,\quad V=\tfrac{(b-a)^2}{12}$$

## ⚖️ Core Decision Matrix
| Case | $E$ | $\mathrm{Var}$ |
| :--- | :--- | :--- |
| discrete $\mathrm{Unif}(0,1)$ | 0.5 | $\tfrac{3}{12}=\tfrac14$ |
| discrete $\mathrm{Unif}(1,6)$ | 3.5 | $\tfrac{35}{12}$ |
| discrete general | $\frac{a+b}2$ | $\frac{(b-a+1)^2-1}{12}$ |
| continuous $U(a,b)$ | $\frac{a+b}2$ | $\frac{(b-a)^2}{12}$ |

> [!NOTE] **When It Flips:** uniform over a sample space = [[Probability|Equally Likely Outcomes]]; $\mathrm{Unif}(0,1)$ is a fair [[Binomial Distribution|Bernoulli Trial]]. It is the natural prior when the distribution's shape is entirely unknown. Reach for the **continuous** form when the variable is measured rather than counted (weight, waiting time, position).

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace
$\mathrm{Unif}(1,6)$:

| Step / State | Quantity | Value |
| :--- | :--- | :--- |
| **0 (Init)** | $b-a+1$ | 6 |
| 1 | $\mathrm{Pr}(X=4)$ | $\tfrac16$ |
| 2 | $E$ | 3.5 |
| 3 | $\mathrm{Var}$ | $\tfrac{35}{12}$ |

### Applied Exercise 1 — fair die events *(discrete)*
**Problem:** $X$ = face shown by a fair six-sided die. (i) $P(X\text{ odd})$; (ii) $P(X<5)$.
$$
\begin{aligned}
P(X\text{ odd}) &= P(X{=}1)+P(X{=}3)+P(X{=}5)=\tfrac16+\tfrac16+\tfrac16=\tfrac36=\tfrac12\\
P(X<5) &= 4\times\tfrac16=\tfrac46=\tfrac23
\end{aligned}
$$
**Key move:** under a uniform pmf every event probability collapses to **favourable count** $\div\ |\mathcal{X}|$.

### Applied Exercise 2 — car weight *(continuous)*
**Problem:** weight of a randomly selected car $\sim U(800,1500)$ kg. Find (i) $E[X]$, (ii) $V[X]$, (iii) $P(X<1000)$.
$$
\begin{aligned}
E[X] &= \frac{a+b}{2}=\frac{800+1500}{2}=1150\\
V[X] &= \frac{(b-a)^2}{12}=\frac{700^2}{12}=\frac{490000}{12}=40833.33\\
P(X<1000) &= \int_{800}^{1000}\frac{dx}{700}=\left[\frac{x}{700}\right]_{800}^{1000}=\frac{1000-800}{700}=\frac{200}{700}=0.29
\end{aligned}
$$
**Final Extracted Output:** $1150$ kg, $40833.33$, $P\approx0.29$. **Key move:** the integral of a constant density is a **length ratio** — no antiderivative work needed.

### Applied Exercise 3 — deriving $E[X]$ from the definition *(Studio 2)*
**Problem:** $X\sim U(0,b)$. Derive $E[X]$ by integration rather than quoting $\tfrac{a+b}{2}$.
$$
\begin{aligned}
E[X]&=\int_0^b x\,p(x\mid0,b)\,dx=\int_0^b\frac{x}{b}\,dx=\frac1b\int_0^b x\,dx\\
&=\frac1b\left[\frac{x^2}{2}\right]_0^b=\frac{b^2}{2b}=\frac{b}{2}
\end{aligned}
$$
**Final Extracted Output:** $E[X]=\tfrac b2$, consistent with $\tfrac{a+b}{2}$ at $a=0$. **Key move:** the constant $\tfrac1b$ pulls **outside** the integral, leaving the elementary $\int x\,dx$ — the same trick works for $E[X^2]$ if the question wants $V[X]$ from scratch.

### Applied Exercise 4 — two dice by linearity *(Studio 2)*
**Problem:** $X$ = one roll of a fair six-sided die, $Y$ = an independent second roll. Give $E[X]$ and $E[X+Y]$.
$$
\begin{aligned}
E[X]&=\sum_x x\,P(X=x)=\tfrac16(1)+\tfrac16(2)+\tfrac16(3)+\tfrac16(4)+\tfrac16(5)+\tfrac16(6)=3.5\\
E[X+Y]&=E[X]+E[Y]=3.5+3.5=7
\end{aligned}
$$
**Final Extracted Output:** $3.5$ and $7$. **Key move:** $E[X+Y]=E[X]+E[Y]$ is **linearity — it needs no independence at all**; independence would only be required for $V[X+Y]=V[X]+V[Y]$ (see [[Expectations and Covariance (FIT2086)]]).

## ⚠️ Common Mistakes
- 💡 **Count is $b-a+1$, not $b-a$** ➔ inclusive endpoints; the uniform is the maximally non-committal choice given only the range.
- 💡 **Discrete variance formula on a continuous uniform** ➔ $\frac{(b-a+1)^2-1}{12}$ counts *lattice points* and is meaningless on an interval, where $\frac{(b-a)^2}{12}$ applies.
- 💡 **Continuous density can exceed 1** ➔ $U(3,3.5)$ has $p(x)=2$; only the area under it is a probability.
- 💡 **Computing a probability for a region outside $[a,b]$** ➔ $P(X>2b)$ and $P(X\in[0,a])$ are **zero**, not small; students reflexively apply the length ratio and produce a negative or $>1$ answer. Sketch the support first.
- 💡 **Assuming any bounded variable is uniform** ➔ daily temperature and adult heights are bounded but centre-heavy ➔ **normal**. Uniform requires genuine symmetry (fair die/coin) or deliberate ignorance. Selection drill ➔ [[Parametric Probability Distributions]].

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

> [!FAQ]- How do the discrete and continuous uniform differ in density, variance, and how probabilities are computed?
> - **Hint:** Lattice points vs interval length.
> > [!SUCCESS]- Answer
> > - **Short answer:** discrete puts mass $\tfrac{1}{b-a+1}$ on each of $b-a+1$ integers, $\mathrm{Var}=\tfrac{(b-a+1)^2-1}{12}$; continuous spreads density $\tfrac1{b-a}$ across the interval, $V=\tfrac{(b-a)^2}{12}$. Both share $E=\tfrac{a+b}{2}$.
> > - **Why:** **Count ratio vs length ratio** ➔ discretely $P(X\in A)$ counts favourable integers over $|\mathcal{X}|$; continuously $P(a\le X\le c)=\tfrac{c-a}{b-a}$ is the sub-interval's share of the width, and $P(X=x)=0$ exactly.
