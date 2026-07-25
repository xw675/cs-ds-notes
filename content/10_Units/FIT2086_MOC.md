---
unit: FIT2086
type: MOC
tags: [DataScience/Modelling, Tool/R]
---
# 📘 FIT2086: Modelling for Data Analysis

> [!INFO] Map of Content
> Index for **FIT2086 Modelling for Data Analysis** — the **statistics spine** of the DS degree. Much of Week 0–1 is **revision** shared dual-unit with [[FIT1058_MOC]] (probability) and [[FIT1043_MOC]] (descriptive statistics, R) rather than duplicated.

## 📊 Assessment Map
- **Assignment 1 (10%)** · **Assignment 2 (20%)** · **Assignment 3 (20%)** ➔ the three written assignments carry the whole in-semester half; **all involve implementing models in R (LO5)**, so R fluency is assessed continuously.
- **Final exam (50%)** ➔ whole unit; **must obtain ≥ 50% overall to pass**. *(2026 handbook — confirm hurdle detail in the unit guide.)*
- **LO thread so far** ➔ frame data via probability models; manipulate random variables (joint/marginal/conditional/iid); revise descriptive statistics + the calculus needed for estimation.

## 📅 Knowledge Index

### 🧰 Toolkit Cheatsheets
- [[R Toolkit (Cheatsheet)]] -> dual-unit (FIT1043 + FIT2086); FIT2086 adds the simulation / distribution (`d`/`p`/`q`/`r`) block

### Week 0 — Self-Study / Revision
- [[Measures of Centrality]] -> Parent Framework: [[Statistical Modelling and Inference]] *(dual-unit — statistic $s(\mathbf{y})$ framing)*
- [[Measures of Spread and Boxplots]] -> Parent Framework: [[Statistical Modelling and Inference]] *(dual-unit — variance $v(\mathbf{y})$, percentile $Q(\mathbf{y},p)$)*
- [[Association Between Variables]] -> Parent Framework: [[Statistical Modelling and Inference]] *(dual-unit — Pearson $R(\mathbf{x},\mathbf{y})$, correlation ≠ causation)*
- [[Mathematics for Modelling (Log, Exp, Calculus)]] -> Parent Framework: [[Statistical Modelling and Inference]] *(log/exp/derivative/partial — the MLE toolkit)*
- *(R revision R0001–R0005/R0007 is covered dual-unit by [[R Basics (Syntax, Types, Control Flow)]], [[R Vectors]], [[R Data Frames and IO]], [[R Visualisation (base graphics)]] + the cheatsheet.)*

### Week 1 — Modelling, Probability & Random Variables 
- [[Statistical Modelling and Inference]] -> Parent Framework: [[FIT2086_MOC]] *(hub: population/sample/model/inference)*
- [[Random Variables and Probability Distributions (FIT2086)]] -> Parent Framework: [[Statistical Modelling and Inference]] *(joint/marginal/conditional/iid; continuous pdf/CDF/quantile)*
- [[R Simulation and Random Sampling]] -> Parent Framework: [[R for Data Science]] *( `set.seed`, `sample`, `d`/`p`/`q`/`r`)*
- *(Cross-links to the FIT1058 probability cluster: [[Random Variable]], [[Conditional Probability]], [[Bayes' Theorem]], [[Expectation]], [[Variance and Standard Deviation]], [[Binomial Distribution]], [[Poisson Distribution]], [[Uniform Distribution]] — the maths lives there, deepened here for modelling.)*

### 🔭 Coming later in the unit *(from the unit outline — no notes yet)*
- Maximum likelihood estimation (MLE) · bias/variance & sample size · common distributions (Gaussian, multivariate Gaussian, Dirichlet) · random sampling, simulation & the **bootstrap** · hypothesis testing (p-values, CIs, type I/II errors) · exploratory vs confirmatory analysis · linear & logistic regression · Bayesian classification & inverse probability · cross-validation & model-performance estimation.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = assessment-critical)*

- **W0 — revision:** [[Measures of Centrality]] → [[Measures of Spread and Boxplots]] → [[Association Between Variables]] → **[[Mathematics for Modelling (Log, Exp, Calculus)]]** *(needed for every MLE derivation)*
- **W1 — modelling & probability:** **[[Statistical Modelling and Inference]]** *(the hub)* → **[[Random Variables and Probability Distributions (FIT2086)]]** *(sum/product rules, iid, pdf/CDF/quantile)* → [[R Simulation and Random Sampling]] *(simulate it in R)*

## 🎯 Learning Outcomes (key skills per week)
- **W0** ➔ 
	- classify data (nominal/ordinal/discrete/continuous)
	- compute + interpret centrality ($\bar y$, median, mode) and spread (range, $s(\mathbf{y})$, $v(\mathbf{y})$, percentiles/IQR, boxplots)
	- read Pearson correlation $R(\mathbf{x},\mathbf{y})$ and know $R\approx 0 \neq$ independence
	- apply the log/exp identities and differentiate (power/log/exp, product, chain, **partial**) toward log-likelihoods
- **W1** ➔ 
	- separate **population/sample/model/inference** and the two sources of randomness (measurement error vs random sampling)
	- state a discrete distribution ($P(X{=}x)\in[0,1]$, $\sum P = 1$) and use additivity/inclusion–exclusion
	- manipulate **joint** $p(x,y)$ via the **sum rule** (marginal) and **product rule** (conditional), test **independence** $p(x,y)=p(x)p(y)$ and write the **iid** product $\prod_i p(y_i)$ 
	- handle **continuous** RVs (density $f$ is not a probability; $P(X{=}x)=0$; probabilities are integrals; CDF $F$ and its inverse the quantile $Q$)
	- in R, use `set.seed` for reproducibility, `sample` (with/without replacement, permutation), and the `d`/`p`/`q`/`r` distribution family
