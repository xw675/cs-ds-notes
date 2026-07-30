---
unit: FIT2086
week: 4
source: [lecture]
domain: D
parent: "[[Sampling Distribution of an Estimator]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [CLT, central limit theorem, asymptotically normal, asymptotic normality, converges in distribution, normal approximation to the binomial, normal approximation to the Poisson]
---
# [[Central Limit Theorem]]

**Context:** [[FIT2086_MOC]] · the reason the [[Gaussian Distribution|normal]] is *central* — it is the limiting shape of **sums and averages**, whatever the population · turns the exact-normal result of [[Sampling Distribution of an Estimator]] into an **approximation available for every population** · licenses the approximate intervals in [[Confidence Intervals]]

> [!abstract] Quick Revision
> - **🎯 Objective:** sums of many iid RVs with finite $\mu,\sigma^2$ are approximately normal ➔ $\sum_i Y_i \xrightarrow{d} N(n\mu, n\sigma^2)$, hence $\bar Y \xrightarrow{d} N(\mu,\sigma^2/n)$ — the shape comes free, **no family need be named**.
> - **⚡ Key Constraint:** it is an **asymptotic** statement about the *sum/average*, not about the data, and it requires $E[Y_i]$ and $V[Y_i]$ to **exist and be finite**.

## 📝 Core
- **Statement** ➔ let $Y_1,\dots,Y_n$ be iid with $E[Y_i]=\mu$, $V[Y_i]=\sigma^2$; then for large $n$, $S=Y_1+\cdots+Y_n$ is approximately $N(n\mu,\,n\sigma^2)$.
- **Formal form** ➔ $\sum_{i=1}^{n} Y_i \xrightarrow{d} N(n\mu,\,n\sigma^2)$ as $n\to\infty$, where $\xrightarrow{d}$ reads "**converges in distribution**" — the approximation improves monotonically with $n$.
- **Why the normal is everywhere** ➔ any quantity built as a **sum of many small independent contributions** inherits the shape: adult height $=$ millions of genetic variants $+$ diet $+$ behaviour, each an RV.
- **Distributions become normal in a limit** ➔ a parametric family whose parameter is itself a *count of summands* flattens into a normal as that parameter $\to\infty$ (binomial in $n$, Poisson in $\lambda$).
- **Asymptotic normality of estimators** ➔ any $\hat\theta$ that is an **average of RVs** is approximately normal for large $n$ — this covers $\hat\mu_{ML}=\bar Y$, $\hat\lambda_{ML}=\bar Y$, and $\hat\sigma^2_{ML}=\frac1n\sum_i E_i$ with $E_i=(Y_i-\bar Y)^2$ (an average of the $E_i$).
- **The escape hatch's limit** ➔ many estimators are **not** visibly sums, so direct application of the CLT is difficult; the shape is then obtained by **simulation** ([[R Simulation and Random Sampling]]).
- **Exact beats asymptotic when available** ➔ if the population is itself $N(\mu,\sigma^2)$, $\bar Y\sim N(\mu,\sigma^2/n)$ **exactly, for every $n$** — the CLT adds nothing there.

## 🧮 Proof Blueprint
**Theorem.** If $Y_1,\dots,Y_n$ are iid with $E[Y_i]=\mu$, $V[Y_i]=\sigma^2$, then $\bar Y=\frac1n\sum_i Y_i \xrightarrow{d} N\!\left(\mu,\frac{\sigma^2}{n}\right)$.
**Strategy:** take the CLT on the **sum** as given, then push the constant $1/n$ through the mean and variance using $V[X/n]=V[X]/n^2$.
$$
\begin{aligned}
\sum_{i=1}^{n}Y_i &\xrightarrow{d} N\!\left(n\mu,\;n\sigma^2\right) && \text{(CLT for sums)}\\
\bar Y&=\frac1n\sum_{i=1}^{n}Y_i \;\Rightarrow\; E[\bar Y]=\frac{n\mu}{n}=\mu\\
V[\bar Y]&=\frac{1}{n^2}V\!\left[\sum_i Y_i\right]=\frac{n\sigma^2}{n^2}=\frac{\sigma^2}{n}\\
\Rightarrow\;\bar Y &\xrightarrow{d} N\!\left(\mu,\frac{\sigma^2}{n}\right)
\end{aligned}
$$**Q.E.D.** ➔ the same $(\mu,\sigma^2/n)$ that [[Estimator Quality (Bias, Variance, MSE)|bias/variance]] gives under iid-only assumptions, now carrying a **distributional shape** — which is exactly what a probability statement or interval needs.

## 📊 Normal Approximations to Named Families
| Family | Written as a sum | Summand moments | Normal limit | Limit taken in |
| :--- | :--- | :--- | :--- | :--- |
| $Bin(\theta,n)$ | $M=\sum_{i=1}^{n}Y_i$, $Y_i\sim Be(\theta)$ | $E[Y_i]=\theta$, $V[Y_i]=\theta(1-\theta)$ | $M\sim N\!\big(n\theta,\;n\theta(1-\theta)\big)$ | $n\to\infty$ |
| $Poi(\lambda)$, $\lambda\in\mathbb{Z}^+$ | $S=\sum_{i=1}^{\lambda}X_i$, $X_i\sim Poi(1)$ | $E[X_i]=1$, $V[X_i]=1$ | $S\sim N(\lambda,\;\lambda)$ | $\lambda\to\infty$ |

**Convergence in numbers** — $Bin(\theta=0.75,n)$ against its normal approximation:

| $n$ | $n\theta$ | $n\theta(1-\theta)$ | Approximation | Visual verdict |
| :--- | :--- | :--- | :--- | :--- |
| $10$ | $7.5$ | $1.875$ | $N(7.5,\,1.875)$ | visibly skewed, poor in the tails |
| $20$ | $15$ | $3.75$ | $N(15,\,3.75)$ | closer, peak still offset |
| $40$ | $30$ | $7.5$ | $N(30,\,7.5)$ | good |
| $80$ | $60$ | $15$ | $N(60,\,15)$ | curves **virtually identical** |

**Final extracted output:** the Poisson runs the same way in $\lambda$ — $Poi(4)\!\to\!N(4,4)$ is rough, $Poi(64)\!\to\!N(64,64)$ is indistinguishable; and simulated $\hat\lambda_{ML}$ histograms match $N(\lambda,\lambda/n)$ from $n\approx25$ ($\lambda=3$) while $n=3$ is still visibly discrete.

## ⚠️ Common Mistakes
- 💡 **Claiming the *data* become normal** ➔ the CLT constrains the distribution of $\sum_i Y_i$ and $\bar Y$; the population $p(y\mid\theta)$ is completely unchanged and may stay wildly skewed or discrete.
- 💡 **Applying it with no finite moments** ➔ $E[Y_i]$ and $V[Y_i]$ must **exist**; for a heavy-tailed population where $E[X]$ diverges (see [[Expectations and Covariance (FIT2086)]]) there is no $\mu$ for the limit to centre on.
- 💡 **Writing the binomial variance as $n\theta^2$** ➔ the Bernoulli summand has $V[Y_i]=\theta(1-\theta)$, so the limit is $N(n\theta,\,n\theta(1-\theta))$ — the $(1-\theta)$ is what shrinks the spread near $\theta\in\{0,1\}$.
- 💡 **Treating "approximately normal" as exact for small $n$** ➔ the approximation is asymptotic and worst in the **tails**, which is precisely where interval endpoints and $p$-values live.
- 💡 **Losing the exact result** ➔ for a normal population $\bar Y$ is exactly normal at every $n$; invoking the CLT there needlessly downgrades an exact statement to an approximation.

## 🧠 Active Recall
> [!FAQ]- The CLT says "sums become normal". What does that buy you that $E[\bar Y]=\mu$, $V[\bar Y]=\sigma^2/n$ did not already give?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **shape**. Under iid-only assumptions you can state the mean and variance of $\bar Y$ but no density; the CLT supplies an (approximate) density, so $P(a<\bar Y<b)$ becomes computable and invertible into a [[Confidence Intervals|confidence interval]].
> > - **Why:** **No family needs to be named** ➔ previously $\bar Y\sim N(\mu,\sigma^2/n)$ was a theorem *conditional* on the population being normal; the CLT delivers the same limit for **any** population with finite $\mu,\sigma^2$, which is why approximate intervals exist for the Poisson rate and Bernoulli probability.

> [!FAQ]- $\hat\sigma^2_{ML}=\frac1n\sum_i(Y_i-\bar Y)^2$ is not a sum of independent draws. Why is it still asymptotically normal?
> > [!SUCCESS]- Answer
> > - **Short answer:** define $E_i=(Y_i-\bar Y)^2$; then $\hat\sigma^2_{ML}=\frac1n\sum_i E_i$ is an **average of RVs**, and the CLT applies to averages.
> > - **Why:** **The CLT keys on the algebraic form, not the interpretation** ➔ any estimator expressible as an average inherits the limit; estimators that resist that rewriting (medians, quantiles, ratios) need **simulation** for their sampling distribution instead.
