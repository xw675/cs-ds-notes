---
unit: FIT2086
week: [8, 9]
source: [lecture, applied]
domain: [E, D]
parent: "[[Linear Regression (FIT2086)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Penalised Regression, Penalized Least Squares, Ridge Regression, Ridge, Lasso Regression, Lasso, LASSO, Shrinkage, Regularisation, L1 Penalty, L2 Penalty, Statistical Instability, Multicollinearity, Standardisation, Lambda Path, glmnet]
---
# [[Penalized Regression (Ridge and Lasso)]]

**Context:** [[FIT2086_MOC]] · the stable alternative to all-or-nothing subset search in [[Model Selection and Information Criteria (AIC, BIC)]] · shrinks [[Linear Regression (FIT2086)|least-squares]] coefficients to trade a little bias for less variance ([[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]) · $\lambda$ chosen by [[Cross-Validation]] · in R ➔ [[Penalized Regression in R (glmnet)]] · one-parameter derivation ➔ [[Shrinkage Estimator of the Mean]]

> [!abstract] Quick Revision
> - **🎯 Objective:** minimise $\text{RSS}+\lambda\sum_j g(\beta_j)$ on **standardised** predictors ➔ $\lambda$ sets model complexity ➔ pick $\lambda$ by CV, refit on all the data.
> - **📦 Core Components:** [[#4. Ridge Regression|Ridge]] $g=\beta_j^2$ ➔ stable, never exactly zero | [[#5. Lasso Regression|Lasso]] $g=\lvert\beta_j\rvert$ ➔ sparse, performs variable selection.
> - **⚠️ Key Constraint:** ridge **cannot** select variables; lasso can, but biases large coefficients and struggles with correlated predictors.

## 📝 How It Works
### 1. Statistical Instability of Subset Selection
- **Conventional methods** ➔ all-subsets (score every combination), forward selection, backward selection — intuitive but expensive **or unstable**.
- **Their problems** ➔ **statistically unstable** (small data change ⟹ big model change) · multiple-testing false positives ([[Multiple Testing and the Bonferroni Correction]]) · all-subsets infeasible for moderate-to-large $p$ · stepwise hurt by **correlated predictors** and slow for large $p$.
- **Diabetes experiment** ➔ $n=354$, $p=10$ (AGE, SEX, BMI, BP, S1–S6); remove **one** random sample, search all $2^{10}=1024$ subsets for the smallest CV error, repeat 4 times (same CV partitioning rule each time).

| Test | AGE | SEX | BMI | BP | S1 | S2 | S3 | S4 | S5 | S6 |
| :--- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 1 |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  | ✓ |  |
| 2 |  | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |  |
| 3 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  |  |
| 4 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |  | ✓ |  |

- **Reading** ➔ one observation of 354 flips AGE, S4, S5 in and out ➔ the **all-or-nothing** include/exclude decision makes the "best" model jump with tiny data changes.

### 2. Penalised Least Squares
- **Objective** ➔ penalise the coefficients instead of choosing subsets:
$$
(\hat\beta_0,\hat{\boldsymbol\beta}_\lambda)=\arg\min_{\beta_0,\boldsymbol\beta}\left\{\text{RSS}(\beta_0,\boldsymbol\beta)+\lambda\sum_{j=1}^{p}g(\beta_j)\right\}
$$
- **Contrast** ➔ ordinary least squares minimises goodness-of-fit ($\text{RSS}$) only.
- **Penalty choice** ➔ $g(\cdot)$ **increases with $\lvert\beta_j\rvert$**; the sum runs over $j=1..p$, so the intercept is not penalised.
- **Generalises** ➔ logistic regression becomes **penalised maximum likelihood** (penalty added to the NLL).
- **Standardise first** ➔ penalising "large" coefficients only makes sense if size means strength, but $\beta_j$'s size depends on the predictor's **scale** ⟹ require $\sum_i x_{i,j}=0$ and $\sum_i x_{i,j}^2=n$ via $x^s_{i,j}=\dfrac{x_{i,j}-\bar x_j}{s_j}$ ⟹ larger $\lvert\beta_j\rvert$ means stronger association; $\beta_j=0$ means no association.

### 3. The Hyperparameter $\lambda$ and the Path
- **$\lambda$** ➔ user-chosen **hyperparameter** controlling penalty strength.
- **Limits** ➔ $\lambda\to0$ ⟹ $\hat{\boldsymbol\beta}\to$ least squares; $\lambda$ larger ⟹ $\hat{\boldsymbol\beta}$ smaller.
- **Complexity dial** ➔ varying $\lambda$ traces a **path** of models; moving towards small $\lambda$ the models become **more complex**.
- **Choosing $\lambda$** ➔ (1) vary $\lambda$ over a grid; (2) for each, estimate prediction error by CV; (3) take the $\lambda$ with smallest CV error; (4) refit with that $\lambda$ on **all** the data. AIC/BIC can replace CV.
- **Implementations** ➔ R: the `glmnet` package; MATLAB: `lasso()`, `lassoglm()`.

### 4. Ridge Regression
- **Penalty** ➔ $\ell_2$: $\lambda\sum_{j=1}^{p}\beta_j^2$ — a parabola in $\beta$, steeper for larger $\lambda$.
- **Strengths** ➔ very quick even for large $n$ and $p$ · very stable, low-variance estimates · well suited to **multicollinearity**.
- **Weakness** ➔ cannot set a coefficient exactly to zero ⟹ **no variable selection**.
- **Path shape** ➔ coefficients shrink **smoothly** towards zero as $\lambda$ grows.

### 5. Lasso Regression
- **Penalty** ➔ $\ell_1$: $\lambda\sum_{j=1}^{p}\lvert\beta_j\rvert$ — a V with its corner at $\beta=0$.
- **Strengths** ➔ efficient algorithms · coefficients can be **exactly zero** ⟹ a **sparse** estimator that performs variable selection.
- **Weaknesses** ➔ biased estimates for **large** coefficients · correlated predictors are problematic · can overfit (include unassociated predictors).
- **Path shape** ➔ coefficients hit zero **one by one** as $\lambda$ grows; reading the path right-to-left is the order predictors enter.

### 6. Why Penalisation Helps
- **Advantages** ➔ increased statistical stability · works when $n<p$ · better behaviour with correlated predictors (ridge particularly).
- **Multicollinearity** ➔ $\ge2$ predictors highly correlated ⟹ hard to separate their relationships with the target ⟹ inflated variance in least squares, and **dramatically** more instability in stepwise methods.
- **Bias–variance motivation** ➔ if the linear model is correct, OLS is **unbiased but can have high variance**; shrinking towards zero deliberately adds bias to cut variance ⟹ a good $\lambda$ lowers $\text{MSE}_f=\text{bias}^2+\text{variance}$.
- **Irreducible error untouched** ➔ $\sigma^2$ in prediction error does not depend on $\lambda$.
- **Hand-derivable case (Studio 8)** ➔ ridge on an intercept alone gives $\hat\mu(c)=\frac{n}{n+c}\bar Y$: bias $-\frac{c\mu}{n+c}$, variance $\frac{n\sigma^2}{(n+c)^2}$ ➔ [[Shrinkage Estimator of the Mean]].
- **Small-$n$ evidence (Studio 8)** ➔ Pima, $n=100$, $p=59$: plain `glm` AUC $0.618$ · backward BIC $0.623$ · lasso $0.789$ · ridge $0.795$ ⟹ penalisation degrades gracefully where stepwise collapses; at $n=668$ lasso only matches stepwise ➔ [[Penalized Regression in R (glmnet)]].

## ⚖️ Core Decision Matrix
| Method | Penalty | Exact zeros? | Stability | Correlated predictors | Main weakness |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Subset / stepwise** | none (discrete in/out) | yes | **unstable** | makes stepwise worse | infeasible or slow for large $p$ |
| **Ridge** | $\lambda\sum\beta_j^2$ | no | very stable | handles well | no variable selection |
| **Lasso** | $\lambda\sum\lvert\beta_j\rvert$ | yes (sparse) | more stable than subsets | problematic | biases large coefficients; can overfit |

> [!NOTE] **When It Flips:** need a **reduced predictor set** ➔ lasso; predictors heavily **correlated** and only prediction matters ➔ ridge.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Lasso on the degree-20 polynomial example ($x,x^2,\dots,x^{20}$, true order 5), decreasing $\lambda$:

| $\lambda$ | $\text{RSS}$ | $\sum\lvert\hat\beta_j\rvert$ | CV error | DF (non-zero terms) |
| :--- | :--- | :--- | :--- | :--- |
| $2.414$ | $625.85$ | $0.00$ | $12.93$ | $0$ (flat line) |
| $0.868$ | $357.82$ | $5.63$ | $8.58$ | $2$ |
| $0.312$ | $238.42$ | $12.66$ | $5.84$ | $3$ |
| **$0.112$** | $196.46$ | $17.44$ | **$5.21$** | **$4$** |
| $0.040$ | $189.05$ | $19.78$ | $7.08$ | $5$ |
| $0.014$ | $184.49$ | $27.86$ | $11.22$ | $7$ |
| $0.005$ | $171.19$ | $89.13$ | $14.83$ | $9$ |
| $0.002$ | $166.31$ | $150.12$ | $19.22$ | $11$ |
| $0.001$ | $161.23$ | $311.90$ | $19.67$ | $15$ |
| $0.000$ | $157.60$ | $542.90$ | $18.45$ | $18$ |

- **Read it** ➔ $\text{RSS}$ falls **monotonically** as $\lambda\downarrow$ (in-sample fit always improves) while CV error is **U-shaped** ➔ selected $\lambda=0.112$ with 4 active terms; beyond it $\sum\lvert\hat\beta_j\rvert$ explodes and the curve wiggles (overfit).

## ⚠️ Common Mistakes
- 💡 **Skipping standardisation** ➔ the penalty then punishes predictors for their **units**, not their weakness.
- 💡 **Choosing $\lambda$ by $\text{RSS}$** ➔ RSS always prefers $\lambda=0$; use CV (or AIC/BIC).
- 💡 **Claiming ridge selects variables** ➔ ridge shrinks but never zeroes; only lasso gives exact zeros.
- 💡 **Reporting the CV-fold fit** ➔ after picking $\lambda$, refit on **all** the data.

## 🧠 Active Recall
> [!FAQ]- Why is all-subsets selection unstable, and why does shrinkage help?
> > [!SUCCESS]- Answer
> > - **Short answer:** Each predictor is either fully in or fully out, so a tiny data change can flip the choice and the whole model jumps; a penalty moves coefficients **continuously**, so small data changes give small coefficient changes.
> > - **Why:** **Discrete vs continuous** ➔ the diabetes experiment flipped AGE/S4/S5 after removing one of 354 points; $\hat{\boldsymbol\beta}_\lambda$ varies smoothly with the data and with $\lambda$.

> [!FAQ]- Why can lasso set coefficients exactly to zero while ridge cannot?
> > [!SUCCESS]- Answer
> > - **Short answer:** The $\ell_1$ penalty keeps a constant pull towards zero even for tiny coefficients (its V has a corner at $0$), while the $\ell_2$ penalty's pull vanishes as $\beta_j\to0$ (flat-bottomed parabola).
> > - **Why:** **Penalty shape** ➔ $\lambda\lvert\beta_j\rvert$ vs $\lambda\beta_j^2$ — the lecture plots show the V and the parabola; the paths show lasso coefficients hitting zero and ridge ones only approaching it.

> [!FAQ]- If OLS is unbiased, how can a biased penalised estimator predict better?
> > [!SUCCESS]- Answer
> > - **Short answer:** Error is $\text{bias}^2+\text{variance}$; shrinkage adds a little bias but can remove much more variance.
> > - **Why:** **Bias–variance trade** ➔ $\lambda$ controls the exchange; $\sigma^2$ is unaffected, so the whole gain comes from the variance term.
