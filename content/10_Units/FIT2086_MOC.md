---
unit: FIT2086
type: MOC
tags: [DataScience/Modelling, Tool/R]
---
# 📘 FIT2086: Modelling for Data Analysis

> [!INFO] Map of Content
> Index for **FIT2086 Modelling for Data Analysis** — the **statistics spine** of the DS degree. Much of Week 0–1 is **revision** shared dual-unit with [[FIT1058_MOC]] (probability) and [[FIT1043_MOC]] (descriptive statistics, R) rather than duplicated.

## 📊 Assessment Map
- **Assignment 1 (10%, due W5)** · **Assignment 2 (20%, due W8)** · **Assignment 3 (20%, due W11)** ➔ carry the whole in-semester half; **all involve implementing models in R (LO5)**.
- **Final exam (50%)**
- **LO map** ➔ LO1 EDA/descriptive (W1–2) · LO2 inferential models (W3–5) · LO3 predictive models (W6–9, W11) · LO4 sampling/simulation/testing (W3, W5, W10) · LO5 implement in R (W6–11) · LO6 interpret results (W4–11).
- **LO thread so far** ➔ frame data via probability models; manipulate random variables (pmf/pdf/cdf, joint/marginal/conditional/iid); summarise them by expectations; name the parametric families — then **fit** them by maximum likelihood (W3), **judge the fit** by bias/variance/MSE, and **bound the estimate** by a confidence interval (W4). **A1 (due W5) sits directly on W3–4 estimation.**

## 🧰 Toolkit Cheatsheets
- [[R Toolkit (Cheatsheet)]] -> dual-unit (FIT1043 + FIT2086); FIT2086 adds the simulation / distribution (`d`/`p`/`q`/`r`) block plus the `qnorm`/`qt` critical-value rows

## 📅 Knowledge Index

### Week 0 — Self-Study / Revision
- [[Measures of Centrality]] -> Parent Framework: [[Statistical Modelling and Inference]] *(dual-unit — statistic $s(\mathbf{y})$ framing)*
- [[Measures of Spread and Boxplots]] -> Parent Framework: [[Statistical Modelling and Inference]] *(dual-unit — variance $v(\mathbf{y})$, percentile $Q(\mathbf{y},p)$)*
- [[Association Between Variables]] -> Parent Framework: [[Statistical Modelling and Inference]] *(dual-unit — Pearson $R(\mathbf{x},\mathbf{y})$, correlation ≠ causation)*
- [[Mathematics for Modelling (Log, Exp, Calculus)]] -> Parent Framework: [[Statistical Modelling and Inference]] *(log/exp/derivative/partial — the MLE toolkit)*
- [[R Basics (Syntax, Types, Control Flow)]], [[R Vectors]], [[R Data Frames and IO]], [[R Visualisation (base graphics)]] + the cheatsheet.

### Week 1 — Modelling, Probability & Random Variables 
- [[Statistical Modelling and Inference]] -> Parent Framework: [[FIT2086_MOC]] *(hub: population/sample/model/inference)*
- [[Random Variables and Probability Distributions (FIT2086)]] -> Parent Framework: [[Statistical Modelling and Inference]] *(**exam-heavy**: pmf/pdf/cdf/quantile/mode; joint→marginal→conditional; iid)*
- [[R Simulation and Random Sampling]] -> Parent Framework: [[R for Data Science]] *( `set.seed`, `sample`, `d`/`p`/`q`/`r`)*
- *(Cross-links to the FIT1058 probability cluster: [[Random Variable]], [[Conditional Probability]], [[Bayes' Theorem]], [[Expectation]], [[Variance and Standard Deviation]], [[Binomial Distribution]], [[Poisson Distribution]], [[Uniform Distribution]] — the maths lives there, deepened here for modelling.)*

### Week 2 — Expectations & Probability Distributions
- [[Expectations and Covariance (FIT2086)]] -> Parent Framework: [[Random Variables and Probability Distributions (FIT2086)]] *(**exam-heavy**: $E[f(X)]$, linearity, $V=E[X^2]-E[X]^2$, cov/corr, WLLN, non-existence)*
- [[Taylor Approximation of Expectations]] -> Parent Framework: [[Expectations and Covariance (FIT2086)]] *(**derivation drill** — 2nd order for $E$, 1st order for $V$)*
- [[Parametric Probability Distributions]] -> Parent Framework: [[Statistical Modelling and Inference]] *(hub: $p(x\mid\theta)$, $\theta\in\Theta$ + the distribution zoo tables)*
- [[Gaussian Distribution]] -> Parent Framework: [[Parametric Probability Distributions]] *(self-similarity, $\sigma$-rules, additivity)*
- [[Binomial Distribution]] — $Be(\theta)$/$Bin(\theta,n)$, additivity in $n$; [[Poisson Distribution]] — rate $\lambda$, additivity + thinning $Poi(\lambda/k)$, the four appropriateness conditions; [[Uniform Distribution]] — the **continuous** $U(a,b)$ with $V=\tfrac{(b-a)^2}{12}$.

#### Studio 1 *(run in W2 — R foundations, `heart.csv` / `Mushroom.csv` / `wine.csv`)*
- [[Categorical Summaries and Cross-Tabulation in R]] -> Parent Framework: [[R for Data Science]] *(`factor`/`table`/`prop.table`/`pie` — the cat–cat toolkit)*
- [[R Basics (Syntax, Types, Control Flow)]] — user-defined **functions**, `list` returns, `stop`, `cat`, `ls`/`rm`/`source`; [[R Data Frames and IO]] — **logical referencing**, add/drop columns, `stringsAsFactors`; [[Association Between Variables]] — the `cor` screening loop over `wine.csv`.

### Week 3 — Parameter Estimation, Maximum Likelihood & Estimator Quality
- [[Maximum Likelihood Estimation]] -> Parent Framework: [[Statistical Modelling and Inference]] *(**exam-heavy derivation drill** — likelihood → NLL → $\partial L/\partial\theta=0$; Gaussian, Poisson, Exponential, power families; plug-in distribution)*
- [[Sampling Distribution of an Estimator]] -> Parent Framework: [[Statistical Modelling and Inference]] *($\hat\theta$ is an RV; $\bar Y\sim N(\mu,\sigma^2/n)$; strength-of-assumptions ladder)*
- [[Estimator Quality (Bias, Variance, MSE)]] -> Parent Framework: [[Sampling Distribution of an Estimator]] *(**exam-heavy**: $b_\theta$, $\mathrm{Var}_\theta$, $\mathrm{MSE}=b^2+\mathrm{Var}$, efficiency, $\hat\sigma^2_{ML}$ vs $\hat\sigma^2_u$, consistency)*
- *(Reading: Ross Ch. 6 §6.1, 6.2, 6.4, 6.5 and Ch. 7 §7.1, 7.2, 7.7)*

#### Studio 2 *(run in W3 — drills the W2 distributions; **no new notes**, merged into the existing four)*
- [[Gaussian Distribution]] — **$z$-table lookup with linear interpolation** ($X\sim N(3,16)$ worked three ways); $Z_{\mu+k\sigma}=k$ is why the $\sigma$-rules are scale-free
- [[Binomial Distribution]] — term-by-term pmf interpretation; a *named sequence* has no $\binom{n}{m}$; fair-coin tails by hand
- [[Poisson Distribution]] — additivity run **backwards** ($\lambda=6$/week ➔ $\lambda_i=6/7$/day); "at least one" $=1-e^{-\lambda}$
- [[Uniform Distribution]] — cdf derivation, $E[X]$ by integration, out-of-support probabilities are **zero**
- [[Parametric Probability Distributions]] — the **family selection drill** (15 described variables ➔ verdict + reason)
- [[R Simulation and Random Sampling]] — $O(n)$ **running-mean** accumulator + the WLLN convergence plot; why $\theta=0.9$ converges faster than $\theta=0.5$

### Week 4 — Central Limit Theorem & Confidence Intervals
- [[Central Limit Theorem]] -> Parent Framework: [[Sampling Distribution of an Estimator]] *(**exam-heavy**: $\sum Y_i\xrightarrow{d}N(n\mu,n\sigma^2)$ ➔ $\bar Y\xrightarrow{d}N(\mu,\sigma^2/n)$; normal approximation to $Bin$/$Poi$; asymptotic normality of averages)*
- [[Confidence Intervals]] -> Parent Framework: [[Statistical Modelling and Inference]] *(**exam-heavy**: coverage vs the wrong "$95\%$ probability" reading; the four cases $z$ / $t$ / difference / CLT-approximate)*
- [[Student-t Distribution]] -> Parent Framework: [[Parametric Probability Distributions]] *($\nu=n-1$, heavier tails, $t_{\alpha/2,\nu}>z_{\alpha/2}$ always)*
- *(Reading: Ross Ch. 6 §6.3 and Ch. 7 §7.3, 7.4, 7.5)*

### 🔭 Coming later in the unit *(from the unit outline — no notes yet)*
- **W5 next:** hypothesis testing ($p$-values, type I/II errors) *(the direct sequel — same sampling-distribution machinery, inverted)*.
- Multivariate Gaussian, Dirichlet · random sampling, simulation & the **bootstrap** · hypothesis testing (p-values, type I/II errors) · exploratory vs confirmatory analysis · linear & logistic regression · Bayesian classification & inverse probability · cross-validation & model-performance estimation.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = assessment-critical)*

- **W0 — revision:** [[Measures of Centrality]] → [[Measures of Spread and Boxplots]] → [[Association Between Variables]] → **[[Mathematics for Modelling (Log, Exp, Calculus)]]** *(needed for every MLE derivation)*
- **W1 — modelling & probability:** **[[Statistical Modelling and Inference]]** *(the hub)* → **[[Random Variables and Probability Distributions (FIT2086)]]** *(sum/product rules, iid, pdf/CDF/quantile)* → [[R Simulation and Random Sampling]] *(simulate it in R)*
- **W2 — expectations & distributions:** **[[Expectations and Covariance (FIT2086)]]** *(every summary is an $E$)* → [[Taylor Approximation of Expectations]] *(derivation drill)* → **[[Parametric Probability Distributions]]** *(the zoo tables)* → **[[Gaussian Distribution]]** → [[Binomial Distribution]] → [[Poisson Distribution]] → [[Uniform Distribution]]
- **W3 — estimation:** **[[Maximum Likelihood Estimation]]** *(the derivation drill)* → [[Sampling Distribution of an Estimator]] *($\hat\theta$ as an RV)* → **[[Estimator Quality (Bias, Variance, MSE)]]** *(compare estimators)*
- **W4 — CLT & intervals:** **[[Central Limit Theorem]]** *(shape for free)* → [[Student-t Distribution]] *(unknown $\sigma^2$)* → **[[Confidence Intervals]]** *(A1 hand skill)*

## 🎯 Learning Outcomes (key skills per week)
- **W0** ➔ 
	- classify data (nominal/ordinal/discrete/continuous)
	- compute + interpret centrality ($\bar y$, median, mode) and spread (range, $s(\mathbf{y})$, $v(\mathbf{y})$, percentiles/IQR, boxplots)
	- read Pearson correlation $R(\mathbf{x},\mathbf{y})$ and know $R\approx 0 \neq$ independence
	- apply the log/exp identities and differentiate (power/log/exp, product, chain, **partial**) toward log-likelihoods
- **W1** ➔ 
	- separate population/sample/model · sampling/inference/model-checking · **three** sources of randomness
	- state a **pmf** ($p(x)\ge0$, $\sum p=1$); apply inclusion–exclusion
	- joint $\to$ **marginal** (sum rule) $\to$ **conditional** (product rule); test independence; write the **iid** product
	- **continuous**: $f$ is not a probability, $P(X{=}x)=0$, split piecewise integrals
	- derive **cdf** $\leftrightarrow$ pdf, survival $1-F$, quantile $Q(p)=F^{-1}(p)$, mode $=\arg\max p(x)$
	- in R: `set.seed`, `sample`, the `d`/`p`/`q`/`r` family
- **W2** ➔ 
	- compute $E[X]$, $E[f(X)]$, $V[X]=E[X^2]-E[X]^2$ from a pmf
	- apply linearity $E[cf(X)+d]$ and $V[cX+d]=c^2V[X]$; know products need independence
	- read population $\operatorname{cov}$/$\operatorname{corr}$ and why $\operatorname{corr}=0\neq$ independence
	- state the **WLLN**; test whether $E[X]$ **exists** at all
	- derive $E[f(X)]\approx f(\mu)+\tfrac{\sigma^2}{2}f''(\mu)$ and $V[f(X)]\approx\sigma^2(f'(\mu))^2$
	- select a family by support: $N(\mu,\sigma^2)$ · $Be(\theta)$ · $Bin(\theta,n)$ · $U(a,b)$ · $Pois(\lambda)$, with each mean/variance
	- *(Studio 1)* subset a data frame by **condition**; write an R function returning a `list`; `factor` + `table` + `prop.table`; screen predictors with `cor`
- **W3** ➔ 
	- separate the three inference tasks: **point** / **interval** / **hypothesis testing**
	- derive an MLE cold: $\prod p(y_i\mid\theta)$ → $L=-\log p$ → $\partial L/\partial\theta=0$ → $\hat\theta$
	- quote $\hat\mu=\bar y$, $\hat\sigma^2_{ML}=\tfrac1n\sum(y_i-\bar y)^2$, $\hat\lambda_{Poi}=\bar y$, $\hat\beta_{Exp}=1/\bar y$
	- use the **plug-in** distribution $p(y\mid\hat\theta)$ for probability statements
	- derive $\bar Y\sim N(\mu,\sigma^2/n)$ and say what naming the family buys
	- compute $b_\theta$, $\mathrm{Var}_\theta$, $\mathrm{MSE}=b^2+\mathrm{Var}$; rank by **efficiency**; test **consistency**
	- *(Studio 2)* read a $z$-table by **interpolation**; justify a family choice from a data description; code an $O(n)$ running mean and read a convergence plot
- **W4** ➔ 
	- state the **CLT** for sums and derive $\bar Y\xrightarrow{d}N(\mu,\sigma^2/n)$ from it
	- approximate $Bin(\theta,n)$ by $N(n\theta,n\theta(1-\theta))$ and $Poi(\lambda)$ by $N(\lambda,\lambda)$
	- recognise an estimator as an **average** ⟹ asymptotically normal
	- derive the $z$ interval by inverting $\frac{\hat\mu-\mu}{\sigma/\sqrt n}\sim N(0,1)$
	- select among the four CI cases: $z$ known $\sigma^2$ · $t_{\alpha/2,n-1}$ unknown · difference of means · CLT-approximate $\hat\theta\pm z_{\alpha/2}\sqrt{v(\hat\theta)/n}$
	- state coverage correctly (**procedure**, not the one interval) and read a difference CI containing zero
