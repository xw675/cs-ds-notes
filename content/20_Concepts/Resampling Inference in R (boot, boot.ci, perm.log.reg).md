---
unit: FIT2086
week: 11
source: [applied]
domain: E
parent: "[[Bootstrap]]"
tags: [Tool/R, DataScience/Modelling]
type: pattern
aliases: [boot package, boot.ci, boot in R, BCa interval, bootstrap AUC, perm.log.reg, permutation test in R, studio10, sweep colMeans]
---
# [[Resampling Inference in R (boot, boot.ci, perm.log.reg)]]

**Context:** [[FIT2086_MOC]] · Studio 10 · the `boot` package for any statistic + a coefficient-wise permutation test for `glm` · theory ➔ [[Bootstrap]], [[Permutation Tests]] · hand-rolled loops ➔ [[R Toolkit (Cheatsheet)]] · scoring helper from [[Logistic Regression in R (glm, pROC, step)]]
**Problem it solves:** a CI or a $p$-value for a statistic with no usable formula — a median, a fitted model's AUC, a logistic coefficient — by computation instead of derivation.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "CI for *any* statistic" ➔ write `stat(data, indices)` ➔ `boot(data, stat, R)` ➔ `boot.ci(bs, 0.95, type = "bca")` · "$p$-value without normal theory" ➔ permute the target, refit, compare $\lvert\hat\beta\rvert$.
> - **⚡ Key Constraint:** the statistic **must** take `(data, indices)` and subset with them — `x[I]` for a vector, `data[indices, ]` for a data frame (the comma keeps whole rows); extra arguments such as `formula` go to `boot(…)` by name.

## 🔧 Minimal Working Example
```r
library(boot)                                         # install.packages("boot") once
bpdata = read.csv("bpdata.csv")                       # n = 20 men, BSA in m^2

t.test(x = bpdata$BSA, conf.level = 0.95)             # parametric reference
bs.mean = boot(bpdata$BSA, function(x, I) { return(mean(x[I])) }, 1000)
bs.mean                                               # original / bias / std. error
boot.ci(bs.mean, 0.95, type = "basic")
boot.ci(bs.mean, 0.95, type = "bca")
bs.med = boot(bpdata$BSA, function(x, I) { return(median(x[I])) }, 1000)
boot.ci(bs.med, 0.95, type = "basic")
plot(bs.mean); plot(bs.med)                           # histogram + QQ of the R replicates
```
**Expected output** (Studio 10 notebook, `set.seed(2086)`; reruns move the 3rd decimal):

| Statistic | Original | Bootstrap bias | Bootstrap se | Basic 95% | BCa 95% |
| :--- | :--- | :--- | :--- | :--- | :--- |
| mean BSA | $1.998$ | $\approx0.001$ | $0.029$–$0.031$ | $(1.937,\ 2.050)$ | $(1.942,\ 2.058)$ |
| median BSA | $1.98$ | $\approx0.005$ | $0.043$–$0.046$ | $(1.89,\ 2.06)$ | — |
| $t$-test (reference) | $1.998$ | — | — | $(1.934,\ 2.062)$ | — |

- **Reading** ➔ all mean intervals overlap heavily; bootstrap intervals slightly narrower than $t$ · the median's se is $\approx1.5\times$ the mean's and its interval wider · `plot(bs.med)` is spiky at $1.98$ ➔ why: [[Bootstrap#7. Studio 10 — Interval Types and Hard Statistics|Bootstrap §7]].

## 🔀 Variations
### Bootstrapping a model statistic (AUC of a fitted logistic regression)
```r
pima.train = read.csv("pima.train.csv", stringsAsFactors = T)
source("studio10.prediction.stats.R")                 # my.pred.stats(..., display = F) RETURNS a list
fit = glm(DIABETES ~ ., pima.train, family = binomial)
rv  = my.pred.stats(predict(fit, pima.train, type = "response"), pima.train$DIABETES, display = F)
rv$auc                                                # 0.848 (train); also $ca $sens $spec $log.loss

boot.auc = function(formula, data, indices) {
  d   = data[indices, ]                               # resample whole ROWS
  fit = glm(formula, d, family = binomial)            # refit on the resample
  target = as.character(fit$terms[[2]])               # "DIABETES" pulled from the formula
  rv = my.pred.stats(predict(fit, d, type = "response"), d[, target], display = F)
  return(rv$auc)
}
bs = boot(data = pima.train, statistic = boot.auc, R = 1000, formula = DIABETES ~ .)
boot.ci(bs, conf = 0.95, type = "bca"); plot(bs)      # ~(0.811, 0.872)

pima.test = read.csv("pima.test.csv", stringsAsFactors = T)
my.pred.stats(predict(fit, pima.test, type = "response"), pima.test$DIABETES)   # test AUC 0.816
```
- **Result** ➔ train CA $0.763$, sens $0.578$, spec $0.865$, AUC $0.848$ · test CA $0.77$, AUC $0.816$ — inside the bootstrap interval, but the interval is **centred on an optimistic** in-sample AUC.

### Permutation test for every `glm` coefficient (`perm.log.reg.R`)
```r
perm.log.reg = function(formula, data, R) {
  rv = list(); n = nrow(data)
  rv$fit = glm(formula, data, family = binomial)      # observed coefficients
  target = as.character(rv$fit$terms[[2]])
  rv$perm.coef = matrix(NA, R, length(rv$fit$coefficients),
                        dimnames = list(NULL, names(rv$fit$coefficients)))
  d = data
  for (i in 1:R) {
    d[, target] = d[sample(n), target]                # shuffle the target column only
    rv$perm.coef[i, ] = glm(formula, d, family = binomial)$coefficients
  }
  # row-wise |perm| > |obs| for every column, then the proportion per coefficient
  rv$p.value = colMeans(sweep(abs(rv$perm.coef), 2, abs(rv$fit$coefficients), ">"))
  return(rv)
}
rv = perm.log.reg(DIABETES ~ ., pima.train, R = 10000)
rv$p.value; summary(rv$fit)
hist(rv$perm.coef[, "INS"]); hist(rv$perm.coef[, "BP"])   # empirical null per coefficient
```
**Expected output:**

| Coefficient | $\hat\beta$ | Wald `Pr(>\|z\|)` | Perm $p$, $R=1000$ | Perm $p$, $R=10{,}000$ |
| :--- | :--- | :--- | :--- | :--- |
| PREG | $0.126$ | $0.00029$ | $0.000$ | $0.0000$ |
| PLAS | $0.0354$ | $2.6\times10^{-16}$ | $0.000$ | $0.0000$ |
| BP | $-0.0170$ | $0.0166$ | $0.008$ | $0.0040$ |
| SKIN | $0.0136$ | $0.374$ | $0.245$ | $0.2646$ |
| INS | $0.00035$ | $0.787$ | $0.767$ | $0.7551$ |
| BMI | $0.0806$ | $0.00018$ | $0.000$ | $0.0000$ |
| PED | $0.841$ | $0.0107$ | $0.004$ | $0.0023$ |
| AGE | $0.0190$ | $0.0699$ | $0.035$ | $0.0401$ |

- **Reading** ➔ same big picture, different small $p$-values (BP, PED, AGE): permutation simulates the **global** null, Wald tests $\beta_j=0$ **given** the others ➔ [[Permutation Tests#4. Studio 10 — Permuting a Logistic Regression|Permutation Tests §4]] · INS: $\hat\beta=0.00035$ deep inside a null spanning $\pm0.002$ ⟹ $p\approx0.75$ · BP: $-0.017$ outside the null bulk $\pm0.01$ ⟹ $p\approx0.004$.

## ✍️ Practice
> [!QUESTION]- Practice 1: Give a 95% BCa interval for the **standard deviation** of `bpdata$Weight` with $R=2000$, and its bootstrap standard error.
> > [!SUCCESS]- Reference solution
> > ```r
> > bs.sd = boot(bpdata$Weight, function(x, I) { return(sd(x[I])) }, R = 2000)
> > sd(bs.sd$t)                                       # bootstrap se (= the printed std. error)
> > boot.ci(bs.sd, 0.95, type = "bca")
> > ```
> > - **Key move:** any statistic slots into `x[I]`; `bs$t` is the $R\times1$ matrix of replicates, `bs$t0` the original.

> [!QUESTION]- Practice 2: Bootstrap the **log-loss** of the BIC-pruned Pima model (refit and re-prune inside each resample), $R=500$, 95% BCa interval.
> > [!SUCCESS]- Reference solution
> > ```r
> > boot.ll = function(formula, data, indices) {
> >   d   = data[indices, ]
> >   fit = step(glm(formula, d, family = binomial), k = log(nrow(d)), trace = 0)
> >   my.pred.stats(predict(fit, d, type = "response"), d$DIABETES, display = F)$log.loss
> > }
> > bs = boot(pima.train, boot.ll, R = 500, formula = DIABETES ~ .)
> > boot.ci(bs, 0.95, type = "bca")
> > ```
> > - **Key move:** the **whole** procedure (selection included) goes inside the statistic, or the interval ignores selection variability.

> [!QUESTION]- Practice 3: Change `perm.log.reg` so no $p$-value can be exactly $0$.
> > [!SUCCESS]- Reference solution
> > ```r
> > b = colSums(sweep(abs(rv$perm.coef), 2, abs(rv$fit$coefficients), ">="))
> > rv$p.value = (b + 1) / (R + 1)                    # floor 1/(R+1)
> > ```
> > - **Key move:** `colMeans` gives $b/R$ (can be $0$); the corrected form counts the observed data as one arrangement and uses `>=` for "at least as extreme".

## ⚠️ Common Mistakes
- 💡 **Statistic ignores `indices`** ➔ `function(x, I) mean(x)` returns the original value every time ⟹ se $=0$, degenerate interval.
- 💡 **`data[indices]` on a data frame** ➔ selects **columns**; rows need `data[indices, ]`.
- 💡 **Shipped `perm.log.reg` vs the solutions' claim** ➔ the solutions say "no permutation $p$-value is exactly zero (uses $(b+1)/(R+1)$)", but the supplied code computes $b/R$ and prints `0.0000` for PREG, PLAS, BMI ➔ report "$p<1/R$", or patch it (Practice 3).
- 💡 **`plot(bs)` read as the data's histogram** ➔ it shows the $R$ **replicates** of the statistic — the bootstrap sampling distribution.
