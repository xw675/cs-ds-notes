---
unit: FIT2086
week: [7, 8]
source: [applied]
domain: E
parent: "[[Logistic Regression]]"
tags: [Tool/R, DataScience/Modelling, DataScience/ML]
type: pattern
aliases: [glm binomial, logistic regression in R, pROC, roc in R, my.pred.stats, studio7, KIC in R, step k = 3, null deviance, residual deviance]
---
# [[Logistic Regression in R (glm, pROC, step)]]

**Context:** [[FIT2086_MOC]] · Studio 7 · fit a [[Logistic Regression]] ➔ score it on held-out data ([[Classification Evaluation (Confusion Matrix and Metrics)]], [[ROC and AUC]], [[Logarithmic Loss]]) ➔ prune with AIC/KIC/BIC ([[Model Selection and Information Criteria (AIC, BIC)]]) · linear twin ➔ [[Multiple Regression and Stepwise Selection in R]] · files: `30_Projects/FIT2086_Studios/Studio7/`
**Problem it solves:** a Y/N target and many candidate predictors ➔ a pruned classifier whose quality is measured on data it never saw.

> [!abstract] Quick Revision
> - **🎯 Trigger:** binary target ➔ `glm(…, family = binomial)` ➔ `predict(…, type = "response")` on test ➔ `my.pred.stats` ➔ `step(k = …)` ➔ re-score.
> - **⚡ Key Constraint:** `predict()` returns **log-odds** by default — without `type = "response"` every threshold, AUC and log-loss is computed on the wrong scale.

## 🔧 Minimal Working Example
```r
library(pROC)                        # install.packages("pROC") once
source("my.prediction.stats.R")      # defines my.pred.stats(prob, target)
train = read.csv("pima.train.csv", stringsAsFactors = TRUE)   # DIABETES: factor N/Y
test  = read.csv("pima.test.csv",  stringsAsFactors = TRUE)
levels(train$DIABETES)               # "N" "Y" -> the 2nd level is the "success"

fullmod = glm(DIABETES ~ ., data = train, family = binomial)
summary(fullmod)                     # z value, Pr(>|z|), null/residual deviance, AIC
all.equal(fullmod$aic, fullmod$deviance + 2*length(coef(fullmod)))   # TRUE

eta  = predict(fullmod, test)                      # log-odds: 2.449 -0.192 -0.277 ...
prob = predict(fullmod, test, type = "response")   # P(Y="Y"|x): 0.921 0.452 0.431 ...
pred = factor(prob > 1/2, c(F, T), c("N", "Y"))    # threshold 1/2
table(pred, test$DIABETES)           # rows = predicted, columns = truth
mean(pred == test$DIABETES)          # classification accuracy
roc.obj = roc(response = test$DIABETES, prob); roc.obj$auc; plot(roc.obj)
my.pred.stats(prob, test$DIABETES)   # table + CA + sens + spec + AUC + log-loss + ROC plot

bic = step(fullmod, k = log(nrow(train)), direction = "both", trace = 0)
my.pred.stats(predict(bic, test, type = "response"), test$DIABETES)
```
**Expected output** (Pima: $n=668$ train, $100$ test; rerun-verified):

| Model | Params | Resid. dev. | CA | Sens | Spec | AUC | Log-loss |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| full `~ .` | $9$ | $618.08$ | $0.77$ | $0.516$ | $0.884$ | $0.816$ | $49.58$ |
| BIC of full | $5$ (PREG, PLAS, BMI, PED) | $626.87$ | $0.77$ | $0.516$ | $0.884$ | $0.823$ | $47.70$ |
| 53-term (`.*.` + logs + squares) | $53$ | $533.75$ | $0.78$ | $0.613$ | $0.855$ | $0.834$ | $46.88$ |
| BIC of 53-term | $7$ | $594.23$ | $0.80$ | $0.581$ | $0.899$ | $0.852$ | $44.54$ |
| KIC (`k = 3`) of 53-term | $20$ | $556.87$ | **$0.82$** | $0.677$ | $0.884$ | **$0.854$** | **$43.29$** |

- **Full-model `summary()`** ➔ PLAS, BMI, PREG strongest ($p<3\times10^{-4}$) · BP, PED $p<0.05$ · AGE marginal ($p=0.070$) · SKIN, INS unimportant. Null deviance $868.88$.
- **BIC-of-53 equation** ➔ $\hat\eta=-21.10+0.0365\,\text{PLAS}-0.0201\,\text{BP}+0.342\,\text{AGE}-0.00377\,\text{AGE}^2+3.157\log(\text{BMI})+0.468\log(\text{PED})$.
- **Doctor's reading** ➔ PLAS, AGE and PED (family history) can't really be changed; BMI can ➔ log-odds of diabetes **fall by $3.157$ per unit decrease in $\log(\text{BMI})$**.
- **BIC vs KIC** ➔ KIC predicts best but keeps $20$ terms incl. interactions, with a $\log(\text{BMI})$ coefficient of $52.1$ beside $\text{BMI}$ and $\text{BMI}^2$ ➔ likely overestimated; trust the simpler model's coefficients for explanation, the KIC model when prediction is all that matters.

## 🔀 Variations
- **Transformations in the formula** ➔ `. + log(BMI)` · `. + I(PLAS^2)` (`I()` protects `^`) · `. + SKIN*AGE` (adds the product term `SKIN:AGE`) · `. + .*.` = all pairwise interactions · `log(PREG+1)` guards $\log 0$.

| Added to `~ .` | Term's $p$-value | Deviance drop from $618.08$ | Verdict |
| :--- | :--- | :--- | :--- |
| `log(BMI)` | $0.0013$ | $10.76$ | nonlinear BMI effect likely |
| `I(PLAS^2)` | $0.704$ | $0.14$ | no evidence of curvature |
| `SKIN*AGE` | $0.015$ | $5.16$ | interaction probably associated, though SKIN alone is not |

- **Criterion via `k`** ➔ `k = 2` AIC (default) · `k = 3` KIC · `k = log(nrow(df))` BIC — least to most conservative.
- **$p$ close to $n$ (gene data)** ➔ $n=200$, $p=100$ binary SNP factors, $10{,}000$ balanced test rows:

| Model | Params | CA | Sens | Spec | AUC | Log-loss |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| full | $101$ | $0.535$ | $0.562$ | $0.508$ | $0.552$ | $18112$ |
| AIC step | $26$ | $0.544$ | $0.551$ | $0.537$ | $0.567$ | $10962$ |
| BIC step | $3$ | **$0.623$** | $0.324$ | $0.923$ | **$0.622$** | **$6678$** |

- **Gene reading** ➔ full fit: null deviance $277.26$ ➔ residual $154.23$, AIC $=154.23+2(101)=356.23$, yet test AUC $\approx$ chance ⟹ overfitting. BIC keeps only $\hat\eta=-0.112-1.134\,\text{SNP12}+1.460\,\text{SNP56}$ ➔ a SNP12 mutation **lowers** the log-odds of disease by $1.134$; a SNP56 mutation **raises** them by $1.460$.
- **Solution-comment correction** ➔ the studio notebook says BIC "greatly improved sensitivity"; the rerun shows the reverse — sensitivity $0.56\to0.32$, specificity $0.51\to0.92$ — while accuracy, AUC and log-loss all improved.

## ✍️ Practice
> [!QUESTION]- Practice 1: From `df` (factor target `y`, levels N/Y) and `newdf`, fit the full logistic model, prune it by KIC, and print only the test AUC.
> > [!SUCCESS]- Reference solution
> > ```r
> > full = glm(y ~ ., data = df, family = binomial)
> > kic  = step(full, k = 3, direction = "both", trace = 0)
> > p    = predict(kic, newdf, type = "response")
> > roc(response = newdf$y, p)$auc
> > ```
> > - **Key move:** `type = "response"` before `roc`; `k = 3` is the whole AIC ➔ KIC change.

> [!QUESTION]- Practice 2: A logistic model has $100$ predictors and residual deviance $154.23$. Compute R's AIC, then the lecture-scale NLL and AIC.
> > [!SUCCESS]- Reference solution
> > - **R scale** ➔ $\text{AIC}_R=\text{deviance}+2k=154.23+2(101)=356.23$.
> > - **Lecture scale** ➔ deviance $=2L$ ⟹ $L=77.12$; $\text{AIC}=L+k=77.12+101=178.12=\text{AIC}_R/2$.
> > - **Key move:** count the intercept — $k=p+1$.

> [!QUESTION]- Practice 3: Lower the Pima threshold to $0.3$ and compute sensitivity from the confusion matrix without `my.pred.stats`.
> > [!SUCCESS]- Reference solution
> > ```r
> > pred3 = factor(prob > 0.3, c(F, T), c("N", "Y"))
> > T = table(pred3, test$DIABETES)   # N/N 47, Y/N 22, N/Y 6, Y/Y 25
> > T[2, 2] / sum(T[, 2])             # 25/31 = 0.806 (was 0.516 at 1/2)
> > ```
> > - **Key move:** columns are the **truth**, so sensitivity divides by the Y column; `my.pred.stats` hard-codes the $\tfrac12$ threshold.

## ⚠️ Common Mistakes
- 💡 **Omitting `family = binomial`** ➔ `glm` silently fits a Gaussian linear model.
- 💡 **Target not a factor** ➔ read with `stringsAsFactors = TRUE`; R treats the **second** level as success, and `my.pred.stats` hard-codes the labels `"N"`/`"Y"`.
- 💡 **Reading `my.pred.stats` log-loss as an average** ➔ it is a **sum** over the test set ($18112$ over $10{,}000$ rows) ➔ compare only on the same test data.
- 💡 **Judging a $p\approx n$ model in-sample** ➔ deviance $277\to154$ looks excellent; test AUC $0.55$ says otherwise.
