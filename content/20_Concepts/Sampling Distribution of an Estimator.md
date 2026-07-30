---
unit: FIT2086
week: 3
source: [lecture]
domain: D
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [sampling distribution, sampling statistics, distribution of the sample mean, repeated sampling, standard error]
---
# [[Sampling Distribution of an Estimator]]

**Context:** [[FIT2086_MOC]] · the machinery that makes an estimate *auditable* — an estimator is a **random variable**, so it has a distribution · consumed by [[Estimator Quality (Bias, Variance, MSE)]], then by [[Confidence Intervals]] (W4) and hypothesis testing (W5); generalised beyond normal populations by the [[Central Limit Theorem]]

> [!abstract] Quick Revision
> - **🎯 Objective:** any function of the data is a **realisation of a random variable** ➔ $\hat\theta(Y_1,\dots,Y_n)$ follows a distribution determined by the population $p(y\mid\theta)$.
> - **⚡ Key Constraint:** the sampling distribution exists only **relative to assumed population assumptions** — weaker assumptions still give $E$ and $V$, but no distributional shape.

## 📝 Core
- **The chain** ➔ population $\to$ **sampling** $\to$ sample $\mathbf{y}$ $\to$ **inference** $\to$ model. The $\mathbf{y}$ you hold is **one of infinitely many** datasets you could have drawn.
- **Estimator as a function** ➔ formally $\hat\theta$ maps the sample to the parameter space; if $\mathbf{y}$ realises $(Y_1,\dots,Y_n)$, then $\hat\theta(\mathbf{y})$ realises the RV $\hat\theta(Y_1,\dots,Y_n)$, so $\hat\theta\sim P(\theta)$.
- **Repeated sampling is the thought experiment** ➔ draw $\mathbf{y}^{(1)},\mathbf{y}^{(2)},\dots$ each of size $n$; each gives a different $\bar y_k$. The **histogram of those $\bar y_k$** *is* the sampling distribution.
- **Standard parametric assumption** ➔ assume $Y_1,\dots,Y_n\sim p(y\mid\theta)$ with $\theta$ the **population parameters**; weakening it is possible but weakens every statement derivable about $\hat\theta$.
- **Escape hatch** ➔ when the distribution is not analytically obtainable, **simulate**: resample, recompute $\hat\theta$, histogram — always an available approximation (see [[R Simulation and Random Sampling]]).
- **Three uses** ➔ quantify accuracy (**confidence intervals**) · judge how unlikely a statistic is (**hypothesis testing**) · **compare estimators** (the W3 use — bias/variance/MSE).

## 🧮 Proof Blueprint
**Theorem.** If $Y_1,\dots,Y_n\sim N(\mu,\sigma^2)$ iid, then $\bar Y=\frac1n\sum_i Y_i\sim N\!\left(\mu,\frac{\sigma^2}{n}\right)$.
**Strategy:** write $\bar Y$ as a **sum of scaled normals**, then apply the Gaussian's two closure facts.

**Facts used** *(from [[Gaussian Distribution]])*: $Y_1\sim N(\mu_1,\sigma_1^2),Y_2\sim N(\mu_2,\sigma_2^2)$ independent $\Rightarrow Y_1+Y_2\sim N(\mu_1+\mu_2,\sigma_1^2+\sigma_2^2)$; and $Y_1\sim N(\mu,\sigma^2)\Rightarrow Y_1/n\sim N\!\left(\mu/n,(\sigma/n)^2\right)$.
$$
\begin{aligned}
\bar Y&=\frac{Y_1}{n}+\frac{Y_2}{n}+\cdots+\frac{Y_n}{n}\;\sim\;N\!\left(n\cdot\frac{\mu}{n},\;n\cdot\frac{\sigma^2}{n^2}\right)=N\!\left(\mu,\frac{\sigma^2}{n}\right)\\
E[\bar Y]&=\frac1n\big(E[Y_1]+\cdots+E[Y_n]\big)=\frac{n\mu}{n}=\mu\\
V[\bar Y]&=\frac{1}{n^2}\big(V[Y_1]+\cdots+V[Y_n]\big)=\frac{n\sigma^2}{n^2}=\frac{\sigma^2}{n}
\end{aligned}
$$**Q.E.D.** ➔ the sample mean is centred on the **unknown population mean** with variance the **population variance divided by $n$**: it **decreases with $n$** and **increases with $\sigma^2$**.

## ⚖️ Strength of Assumptions
| Assumption on $Y_1,\dots,Y_n$ | What you get about $\bar Y$ | What you cannot do |
| :--- | :--- | :--- |
| iid, $E[Y_i]=\mu$, $V[Y_i]=\sigma^2$ (**no family named**) | $E[\bar Y]=\mu$, $V[\bar Y]=\sigma^2/n$ | no shape ➔ no exact probability statements, no exact CI |
| iid $N(\mu,\sigma^2)$ (**family named**) | $\bar Y\sim N(\mu,\sigma^2/n)$ — full density | — (strongest case; needs normality to hold) |

> [!NOTE] **When It Flips:** both rows give the *same* mean and variance; the normal assumption buys the **distributional shape** on top. Naming the family is what licenses "$P(\bar Y<c)=\dots$".

## 📊 Worked Numbers
Population $N(\mu=1.65,\sigma^2=0.1)$, samples of size $n=5$:

| Sample | $\mathbf{y}^{(k)}$ | $\bar y_k$ |
| :--- | :--- | :--- |
| 1 | $(1.620,1.652,1.623,1.475,1.621)$ | $1.598$ |
| 2 | $(1.729,1.517,1.417,1.505,1.683)$ | $1.570$ |
| 3 | $(1.689,1.695,1.637,1.668,1.602)$ | $1.658$ |
| 4 | $(1.736,1.513,1.695,1.565,1.616)$ | $1.625$ |
| 5 | $(1.705,1.753,1.538,1.776,1.716)$ | $1.697$ |

**Final extracted output:** the $\bar y_k$ scatter around $1.65$; over $10^6$ such samples their histogram is $N(1.65,\sigma^2/5)$ — **not** the population's own spread.

## ⚠️ Common Mistakes
- 💡 **Confusing $V[\bar Y]$ with $V[Y]$** ➔ the sampling distribution is **narrower by a factor $n$**; quoting $\sigma^2$ as the spread of the mean overstates uncertainty $n$-fold.
- 💡 **Treating $\sigma^2/n\to0$ as "the estimate is exact"** ➔ it means variability vanishes *under the assumed model*; model misspecification does not shrink with $n$.
- 💡 **Naming a family for free** ➔ $\bar Y\sim N(\cdot)$ is a theorem *given* normal data; from iid-only assumptions you may state $E$ and $V$ **but not the shape**.
- 💡 **Reading the histogram as the data's histogram** ➔ it is a histogram of **statistics computed from many samples**, one point per dataset.

## 🧠 Active Recall
> [!FAQ]- In what sense does the sample mean have a distribution, when it is just one number computed from one dataset?
> > [!SUCCESS]- Answer
> > - **Short answer:** the one dataset is **one realisation** of $(Y_1,\dots,Y_n)$; since $\bar Y$ is a function of those RVs it is itself an RV, and its distribution describes how $\bar y$ would vary **across repeated samples** from the same population.
> > - **Why:** **Function of RVs is an RV** ➔ formally $\hat\theta:\mathbf{y}\mapsto\Theta$, so $\hat\theta\sim P(\theta)$ inherited from $p(y\mid\theta)$ — the source of the estimator's bias, variance and MSE.

> [!FAQ]- Which is the stronger claim, $V[\bar Y]=\sigma^2/n$ or $\bar Y\sim N(\mu,\sigma^2/n)$, and what extra assumption buys the difference?
> > [!SUCCESS]- Answer
> > - **Short answer:** the second. $E[\bar Y]=\mu$ and $V[\bar Y]=\sigma^2/n$ need only **iid with finite mean and variance**; the normal *shape* needs the population itself to be $N(\mu,\sigma^2)$ (or, from W4, the [[Central Limit Theorem|CLT]] for large $n$).
> > - **Why:** **Shape licenses probability statements** ➔ without a density you cannot compute $P(a<\bar Y<b)$ or invert it into a confidence interval; the moments alone only bound variability.
