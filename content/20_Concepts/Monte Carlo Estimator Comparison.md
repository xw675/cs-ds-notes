---
unit: FIT2086
week: [3, 4]
source: [applied]
domain: E
parent: "[[Estimator Quality (Bias, Variance, MSE)]]"
tags: [Tool/R, DataScience/Modelling]
type: pattern
aliases: [simulation study, Monte Carlo estimator comparison, mean vs median, relative MSE, RelMSE, contaminated data, robustness simulation, mean_median_test]
---
# [[Monte Carlo Estimator Comparison]]

**Context:** [[FIT2086_MOC]] · Studio 3 · the **empirical** route to [[Estimator Quality (Bias, Variance, MSE)|bias, variance and MSE]] when the algebra is hard or absent — simulate the [[Sampling Distribution of an Estimator|sampling distribution]] and measure it · extends [[R Simulation and Random Sampling]] and [[R Toolkit (Cheatsheet)]]
**Problem it solves:** decide which of two estimators of the same quantity is better, without deriving either one's sampling distribution by hand.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "which estimator is better", "how does it behave as $n$ grows", "what if the data are contaminated" ➔ loop `niterations` times: **generate → estimate → store**, then summarise the stored vectors.
> - **⚠️ Key Constraint:** the loop's `mu` argument is the **true** $\theta$ you compare against — bias is $\overline{\hat\theta}-\mu$ over iterations, so the simulation only works because you *chose* the population.

## 🔧 Minimal Working Example
```r
mean_median_test <- function(niterations, mu, sigma, n, nc = 0) {
  mu_hat  = rep(0, niterations)      # PREALLOCATE — growing with c() is O(niter^2)
  med_hat = rep(0, niterations)

  for (i in 1:niterations) {
    y = rnorm(n, mu, sigma)                      # one fresh dataset per iteration
    if (nc > 0) y[1:nc] = rnorm(nc, mu, 4*sigma) # contaminate the first nc points
    mu_hat[i]  = mean(y)
    med_hat[i] = median(y)
  }

  retval = list()
  retval$bias_mean = mean(mu_hat - mu)                             # b_theta
  retval$var_mean  = var(mu_hat)                                   # Var_theta
  retval$mse_mean  = retval$bias_mean^2 + retval$var_mean          # MSE = b^2 + Var
  retval$bias_med  = mean(med_hat - mu)
  retval$var_med   = var(med_hat)
  retval$mse_med   = retval$bias_med^2 + retval$var_med
  retval$rel_mse   = retval$mse_mean / retval$mse_med              # < 1 ⟹ mean wins
  return(retval)
}
mean_median_test(1e4, mu = 0, sigma = 1, n = 10)
```
**Expected output:** a list with both biases $\approx0$, $\mathrm{Var}(\bar Y)\approx0.10$, $\mathrm{Var}(\text{median})\approx0.14$, `rel_mse` $\approx0.73$. The exact theory for the mean is $b=0$, $\mathrm{Var}=\sigma^2/n=0.1$, $\mathrm{MSE}=0.1$ — **the simulation reproduces it to two decimals**, which is how you validate the code before trusting the median column.

## 📊 Results — $10^4$ iterations, $\mu=0$
| $\sigma$ | $n$ | $n_c$ | $\mathrm{Var}(\bar Y)$ | $\mathrm{Var}(\mathrm{med})$ | $\mathrm{RelMSE}$ | Reading |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $1$ | $10$ | $0$ | $0.100$ | $0.138$ | $0.73$ | clean data ➔ **mean more efficient** |
| $10$ | $10$ | $0$ | $10.03$ | $13.83$ | $0.73$ | both scale by $\sigma^2$ ➔ **RelMSE unchanged** |
| $10$ | $100$ | $0$ | $1.00$ | $1.54$ | $0.65$ | mean's variance falls by exactly $10\times$, median's by less ➔ **gap widens for the mean** |
| $1$ | $10$ | $1$ | $0.252$ | $0.163$ | $1.54$ | one contaminated point ➔ **verdict flips to the median** |
| $1$ | $10$ | $2$ | $0.399$ | $0.194$ | $2.06$ | worse still for the mean |
| $1$ | $50$ | $2$ | $0.032$ | $0.032$ | $0.99$ | more clean data **dilutes** the contamination ➔ back to parity |
| $1$ | $50$ | $4$ | $0.044$ | $0.035$ | $1.27$ | contaminate more and the median leads again |

**Final extracted output:** neither estimator is biased in any row — the entire comparison lives in the **variance**. Efficiency favours the mean on clean normal data; **robustness** favours the median as soon as a fraction of the sample is drawn from a $4\sigma$-wide contaminating distribution.

> [!NOTE] **When It Flips:** $\mathrm{RelMSE}=1$ is the boundary. It is crossed by the **contamination fraction $n_c/n$**, not by $n$ or $\sigma$ alone — $n_c=2$ flips the verdict at $n=10$ but not at $n=50$.

> [!TIP] 🔭 Beyond the lecture *(not in the slides)*: for a normal population $\mathrm{Var}(\mathrm{med})\to\frac{\pi}{2}\cdot\frac{\sigma^2}{n}$, so $\mathrm{RelMSE}\to\frac{2}{\pi}\approx0.64$ as $n\to\infty$ — which is exactly the $0.65$ the $n=100$ row reports.

## 🔀 Variations
- **Sweep the sample size** ➔ loop the whole study over `n_vals <- seq(5, 100, by = 5)`, storing one summary per $n$, then plot two panels side by side:
```r
par(mfrow = c(1, 2))                                   # 1 row, 2 columns of plots
plot(n_vals, var_mean, type="l", col="blue", lwd=2, xlab="Sample size (n)", ylab="Variance")
lines(n_vals, var_median, col="red", lwd=2)
legend("topright", legend=c("Mean","Median"), col=c("blue","red"), lwd=2, bty="n")
plot(n_vals, rel_mse, type="l", col="purple", lwd=2, xlab="Sample size (n)", ylab="RelMSE")
```
**Expected output:** with $n_c=0$ both variance curves decay like $1/n$ with the mean's strictly below, and RelMSE sits flat below $1$; with $n_c=2$ the mean's curve starts far higher, RelMSE begins **above** $1$ and drifts down toward it as the contaminated fraction shrinks.
- **Default argument** ➔ `nc = 0` in the signature keeps every earlier call valid after the function is extended — no call sites need editing.

## ✍️ Practice
> [!QUESTION]- Practice 1: adapt the loop to compare $\hat\sigma^2_{ML}$ against $\hat\sigma^2_u$ at $n=5$, $\sigma^2=1$, and confirm the theoretical bias $-\sigma^2/n$.
> > [!SUCCESS]- Reference solution
> > ```r
> > niter = 1e4; n = 5
> > v_ml = rep(0, niter); v_u = rep(0, niter)
> > for (i in 1:niter) {
> >   y = rnorm(n, 0, 1); e2 = (y - mean(y))^2
> >   v_ml[i] = sum(e2)/n; v_u[i] = sum(e2)/(n-1)
> > }
> > mean(v_ml) - 1     # ≈ -0.2 = -sigma^2/n
> > mean(v_u)  - 1     # ≈  0
> > var(v_ml); var(v_u)  # ML is the LESS variable of the two
> > ```
> > - **Key move:** compare against the **true** $\sigma^2=1$ you generated with; the run reproduces both halves of [[Estimator Quality (Bias, Variance, MSE)]] — unbiasedness is bought with extra variance.

> [!QUESTION]- Practice 2: why does raising $\sigma$ from $1$ to $10$ leave RelMSE unchanged, while raising $n$ from $10$ to $100$ does not?
> > [!SUCCESS]- Reference solution
> > - **Key move:** $\sigma$ is a pure **scale** — both estimators inherit $\sigma^2$ multiplicatively, so it cancels in the ratio. $n$ is not: $\mathrm{Var}(\bar Y)=\sigma^2/n$ exactly, whereas the median's variance shrinks **more slowly**, so the ratio moves in the mean's favour.

## ⚠️ Common Mistakes
- 💡 **Growing the result vectors inside the loop** ➔ `mu_hat = c(mu_hat, mean(y))` reallocates every iteration ($O(\texttt{niter}^2)$); `rep(0, niterations)` preallocates.
- 💡 **Computing bias against $\bar{\hat\theta}$ instead of $\mu$** ➔ `mean(mu_hat - mean(mu_hat))` is identically $0$ and measures nothing; bias must be taken against the **true parameter you simulated from**.
- 💡 **Skipping the exact-value check** ➔ always confirm the mean's simulated $\mathrm{Var}\approx\sigma^2/n$ first; if that fails, the code is wrong and the median's numbers are meaningless.
- 💡 **Reading "median is more robust" as "median is better"** ➔ on clean normal data the median throws away information and pays $\approx37\%$ more MSE; robustness is only an advantage once contamination is actually present.
- 💡 **Forgetting `var()` uses the $n-1$ divisor** ➔ that is the intended unbiased estimate of the sampling variance here, but it is *not* $\hat\sigma^2_{ML}$.
