---
unit: FIT2086
week: [3, 4, 5]
source: [lecture, applied]
domain: D
parent: "[[Sampling Distribution of an Estimator]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [estimator bias, unbiased estimator, estimator variance, mean squared error, MSE, bias-variance decomposition, efficiency, consistency, unbiased variance estimator, robustness, relative MSE, mean vs median]
---
# [[Estimator Quality (Bias, Variance, MSE)]]

**Context:** [[FIT2086_MOC]] · how to *compare* two estimators of the same $\theta$ — [[Maximum Likelihood Estimation|ML]] is one recipe among many · every metric here is an expectation over the [[Sampling Distribution of an Estimator|sampling distribution]] · distinct from the prediction-side [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** score an estimator by **systematic error** ($b_\theta$), **variability** ($\mathrm{Var}_\theta$), and their combination $\mathrm{MSE}_\theta=b_\theta^2+\mathrm{Var}_\theta$ ➔ smaller MSE = better.
> - **📦 Core Components:** $b_\theta(\hat\theta)=E[\hat\theta(\mathbf{Y})]-\theta$ | $\mathrm{Var}_\theta(\hat\theta)=V[\hat\theta(\mathbf{Y})]$ | $\mathrm{MSE}_\theta(\hat\theta)=E[(\hat\theta(\mathbf{Y})-\theta)^2]$.
> - **⚡ Key Constraint:** bias, variance and MSE all depend on the **parameterisation** — unbiased for $\sigma^2$ does **not** mean unbiased for $\sigma$; only **consistency** survives reparameterisation.

## 📝 How It Works
### 1. Bias
- **Definition** ➔ $b_\theta(\hat\theta)=E\!\left[\hat\theta(\mathbf{Y})\right]-\theta$, the expectation taken over the RVs $\mathbf{Y}=(Y_1,\dots,Y_n)$ — how much the estimator over/underestimates **on average**.
- **A function of $\theta$** ➔ bias may be harmless at some $\theta$ and severe at others; it is not a single number.
- **Three signs** ➔ $b_\theta<0$ **underestimates** · $b_\theta>0$ **overestimates** · $b_\theta=0$ for **all** $\theta$ ⟹ the estimator is **unbiased**.
- **Sample mean is unbiased under weak assumptions** ➔ only iid with $E[Y_i]=\mu$ needed, no family named: $E[\bar Y]=\frac{E[Y_1]+\cdots+E[Y_n]}{n}=\frac{n\mu}{n}=\mu$.

### 2. Variance
- **Definition** ➔ $\mathrm{Var}_\theta(\hat\theta)=E\!\left[\left(\hat\theta(\mathbf{Y})-E[\hat\theta(\mathbf{Y})]\right)^2\right]=V\!\left[\hat\theta(\mathbf{Y})\right]$ — literally the **variance of the sampling distribution**.
- **Operational reading** ➔ draw a *fresh* sample of size $n$ and recompute: the variance says how far (squared) the new estimate is expected to sit from the old one.
- **Sample mean** ➔ $V[\bar Y]=\frac{1}{n^2}\left(V[Y_1]+\cdots+V[Y_n]\right)=\frac{\sigma^2}{n}$, using independence, then $V[kX]=k^2V[X]$, then $V[Y_i]=\sigma^2$ ➔ **larger $n$, less variable**.

### 3. Mean squared error and its decomposition
- **Definition** ➔ $\mathrm{MSE}_\theta(\hat\theta)=E\!\left[(\hat\theta(\mathbf{Y})-\theta)^2\right]$ — average squared distance from the **population parameter**; larger ⟹ poorer. Absolute error is a legitimate alternative but algebraically nastier.
- **Bias–variance decomposition** ➔ $\boxed{\mathrm{MSE}_\theta(\hat\theta)=b_\theta^2(\hat\theta)+\mathrm{Var}_\theta(\hat\theta)}$ — MSE's chief attraction.
- **Unbiased case** ➔ $b_\theta=0\Rightarrow\mathrm{MSE}=\mathrm{Var}$, so among unbiased estimators "better" = **smaller variance** = more **efficient**.
- **Sample mean** ➔ $\mathrm{MSE}_{\mu,\sigma^2}(\bar Y)=0^2+\sigma^2/n=\sigma^2/n$ ➔ **independent of $\mu$** · **increasing in $\sigma^2$** · **decreasing in $n$**. Broadly useful, since many MLEs *are* the sample mean.

### 4. Parameterisation dependence
- **The weakness** ➔ bias, variance and MSE are all defined on a *chosen* expression of the parameter, and $E[f(X)]\neq f(E[X])$ unless $f$ is **linear** (see [[Taylor Approximation of Expectations]]).
- **Concrete failure** ➔ $\hat\sigma^2_u$ is unbiased for $\sigma^2$, yet $E\!\left[\sqrt{\hat\sigma^2_u}\right]-\sigma\neq0$: the same estimator is **biased for the standard deviation**.
- **Mitigation** ➔ error measures exist that are parameterisation-insensitive — e.g. **relative error** in place of MSE, which does not care whether you wrote variance or standard deviation.

### 5. Consistency
- **Loose statement** ➔ $\hat\theta$ is **consistent** if it gets closer and closer to $\theta$ as $n\to\infty$ ➔ for large enough samples the estimate is guaranteed good.
- **Sufficient test** ➔ $b_\theta(\hat\theta)\to0$ **and** $\mathrm{Var}_\theta(\hat\theta)\to0$ as $n\to\infty$, for all $\theta$.
- **Sample mean qualifies** ➔ $b_\mu(\bar Y)=0$ and $\mathrm{Var}_{\sigma^2}(\bar Y)=\sigma^2/n\to0$; also derivable from the **WLLN** ([[Expectations and Covariance (FIT2086)]]).
- **Why it matters** ➔ unlike bias/variance/MSE, consistency **does not depend on the parameterisation** — and ML is consistent for many (not all) models.

### 6. Efficiency vs robustness *(Studio 3)*
- **Both metrics need a rival** ➔ compare two estimators of the same $\theta$ by $\mathrm{RelMSE}=\dfrac{\mathrm{MSE}(\hat\theta_A)}{\mathrm{MSE}(\hat\theta_B)}$ ➔ $<1$ means $A$ wins; the ratio is **scale-free**, so changing $\sigma$ leaves it unmoved.
- **Sample mean vs sample median** ➔ for a normal population **both are unbiased**, so the verdict is pure variance: the mean uses every value, the median uses only the central one or two ➔ the **mean is more efficient**, and its lead *grows* with $n$ because $\mathrm{Var}(\bar Y)=\sigma^2/n$ falls faster than the median's.
- **Robustness is the counterweight** ➔ replace a fraction $n_c/n$ of the sample with draws of $4\times$ the spread and the mean's variance inflates while the median's barely moves ➔ **the verdict flips to the median**; enough clean data dilutes the contamination and flips it back.
- **The general lesson** ➔ "better estimator" is a claim **conditional on the population you assume**; an estimator optimal under exact normality can be the wrong choice under outliers ([[Measures of Centrality]] makes the same point descriptively).
- **When the algebra runs out** ➔ estimate $b_\theta$, $\mathrm{Var}_\theta$ and $\mathrm{MSE}_\theta$ by **simulation** — generate many datasets from a known $\theta$, recompute $\hat\theta$ on each, and summarise ➔ [[Monte Carlo Estimator Comparison]].

## 🧮 Proof Blueprint
**Theorem.** For iid $Y_i$ with variance $\sigma^2$, the ML variance estimator $\hat\sigma^2_{ML}=\frac1n\sum_i(y_i-\bar y)^2$ is **biased**, with $b_{\sigma^2}(\hat\sigma^2_{ML})=-\sigma^2/n$; the rescaled $\hat\sigma^2_u=\frac{1}{n-1}\sum_i(y_i-\bar y)^2=\frac{n}{n-1}\hat\sigma^2_{ML}$ is **unbiased**.
**Strategy:** re-centre each deviation on $\mu$, expand the square, collapse the cross term via $\sum_i(y_i-\mu)=n(\bar y-\mu)$, then substitute $E[(\bar y-\mu)^2]=V[\bar Y]=\sigma^2/n$.
$$
\begin{aligned}
E\!\left[\hat\sigma^2_{ML}\right]&=\frac1n E\!\left[\sum_{i=1}^n\big((y_i-\mu)-(\bar y-\mu)\big)^2\right]\\
&=\frac1n E\!\left[\sum_i(y_i-\mu)^2-2\sum_i(y_i-\mu)(\bar y-\mu)+\sum_i(\bar y-\mu)^2\right]\\
&=\frac1n\left[n\sigma^2-2n\,E\big[(\bar y-\mu)^2\big]+n\,E\big[(\bar y-\mu)^2\big]\right]=\frac1n\left[n\sigma^2-n\,V[\bar Y]\right]\\
&=\frac1n\left[n\sigma^2-n\frac{\sigma^2}{n}\right]=\sigma^2\!\left(1-\frac1n\right)=\left(\frac{n-1}{n}\right)\sigma^2\\
b_{\sigma^2}\!\left(\hat\sigma^2_{ML}\right)&=\left(\frac{n-1}{n}\right)\sigma^2-\sigma^2=-\frac{\sigma^2}{n}\;<0\\
E\!\left[\hat\sigma^2_u\right]&=\frac{n}{n-1}E\!\left[\hat\sigma^2_{ML}\right]=\frac{n}{n-1}\cdot\frac{n-1}{n}\sigma^2=\sigma^2\;\Rightarrow\;b_{\sigma^2}\!\left(\hat\sigma^2_u\right)=0
\end{aligned}
$$
**Q.E.D.** ➔ $\hat\sigma^2_{ML}$ systematically **underestimates** the variance (it measures spread about $\bar y$, which sits closer to the data than $\mu$ does), and the bias vanishes as $n\to\infty$ ⟹ consistent.

## ⚖️ Core Decision Matrix
Comparing the two variance estimators for $Y_1,\dots,Y_n\sim N(\mu,\sigma^2)$:

| Estimator | Formula | Bias $b_{\sigma^2}$ | Variance | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| $\hat\sigma^2_{ML}$ | $\frac1n\sum_i(y_i-\bar y)^2$ | $-\dfrac{\sigma^2}{n}$ (underestimates) | $\mathrm{Var}_{\sigma^2}(\hat\sigma^2_{ML})$ | biased, but **less variable** |
| $\hat\sigma^2_u$ | $\frac{1}{n-1}\sum_i(y_i-\bar y)^2=\frac{n}{n-1}\hat\sigma^2_{ML}$ | $0$ for all $\sigma^2$ | $\left(\dfrac{n}{n-1}\right)^{\!2}\mathrm{Var}_{\sigma^2}(\hat\sigma^2_{ML})$ | unbiased, but **always more variable** |

> [!NOTE] **When It Flips:** $\hat\sigma^2_u>\hat\sigma^2_{ML}$ always, and unbiasedness is bought with strictly larger variance — so "unbiased" is **not** automatically "better"; only MSE settles it, and even that verdict depends on whether you asked about $\sigma^2$ or $\sigma$.

## ✍️ Practice
> [!QUESTION]- Practice 1: $\mathbf{X}=(X_1,\dots,X_{12})$ is a random sample from $X\sim Poi(\theta)$. Determine the bias of $\hat\theta_1=\bar X$, $\hat\theta_2=X_1$, $\hat\theta_3=\frac{1}{12}\sum_{i=1}^{12}X_i^2$.
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > E[\hat\theta_1]&=E[\bar X]=\frac{1}{12}\sum_{i=1}^{12}E[X_i]=\frac{1}{12}\sum_{i=1}^{12}\theta=\theta&&\Rightarrow b_\theta=0\;\text{(unbiased)}\\
> > E[\hat\theta_2]&=E[X_1]=\theta&&\Rightarrow b_\theta=0\;\text{(unbiased)}\\
> > E[X_i^2]&=V[X_i]+E[X_i]^2=\theta+\theta^2\;\Rightarrow\;E[\hat\theta_3]=\theta+\theta^2&&\Rightarrow b_\theta=\theta^2>0\;\text{(overestimates)}
> > \end{aligned}
> > $$
> > - **Key move:** rearrange $V[X]=E[X^2]-E[X]^2$ into $E[X^2]=V[X]+E[X]^2$, then use $Poi$'s $E=V=\theta$. A single observation $X_1$ is a perfectly **unbiased** estimator — unbiasedness alone says nothing about quality.

> [!QUESTION]- Practice 2: same setup. Compare $\mathrm{MSE}(\hat\theta_1)$ and $\mathrm{MSE}(\hat\theta_2)$ and state which is more efficient.
> > [!SUCCESS]- Reference solution
> > Both are unbiased, so $\mathrm{MSE}=\mathrm{Var}$:
> > $$
> > \begin{aligned}
> > \mathrm{MSE}(\hat\theta_1)&=V[\bar X]=\frac{V[X]}{12}=\frac{\theta}{12},\qquad
> > \mathrm{MSE}(\hat\theta_2)=V[X_1]=\theta\\
> > \mathrm{MSE}(\hat\theta_1)&<\mathrm{MSE}(\hat\theta_2)\;\Rightarrow\;\hat\theta_1=\bar X\text{ is }\textbf{more efficient}
> > \end{aligned}
> > $$
> > - **Key move:** $b=0$ collapses MSE to variance ➔ averaging 12 observations divides the variance by 12, which is the entire benefit of using the whole sample.

> [!QUESTION]- Practice 3: is $\hat\theta_3=\frac{1}{12}\sum X_i^2$ consistent for $\theta$? Justify with the two-condition test.
> > [!SUCCESS]- Reference solution
> > - **No.** $b_\theta(\hat\theta_3)=\theta^2$, which is **free of $n$** ➔ $b_\theta\not\to0$ as $n\to\infty$, so the bias condition fails regardless of what the variance does.
> > - **Key move:** the consistency test needs $b_\theta\to0$ **and** $\mathrm{Var}_\theta\to0$; a bias that does not shrink with sample size is fatal — more data buys precision around the **wrong** target ($\theta+\theta^2$).

> [!QUESTION]- Practice 4 *(Studio 4)*: for $Y_1,\dots,Y_n\sim Be(\theta)$ and $\hat\theta_{ML}=\frac1n\sum_i y_i$, derive the bias, variance and MSE, decide consistency, and state the large-$n$ distribution.
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > E[Y_i]=\theta,\quad V[Y_i]&=\theta(1-\theta) &&\text{(Bernoulli moments)}\\
> > E\!\left[\hat\theta_{ML}\right]=E[\bar Y]&=\theta &&\Rightarrow b_\theta\!\left(\hat\theta_{ML}\right)=0\ \textbf{(unbiased)}\\
> > \mathrm{Var}_\theta\!\left(\hat\theta_{ML}\right)&=\frac{V[Y_i]}{n}=\frac{\theta(1-\theta)}{n}\\
> > \mathrm{MSE}_\theta\!\left(\hat\theta_{ML}\right)&=0^2+\frac{\theta(1-\theta)}{n}=\frac{\theta(1-\theta)}{n}\\
> > \hat\theta_{ML}&\xrightarrow{d} N\!\left(\theta,\frac{\theta(1-\theta)}{n}\right) &&\text{(CLT, since } \hat\theta_{ML}\text{ is an average)}
> > \end{aligned}
> > $$
> > - **Key move:** recognise $\hat\theta_{ML}$ as a **sample mean**, which lets the generic $E[\bar Y]=\mu$, $V[\bar Y]=\sigma^2/n$ results fire with $\mu=\theta$ and $\sigma^2=\theta(1-\theta)$ — no Bernoulli-specific algebra is needed. **Consistent**: $b_\theta=0$ already and $\theta(1-\theta)/n\to0$.
> > - **Hint:** the variance is largest at $\theta=1/2$ and vanishes at $\theta\in\{0,1\}$ — precision depends on **where** in the parameter space you are, which is the same effect behind ML's boundary overconfidence. The interval built on this appears in [[Confidence Intervals]]; the *test* built on it swaps $\hat\theta$ for $\theta_0$ ➔ [[Tests for Bernoulli Populations]].

## ⚠️ Common Mistakes
- 💡 **"Unbiased ⟹ better"** ➔ $\hat\sigma^2_u$ is unbiased yet always has larger variance than $\hat\sigma^2_{ML}$; the comparison must go through MSE, and even then $\mathrm{MSE}=b^2+\mathrm{Var}$ can favour the biased estimator.
- 💡 **Claiming unbiasedness from one $\theta$** ➔ unbiased means $b_\theta(\hat\theta)=0$ for **all** $\theta$; bias is a *function* of the population parameter.
- 💡 **Transporting unbiasedness through a nonlinear map** ➔ $E[f(X)]\neq f(E[X])$ unless $f$ is linear, so $\sqrt{\hat\sigma^2_u}$ is a **biased** estimator of $\sigma$.
- 💡 **Confusing this with the prediction bias–variance tradeoff** ➔ here bias/variance are properties of an **estimator of a parameter** under repeated sampling; [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]] is about model **complexity** and held-out prediction error.
- 💡 **Reading $\mathrm{Var}\to0$ as consistency** ➔ both $b_\theta\to0$ *and* $\mathrm{Var}_\theta\to0$ are required; a fixed bias term never washes out.

## 🧠 Active Recall
> [!FAQ]- Why does the ML variance estimator underestimate $\sigma^2$, and why does the fix use $n-1$?
> > [!SUCCESS]- Answer
> > - **Short answer:** it measures spread about $\bar y$, and $\bar y$ is itself fitted to the data so it sits **closer to the sample than the true $\mu$ does** ➔ $E[\hat\sigma^2_{ML}]=\frac{n-1}{n}\sigma^2$, a deficit of exactly $\sigma^2/n$. Rescaling by $\frac{n}{n-1}$ cancels the factor.
> > - **Why:** **One degree of freedom is consumed by $\hat\mu$** ➔ in the derivation the cross term contributes $-n\,E[(\bar y-\mu)^2]=-n\cdot\frac{\sigma^2}{n}=-\sigma^2$, i.e. the sampling variance of the plugged-in mean is subtracted from the total.
> > - **Hint:** the bias is $O(1/n)$ ➔ irrelevant at $n=10^4$, material at $n=5$.

> [!FAQ]- Sample mean or sample median for the centre of a population? Both are unbiased under normality, so on what does the answer turn?
> > [!SUCCESS]- Answer
> > - **Short answer:** on **variance, and on whether the normal assumption actually holds**. With clean normal data the mean's MSE is about $27\%$ lower ($\mathrm{RelMSE}\approx0.73$ at $n=10$) because it uses every observation; contaminate even one point in ten with a $4\sigma$-wide draw and the ratio exceeds $1$ — the median wins.
> > - **Why:** **Efficiency and robustness are different questions** ➔ the median discards magnitude information (its value depends only on the central one or two order statistics), which costs precision on well-behaved data and buys immunity to outliers on badly-behaved data. Verified by simulation in [[Monte Carlo Estimator Comparison]].
> > - **Hint:** $\sigma$ cancels from $\mathrm{RelMSE}$; $n$ and the **contamination fraction** $n_c/n$ do not.

> [!FAQ]- Two estimators of $\theta$: one unbiased with variance $4\sigma^2$, one with bias $\sigma$ and variance $\sigma^2$. Which do you prefer, and what caveat must you state?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **biased** one — $\mathrm{MSE}=b^2+\mathrm{Var}$ gives $0+4\sigma^2=4\sigma^2$ against $\sigma^2+\sigma^2=2\sigma^2$, so the biased estimator is on average closer to $\theta$.
> > - **Why:** **MSE is the single decision metric**; unbiasedness is only decisive *among* unbiased estimators, where MSE reduces to variance (efficiency).
> > - **Caveat:** the verdict is **parameterisation-dependent** — rewriting $\theta$ as $\sqrt\theta$ or $1/\theta$ can reverse it, and a bias that does not shrink with $n$ also costs **consistency**.
