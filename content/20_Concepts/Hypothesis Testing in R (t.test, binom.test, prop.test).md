---
unit: FIT2086
week: [5, 6]
source: [applied]
domain: E
parent: "[[Hypothesis Testing]]"
tags: [Tool/R, DataScience/Modelling]
type: pattern
aliases: [t.test, binom.test, prop.test, testing in R, Welch test in R, one-sided test in R, studio5]
---
# [[Hypothesis Testing in R (t.test, binom.test, prop.test)]]

**Context:** [[FIT2086_MOC]] · Studio 5 *(run in W6, drills the W5 material)* · the R execution of [[Tests for Normal Means (z-test and t-test)]] and [[Tests for Bernoulli Populations]] — three functions cover every case the unit tests · sits beside [[Confidence Intervals in R (calcCI)]], which builds the same intervals by hand
**Problem it solves:** turn a data vector (or a pair of counts) into a $p$-value, a confidence interval, and a defensible sentence about the **population**.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "is this group's mean $\mu_0$?" ➔ `t.test(x, mu=)` | "do these two groups differ?" ➔ `t.test(x, y)` | "is this proportion $\theta_0$?" ➔ `binom.test` | "do these two proportions differ?" ➔ `prop.test`.
> - **⚡ Key Constraint:** three arguments carry all the exam risk — `mu` (the null value, **not** the estimate), `alternative` (which tail), and `var.equal` (Welch vs pooled). Getting `alternative` wrong changes $p$ by exactly a factor of $2$.

## 🔧 Minimal Working Example
```r
bpdata <- read.csv("bpdata.csv")          # 20 males aged 47–56; n = 20, mean 114, sd 5.43

# One sample, two-sided: is this an "at risk" population (mu = 120)?
t.test(x = bpdata$BP, mu = 120)                        # t = -4.943, df = 19, p = 9.0e-05

# One sample, one-sided: are they healthy?  H0: mu >= 120 vs HA: mu < 120
t.test(x = bpdata$BP, mu = 120, alternative = "less")  # same t, p = 4.5e-05

# Coverage of the reported interval
t.test(x = bpdata$BP, conf.level = 0.99)               # wider than the 0.95 default

# Two samples: Welch (unequal variances, the DEFAULT) then pooled
SP500  <- read.csv("SP500.csv")
y_pre  <- SP500$Index[1:58]; y_post <- SP500$Index[59:108]
t.test(y_pre, y_post, var.equal = FALSE)               # Welch
t.test(y_pre, y_post, var.equal = TRUE)                # pooled

rv <- t.test(y_pre, y_post, var.equal = FALSE)
rv$p.value                                             # 1.77e-51 — R prints "< 2.2e-16"

# Binary data
binom.test(x = 4, n = 12, p = 1/2)                     # exact one-proportion, p = 0.3877
prop.test(x = c(4, 10), n = c(12, 12))                 # exact two-proportion, p = 0.0384
```
**Expected output:**

| Call | Statistic | $p$-value | Interval reported |
| :--- | :--- | :--- | :--- |
| `t.test(BP, mu=120)` | $t=-4.943$, $\text{df}=19$ | $9.0\times10^{-5}$ | $(111.46,\ 116.54)$ — a **two-sided** range for $\mu$ |
| `t.test(BP, mu=120, alternative="less")` | same $t$ | $4.5\times10^{-5}$ *(exactly half)* | $(-\infty,\ 116.10)$ — an **upper bound** on $\mu$ |
| `t.test(BP, conf.level=0.99)` | — | — | $(110.53,\ 117.47)$ — wider than the $0.95$ interval |
| `t.test(y_pre, y_post)` *(Welch)* | $t=28.48$ | $1.8\times10^{-51}$ | $(460.34,\ 529.23)$ |
| `t.test(y_pre, y_post, var.equal=T)` *(pooled)* | $t=28.17$ | $4.9\times10^{-51}$ | $(459.97,\ 529.61)$ |
| `binom.test(4, 12, 1/2)` | $m=4$ successes | $0.3877$ | $(0.099,\ 0.651)$ for $\theta$ |
| `prop.test(c(4,10), c(12,12))` | — | $0.0384$ | interval for $\theta_x-\theta_y$ |

- **Reading the printout** ➔ R gives the statistic and `df` on one line, the $p$-value, then `alternative hypothesis:` (a check that `alternative`/`mu` landed as intended), then the interval, then the sample estimate.
- **Tiny $p$-values are truncated** ➔ R prints `p-value < 2.2e-16` rather than the number; recover it with `rv <- t.test(...); rv$p.value`. The object also carries `rv$statistic`, `rv$conf.int`, `rv$estimate`.
- **`t.test` has no `sigma` argument** ➔ it always estimates the variance from the data, so it is a $t$-test, never the known-$\sigma$ $z$-test; a $z$-test is coded by hand as `2 * pnorm(-abs(z))`.
- **`binom.test` beats the hand $z$** ➔ at $n=12$ the CLT approximation gives $p=0.248$ against the exact $0.3877$; the approximation **overstates the evidence** and only closes as $n$ grows.

## 🔀 Variations
- **The approximate difference-of-means $z$ by hand** *(when you are given only summaries, not the raw vectors)* ➔
```r
diff <- mu_pre - mu_post                                   # 494.787
se_diff <- sqrt(sigma2_pre/n_pre + sigma2_post/n_post)     # 17.373
z <- diff / se_diff                                        # 28.48
p <- 2 * pnorm(-abs(z))                                    # 2.1e-178
```
- **Sensitivity sweep on the exact binomial** ➔ `for (x in 4:1) print(binom.test(x, 12, 1/2)$p.value)` ➔ $0.388,\ 0.146,\ 0.0386,\ 0.0063$ — answers "how few heads before I suspect the coin".
- **Plot before you test** ➔ `plot(SP500$Index, type="l", lwd=2.5); lines(x=59:108, y=SP500$Index[59:108], col="red", lwd=2.5)` — a visible step change predicts a tiny $p$ before any arithmetic.
- **`alternative` values** ➔ `"two.sided"` (default) · `"less"` · `"greater"`; these follow $H_A$, so `"less"` pairs with $H_A:\mu<\mu_0$.

## ✍️ Practice
> [!QUESTION]- Practice 1: A vector `y` of 20 systolic readings. Test whether the population is "at risk" ($\mu\ge120$) against the alternative that it is healthy, and report a $99\%$ two-sided interval for $\mu$.
> > [!SUCCESS]- Reference solution
> > ```r
> > t.test(x = y, mu = 120, alternative = "less")
> > t.test(x = y, conf.level = 0.99)$conf.int
> > ```
> > - **Key move:** the one-sided call answers the *question*; a separate two-sided call is needed for a reportable **range**, because `alternative="less"` returns only an upper bound.

> [!QUESTION]- Practice 2: 4 heads in 12 tosses, then 10 heads in 12 tosses. Test whether the coin changed, both approximately and exactly.
> > [!SUCCESS]- Reference solution
> > ```r
> > mx <- 4; nx <- 12; my <- 10; ny <- 12
> > theta_p <- (mx + my) / (nx + ny)                                  # 0.5833
> > z <- (mx/nx - my/ny) / sqrt(theta_p*(1-theta_p)*(1/nx + 1/ny))    # -2.484
> > 2 * pnorm(-abs(z))                                                # 0.0130
> > prop.test(x = c(mx, my), n = c(nx, ny))                           # 0.0384
> > ```
> > - **Key move:** the pooled $\hat\theta_p$ pools **counts**, not rates; the approximate $p$ is $\approx3\times$ smaller than the exact one, so it **overstates** the evidence at $n=12$.

## ⚠️ Common Mistakes
- 💡 **Passing the sample mean to `mu`** ➔ `mu` is the **null value** $\mu_0$; feeding it $\bar y$ returns $t=0$ and $p=1$.
- 💡 **Choosing `alternative` after seeing the data** ➔ the one-sided $p$ is exactly half the two-sided one, so picking the tail post hoc manufactures significance; $H_A$ comes from the research question.
- 💡 **Reporting a one-sided interval as a range** ➔ `alternative="less"` makes `conf.int` an upper **bound** ($-\infty$ on the left), not a plausible range for $\mu$.
- 💡 **Quoting `p-value < 2.2e-16` as the answer** ➔ that is R's print floor; extract `rv$p.value` when the exact magnitude matters.
- 💡 **Assuming `var.equal = TRUE` is the default** ➔ the default is `FALSE` (Welch). Pooling when the variances genuinely differ ($7002$ vs $9383$ here) widens the interval rather than sharpening it.

## 🧠 Active Recall
> [!FAQ]- On the S&P data the approximate $z$, the Welch $t$ and the pooled $t$ all give effectively the same verdict but three different intervals. Which interval is the least trustworthy, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** the **approximate** $z$ interval $(460.74,\ 528.84)$ — it is the **narrowest**, and narrowness here is overconfidence, not precision.
> > - **Why:** **It ignores the uncertainty in $\hat\sigma^2$** ➔ substituting the estimated variances as if they were known removes a source of error from the width. The $t$ procedures carry that uncertainty and widen accordingly.
