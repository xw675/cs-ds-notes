---
unit: FIT2086
week: 6
source: [lecture]
domain: E
parent: "[[Linear Regression (FIT2086)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Indicator Variables, Dummy Variables, Categorical Predictors, Polynomial Regression, Interaction Terms, Design Matrix, Nonlinear effects]
---
# [[Predictor Transformations (Indicators, Polynomials, Interactions)]]

**Context:** [[FIT2086_MOC]] · how a model that is **linear in the coefficients** still fits categories, curves and conditional effects — by rewriting the **columns**, never the fitting machinery of [[Linear Regression (FIT2086)]] · more columns ⟹ more complexity to police ➔ [[Model Selection and Information Criteria (AIC, BIC)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** detect the shortfall (a category, a curved residual plot, a conditional effect) ➔ add the right **new columns** to the design matrix ➔ re-fit by ordinary least squares.
> - **📦 Core Components:** $K$ categories ➔ $K-1$ **indicators** | curvature ➔ $\log x$ or $x,x^2,\dots,x^q$ | conditional effect ➔ the **product** $x_jx_k$.
> - **⚡ Key Constraint:** "linear" means linear in $\boldsymbol\beta$, **not** in $x$ — so every transformation below leaves the model a linear regression, and every one of them buys flexibility at the price of **overfitting risk**.

## 📝 How It Works
### 1. Categorical Predictors ➔ Indicator Variables
- **Why not use the codes** ➔ a category coded $1,2,3,4$ is a **label**, not a quantity; adding or multiplying it is meaningless and would force an arbitrary equal-spacing.
- **Construction** ➔ $K$ categories become $K-1$ **indicator** (dummy) columns, each $1$ when the individual is in that category and $0$ otherwise.
- **The dropped category is the baseline** ➔ no indicator is built for the **first** category; every other coefficient is the increase in the target **relative to that baseline**.
- **Coding table** ➔ for a 4-level variable (North/East/South/West):

| Category | `Ind2` | `Ind3` | `Ind4` | Reading |
| :--- | :--- | :--- | :--- | :--- |
| North *(baseline)* | 0 | 0 | 0 | intercept only |
| East | 1 | 0 | 0 | intercept $+\beta_{2}$ |
| South | 0 | 1 | 0 | intercept $+\beta_{3}$ |
| West | 0 | 0 | 1 | intercept $+\beta_{4}$ |

### 2. Nonlinear Effects ➔ Transform the Predictor
- **Diagnostic** ➔ plot **residuals against a predictor**; a curve or trend means a transformation is needed (a linear fit cannot leave linear-in-$x$ structure behind, so a visible bend is genuinely nonlinear).
- **Log transform** ➔ $x_{i,j}\Rightarrow\log x_{i,j}$; use when the predictor is **more variable at larger values**. Requires **all $x_i>0$**.
- **Polynomial expansion** ➔ $x_{i,j}\Rightarrow x_{i,j},x^2_{i,j},x^3_{i,j},\dots,x^q_{i,j}$ — a general-purpose nonlinear fit; higher $q$ = more flexibility **and** more overfitting risk.
- **Payoff on the lecture data** ➔ $\hat y=-1.07+9.55x$ gives $R^2=0.95$ but curved residuals; $\hat y=-0.02+2.16x+7.77x^2$ gives $R^2=0.999$.
- **Reading a quadratic** ➔ the **sign of the $x^2$ coefficient** carries the shape: positive ⟹ initially decreasing then increasing returns (a $\cup$), negative ⟹ diminishing returns (a $\cap$).

### 3. Interactions ➔ Multiply Two Predictors
- **The claim being modelled** ➔ the effect of predictor $j$ on the target **depends on the value of** predictor $k$.
- **Construction** ➔ append one new design-matrix column equal to $x_{i,j}\times x_{i,k}$; fit as usual.
- **Reading the sign** ➔ with both main effects negative, a **positive** interaction means their combined negative effect is **weakened** when both rise together.
- **Practical note** ➔ most packages build interaction columns for you (in R, `y ~ a*b` expands to `a + b + a:b`).

## ⚖️ Core Decision Matrix
| Transformation | Trigger condition | New columns added | What the coefficient means | Cost |
| :--- | :--- | :--- | :--- | :--- |
| **Indicators** | predictor is categorical with $K$ levels | $K-1$ | shift vs the **baseline** category | $K-1$ parameters for one variable |
| **Log** | spread of $x$ grows with $x$; all $x_i>0$ | $0$ *(replaces the column)* | effect per unit of $\log x$ ➔ multiplicative in $x$ | undefined at $x\le0$ |
| **Polynomial degree $q$** | residual-vs-$x$ plot bends | $q-1$ | curvature, read off the sign of the top term | overfits fast as $q$ grows |
| **Interaction $x_jx_k$** | effect of $j$ believed to depend on $k$ | $1$ per pair | how the effect of $j$ changes per unit of $k$ | pairs explode combinatorially |

> [!NOTE] **When It Flips:** a **transformation** keeps the column count flat and is the cheap first move; a **polynomial expansion** buys arbitrary curvature but is the point at which [[Model Selection and Information Criteria (AIC, BIC)|an information criterion]] must decide $q$ — $R^2$ will keep rising to $q=20$ and beyond.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise
**Problem:** Cooling load is fitted with orientation coded by indicators `Orient2` (East), `Orient3` (South), `Orient4` (West), baseline North:
$\mathbb{E}[\text{Cooling}]=275.94511-152.73246\,C-0.26473\,S+0.12104\,W+0.10117\,H+0.30194\,O_2+0.18197\,O_3+0.64121\,O_4+14.78224\,P$.
Predict for compactness $C=0.5$, surface $S=500$, wall $W=300$, height $H=8$, orientation **East**, window proportion $P=0.5$.
$$
\begin{aligned}
(O_2,O_3,O_4) &= (1,0,0) \quad\text{(East)} \\
\mathbb{E}[\text{Cooling}] &= 275.94511-152.73246(0.5)-0.26473(500)+0.12104(300) \\
&\quad +0.10117(8)+0.30194(1)+0.18197(0)+0.64121(0)+14.78224(0.5) \\
&= 275.94511-76.36623-132.36500+36.31200+0.80936+0.30194+7.39112 \\
&= 112.03
\end{aligned}
$$
**Final Extracted Output:** $112.03\ \text{kW}$. Only the **East** indicator fires; South and West contribute exactly zero, and North would have zeroed all three.

### Applied Exercise 2
**Problem:** Internet sales on website hits ('000): intercept $32.010$; hits $-29.621$ ($p=0.0516$); hits$^2$ $+6.056$ ($p=1.40\times10^{-5}$). Characterise the nonlinearity and judge the model.
**Final Extracted Output:** $\hat y=32.01-29.62x+6.06x^2$ — a $\cup$ shape: returns to hits are **initially decreasing, then increasing**. The quadratic term is **highly significant**, so the evidence for nonlinearity is strong; the linear term is only **marginally insignificant** at the $5\%$ level, so the model is moderately reasonable and the curvature is the real finding.

## ⚠️ Common Mistakes
- 💡 **Building $K$ indicators instead of $K-1$** ➔ the full set is perfectly collinear with the intercept ⟹ the LS solution stops being unique; the omitted level **is** the baseline.
- 💡 **Reading an indicator coefficient as an absolute level** ➔ $\hat\beta_{O_2}=0.30194$ is East **relative to North**, not East's predicted value.
- 💡 **Treating a coded category as a number** ➔ regressing on the raw codes $1,2,3,4$ silently asserts that "South $-$ East $=$ East $-$ North".
- 💡 **Chasing $R^2$ with polynomial degree** ➔ $R^2$ rises monotonically in $q$; a degree-$20$ fit will look best and generalise worst.

## 🧠 Active Recall
> [!FAQ]- A polynomial regression fits a curve. In what sense is it still a **linear** model?
> - **Hint:** Linear in what?
> > [!SUCCESS]- Answer
> > - **Short answer:** Linear in the **coefficients** — $x,x^2,\dots,x^q$ are just extra columns, and the model is still $\beta_0+\sum_j\beta_jz_{i,j}$ with $z$ a fixed function of the data.
> > - **Why:** **Least squares is untouched** ➔ the same stationary equations and the same $\arg\min\text{RSS}$ solve it; only the design matrix changed.

> [!FAQ]- Why is a categorical predictor with $K$ levels given only $K-1$ indicators, and what does the intercept then mean?
> > [!SUCCESS]- Answer
> > - **Short answer:** The $K$-th indicator is redundant — the baseline is identified by all others being $0$ — and including it makes the design collinear with the intercept. The intercept then holds the baseline category's predicted value (with the other predictors at zero).
> > - **Why:** **Relative coding** ➔ each $\hat\beta$ is the shift **from** the omitted level, so changing the baseline changes every indicator coefficient but not a single prediction.
