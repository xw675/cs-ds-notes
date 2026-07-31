---
unit: FIT2086
week: [4, 5]
source: [applied]
domain: E
parent: "[[Confidence Intervals]]"
tags: [Tool/R, DataScience/Modelling]
type: pattern
aliases: [coverage simulation, testCIknownSigma2, testCIunknownSigma2, testCIlambda, CI coverage, exact vs approximate CI, Poisson CI coverage]
---
# [[Confidence Interval Coverage Simulation]]

**Context:** [[FIT2086_MOC]] · Studio 4 additional question · the **empirical audit** of [[Confidence Intervals]] — does a $95\%$ procedure actually cover $95\%$ of the time? · same simulate-and-count skeleton as [[Monte Carlo Estimator Comparison]], but the thing counted is **coverage**, not bias/variance
**Problem it solves:** measure how badly an *approximate* interval misses its advertised confidence level, and find the sample size at which the approximation becomes safe.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "is this interval really $95\%$", "how bad is the plug-in approximation", "at what $n$ does it become acceptable" ➔ loop: **generate from a known $\theta$ → build the interval → test containment → tally**.
> - **⚠️ Key Constraint:** the simulation only works because **you chose the population** — `pop.mu`/`pop.lambda` is the truth the interval is checked against, and it can never be estimated from the data inside the loop.

## 🔧 Minimal Working Example
```r
testCIknownSigma2 <- function(pop.mu, pop.sigma2, n, niter) {
  retval = list(); retval$coverage = 0
  for (i in 1:niter) {
    y = rnorm(n, pop.mu, sqrt(pop.sigma2))        # rnorm takes sd, NOT variance
    mu.hat = mean(y)
    CI = mu.hat + c(-1.96*sqrt(pop.sigma2)/sqrt(n),
                     1.96*sqrt(pop.sigma2)/sqrt(n))
    if (pop.mu >= CI[1] && pop.mu <= CI[2]) {     # containment test
      retval$coverage = retval$coverage + 1
    }
  }
  retval$coverage = retval$coverage/niter         # count ➔ proportion
  return(retval)
}
testCIknownSigma2(pop.mu=0, pop.sigma2=1, n=5, niter=1e4)
```
**Expected output:** `$coverage` $\approx0.95$ — and it stays $\approx0.95$ for $(\mu,\sigma^2,n)=(2,1,5)$, $(2,5,5)$, $(0,1,25)$. **Nothing moves it**, because the known-variance interval is **exact** at every $n$ and every parameter value: the pivot $\frac{\hat\mu-\mu}{\sigma/\sqrt n}$ is exactly $N(0,1)$ regardless.

## 🔀 Variations
### 1. Plug-in $z$ vs exact $t$ — where the approximation breaks
Estimate $\hat\sigma^2_u$ inside the loop and build **both** intervals from the same sample:
```r
se = sqrt(var(y))/sqrt(n)
CI.approx = mu.hat + c(-1.96*se, 1.96*se)                   # z with a plugged-in sigma
CI.t      = mu.hat + c(-qt(1-0.05/2, n-1)*se,               # exact, unknown-variance
                        qt(1-0.05/2, n-1)*se)
```
then sweep `for (n in 3:100)` and plot both coverage curves against $n$.
**Expected output:** the $t$ curve sits flat on $0.95$ for **every** $n$; the plug-in $z$ curve starts well **below** $0.95$ at $n=3$–$5$ and climbs toward it, the two becoming indistinguishable as $n$ grows.
**Reading** ➔ substituting $\hat\sigma_u$ for $\sigma$ ignores the uncertainty in that estimate, so the interval is **too narrow** and **undercovers**; the wider $t_{\alpha/2,n-1}$ multiplier is exactly the repair ([[Student-t Distribution]]).

### 2. Poisson approximate interval — a two-dimensional grid
$\hat\lambda_{ML}=\bar Y$, and the approximate interval is $\hat\lambda_{ML}\pm1.96\sqrt{\hat\lambda_{ML}/n}$ (variance $v(\lambda)=\lambda$ plugged in). Sweep both parameters with a nested loop into a matrix:
```r
M = matrix(NA, 4, 5)                       # 4 lambdas x 5 sample sizes, prefilled NA
L = c(1,5,10,50); N = c(5,10,25,50,100)
for (i in 1:4) for (j in 1:5) M[i,j] = testCIlambda(L[i], N[j], 1e5)$coverage
results = data.frame(M)
row.names(results) <- paste0("lambda=", L)
names(results)     <- paste0("n=", N)
```
**Expected output:** coverage is essentially $0.95$ across the grid **except** at $(\lambda=1,n=5)$, where it is clearly poor, and $(\lambda=5,n=5)$, where it is a little low.
**Reading** ➔ for a Poisson **the CLT works twice** — the approximation improves as $n$ grows *and* as $\lambda$ grows (a $Pois(\lambda)$ is itself a sum of $\lambda$ unit-rate pieces), so only the small-$\lambda$, small-$n$ corner fails.

> [!NOTE] **When It Flips:** exactness is a property of the **pivot**, not the sample size. Case 1 (known $\sigma^2$) and the $t$ interval are exact at $n=3$; every interval that **plugs an estimate into the variance** — $\hat\sigma_u$ for $\sigma$, $\hat\lambda$ for $\lambda$, $\hat\theta$ for $\theta(1-\theta)$ — is asymptotic and undercovers at small $n$.

## ✍️ Practice
> [!QUESTION]- Practice 1: from a blank editor, write the loop body that tallies coverage for the Poisson interval, given `pop.lambda`, `n`, `niter`.
> > [!SUCCESS]- Reference solution
> > ```r
> > for (i in 1:niter) {
> >   y = rpois(n, pop.lambda)
> >   lambda.hat = mean(y)
> >   se = sqrt(lambda.hat)/sqrt(n)                 # v(lambda.hat) = lambda.hat
> >   CI = lambda.hat + c(-1.96*se, 1.96*se)
> >   if (pop.lambda >= CI[1] && pop.lambda <= CI[2]) retval$coverage = retval$coverage + 1
> > }
> > retval$coverage = retval$coverage/niter
> > ```
> > - **Key move:** the standard error is $\sqrt{\hat\lambda/n}$, **not** $\sqrt{\mathrm{var}(y)/n}$ — for a Poisson the variance is the mean, so the family assumption supplies it for free.

> [!QUESTION]- Practice 2: your plug-in $z$ simulation returns coverage $0.87$ at $n=3$. Is this a bug or the expected answer, and how would you tell?
> > [!SUCCESS]- Reference solution
> > - **Key move:** **expected** — validate by running the *known-variance* version on the same $n$; if that returns $\approx0.95$ the loop mechanics are correct and the shortfall is genuine undercoverage from the plugged-in $\hat\sigma_u$. Always audit new simulation code against a case with a known exact answer before trusting the case you actually care about.

## ⚠️ Common Mistakes
- 💡 **Passing the variance to `rnorm`** ➔ `rnorm(n, mu, sigma2)` silently generates from the wrong population; the third argument is the **sd**, hence `sqrt(pop.sigma2)`.
- 💡 **Checking containment against $\hat\mu$** ➔ the test is `pop.mu >= CI[1] && pop.mu <= CI[2]`; the interval is built *around* $\hat\mu$, so testing $\hat\mu$ returns coverage $1$ every time and measures nothing.
- 💡 **Reading a $0.95$ result as "my interval is correct"** ➔ coverage at one $(\mu,\sigma^2,n)$ proves nothing about others; the whole point of the sweep is that the failure lives in a **corner** of the parameter grid.
- 💡 **Too few iterations** ➔ coverage is itself an estimated proportion with $\mathrm{se}=\sqrt{0.95\cdot0.05/\texttt{niter}}$; at `niter=100` that is $\approx0.02$, wide enough to hide the effect being measured. The studio uses $10^4$–$10^5$.
- 💡 **Growing the results vector inside the sweep** ➔ preallocate with `rep.int(0, 98)` or `matrix(NA, 4, 5)`; `c()` in a loop is $O(k^2)$.
