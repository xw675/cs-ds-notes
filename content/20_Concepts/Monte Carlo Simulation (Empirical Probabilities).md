---
unit: FIT2086
week: 10
source: [lecture]
domain: [D, E]
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Probability, DataScience/Modelling, Tool/R]
aliases: [Monte Carlo, Monte Carlo method, Monte Carlo simulation, empirical probability, simulation-based methods, simulation based statistical methods, Buffon's needle, resolution of an estimate]
---
# [[Monte Carlo Simulation (Empirical Probabilities)]]

**Context:** [[FIT2086_MOC]] · W10 opens the simulation half of LO4 — replace mathematical ingenuity with **computational power** · convergence is the WLLN from [[Expectations and Covariance (FIT2086)]] · draws come from a [[Pseudo-Random Number Generators|PRNG]] via [[R Simulation and Random Sampling]] · applied to estimators in [[Monte Carlo Estimator Comparison]], to the data itself in [[Bootstrap]] and [[Permutation Tests]]
**Parent Framework:** [[Statistical Modelling and Inference]]

> [!abstract] Quick Revision
> - **🎯 Objective:** any $\mathbb{P}((X_1,\dots,X_p)\in Z)$ ➔ simulate $m$ draws ➔ **average the indicators** ➔ WLLN guarantees convergence ➔ answers problems with no closed form.
> - **📦 Core Components:** generate ➔ check $I(\cdot\in Z)$ ➔ average ➔ converge | **resolution** $1/m$ ➔ need $m\gg1/p$.
> - **⚡ Key Constraint:** an event rarer than $1/m$ is usually never observed ⟹ estimate $=0$; size $m$ so the event is expected **many** times.

## 📝 How It Works
### 1. The General Problem
- **Target** ➔ RVs $X_1,\dots,X_p\in\mathcal{X}$ and a set $Z\subseteq\mathcal{X}^p$ ➔ find $\mathbb{P}((X_1,\dots,X_p)\in Z)$.
- **Hard by hand** ➔ $X_1,X_2\sim N(0,1)$: $\mathbb{P}(\sqrt{\lvert X_1\rvert}+\sqrt{\lvert X_2\rvert}>2)$ · $X_1\sim\text{Poi}(\lambda_1)$, $X_2\sim\text{Poi}(\lambda_2)$: $\mathbb{P}(X_1-X_2^{3/2}>0)$ ➔ answerable analytically but hard; trivial to pose ones that are **impossible**. Simulation **always** gives an answer.
- **Buffon's needle (18th c.)** ➔ $\mathbb{P}(\text{needle crosses a strip line})$ needs integral geometry; simulation needs nothing: drop, record, repeat, estimate $\frac{\#\text{crossings}}{\#\text{drops}}$ (e.g. $7/20=0.35$).

### 2. The Algorithm
1. **Generate** ➔ $(X_1^{(i)},\dots,X_p^{(i)})$ from their **joint** distribution, $i=1,\dots,m$.
2. **Check** ➔ $I\big((X_1^{(i)},\dots,X_p^{(i)})\in Z\big)=1$ if the condition holds, $0$ otherwise.
3. **Average** ➔ $\hat\theta_m=\frac1m\sum_{i=1}^{m}I\big((X_1^{(i)},\dots,X_p^{(i)})\in Z\big)$ — the **empirical probability**.
4. **Converge** ➔ larger $m$ ⟹ more accurate.

### 3. Resolution and Rare Events
- **Resolution** ➔ $1/m$ = the smallest non-zero probability the estimate can take; the estimate moves in steps of $1/m$.
- **Rare events** ➔ $p<1/m$ cannot be estimated well ⟹ choose $m\gg1/p$.
- **Break Q1** ➔ event seen $23$ times in $m=1000$ ⟹ $\hat p=0.023$; $\hat p\to p$ as $m\to\infty$.

### 4. Beyond Probabilities
- **Any distribution summary** ➔ `x` $=m$ draws from $p(x)$: $\mathbb{E}[X]\approx$ `mean(x)` · $\mathbb{V}[X]\approx$ `var(x)` · $Q(0.2)\approx$ `quantile(x, 0.2)` · $p(x)\approx$ `hist(x, probability = TRUE)` ➔ all sharpen as $m$ grows.

## 🧮 Proof Blueprint
- **Theorem** ➔ $\hat\theta_m=\frac1m\sum_{i=1}^{m}I(\mathbf{X}^{(i)}\in Z)\to\theta=\mathbb{P}(\mathbf{X}\in Z)$ as $m\to\infty$.
- **Strategy** ➔ each indicator is a **Bernoulli** RV ⟹ $\hat\theta_m$ is a sample mean ⟹ WLLN.
- **Derivation Steps:**
$$
\begin{aligned}
B_i &= I(\mathbf{X}^{(i)}\in Z)\in\{0,1\},\qquad \mathbb{P}(B_i=1)=\mathbb{P}(\mathbf{X}\in Z)=\theta \;\Rightarrow\; B_i\overset{iid}{\sim}Be(\theta) \\
\hat\theta_m &= \frac1m\sum_{i=1}^{m}B_i \quad\text{(the mean of } m \text{ Bernoulli RVs)} \\
\hat\theta_m &\to \mathbb{E}[B_i]=\theta \quad\text{as } m\to\infty \quad\text{(weak law of large numbers)}
\end{aligned}
$$
- **Q.E.D.** ➔ the empirical probability is consistent for $\theta$; being a Bernoulli mean, its variance is $\theta(1-\theta)/m$ ([[Estimator Quality (Bias, Variance, MSE)|Studio 4 drill]]) — why small-$m$ runs wobble.

## ⚙️ Core Implementation
### 🔹 Monte Carlo in two lines of R
> [!code]- Code / Layout Details
> ```r
> X = rnorm(m, 0, 1)          # m draws of X ~ N(0,1)
> mean(sqrt(abs(X)) > 1)      # logical vector -> mean = proportion TRUE = empirical probability
> ```
> 💡 **Common Mistake:** **`hist(x, Probability = T)` as printed on the slide** ➔ R's argument is lowercase `probability` (or `freq = FALSE`); the capitalised name is not matched and the y-axis stays as **counts**.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
$X\sim N(0,1)$, target $\mathbb{P}(\sqrt{\lvert X\rvert}>1)$:

| $m$ | Resolution $1/m$ | Estimate |
| :--- | :--- | :--- |
| $100$ | $0.01$ | $0.3300$ |
| $1{,}000$ | $0.001$ | $0.3310$ |
| $10{,}000$ | $0.0001$ | $0.3179$ |
| $100{,}000$ | $0.00001$ | $0.3176$ |
| $10^9$ | $10^{-9}$ | $0.3172$ |

- **Reading** ➔ convergence is **not monotone** ($m=1000$ is no closer than $m=100$) — each run is random; only the typical error shrinks.

### Applied Exercise
**Problem:** derive the exact value the simulation chases: $X\sim N(0,1)$, $Q=\sqrt{\lvert X\rvert}$, find $\mathbb{P}(Q>1)$ — the slide's CDF route, then the shortcut.
$$
\begin{aligned}
F_Q(q) &= \mathbb{P}(\lvert X\rvert\le q^2) = 2\Phi(q^2)-1 \\
p(q) &= 2\varphi(q^2)\cdot 2q = \left(\frac{2^3}{\pi}\right)^{1/2} q\exp\left(-\frac{q^4}{2}\right),\quad q\ge0 \\
\mathbb{P}(Q>1) &= \int_1^\infty p(q)\,dq = 1-\operatorname{erf}(1/\sqrt2) \\
\text{shortcut: } \mathbb{P}(Q>1) &= \mathbb{P}(\lvert X\rvert>1) = 2\,(1-\Phi(1)) = 2\,(1-0.8413) = 0.3173
\end{aligned}
$$
**Final Extracted Output:** $\mathbb{P}(Q>1)\approx0.317$. The slides print $0.3171$; $1-\operatorname{erf}(1/\sqrt2)=0.31731$ — a rounding slip on the slide, and the $10^9$ run ($0.3172$) agrees with $0.3173$ to within simulation error.

## ⚠️ Common Mistakes
- 💡 **$m$ too small for a rare event** ➔ $\hat p=0$ is not evidence that $p=0$; it means $p\lesssim1/m$.
- 💡 **Sampling each $X_j$ from the wrong law** ➔ draw from the **joint** distribution; independent marginals are only valid when the $X_j$ are independent.
- 💡 **No seed** ➔ the estimate changes every run; `set.seed()` first when the number must be reproduced ([[Pseudo-Random Number Generators]]).

## 🧠 Active Recall
> [!FAQ]- Why does the proportion of simulated draws landing in $Z$ converge to $\mathbb{P}(\mathbf{X}\in Z)$?
> > [!SUCCESS]- Answer
> > - **Short answer:** each indicator is a $Be(\theta)$ RV with $\theta=\mathbb{P}(\mathbf{X}\in Z)$, so the proportion is a sample mean, which the WLLN sends to $\theta$.
> > - **Why:** **Indicator ➔ Bernoulli ➔ WLLN** ➔ $\frac1m\sum I(\mathbf{X}^{(i)}\in Z)\to\mathbb{E}[I]=\theta$ as $m\to\infty$.

> [!FAQ]- You need $\mathbb{P}(A)\approx10^{-5}$ and simulate $m=10^4$ times. What goes wrong, and what $m$ do you need?
> > [!SUCCESS]- Answer
> > - **Short answer:** the expected count is $mp=0.1$, so the estimate is almost always $0$ — below the resolution $1/m=10^{-4}$; take $m\gg10^5$ (e.g. $10^7$, expecting $\approx100$ hits).
> > - **Why:** **Resolution** ➔ the estimate lives on the grid $\{0,\tfrac1m,\tfrac2m,\dots\}$; it can only resolve $p$ once the event is observed many times.
