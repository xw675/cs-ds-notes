---
unit: FIT2086
week: 10
source: [lecture]
domain: [D, E]
parent: "[[Sampling Distribution of an Estimator]]"
tags: [Math/Probability, DataScience/Modelling, Tool/R]
aliases: [the bootstrap, bootstrap methods, exact bootstrap, bootstrap distribution, bootstrap algorithm, resampling, resampling methods, sampling with replacement, bootstrap confidence interval, percentile interval, bootstrapping predictions, bagging, bootstrap aggregation]
---
# [[Bootstrap]]

**Context:** [[FIT2086_MOC]] · W10 · estimates a [[Sampling Distribution of an Estimator|sampling distribution]] by **resampling** instead of deriving it · same family as [[Cross-Validation]], different job · the $p$-value counterpart ➔ [[Permutation Tests]] · bagging is the ancestor of [[Random Forest]] · relies on [[Monte Carlo Simulation (Empirical Probabilities)|Monte Carlo]] averaging
**Parent Framework:** [[Sampling Distribution of an Estimator]]

> [!abstract] Quick Revision
> - **🎯 Objective:** treat the sample as the population ➔ draw $n$ rows **with replacement**, $m$ times ➔ recompute $\hat\theta^{(i)}$ each time ➔ the spread of $\hat\theta^{(1)},\dots,\hat\theta^{(m)}$ gives bias, variance and percentile CIs with **no distributional assumption**.
> - **📦 Core Components:** [[#2. The Exact Bootstrap|exact bootstrap]] ➔ all $M=n^n$ resamples, infeasible | [[#3. The Bootstrap Algorithm|bootstrap algorithm]] ➔ $m\ll M$ random resamples, $m=1000$ often enough | [[#5. Bagging|bagging]] ➔ average models fitted to resamples.
> - **⚡ Key Constraint:** resample **with replacement, size $n$, whole rows** — without replacement every resample is a reshuffle of $\mathbf{y}$ and $\bar y$ never changes (zero spread); resampling columns separately destroys the $(x,y)$ pairing.

## 📝 How It Works
### 1. The Problem
- **Population–sample model** ➔ population characterised by $\theta$; a finite sample of size $n$ gives $\hat\theta$ ➔ how much would $\hat\theta$ vary over new samples?
- **Classical route** ➔ assume a population distribution, then derive the distribution of $\hat\theta$ ➔ difficult or impossible, and only as good as the assumption. A sample mean needs weaker assumptions ([[Central Limit Theorem|CLT]]); a general statistic does not get that help.

### 2. The Exact Bootstrap
- **Idea (Efron, 1970s)** ➔ the sample is an estimate of the population ➔ draw new samples from this **surrogate population** ➔ an **empirical** sampling distribution. Justified because sample probabilities are a consistent estimate of population probabilities as $n$ grows.
- **Enumerate** ➔ all $M=n^n$ **ordered** samples of size $n$ with replacement, $\mathbf{y}^{(1)},\dots,\mathbf{y}^{(M)}$ ➔ compute $\hat\theta^{(i)}$ for each. The original $\hat\theta$ plays the **population value**.
- **Bias** ➔ $\text{bias}=\frac1M\sum_{i=1}^{M}\big(\hat\theta^{(i)}-\hat\theta\big)$.
- **Variance** ➔ $\text{Var}=\frac1M\sum_{i=1}^{M}\Big(\hat\theta^{(i)}-\frac1M\sum_{j=1}^{M}\hat\theta^{(j)}\Big)^2$ (divisor $M$).
- **Confidence interval** ➔ percentiles of the $\hat\theta^{(i)}$.
- **Cost** ➔ $M=n^n$: $27$ at $n=3$, $10^{10}$ at $n=10$ ⟹ infeasible almost immediately.

### 3. The Bootstrap Algorithm
- **For $i=1$ to $m$** ($m\ll M$) ➔ (1) draw a new sample of size $n$ **with replacement** from $\mathbf{y}$ · (2) compute $\hat\theta^{(i)}$ on it ➔ a **resampling procedure**.
- **Approximation** ➔ $\hat\theta^{(1)},\dots,\hat\theta^{(m)}$ approximate the exact bootstrap distribution; larger $m$ ⟹ closer; $m=1000$ often works well.
- **Possible resamples of $(2,3,6)$** ➔ $(3,2,2)$, $(6,2,6)$, $(3,3,2)$, $(2,6,2)$ — repeats allowed, some points absent.
- **Supervised data** ➔ resample **whole rows** ($y$ with its predictors): indices $I=8,9,2,9,6,1,3,5,9$ on the 9-row BP data ⟹ row $9$ appears three times, rows $4$ and $7$ not at all.

### 4. Bootstrapping Predictions and Errors
- **One model per resample** ➔ fit BP on Age + Weight to each resample ⟹ $\hat\beta_0^{(i)},\hat\beta_{\text{Age}}^{(i)},\hat\beta_{\text{Weight}}^{(i)}$, $i=1,\dots,m$ — a range of plausible models.
- **Prediction CI** ➔ new individual (age $a$, weight $w$): $\hat y^{(i)}=\hat\beta_{\text{Weight}}^{(i)}w+\hat\beta_{\text{Age}}^{(i)}a+\hat\beta_0^{(i)}$ ➔ 95% CI $=$ [2.5th, 97.5th] percentiles of the $m$ predictions.
- **What it covers** ➔ uncertainty in the **predicted mean** at $(a,w)$; an interval for one individual's actual BP would also need the outcome noise.
- **Training MSE** ➔ resample ➔ fit ➔ MSE of fit ➔ its bootstrap distribution quantifies the **sampling variability** of the training MSE — but does **not** remove its **optimistic bias** (that is [[Cross-Validation]]'s job).

### 5. Bagging
- **Bootstrap aggregation** ➔ draw $m$ bootstrap samples ➔ fit a model to each ➔ predict new data by **averaging** the $m$ predictions $\hat y_{\text{bag}}=\frac1m\sum_{i=1}^{m}\hat y_i$ (classification: majority vote).
- **When it helps** ➔ **low-bias / high-variance** models — trees are the prime example ➔ averaging cancels their instability.
- **Lineage** ➔ bagging inspired [[Random Forest|random forests]], which add random feature selection at each split.

### 6. Strengths and Weaknesses
- **Strengths** ➔ few distributional assumptions (standard bootstrap: observations **independently** sampled) · easy to code and apply · accuracy improves with $n$.
- **Weaknesses** ➔ slow when $\hat\theta$ is slow to compute · poor accuracy at small $n$ · may need large $m$ for a smooth distribution · some problems need modifications first, e.g. the **lasso**.

## 🧮 Proof Blueprint
*(Derivation not on the slides — it reproduces their $26/27$ and explains it.)*
- **Theorem** ➔ for $\hat\theta=\bar Y$ the exact bootstrap gives $\text{bias}=0$ and $\text{Var}=\hat\sigma^2_{ML}/n$, $\hat\sigma^2_{ML}=\frac1n\sum_i(y_i-\bar y)^2$.
- **Strategy** ➔ one bootstrap draw $Y^*$ picks each $y_i$ with probability $\frac1n$; the $n$ draws are iid; apply $E$ and $V$ of a mean.
- **Derivation Steps:**
$$
\begin{aligned}
\mathbb{E}[Y^*] &= \sum_{i=1}^{n}\tfrac1n y_i = \bar y \quad\Rightarrow\quad \mathbb{E}[\bar Y^*]=\bar y \quad\Rightarrow\quad \text{bias}=0 \\
\mathbb{V}[Y^*] &= \sum_{i=1}^{n}\tfrac1n(y_i-\bar y)^2 = \hat\sigma^2_{ML} \quad\Rightarrow\quad \mathbb{V}[\bar Y^*]=\frac{\hat\sigma^2_{ML}}{n} \\
\mathbf{y}=(2,6,3):\ \hat\sigma^2_{ML} &= \tfrac13\Big[\big(-\tfrac53\big)^2+\big(\tfrac73\big)^2+\big(-\tfrac23\big)^2\Big] = \tfrac{78}{27} = \tfrac{26}{9} \quad\Rightarrow\quad \text{Var}=\tfrac{26}{27}\approx0.9630
\end{aligned}
$$
- **Q.E.D.** ➔ the bootstrap standard error of a mean is $\hat\sigma_{ML}/\sqrt n$ — the plug-in version of $\sigma/\sqrt n$; for statistics with no such formula, the resampling loop does the same job numerically.

## ⚙️ Core Implementation
### 🔹 Bootstrapping a prediction (lecture code)
> [!code]- Code / Layout Details
> ```r
> df = read.csv("bpdata.csv")
> rv = list(); n = nrow(df); m = 100
> for (i in 1:m) {
>   Ix = sample(n, n, replace = T)                  # n row indices WITH replacement
>   rv[[i]] = lm(BP ~ Weight + Age, data = df[Ix, ]) # whole rows -> pairing kept
> }
> df.test = data.frame(Age = 45, Weight = 90)        # new individual
> yp = rep(0, m)
> for (i in 1:m) yp[i] = predict(rv[[i]], newdata = df.test)
> quantile(yp, c(0.025, 0.975))                      # 95% percentile CI for the predicted mean
> ```
> 💡 **Common Mistake:** **`sample(n, n)` without `replace = T`** ➔ returns a permutation of $1..n$; every fit is identical and the CI collapses to a point.

### 🔹 Bootstrapping any statistic + the exact check
> [!code]- Code / Layout Details
> ```r
> m = 1000; n = length(y); th = rep(0, m)
> for (i in 1:m) th[i] = median(y[sample(n, n, replace = TRUE)])
> mean(th) - median(y)               # bootstrap bias
> var(th); sd(th)                    # bootstrap variance / standard error
> quantile(th, c(0.025, 0.975))      # 95% percentile CI
>
> # exact bootstrap for y = (2,6,3) — expand.grid is my own check, not on the slides
> g = expand.grid(c(2,6,3), c(2,6,3), c(2,6,3))   # all M = 27 ordered resamples
> th = rowMeans(g); mean(th - mean(c(2,6,3)))     # 0
> mean((th - mean(th))^2)                          # 0.963 = 26/27 (divisor M)
> ```
> 💡 **Common Mistake:** **`var()` divides by $m-1$** ➔ the slide's formula divides by $M$; negligible at $m=1000$, visible at $M=27$ ($26/27$ vs $1$).

## ⚖️ Core Decision Matrix
| Resampling method | What is resampled | Draw rule | Estimates | Question answered |
| :--- | :--- | :--- | :--- | :--- |
| [[Cross-Validation]] | rows, split into $K$ disjoint folds | partition, no repeats | prediction error on future data | how well will it predict? |
| **Bootstrap** | whole rows | $n$ **with** replacement | sampling distribution of $\hat\theta$ ➔ bias, se, CI | how variable is my estimate? |
| [[Permutation Tests\|Permutation test]] | targets $y$ only, $x$ fixed | shuffle, **without** replacement | null distribution of an association statistic ➔ $p$-value | is there any association at all? |

> [!NOTE] **When It Flips:** the question, not the data — uncertainty **about** $\hat\theta$ ➔ bootstrap; evidence **against** "no association" ➔ permutation; future predictive error ➔ CV.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Exact bootstrap of $\bar Y$ for $\mathbf{y}=(2,6,3)$, $\hat\theta=\bar y=11/3\approx3.6667$, $M=3^3=27$:

| $i$ | $\mathbf{y}^{(i)}$ | $\hat\theta^{(i)}=\bar y^{(i)}$ |
| :--- | :--- | :--- |
| $1$ | $(2,2,2)$ | $2$ |
| $2$ | $(2,2,6)$ | $3.3333$ |
| $3$ | $(2,2,3)$ | $2.3333$ |
| $4$ | $(2,6,2)$ | $3.3333$ |
| $5$ | $(2,6,6)$ | $4.6667$ |
| $\vdots$ | $\vdots$ | $\vdots$ |
| $25$ | $(3,3,2)$ | $2.6667$ |
| $26$ | $(3,3,6)$ | $4$ |
| $27$ | $(3,3,3)$ | $3$ |

- **Result** ➔ mean of the 27 values $=11/3$ ⟹ $\text{bias}=0$; $\text{Var}=26/27\approx0.9630$. **Order matters**: $(2,2,6)$ and $(2,6,2)$ are separate resamples.

### Applied Exercise
**Problem:** $\mathbf{y}=(1,5)$, statistic $\hat\theta=\max(\mathbf{y})=5$. Exact bootstrap bias and variance.
$$
\begin{aligned}
M &= 2^2 = 4:\quad (1,1)\to1,\ (1,5)\to5,\ (5,1)\to5,\ (5,5)\to5 \\
\bar\theta^* &= \tfrac14(1+5+5+5) = 4 \quad\Rightarrow\quad \text{bias} = 4-5 = -1 \\
\text{Var} &= \tfrac14\big[(1-4)^2+3\,(5-4)^2\big] = \tfrac{12}{4} = 3
\end{aligned}
$$
**Final Extracted Output:** bias $=-1$, Var $=3$ — unlike the mean, the sample maximum is **biased downward**, and the bootstrap detects it without any distributional theory.

## ⚠️ Common Mistakes
- 💡 **CI for the mean read as an interval for an individual** ➔ percentiles of $\hat y^{(i)}$ bound the **predicted mean** at $(a,w)$; one person's BP varies more.
- 💡 **Bootstrapping training MSE to "fix" optimism** ➔ it quantifies the MSE's variability only; the optimistic bias stays.
- 💡 **Trusting it at tiny $n$** ➔ the surrogate population is only as good as the sample; accuracy improves with $n$, not with $m$.

## 🧠 Active Recall
> [!FAQ]- Why must bootstrap resamples be drawn **with** replacement and of size $n$?
> > [!SUCCESS]- Answer
> > - **Short answer:** with replacement each resample is a fresh iid sample of size $n$ from the surrogate population; without it, size-$n$ resamples are just reorderings of $\mathbf{y}$, so $\hat\theta^{(i)}=\hat\theta$ for order-free statistics and there is no spread to measure.
> > - **Why:** **Mimic repeated sampling** ➔ the empirical distribution puts mass $\frac1n$ on each $y_i$; iid draws from it reproduce how $\hat\theta$ would vary over new samples of size $n$.

> [!FAQ]- CV and the bootstrap both resample the data. What different question does each answer?
> > [!SUCCESS]- Answer
> > - **Short answer:** CV estimates **prediction error on future data**; the bootstrap estimates **how variable an estimate is** (bias, standard error, CI).
> > - **Why:** **Held-out vs resampled-with-replacement** ➔ CV scores each fold on data the model never saw; the bootstrap refits on resamples to approximate the sampling distribution of $\hat\theta$.

> [!FAQ]- Why is the exact bootstrap infeasible for $n=20$, and what replaces it?
> > [!SUCCESS]- Answer
> > - **Short answer:** $M=20^{20}\approx1.05\times10^{26}$ resamples; draw $m\approx1000$ at random instead (the bootstrap algorithm).
> > - **Why:** **Monte Carlo approximation** ➔ $m$ random resamples approximate the exact distribution, improving as $m$ grows.

> [!FAQ]- Why does bagging help a decision tree much more than a linear regression?
> > [!SUCCESS]- Answer
> > - **Short answer:** a tree is low-bias / high-variance — small data changes rebuild it — so averaging trees fitted to resamples cancels that variance; a linear model is already stable, leaving little to cancel.
> > - **Why:** **Averaging cuts variance, not bias** ➔ see [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]].
