---
unit: FIT2086
week: 6
source: [lecture]
domain: E
parent: "[[R for Data Science]]"
tags: [Tool/R, DataScience/Modelling, DataScience/ML]
type: pattern
aliases: [step, lm multiple regression, R AIC BIC, stepwise R, R model selection]
---
# [[Multiple Regression and Stepwise Selection in R]]

**Context:** [[FIT2086_MOC]] · the **LO5 hand skill** for W6 — fit a [[Linear Regression (FIT2086)|multiple regression]], read its `summary()`, then prune it with [[Model Selection and Information Criteria (AIC, BIC)|AIC/BIC]] · single-predictor `lm` basics ➔ [[R Modelling (lm and Decision Trees)]] · source: `Lecture 06 - Slide 66.R`
**Problem it solves:** you have many candidate predictors and need a defensible subset, not the kitchen sink.

> [!abstract] Quick Revision
> - **🎯 Trigger:** more predictors than you believe are real ➔ fit the **full** model ➔ `step()` it down.
> - **⚡ Key Constraint:** `step()` defaults to **AIC**; BIC is obtained **only** by passing `k = log(n)` — nothing else in the call changes.

## 🔧 Minimal Working Example
```r
data <- data.frame(
  BP     = c(105,115,116,117,112,121,121,110,110,114,114,115,114,106,125,114,106,113,110,122),
  Age    = c(47,49,49,50,51,48,49,47,49,48,47,49,50,45,52,46,46,46,48,56),
  Weight = c(85.4,94.2,95.3,94.7,89.4,99.5,99.8,90.9,89.2,92.7,
             94.4,94.1,91.6,87.1,101.3,94.5,87.0,94.5,90.5,95.7),
  BSA    = c(1.75,2.10,1.98,2.01,1.89,2.25,2.25,1.90,1.83,2.07,
             2.07,1.98,2.05,1.92,2.19,1.98,1.87,1.90,1.88,2.09),
  Dur    = c(5.1,3.8,8.2,5.8,7.0,9.3,2.5,6.2,7.1,5.6,5.3,5.6,10.2,5.6,10.0,7.4,3.6,4.3,9.0,7.0),
  Pulse  = c(63,70,72,73,72,71,69,66,69,64,74,71,68,67,76,69,62,70,71,75),
  Stress = c(33,14,10,99,95,10,42,8,62,35,90,21,47,80,98,95,18,12,99,99)
)

full_model <- lm(BP ~ Age + Weight + BSA + Dur + Pulse + Stress, data = data)
summary(full_model)

# direction: "forward" | "backward" | "both"; trace = 0 hides the step-by-step log
aic_model <- step(full_model, direction = "both", trace = 0)
summary(aic_model)

n <- nrow(data)
bic_model <- step(full_model, direction = "both", k = log(n), trace = 0)
summary(bic_model)
```
**Expected output:**

| Fit | Predictors kept | Coefficients | Verdict |
| :--- | :--- | :--- | :--- |
| `full_model` | all 6 | Age $0.703$ ($p\approx2.8\times10^{-9}$) · Weight $0.970$ ($p\approx1.0\times10^{-9}$) · BSA $3.78$ ($p=0.033$) · Dur/Pulse/Stress all $p>0.1$ | three predictors look inert |
| `aic_model` | all 6 | unchanged | AIC keeps everything — it is **optimistic at small $n$** |
| `bic_model` | Age, Weight, BSA | $\hat{BP}=-13.67+0.702\,\text{Age}+0.906\,\text{Weight}+4.627\,\text{BSA}$; $p=3.0\times10^{-11},\ 3.2\times10^{-12},\ 0.00776$ | the defensible model at $n=20$ |

- **Formula syntax** ➔ `y ~ a + b + c`; `y ~ .` means "every other column"; `data =` keeps the columns out of the global environment.
- **Reading `summary()`** ➔ the `Estimate` column is $\hat\beta_j$, `Std. Error` is $\operatorname{se}(\hat\beta_j)$, `t value` is $t_j=\hat\beta_j/\operatorname{se}(\hat\beta_j)$, `Pr(>|t|)` tests $H_0:\beta_j=0$; `Multiple R-squared` is $R^2$, `Residual standard error` is $\hat\sigma_u$ on $n-p-1$ df.
- **Post-pruning check** ➔ in the BIC model the $p$-values for Age, Weight and BSA are all **smaller** than in the full fit — the removed predictors were diluting the signal.
- **Scale note** ➔ R scores on the $-2\log L$ scale, so its default `k = 2` is the lecture's $\alpha=k_M$ and `k = log(n)` is the lecture's $\alpha=\tfrac{k_M}{2}\log n$. The **selected subset** is identical either way.

## 🔀 Variations
- **Pure forward from empty** ➔ `step(lm(BP ~ 1, data = data), scope = ~ Age + Weight + BSA + Dur + Pulse + Stress, direction = "forward")` — `scope` is mandatory here, since the starting model names no candidates.
- **Pure backward from full** ➔ `step(full_model, direction = "backward")` — the default when `direction` is omitted and the model is full.
- **Watch the search** ➔ drop `trace = 0` to print each candidate's score and see which predictor left at which step.
- **Add curvature / interactions** ➔ `lm(BP ~ Age + I(Weight^2), …)` for a polynomial term, `lm(BP ~ Age * Weight, …)` to expand to `Age + Weight + Age:Weight` ➔ [[Predictor Transformations (Indicators, Polynomials, Interactions)]].
- **Predict for new data** ➔ `predict(bic_model, newdata = data.frame(Age = 50, Weight = 95, BSA = 2.0))`.

## ✍️ Practice
> [!QUESTION]- Practice 1: From a data frame `d` with response `y` and predictors `a`–`e`, fit the full model, then produce the BIC-selected model and print only its coefficients.
> > [!SUCCESS]- Reference solution
> > ```r
> > full <- lm(y ~ a + b + c + d + e, data = d)
> > bic  <- step(full, direction = "both", k = log(nrow(d)), trace = 0)
> > coef(bic)
> > ```
> > - **Key move:** `k = log(nrow(d))` is the entire difference between AIC and BIC; `coef()` extracts the named coefficient vector.

> [!QUESTION]- Practice 2: Two nested models score AIC $118.2$ and $120.1$. State which you report and whether the gap settles the question.
> > [!SUCCESS]- Reference solution
> > - **Report the $118.2$ model** — the criterion is **minimised**.
> > - **Key move:** the gap is $1.9$, below the $\ge3$ rule of thumb ➔ the models are **comparable**, so justify the choice on parsimony or interpretability rather than claiming the score decided it.

## ⚠️ Common Mistakes
- 💡 **Assuming `step()` gives BIC** ➔ the default is AIC; without `k = log(n)` the reported "BIC model" is an AIC model.
- 💡 **Passing `k = n` or `k = log(nrow)`** ➔ it is `log` of the **sample size**, computed once as `n <- nrow(data)`; `nrow` without the parentheses/argument is a function object, not a number.
- 💡 **`direction = "forward"` without `scope`** ➔ forward selection from an intercept-only model has no candidate list and terminates immediately.
- 💡 **Quoting post-selection $p$-values as if pre-planned** ➔ the same data chose the subset **and** produced the $p$-values; report them as descriptive.
