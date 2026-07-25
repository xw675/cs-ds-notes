---
unit: FIT2086
domain: [D, E]
week: 0
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Calculus, DataScience/Modelling]
aliases: [log identities, exp identities, derivative rules, product rule, chain rule, partial derivative, log-likelihood algebra, MLE toolkit]
---
# [[Mathematics for Modelling (Log, Exp, Calculus)]]

**Context:** [[FIT2086_MOC]] · the algebra + calculus toolkit every derivation leans on · used to differentiate **log-likelihoods** when fitting models (MLE, coming weeks)

> [!abstract] Quick Revision
> - **🎯 Objective:** the **log/exp identities** that turn products into sums, plus the **derivative rules** (product, chain, partial) needed to maximise a function ➔ the mechanics behind every parameter estimate.
> - **⚡ Key Constraint:** $\log$ turns a **product into a sum** ($\log\prod = \sum\log$) — this is *why* we maximise the **log**-likelihood: the i.i.d. product $\prod_i p(y_i)$ becomes a differentiable sum $\sum_i\log p(y_i)$.

## 📝 Logarithm identities
$$
\begin{aligned}
\log 1 &= 0 \\
\log(ab) &= \log a + \log b \\
\log(a/b) &= \log a - \log b \\
\log(a^{b}) &= b\log a
\end{aligned}
$$
- **Convention** ➔ in this unit $\log$ means the **natural** log ($\ln$, base $e$), the inverse of $e^{x}$.
- **The key move** ➔ $\log\!\Big(\prod_{i} x_i\Big)=\sum_i \log x_i$ — collapses a likelihood product into a sum.

## 📝 Exponential identities
$$
e^{a}e^{b}=e^{a+b}, \qquad e^{-a}=\frac{1}{e^{a}}, \qquad (e^{a})^{b}=e^{ab}
$$
- **Inverse pair** ➔ $\log(e^{x})=x$ and $e^{\log x}=x$ (for $x>0$).

## 📝 Derivative rules
$$
\begin{aligned}
\frac{d}{dx}\{x^{n}\} &= n\,x^{n-1} & \frac{d}{dx}\{\log x\} &= \frac{1}{x} & \frac{d}{dx}\{e^{x}\} &= e^{x} \\[4pt]
\textbf{Linearity:}\quad \frac{d}{dx}\{a\,f(x)+b\} &= a\,\frac{d}{dx}\{f(x)\} \\[4pt]
\textbf{Product rule:}\quad \frac{d}{dx}\{f(x)g(x)\} &= g(x)\,\frac{d}{dx}\{f(x)\} + f(x)\,\frac{d}{dx}\{g(x)\} \\[4pt]
\textbf{Chain rule:}\quad \frac{d}{dx}\{f(g(x))\} &= \frac{d}{d\,g(x)}\{f(g(x))\}\cdot\frac{d}{dx}\{g(x)\}
\end{aligned}
$$

## 📝 Partial derivatives
- **Definition** ➔ $\dfrac{\partial f(x,y)}{\partial x}$ differentiates $f$ w.r.t. $x$ while **treating $y$ as a constant**.
- **Worked example** ➔
$$
\begin{aligned}
\frac{\partial}{\partial x}\Big\{y\log\big(x^{2}y+1\big)\Big\}
&= y\,\frac{\partial}{\partial x}\Big\{\log\big(x^{2}y+1\big)\Big\} && \text{(linearity: } y \text{ constant)}\\
&= y\cdot\frac{1}{x^{2}y+1}\cdot\frac{\partial}{\partial x}\big\{x^{2}y+1\big\} && \text{(chain rule)}\\
&= \frac{2xy^{2}}{x^{2}y+1}
\end{aligned}
$$
- **Why it appears** ➔ models have **several** parameters; maximising a log-likelihood means setting **each** partial derivative $\partial/\partial\theta_j$ to zero.

## ⚠️ Common Mistakes
- 💡 **$\log$ of a sum does not split** ➔ $\log(a+b)\neq\log a+\log b$; only **products/quotients/powers** simplify. This is why the likelihood *product* is what becomes a sum, not the density itself.
- 💡 **Chain rule is the usual omission** ➔ differentiating $\log(g(x))$ gives $g'(x)/g(x)$, not $1/g(x)$ — the inner derivative is essential.
- 💡 **Partial ⇒ freeze the others** ➔ every variable except the one you differentiate is a constant; forgetting this drops terms.
- 💡 **Maximise the log, not the raw likelihood** ➔ $\log$ is monotincreasing, so the maximiser is unchanged, but the sum is far easier to differentiate than the product.

## 🧠 Active Recall
> [!FAQ]- Why do we maximise the log-likelihood instead of the likelihood itself?
> > [!SUCCESS]- Answer
> > - **Short answer:** the likelihood of an i.i.d. sample is a **product** $\prod_i p(y_i\mid\theta)$, which is awkward to differentiate. Taking $\log$ turns it into a **sum** $\sum_i\log p(y_i\mid\theta)$ via $\log\prod=\sum\log$, and because $\log$ is strictly increasing the **maximiser $\hat\theta$ is identical**.
> > - **Why:** **Monotone transform + sum rule for derivatives** ➔ maximising a monotone function of $L$ maximises $L$; and $\frac{d}{d\theta}\sum_i(\cdots)=\sum_i\frac{d}{d\theta}(\cdots)$ by linearity, so a sum differentiates term-by-term where a product would need the product rule repeatedly.

> [!FAQ]- Compute $\dfrac{\partial}{\partial x}\{y\log(x^2 y + 1)\}$ and name the rules used.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\dfrac{2xy^{2}}{x^{2}y+1}$.
> > - **Why:** **Linearity → chain rule** ➔ treat $y$ as constant and pull it out (linearity); differentiate $\log(u)$ as $1/u$ times $u'$ with $u=x^2y+1$ (chain rule), giving $u'=2xy$; combine: $y\cdot\frac{1}{x^2y+1}\cdot 2xy = \frac{2xy^2}{x^2y+1}$.
