---
unit: FIT2086
week: 9
source: [applied]
domain: D
parent: "[[Estimator Quality (Bias, Variance, MSE)]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [Shrinkage Estimator, Shrunken Mean, mu hat c, Studio 8 shrinkage, Ridge Estimate of a Mean]
---
# [[Shrinkage Estimator of the Mean]]

**Context:** [[FIT2086_MOC]] · Studio 8 · the one-parameter version of [[Penalized Regression (Ridge and Lasso)|ridge]] · a hand-derivable instance of $\text{MSE}=b^2+\mathrm{Var}$ from [[Estimator Quality (Bias, Variance, MSE)]] · the trade the [[Bias-Variance Tradeoff (Underfitting vs Overfitting)|bias–variance tradeoff]] describes
**Parent Framework:** [[Estimator Quality (Bias, Variance, MSE)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $\hat\mu(c)=\frac{n}{n+c}\bar Y$ ➔ $b=-\frac{c\mu}{n+c}$, $\mathrm{Var}=\frac{n\sigma^2}{(n+c)^2}$ ➔ beats $\bar Y$ when $\mu^2<\sigma^2\frac{2n+c}{nc}$ ➔ and it **is** ridge: $\arg\min_\mu\{\tfrac12\sum(y_i-\mu)^2+\tfrac c2\mu^2\}$.
> - **⚠️ Key Constraint:** shrinkage wins only **near the shrinkage target** $\mu=0$; far from it the squared bias $\frac{c^2\mu^2}{(n+c)^2}$ grows without bound.

## 📝 How It Works
### 1. The Estimator
- **Baseline** ➔ $Y_1,\dots,Y_n\sim N(\mu,\sigma^2)$ iid; ML $\hat\mu=\bar Y$ has $b=0$, $\mathrm{Var}=\mathrm{MSE}=\sigma^2/n$, consistent.
- **Shrinkage** ➔ $\hat\mu(c)=\dfrac{1}{n+c}\sum_{i=1}^{n}y_i=\dfrac{n}{n+c}\,\hat\mu$, $c>0$ ⟹ multiplier $0<\frac{n}{n+c}<1$ pulls $\hat\mu$ towards $0$.
- **Tools** ➔ $\mathbb{E}[aX]=a\,\mathbb{E}[X]$ and $\mathbb{V}[aX]=a^2\,\mathbb{V}[X]$ with $a=\frac{n}{n+c}$.

### 2. Reading the MSE Curves ($\sigma^2=1$, $n=1$)
- **Formula** ➔ $\mathrm{MSE}(\hat\mu(c))=\dfrac{c^2\mu^2+1}{(1+c)^2}$ vs flat $\mathrm{MSE}(\hat\mu)=1$ — a parabola in $\mu$.
- **Crossover** ➔ $\hat\mu(c)$ wins iff $\lvert\mu\rvert<\sqrt{1+2/c}$.

| $c$ | MSE at $\mu=0$ | wins while $\lvert\mu\rvert<$ | MSE at $\mu=\pm5$ |
| :--- | :--- | :--- | :--- |
| $0.1$ | $0.826$ | $4.58$ | $1.03$ |
| $1$ | $0.25$ | $1.73$ | $6.5$ |
| $5$ | $0.028$ | $1.18$ | $17.4$ |

- **As $c\uparrow$** ➔ the dip at $\mu=0$ deepens (less variance) but the winning window narrows and the walls steepen (more bias) ⟹ $c$ plays the role of $\lambda$.

### 3. Consistency
- **$n\to\infty$, $c$ fixed** ➔ $b=-\frac{c\mu}{n+c}\to0$ and $\mathrm{Var}=\frac{n\sigma^2}{(n+c)^2}\to0$ ⟹ $\mathrm{MSE}\to0$ ⟹ **consistent** — the penalty's influence fades as data accumulate.

## 🧮 Proof Blueprint
- **Theorem** ➔ $\mathrm{MSE}(\hat\mu(c))=\dfrac{c^2\mu^2+n\sigma^2}{(n+c)^2}$, and $\hat\mu(c)=\arg\min_\mu\left\{\tfrac12\sum_{i=1}^{n}(y_i-\mu)^2+\tfrac{c\mu^2}{2}\right\}$.
- **Strategy** ➔ bias and variance by linearity of $\mathbb{E}$ and $\mathbb{V}$; the argmin by setting the derivative to zero and checking the second derivative.
- **Derivation Steps:**
$$
\begin{aligned}
\mathbb{E}[\hat\mu(c)] &= \frac{n}{n+c}\,\mathbb{E}[\bar Y] = \frac{n\mu}{n+c} \\
b(\hat\mu(c)) &= \frac{n\mu}{n+c}-\mu = -\frac{c\mu}{n+c} \\
\mathbb{V}[\hat\mu(c)] &= \left(\frac{n}{n+c}\right)^2\frac{\sigma^2}{n} = \frac{n\sigma^2}{(n+c)^2} \\
\mathrm{MSE}(\hat\mu(c)) &= b^2+\mathbb{V} = \frac{c^2\mu^2+n\sigma^2}{(n+c)^2}
\end{aligned}
$$
- **Crossover** ➔ $\mathrm{MSE}(\hat\mu(c))<\frac{\sigma^2}{n}$ ⟺ $c^2\mu^2<\frac{\sigma^2}{n}\big[(n+c)^2-n^2\big]=\frac{\sigma^2c(2n+c)}{n}$ ⟺ $\mu^2<\sigma^2\frac{2n+c}{nc}$.
- **Ridge form:**
$$
\begin{aligned}
\frac{d}{d\mu}\left\{\tfrac12\sum_{i=1}^{n}(y_i-\mu)^2+\tfrac{c}{2}\mu^2\right\} &= -\sum_{i=1}^{n}(y_i-\mu)+c\mu = 0 \\
(n+c)\,\mu &= \sum_{i=1}^{n}y_i \quad\Rightarrow\quad \hat\mu = \frac{1}{n+c}\sum_{i=1}^{n}y_i = \hat\mu(c) \\
\frac{d^2}{d\mu^2}\{\cdot\} &= n+c > 0 \quad\Rightarrow\quad \text{minimum}
\end{aligned}
$$
- **Q.E.D.** ➔ the shrinkage estimator is least squares plus an $\ell_2$ penalty $\tfrac c2\mu^2$ — ridge regression with only an intercept, penalty $c$ in place of $\lambda$.

## ⚙️ Core Implementation
### 🔹 MSE curves in R
> [!code]- Plot for $\sigma^2=1$, $n=1$
> ```r
> mu = seq(-5, 5, length.out = 200); n = 1; s2 = 1
> mse = function(c) (c^2 * mu^2 + n * s2) / (n + c)^2
> plot(mu, rep(s2/n, length(mu)), type = "l", ylim = c(0, 3), lwd = 2,
>      xlab = expression(mu), ylab = "MSE")          # ML: flat at sigma^2/n
> lines(mu, mse(0.1), col = "blue"); lines(mu, mse(1), col = "red"); lines(mu, mse(5), col = "darkgreen")
> legend("top", c("ML", "c=0.1", "c=1", "c=5"), col = c("black","blue","red","darkgreen"), lty = 1)
> ```
> 💡 **Common Mistake:** **Plotting against the data** ➔ MSE is a function of the unknown **$\mu$**, averaged over all samples; the x-axis is $\mu$, not $y$.

## ⚠️ Common Mistakes
- 💡 **Dropping the square on the multiplier** ➔ $\mathbb{V}[a\bar Y]=a^2\sigma^2/n$, giving $\frac{n\sigma^2}{(n+c)^2}$, not $\frac{\sigma^2}{n+c}$.
- 💡 **"Biased ⟹ worse"** ➔ near $\mu=0$ the biased estimator has **lower** MSE; bias is a cost, not a verdict.
- 💡 **Calling it inconsistent because it is biased** ➔ the bias vanishes as $n\to\infty$.

## 🧠 Active Recall
> [!FAQ]- Why does $\hat\mu(c)$ beat $\bar Y$ for some $\mu$ but lose badly for others, and how does $c$ move the boundary?
> > [!SUCCESS]- Answer
> > - **Short answer:** It always has less variance, but its bias grows with $\lvert\mu\rvert$; it wins while the variance saving exceeds $b^2$, i.e. $\mu^2<\sigma^2\frac{2n+c}{nc}$ — larger $c$ saves more variance but narrows the window.
> > - **Why:** **$b^2$ vs Var** ➔ $\mathrm{MSE}=\frac{c^2\mu^2+n\sigma^2}{(n+c)^2}$: the $n\sigma^2$ term shrinks with $c$, the $c^2\mu^2$ term grows with $\lvert\mu\rvert$.

> [!FAQ]- What does this one-parameter example say about ridge regression?
> > [!SUCCESS]- Answer
> > - **Short answer:** Ridge is the same move per coefficient — pull estimates towards zero to cut variance at the cost of bias, lowering MSE when the true coefficients are small relative to the noise.
> > - **Why:** **Same objective** ➔ $\tfrac12\sum(y_i-\mu)^2+\tfrac c2\mu^2$ is ridge's $\text{RSS}+\lambda\sum_j\beta_j^2$ (up to a factor of $\tfrac12$) with a single parameter.
