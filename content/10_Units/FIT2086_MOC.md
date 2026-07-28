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
- **LO thread so far** ➔ frame data via probability models; manipulate random variables (pmf/pdf/cdf, joint/marginal/conditional/iid); summarise them by expectations; name the parametric families the unit will estimate.

## 📅 Knowledge Index

### 🧰 Toolkit Cheatsheets
- [[R Toolkit (Cheatsheet)]] -> dual-unit (FIT1043 + FIT2086); FIT2086 adds the simulation / distribution (`d`/`p`/`q`/`r`) block

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

### 🔭 Coming later in the unit *(from the unit outline — no notes yet)*
- Maximum likelihood estimation (MLE) · bias/variance & sample size · multivariate Gaussian, Dirichlet · random sampling, simulation & the **bootstrap** · hypothesis testing (p-values, CIs, type I/II errors) · exploratory vs confirmatory analysis · linear & logistic regression · Bayesian classification & inverse probability · cross-validation & model-performance estimation.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = assessment-critical)*

- **W0 — revision:** [[Measures of Centrality]] → [[Measures of Spread and Boxplots]] → [[Association Between Variables]] → **[[Mathematics for Modelling (Log, Exp, Calculus)]]** *(needed for every MLE derivation)*
- **W1 — modelling & probability:** **[[Statistical Modelling and Inference]]** *(the hub)* → **[[Random Variables and Probability Distributions (FIT2086)]]** *(sum/product rules, iid, pdf/CDF/quantile)* → [[R Simulation and Random Sampling]] *(simulate it in R)*
- **W2 — expectations & distributions:** **[[Expectations and Covariance (FIT2086)]]** *(every summary is an $E$)* → [[Taylor Approximation of Expectations]] *(derivation drill)* → **[[Parametric Probability Distributions]]** *(the zoo tables)* → **[[Gaussian Distribution]]** → [[Binomial Distribution]] → [[Poisson Distribution]] → [[Uniform Distribution]]

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
