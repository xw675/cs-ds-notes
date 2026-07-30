---
unit: FIT2086
week: 3
source: [lecture]
domain: D
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Probability, DataScience/Modelling]
aliases: [MLE, ML estimator, likelihood, negative log-likelihood, point estimation, plug-in distribution, minimum sum of squared errors, SSE]
---
# [[Maximum Likelihood Estimation]]

**Context:** [[FIT2086_MOC]] · the unit's **universal fitting engine** — turns a [[Parametric Probability Distributions|family $p(y\mid\theta)$]] plus a sample into a number $\hat\theta$ · quality of that $\hat\theta$ is judged in [[Estimator Quality (Bias, Variance, MSE)]], its variability in [[Sampling Distribution of an Estimator]] · Fisher, 1920s

> [!abstract] Quick Revision
> - **🎯 Objective:** pick the $\theta$ that assigns the **greatest probability to the data observed** ➔ $\hat\theta=\arg\max_\theta p(\mathbf{y}\mid\theta)=\arg\min_\theta\{-\log p(\mathbf{y}\mid\theta)\}$.
> - **📦 Core Components:** likelihood $p(\mathbf{y}\mid\theta)=\prod_i p(y_i\mid\theta)$ ➔ NLL $L(\mathbf{y}\mid\theta)=-\log p(\mathbf{y}\mid\theta)$ ➔ $\frac{d}{d\theta}L=0$ ➔ $\hat\theta$.
> - **⚡ Key Constraint:** $L$ is the **negative** log-likelihood, so you **minimise** it — flip a sign and every derivation lands on a maximum of the wrong quantity.

## 📝 How It Works
### 1. The three tasks of inference
- **Point estimation** ➔ learn one best-fitting parameter value from the data — this note.
- **Interval estimation** ➔ quantify accuracy/confidence in that fit (W4 CIs).
- **Hypothesis testing** ➔ decide whether a stated claim about the data-generating process is plausible (W5).

### 2. Why not just minimise squared error
- **The heuristic** ➔ choose $\mu$ close to all points under squared error: $\mathrm{SSE}(\mu)=\sum_{i=1}^n(y_i-\mu)^2$, so $\hat\mu=\arg\min_\mu\{\mathrm{SSE}(\mu)\}$ — read $\arg\min_x f(x)$ as *the $x$ that minimises $f$*, and the **hat** as "estimator of".
- **It gives the sample mean** ➔ $\frac{d\,\mathrm{SSE}}{d\mu}=-2\sum_i(y_i-\mu)=-2\sum_i y_i+2n\mu=0\Rightarrow\hat\mu=\frac1n\sum_i y_i$ — the sample mean is the closest point to the sample *in a squared sense*.
- **⚡ Key Constraint:** **no handle on $\sigma$** ➔ squared error scores only the *centre*; a spread parameter has no obvious goodness-of-fit under it, so a general criterion is needed.

### 3. The likelihood criterion
- **Goodness-of-fit = probability assigned to the data** ➔ score a candidate $\theta$ by $p(\mathbf{y}\mid\theta)$; larger means the observed data is more likely under that model. Read as the **likelihood function** — a function of $\theta$ with $\mathbf{y}$ fixed.
- **Independence factorises it** ➔ $p(\mathbf{y}\mid\theta)=\prod_{i=1}^n p(y_i\mid\theta)$ for the iid models of this unit.
- **Work with the NLL** ➔ products of $n$ small probabilities are analytically and numerically horrible; $-\log$ turns them into sums, and $\arg\max p=\arg\min\{-\log p\}$ because $\log$ is strictly increasing.
- **Notation** ➔ $L(\mathbf{y}\mid\theta)\equiv-\log p(\mathbf{y}\mid\theta)$; $\theta$ is generic, and for Bernoulli the *specific* parameter also happens to be called $\theta$.
- **Status** ➔ originally a **heuristic**, later shown to have strong properties — notably **statistical consistency** for most models.

### 4. Product and log identities (the whole algebra of step 2)
- **Constants** ➔ $\prod_{i=1}^n a=a^n$ · $\prod_{i=1}^n e^{-\theta}=e^{-n\theta}$.
- **Exponents collapse to sums** ➔ $\prod_{i=1}^n a^{x_i}=a^{\sum_i x_i}$ · $\prod_{i=1}^n e^{-\theta x_i}=e^{-\theta\sum_i x_i}$.
- **Constant factors pull out** ➔ $\prod_{i=1}^n a\,x_i=a^n\prod_{i=1}^n x_i$.
- **Then log** ➔ $\log(ab)=\log a+\log b$ · $\log\left(\prod_i y_i\right)=\sum_i\log y_i$ · $\frac{d}{dx}\log x=\frac1x$ · terms free of $\theta$ are **constants** whose derivative vanishes.

### 5. Using the fit: the plug-in distribution
- **Plug-in** ➔ substitute the estimates back into the family, $p(y\mid\hat\mu,\hat\sigma^2)$, and treat it as the population.
- **What it buys** ➔ probability statements about the population: for the height data, $P(1.6<X<1.8\mid\hat\mu=1.6789,\hat\sigma^2=0.1032^2)\approx0.664$.
- **Accuracy inherits** ➔ the better $\hat\theta$, the more trustworthy every downstream probability — which is why estimator quality gets its own note.

## 🧮 Proof Blueprint
**Theorem (ML recipe).** For iid $y_1,\dots,y_n\sim p(y\mid\theta)$, $\hat\theta$ solves $\frac{\partial}{\partial\theta}L(\mathbf{y}\mid\theta)=0$.
**Strategy:** factorise ➔ take $-\log$ ➔ differentiate ➔ set to zero ➔ rearrange.

**Derivation — Gaussian $N(\mu,\sigma^2)$, $\theta=(\mu,\sigma)$:**
$$
\begin{aligned}
p(\mathbf{y}\mid\mu,\sigma^2)&=\prod_{i=1}^n\left(\frac{1}{2\pi\sigma^2}\right)^{1/2}\!\exp\!\left(-\frac{(y_i-\mu)^2}{2\sigma^2}\right)=\left(\frac{1}{2\pi\sigma^2}\right)^{n/2}\!\exp\!\left(-\frac{1}{2\sigma^2}\sum_i(y_i-\mu)^2\right)\\
L(\mathbf{y}\mid\mu,\sigma)&=\frac{n}{2}\log(2\pi\sigma^2)+\frac{1}{2\sigma^2}\sum_{i=1}^n(y_i-\mu)^2\\
\frac{\partial L}{\partial\mu}&=-\frac{1}{\sigma^2}\sum_i(y_i-\mu)=-\frac{1}{\sigma^2}\sum_i y_i+\frac{n\mu}{\sigma^2}=0\;\Rightarrow\;\hat\mu=\frac1n\sum_{i=1}^n y_i\\
\frac{\partial L}{\partial\sigma}\bigg|_{\mu=\hat\mu}&=\frac{n}{\sigma}-\frac{1}{\sigma^3}\sum_i(y_i-\hat\mu)^2=0\;\Rightarrow\;n\sigma^2=\sum_i(y_i-\hat\mu)^2\;\Rightarrow\;\hat\sigma=\sqrt{\frac1n\sum_{i=1}^n(y_i-\hat\mu)^2}
\end{aligned}
$$
**Q.E.D.** ➔ for the Gaussian the ML estimators are the **sample mean** and the **sample standard deviation** (with divisor $n$). Multiply through by $\sigma^3$ to clear denominators; $\hat\mu$ is substituted **before** differentiating in $\sigma$, which removes $\mu$ from the equation.

**Derivation — Poisson $Poi(\lambda)$, $p(y\mid\lambda)=\lambda^y e^{-\lambda}/y!$:**
$$
\begin{aligned}
p(\mathbf{y}\mid\lambda)&=\frac{\lambda^{\sum_i y_i}e^{-n\lambda}}{\prod_i y_i!},\qquad
L(\mathbf{y}\mid\lambda)=-\sum_i y_i\log\lambda+n\lambda+\sum_i\log y_i!\\
\frac{dL}{d\lambda}&=-\frac1\lambda\sum_i y_i+n=0\;\Rightarrow\;\hat\lambda=\frac1n\sum_{i=1}^n y_i
\end{aligned}
$$
**Q.E.D.** ➔ the Poisson rate's MLE is again the sample mean — **but this coincidence is not a rule**, as the practice derivations below show.

## 📊 Worked Numbers
| Data | Family | ML estimates | Read-off |
| :--- | :--- | :--- | :--- |
| $\mathbf{y}=(1.75,1.64,1.81,1.55,1.51,1.67,1.83,1.63,1.72)$, $n=9$ | $N(\mu,\sigma^2)$ | $\hat\mu=1.6789$, $\hat\sigma=0.1032$ ($\hat\sigma^2=0.0107$) | bulk of samples inside $(\hat\mu-2\hat\sigma,\hat\mu+2\hat\sigma)\approx(1.47,1.88)$ |
| $\mathbf{y}=(7,9,3,5,3,4,4,9,4,6)$, $n=10$ | $Poi(\lambda)$ | $\hat\lambda=5.4$ | $\hat\lambda=\bar y$, and $E[X]=V[X]=5.4$ under the fit |
| same 9 heights | plug-in $N(\hat\mu,\hat\sigma^2)$ | — | $P(1.6<X<1.8)\approx0.664$ |

## ✍️ Practice
> [!QUESTION]- Practice 1: $Y_1,\dots,Y_n\sim\mathrm{Exp}(\beta)$ with $p(y\mid\beta)=\beta e^{-\beta y}$. Derive $\hat\beta_{\text{MLE}}$.
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > p(\mathbf{y}\mid\beta)&=\prod_{i=1}^n\beta e^{-\beta y_i}=\beta^n e^{-\beta\sum_i y_i}\\
> > L(\mathbf{y}\mid\beta)&=-n\log\beta+\beta\sum_i y_i\\
> > \frac{dL}{d\beta}&=-\frac{n}{\beta}+\sum_i y_i=0\;\Rightarrow\;\hat\beta=\frac{n}{\sum_i y_i}=\frac{1}{\bar y}
> > \end{aligned}
> > $$
> > - **Key move:** $\prod e^{-\beta y_i}=e^{-\beta\sum y_i}$ ➔ the estimator is the **reciprocal** of the sample mean, not the sample mean.

> [!QUESTION]- Practice 2: pollination rates $X_1,\dots,X_n$ have $f(x\mid\theta)=\frac1\theta x^{(1-\theta)/\theta}$ on $0<x<1$, $\theta>0$. Derive $\hat\theta_{\text{MLE}}$.
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > P(\mathbf{x}\mid\theta)&=\prod_{i=1}^n\frac1\theta x_i^{(1-\theta)/\theta}=\frac{1}{\theta^n}\prod_{i=1}^n x_i^{(1-\theta)/\theta}\\
> > L(\mathbf{x}\mid\theta)&=n\log\theta-\frac{1-\theta}{\theta}\sum_{i=1}^n\log x_i=n\log\theta-\frac{1}{\theta}\sum_i\log x_i+\sum_i\log x_i\\
> > \frac{dL}{d\theta}&=\frac{n}{\theta}+\frac{1}{\theta^2}\sum_i\log x_i=0\;\Rightarrow\;n\theta+\sum_i\log x_i=0\;\Rightarrow\;\hat\theta=-\frac{\sum_{i=1}^n\log x_i}{n}
> > \end{aligned}
> > $$
> > - **Key move:** $\log\left(\prod x_i^{c}\right)=c\sum\log x_i$, then multiply by $\theta^2$ to clear denominators; $\hat\theta>0$ because $\log x_i<0$ on $0<x<1$.

> [!QUESTION]- Practice 3: seed germination with $f_X(x)=\lambda x^{\lambda-1}$ on $0<x<1$ (else $0$), $\lambda>0$. Derive $\hat\lambda_{\text{MLE}}$ and contrast with Practice 2.
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > P(\mathbf{x}\mid\lambda)&=\prod_{i=1}^n\lambda x_i^{\lambda-1}=\lambda^n\left(\prod_{i=1}^n x_i\right)^{\lambda-1}\\
> > L(\mathbf{x}\mid\lambda)&=-n\log\lambda-(\lambda-1)\sum_{i=1}^n\log x_i\\
> > \frac{dL}{d\lambda}&=-\frac{n}{\lambda}-\sum_i\log x_i=0\;\Rightarrow\;\frac{n}{\lambda}=-\sum_i\log x_i\;\Rightarrow\;\hat\lambda=-\frac{n}{\sum_{i=1}^n\log x_i}
> > \end{aligned}
> > $$
> > - **Key move:** the exponent here is $\lambda-1$ (linear in the parameter) versus $(1-\theta)/\theta$ (a **reciprocal** in the parameter) ➔ same data, **reciprocal** estimators: $\hat\lambda=n/(-\sum\log x_i)$ against $\hat\theta=(-\sum\log x_i)/n$.

## ⚠️ Common Mistakes
- 💡 **Maximising the NLL** ➔ $L$ carries the minus sign already; maximise $p(\mathbf{y}\mid\theta)$ **or** minimise $L(\mathbf{y}\mid\theta)$, never maximise $L$.
- 💡 **Dropping the $\theta$-free terms too early — or too late** ➔ $\sum\log y_i!$ (Poisson) and $\frac{n}{2}\log 2\pi$ (Gaussian) vanish on differentiation, but they belong in $L$ if the question asks for the NLL *value*.
- 💡 **Differentiating in $\sigma$ before plugging in $\hat\mu$** ➔ leaves two unknowns coupled; substitute $\hat\mu$ first, then the $\sigma$ equation solves in one line.
- 💡 **Assuming the MLE is always the sample mean** ➔ true for Gaussian $\mu$ and Poisson $\lambda$, false for $\mathrm{Exp}(\beta)$ ($1/\bar y$) and for the power families above.
- 💡 **Forgetting the ML variance divides by $n$** ➔ $\hat\sigma^2_{ML}=\frac1n\sum(y_i-\bar y)^2$; the $n-1$ version is a *different*, unbiased estimator — see [[Estimator Quality (Bias, Variance, MSE)]].

## 🧠 Active Recall
> [!FAQ]- Why is minimum squared error abandoned in favour of maximum likelihood, given both return $\bar y$ for the Gaussian mean?
> > [!SUCCESS]- Answer
> > - **Short answer:** SSE only scores **closeness of a centre** — it offers no goodness-of-fit measure for a spread parameter like $\sigma$, whereas ML scores the **whole model** and so estimates every parameter of any family.
> > - **Why:** **Generality** ➔ ML's criterion $p(\mathbf{y}\mid\theta)$ is defined for any $\theta\in\Theta$ of any distribution, giving simultaneous equations $\partial L/\partial\mu=0,\ \partial L/\partial\sigma=0$; the agreement on $\hat\mu=\bar y$ is a **coincidence of the Gaussian's quadratic exponent**, not equivalence of methods.

> [!FAQ]- Why take logs at all, and why does it not change the answer?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\log$ turns $\prod_i p(y_i\mid\theta)$ into $\sum_i\log p(y_i\mid\theta)$ — differentiable term by term and numerically stable — and because $\log$ is **strictly increasing**, $\arg\max_\theta p=\arg\max_\theta\log p=\arg\min_\theta\{-\log p\}$.
> > - **Why:** **Monotone reparameterisation of the objective** ➔ a strictly increasing transform preserves the *location* of the extremum while changing its value; without it the product of $n$ densities underflows and the chain rule compounds across $n$ factors.
