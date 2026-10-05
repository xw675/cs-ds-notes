---
unit: FIT2086
week: 10
source: [applied]
domain: E
parent: "[[Decision Trees and Regression Trees]]"
tags: [Tool/R, DataScience/Modelling, DataScience/ML]
type: pattern
aliases: [rpart, randomForest, kknn, train.kknn, learn.tree.cv, plot.tree.cv, prune.rpart, variable.importance, IncMSE, IncNodePurity, out-of-bag error, OOB, RMSE in R, studio9, diabetes data, trees in R, kNN in R, random forest in R]
---
# [[Trees, Forests and kNN in R (rpart, randomForest, kknn)]]

**Context:** [[FIT2086_MOC]] · Studio 9 · drills the W9 [[Decision Tree Learning (Likelihood Splits, Pruning, CV)|tree]], [[Random Forest]] and [[k-Nearest Neighbours|kNN]] material on `diabetes.*.csv` · benchmark ➔ [[Penalized Regression in R (glmnet)|lasso]] · wrappers from Studio 8's `wrappers.R` · extends [[R Toolkit (Cheatsheet)]]
**Problem it solves:** fit a non-linear model to a numeric (or binary) target, size it by CV, read which predictors matter, and decide by **test RMSE** whether it beats a linear benchmark.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "flexible model", "which variables matter", "beat the linear model?" ➔ `rpart` ➔ `learn.tree.cv` ➔ `randomForest(importance = TRUE)` ➔ `train.kknn` ➔ one RMSE per model vs `cv.glmnet.f` lasso.
> - **⚡ Key Constraint:** the three packages predict differently — tree/forest `predict(fit, test)`; kNN has **no fitted model**: `fitted(kknn(formula, train, test, k =, kernel =))` every time.

## 🔧 Minimal Working Example
```r
library(rpart); library(randomForest); library(kknn); library(glmnet)
source("wrappers.R")                                   # learn.tree.cv, plot.tree.cv, cv.glmnet.f, ...
diabetes.train = read.csv("diabetes.train.csv")         # n = 354: AGE SEX BMI BP S1..S6, target Y
diabetes.test  = read.csv("diabetes.test.csv")
rmse = function(yhat) sqrt(mean((yhat - diabetes.test$Y)^2))   # same scale as Y

# 1. tree: rpart's stopping heuristics, then size by 10-fold CV repeated m = 1000 times
tree.diabetes = rpart(Y ~ ., diabetes.train)
tree.diabetes$variable.importance / max(tree.diabetes$variable.importance)
cv = learn.tree.cv(Y ~ ., data = diabetes.train, nfolds = 10, m = 1000)
plot.tree.cv(cv)                                       # CV error vs leaves; minimum in red
rmse(predict(tree.diabetes, diabetes.test)); rmse(predict(cv$best.tree, diabetes.test))

# 2. linear benchmark
lasso.fit = cv.glmnet.f(Y ~ ., data = diabetes.train); glmnet.tidy.coef(lasso.fit)
rmse(predict.glmnet.f(lasso.fit, diabetes.test))

# 3. forest
rf.diabetes = randomForest(Y ~ ., data = diabetes.train, importance = TRUE, ntree = 5000)
rf.diabetes                                            # OOB MSE + % Var explained
rmse(predict(rf.diabetes, diabetes.test)); round(importance(rf.diabetes), 2)

# 4. kNN: CV over k = 1..25 and six kernels
kernels = c("rectangular","triangular","epanechnikov","gaussian","rank","optimal")
knn = train.kknn(Y ~ ., data = diabetes.train, kmax = 25, kernel = kernels)
ytest.hat = fitted(kknn(Y ~ ., diabetes.train, diabetes.test,
                        kernel = knn$best.parameters$kernel, k = knn$best.parameters$k))
rmse(ytest.hat)
```
*(`rmse()` is a shorthand for the studio's repeated `sqrt(mean((… - diabetes.test$Y)^2))`.)*

**Expected output:**

| Model | Test RMSE | Predictors it uses / ranks top |
| :--- | :--- | :--- |
| `rpart` default, $14$ leaves | $62.72$ | BMI, S5, S1, S3, BP, S6, S2 |
| CV-pruned tree, $7$ leaves | $62.80$ | BMI, S5, BP, S6 — S1, S2, S3 dropped |
| kNN, default settings | $61.90$ | all predictors, none selected |
| lasso `cv.glmnet.f` | $55.43$ | BMI, BP, S3, S5 |
| forest, $500$ trees | $54.62$ | — |
| forest, $5000$ trees | $54.19$ | `%IncMSE`: BMI $97.68$ · S5 $82.84$ · BP $61.65$ |
| kNN, CV-chosen `gaussian`, $k=24$ | about the lasso's, a little worse than the forest | — |

- **Verdict** ➔ forest $\gtrsim$ lasso $\gg$ single tree ⟹ the relationship is at least somewhat **linear**; the forest's small gain costs all interpretability ➔ **always fit the linear benchmark**.
- **Pruning** ➔ half the leaves, RMSE $+0.08$ ⟹ CV pruning rarely does much worse, can do much better when the full tree overfits, and always reads more easily.
- **Importance agrees** ➔ `rpart` normalised: BMI $1.00$, S5 $0.67$, BP $0.41$ ⟹ the same top three as the forest's `%IncMSE` and the lasso's selection.

## 🔀 Variations
### Reading `print(tree)`
```
node), split, n, deviance, yval      * = leaf
 1) root 354 2069865.000 148.30790
   2) BMI< 27.75 238  871378.700 120.11760
   3) BMI>=27.75 116  621294.500 206.14660
     6) BP< 101.5 63  376184.900 175.22220
```
- **`yval`** ➔ mean of $Y$ in that node (root $148.3$ = `mean(Y)`); check any node by hand: `mean(diabetes.train$Y[diabetes.train$BMI >= 27.75 & diabetes.train$BP < 101.5])` $=175.22$.
- **Classification tree** ➔ `yval` is the most likely class, followed by the class probabilities.
- **Repeat splits** ➔ a numeric predictor may split more than once (S5 at $4.17$, $4.61$, $4.88$) — binary splits lose no generality; a categorical split may send several levels down one branch.

### Three importance measures
| Measure | Call | Defined as | Scale |
| :--- | :--- | :--- | :--- |
| tree importance | `tree$variable.importance` | contribution to improving the tree's fit | arbitrary ➔ divide by `max()` |
| `%IncMSE` | `importance(rf)[, 1]` (needs `importance = TRUE`) | rise in **OOB** MSE when the predictor is randomly **permuted** ➔ the [[Permutation Tests\|permutation]] idea | % increase |
| `IncNodePurity` | `importance(rf)[, 2]` | total purity gain from splits on the predictor | arbitrary |

### Printed forest diagnostics
- **`No. of variables tried at each split: 3`** ➔ the random candidate subset per split (heuristic from $p=10$).
- **`Mean of squared residuals: 3222.09`** ➔ **out-of-bag** MSE: each row predicted only by trees whose bootstrap sample excluded it ⟹ $\sqrt{3222.09}=56.8$, close to the test RMSE $54.6$.
- **`% Var explained: 44.89`** ➔ OOB analogue of $100R^2$ ⟹ $R^2\approx0.45$.

### Binary target (Pima / gene data)
```r
tree = rpart(DIABETES ~ ., pima.train)
my.pred.stats(predict(tree, pima.test)[, 2], pima.test$DIABETES)          # col 2 = P(second level)
rf.pima = randomForest(DIABETES ~ ., data = pima.train)
my.pred.stats(predict(rf.pima, pima.test, type = "prob")[, 2], pima.test$DIABETES)
yhat.test = fitted(kknn(DIABETES ~ ., pima.train, pima.test))             # labels only
mean(yhat.test == pima.test$DIABETES) * 100                               # accuracy %: no AUC / log-loss
```
*(The Studio 9 sheet writes `my.prediction.stats()` — the file name; the function that file defines is `my.pred.stats` ➔ [[Logistic Regression in R (glm, pROC, step)]].)*

## ✍️ Practice
> [!QUESTION]- Practice 1: from the full tree below, predict $Y$ for (a) BMI $28.0$, BP $96$, S6 $110$; (b) BMI $20.1$, S5 $4.7$, S3 $38$; (c) describe the worst-progression leaf.
> ```
>  1) root 354 148.31
>    2) BMI< 27.75 120.12
>      4) S5< 4.61005 99.14
>        8) S5< 4.16665 80.67 *
>        9) S5>=4.16665 110.05
>         18) S1>=148.5 103.61 *
>         19) S1< 148.5 158.09 *
>      5) S5>=4.61005 154.62
>       10) S5< 4.88275 133.16
>         20) S3>=40 113.44 *
>         21) S3< 40 160.56 *
>       11) S5>=4.88275 174.26
>         22) BP< 82.5 109.71 *
>         23) BP>=82.5 185.55 *
>    3) BMI>=27.75 206.15
>      6) BP< 101.5 175.22
>       12) S6< 101.5 155.63
>         24) S3>=49.5 123.64 *
>         25) S3< 49.5 168.43
>           50) S2>=138.7 129.64 *
>           51) S2< 138.7 186.21
>            102) S5< 4.93805 157.53 *
>            103) S5>=4.93805 234.00 *
>       13) S6>=101.5 243.79 *
>      7) BP>=101.5 242.91
>       14) BMI< 31.35 218.35 *
>       15) BMI>=31.35 261.73 *
> ```
> > [!SUCCESS]- Reference solution
> > - **(a)** BMI $\ge27.75$ ➔ BP $<101.5$ ➔ S6 $\ge101.5$ ➔ node 13: $\hat Y=243.79\approx244$.
> > - **(b)** BMI $<27.75$ ➔ S5 $\ge4.61$ ➔ S5 $<4.88$ ➔ S3 $<40$ ➔ node 21: $\hat Y=160.56\approx161$.
> > - **(c)** node 15, $\hat Y=261.73$: BMI $\ge31.35$ **and** BP $\ge101.5$. After CV pruning the top leaf becomes BMI $\ge27.75$, BP $<101.5$, S6 $\ge101.5$ ($243.79$) while BP $\ge101.5$ predicts $242.91$ — near-equal predictions from different structure: **instability**.
> > - **Key move:** follow the condition printed on each child line; a value missing from the question is never needed on the path you take.

> [!QUESTION]- Practice 2: on `pima.train`/`pima.test`, fit a tree sized by CV and a 1000-tree forest; report each test AUC and the forest's top-3 predictors by `%IncMSE`-style importance.
> > [!SUCCESS]- Reference solution
> > ```r
> > cv = learn.tree.cv(DIABETES ~ ., data = pima.train, nfolds = 10, m = 100)
> > my.pred.stats(predict(cv$best.tree, pima.test)[, 2], pima.test$DIABETES)
> > rf = randomForest(DIABETES ~ ., data = pima.train, importance = TRUE, ntree = 1000)
> > my.pred.stats(predict(rf, pima.test, type = "prob")[, 2], pima.test$DIABETES)
> > imp = importance(rf)
> > head(imp[order(imp[, "MeanDecreaseAccuracy"], decreasing = TRUE), ], 3)
> > ```
> > - **Key move:** probabilities, not labels, go into AUC — `[, 2]` for `rpart`, `type = "prob"` then `[, 2]` for the forest. For a factor target the permutation-importance column is `MeanDecreaseAccuracy` (the classification counterpart of `%IncMSE`; column name from the package, not the studio sheet).

## ⚠️ Common Mistakes
- 💡 **`predict(rf.pima, test)` for AUC** ➔ returns class labels; add `type = "prob"` and take column 2.
- 💡 **Treating kNN like a fitted model** ➔ there is nothing to `predict()`; pass train **and** test to `kknn()` each time — prediction slows as the training set grows.
- 💡 **Over-reading the CV tree size** ➔ CV error is nearly flat over $7$–$9$ leaves and CV is random; large `m` stabilises the choice but "about 7" is the honest reading.
- 💡 **Skipping the linear benchmark** ➔ here lasso RMSE $55.4$ beat the best single tree's $62.7$; a flexible model is only worth its opacity if it beats the linear one.
