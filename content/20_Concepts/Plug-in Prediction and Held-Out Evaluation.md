---
unit: FIT2086
week: [3, 4]
source: [applied, lab]
domain: E
parent: "[[Maximum Likelihood Estimation]]"
tags: [Tool/R, DataScience/Modelling]
type: pattern
aliases: [plug-in predictive density, plug-in distribution, held-out evaluation, train test split, empirical probability, predictive negative log-likelihood, norm_negloglike, out-of-sample likelihood]
---
# [[Plug-in Prediction and Held-Out Evaluation]]

**Context:** [[FIT2086_MOC]] · Studio 3 · what you *do* with $\hat\theta$ after [[Maximum Likelihood Estimation|fitting]] — predict, then **score the prediction on data the fit never saw** · the first appearance of train/test thinking that becomes cross-validation later in the unit · extends [[R Toolkit (Cheatsheet)]] · data: `train.csv` ($n=10$ heights), `test.csv` ($n=10^6$)
**Problem it solves:** fit a distribution to a small sample, turn it into probability statements about the population, and check whether those probabilities were any good.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "fit a model and predict $P(\cdot)$" ➔ estimate $\hat\theta$ on **train** → `pnorm` with $\hat\theta$ → compare against **empirical proportions** on **test** → score with the **out-of-sample negative log-likelihood**.
> - **⚠️ Key Constraint:** every estimate comes from `train` only; `test` is touched **only** for scoring. Re-estimating on test destroys the whole point of the exercise.

## 🔧 Minimal Working Example
```r
# 1. Fit: all three estimates in one list-returning function
my_estimates <- function(X) {
  n = length(X)
  retval = list()
  retval$mu_ml = sum(X)/n                    # sample mean
  e2 = (X - retval$mu_ml)^2                  # squared deviations, reused twice
  retval$var_ml = sum(e2)/n                  # divisor n   ➔ biased
  retval$var_u  = sum(e2)/(n-1)              # divisor n-1 ➔ unbiased
  return(retval)
}
train <- read.csv("train.csv"); test <- read.csv("test.csv")
est <- my_estimates(train$heights)

# 2. Predict: plug the estimates into the family — pnorm takes the SD, not the variance
1 - pnorm(1.7, est$mu_ml, sqrt(est$var_ml))                                  # P(X > 1.7)
pnorm(1.5, est$mu_ml, sqrt(est$var_u))                                       # P(X < 1.5)
pnorm(1.75, est$mu_ml, sqrt(est$var_u)) - pnorm(1.6, est$mu_ml, sqrt(est$var_u))

# 3. Ground truth: the empirical proportion in the held-out data
mean(test$heights > 1.7)          # logical vector ➔ TRUE=1, FALSE=0 ➔ mean = proportion

# 4. Score: negative log-likelihood of the HELD-OUT data under the fitted model
norm_negloglike <- function(y, mu, sigma) {
  n = length(y)
  return( (n/2)*log(2*pi*sigma^2) + 1/2/sigma^2*sum((y-mu)^2) )
}
norm_negloglike(test$heights, est$mu_ml, sqrt(est$var_ml))
norm_negloglike(test$heights, est$mu_ml, sqrt(est$var_u))
```
**Expected output:** $\hat\mu_{ML}=1.6597$, $\hat\sigma^2_{ML}=0.00799$, $\hat\sigma^2_u=0.00888$ — the unbiased estimate is **always the larger**, by the factor $\frac{n}{n-1}=\frac{10}{9}$.

## 📊 Predicted vs Empirical (fit on $n=10$, scored on $n=10^6$)
| Event | ML $\hat\sigma^2_{ML}$ | Unbiased $\hat\sigma^2_u$ | Empirical (test) | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| $P(X>1.7)$ | $0.326$ | $0.334$ | $0.307$ | ML closer — both **over**estimate |
| $P(X<1.5)$ | $0.037$ | $0.045$ | $0.067$ | unbiased closer — both **under**estimate |
| $P(1.6<X<1.75)$ | $0.592$ | $0.568$ | $0.533$ | unbiased closer |
| **Predictive NLL** on test | $-864{,}540.8$ | $-874{,}975.6$ | — | **unbiased wins** (lower is better, $\approx1\%$) |

**Final extracted output:** the $\hat\sigma^2_u$ model fits the future data better overall, because a **wider** density spreads probability onto the tail values a $n=10$ sample never showed — but that same widening is what makes it *over*shoot $P(X>1.7)$. With $n$ large the two estimates converge and the distinction evaporates.

## 🔀 Variations
- **Two densities on one plot** ➔ scatter the sample on the $x$-axis, then overlay both fitted pdfs to see the width difference:
```r
plot(x=train$heights, y=rep(0,10), ylim=c(0,6), xlim=c(1.4,2), ylab="p(heights)", xlab="Heights")
xv = seq(from=1.4, to=2, length.out=100)          # smooth grid for the curves
lines(xv, dnorm(xv, est$mu_ml, sqrt(est$var_ml)), lwd=2.5, col="red")
lines(xv, dnorm(xv, est$mu_ml, sqrt(est$var_u)),  lwd=2.5, col="blue")
legend(x=1.75, y=6, c("Samples","ML Estimate","Unbiased Estimate"),
       lty=c(0,1,1), pch=c("o","",""), col=c("black","red","blue"), lwd=c(1,2.5,2.5))
```
- **Why the NLL, not just the three probabilities** ➔ the NLL scores the model at **every observed value at once** rather than at three hand-picked thresholds; low probability assigned to values that actually occur is punished by $-\log$ of a small number being large.

## ✍️ Practice
> [!QUESTION]- Practice 1: fit $Poi(\lambda)$ to a count vector `y_train` by ML, then report the predicted $P(X\ge3)$ and compare it with the empirical proportion in `y_test`.
> > [!SUCCESS]- Reference solution
> > ```r
> > lam <- mean(y_train)                              # MLE of the Poisson rate
> > ppois(2, lam, lower.tail = FALSE)                 # P(X >= 3) = P(X > 2)
> > mean(y_test >= 3)                                 # empirical proportion
> > ```
> > - **Key move:** discrete boundaries — $P(X\ge3)=P(X>2)$, so pass `2`, not `3`; the plug-in step is identical in shape to the normal case, only the family changes.

> [!QUESTION]- Practice 2: write a one-line R expression for the predictive NLL of `y` under $Poi(\hat\lambda)$ and say why it is comparable across models but not across datasets.
> > [!SUCCESS]- Reference solution
> > ```r
> > -sum(dpois(y, lam, log = TRUE))       # log=TRUE avoids underflow on the product
> > ```
> > - **Key move:** the NLL scales with $n$ and with the units of $y$, so only **differences between models on the same held-out data** are meaningful — an absolute NLL value means nothing on its own.

## ⚠️ Common Mistakes
- 💡 **Passing the variance where R wants the SD** ➔ `pnorm(1.7, mu, est$var_ml)` silently models $N(\mu,(\sigma^2)^2)$; every call needs `sqrt(...)`.
- 💡 **Reading a negative NLL as an error** ➔ for **continuous** data the density can exceed $1$ (here $\sigma\approx0.09$), so $-\log p$ goes negative; only **differences** between models carry meaning.
- 💡 **Estimating on the test set** ➔ `test` exists only to stand in for the unseen population; fitting on it makes the score self-congratulatory and, in reality, you never have it.
- 💡 **Trusting a `cat()` label over its argument** ➔ the released `studio3.solns.R` prints the `var_ml` figure under the label "(unbiased)" and vice versa; read which estimate is actually passed to the function.
- 💡 **Concluding "unbiased is better" in general** ➔ it won *this* comparison at $n=10$; the ranking is a property of this dataset and sample size, and both estimates converge as $n$ grows.
