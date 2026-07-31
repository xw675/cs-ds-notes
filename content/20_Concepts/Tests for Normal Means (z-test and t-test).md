---
unit: FIT2086
week: 5
source: [lecture]
domain: D
parent: "[[Hypothesis Testing]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [z-test, t-test, one-sample t-test, two-sample z-test, testing a population mean, difference of means test, t-score, z-score, pooled variance t-test, Welch test]
---
# [[Tests for Normal Means (z-test and t-test)]]

**Context:** [[FIT2086_MOC]] · the **case selection** layer of [[Hypothesis Testing]] — one sample or two, $\sigma^2$ known or estimated · same four-way split as [[Confidence Intervals]], because each test statistic is the CI's pivot re-centred on the null · $t$ critical values from [[Student-t Distribution]]

> [!abstract] Quick Revision
> - **🎯 Objective:** identify (samples, $\sigma^2$ status, $n$) ➔ pick the statistic ➔ read the tail of $N(0,1)$ or $T(\nu)$ ➔ grade the evidence.
> - **📦 Core Components:** $\sigma^2$ known ➔ $z$ | $\sigma^2$ unknown & $n<30$ normal ➔ $t_{n-1}$ | $\sigma^2$ unknown & $n>30$ ➔ approximate $z$ | two samples ➔ variances **add**.
> - **⚡ Key Constraint:** every statistic is $\dfrac{\text{estimate}-\text{null value}}{\text{standard error}}$ — the only thing that changes across cases is **which standard error** and **which reference distribution**.

## 📝 Core
- **Universal shape** ➔ $\text{statistic}=\dfrac{\hat\mu-\mu_0}{\mathrm{se}}$; the case table below is entirely a table of standard errors and reference distributions.
- **Unknown variance costs a distribution** ➔ substituting the **unbiased** $\hat\sigma^2=\frac{1}{n-1}\sum_i(y_i-\hat\mu)^2$ makes the denominator random too, so the statistic follows $T(n-1)$, not $N(0,1)$.
- **Large $n$ buys back normality** ➔ for $n>30$ from **any** distribution the [[Central Limit Theorem|CLT]] makes $\hat\mu$ approximately normal and $\hat\sigma^2$ nearly exact, so the $z$ form returns as an approximation.
- **Two samples, one difference** ➔ $H_0:\mu_x=\mu_y$ is restated as $\mu_x-\mu_y=0$, so the estimate under test is $\hat\mu_x-\hat\mu_y$ with null mean **zero**.
- **Independence makes variances add** ➔ $\hat\mu_x-\hat\mu_y\sim N\!\left(0,\frac{\sigma_x^2}{n_x}+\frac{\sigma_y^2}{n_y}\right)$ under the null; the minus sign never reaches the variance.
- **Direction is a relabelling** ➔ testing $\mu_x>\mu_y$ is identical to testing $\mu_y<\mu_x$, so only one one-sided formula is needed.
- **Exact two-sample procedures exist** ➔ more precise but more complicated methods handle unknown, unequal variances; `t.test()` implements several ➔ [[R Toolkit (Cheatsheet)]].

## ⚖️ Case Selection Matrix
| Case | Assumptions | Test statistic | Null distribution | $\mathrm{se}$ |
| :--- | :--- | :--- | :--- | :--- |
| **1. One sample, $\sigma$ known** | normal population (any $n$), **or** $n>30$ from any distribution; independent | $z_{\hat\mu}=\dfrac{\hat\mu-\mu_0}{\sigma/\sqrt n}$ | $N(0,1)$ **exact** | $\sigma/\sqrt n$ |
| **2. One sample, $\sigma$ unknown, $n<30$** | **normal** population; independent | $t_{\hat\mu}=\dfrac{\hat\mu-\mu_0}{\hat\sigma/\sqrt n}$ | $T(n-1)$ **exact** | $\hat\sigma/\sqrt n$ |
| **3. One sample, $\sigma$ unknown, $n>30$** | any distribution; independent | $z_{\hat\mu}=\dfrac{\hat\mu-\mu_0}{\hat\sigma/\sqrt n}$ | $N(0,1)$ **approximate** | $\hat\sigma/\sqrt n$ |
| **4. Two samples, $\sigma_x,\sigma_y$ known** | both normal (any $n$), **or** $n>30$; independent | $z_{(\hat\mu_x-\hat\mu_y)}=\dfrac{\hat\mu_x-\hat\mu_y}{\sqrt{\sigma_x^2/n_x+\sigma_y^2/n_y}}$ | $N(0,1)$ **exact** | $\sqrt{\sigma_x^2/n_x+\sigma_y^2/n_y}$ |
| **5. Two samples, $\sigma$ unknown, large $n$** | $n_x,n_y>30$, any distribution; independent | $z_{(\hat\mu_x-\hat\mu_y)}=\dfrac{\hat\mu_x-\hat\mu_y}{\sqrt{\hat\sigma_x^2/n_x+\hat\sigma_y^2/n_y}}$ | $N(0,1)$ **approximate** | $\sqrt{\hat\sigma_x^2/n_x+\hat\sigma_y^2/n_y}$ |

**$p$-value from any of the above** ➔ substitute the statistic $s$ and its reference RV $W$ ($Z$ or $T$) into the three-way rule of [[Hypothesis Testing]]: two-sided $2P(W<-\lvert s\rvert)$ · upper $1-P(W<s)$ · lower $P(W<s)$.

> [!NOTE] **When It Flips:** Case 1 becomes Case 2 the instant $\sigma^2$ is computed from the same data, and $t_{\alpha/2,n-1}>z_{\alpha/2}$ always ⟹ the honest $p$ is the **larger** one. Case 2 relaxes into Case 3 around $n\approx30$, where $T(n-1)\to N(0,1)$ makes the choice immaterial.

### 🔭 Beyond the lecture *(flagged "optional extra" on the slides — small-$n$ two-sample $t$)*
- **Equal variances assumed** ➔ pool them: $\hat\sigma_p=\sqrt{\dfrac{\hat\sigma_x^2(n_x-1)+\hat\sigma_y^2(n_y-1)}{n_x+n_y-2}}$, then $t=\dfrac{\hat\mu_x-\hat\mu_y}{\hat\sigma_p\sqrt{1/n_x+1/n_y}}\sim T(n_x+n_y-2)$.
- **Unequal variances (Welch)** ➔ $t=\dfrac{\hat\mu_x-\hat\mu_y}{\sqrt{\hat\sigma_x^2/n_x+\hat\sigma_y^2/n_y}}\sim T(\mathrm{df})$ with the Welch–Satterthwaite $\mathrm{df}=\dfrac{\left(\hat\sigma_x^2/n_x+\hat\sigma_y^2/n_y\right)^2}{\dfrac{(\hat\sigma_x^2/n_x)^2}{n_x-1}+\dfrac{(\hat\sigma_y^2/n_y)^2}{n_y-1}}$.

## 📊 Worked Example Bank
| Scenario | $H_0$ vs $H_A$ | Inputs | Statistic | $p$-value | Verdict |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Ohm's law** — measured voltage | $\mu=1$ vs $\mu\neq1$ | $n=6$, $\hat\mu=1.0715$, $\sigma=0.125$ | $z=\frac{0.0715}{0.125/\sqrt6}=1.4011$ | $2P(Z<-1.4011)=0.1612$ | $\approx1$ in $6$ by chance ➔ **weak** evidence; data not incompatible with Ohm |
| **"Schmidt's law"** — same data, $V=1.5IR$ | $\mu=1.5$ vs $\mu\neq1.5$ | $n=6$, $\hat\mu=1.0715$, $\sigma=0.125$ | $z=\frac{-0.4285}{0.125/\sqrt6}\approx-8.36$ | $\approx4.5\times10^{-17}$ | **very strong** evidence against |
| **Bear weights** *(Case 1, one-sided lower)* | $\mu=200$ vs $\mu<200$ | $n=54$, $\hat\mu=182.9$, $\sigma=121.8$ | $z=\frac{-17.1}{121.8/\sqrt{54}}=-1.03$ | $P(Z<-1.03)=0.1515$ | do **not** reject ➔ mean weight not shown to be $<200$ lb |
| **Algebra scores** *(Case 1, one-sided upper)* | $\mu=75$ vs $\mu>75$ | $n=25$, $\hat\mu=78.2$, $\sigma=8.25$ | $z=\frac{3.2}{8.25/\sqrt{25}}=1.94$ | $1-P(Z<1.94)=0.0262$ | **moderate** evidence ➔ new system improves scores |
| **$t$-test (i)** *(Case 2, two-sided)* | $\mu=24.5$ vs $\mu\neq24.5$ | $n=15$, $\sum y_i=389$, $\sum y_i^2=10197$ | $t=\frac{25.933-24.5}{\sqrt{7.781}/\sqrt{15}}=1.990$, $\nu=14$ | $2P(T>1.990)=0.0702$ | insufficient evidence to reject |
| **$t$-test (ii)** *(same data, one-sided)* | $\mu=24.5$ vs $\mu>24.5$ | as above | $t=1.990$, $\nu=14$ | $P(T>1.990)=0.0351$ | **moderate** evidence ➔ reject in favour of $H_A$ |
| **Graduate salaries** *(Case 4, one-sided)* | $\mu_x-\mu_y=0$ vs $>0$ | $\hat\mu_x=24604,\hat\mu_y=17129$; $\sigma_x=3350,\sigma_y=3270$; $n_x=200,n_y=210$ | $z=\frac{7475}{327.16}=22.85$ | $P(Z>22.85)\approx0$ | reject ➔ men's mean salary higher |
| **Repair costs** *(Case 5, two-sided)* | $\mu_x-\mu_y=0$ vs $\neq0$ | $\hat\mu_x=3300,\hat\mu_y=3850$; $\hat\sigma_x=800,\hat\sigma_y=1000$; $n_x=45,n_y=51$ | $z=\frac{-550}{183.93}=-2.99$ | $2P(Z>2.99)=0.00278$ | **strong** evidence ➔ mean repair costs differ |
| **Blood pressure** *(Case 2, two-sided; Studio 5)* | $\mu=120$ vs $\mu\neq120$ | $n=20$, $\hat\mu=114$, $\hat\sigma_u=5.429$ | $t=\frac{-6}{5.429/\sqrt{20}}=-4.943$, $\nu=19$ | $9.0\times10^{-5}$ | **very strong** ➔ sample does not come from an "at risk" ($120$–$139$ mmHg) population |
| **Blood pressure** *(same data, one-sided lower)* | $\mu\ge120$ vs $\mu<120$ | as above | $t=-4.943$, $\nu=19$ | $4.5\times10^{-5}$ *(exactly half)* | **very strong** ➔ the stronger claim: the population is **healthy**, not merely "not at risk" |

**Final extracted output:** the same $t=1.990$ produces $p=0.0702$ (weak) two-sided and $p=0.0351$ (moderate) one-sided — the alternative, not the data, moved the verdict across the conventional threshold. This is why $H_A$ must be fixed before the sample is seen.

### Derivation trace — the $t$-test example by hand
$$
\begin{aligned}
\hat\mu &= \frac{1}{n}\sum_i y_i = \frac{389}{15} = 25.933\\
\hat\sigma^2 &= \frac{1}{n-1}\left(\sum_i y_i^2-\frac{\left(\sum_i y_i\right)^2}{n}\right) = \frac{1}{14}\left(10197-\frac{389^2}{15}\right) = 7.781\\
\mathrm{se} &= \frac{\hat\sigma}{\sqrt n} = \frac{2.789}{\sqrt{15}} = 0.720\\
t_{\hat\mu} &= \frac{25.933-24.5}{0.720} = 1.990 \quad\text{with } \nu=n-1=14
\end{aligned}
$$
**Final extracted output:** $t_{0.05,14}=1.7613$ and $t_{0.025,14}=2.1448$ bracket $1.990$, so the one-sided $p$ lies between $0.025$ and $0.05$ — consistent with the tabulated $0.0351$ and enough to place the evidence as **moderate** without a computer.

### Three routes to one difference — S&P 500 pre/post-Lehman *(Studio 5)*
$\hat\mu_{pre}=1381.703$, $\hat\sigma^2_{pre}=9383.026$, $n_{pre}=58$; $\hat\mu_{post}=886.916$, $\hat\sigma^2_{post}=7002.371$, $n_{post}=50$; $H_0:\mu_{pre}=\mu_{post}$.
$$
\begin{aligned}
\text{diff} &= 1381.703-886.916 = 494.787\\
\mathrm{se}_{\text{diff}} &= \sqrt{\frac{9383.026}{58}+\frac{7002.371}{50}} = 17.373\\
z &= \frac{494.787}{17.373} = 28.48
\end{aligned}
$$

| Route | Statistic | $p$-value | $95\%$ CI for $\mu_{pre}-\mu_{post}$ |
| :--- | :--- | :--- | :--- |
| **Approximate $z$** (Case 5, by hand) | $z=28.48$ | $2P(Z<-28.48)\approx2\times10^{-178}$ | $(460.74,\ 528.84)$ ➔ **narrowest** |
| **Welch $t$** (`var.equal = FALSE`, the default) | $t=28.48$ | $\approx1.8\times10^{-51}$ | $(460.34,\ 529.23)$ |
| **Pooled $t$** (`var.equal = TRUE`) | $t=28.17$ | $\approx4.9\times10^{-51}$ | $(459.97,\ 529.61)$ ➔ **widest** |

**Final extracted output:** all three reach the same verdict — the difference of $494.787$ dwarfs its standard error of $17.373$, so the observed gap is essentially impossible under "the bank collapse and the economy are unassociated". The **intervals** are what separate the routes: the approximate $z$ is narrowest because it treats $\hat\sigma^2_{pre},\hat\sigma^2_{post}$ as if they were **known**, so it is slightly **overconfident**; pooling is widest here because the two variances are in fact quite different ($9383$ vs $7002$), so forcing a common variance is the wrong assumption. Do **not** compare the raw $p$ magnitudes across routes — $N(0,1)$ has far thinner tails than $T(\nu)$, so the $z$ route reports an absurdly smaller number for the same evidence.

## ⚠️ Common Mistakes
- 💡 **Using $z$ after estimating $\sigma^2$ at small $n$** ➔ the reference distribution is $T(n-1)$, whose tails are heavier, so the $z$ tail **understates** $p$ and manufactures evidence — the same error that makes a $z$ interval undercover.
- 💡 **Feeding $\hat\sigma^2_{ML}$ (divisor $n$) into the $t$-statistic** ➔ the $t$ result is derived for the **unbiased** $\hat\sigma^2$ with divisor $n-1$ ([[Estimator Quality (Bias, Variance, MSE)]]); the ML version shrinks $\mathrm{se}$ and inflates $\lvert t\rvert$.
- 💡 **$\nu=n$ instead of $n-1$** ➔ one degree of freedom is spent estimating $\mu$ inside $\hat\sigma^2$; at $n=15$ that is $T(14)$.
- 💡 **Adding standard deviations for a difference** ➔ $\sqrt{\hat\sigma_x^2/n_x}+\sqrt{\hat\sigma_y^2/n_y}$ overstates $\mathrm{se}$; add the **variances**, then take one square root.
- 💡 **Dividing the two-sample difference by a single $\sigma/\sqrt n$** ➔ each sample contributes its own $\sigma_i^2/n_i$; the sample sizes $n_x,n_y$ need not be equal.

## 🧠 Active Recall
> [!FAQ]- A question gives $n=54$, $\hat\mu=182.9$, and states "$\sigma$ is known to be $121.8$". Why is this a $z$-test and not a $t$-test, and would the answer change if $\sigma$ had been estimated?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\sigma$ is supplied externally, so the denominator $\sigma/\sqrt n$ is a **constant** and the standardised statistic is exactly $N(0,1)$ — Case 1. Had it been estimated, the statistic would be $T(53)$; but with $n=54>30$, $T(53)\approx N(0,1)$, so the numerical $p$ would barely move.
> > - **Why:** **Randomness in the denominator is what creates $t$** ➔ $T(\nu)\to N(0,1)$ as $\nu\to\infty$ ([[Student-t Distribution]]), so the distinction is only material at small $n$; the exam trap is applying $z$ at small $n$, not at large.

> [!FAQ]- Both salary and repair-cost examples compare two means, yet one uses $\sigma_x,\sigma_y$ and the other $\hat\sigma_x,\hat\sigma_y$. Which is exact, and why is the other still allowed to use $N(0,1)$?
> > [!SUCCESS]- Answer
> > - **Short answer:** the salary test (Case 4) has **known** population standard deviations, so $\hat\mu_x-\hat\mu_y$ is exactly normal and $z$ is exact. The repair-cost test (Case 5) substitutes estimates, which is only justified because $n_x=45$ and $n_y=51$ are large enough for the CLT to make the substitution approximately harmless.
> > - **Why:** **Plug-in standard errors are a large-sample licence** ➔ $\hat\sigma^2\to\sigma^2$ as $n$ grows, so the substituted statistic is *approximately* $N(0,1)$; at small $n$ this licence expires and the pooled or Welch $t$ procedures are needed.

> [!FAQ]- Under $H_0:\mu_x=\mu_y$, why is the null variance $\frac{\sigma_x^2}{n_x}+\frac{\sigma_y^2}{n_y}$ rather than a difference of variances?
> > [!SUCCESS]- Answer
> > - **Short answer:** the two samples are **independent**, so $V[\hat\mu_x-\hat\mu_y]=V[\hat\mu_x]+V[(-1)\hat\mu_y]=V[\hat\mu_x]+(-1)^2V[\hat\mu_y]$ — the sign is squared away and the uncertainties accumulate.
> > - **Why:** **Subtracting estimates adds noise, never cancels it** ➔ each estimate carries its own sampling error, so the difference is *less* precise than either mean; only the null **mean** becomes zero, never the null **variance**.
