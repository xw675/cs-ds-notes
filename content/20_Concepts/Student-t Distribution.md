---
unit: FIT2086
week: 4
source: [lecture]
domain: D
parent: "[[Parametric Probability Distributions]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [Student t, t-distribution, t distribution, degrees of freedom, DOF, t critical value, t_alpha/2]
---
# [[Student-t Distribution]]

**Context:** [[FIT2086_MOC]] · the distribution the standardised sample mean follows once $\sigma^2$ is **estimated rather than known** · replaces $z$ with $t$ in the unknown-variance case of [[Confidence Intervals]] · a wider-tailed sibling of the [[Gaussian Distribution]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\dfrac{\hat\mu_{ML}-\mu}{\hat\sigma_u/\sqrt{n}}\sim t(n-1)$ ➔ one parameter, the **degrees of freedom** $\nu=n-1$; symmetric and self-similar like the normal, but with **heavier tails**.
> - **⚡ Key Constraint:** $\nu=n-1$, **not** $n$ — one degree of freedom is spent estimating $\mu$ inside $\hat\sigma^2_u$.

## 📝 Core
- **Where it comes from** ➔ substituting the estimate $\hat\sigma^2_u=\frac{1}{n-1}\sum_i(y_i-\hat\mu_{ML})^2$ for the known $\sigma^2$ makes the standardised statistic **no longer normal**: the denominator is now random too.
- **Extra uncertainty widens the tails** ➔ $t(\nu)$ spreads probability further out and **tails off to zero more slowly** than $N(0,1)$; that surplus tail mass is the price of not knowing $\sigma^2$.
- **Shape properties reused** ➔ **symmetric about $0$** and **self-similar**, so the same two-sided percentile trick as the unit normal works: the $100(1-\alpha/2)$-th percentile $t_{\alpha/2,\nu}$ cuts $\alpha/2$ off each tail.
- **Limit** ➔ as $\nu\to\infty$ the estimate $\hat\sigma^2_u$ concentrates on $\sigma^2$ and $t(\nu)\to N(0,1)$ ➔ $t_{\alpha/2,\nu}\downarrow z_{\alpha/2}$ from above, never below.
- **Critical values are always $>$ the normal's** ➔ $t$-based intervals are **wider** than the corresponding $z$-based interval at the same $\alpha$, which is exactly how the coverage lost by estimating $\sigma^2$ is recovered.

## 📊 Two-Sided Critical Values ($\alpha=0.05$)
| $n$ | $\nu=n-1$ | $t_{0.025,\nu}$ | Excess over $z_{0.025}=1.96$ |
| :--- | :--- | :--- | :--- |
| $3$ | $2$ | $\approx 4.30$ | $+119\%$ |
| $6$ | $5$ | $\approx 2.57$ | $+31\%$ |
| $8$ | $7$ | $\approx 2.36$ | $+20\%$ |
| $11$ | $10$ | $\approx 2.22$ | $+13\%$ |
| $\infty$ | $\infty$ | $1.96$ | $0\%$ |

**Final extracted output:** the penalty is severe only for tiny samples — by $n\approx 30$ the $t$ and $z$ intervals differ by a few percent, which is why large-$n$ work quotes $1.96$ without apology. Look-up syntax lives in [[R Toolkit (Cheatsheet)]].

## ⚠️ Common Mistakes
- 💡 **Using $\nu=n$** ➔ the degrees of freedom are $n-1$; at $n=8$ that is $t_{0.025,7}=2.36$, not $t_{0.025,8}=2.31$ — small, but it is a free mark.
- 💡 **Feeding $\hat\sigma^2_{ML}$ into a $t$ interval** ➔ the $t$ result is derived for the **unbiased** $\hat\sigma^2_u$ (divisor $n-1$); the ML version (divisor $n$) understates the spread ([[Estimator Quality (Bias, Variance, MSE)]]).
- 💡 **Passing $\alpha$ where the percentile is wanted** ➔ $t_{\alpha/2,\nu}$ is the $100(1-\alpha/2)$-th percentile, so the quantile argument is $p=1-\alpha/2=0.975$, not $0.025$ or $0.05$.

## 🧠 Active Recall
> [!FAQ]- Why does estimating $\sigma^2$ force a *different distribution* rather than just a slightly noisier normal?
> > [!SUCCESS]- Answer
> > - **Short answer:** in $\frac{\hat\mu_{ML}-\mu}{\hat\sigma_u/\sqrt n}$ **both numerator and denominator are random**; the ratio of a normal to an independent random scale is no longer normal, and its exact law is $t(n-1)$.
> > - **Why:** **Coverage, not cosmetics** ➔ substituting $\hat\sigma_u$ into the $z$ interval yields *less* than $100(1-\alpha)\%$ coverage; the heavier $t$ tails are the correction that restores it, exactly when the population is normal.
