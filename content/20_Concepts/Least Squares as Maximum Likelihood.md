---
unit: FIT2086
week: 6
source: [lecture]
domain: [D, E]
parent: "[[Linear Regression (FIT2086)]]"
tags: [DataScience/Modelling, Math/Probability]
aliases: [LS equals ML, Normal error model, Regression error variance, sigma hat unbiased, Gaussian noise regression]
---
# [[Least Squares as Maximum Likelihood]]

**Context:** [[FIT2086_MOC]] · the bridge that licenses everything downstream — [[Linear Regression (FIT2086)|least squares]] is [[Maximum Likelihood Estimation|maximum likelihood]] under **normal errors**, which is why a likelihood-based criterion can score regression models ([[Model Selection and Information Criteria (AIC, BIC)]]) and why residuals get a [[Gaussian Distribution|normal]] predictive distribution

> [!abstract] Quick Revision
> - **🎯 Objective:** put $\varepsilon_i\sim N(0,\sigma^2)$ on the regression errors ➔ the negative log-likelihood becomes $\tfrac{n}{2}\log(2\pi\sigma^2)+\tfrac{\text{RSS}}{2\sigma^2}$ ➔ **minimising NLL in $\boldsymbol\beta$ = minimising RSS**.
> - **⚡ Key Constraint:** $\sigma^2$ only **scales** the RSS term, so it drops out of the $\boldsymbol\beta$ argmin — the equivalence holds for **any** $\sigma^2$, but only under the **normal** error assumption.

## 📝 Core
- **Error form of the model** ➔ $Y_i=\beta_0+\sum_{j=1}^{p}\beta_jx_{i,j}+\varepsilon_i$ with $\varepsilon_i\sim N(0,\sigma^2)$, independent across $i$.
- **Equivalent conditional statement** ➔ $Y_i\mid x_{i,1},\dots,x_{i,p}\sim N\big(\beta_0+\sum_j\beta_jx_{i,j},\ \sigma^2\big)$ — the mean moves with the predictors, the variance does **not**.
- **Residuals estimate the errors** ➔ $e_i=y_i-\hat y_i$ is the observable stand-in for the unobservable $\varepsilon_i$.
- **What the equivalence buys** ➔ a *fitting rule* (least squares) is upgraded to a *probability model*, unlocking $p$-values on $\hat\beta_j$, predictive distributions, and penalised-likelihood model selection.
- **ML variance estimate** ➔ $\hat\sigma^2_{ML}=\dfrac{\text{RSS}(\hat\beta_0,\hat{\boldsymbol\beta})}{n}$ ➔ **underestimates** the true variance (same bias story as $\hat\sigma^2_{ML}$ in [[Estimator Quality (Bias, Variance, MSE)]]).
- **Unbiased variance estimate** ➔ $\hat\sigma^2_{u}=\dfrac{\text{RSS}(\hat\beta_0,\hat{\boldsymbol\beta})}{n-p-1}$ ➔ divisor is $n$ minus the **$p+1$ fitted coefficients**, not $n-1$.

## 🧮 Proof Blueprint
**Theorem.** If $\varepsilon_i\stackrel{\text{iid}}{\sim}N(0,\sigma^2)$ then $\arg\min_{\beta_0,\boldsymbol\beta}L(\mathbf{y}\mid\beta_0,\boldsymbol\beta,\sigma^2)=\arg\min_{\beta_0,\boldsymbol\beta}\text{RSS}(\beta_0,\boldsymbol\beta)$ — the ML and LS estimates coincide.

**Strategy.** Write the iid normal likelihood, collapse the product of exponentials, recognise RSS in the exponent, take $-\log$, and note $\sigma^2$ is a positive constant factor on the only $\boldsymbol\beta$-dependent term.

**Derivation.**
$$
\begin{aligned}
p(\mathbf{y}\mid\beta_0,\boldsymbol\beta,\sigma^2)
&= \prod_{i=1}^{n}\left(\frac{1}{2\pi\sigma^{2}}\right)^{1/2}\exp\left(-\frac{\big(y_i-\beta_0-\sum_{j}\beta_jx_{i,j}\big)^{2}}{2\sigma^{2}}\right) \\
&= \left(\frac{1}{2\pi\sigma^{2}}\right)^{n/2}\exp\left(-\frac{\sum_{i=1}^{n}\big(y_i-\beta_0-\sum_{j}\beta_jx_{i,j}\big)^{2}}{2\sigma^{2}}\right) \\
&= \left(\frac{1}{2\pi\sigma^{2}}\right)^{n/2}\exp\left(-\frac{\text{RSS}(\beta_0,\boldsymbol\beta)}{2\sigma^{2}}\right) \\
L(\mathbf{y}\mid\beta_0,\boldsymbol\beta,\sigma^{2}) &= -\log p = \frac{n}{2}\log(2\pi\sigma^{2})+\frac{\text{RSS}(\beta_0,\boldsymbol\beta)}{2\sigma^{2}}
\end{aligned}
$$
- **Step 1 justification** ➔ independence turns the joint density into a product; $e^{-a}e^{-b}=e^{-a-b}$ collapses the exponentials into one sum.
- **Step 2 justification** ➔ that sum **is** the residual sum-of-squares by definition.
- **Step 3 justification** ➔ in $L$, the first term is free of $\beta_0,\boldsymbol\beta$ and the second is $\text{RSS}$ divided by the positive constant $2\sigma^2$ ➔ the minimiser is unchanged by that scaling.

**Q.E.D.** $\hat\beta_0,\hat{\boldsymbol\beta}$ from least squares are exactly the maximum-likelihood estimates under normal errors. $\blacksquare$

## ⚠️ Common Mistakes
- 💡 **Claiming LS "assumes normality"** ➔ least squares is a **loss choice** valid with no distributional assumption; normality is what makes it *coincide with ML* and is what the $p$-values and predictive intervals need.
- 💡 **Dividing by $n-1$ for the regression variance** ➔ the unbiased divisor is $n-p-1$; $n-1$ is the special case $p=0$ (the mean model).
- 💡 **Using $\hat\sigma^2_{ML}$ for inference** ➔ it is biased low ⟹ over-narrow prediction intervals and over-confident tests; use $\hat\sigma^2_u$. It *is* the right one inside the information criteria, where the NLL is evaluated at the ML estimates.

## 🧠 Active Recall
> [!FAQ]- Why does $\sigma^2$ not affect which $\boldsymbol\beta$ maximises the likelihood?
> - **Hint:** Look at where $\boldsymbol\beta$ appears in $L$.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\boldsymbol\beta$ appears **only** inside $\text{RSS}$, which enters $L$ divided by the positive constant $2\sigma^{2}$; scaling a function by a positive constant moves its value but not its argmin.
> > - **Why:** **$L=\tfrac{n}{2}\log(2\pi\sigma^{2})+\tfrac{\text{RSS}}{2\sigma^{2}}$** ➔ the first term is $\boldsymbol\beta$-free, so $\arg\min_{\boldsymbol\beta}L=\arg\min_{\boldsymbol\beta}\text{RSS}$ for every $\sigma^2>0$.

> [!FAQ]- Why is the unbiased error-variance divisor $n-p-1$ rather than $n$?
> > [!SUCCESS]- Answer
> > - **Short answer:** Fitting $p+1$ coefficients uses up $p+1$ degrees of freedom — the residuals are shrunk by construction, so dividing by $n$ systematically **understates** the spread.
> > - **Why:** **Degrees of freedom** ➔ $\hat\sigma^2_{ML}=\text{RSS}/n$ is biased low; $\hat\sigma^2_u=\text{RSS}/(n-p-1)$ corrects it, and the gap widens as $p$ approaches $n$.
