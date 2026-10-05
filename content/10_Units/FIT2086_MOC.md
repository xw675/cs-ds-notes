---
unit: FIT2086
type: MOC
tags:
  - 2026/S2
---
# 📘 FIT2086: Modelling for Data Analysis

> [!INFO] Map of Content
> Index for **FIT2086 Modelling for Data Analysis** — the **statistics spine** of the DS degree. Much of Week 0–1 is **revision** shared dual-unit with [[FIT1058_MOC]] (probability) and [[FIT1043_MOC]] (descriptive statistics, R) rather than duplicated.

## 📊 Assessment Map
- **Assignment 1 (10%, due W5)** · **Assignment 2 (20%, due W8)** · **Assignment 3 (20%, due W11)** ➔ carry the whole in-semester half; **all involve implementing models in R (LO5)**.
- **Final exam (50%)**
- **LO map** ➔ LO1 EDA/descriptive (W1–2) · LO2 inferential models (W3–5) · LO3 predictive models (W6–9, W11) · LO4 sampling/simulation/testing (W3, W5, W10) · LO5 implement in R (W6–11) · LO6 interpret results (W4–11).
- **LO thread so far** ➔ frame data via probability models; manipulate random variables (pmf/pdf/cdf, joint/marginal/conditional/iid); summarise them by expectations; name the parametric families — then **fit** them by maximum likelihood (W3), **judge the fit** by bias/variance/MSE, and **bound the estimate** by a confidence interval (W4). **A1 (due W5) sits directly on W3–4 estimation.** W6 turns the estimation machinery on a mean that **varies with predictors** (linear regression) and adds the second-order question — **which** predictors — answered by a penalised likelihood. **A2 (due W8) sits on W6–7 supervised learning.** W7 swaps the Gaussian target for a **Bernoulli** one — the same linear predictor, now read as log-odds — and adds the classification-specific scoring layer (CA, sensitivity/specificity, AUC, log-loss). W8 formalises **why** complexity must be controlled (bias$^2$ + variance + irreducible $\sigma^2$) and compares the three controls — **tests** (with Bonferroni), **criteria** (AIC/KIC/BIC/RIC), **cross-validation** — before replacing unstable subset search with **ridge/lasso** shrinkage. W9 leaves the parametric families behind: **trees** partition predictor space and fit a model per leaf (grown by Bernoulli NLL, sized by IC/CV), **random forests** average randomised trees to cancel their instability, and **$k$-NN** predicts from neighbours with no model at all — each tuned by the same CV recipe over a complexity parameter $\gamma$.

## 🧰 Toolkit Cheatsheets
- [[R Toolkit (Cheatsheet)]] -> dual-unit (FIT1043 + FIT2086); FIT2086 adds the simulation / distribution (`d`/`p`/`q`/`r`) block, the `qnorm`/`qt` critical-value rows, and the `glm` / `pROC` / `step(k = 3)` classification block, and the `glmnet` ridge/lasso block (`cv.glmnet.f`, `lambda.min`, `alpha = 0`, RIC `k = 2*log(p)`)

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

#### Studio 3 *(run in W4 — drills the W3 estimation material; `train.csv` / `test.csv`)*
- [[Plug-in Prediction and Held-Out Evaluation]] -> Parent Framework: [[Maximum Likelihood Estimation]] *(fit on train ➔ `pnorm` predictions ➔ empirical proportions ➔ **out-of-sample NLL**; $\hat\sigma^2_{ML}$ vs $\hat\sigma^2_u$ head-to-head)*
- [[Monte Carlo Estimator Comparison]] -> Parent Framework: [[Estimator Quality (Bias, Variance, MSE)]] *(simulation loop for $b_\theta$/$\mathrm{Var}_\theta$/MSE; **RelMSE**; mean vs median under contamination)*
- [[Maximum Likelihood Estimation]] — the **Bernoulli** derivation $\hat\theta=m/n$; ML's **boundary overconfidence** at $m\in\{0,n\}$
- [[Estimator Quality (Bias, Variance, MSE)]] — **efficiency vs robustness**: RelMSE is scale-free, moves with $n$ and the contamination fraction

### Week 5 — Hypothesis Testing
- [[Hypothesis Testing]] -> Parent Framework: [[Statistical Modelling and Inference]] *(**exam-heavy** hub: Neyman–Pearson, $p$-value semantics + evidence grading, one vs two sided, $\alpha$, why the null can never be proved)*
- [[Tests for Normal Means (z-test and t-test)]] -> Parent Framework: [[Hypothesis Testing]] *(**exam-heavy hand skill**: the 5-case selection matrix + 8 worked examples; pooled/Welch $t$ flagged optional)*
- [[Tests for Bernoulli Populations]] -> Parent Framework: [[Hypothesis Testing]] *(CLT-based proportion $z$-test; null-supplied $\mathrm{se}$, pooled $\hat\theta_p$, exact `binom.test`/`prop.test`)*
- [[Confidence Intervals]] — **merged**: proportion intervals, small-$n$ pooled/Welch difference intervals, and the interval–test pairing from the W5 summary tables
- *(Reading: Lecture 5 Notes)*

#### Studio 4 *(run in W5 — drills the W4 CLT/CI material; `train.csv` / `test.csv` / `SP500.csv`)*
- [[Confidence Intervals in R (calcCI)]] -> Parent Framework: [[Confidence Intervals]] *(**A1 hand-and-R skill**: `calcCI` anatomy ➔ heights train/test check ➔ SP500 pre/post-Lehman difference ➔ the reporting statement)*
- [[Confidence Interval Coverage Simulation]] -> Parent Framework: [[Confidence Intervals]] *(generate ➔ build interval ➔ tally containment; exact $z$/$t$ vs the undercovering plug-in; Poisson $(\lambda,n)$ coverage grid)*
- [[Confidence Intervals]] — $z_{0.1}=1.281$ at $80\%$, the degenerate $100\%$ interval $(-\infty,\infty)$, the **plug-in proportion** interval + the $n=12$ coin toss $(0.066,0.600)$
- [[Student-t Distribution]] — critical-value table extended to $n=5,10,50,100,1000$ ➔ $t\to z$ visibly by $n\approx50$
- [[Estimator Quality (Bias, Variance, MSE)]] — the **Bernoulli** $\hat\theta_{ML}$ drill: $b=0$, $\mathrm{Var}=\mathrm{MSE}=\theta(1-\theta)/n$, consistency, and the CLT limit

### Week 6 — Linear Regression & Model Selection
- [[Linear Regression (FIT2086)]] -> Parent Framework: [[Statistical Modelling and Inference]] *(**exam-heavy** hub: supervised setup, simple→multiple, least squares, $\text{RSS}$/$\text{TSS}$/$R^2$, prediction)*
- [[Least Squares as Maximum Likelihood]] -> Parent Framework: [[Linear Regression (FIT2086)]] *(**derivation drill**: $\varepsilon_i\sim N(0,\sigma^2)$ ➔ $L=\tfrac n2\log(2\pi\sigma^2)+\tfrac{\text{RSS}}{2\sigma^2}$; $\hat\sigma^2_{ML}$ vs $\hat\sigma^2_u=\text{RSS}/(n-p-1)$)*
- [[Predictor Transformations (Indicators, Polynomials, Interactions)]] -> Parent Framework: [[Linear Regression (FIT2086)]] *($K-1$ indicators, $\log$/polynomial, $x_jx_k$ — linear in $\boldsymbol\beta$, not in $x$)*
- [[Model Selection and Information Criteria (AIC, BIC)]] -> Parent Framework: [[Linear Regression (FIT2086)]] *(**exam-heavy**: $t_j$ + $H_0:\beta_j=0$; $L+\alpha(n,k_M)$; AIC $k_M$ vs BIC $\tfrac{k_M}2\log n$; all-subsets $2^p$ vs stepwise)*
- [[Multiple Regression and Stepwise Selection in R]] -> Parent Framework: [[R for Data Science]] *(**LO5 hand skill**: `lm` ➔ `summary` ➔ `step(…, k = log(n))`)*
- [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]] — **merged**: under/overfitting restated as *omitting important* vs *including spurious* predictors; generalisation; polynomial degree $=$ predictor-set choice
- *(Reading: Ross Ch. 9)*

#### Studio 5 *(run in W6 — drills the W5 hypothesis-testing material; `bpdata.csv` / `SP500.csv`)*
- [[Hypothesis Testing in R (t.test, binom.test, prop.test)]] -> Parent Framework: [[Hypothesis Testing]] *(**exam + A2 hand skill**: `mu` / `alternative` / `conf.level` / `var.equal`; `rv$p.value`; `binom.test` vs `prop.test`)*
- [[Tests for Normal Means (z-test and t-test)]] — **merged**: the `bpdata` two-sided ($9.0\times10^{-5}$) vs one-sided ($4.5\times10^{-5}$) pair, and the **three routes to one difference** on S&P (approximate $z$ / Welch $t$ / pooled $t$)
- [[Tests for Bernoulli Populations]] — **merged**: the "guess the coin" drill ($z=-1.155$, $p=0.248$ vs exact $0.3877$), the two-sample pooled $\hat\theta_p=14/24$ ($p=0.0130$ vs exact $0.0384$), and the `binom.test` **sensitivity sweep**
- [[Hypothesis Testing]] — **merged**: $\sigma^2\uparrow\Rightarrow\lvert z\rvert\downarrow\Rightarrow p\uparrow$; the leukemia-trial true/false drill at $p=0.17$; the rejection threshold **scales with the consequences** of a wrong call
- [[Confidence Intervals]] — **merged**: a one-sided alternative returns a **bound** $(-\infty,u)$, not a range; the $90/95/99\%$ width sweep on `bpdata`

### Week 7 — Classification & Logistic Regression
- [[Classification and Conditional Class Probabilities]] -> Parent Framework: [[Statistical Modelling and Inference]] *(hub: $\mathbb{P}(Y=y\mid\mathbf{x})$, joint→conditional by proportions, the $2^{p+1}$ **curse of dimensionality**, generative vs discriminative)*
- [[Logistic Regression]] -> Parent Framework: [[Classification and Conditional Class Probabilities]] *(**exam-heavy**: odds/log-odds, $\eta_i$ → logistic function, Bernoulli NLL by ML — convex, no closed form; $\beta_j$ as log-odds per unit; linear decision boundary)*
- [[Classification Evaluation (Confusion Matrix and Metrics)]] — **merged** (now dual-unit with FIT1043): the $\arg\max$ decision rule, $\text{CA}=\frac1{n'}\sum I(y'_i=\hat y'_i)$, the TPR/TNR names, the class-frequency baseline, and the $n'=192$ worked matrix
- [[ROC and AUC]] -> Parent Framework: [[Classification Evaluation (Confusion Matrix and Metrics)]] *(**hand skill**: threshold $T$ sweep → sensitivity/specificity trade-off → ROC → AUC by counting ordered pairs)*
- [[Logarithmic Loss]] -> Parent Framework: [[Classification Evaluation (Confusion Matrix and Metrics)]] *(scores the **probabilities**, not the labels; $=$ NLL of future data; $0.501$ vs $0.99$ is the whole point)*
- [[Model Selection and Information Criteria (AIC, BIC)]] — **merged**: the penalty transfers unchanged to logistic regression as $L+k\alpha_n$, with $\alpha_n=1$ (AIC), $\tfrac32$ (**KIC**, new), $\tfrac12\log n$ (BIC)
- *(Terms to revise, from the lecture: odds/log-odds · logistic regression · classification accuracy · specificity/sensitivity · AUC · logarithmic loss)*

### Week 8 — Model Selection & Penalized Regression
- [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]] — **merged**: $\hat f_{\mathcal{D}}$ over repeated samples, $\text{bias}(x_0)$/$\text{variance}(x_0)$, $\text{MSE}_f=\text{bias}^2+\text{variance}$, **irreducible** $\sigma^2$, the 10,000-sample simulation (order 2 / 7 / 20)
- [[Multiple Testing and the Bonferroni Correction]] -> Parent Framework: [[Hypothesis Testing]] *(**exam hand skill**: $\alpha p$ false positives, threshold $\alpha/p$, FWER vs FDR)*
- [[Model Selection and Information Criteria (AIC, BIC)]] — **merged**: NLL-scale AIC/**KIC**/BIC/**RIC**, when each over/underfits, the polynomial-order plot, problems with conventional selection
- [[Cross-Validation]] -> Parent Framework: [[Model Selection and Information Criteria (AIC, BIC)]] *(MSPE estimate; $K$-fold / repeated / LOO; LOO ≈ AIC)*
- [[Penalized Regression (Ridge and Lasso)]] -> Parent Framework: [[Linear Regression (FIT2086)]] *(**exam-heavy**: instability experiment, standardise, $\lambda$ path, ridge $\ell_2$ vs lasso $\ell_1$, CV for $\lambda$, multicollinearity)*
#### Studio 7 *(run in W8 — drills the W7 logistic-regression material; `gene.*.csv` / `pima.*.csv`)*
- [[Logistic Regression in R (glm, pROC, step)]] -> Parent Framework: [[Logistic Regression]] *(**LO5 hand skill**: `glm(family = binomial)` ➔ `type = "response"` ➔ `my.pred.stats` ➔ `step` with AIC/KIC/BIC; gene $p\approx n$ overfit; Pima 53-term BIC vs KIC)*
- [[Logistic Regression]] — **merged**: null/residual **deviance** $=2L$, interaction reading on the log-odds, the pruned SNP12/SNP56 equation drill
- [[Predictor Transformations (Indicators, Polynomials, Interactions)]] — **merged**: judge a new term by $p$-value **and** deviance drop (`log(BMI)` keep, `PLAS^2` drop, `SKIN*AGE` keep)
- *(Terms to revise, from the lecture: underfitting/bias · overfitting/variance · irreducible error & MSPE · multiple testing/Bonferroni · AIC, BIC · cross-validation · statistical instability · penalised regression · ridge/lasso)*

### Week 9 — Trees & Nearest Neighbour Methods
- [[Decision Trees and Regression Trees]] — **merged** (now dual-unit with FIT1043): $L$ disjoint regions, Bernoulli/Normal **leaf models**, complexity $L$, strengths/weaknesses, three near-equal trees ⟹ **instability**
- [[Decision Tree Learning (Likelihood Splits, Pruning, CV)]] -> Parent Framework: [[Decision Trees and Regression Trees]] *(**exam hand skill**: leaf NLL $-n_1\log\frac{n_1}{n}-n_0\log\frac{n_0}{n}$, the $x_1$ vs $x_2$ toy split, forward search, pruning, $K$-fold CV over $L$)*
- [[Random Forest]] — **merged** (dual-unit): bootstrap sample + random candidate variables per split, average means/probabilities, low bias with reduced variance, variable importance
- [[k-Nearest Neighbours]] -> Parent Framework: [[Classification and Conditional Class Probabilities]] *(**exam hand skill**: Euclidean distance, standardise, vote vs average vs kernel-weighted average, LOO CV for $k$)*
- [[Cross-Validation]] — **merged**: the general complexity parameter $\gamma$ (predictor count, $\lambda$, $L$, $k$) and $\gamma^*=\arg\min_\gamma\text{CV}(\gamma)$
- [[Machine Learning]] — **merged**: the statistician's framing — algorithmic, flexible, few assumptions, prediction over interpretation
- *(Terms to revise, from the lecture: cross-validation · decision tree · split and leaf · random forest · $k$-nearest neighbours method)*

#### Studio 8 *(run in W9 — drills the W8 selection/shrinkage material; `gene.*.csv` / `pima.*.csv` / `wrappers.R`)*
- [[Shrinkage Estimator of the Mean]] -> Parent Framework: [[Estimator Quality (Bias, Variance, MSE)]] *(**derivation drill**: $\hat\mu(c)=\frac{n}{n+c}\bar Y$ ➔ bias, variance, MSE, crossover $\mu^2<\sigma^2\frac{2n+c}{nc}$, consistency, the ridge argmin proof)*
- [[Penalized Regression in R (glmnet)]] -> Parent Framework: [[Penalized Regression (Ridge and Lasso)]] *(**LO5 hand skill**: `glmnet.f` / `cv.glmnet.f` / `predict.glmnet.f`, `lambda.min`, `alpha = 0`; lasso vs BIC at $n=668$; graceful degradation at $n=100$, $p=59$)*
- [[Multiple Testing and the Bonferroni Correction]] — **merged**: the gene drill — 12 SNPs pass $0.05$ vs $5$ expected by chance, $0$ pass Bonferroni, RIC `k = 2*log(p)` keeps SNP56 alone ($p=0.0018$)
- [[Penalized Regression (Ridge and Lasso)]] — **merged**: the one-parameter shrinkage case and the Studio 8 small-$n$ evidence

### 🔭 Coming later in the unit *(from the unit outline — no notes yet)*
- **W10 next:** simulation-based methods — **bootstrapping**, **permutation tests**.
- Multivariate Gaussian, Dirichlet · random sampling, simulation & the **bootstrap** · exploratory vs confirmatory analysis · Bayesian classification & inverse probability · model-performance estimation.

## 🧭 Suggested Reading Order
*(read left→right · **bold** = assessment-critical)*

- **W0 — revision:** [[Measures of Centrality]] → [[Measures of Spread and Boxplots]] → [[Association Between Variables]] → **[[Mathematics for Modelling (Log, Exp, Calculus)]]** *(needed for every MLE derivation)*
- **W1 — modelling & probability:** **[[Statistical Modelling and Inference]]** *(the hub)* → **[[Random Variables and Probability Distributions (FIT2086)]]** *(sum/product rules, iid, pdf/CDF/quantile)* → [[R Simulation and Random Sampling]] *(simulate it in R)*
- **W2 — expectations & distributions:** **[[Expectations and Covariance (FIT2086)]]** *(every summary is an $E$)* → [[Taylor Approximation of Expectations]] *(derivation drill)* → **[[Parametric Probability Distributions]]** *(the zoo tables)* → **[[Gaussian Distribution]]** → [[Binomial Distribution]] → [[Poisson Distribution]] → [[Uniform Distribution]]
- **W3 — estimation:** **[[Maximum Likelihood Estimation]]** *(the derivation drill)* → [[Sampling Distribution of an Estimator]] *($\hat\theta$ as an RV)* → **[[Estimator Quality (Bias, Variance, MSE)]]** *(compare estimators)*
- **W4 — CLT & intervals:** **[[Central Limit Theorem]]** *(shape for free)* → [[Student-t Distribution]] *(unknown $\sigma^2$)* → **[[Confidence Intervals]]** *(A1 hand skill)* → [[Plug-in Prediction and Held-Out Evaluation]] *(Studio 3, in R)* → [[Monte Carlo Estimator Comparison]] *(Studio 3, in R)*
- **W5 — testing:** **[[Hypothesis Testing]]** *(the logic + $p$-value)* → **[[Tests for Normal Means (z-test and t-test)]]** *(exam hand skill)* → [[Tests for Bernoulli Populations]] *(proportions)* → **[[Confidence Intervals in R (calcCI)]]** *(Studio 4, A1 skill)* → [[Confidence Interval Coverage Simulation]] *(Studio 4, in R)*
- **W6 — regression & selection:** **[[Linear Regression (FIT2086)]]** *(the hub)* → [[Least Squares as Maximum Likelihood]] *(derivation drill)* → [[Predictor Transformations (Indicators, Polynomials, Interactions)]] *(build the columns)* → [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]] *(why prune)* → **[[Model Selection and Information Criteria (AIC, BIC)]]** *(exam hand skill)* → **[[Multiple Regression and Stepwise Selection in R]]** *(LO5, in R)* → **[[Hypothesis Testing in R (t.test, binom.test, prop.test)]]** *(Studio 5, in R)*
- **W7 — classification:** **[[Classification and Conditional Class Probabilities]]** *(why the joint dies)* → **[[Logistic Regression]]** *(the model + the derivation)* → [[Classification Evaluation (Confusion Matrix and Metrics)]] *(CA, TPR, TNR)* → **[[ROC and AUC]]** *(exam hand skill)* → [[Logarithmic Loss]] *(confidence, not labels)*
- **W8 — selection & shrinkage:** **[[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]** *(the decomposition)* → **[[Multiple Testing and the Bonferroni Correction]]** *(why tests mislead)* → **[[Model Selection and Information Criteria (AIC, BIC)]]** *(four penalties)* → [[Cross-Validation]] *(estimate MSPE)* → **[[Penalized Regression (Ridge and Lasso)]]** *(stable selection)* → **[[Logistic Regression in R (glm, pROC, step)]]** *(Studio 7, in R)*
- **W9 — trees & neighbours:** [[Machine Learning]] *(the framing)* → [[Decision Trees and Regression Trees]] *(leaves + leaf models)* → **[[Decision Tree Learning (Likelihood Splits, Pruning, CV)]]** *(NLL split drill)* → [[Random Forest]] *(average away instability)* → **[[k-Nearest Neighbours]]** *(vote/average by hand)* → [[Cross-Validation]] *(one $\gamma$ recipe)* → **[[Shrinkage Estimator of the Mean]]** *(Studio 8 derivation)* → **[[Penalized Regression in R (glmnet)]]** *(Studio 8, in R)*

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
	- *(Studio 3)* derive the **Bernoulli** MLE $\hat\theta=m/n$ and explain ML's boundary overconfidence
	- *(Studio 3)* fit on train, predict with `pnorm`, check against empirical proportions, rank models by held-out NLL
	- *(Studio 3)* code a simulation study returning bias/variance/MSE, and read **RelMSE** for efficiency vs robustness
- **W5** ➔ 
	- set up $H_0$ vs $H_A$ and identify one-sided vs two-sided from the wording
	- define a $p$-value as $P(\text{data this extreme}\mid H_0)$ and grade it ($0.01$ / $0.05$)
	- select the test: $\sigma$ known $z$ · $\sigma$ unknown small-$n$ $t_{n-1}$ · large-$n$ approximate $z$ · two-sample difference
	- compute $z$/$t$ by hand and bracket $p$ with tabulated criticals
	- test a proportion via the CLT, pooling $\hat\theta_p$ for two Bernoulli samples
	- explain why a large $p$ **never** proves $H_0$, and why $\alpha$-thresholding is deprecated
	- *(Studio 4)* state how CI width scales with $\sigma$ and $n$ ($\times4$ data to halve the width); read $z$ at any $\alpha$
	- *(Studio 4)* write `calcCI` cold and report an interval as a sentence about the **population**
	- *(Studio 4)* build a difference-of-means CI for two groups and read it against zero
	- *(Studio 4)* derive $b$, $\mathrm{Var}$, MSE, consistency and the CLT limit for the Bernoulli $\hat\theta_{ML}$
	- *(Studio 4)* simulate **coverage** and explain why plug-in intervals undercover at small $n$
- **W6** ➔ 
	- separate **classification** (categorical target) from **regression** (numerical target)
	- write $\mathbb{E}[Y_i\mid\mathbf{x}_i]=\beta_0+\sum_j\beta_jx_{i,j}$; read each $\beta_j$ as a per-unit change
	- fit by least squares; state $\sum e_i=0$, $\operatorname{corr}(\mathbf{x},\mathbf{e})=0$, and the $p<n$ requirement
	- compute $R^2=1-\text{RSS}/\text{TSS}$ and say why it can never select a model
	- derive $L=\tfrac{n}{2}\log(2\pi\sigma^2)+\tfrac{\text{RSS}}{2\sigma^2}$ ⟹ LS $=$ ML; quote $\hat\sigma^2_{ML}$ vs $\hat\sigma^2_u$
	- build $K-1$ **indicators**, polynomial terms, and interaction columns
	- rank predictors by $t_j$, test $H_0:\beta_j=0$, score models by $L+\alpha(n,k_M)$
	- contrast AIC ($k_M$, overfits) with BIC ($\tfrac{k_M}{2}\log n$, underfits); $\ge3$ is significant
	- search all-subsets $2^p$ vs forward/backward **stepwise**; run `step(…, k = log(n))` in R
	- *(Studio 5)* run `t.test` with the right `mu`, `alternative`, `conf.level` and `var.equal`
	- *(Studio 5)* explain why $\sigma^2\uparrow$ weakens the evidence, and read a $p$ of $0.9$ correctly
	- *(Studio 5)* judge a large effect with a borderline $p$ — demand a larger trial, not a verdict
	- *(Studio 5)* compare approximate $z$, Welch $t$ and pooled $t$ on one difference, and say which interval is overconfident
	- *(Studio 5)* test one and two proportions by hand, then check against `binom.test` / `prop.test`
- **W7** ➔ 
	- separate **classification** (categorical $Y$) from regression; predict by $\arg\max_y\mathbb{P}(Y=y\mid\mathbf{x})$
	- count $2^{p+1}$ joint cells — the **curse of dimensionality** that kills direct estimation
	- convert $\eta\to$ odds $e^{\eta}\to$ probability $\tfrac{1}{1+e^{-\eta}}$, and read $\beta_j$ as log-odds per unit
	- derive the Bernoulli NLL $\sum_i[-y_i\eta_i+\log(1+e^{\eta_i})]$; state **convex, no closed form**
	- compute $\text{CA}$, $\text{TPR}$, $\text{TNR}$ from a confusion matrix, against the **class-frequency** baseline
	- compute AUC by hand from ranked scores, and say what **log-loss** adds that AUC cannot
- **W8** ➔ 
	- define $\text{bias}(x_0)$ and $\text{variance}(x_0)$ over repeated training samples $\hat f_{\mathcal{D}}$
	- state $\text{MSE}_f=\text{bias}^2+\text{variance}$ and add $\sigma^2$ for predicting a new $Y'$ — **irreducible**
	- map underfitting ➔ high bias/low variance and overfitting ➔ low bias/high variance; say what more $n$ does and doesn't fix
	- compute expected false positives $\alpha p$ and the Bonferroni threshold $\alpha/p$; distinguish **FWER** from **FDR**
	- write AIC $L+k$, KIC $L+\tfrac32k$, BIC $L+\tfrac k2\log n$, RIC $L+k\log p$ and say which over/underfits
	- describe $K$-fold, repeated $K$-fold and LOO CV, and choose a model by smallest CV error
	- explain why all-or-nothing subset selection is **statistically unstable**
	- write the penalised LS objective, justify **standardising**, and read a $\lambda$ path
	- contrast ridge ($\ell_2$, stable, no zeros) with lasso ($\ell_1$, sparse, biased large coefficients); pick $\lambda$ by CV then refit on all data
	- explain penalisation as adding bias to cut variance, and why it helps with **multicollinearity** and $n<p$
	- *(Studio 7)* fit `glm(…, family = binomial)` and read deviance, AIC $=$ deviance $+2k$, and each $z$-test
	- *(Studio 7)* predict probabilities with `type = "response"`, threshold at $\tfrac12$, and score CA/sens/spec/AUC/log-loss on test data
	- *(Studio 7)* prune with `step` at `k = 2` / `3` / `log(n)` and argue BIC (interpretable) vs KIC (predictive)
	- *(Studio 7)* add `log()`, `I(x^2)` and `a*b` terms and justify each from its $p$-value and deviance drop
	- *(Studio 7)* write a pruned model's log-odds equation and read each coefficient's effect
- **W9** ➔ 
	- explain how a tree partitions predictor space into $L$ leaves and predicts with each leaf's Bernoulli/Normal model
	- compute a leaf's minimised NLL $-n_1\log\frac{n_1}{n}-n_0\log\frac{n_0}{n}$ and pick the purer split
	- explain why splitting never raises the NLL ⟹ size trees by IC, pruning, or $K$-fold CV over $L$
	- explain how bootstrap samples and random candidate variables let a forest cut variance, and what it costs in interpretability
	- apply kNN: Euclidean distance on standardised predictors, then vote / average / kernel-weighted average
	- choose $k$, distance and kernel by LOO CV
	- *(Studio 8)* derive bias, variance and MSE of $\hat\mu(c)=\frac{n}{n+c}\bar Y$, find where it beats $\bar Y$, and prove it is the ridge solution
	- *(Studio 8)* count false discoveries against $\alpha p$, apply Bonferroni, and run RIC stepwise with `k = 2*log(p)`
	- *(Studio 8)* fit lasso/ridge with `cv.glmnet.f`, read the `lambda.min` coefficients, and compare with BIC stepwise on test data
	- *(Studio 8)* explain why penalisation beats stepwise when $n$ is small relative to $p$
