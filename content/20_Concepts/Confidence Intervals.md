---
unit: FIT2086
week: 4
source: [lecture]
domain: D
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [confidence interval, CI, interval estimation, interval estimator, coverage, standard error, z-interval, t-interval, CI for difference of means, approximate confidence interval]
---
# [[Confidence Intervals]]

**Context:** [[FIT2086_MOC]] · **interval** estimation — the second of the three inference tasks, after the point estimation of [[Maximum Likelihood Estimation]] · built entirely on the sampling distribution of $\hat\theta$ ([[Sampling Distribution of an Estimator]]), exactly where the population is normal and via [[Central Limit Theorem|the CLT]] everywhere else · the machinery reused next week for hypothesis testing

> [!abstract] Quick Revision
> - **🎯 Objective:** a **procedure** $T_\alpha(\mathbf{y})=(\hat\theta^-,\hat\theta^+)$ with $P\big(\theta\in T_\alpha(\mathbf{y})\big)=1-\alpha$ ➔ estimate $\pm$ (critical value) $\times$ (standard error).
> - **📦 Core Components:** known $\sigma^2$ ➔ $z_{\alpha/2}$ | unknown $\sigma^2$ ➔ $t_{\alpha/2,n-1}$ | difference of means ➔ variances **add** | non-normal population ➔ CLT approximation.
> - **⚡ Key Constraint:** the $1-\alpha$ guarantee attaches to the **procedure under repeated sampling**, never to the one interval you computed — $\theta$ is **fixed, not random**, so your interval either covers it or does not.

## 📝 Core
- **Point vs interval** ➔ point estimation returns one value $\hat\theta_{ML}(\mathbf{y})$; sampling randomness guarantees it is not exactly right, so **interval estimation** returns $T(\mathbf{y})=(\hat\theta^-(\mathbf{y}),\hat\theta^+(\mathbf{y}))\subset\mathbb{R}$ to **quantify the uncertainty**.
- **Width reads as uncertainty** ➔ narrow interval $\Rightarrow$ low uncertainty · wide interval $\Rightarrow$ high uncertainty.
- **Coverage definition** ➔ $T_\alpha$ is a $100(1-\alpha)\%$ confidence interval if $P\big(\theta\in T_\alpha(\mathbf{y})\big)=1-\alpha$, the probability taken **over samples from the population**: for $100(1-\alpha)\%$ of the samples you *could* have drawn, the generated interval covers the true $\theta$.
- **Frequentist reading, stated precisely** ➔ *before* sampling there is a $95\%$ chance of drawing a $\mathbf{y}$ whose interval covers $\theta$; *after* sampling the interval is fixed and either covers or does not — no probability remains to be assigned.
- **Standard error is the scale unit** ➔ $\mathrm{se}=\sqrt{V[\hat\theta]}$, i.e. $\sigma/\sqrt{n}$ for a sample mean with known variance and $\sqrt{v(\hat\theta)/n}$ in the approximate case; every interval below is $\hat\theta\pm(\text{critical value})\times\mathrm{se}$.
- **Critical values from the unit normal** ➔ $z_{\alpha/2}=Q(1-\alpha/2)$ with $Q$ the quantile function: $z_{0.025}\approx1.96$ ($\alpha=0.05$), $z_{0.005}\approx2.576$ ($\alpha=0.01$).
- **Three width drivers** ➔ width is **proportional to $\sigma$**, **inversely proportional to $\sqrt{n}$** (quartering the width costs $16\times$ the data), and **increases with the confidence level $1-\alpha$**.
- **Reporting template** ➔ *"The estimated mean BMI of diabetic Pima people ($n=8$) is $38.88\ \mathrm{kg/m^2}$. We are $95\%$ confident the population mean lies between $34.3$ and $43.47\ \mathrm{kg/m^2}$."* — estimate, then $n$, then the interval, then the population-level claim.

## 🧮 Proof Blueprint
**Theorem.** For $Y_1,\dots,Y_n\sim N(\mu,\sigma^2)$ with $\sigma^2$ **known**, $\left(\hat\mu_{ML}-z_{\alpha/2}\frac{\sigma}{\sqrt n},\;\hat\mu_{ML}+z_{\alpha/2}\frac{\sigma}{\sqrt n}\right)$ is a $100(1-\alpha)\%$ confidence interval for $\mu$.
**Strategy:** standardise the exact sampling distribution into $N(0,1)$, bracket it with symmetric percentiles, then **invert the inequalities onto $\mu$**.
$$
\begin{aligned}
\hat\mu_{ML}\equiv\bar Y &\sim N\!\left(\mu,\frac{\sigma^2}{n}\right) && \text{(exact: normal population)}\\
\frac{\hat\mu_{ML}-\mu}{\sigma/\sqrt n} &\sim N(0,1) && \text{(self-similarity; } \sigma/\sqrt n=\mathrm{se})\\
P\!\left(-1.96<\frac{\hat\mu_{ML}-\mu}{\sigma/\sqrt n}<1.96\right)&=0.95 && \text{(symmetry of } N(0,1))\\
P\!\left(-1.96\frac{\sigma}{\sqrt n}<\mu-\hat\mu_{ML}<1.96\frac{\sigma}{\sqrt n}\right)&=0.95 && \text{(multiply by } -\sigma/\sqrt n\text{; symmetry absorbs the flip)}\\
P\!\left(\hat\mu_{ML}-1.96\frac{\sigma}{\sqrt n}<\mu<\hat\mu_{ML}+1.96\frac{\sigma}{\sqrt n}\right)&=0.95 && \text{(add }\hat\mu_{ML})
\end{aligned}
$$**Q.E.D.** ➔ for $95\%$ of possible samples the population mean lies within $1.96\,\sigma/\sqrt n$ of the sample mean; replacing $1.96$ by $z_{\alpha/2}$ generalises to any $\alpha$.

## ⚖️ Which Interval Fires
| Case | Population assumptions | Interval | Critical value | Coverage |
| :--- | :--- | :--- | :--- | :--- |
| **1. Normal mean, $\sigma^2$ known** | $Y_i\sim N(\mu,\sigma^2)$, $\sigma^2$ given | $\hat\mu_{ML}\pm z_{\alpha/2}\dfrac{\sigma}{\sqrt n}$ | $z_{\alpha/2}$ | **exact** at every $n$ |
| **2. Normal mean, $\sigma^2$ unknown** | $Y_i\sim N(\mu,\sigma^2)$, use $\hat\sigma^2_u=\frac{1}{n-1}\sum_i(y_i-\hat\mu_{ML})^2$ | $\hat\mu_{ML}\pm t_{\alpha/2,n-1}\dfrac{\hat\sigma_u}{\sqrt n}$ | $t_{\alpha/2,n-1}$ ([[Student-t Distribution]]) | **exact** if population normal |
| **3. Difference of two means** | independent samples $A,B$; $\mu_A,\mu_B,\sigma_A^2,\sigma_B^2$ all unknown | $(\hat\mu_A-\hat\mu_B)\pm z_{\alpha/2}\sqrt{\dfrac{\hat\sigma_A^2}{n_A}+\dfrac{\hat\sigma_B^2}{n_B}}$ | $z_{\alpha/2}$ | **approximate**, improving with $n_A,n_B$ |
| **4. Any sample-mean estimator** | $E[Y_i]=\theta$, $V[Y_i]=v(\theta)$ only; $\hat\theta=\bar Y$ | $\hat\theta\pm z_{\alpha/2}\sqrt{\dfrac{v(\hat\theta)}{n}}$ | $z_{\alpha/2}$ | **approximate** via the CLT |

> [!NOTE] **When It Flips:** Case 1 collapses into Case 2 the moment $\sigma^2$ is estimated from the same data — and $t_{\alpha/2,n-1}>z_{\alpha/2}$ always, so the honest interval is the wider one. Case 4 subsumes Case 3's logic for non-normal populations: with $Y_i\sim Poi(\lambda)$, $v(\lambda)=\lambda$ gives $\hat\lambda_{ML}\pm z_{\alpha/2}\sqrt{\hat\lambda_{ML}/n}$.

## 📊 Worked Examples — Pima BMI
Diabetic sample $\mathbf{y}_D=(53.2,33.6,36.6,42.0,33.3,37.8,31.2,43.4)$, $n=8$ ➔ $\hat\mu_D=38.88$, $\hat\sigma^2_{u,D}=\frac17\sum_i(y_i-38.88)^2\approx51.37$.
Non-diabetic sample $\mathbf{y}_N=(34.0,28.9,29.0,45.4,53.2,29.0,36.5,32.9)$, $n=8$ ➔ $\hat\mu_N=36.11$, $\hat\sigma^2_{u,N}\approx78.05$.

| Case | Inputs | Computation | Interval |
| :--- | :--- | :--- | :--- |
| **1** — $\sigma^2=43.75$ known (external study) | $z_{0.025}=1.96$ | $38.88\pm1.96\sqrt{43.75/8}=38.88\pm4.58$ | $(34.30,\,43.47)$ |
| **2** — $\sigma^2$ unknown | $t_{0.025,7}=2.36$ | $38.88\pm2.36\sqrt{51.37/8}=38.88\pm5.98$ | $(32.90,\,44.86)$ |
| **3** — difference $\mu_N-\mu_D$ | $\hat\mu_N-\hat\mu_D=-2.77$ | $-2.77\pm1.96\sqrt{\tfrac{78.05}{8}+\tfrac{51.37}{8}}=-2.77\pm7.88$ | $(-10.65,\,5.11)$ |

**Final extracted output:** Case 2 is $30\%$ wider than Case 1 on identical data — the cost of not knowing $\sigma^2$. Case 3's interval **contains zero**, so a population-level difference in BMI between diabetic and non-diabetic Pima people **cannot be ruled out either way**.

## 🎯 Reading a Difference Interval
- **Entirely negative** ➔ suggestive of a genuine **negative** difference at the population level ($\mu_A<\mu_B$).
- **Entirely positive** ➔ suggestive of a genuine **positive** difference ($\mu_A>\mu_B$).
- **Contains zero** ➔ $\mu_A=\mu_B$ is **compatible with the data** — report "cannot rule out no difference", which is *not* evidence that the difference is zero.
- **Why variances add, not subtract** ➔ independence of the two samples gives $V[\hat\mu_A-\hat\mu_B]=V[\hat\mu_A]+V[\hat\mu_B]=\frac{\sigma_A^2}{n_A}+\frac{\sigma_B^2}{n_B}$; the minus sign in the estimate never reaches the variance.

## ⚠️ Common Mistakes
- 💡 **"There is a $95\%$ probability that $\mu$ lies in $(34.3,43.47)$"** ➔ the classic mark-loser: $\mu$ is a **fixed constant**, not an RV, so this interval has no probability attached. Say "we are $95\%$ confident", meaning $95\%$ of samples produce covering intervals.
- 💡 **Keeping $z_{\alpha/2}$ after estimating $\sigma^2$** ➔ $\frac{\hat\mu_{ML}-\mu}{\hat\sigma_u/\sqrt n}$ is $t(n-1)$, not $N(0,1)$; the $z$ interval **undercovers** — it is narrower than $95\%$ honesty allows.
- 💡 **Using $\hat\sigma^2_{ML}$ (divisor $n$) in Case 2 or 3** ➔ these intervals are built on the **unbiased** $\hat\sigma^2_u$ (divisor $n-1$); the ML variance is biased low, shrinking the interval further.
- 💡 **Adding standard deviations for a difference** ➔ $\sqrt{\frac{\hat\sigma_A^2}{n_A}}+\sqrt{\frac{\hat\sigma_B^2}{n_B}}$ overstates the standard error; add the **variances**, then take one square root.
- 💡 **Forgetting the interval is only as good as the model** ➔ Cases 1–2 need population normality and Cases 3–4 need $n$ large enough for the CLT; misspecification does not shrink with $n$.

## 🧠 Active Recall
> [!FAQ]- You compute a $95\%$ CI of $(34.3,43.47)$. Why is "$\mu$ has a $95\%$ chance of being in here" wrong, and what *is* the right statement?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mu$ is a **fixed population constant**; once $\mathbf{y}$ is observed the interval is fixed too, so it either covers $\mu$ or it does not — nothing is random any more. Correct: *the procedure* generates covering intervals for $95\%$ of possible samples.
> > - **Why:** **The probability is over samples, not parameters** ➔ $P(\theta\in T_\alpha(\mathbf{y}))=1-\alpha$ has $\mathbf{y}$ as the random object. This is the frequentist commitment; assigning probability to $\theta$ itself requires a Bayesian prior, which FIT2086 does not use here.

> [!FAQ]- Two analysts use the same $n=8$ Pima sample. One reports $(34.30,43.47)$, the other $(32.90,44.86)$. Neither made an arithmetic error — what differs, and which should be published?
> > [!SUCCESS]- Answer
> > - **Short answer:** the first **assumed $\sigma^2=43.75$ known** from an external study and used $z_{0.025}=1.96$; the second **estimated** $\hat\sigma^2_u=51.37$ from the eight points and used $t_{0.025,7}=2.36$. With no external variance available, the $t$ interval is the defensible one.
> > - **Why:** **Two sources of uncertainty demand two corrections** ➔ estimating $\sigma^2$ inflates the interval twice over — a larger scale ($\hat\sigma_u>\sigma$ here) *and* a larger multiplier ($2.36>1.96$) — which is precisely what restores $95\%$ coverage.

> [!FAQ]- The Poisson rate estimator $\hat\lambda_{ML}$ has no exactly-normal sampling distribution. How do you still put a $95\%$ interval on it?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\hat\lambda_{ML}=\bar Y$ is a **sample mean**, so the CLT gives $\hat\lambda_{ML}\xrightarrow{d}N(\lambda,\lambda/n)$; substituting $v(\hat\lambda)=\hat\lambda_{ML}$ for the unknown $v(\lambda)$ yields the approximate interval $\hat\lambda_{ML}\pm1.96\sqrt{\hat\lambda_{ML}/n}$.
> > - **Why:** **The plug-in standard error is the general recipe** ➔ for any $\hat\theta=\bar Y$ with $V[Y_i]=v(\theta)$, $\sqrt{v(\hat\theta)/n}$ is the standard error and the interval is $\hat\theta\pm z_{\alpha/2}\,\mathrm{se}$; the coverage is only **approximate** and improves with $n$.
