---
unit: FIT2086
week: 6
source: [lecture]
domain: [E, D]
parent: "[[Statistical Modelling and Inference]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Simple Linear Regression, Multiple Linear Regression, Least Squares, LS estimates, R-squared, RSS, TSS, Coefficient of Determination, Residual]
---
# [[Linear Regression (FIT2086)]]

**Context:** [[FIT2086_MOC]] · the first **supervised** model of the unit — [[Maximum Likelihood Estimation|point estimation]], [[Confidence Intervals|intervals]] and [[Hypothesis Testing|testing]] now applied to a mean that **varies with predictors** · the rigorous version of [[Linear and Polynomial Regression]] · fit ≡ ML ➔ [[Least Squares as Maximum Likelihood]] · design-matrix tricks ➔ [[Predictor Transformations (Indicators, Polynomials, Interactions)]] · choosing which predictors ➔ [[Model Selection and Information Criteria (AIC, BIC)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** let the **conditional mean** of $Y$ move linearly with the predictors ➔ estimate $\boldsymbol\beta$ by least squares ➔ predict, and read one coefficient at a time.
> - **📦 Core Components:** simple $\hat y=\beta_0+\beta_1x$ ➔ 2 free parameters | multiple $\beta_0+\sum_j\beta_jx_j$ ➔ $p+1$ | fit measured by $\text{RSS}$ | scale-free fit by $R^2$.
> - **⚡ Key Constraint:** $R^2$ **always** rises when a predictor is added ➔ it can rank fit but can **never** choose a model; and least squares needs $p<n$ or the solution is non-unique.

## 📝 How It Works
### 1. Supervised Learning Setup
- **Data shape** ➔ $p+1$ variables measured on $n$ individuals; predict one variable from the remaining $p$.
- **Target $y$** ➔ also *response* / *outcome*; treated as a **random variable** $Y_i$ because measurement carries error.
- **Predictors $x_{i,j}$** ➔ also *explanatory variables* / *covariates* / *exposures*; assumed **known without error**.
- **Task split** ➔ categorical target ⟹ **classification** (W7); numerical target ⟹ **regression** (here).
- **What is learned** ➔ an $f(\cdot)$ with $y_i\approx f(x_{i,1},\dots,x_{i,p})$; "supervised" because labelled examples exist. No $f$ fits perfectly.

### 2. From the Mean Model to a Line
- **Baseline** ➔ $\mathbb{E}[BP_i]=\mu$, $\hat\mu=\bar y=114$ — one prediction for **everybody**, ignoring all other data.
- **Upgrade** ➔ $\mathbb{E}[BP_i\mid \text{Weight}_i]=\beta_0+\beta_1\text{Weight}_i$ — the mean is now **conditional** on the predictor.
- **Strict nesting** ➔ $\beta_1=0$ collapses the line back to the mean model with $\beta_0=\mu$ ⟹ the mean model is a **submodel**, which is exactly why it serves as the $R^2$ reference.
- **Payoff on the BP data** ➔ $\text{RSS}$ falls $560\to120$ by using weight alone.

### 3. Reading the Parameters
- **Simple form** ➔ $\mathbb{E}[Y_i\mid x_i]=\hat y_i=\beta_0+\beta_1x_i$ ➔ $\beta_0$ is the **intercept** ($\hat y$ at $x=0$), $\beta_1$ the **regression coefficient** (change in $\hat y$ per **one unit** of $x$).
- **Multiple form** ➔ $\mathbb{E}[y_i\mid x_{i,1},\dots,x_{i,p}]=\beta_0+\sum_{j=1}^{p}\beta_jx_{i,j}$ ➔ $\beta_0$ is $\hat y$ when **all** $x_{i,j}=0$; $\beta_j$ is the change per unit of $x_j$ **with the others held fixed**.
- **Worked reading** ➔ $\hat y=2.2053+1.2009x$ (BP on weight): $+1\,\text{kg}\Rightarrow+1.2009\,\text{mmHg}$ average BP; at $0\,\text{kg}$ the model says $2.2053\,\text{mmHg}$ — a nonsense **extrapolation** outside the observed range.
- **Magnitude is not importance** ➔ $\lvert\hat\beta_j\rvert$ depends on the predictor's **units**, so it cannot rank predictors ➔ standardise or use the $t$-score ([[Model Selection and Information Criteria (AIC, BIC)]]).

### 4. Fitting by Least Squares
- **Residual** ➔ $e_i=y_i-\hat y_i$ — the model's error on an observation it was fitted to.
- **Least-squares principle** ➔ pick the coefficients minimising the squared total error; **smaller $\text{RSS}$ = better fit**.
- **Stationary equations** ➔ set both partials to zero (chain rule), then solve the resulting linear system:
$$
\begin{aligned}
\frac{\partial \text{RSS}}{\partial\beta_0} &= -2\sum_{i=1}^{n}(y_i-\beta_0-\beta_1x_i)=0 \\
\frac{\partial \text{RSS}}{\partial\beta_1} &= -2\sum_{i=1}^{n}x_i(y_i-\beta_0-\beta_1x_i)=0
\end{aligned}
$$
- **Two free properties of the solution** ➔ $\sum_{i=1}^{n}e_i=0$ and $\operatorname{corr}(\mathbf{x},\mathbf{e})=0$ — the fitted line leaves **zero mean residual** and residuals **uncorrelated with the predictor**. Structure left in a residual plot is therefore *not* linear-in-$x$ structure ➔ it signals a needed transformation.
- **Identifiability** ➔ requires $p<n$; with $p\ge n$ the minimiser is **non-unique**. Efficient algorithms solve the multiple-predictor case directly.
- **Alternative losses exist** ➔ e.g. least **absolute** errors; squares win on simplicity, computational efficiency, and the normal-model connection.

### 5. $R^2$ — the Scale-Free Fit Score
- **Why not $\text{RSS}$** ➔ its scale is arbitrary; $\text{RSS}=2352$ means nothing without a reference.
- **Reference** ➔ $\text{TSS}=\sum_{i=1}^n(y_i-\bar y)^2$ — the $\text{RSS}$ of the **intercept-only mean model**.
- **Definition** ➔ $R^2=1-\dfrac{\text{RSS}}{\text{TSS}}$, the **coefficient of determination**; $0$ = no explanatory power, $1$ = data fully explained.
- **Monotone in predictors** ➔ adding any predictor **always** increases $R^2$ ➔ a predictor that raises it *a lot* is potentially important, but the ranking cannot be used to stop adding.

### 6. Predicting New Data
- **Point prediction** ➔ $\hat y=\hat\beta_0+\sum_{j=1}^{p}\hat\beta_jx'_j$ for new predictor values $x'_1,\dots,x'_p$.
- **Full predictive distribution** ➔ the normal error model gives $\hat Y\sim N\!\left(\hat\beta_0+\sum_j\hat\beta_jx'_j,\ \sigma^2\right)$ ➔ probability statements, not just a number ([[Plug-in Prediction and Held-Out Evaluation]]).
- **Sensitivity reading** ➔ sweep one predictor, hold the rest, and watch $\hat y$ move — this is how a fitted model answers "what if".
- **Range discipline** ➔ predictions outside the observed predictor ranges are unsupported by the data.

## 🔬 Model
- **Declared spaces** ➔ $\mathbf{y}\in\mathbb{R}^{n}$, design matrix $X\in\mathbb{R}^{n\times p}$ (plus an intercept column), $\boldsymbol\beta\in\mathbb{R}^{p}$, $\beta_0\in\mathbb{R}$.
- **Mean function** ➔ $\mathbb{E}[Y_i\mid \mathbf{x}_i]=\beta_0+\sum_{j=1}^{p}\beta_jx_{i,j}$; only the **mean** is modelled — the spread $\sigma^2$ is constant across $\mathbf{x}$.
- **Objective (least squares)** ➔
$$
(\hat\beta_0,\hat{\boldsymbol\beta})=\arg\min_{\beta_0,\boldsymbol\beta}\ \text{RSS}(\beta_0,\boldsymbol\beta),\qquad
\text{RSS}=\sum_{i=1}^{n}\Big(y_i-\beta_0-\sum_{j=1}^{p}\beta_jx_{i,j}\Big)^{2}=\sum_{i=1}^{n}e_i^{2}
$$
- **Noise model** ➔ $Y_i\mid\mathbf{x}_i\sim N\big(\beta_0+\sum_j\beta_jx_{i,j},\,\sigma^2\big)$ independently ⟹ the LS estimates **are** the ML estimates ➔ derivation and the two $\hat\sigma^2$ estimators in [[Least Squares as Maximum Likelihood]].

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise
**Problem:** On the $n=20$ blood-pressure data the mean model gives $\text{RSS}=560$. Regressing $BP$ on weight gives $\text{RSS}=120$; adding age gives $\mathbb{E}[BP\mid W,A]=-16.57+1.03W+0.71A$ with $\text{RSS}=4.82$. Report both $R^2$ values and predict $BP$ for a $95\,\text{kg}$, $50$-year-old.
$$
\begin{aligned}
R^2_{\text{weight}} &= 1-\frac{120}{560}=0.786 \\
R^2_{\text{weight+age}} &= 1-\frac{4.82}{560}=0.991 \\
\hat y &= -16.57+1.03(95)+0.71(50) \\
&= -16.57+97.85+35.50=116.78
\end{aligned}
$$
**Final Extracted Output:** $R^2$ rises $0.786\to0.991$; predicted $BP\approx116.8\,\text{mmHg}$. Each extra kilogram adds $1.03\,\text{mmHg}$, each extra year $0.71\,\text{mmHg}$.

## ⚠️ Common Mistakes
- 💡 **Using $R^2$ to pick a model** ➔ it is **monotone** in the predictor count, so the full model always wins ➔ a complexity penalty is required ([[Model Selection and Information Criteria (AIC, BIC)]]).
- 💡 **Comparing raw $\lvert\hat\beta_j\rvert$ across predictors** ➔ scale-dependent; $\hat\beta_1=2.5$ vs $\hat\beta_2=-4$ says **nothing** about importance unless the predictors share a scale or are standardised.
- 💡 **Interpreting the intercept literally** ➔ $\beta_0$ is $\hat y$ at $\mathbf{x}=\mathbf{0}$, which is usually far outside the data (a $0\,\text{kg}$ person).
- 💡 **Forgetting "holding the others fixed"** ➔ in multiple regression $\beta_j$ is a **partial** effect; a coefficient can change sign when other predictors enter.

## 🧠 Active Recall
> [!FAQ]- Why is the mean model the right reference for $R^2$, and what does that force $R^2$ to measure?
> - **Hint:** Set $\beta_1=0$.
> > [!SUCCESS]- Answer
> > - **Short answer:** The mean model is the linear model with all slopes zero, so $\text{TSS}$ is the $\text{RSS}$ of the *worst sensible* competitor; $R^2$ is the **fraction of that baseline error removed** by the predictors.
> > - **Why:** **Nested submodel** ➔ $\beta_1=0\Rightarrow\beta_0=\mu$, so $\text{RSS}\le\text{TSS}$ always and $R^2=1-\text{RSS}/\text{TSS}\in[0,1]$.

> [!FAQ]- Residuals from a least-squares fit are uncorrelated with $x$ by construction. What does a **curved** residual-vs-$x$ plot then tell you?
> - **Hint:** Zero correlation ≠ no structure.
> > [!SUCCESS]- Answer
> > - **Short answer:** Not that the fit failed on linear structure — that structure is already removed — but that the relationship is **nonlinear** in $x$, so the predictor needs transforming.
> > - **Why:** **$\operatorname{corr}(\mathbf{x},\mathbf{e})=0$ is forced** ➔ any remaining pattern must be non-linear ➔ apply $\log x$ or a polynomial expansion ([[Predictor Transformations (Indicators, Polynomials, Interactions)]]).

> [!FAQ]- Why must least squares assume $p<n$?
> > [!SUCCESS]- Answer
> > - **Short answer:** With at least as many free coefficients as observations the minimiser is **non-unique** — infinitely many coefficient vectors drive $\text{RSS}$ to the same (often zero) value.
> > - **Why:** **Underdetermined system** ➔ the $p+1$ stationary equations no longer pin down a single solution, so $\hat{\boldsymbol\beta}$ is not identifiable.
