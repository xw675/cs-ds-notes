---
unit: FIT2086
week: [4, 5]
source: [applied]
domain: E
parent: "[[Confidence Intervals]]"
tags: [Tool/R, DataScience/Modelling]
type: pattern
aliases: [calcCI, CI in R, confidence interval in R, difference of means in R, SP500 study, CIunknownvar.R, group comparison CI]
---
# [[Confidence Intervals in R (calcCI)]]

**Context:** [[FIT2086_MOC]] · Studio 4 · the R execution of [[Confidence Intervals]] — one function covering the unknown-variance $t$ interval, then reused twice to compare two groups · sits beside [[Monte Carlo Estimator Comparison]] and [[Plug-in Prediction and Held-Out Evaluation]] as the third Studio R pattern
**Problem it solves:** turn a raw data vector into an estimate, an interval, and a **defensible written statement** — the exact deliverable A1 asks for.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "estimate the mean and quantify its accuracy", "is group A different from group B" ➔ `calcCI` per group ➔ compare intervals ➔ interval for the **difference**.
> - **⚠️ Key Constraint:** two non-overlapping group intervals are **suggestive**, not a test — the defensible object is the interval on $\hat\mu_1-\hat\mu_2$ and whether it contains **zero**.

## 🔧 Minimal Working Example
```r
calcCI <- function(y, alpha) {
  n = length(y)
  retval = list()
  if (alpha <= 0 || alpha >= 1) {                 # guard: alpha is a probability
    stop("Alpha must be a value greater than 0 and less than 1")
  }
  retval$mu.hat     = mean(y)
  retval$sigma2.hat = var(y)                      # var() divides by n-1 ⟹ this is sigma^2_u
  t = qt(1 - alpha/2, n - 1)                      # percentile 1-alpha/2, df = n-1
  retval$CI = retval$mu.hat + c(-t * sqrt(retval$sigma2.hat/n),
                                 t * sqrt(retval$sigma2.hat/n))
  return(retval)
}

train = read.csv("train.csv")
est = calcCI(train$heights, 0.05)
est$mu.hat; est$CI
```
**Expected output:** `mu.hat` $=1.6597$, `CI` $=(1.5923,\,1.7271)$ from $n=10$ heights, using $t_{0.025,9}=2.2622$ and $\hat\sigma^2_u=0.00888$.

**Held-out check (Q2.9)** ➔ `mean(test$heights)` over the $10^6$-row population gives $1.6498$, which **lies inside** the interval built from just $10$ points — one confirming draw of the coverage property, not a proof of it (that needs [[Confidence Interval Coverage Simulation]]).

### 🧩 Function anatomy (execution order)
1. `length(y)` ➔ $n$, which fixes the degrees of freedom **before** anything else.
2. `stop()` guard ➔ fails loudly on an invalid `alpha` rather than returning a silent nonsense interval.
3. `mean(y)` ➔ $\hat\mu_{ML}$ · `var(y)` ➔ $\hat\sigma^2_u$ (**divisor $n-1$**, so no manual correction is needed).
4. `qt(1 - alpha/2, n - 1)` ➔ the multiplier; pass the **percentile**, never `alpha`.
5. `mu.hat + c(-t*se, t*se)` ➔ vector recycling builds both endpoints in one expression.

## 🔀 Variations — comparing two groups (SP500, pre/post-Lehman)
```r
SP500 = read.csv("SP500.csv")
plot(SP500$Index, type="l", lwd=2.5,
     xlab="Week since 7th September, 2007", ylab="S&P Index")
lines(x=59:108, y=SP500$Index[59:108], col="red", lwd=2.5)   # highlight group 2

y1 = SP500$Index[1:58]      # pre-collapse  (7 Sep 2007 – 26 Sep 2008)
y2 = SP500$Index[59:108]    # post-collapse (3 Oct 2008 – 28 Aug 2009)
estG1 = calcCI(y1, alpha=0.05)
estG2 = calcCI(y2, alpha=0.05)

n1 = length(y1); n2 = length(y2)
diff    = estG1$mu.hat - estG2$mu.hat
se.diff = sqrt(estG1$sigma2.hat/n1 + estG2$sigma2.hat/n2)   # variances ADD
CI.diff = diff + c(-1.96*se.diff, 1.96*se.diff)             # z, not t: approximate procedure
diff; CI.diff
```
**Expected output:**

| Group | $n$ | $\hat\mu$ | $\hat\sigma^2_u$ | $95\%$ CI |
| :--- | :--- | :--- | :--- | :--- |
| **1 — pre-collapse** | $58$ | $1381.703$ | $9383.026$ | $(1356.233,\;1407.173)$ |
| **2 — post-collapse** | $50$ | $886.916$ | $7002.371$ | $(863.135,\;910.698)$ |
| **Difference $\hat\mu_1-\hat\mu_2$** | — | $494.787$ | $\mathrm{se}=17.373$ | $(460.7,\;528.8)$ |

**Final extracted output:** the difference interval is **entirely positive and far from zero**, so the data suggest the Lehman Brothers collapse coincided with a genuine population-level drop in the S&P index. `1.96` (not `qt`) is used because with **unknown, not-necessarily-equal** variances the difference interval is only the **CLT-approximate** Case 3 of [[Confidence Intervals]].

**Reporting template** ➔ *"The estimated difference in mean S&P Index between the 58 weeks before the collapse and the 50 weeks after was 494.8 units. We are 95% confident the population mean difference lies between 460.7 and 528.8 units. As both ends are positive and far from zero, the data suggest the collapse had an adverse effect on the US economy."* — estimate, then $n$ per group, then the interval, then the population-level claim.

## ✍️ Practice
> [!QUESTION]- Practice 1: from a blank editor, write `calcCI` and use it to report an $80\%$ interval for `train$heights`. Which two things change relative to the $95\%$ call, and does the interval widen or narrow?
> > [!SUCCESS]- Reference solution
> > ```r
> > est80 = calcCI(train$heights, 0.20)
> > est80$CI          # (1.6185, 1.7009) — narrower than the 95% (1.5923, 1.7271)
> > qt(1 - 0.20/2, 9) # 1.3830 vs 2.2622 at 95%
> > ```
> > - **Key move:** only $\alpha$ moves — $\hat\mu$ and $\hat\sigma^2_u$ are untouched, so the entire change lives in the multiplier. **Less confidence buys a narrower interval**; the $100\%$ interval is the degenerate $(-\infty,\infty)$.

> [!QUESTION]- Practice 2: the two SP500 group intervals do not overlap. Why is the difference interval still the calculation you must do?
> > [!SUCCESS]- Reference solution
> > - **Key move:** non-overlap is a **sufficient-ish but not necessary** signal, and overlap is not evidence of equality — the two intervals answer questions about $\mu_1$ and $\mu_2$ separately, whereas the claim under investigation is about $\mu_1-\mu_2$, whose standard error $\sqrt{\hat\sigma_1^2/n_1+\hat\sigma_2^2/n_2}$ is smaller than the sum of the two half-widths. Only the difference interval, and whether it contains **zero**, addresses the question directly.

## ⚠️ Common Mistakes
- 💡 **Reading `sigma2.hat` as a standard deviation** ➔ `var()` returns a **variance**; the SP500 group figures $9383.026$ and $7002.371$ are $\hat\sigma^2_u$, so $\hat\sigma\approx96.9$ and $83.7$. Passing the variance where an sd is wanted inflates every interval by an order of magnitude.
- 💡 **`qt(alpha/2, ...)` instead of `qt(1 - alpha/2, ...)`** ➔ returns the **negative** lower percentile and silently flips the interval inside out.
- 💡 **Using `qt` on the difference of means** ➔ with unknown, unequal variances the exact df is Welch's; the studio's procedure is the **approximate** $z$ interval, so `1.96` is correct there ➔ [[Tests for Normal Means (z-test and t-test)]].
- 💡 **Adding the two groups' half-widths to get the difference's** ➔ add the **variances** $\hat\sigma_1^2/n_1+\hat\sigma_2^2/n_2$, then take one square root.
- 💡 **Concluding from a single held-out check** ➔ the test-set mean landing inside one interval is one Bernoulli trial; coverage is a claim about the **procedure** over many samples.
