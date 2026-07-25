---
unit: FIT1043
week: [5, 6]
parent: "[[Machine Learning Styles (Supervised vs Unsupervised)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Linear Regression, Polynomial Regression, Least Squares, Learning Curve, MSE, Regression]
---
# [[Linear and Polynomial Regression]]

**Context:** [[FIT1043_MOC]] · a supervised [[Machine Learning Styles (Supervised vs Unsupervised)|regression]] method · fits an equation by minimising a [[Learning Theory and Loss Functions|loss]] · a real-valued [[Predictive Models|predictive model]] · complexity governed by the [[Bias-Variance Tradeoff (Underfitting vs Overfitting)|bias–variance tradeoff]]

> [!abstract] Quick Revision
> - **🎯 Objective:** fit an equation to $(x,y)$ data ➔ study a relationship and predict a real $y$ for a new $x$.
> - **📦 Core Components:** linear $\hat y = a_0 + a_1 x$ (intercept, slope) | polynomial = same machinery, higher degree.
> - **⚡ Key Constraint:** the parameters are chosen to **minimise the loss** (MSE = mean squared residuals) over the training pairs — not to pass through every point.

## 📝 How It Works
### 0. Terminology & When to Use
- **Regression** ➔ the study of the **relationship between variables** (e.g. salary ~ experience, education, role).
- **Independent variables** ➔ inputs / predictors (categorical or continuous), e.g. experience, education, role.
- **Dependent variable** ➔ output / response (**continuous**), e.g. salary.
- **Observation** ➔ one data point / row / sample.
- **When to use** ➔ (1) determine **how variables relate** (does education affect salary?); (2) **forecast** a value (electricity use given temperature/time/residents). Notation: `Sales ~ TV + Radio + Newspaper`.

### 1. Linear Regression
- **Model** ➔ $\hat y = a_0 + a_1 x$ — $a_0$ = **intercept**, $a_1$ = **slope**; a **linear model** (assumes a linear input→output relationship); one input ⇒ **simple** linear regression.
- **Best-fit aim** ➔ make the predicted response as **close as possible** to the actual response.
- **Residual** ➔ $r_i = y_i - \hat y_i$ (actual − predicted); positive above the line, negative below.
- **Fit (least squares / MSE)** ➔ choose $(a_0,a_1)$ minimising the loss; **MSE** is that loss averaged, telling how close the line is to the points:
$$\mathcal{L}(a_0,a_1) = \sum_{i=1}^{N} \big(y_i - (a_0 + a_1 x_i)\big)^2, \qquad \text{MSE} = \frac{1}{N}\sum_{i=1}^{N}\big(y_i - \hat y_i\big)^2.$$

### 2. Polynomial Regression
- **Motivation** ➔ if a straight line **can't capture the pattern** (underfitting), increase model complexity by assuming a polynomial relationship.
- **Model** ➔ $\hat y = a_0 + a_1 x + a_2 x^2 + \dots + a_d x^d$ (degree/order $d$; the lecture fits up to a **10th-order** polynomial).
- **Same infrastructure** ➔ reuses linear-regression machinery — still linear **in the parameters** $a_j$ — minimising the same squared-error loss over the data pairs.
- **Complexity has a cost** ➔ too high a degree overfits (see [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]).

### 3. More Data Improves the Fit
- **Trend** ➔ more training data ⇒ the fit approaches the true (pre-noise) model (e.g. 90 points fit better than 30).
- **Learning curve** ➔ a plot of error (**MSE**) vs training-set size; MSE **decreases** as data grows.
- **Algorithm-dependent** ➔ different algorithms show different decay rates on the learning curve.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** A fitted line is $\hat y = 2 + 3x$. Predict $y$ at $x = 4$, and give the residual if the actual $y = 15$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\hat y &= 2 + 3(4) = 14 \\
r &= y - \hat y = 15 - 14 = +1
\end{aligned}
$$
**Final Extracted Output:** prediction $14$; residual $+1$ (actual sits just above the line).

## ⚠️ Common Mistakes
- 💡 **Higher degree ≠ better** ➔ a 10th-order polynomial can wiggle to chase noise; the goal is the *loss-minimising* fit that generalises, not one through every point.
- 💡 **"Linear" means linear in parameters** ➔ polynomial regression is still solved by linear-regression machinery because it's linear in the coefficients $a_j$.

## 🧠 Active Recall
> [!FAQ]- What quantity does linear regression minimise, and what are $a_0$ and $a_1$?
> > [!SUCCESS]- Answer
> > - **Short answer:** It minimises the sum of squared residuals $\sum (y_i - (a_0 + a_1 x_i))^2$; $a_0$ is the intercept and $a_1$ is the slope.
> > - **Why:** **Least squares** ➔ the parameters that make predictions closest (in squared error) to the observed $y$.

> [!FAQ]- What does a learning curve show, and what happens to MSE as data grows?
> > [!SUCCESS]- Answer
> > - **Short answer:** A learning curve plots error (MSE) against training-set size; MSE decreases as more data is added (better fit).
> > - **Why:** **More data → closer to truth** ➔ the fit converges toward the true model (rate depends on the algorithm).
