---
unit: FIT2086
domain: D
week: 2
source:
  - lecture
  - reading
parent: "[[Expectations and Covariance (FIT2086)]]"
tags:
  - Math/Probability
  - DataScience/Theory
aliases:
  - delta method
  - approximate expectations of functions of RVs
  - second-order Taylor expansion
  - E[f(X)] approximation
---
# [[Taylor Approximation of Expectations]]

**Context:** [[FIT2086_MOC]] · the repair for $E[f(X)]\neq f(E[X])$ ➔ approximates the mean and variance of a **transformed** RV from $\mu$ and $\sigma^2$ alone · consumes the derivative rules in [[Mathematics for Modelling (Log, Exp, Calculus)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** given only $\mu=E[X]$, $\sigma^2=V[X]$ and a twice-differentiable $f$:
> $$E[f(X)]\approx f(\mu)+\frac{\sigma^2}{2}f''(\mu),\qquad V[f(X)]\approx \sigma^2\left(f'(\mu)\right)^2$$
> - **📦 Core Components:** **2nd-order** expansion for the mean (the $f'$ term dies) ➔ **1st-order** expansion for the variance (2nd order would need $V[X^2]$).
> - **⚡ Key Constraint:** the derivatives are evaluated **at $\mu$**, not at $x$ — $\left[\frac{d f(x)}{dx}\right]_{x=\mu}$ is a *number*. Differentiate first, substitute $\mu$ second.

## 📝 How It Works

### 1. The problem it solves
- **Non-linearity breaks the swap** ➔ $E[f(X)]\ne f(E[X])$ in general; equality holds **only** when $f$ is linear in $X$ (then [[Expectations and Covariance (FIT2086)|linearity]] applies exactly).
- **Firing preconditions** ➔ (i) $\mu_X=E[X]$ and $\sigma_X^2=V[X]$ both **exist and are finite**; (ii) $f(x)$ is **twice differentiable** in $x$. State both before applying — the result is void without them.
- **Approximate, not exact** ➔ the error is the truncated Taylor remainder; accuracy degrades as $\sigma^2$ grows or $f$ curves sharply near $\mu$.

### 2. Notation — Leibniz vs Lagrange
- **Same object, two scripts** ➔ $\left[\dfrac{d f(\bar x)}{d\bar x}\right]_{\bar x=\mu}\equiv f'(\mu)$ and $\left[\dfrac{d^2 f(\bar x)}{d\bar x^2}\right]_{\bar x=\mu}\equiv f''(\mu)$.
- **Read Leibniz as an instruction** ➔ differentiate w.r.t. the **dummy** variable $\bar x$, *then* evaluate the resulting function at $\bar x=\mu$; the bracket-then-subscript order is what the notation encodes.
- **Why Leibniz** ➔ it extends cleanly to multiple variables (partial derivatives), which Lagrange's prime does not.
- **Squaring trap** ➔ $\left(f'(\mu)\right)^2=\left[\dfrac{df(\bar x)}{d\bar x}\Big|_{\bar x=\mu}\right]^2$ — square the *evaluated number*, never differentiate $f^2$.

### 3. Formal Proof Blueprint — $E[f(X)]$
**Theorem.** $E[f(X)]\approx f(\mu)+\tfrac{\sigma^2}{2}f''(\mu)$.
**Strategy.** Second-order Taylor expansion of $f$ **about $x=\mu$**, then take expectations term by term and kill the linear term.
$$
\begin{aligned}
f(x) &\approx f(\mu)+f'(\mu)(x-\mu)+\frac{f''(\mu)}{2}(x-\mu)^2 &&\text{(2nd-order expansion at } \mu)\\
E[f(X)] &\approx E\!\left[f(\mu)+f'(\mu)(X-\mu)+\tfrac{f''(\mu)}{2}(X-\mu)^2\right] &&\text{(take } E \text{ of both sides)}\\
&= f(\mu)+f'(\mu)\,E[X-\mu]+\frac{f''(\mu)}{2}E\!\left[(X-\mu)^2\right] &&\text{(linearity; } f(\mu),f'(\mu),f''(\mu) \text{ are constants)}\\
&= f(\mu)+\frac{f''(\mu)}{2}V[X] &&\text{(} E[X-\mu]=0 \text{ by definition of } \mu\text{)}\\
&= f(\mu)+\frac{f''(\mu)}{2}\sigma^2 &&\blacksquare
\end{aligned}
$$**Sealing move:** the **first-derivative contribution vanishes** because $E[X-\mu]=0$, and $E[(X-\mu)^2]$ is precisely $V[X]=\sigma^2$.

### 4. Formal Proof Blueprint — $V[f(X)]$
**Theorem.** $V[f(X)]\approx\sigma^2\left(f'(\mu)\right)^2$.
**Strategy.** **First**-order expansion about $\mu$, then take variances using $V[c]=0$ and $V[cX]=c^2V[X]$.
$$
\begin{aligned}
f(x) &\approx f(\mu)+f'(\mu)(x-\mu) &&\text{(1st-order expansion at } \mu)\\
V[f(X)] &\approx V\!\left[f(\mu)+f'(\mu)(X-\mu)\right]\\
&= V\!\left[f'(\mu)(X-\mu)\right] &&\text{(} V[c]=0 \text{ for constant } c=f(\mu)\text{)}\\
&= \left(f'(\mu)\right)^2 V[X-\mu] &&\text{(} V[cX]=c^2V[X]\text{)}\\
&= \left(f'(\mu)\right)^2\sigma^2 &&\blacksquare
\end{aligned}
$$**Why only first order here** ➔ a second-order expansion would introduce $V[X^2]$, a quantity the assumptions ($\mu$ and $\sigma^2$ only) do not supply.

## ⚖️ Core Decision Matrix
| Target | Expansion order used | Terms that survive | Why the other order fails |
| :--- | :--- | :--- | :--- |
| $E[f(X)]$ | **second** | $f(\mu)$ and $\tfrac{\sigma^2}{2}f''(\mu)$ | first order alone gives $E[f(X)]\approx f(\mu)$ — no $\sigma^2$ correction at all |
| $V[f(X)]$ | **first** | $\left(f'(\mu)\right)^2\sigma^2$ | second order needs $V[X^2]$, unknown under the assumptions |

> [!NOTE] **When It Flips:** the $\sigma^2 f''(\mu)/2$ correction is what separates the approximation from the naive $f(E[X])$. When $f''(\mu)=0$ (locally linear at $\mu$) the two coincide; the larger $|f''(\mu)|\sigma^2$, the worse plugging in the mean becomes.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise — quadratic transform $f(X)=aX^2+c$
**Problem:** $X$ has mean $\mu_X$ and variance $\sigma_X^2$. Approximate $E[f(X)]$ and $V[f(X)]$.
$$
\begin{aligned}
\frac{df(x)}{dx}&=2ax, & \frac{d^2f(x)}{dx^2}&=2a &&\text{(differentiate, then evaluate at } \mu_X)\\
E[f(X)] &\approx f(\mu_X)+\frac{\sigma_X^2}{2}(2a) &=\;& a\mu_X^2+c+a\sigma_X^2\\
V[f(X)] &\approx \sigma_X^2\left(2a\mu_X\right)^2 &=\;& 4(a\mu_X)^2\sigma_X^2
\end{aligned}
$$**Final Extracted Output:** the mean picks up an extra $a\sigma_X^2$ over the naive $a\mu_X^2+c$, and the **variance of a squared RV grows with the square of the mean** of that RV.

## ⚠️ Common Mistakes
- 💡 **Evaluating derivatives at $x$, not $\mu$** ➔ the formulas need *numbers* $f'(\mu),f''(\mu)$; leaving $x$ in the answer means the expectation was never taken.
- 💡 **Using second order for the variance** ➔ tempting for symmetry, but it demands $V[X^2]$ which is outside the assumptions; the first-order result is the examinable one.
- 💡 **Applying it without checking the preconditions** ➔ if $E[X]$ or $V[X]$ does not exist (heavy tails), or $f$ is not twice differentiable, the approximation is invalid — state both conditions when you invoke it.
- 💡 **Reporting $\approx$ as $=$** ➔ these are approximations; only a linear $f$ makes $E[f(X)]=f(E[X])$ exact.

## 🧠 Active Recall
> [!FAQ]- Derive $E[f(X)]\approx f(\mu)+\tfrac{\sigma^2}{2}f''(\mu)$ and explain why the first-derivative term disappears.
> > [!SUCCESS]- Answer
> > - **Short answer:** expand $f(x)\approx f(\mu)+f'(\mu)(x-\mu)+\tfrac{f''(\mu)}{2}(x-\mu)^2$ about $\mu$, then take expectations of the right-hand side.
> > - **Why:** **$E[X-\mu]=0$ by definition of the mean** ➔ the linear term $f'(\mu)E[X-\mu]$ vanishes identically, while $E[(X-\mu)^2]=V[X]=\sigma^2$ by definition of variance, leaving $f(\mu)+\tfrac{f''(\mu)}{2}\sigma^2$. The constants $f(\mu),f'(\mu),f''(\mu)$ pass through $E$ by linearity.

> [!FAQ]- Why is only a first-order expansion used for $V[f(X)]$, when the mean gets a second-order one?
> > [!SUCCESS]- Answer
> > - **Short answer:** a second-order expansion would require the variance of $(X-\mu)^2$, i.e. $V[X^2]$ — a quantity the stated assumptions (finite $\mu$ and $\sigma^2$ only) do not give.
> > - **Why:** **First order suffices because $V[c]=0$ and $V[cX]=c^2V[X]$** ➔ $V[f(\mu)+f'(\mu)(X-\mu)]$ drops the constant $f(\mu)$ entirely and pulls $f'(\mu)$ out squared, yielding $\left(f'(\mu)\right)^2\sigma^2$ using nothing beyond $\sigma^2$.
