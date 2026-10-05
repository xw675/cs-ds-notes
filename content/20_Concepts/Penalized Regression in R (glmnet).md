---
unit: FIT2086
week: 9
source: [applied]
domain: E
parent: "[[Penalized Regression (Ridge and Lasso)]]"
tags: [Tool/R, DataScience/Modelling, DataScience/ML]
type: pattern
aliases: [glmnet in R, cv.glmnet, glmnet.f, cv.glmnet.f, predict.glmnet.f, lambda.min, lasso in R, ridge in R, alpha = 0, my.make.formula, wrappers.R, studio8]
---
# [[Penalized Regression in R (glmnet)]]

**Context:** [[FIT2086_MOC]] · Studio 8 · fit [[Penalized Regression (Ridge and Lasso)|ridge/lasso]] ➔ choose $\lambda$ by [[Cross-Validation]] ➔ score on test with the Studio 7 `my.pred.stats` ([[Logistic Regression in R (glm, pROC, step)]]) · the stepwise rival ➔ [[Model Selection and Information Criteria (AIC, BIC)]]
**Problem it solves:** many candidate predictors (or $p$ close to $n$) ➔ a shrunk, possibly sparse model whose penalty strength is chosen by held-out error instead of all-or-nothing `step()`.

> [!abstract] Quick Revision
> - **🎯 Trigger:** many predictors / transformations, or small $n$ ➔ `cv.glmnet.f(y ~ …, df, family = "binomial")` ➔ `coefficients(fit, s = "lambda.min")` ➔ `predict.glmnet.f(fit, test, type = "response", s = "lambda.min")`.
> - **⚠️ Key Constraint:** `glmnet` takes a matrix, not a formula ➔ use the `.f` wrappers; `alpha = 1` (default) is **lasso**, `alpha = 0` is **ridge**; forget `s = "lambda.min"` and you get the **whole path**.

## 🔧 Minimal Working Example
```r
library(glmnet); library(pROC)       # install.packages("glmnet") once
source("wrappers.R")                 # glmnet.f, cv.glmnet.f, predict.glmnet.f, my.make.formula
source("my.prediction.stats.R")      # my.pred.stats(prob, target)
pima.train = read.csv("pima.train.csv", stringsAsFactors = T)   # 668 x 9
pima.test  = read.csv("pima.test.csv",  stringsAsFactors = T)   # 100 x 9

# lambda = 0: no penalty = plain ML, matches glm()
fit0 = glmnet.f(DIABETES ~ ., pima.train, family = "binomial", lambda = 0)  # "binomial" IN QUOTES

# hand-picked lambda: how sparse?
fit = glmnet.f(DIABETES ~ ., pima.train, family = "binomial", lambda = 0.05)
coefficients(fit)                    # "." = exactly zero
sum(coefficients(fit)[-1, ] != 0)    # non-zero predictors, intercept excluded -> 4

# whole path, then CV for lambda
path = glmnet.f(DIABETES ~ ., pima.train, family = "binomial")
plot(path, "lambda", label = T)      # coefficient paths vs log(lambda)
set.seed(1)
cvfit = cv.glmnet.f(DIABETES ~ ., pima.train, family = "binomial")   # 10 folds
plot(cvfit); min(cvfit$cvm); cvfit$lambda.min
coefficients(cvfit, s = "lambda.min")
my.pred.stats(predict.glmnet.f(cvfit, pima.test, type = "response", s = "lambda.min"),
              pima.test$DIABETES)

# ridge: same calls + alpha = 0
ridge = cv.glmnet.f(DIABETES ~ ., pima.train, family = "binomial", alpha = 0)
```
**Expected output** (rerun on the studio files; CV rows use `set.seed(1)`):

| $\lambda$ (lasso) | Non-zero of 8 | Dropped |
| :--- | :--- | :--- |
| $0.02$ | $7$ | INS |
| $0.03$ | $6$ | BP, INS |
| $0.05$ | $4$ (PREG, PLAS, BMI, AGE) | BP, SKIN, INS, PED |

| Model on Pima ($n=668$) | Terms | CA | Sens | Spec | AUC | Log-loss |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| lasso $\lambda=0$ ($=$ `glm`) | $8$ | $0.77$ | $0.516$ | $0.884$ | $0.816$ | $49.58$ |
| lasso CV, `lambda.min` $=0.0027$ | $8$ (all, shrunk) | $0.77$ | $0.516$ | $0.884$ | $0.814$ | $49.28$ |
| BIC stepwise | $4$ (PREG, PLAS, BMI, PED) | $0.77$ | $0.516$ | $0.884$ | $0.823$ | **$47.70$** |
| ridge CV, `lambda.min` $=0.0236$ | $8$ | $0.76$ | $0.484$ | $0.884$ | $0.810$ | $50.43$ |

- **Path** ➔ the default grid stopped at $60$ $\lambda$ values ($0.00097$–$0.236$), not $100$ ➔ `glmnet` ends early once the deviance stops changing.
- **Lasso CV equation** ➔ $\hat\eta=-8.329+0.120\,\text{PREG}+0.0346\,\text{PLAS}-0.0146\,\text{BP}+0.0126\,\text{SKIN}+0.00027\,\text{INS}+0.0768\,\text{BMI}+0.779\,\text{PED}+0.0175\,\text{AGE}$.
- **Lasso vs BIC** ➔ with $n=668$ and only $8$ predictors, CV barely penalises (all kept); BIC's 4-term model predicts slightly better and is far easier to read.
- **Ridge path** ➔ $\lambda=0.05\to0.15\to0.5$: every coefficient shrinks smoothly (PED $0.633\to0.472\to0.278$) and **none** reaches zero — unlike lasso at $0.05$, which zeroed four.
- **Seed check** ➔ over seeds 1–5, `lambda.min` ranged $0.0014$–$0.0036$ and always kept all 8 ➔ the CV choice moves, the conclusion doesn't.

## 🔀 Variations
- **All transformations** ➔ `f = my.make.formula("DIABETES", pima.train, use.interactions = T, use.logs = T, use.squares = T, use.cubics = T)` ➔ `. + .*.` + `log()` of each strictly positive predictor + `I(x^2)` + `I(x^3)` ⟹ $59$ columns (PREG has zeros ⟹ no log).

| $n=668$, 59 columns | Terms kept | Fit time | CA | AUC | Log-loss |
| :--- | :--- | :--- | :--- | :--- | :--- |
| lasso CV | $17$ | $2.2$ s | $0.77$ | $0.840$ | $45.78$ |
| BIC stepwise (`both`) | $6$ | $20.8$ s | **$0.80$** | **$0.852$** | **$44.54$** |

- **Reading** ➔ lasso is ~$10\times$ faster; with plenty of data it does **not** beat stepwise, but is not much worse.
- **Swap train/test** ➔ `pima.train = read.csv("pima.test.csv", …)` ⟹ $n=100$ to fit, $668$ to test, $p=59$:

| $n=100$ model | Terms | CA | AUC | Log-loss |
| :--- | :--- | :--- | :--- | :--- |
| `glm`, 8 raw predictors | $8$ | $0.75$ | $0.761$ | $452.7$ |
| `glm`, all 59 | $59$ | $0.62$ | $0.618$ | $5329.2$ |
| backward BIC from 59 | $18$ | $0.67$ | $0.623$ | $5034.8$ |
| lasso CV (min CV dev. $0.910$) | $8$ | $0.75$ | $0.789$ | $371.4$ |
| ridge CV, same folds (min CV dev. $0.945$) | $59$ | $0.75$ | **$0.795$** | **$357.6$** |

- **Reading** ➔ 59 terms on 100 rows overfits catastrophically; stepwise barely rescues it; lasso and ridge **degrade gracefully** and beat even the raw 8-predictor `glm` ➔ the lasso's real strength is small $n$ relative to $p$. CV preferred lasso ($0.910<0.945$); the test set slightly favoured ridge — CV is an estimate, not a guarantee.
- **Lasso's $n=100$ equation** ➔ $\hat\eta=-43.28-0.0113\,\text{INS}+6.979\log(\text{PLAS})+3.027\log(\text{BMI})+0.417\log(\text{PED})-2.08{\times}10^{-6}\,\text{INS}^2-4.57{\times}10^{-6}\,\text{AGE}^3+0.267\,\text{PREG{:}PED}+0.000134\,\text{BP{:}BMI}$.
- **Same folds for a fair CV comparison** ➔ `foldid = sample(rep(1:10, length.out = nrow(df)))`, then pass `foldid = foldid` to both `cv.glmnet.f` calls.
- **Continuous target** ➔ omit `family` (Gaussian default) ➔ lasso/ridge linear regression.

## ✍️ Practice
> [!QUESTION]- Practice 1: Fit a CV **ridge** logistic model of `y` on all predictors in `df`, print only the non-zero coefficients at the chosen $\lambda$, and the test AUC on `newdf`.
> > [!SUCCESS]- Reference solution
> > ```r
> > fit = cv.glmnet.f(y ~ ., df, family = "binomial", alpha = 0)
> > b = coefficients(fit, s = "lambda.min"); b[b[, 1] != 0, , drop = F]   # ridge: all of them
> > p = predict.glmnet.f(fit, newdf, type = "response", s = "lambda.min")
> > roc(response = newdf$y, as.numeric(p))$auc
> > ```
> > - **Key move:** `alpha = 0` for ridge; `s = "lambda.min"` in **both** `coefficients` and `predict`.

> [!QUESTION]- Practice 2: Compare lasso and ridge fairly by minimum CV error on the full transformation formula.
> > [!SUCCESS]- Reference solution
> > ```r
> > f = my.make.formula("y", df, use.interactions = T, use.logs = T, use.squares = T, use.cubics = T)
> > set.seed(1); foldid = sample(rep(1:10, length.out = nrow(df)))
> > las = cv.glmnet.f(f, df, family = "binomial", foldid = foldid)
> > rid = cv.glmnet.f(f, df, family = "binomial", foldid = foldid, alpha = 0)
> > c(lasso = min(las$cvm), ridge = min(rid$cvm))   # smaller wins
> > ```
> > - **Key move:** identical `foldid` ⟹ the CV difference reflects the penalty, not the random split.

## ⚠️ Common Mistakes
- 💡 **`family = binomial` unquoted** ➔ `glm` takes the object, `glmnet` needs the **string** `"binomial"`.
- 💡 **Calling `glmnet` with a formula** ➔ it only accepts `X`, `y`; the wrappers build `model.matrix` and drop the intercept column for you.
- 💡 **Counting the intercept as a predictor** ➔ `coefficients(fit)[-1, ] != 0` excludes row 1.
- 💡 **`roc()` warning "Deprecated use a matrix as predictor"** ➔ harmless — `predict.glmnet.f` returns a 1-column matrix; wrap in `as.numeric()` to silence it.
