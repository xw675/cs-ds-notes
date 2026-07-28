---
unit: FIT2086
domain: D
week: 2
source: [lecture]
parent: "[[Parametric Probability Distributions]]"
tags: [Math/Probability, DataScience/Theory]
aliases: [normal distribution, Gaussian, N(mu, sigma^2), standard normal, z-score, standardisation, 68-95-99.7 rule, empirical rule]
---
# [[Gaussian Distribution]]

**Context:** [[FIT2086_MOC]] · the default [[Parametric Probability Distributions|parametric model]] for $\mathcal{X}=\mathbb{R}$ · two parameters $\theta=(\mu,\sigma^2)$ that **are** the mean and variance · self-similar and additive, which is why it carries the confidence-interval and regression work later in the unit

> [!abstract] Quick Revision
> - **🎯 Objective:** $X\sim N(\mu,\sigma^2)$ with
> $$p(x\mid\mu,\sigma^2)=\left(\frac{1}{2\pi\sigma^2}\right)^{1/2}\exp\!\left(-\frac{(x-\mu)^2}{2\sigma^2}\right)$$
> ➔ symmetric bell on all of $\mathbb{R}$, tailing to $0$ as $|x|\to\infty$.
> - **📦 Core Components:** $E[X]=\mu=\text{mode}=\text{median}$ ➔ $V[X]=\sigma^2$ ➔ **self-similarity** $X=\sigma Z+\mu$ ➔ **additivity** under sums.
> - **⚡ Key Constraint:** the **cdf has no closed form** — every probability comes from standardising to $Z$ and reading a table, or from `pnorm` in R. Never try to integrate the pdf by hand.

## 📝 How It Works

### 1. The density and its parameters
- **Parameters are the moments** ➔ $\theta=(\mu,\sigma^2)\in\Theta=\mathbb{R}\times\mathbb{R}^{+}$, where $\mu$ **is** the mean and $\sigma^2$ **is** the variance — unusually direct; most distributions require deriving $E[X]=f(\theta)$.
- **Shape** ➔ symmetric about $\mu$; $\sigma^2$ controls width (small $\sigma^2$ ⟹ tall narrow peak, large $\sigma^2$ ⟹ low flat spread).
- **Centrality collapse** ➔ symmetry ⟹ **mode $=$ median $=$ mean $=\mu$** (contrast the skewed cases in [[Measures of Centrality]]).
- **Notation** ➔ $X\sim N(\mu,\sigma^2)$, "$\sim$" read as *"is distributed as per a"*.

### 2. Self-similarity (standardisation)
- **Every Gaussian is a rescaled standard normal** ➔ if $Z\sim N(0,1)$ then $X=\sigma Z+\mu$ is $N(\mu,\sigma^2)$.
- **Inverted, this is the $z$-score** ➔ $Z=\dfrac{X-\mu}{\sigma}$ ➔ one table/one function serves **all** $(\mu,\sigma^2)$.
- **Consistency check** ➔ $E[\sigma Z+\mu]=\sigma\cdot0+\mu=\mu$ and $V[\sigma Z+\mu]=\sigma^2V[Z]=\sigma^2$ by [[Expectations and Covariance (FIT2086)|linearity and $V[cX]=c^2V[X]$]].

### 3. The cdf and the $\sigma$-rules
- **No closed form** ➔ evaluated numerically by software; the reason $z$-tables exist at all.
- **Scale-free coverage rules** (hold for **every** $\mu,\sigma$):

| Interval | Probability mass |
| :--- | :--- |
| $(\mu-\sigma,\;\mu+\sigma)$ | $68.27\%$ |
| $(\mu-2\sigma,\;\mu+2\sigma)$ | $95.45\%$ |
| $(\mu-3\sigma,\;\mu+3\sigma)$ | $99.73\%$ |

- **Why they are useful** ➔ they convert a distance-from-the-mean into a probability with no integration, and are the intuition behind later confidence intervals.

### 4. Additivity and decomposition
- **Sum of two independent Gaussians is Gaussian** ➔ $X_1\sim N(\mu_1,\sigma_1^2)$, $X_2\sim N(\mu_2,\sigma_2^2)$ ⟹
$$X_1+X_2\sim N(\mu_1+\mu_2,\;\sigma_1^2+\sigma_2^2)$$
— means add, **variances** add (never standard deviations).
- **Decomposition (the converse)** ➔ for any $n\ge1$, $X\sim N(\mu,\sigma^2)$ can be written $X=\sum_{i=1}^{n}X_i$ with $X_i\sim N(\mu_i,\sigma_i^2)$ whenever $\sum\mu_i=\mu$ and $\sum\sigma_i^2=\sigma^2$ ➔ a normal RV splits into arbitrarily many normal pieces.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — standardise, then read the cdf
$X\sim N(100,\,15^2)$; find $P(X\le 118)$ and $P(85<X<115)$.

| Step | Operation | Computation | Result |
| :--- | :--- | :--- | :--- |
| 1 | standardise the bound | $z=\dfrac{118-100}{15}$ | $z=1.2$ |
| 2 | cdf lookup / `pnorm` | $P(Z\le1.2)$ | $\approx0.885$ |
| 3 | recognise $85,115$ as $\mu\pm\sigma$ | $\sigma$-rule | $68.27\%$ |
| 4 | upper tail | $1-P(X\le118)$ | $\approx0.115$ |

**Key move:** step 3 needs no table at all — spotting that the interval **is** $\mu\pm k\sigma$ collapses the question to a memorised rule.

### Applied Exercise — additivity
**Problem:** $X_1\sim N(3,4)$ and $X_2\sim N(5,9)$ are independent. Distribution of $X_1+X_2$, and $P(X_1+X_2>12)$?
$$
\begin{aligned}
X_1+X_2 &\sim N(3+5,\;4+9)=N(8,13)\\
z &= \frac{12-8}{\sqrt{13}}=\frac{4}{3.606}=1.109\\
P(X_1+X_2>12) &= 1-P(Z\le1.109)\approx 1-0.866=0.134
\end{aligned}
$$**Final Extracted Output:** $N(8,13)$, upper-tail probability $\approx0.13$. **Key move:** add the **variances** ($4+9=13$), then take $\sqrt{13}$ only when standardising.

## ⚙️ In R
> [!code]- The `norm` suffix (details ➔ [[R Simulation and Random Sampling]])
> ```r
> dnorm(x, mean = 0, sd = 1)                 # density height at x — NOT a probability
> pnorm(118, mean = 100, sd = 15)            # cdf  P(X <= 118) = 0.8849
> pnorm(118, 100, 15, lower.tail = FALSE)    # upper tail P(X > 118)
> qnorm(0.975)                               # quantile: 1.96
> rnorm(n, mean = 100, sd = 15)              # n random draws
> ```
> 💡 **Common Mistake:** R takes **`sd`**, not the variance ➔ for $N(100,15^2)$ pass `sd = 15`; passing `225` silently models $N(100,225^2)$.

## ⚠️ Common Mistakes
- 💡 **$\sigma^2$ vs $\sigma$** ➔ the notation $N(\mu,\sigma^2)$ carries the **variance**, but standardising and R's `sd` argument both need $\sigma$. Mis-rooting is the single largest mark-loss vector here.
- 💡 **Adding standard deviations** ➔ under independence, **variances** add: $\sigma=\sqrt{\sigma_1^2+\sigma_2^2}$, never $\sigma_1+\sigma_2$.
- 💡 **Trying to integrate the pdf** ➔ there is no closed-form antiderivative; standardise and use a table or `pnorm`.
- 💡 **$\le$ vs $<$** ➔ irrelevant here ($X$ is continuous, so $P(X=x)=0$) but the same slip is fatal for the discrete distributions.

## 🧠 Active Recall
> [!FAQ]- What is self-similarity for the Gaussian, and why does it matter practically?
> > [!SUCCESS]- Answer
> > - **Short answer:** every Gaussian is a **translated and scaled** standard normal — if $Z\sim N(0,1)$ then $X=\sigma Z+\mu\sim N(\mu,\sigma^2)$, equivalently $Z=(X-\mu)/\sigma$.
> > - **Why:** **One tabulated distribution serves all parameters** ➔ since the cdf has no closed form, every probability must be evaluated numerically; self-similarity means only $N(0,1)$ need ever be tabulated, and any $P(X\le x)$ becomes $P\!\left(Z\le\frac{x-\mu}{\sigma}\right)$. The moments follow by linearity: $E[\sigma Z+\mu]=\mu$, $V[\sigma Z+\mu]=\sigma^2$.

> [!FAQ]- State the additivity property and give the parameters of $X_1+X_2$ for independent Gaussians.
> > [!SUCCESS]- Answer
> > - **Short answer:** $X_1\sim N(\mu_1,\sigma_1^2)$, $X_2\sim N(\mu_2,\sigma_2^2)$ ⟹ $X_1+X_2\sim N(\mu_1+\mu_2,\;\sigma_1^2+\sigma_2^2)$ — the family is **closed** under addition, and conversely any $N(\mu,\sigma^2)$ decomposes into $n$ normal summands with $\sum\mu_i=\mu$, $\sum\sigma_i^2=\sigma^2$.
> > - **Why:** **Means add by linearity, variances add by independence** ➔ $E[X_1+X_2]=E[X_1]+E[X_2]$ holds unconditionally, while $V[X_1+X_2]=V[X_1]+V[X_2]$ requires $X_1\perp X_2$; closure of the *family* is the extra Gaussian-specific fact.

> [!FAQ]- Why is the mode of a Gaussian equal to its median and mean, and what fraction of mass lies within $\mu\pm2\sigma$?
> > [!SUCCESS]- Answer
> > - **Short answer:** the density is **symmetric about $\mu$** with a single maximum there, so mode $=$ median $=$ mean $=\mu$; $95.45\%$ of the mass lies in $(\mu-2\sigma,\mu+2\sigma)$.
> > - **Why:** **Symmetry forces the three location measures to coincide** ➔ $p(\mu+d)=p(\mu-d)$ makes $\mu$ both the balance point (mean) and the $0.5$-quantile (median), and $\exp(-(x-\mu)^2/2\sigma^2)$ is maximised where the exponent is zero, i.e. at $x=\mu$ (mode). The $68.27/95.45/99.73$ coverage rules are scale-free, holding for every $\mu$ and $\sigma$.
