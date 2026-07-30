---
unit: FIT2086
domain: [D, E]
week: [1, 3]
source: [lecture, applied]
parent: "[[R for Data Science]]"
tags: [Tool/R, Math/Probability]
type: pattern
aliases: [R simulation, set.seed, sample, rnorm, dnorm, pnorm, qnorm, d p q r functions, random sampling in R, Monte Carlo R, running mean, runningmean, WLLN simulation, convergence plot]
---
# [[R Simulation and Random Sampling]]

**Context:** [[FIT2086_MOC]] · generating random data and evaluating distributions in R · the applied engine behind simulation, the bootstrap and Monte Carlo (LO5) · extends [[R Toolkit (Cheatsheet)]]
**Problem it solves:** draw random samples, reproduce them, and compute density / probability / quantile / random values for a named distribution.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "simulate", "sample", "draw from a distribution", "reproducible random" ➔ set.seed + sample for finite sets, and the **d/p/q/r family** for named distributions.
> - **⚡ Key Constraint:** the **first letter selects the operation** — d = density/pmf, p = CDF (probability ≤), q = quantile (inverse CDF), r = random draws. Mixing them up is the classic error.

## 🎲 Reproducibility with `set.seed`
```r
set.seed(1); rnorm(5)   # a fixed sequence of 5 normals
rnorm(5)                # DIFFERENT next 5 (generator advanced)
set.seed(1); rnorm(5)   # IDENTICAL to the first call — seed reset
```
**Expected output:** the two `set.seed(1)` calls give byte-identical vectors; the middle call differs.
- **Why** ➔ R's random numbers are **pseudo-random**: a fixed seed makes an experiment **reproducible** (essential for assignments and debugging).

## 🃏 `sample()` — drawing from a finite set
```r
sample(1:10, 4)                 # 4 distinct values, WITHOUT replacement (default)
sample(letters, 5)              # 5 distinct lowercase letters
sample(1:10)                    # a random PERMUTATION of 1..10 (size omitted = all)
sample(1:10, 4, replace = TRUE) # WITH replacement — repeats allowed
sample(1:6, 10, replace = TRUE) # 10 dice rolls (must use replace here — n>set size)
```
- **Default is no replacement** ➔ so `size` cannot exceed the set unless `replace = TRUE`.
- **Omit `size`** ➔ returns a full random **permutation**.

## 📊 The `d` / `p` / `q` / `r` family (per distribution)
Each named distribution has four functions sharing a suffix — shown here for the **normal** (`norm`):

| Prefix | Function | Returns | Normal call |
| :-- | :-- | :-- | :-- |
| `d` | **density** (pmf/pdf) $f(x)$ | height of the curve at `x` | `dnorm(x, mean=0, sd=1)` |
| `p` | **probability** (CDF) $F(x)=P(X\le x)$ | lower-tail probability | `pnorm(q, mean=0, sd=1, lower.tail=TRUE)` |
| `q` | **quantile** $F^{-1}(p)$ | the value with `p` below it | `qnorm(p, mean=0, sd=1)` |
| `r` | **random** draws | a vector of `n` samples | `rnorm(n, mean=0, sd=1)` |

- **Same pattern, other distributions** ➔ `*binom` (args `size, prob`), `*pois` (`lambda`), `*unif` (`min, max`), `*exp` (`rate`). E.g. `rbinom(10, size=1, prob=0.3)`, `dpois(2, lambda=4)`, `runif(5)`.
- **`p` and `q` are inverses** ➔ `pnorm(qnorm(0.975)) == 0.975`; use `lower.tail=FALSE` for upper-tail $P(X>q)$.

## 🔧 Minimal working example — simulate + visualise
```r
set.seed(20)
x <- rnorm(1000, mean = 5, sd = 2)   # 1000 draws from N(5, 4)
mean(x); sd(x)                       # ≈ 5 and ≈ 2 (sampling error)
hist(x, breaks = 30)                 # empirical distribution
curve(dnorm(x, 5, 2), add = TRUE, col = "red")  # true density overlaid
```
**Expected output:** a bell-shaped histogram with the red theoretical density tracking it; sample mean/sd close to 5/2. *(plotting: see [[R Visualisation (base graphics)]].)*

## 📈 Simulating the WLLN — the running-mean convergence plot *(Studio 2)*
The **running mean** $\bar x_j=\frac1j\sum_{i=1}^{j}x_i$ for $j=1,\dots,n$ makes the [[Expectations and Covariance (FIT2086)|WLLN]] visible: plot it against $j$ and watch it settle onto the population mean.
```r
runningmean <- function(x) {
  mu <- vector(mode = "numeric", length = length(x))  # preallocate — avoids O(n^2) regrowth
  S  <- 0
  for (i in 1:length(x)) {
    S     <- S + x[i]          # ONE running accumulator ...
    mu[i] <- S / i             # ... so the whole vector costs O(n), not O(n^2)
  }
  return(mu)
}

# reference line = the population mean, then overlay three independent runs
plot(1:1000, rep(0, 1000), col = "black", type = "l",
     xlab = "Samples", ylab = "Sample mean")
lines(1:1000, runningmean(rnorm(1000, 0, 1)), col = "red")
lines(1:1000, runningmean(rnorm(1000, 0, 1)), col = "green")
lines(1:1000, runningmean(rnorm(1000, 0, 1)), col = "blue")

# Bernoulli version: ylim pins the axis to the parameter space [0, 1]
plot(1:1000, rep(1/2, 1000), col = "black", type = "l", ylim = c(0, 1),
     xlab = "Samples", ylab = "Sample mean")
lines(1:1000, rep(0.9, 1000), col = "black")
lines(1:1000, runningmean(rbinom(1000, 1, 0.5)), col = "red")
lines(1:1000, runningmean(rbinom(1000, 1, 0.9)), col = "blue")
```
**Expected output:** every curve is wild for small $j$ and tightens onto its flat reference line as $j$ grows. The $\theta=0.9$ curve hugs its line **visibly sooner and tighter** than the $\theta=0.5$ curve.
- **Why the two Bernoulli curves differ** ➔ $V[\bar X_j]=\frac{\theta(1-\theta)}{j}$, and $0.9(0.1)=0.09$ against $0.5(0.5)=0.25$ ➔ **less variable data converges faster**; $\theta=\tfrac12$ is the maximum-variance Bernoulli.
- **`rep(c, n)` builds the reference line** ➔ a constant vector of length $n$ is how you draw a horizontal line with `plot`/`lines`.
- **`ylim = c(0,1)`** ➔ set on the **first** `plot()` call; passing it to `lines()` is silently ignored.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Estimate $P(X>1.5)$ for $X\sim N(0,1)$ two ways — exactly, and by simulation — reproducibly.
> > [!SUCCESS]- Reference solution
> > ```r
> > pnorm(1.5, lower.tail = FALSE)          # exact upper-tail probability ≈ 0.0668
> > set.seed(1)
> > mean(rnorm(1e6) > 1.5)                    # Monte Carlo estimate ≈ 0.0668
> > ```
> > - **Key move:** `p` gives the exact CDF (use `lower.tail=FALSE` for $>$); the simulation estimates the same probability as the **proportion** of draws exceeding 1.5. `set.seed` makes it reproducible.

> [!QUESTION]- Practice 2: Simulate rolling two fair dice 10,000 times and estimate P(sum = 7).
> > [!SUCCESS]- Reference solution
> > ```r
> > set.seed(42)
> > d1 <- sample(1:6, 1e4, replace = TRUE)
> > d2 <- sample(1:6, 1e4, replace = TRUE)
> > mean(d1 + d2 == 7)      # ≈ 0.167  (true value 6/36)
> > ```
> > - **Key move:** `replace = TRUE` is mandatory (drawing 10,000 from a set of 6); vectorised `d1 + d2` then `mean(... == 7)` turns a logical vector into a proportion.

## ⚠️ Common Mistakes
- 💡 **`d`/`p`/`q`/`r` mix-up** ➔ `rnorm` draws samples; `dnorm` gives density heights (not probabilities); `pnorm` gives $P(X\le q)$; `qnorm` inverts it. Reaching for the wrong prefix is the top mistake.
- 💡 **`sample` without `replace` caps at set size** ➔ `sample(1:6, 10)` errors; you need `replace = TRUE` whenever `size` exceeds the population.
- 💡 **Seed placement matters** ➔ `set.seed()` must precede **each** block you want reproducible; the generator advances with every draw.
- 💡 **`rbinom`'s `n` is not the binomial's $n$** ➔ in `rbinom(n, size, prob)` the first argument is **how many variates to generate** and `size` is the binomial's number of trials ➔ `rbinom(10, 5, 0.25)` returns **10 draws** from $Bin(5,0.25)$, not one draw from $Bin(10,\cdot)$.
- 💡 **Growing a vector inside a loop** ➔ `mu <- c(mu, val)` reallocates every iteration ($O(n^2)$); `vector(mode="numeric", length=n)` preallocates and keeps the running mean $O(n)$.
- 💡 **A density is not a probability** ➔ `dnorm(0)` ≈ 0.399, not a probability — consistent with [[Random Variables and Probability Distributions (FIT2086)|continuous densities]] where only integrals (via `pnorm`) are probabilities.

## 🧠 Active Recall
> [!FAQ]- For the normal distribution, what do `dnorm`, `pnorm`, `qnorm`, `rnorm` each return?
> > [!SUCCESS]- Answer
> > - **Short answer:** `dnorm(x)` = **density** $f(x)$ at `x`; `pnorm(q)` = **CDF** $P(X\le q)$; `qnorm(p)` = **quantile** $F^{-1}(p)$ (value with `p` below it); `rnorm(n)` = a vector of **`n` random draws**.
> > - **Why:** **Prefix = operation, suffix = distribution** ➔ every named distribution reuses the four prefixes, so `dpois/ppois/qpois/rpois`, `dbinom/...` behave identically; `p` and `q` are inverse, and `r` is what you use to simulate.

> [!FAQ]- Why does `set.seed(1)` before two separate `rnorm` calls not make them identical, but `set.seed(1)` before each does?
> > [!SUCCESS]- Answer
> > - **Short answer:** the pseudo-random generator **advances its internal state** with every number produced. One `set.seed(1)` fixes the *starting* state, so the first call consumes numbers and the second continues from where it left off — different values. Re-seeding **before each** call resets the state, reproducing the same sequence.
> > - **Why:** **Deterministic stream from a seed** ➔ the seed selects a fixed, reproducible stream; identical output requires the generator to be at the same position, which only re-seeding guarantees.
