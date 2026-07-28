---
unit: FIT2086
domain: D
week: 2
source: [lecture]
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Probability, DataScience/Theory]
aliases: [parametric model, p(x|theta), parameter space, distribution zoo, distribution summary table]
---
# [[Parametric Probability Distributions]]

**Context:** [[FIT2086_MOC]] · the move from *listing* probabilities to *generating* them from a handful of parameters ➔ the object every later week estimates ([[Statistical Modelling and Inference|MLE, CIs, testing]]) · indexes [[Gaussian Distribution]], [[Binomial Distribution]], [[Poisson Distribution]], [[Uniform Distribution]]

> [!abstract] Quick Revision
> - **🎯 Objective:** specify a whole distribution by $p(x\mid\theta)$, $x\in\mathcal{X}$, $\theta\in\Theta$ ➔ changing $\theta$ changes the distribution; $k=|\theta|\ll|\mathcal{X}|$.
> - **⚡ Key Constraint:** **every property is a function of $\theta$** — $E[X]=f(\theta)$, and likewise variance, cdf, quantiles. Match the *support* $\mathcal{X}$ to the data before choosing a family.

## 📝 Core
- **Why parametric at all** ➔ directly specifying $p(x)$ for each $x$ works only for a **small finite** $\mathcal{X}$; for large or infinite $\mathcal{X}$ (e.g. $\mathbb{Z}$, $\mathbb{R}$) the list is unwritable ➔ compress it into $k$ parameters.
- **Notation** ➔ $p(x\mid\theta)$ for densities; for discrete RVs $P(X=x\mid\theta)\equiv p(x\mid\theta)$. Here $\theta=(\theta_1,\dots,\theta_k)$ **controls** the probabilities and $\Theta$ is the set of **valid** parameter values.
- **Properties are induced by $\theta$** ➔ $E[X]=f(\theta)$ for some $f$ determined by the family, and the same holds for $V[X]$, the cdf and the quantiles ➔ *learn the family, get every summary for free*.
- **Parameterisation is not unique** ➔ one family often admits several standard parameterisations (e.g. discrete uniform as $U(k)$ on $\{1,\dots,k\}$ or $U(a,b)$ on $\{a,\dots,b\}$) ➔ **always state which one you are using** before quoting a mean or variance.
- **Selection is driven by the support** ➔ $\mathcal{X}=\{0,1\}$ ⟹ Bernoulli · $\{0,\dots,n\}$ ⟹ binomial · $\mathbb{Z}^{+}=\{0,1,2,\dots\}$ ⟹ Poisson · $\mathbb{R}$ ⟹ Gaussian · "all outcomes equally likely" ⟹ uniform.

## ⚖️ Distribution Zoo — discrete
| Distribution | Notation | pmf $f(x)$ | Support | $E[X]$ | $V[X]$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| [[Uniform Distribution\|Uniform]] — all outcomes equally likely | $X\sim U(k)$ | $\dfrac{1}{k}$ | $x=1,2,\dots,k$ | $\dfrac{k+1}{2}$ | $\dfrac{k^2-1}{12}$ |
| [[Binomial Distribution\|Bernoulli]] — one success/failure trial | $X\sim Be(\theta)$ | $\theta^{x}(1-\theta)^{1-x}$ | $x\in\{0,1\}$ | $\theta$ | $\theta(1-\theta)$ |
| [[Binomial Distribution\|Binomial]] — successes in $n$ trials | $M\sim Bin(\theta,n)$ | $\dbinom{n}{x}\theta^{x}(1-\theta)^{n-x}$ | $x=0,\dots,n$ | $n\theta$ | $n\theta(1-\theta)$ |
| [[Poisson Distribution\|Poisson]] — count of events in an interval | $X\sim Pois(\lambda)$ | $\dfrac{\lambda^{x}e^{-\lambda}}{x!}$ | $x=0,1,2,\dots$ | $\lambda$ | $\lambda$ |

## ⚖️ Distribution Zoo — continuous
| Distribution | Notation | pdf $f(x)$ | Support | $E[X]$ | $V[X]$ |
| :--- | :--- | :--- | :--- | :--- | :--- |
| [[Uniform Distribution\|Uniform]] | $X\sim U(a,b)$ | $\dfrac{1}{b-a}$ | $a\le x\le b$ | $\dfrac{a+b}{2}$ | $\dfrac{(b-a)^2}{12}$ |
| [[Gaussian Distribution\|Normal / Gaussian]] | $X\sim N(\mu,\sigma^2)$ | $\dfrac{1}{\sigma\sqrt{2\pi}}\exp\!\left(-\dfrac{(x-\mu)^2}{2\sigma^2}\right)$ | $-\infty<x<\infty$ | $\mu$ | $\sigma^2$ |

> [!NOTE] **When It Flips:** the **variance–mean relationship** is the family fingerprint — Poisson has $V=E=\lambda$ (variance **grows** with the mean), binomial has $V=n\theta(1-\theta)<E=n\theta$ (variance **capped** and maximal at $\theta=\tfrac12$), Gaussian decouples them entirely ($\mu$ and $\sigma^2$ free) ➔ comparing a sample's mean against its variance is the fastest check that a count model is the wrong family.

## ⚠️ Common Mistakes
- 💡 **Quoting a mean without fixing the parameterisation** ➔ discrete uniform gives $\tfrac{k+1}{2}$ under $U(k)$ but $\tfrac{a+b}{2}$ under $U(a,b)$; the *variance* differs too ($\tfrac{k^2-1}{12}$ vs $\tfrac{(b-a+1)^2-1}{12}$).
- 💡 **Choosing a family whose support contradicts the data** ➔ a Gaussian assigns positive density to negative values, so it cannot model a strictly non-negative count; match $\mathcal{X}$ first, fit second.
- 💡 **Confusing $\theta$ with a realisation** ➔ $\theta$ is a **fixed unknown** indexing the model; $x$ is the observed data. Every estimation week of this unit is about recovering $\theta$ from $x$.

## 🧠 Active Recall
> [!FAQ]- Why use a parametric distribution rather than specifying $p(x)$ for each $x$ directly?
> > [!SUCCESS]- Answer
> > - **Short answer:** direct specification requires one number per element of $\mathcal{X}$, which is only feasible for a **small finite** event space; a parametric model uses $k\ll|\mathcal{X}|$ parameters and works even when $\mathcal{X}$ is infinite.
> > - **Why:** **$p(x\mid\theta)$ is a rule, not a list** ➔ $\theta\in\Theta$ generates a probability for every $x\in\mathcal{X}$, and all derived quantities ($E[X]$, $V[X]$, cdf, quantiles) become functions of $\theta$ ➔ estimating the handful of parameters from data recovers the entire distribution, which is exactly what the rest of the unit does.

> [!FAQ]- Given only the sample space of a variable, which family would you reach for and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** match the **support** — $\{0,1\}$ ⟹ Bernoulli; $\{0,\dots,n\}$ successes in $n$ fixed trials ⟹ binomial; unbounded non-negative counts in an interval ⟹ Poisson; a bounded set with no outcome favoured ⟹ uniform; the whole real line ⟹ Gaussian.
> > - **Why:** **The support is a hard constraint, the shape is a modelling choice** ➔ a family that puts mass outside $\mathcal{X}$ (or none inside it) is wrong regardless of fit quality; among the survivors, the variance–mean relationship discriminates further (Poisson forces $V=E$, binomial caps $V$ below $E$, Gaussian leaves both free).
