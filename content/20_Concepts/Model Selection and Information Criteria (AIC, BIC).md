---
unit: FIT2086
week: [6, 8]
source: [lecture]
domain: [E, D]
parent: "[[Linear Regression (FIT2086)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [AIC, BIC, Akaike Information Criterion, Bayesian Information Criterion, Model Selection, Penalised Likelihood, Stepwise Selection, Forward Selection, All Subsets, t-score, KIC, Kullback-Leibler Information Criterion, RIC, Risk Inflation Criterion, Backward Selection]
---
# [[Model Selection and Information Criteria (AIC, BIC)]]

**Context:** [[FIT2086_MOC]] · **which predictors to include** in a [[Linear Regression (FIT2086)|linear regression]] — the question $R^2$ and the likelihood cannot answer because both improve monotonically · legal only because [[Least Squares as Maximum Likelihood|LS ≡ ML]] gives regression a likelihood · complexity framing ➔ [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]] · run it ➔ [[Multiple Regression and Stepwise Selection in R]] · resampling alternative ➔ [[Cross-Validation]] · stable alternative ➔ [[Penalized Regression (Ridge and Lasso)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** score a model as **fit + complexity penalty** ➔ $L(\mathbf{y}\mid\hat\beta_0,\hat{\boldsymbol\beta},\hat\sigma^2_{ML},M)+\alpha(n,k_M)$ ➔ **smaller score wins**.
> - **📦 Core Components:** AIC $\alpha=k_M$ ➔ mild penalty, overfits | BIC $\alpha=\tfrac{k_M}{2}\log n$ ➔ harsh penalty, underfits | KIC $\tfrac32k_M$ | RIC $k_M\log p$ ➔ for very large $p$.
> - **⚡ Key Constraint:** the **minimised NLL always falls** as predictors are added (exactly like $R^2$ rising) ➔ it selects **parameters**, never **models**; only the penalty makes comparison possible.

## 📝 How It Works
### 1. Why a Criterion Is Needed
- **The two failure directions** ➔ under- vs overfitting, defined in predictor-selection terms in [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]].
- **Both in-sample diagnostics fail** ➔ the minimised NLL always **falls** with an extra predictor, exactly as $R^2$ always rises ⟹ it selects **parameters**, never **models**.
- **The fix** ➔ **penalised likelihood**: charge a model for its ability to fit, not just measure the fit.

### 2. Approach A — Testing One Coefficient at a Time
- **Coefficient magnitude fails** ➔ $\lvert\hat\beta_j\rvert$ depends on the predictor's units.
- **$t$-score** ➔ $t_j=\dfrac{\hat\beta_j}{\operatorname{se}(\hat\beta_j)}$ ➔ **larger $\lvert t_j\rvert$ = more important**; it standardises out both the scale and how variable the estimate is.
- **The hypothesis** ➔ predictor $j$ is unimportant exactly when $\beta_j=0$, so test $H_0:\beta_j=0$ vs $H_A:\beta_j\ne0$ — a variant of the [[Tests for Normal Means (z-test and t-test)|$t$-test]] built on $t_j$ *(Ross Ch. 9; Studio 6)*.
- **Strengths** ➔ easy to apply, easy to explain, and every `summary()` prints it.
- **Many tests ⟹ false positives** ➔ screening $p$ predictors at $\alpha$ expects $\alpha p$ spurious hits ➔ [[Multiple Testing and the Bonferroni Correction]] *(W8)*.
- **Weaknesses** ➔ **cannot compare two whole models** directly, and predictors can appear stronger once other unimportant predictors stop **diluting the signal**.

### 3. Approach B — Model Selection by Information Criterion
- **A "model" $M$** ➔ just a **subset of predictors**, e.g. $\{\text{Weight}\}$, $\{\text{Weight},\text{Age}\}$, $\{\text{Age},\text{Stress},\text{Pulse}\}$; given $M$, the coefficients still come from least squares.
- **The score** ➔ minimise over models:
$$
\text{score}(M)=L(\mathbf{y}\mid\hat\beta_0,\hat{\boldsymbol\beta},\hat\sigma^2_{ML},M)+\alpha(n,k_M)
$$
where $k_M$ is the number of predictors in $M$ and $n$ the sample size.
- **Reading it** ➔ score $=$ **model error** $+$ **complexity charge**; the more complex the model, the bigger the charge, so a predictor must **pay for itself** in fit.
- **W8 notation** ➔ $\mathcal{M}$ a candidate model, $\hat{\mathcal{M}}$ it fitted to $\mathbf{y}$, $L(\mathbf{y}\mid\hat{\mathcal{M}})$ its **minimised NLL** (likelihood $p(\mathbf{y}\mid\hat{\boldsymbol\theta})=\prod_i p(y_i\mid\hat{\boldsymbol\theta})$ under conditional independence); for **nested** models adding predictors can never increase $L$.
- **The four criteria** (NLL scale, $k_M$ = number of **free parameters**):
$$
\begin{aligned}
\text{AIC}(\hat{\mathcal{M}}) &= L(\mathbf{y}\mid\hat{\mathcal{M}})+k_M \\
\text{KIC}(\hat{\mathcal{M}}) &= L(\mathbf{y}\mid\hat{\mathcal{M}})+\tfrac{3}{2}k_M \\
\text{BIC}(\hat{\mathcal{M}}) &= L(\mathbf{y}\mid\hat{\mathcal{M}})+\tfrac{k_M}{2}\log n \\
\text{RIC}(\hat{\mathcal{M}}) &= L(\mathbf{y}\mid\hat{\mathcal{M}})+k_M\log p
\end{aligned}
$$
- **Shared parameters don't matter** ➔ parameters present in **every** candidate (e.g. intercept, $\sigma^2$) add the same constant to all scores and never change the choice.
- **Refined criteria** ➔ MML, MDL, corrected AIC/KIC ➔ often better for **small $n$**.
- **Polynomial example** ➔ orders $0$–$20$ fitted to the fifth-order truth: the NLL keeps falling with order while each criterion bottoms out; read off the lecture plot, BIC and KIC select order $5$ and AIC a higher order ($\approx7$).
- **Significance rule of thumb** ➔ score differences of $\ge3$ are considered meaningful; smaller gaps are a tie.

### 4. Searching the Model Space
- **All subsets** ➔ score every combination and take the minimum — **exact**, but $2^p$ models; at $p=50$ that is $\approx1.2\times10^{15}$ ⟹ computationally intractable for even moderate $p$.
- **Forward selection** ➔ (1) start from the **empty** model; (2) find the predictor that reduces the criterion **most**; (3) if none improves it, **stop**; (4) add it; (5) return to step 2.
- **Backward selection** ➔ the mirror image — start from the **full** model and remove predictors.
- **Trade-off** ➔ tractable for large $p$, but a greedy path **may miss important predictors** (a pair that only helps jointly is never entered).
- **Problems with all conventional methods (W8)** ➔ **statistically unstable** — small data change ⟹ big model change ([[Penalized Regression (Ridge and Lasso)]]) · multiple-testing false positives · all-subsets infeasible for moderate-to-large $p$ · stepwise hurt by **correlated predictors** and slow for large $p$.

## ⚖️ Core Decision Matrix
| Criterion | Penalty $\alpha(n,k_M)$ | Behaviour | Risk it carries | Reach for it when |
| :--- | :--- | :--- | :--- | :--- |
| **AIC** | $k_M$ | encourages fit, allows more variables; overfits **even for large $n$**, though moderate overfitting hurts less there | **overfits** — includes spurious predictors | prediction matters more than parsimony; small $n$ with weak signals |
| **KIC** | $\tfrac32k_M$ | like AIC, slightly stricter; often performs better than AIC in practice | still **overfits** (rarely underfits) | AIC's use case, with a little more caution |
| **BIC** | $\tfrac{k_M}{2}\log n$ | prefers simpler models, selects fewer predictors; $P(\text{overfit})\to0$ as $n\to\infty$ | **underfits** at small $n$ — drops genuine predictors | you want an interpretable, defensible predictor set |
| **RIC** | $k_M\log p$ | penalty grows with the **number of candidate predictors** — the multiple-testing idea | can be **quite conservative** | $p$ is very large (recommended over AIC/KIC there) |

> [!NOTE] **When It Flips:** the BIC penalty exceeds the AIC penalty exactly when $\tfrac{k}{2}\log n>k\iff\log n>2\iff n>e^{2}\approx7.4$ ➔ for any realistic sample ($n\ge8$) **BIC is always the stricter criterion**, and the gap widens with $n$.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise
**Problem:** Blood pressure, $n=20$, six candidate predictors (Age, Weight, BSA, Dur, Pulse, Stress). Stepwise selection under AIC returns the **full** 6-predictor model; under BIC it returns $\{\text{Age},\text{Weight},\text{BSA}\}$ with $\mathbb{E}[BP]=-13.67+0.702\,\text{Age}+0.906\,\text{Weight}+4.627\,\text{BSA}$ ($p$-values $3.0\times10^{-11}$, $3.2\times10^{-12}$, $0.00776$). Why do they disagree, and how much extra fit would the three dropped predictors need to buy?
$$
\begin{aligned}
\alpha_{AIC}(20,6)-\alpha_{AIC}(20,3) &= 6-3 = 3 \\
\alpha_{BIC}(20,6)-\alpha_{BIC}(20,3) &= \tfrac{6}{2}\log 20-\tfrac{3}{2}\log 20 = \tfrac{3}{2}(2.9957)=4.494
\end{aligned}
$$
**Final Extracted Output:** Dur, Pulse and Stress must reduce the NLL by more than $3$ to survive AIC but by more than $4.49$ to survive BIC — they clear the first bar and not the second. AIC is **known to be optimistic and to overfit, particularly at small $n$**; with $n=20$ the BIC model is the defensible one. In it, every remaining $p$-value is **smaller** than in the full fit — the removed predictors were diluting the signal. Interpretation: $+1$ year $\Rightarrow+0.702$, $+1\,\text{kg}\Rightarrow+0.906$, $+1\,\text{m}^2$ BSA $\Rightarrow+4.627\,\text{mmHg}$.

## ⚠️ Common Mistakes
- 💡 **Selecting on $R^2$ or on the likelihood** ➔ both are monotone in model size ⟹ they always crown the full model; only a **penalised** score can choose.
- 💡 **Reading a bigger score as a better model** ➔ the criterion is **minimised** — lower AIC/BIC wins, because the score is error plus penalty.
- 💡 **Treating a difference of $1$ as decisive** ➔ differences below $\approx3$ are not considered significant; report the models as comparable.
- 💡 **Mixing up RIC's $p$ and BIC's $n$** ➔ RIC charges $\log p$ with $p$ = **total candidate predictors**; BIC charges $\tfrac12\log n$ with $n$ = **sample size**.
- 💡 **Trusting a stepwise path as exhaustive** ➔ forward/backward selection is **greedy**; it is not the all-subsets optimum and can miss jointly-useful predictors.
- 💡 **Reporting post-selection $p$-values as if pre-planned** ➔ they shrink precisely *because* competitors were removed; the selection step already used the data.

## 🧠 Active Recall
> [!FAQ]- The minimised negative log-likelihood always decreases as predictors are added. Why does that make it useless for choosing a model but fine for choosing parameters?
> - **Hint:** What is being ranked in each case?
> > [!SUCCESS]- Answer
> > - **Short answer:** Within one model the parameter space is fixed, so the smallest NLL genuinely identifies the best coefficients; **across** models the larger model can always mimic the smaller one and then use its spare freedom to fit noise, so NLL ranks by **flexibility**, not by quality.
> > - **Why:** **Nested models** ➔ $M_{\text{small}}\subset M_{\text{big}}$ ⟹ $\min L_{\text{big}}\le\min L_{\text{small}}$ always ➔ the fix is $L+\alpha(n,k_M)$, which charges for the extra freedom.

> [!FAQ]- Why does BIC drop predictors that AIC keeps, and which should you trust at $n=20$?
> > [!SUCCESS]- Answer
> > - **Short answer:** BIC's per-predictor charge $\tfrac{1}{2}\log n$ exceeds AIC's flat $1$ for any $n>e^2\approx7.4$, so each predictor must buy strictly more fit to survive BIC. At $n=20$ AIC is known to be optimistic and to overfit, so the BIC subset is the defensible one.
> > - **Why:** **Penalty scaling** ➔ AIC's penalty is constant in $n$ while BIC's grows like $\log n$ ➔ AIC is less likely to underfit, BIC less likely to overfit.

> [!FAQ]- Why is the all-subsets approach abandoned in practice, and what is given up by replacing it?
> > [!SUCCESS]- Answer
> > - **Short answer:** It requires scoring $2^p$ models — $\approx1.2\times10^{15}$ at $p=50$. Forward/backward selection is tractable but **greedy**, so it can miss important predictors.
> > - **Why:** **Exhaustive vs greedy** ➔ all-subsets guarantees the criterion-optimal subset; stepwise only guarantees a local improvement path from its starting model.

> [!FAQ]- You have $p=5000$ candidate predictors. Why might RIC beat AIC or KIC here?
> > [!SUCCESS]- Answer
> > - **Short answer:** With thousands of candidates, many will look useful by chance; RIC's per-parameter charge $\log p$ grows with the size of the search, so spurious predictors struggle to pay for themselves, while AIC/KIC's fixed charge lets them in.
> > - **Why:** **Multiple-testing idea** ➔ the more predictors you search, the more false positives ([[Multiple Testing and the Bonferroni Correction]]); $\log 5000\approx8.5$ vs AIC's $1$ and KIC's $1.5$ per parameter.
