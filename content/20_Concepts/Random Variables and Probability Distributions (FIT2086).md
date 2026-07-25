---
unit: FIT2086
domain: [D, E]
week: 1
parent: "[[Statistical Modelling and Inference]]"
tags: [Math/Probability, DataScience/Theory]
aliases: [random variable FIT2086, joint distribution, marginal distribution, sum rule, conditional distribution, independence, iid, pdf, CDF, quantile function, event space]
---
# [[Random Variables and Probability Distributions (FIT2086)]]

**Context:** [[FIT2086_MOC]] · the probability calculus the whole unit runs on · deepens FIT1058's [[Random Variable]] / [[Conditional Probability]] with **joint / marginal / conditional / independence** and the **continuous** pdf–CDF–quantile trio

> [!abstract] Quick Revision
> - **🎯 Objective:** a **random variable** $X$ takes values from an event space $\mathcal{X}$ with probabilities summing to $1$ ➔ manipulate one, two or many RVs via the **sum rule** (marginalise) and **product rule** (condition).
> - **📦 Core Components:** joint $p(x,y)$ ➔ **marginal** $p(x)=\sum_y p(x,y)$ · **conditional** $p(x\mid y)=p(x,y)/p(y)$ · **independence** $p(x,y)=p(x)p(y)$.
> - **⚡ Key Constraint:** for **continuous** RVs a density $f(x)$ is **not** a probability — $f(x)$ can exceed $1$; only **integrals** $\int_a^b f(x)\,dx$ are probabilities, and $P(X=x)=0$ for any single point.

## 📝 Discrete random variables
- **Definition** ➔ $X$ is a random variable if it takes values from a set $\mathcal{X}$ (the **event space**) with specified probabilities; observing $x\in\mathcal{X}$ is the **event** $X=x$.
- **Probability distribution** ➔ a map $\mathcal{X}\to\mathbb{R}$ with
$$P(X=x)\in[0,1]\quad\text{and}\quad \sum_{x\in\mathcal{X}}P(X=x)=1.$$
- **Probability of a subset** ➔ $P(X\in A)=\sum_{x\in A}P(X=x)$.
- **Additivity (mutually exclusive)** ➔ if $A\cap B=\emptyset$: $P(X\in A\text{ or }X\in B)=P(X\in A)+P(X\in B)$.
- **General inclusion–exclusion** ➔ $P(X\in A\text{ or }X\in B)=P(X\in A)+P(X\in B)-P(X\in A\cap B)$.
- **Realisation** ➔ a value drawn at random from $\mathcal{X}$; over long runs, relative frequencies approach the probabilities.

## 🔗 Two (and many) random variables
### Joint, marginal, conditional
- **Joint distribution** ➔ $p(x,y)=P(X=x,\,Y=y)$ for $x\in\mathcal{X},\,y\in\mathcal{Y}$; still sums to $1$ over all pairs.
- **Sum rule (marginalisation)** ➔ recover a single-variable distribution by summing out the other:
$$p(x)=\sum_{y\in\mathcal{Y}}p(x,y), \qquad p(y)=\sum_{x\in\mathcal{X}}p(x,y).$$
- **Product / conditional rule** ➔
$$p(x\mid y)=\frac{p(x,y)}{p(y)}\quad(p(y)>0), \qquad\Longrightarrow\qquad p(x,y)=p(x\mid y)\,p(y).$$

### Independence and i.i.d.
- **Independent** ➔ $X,Y$ are independent iff $p(x,y)=p(x)\,p(y)$ for all $x,y$ — equivalently $p(x\mid y)=p(x)$ (knowing $Y$ tells you nothing about $X$).
- **i.i.d.** ➔ a sample $y_1,\dots,y_n$ is **independent and identically distributed** if the $y_i$ are mutually independent and share one distribution $p(\cdot)$, so
$$p(y_1,\dots,y_n)=\prod_{i=1}^{n}p(y_i).$$
- **Why it matters** ➔ the i.i.d. product is the backbone of the **likelihood** used to fit models (coming weeks).

## 📈 Continuous random variables
- **Probability density function (pdf)** ➔ $f(x)\ge 0$ with $\int_{\mathcal{X}}f(x)\,dx=1$; probabilities come from **integration**:
$$P(a\le X\le b)=\int_a^b f(x)\,dx, \qquad P(X=x)=0.$$
- **Continuous sum rule** ➔ integrate to marginalise: $\;f(x)=\int f(x,y)\,dy$.
- **Continuous conditional** ➔ $\;f(x\mid y)=\dfrac{f(x,y)}{f(y)}$ (same form, densities in place of masses).

### CDF and quantile function
- **Cumulative distribution function (CDF)** ➔ $F(x)=P(X\le x)=\int_{-\infty}^{x}f(t)\,dt$; non-decreasing from $0$ to $1$, and $f(x)=F'(x)$.
- **Quantile function** ➔ the inverse, $Q(p)=F^{-1}(p)$: the value with probability $p$ below it. The **median** is $Q(0.5)$; quartiles are $Q(0.25),Q(0.75)$ (see [[Measures of Spread and Boxplots]]).
- **Interval probabilities via CDF** ➔ $P(a<X\le b)=F(b)-F(a)$.

## 🖼️ Modelling application — generative AI (sketch)
- **Joint over images + tags** ➔ let $I$ be an image and $\mathbf{t}$ its tag vector; a model posits a joint $p(I,\mathbf{t})$.
- **Generate by conditioning** ➔ given target tags $\mathbf{t}^{*}$, form $p(I\mid\mathbf{t}^{*})=\dfrac{p(I,\mathbf{t}^{*})}{\int p(I,\mathbf{t}^{*})\,dI}$ and sample an image — the sum/product rules doing real work.

## ⚠️ Common Mistakes
- 💡 **A density is not a probability** ➔ $f(x)$ may be $>1$; only $\int_a^b f$ is a probability, and $P(X=x)=0$ for continuous $X$. Confusing $f$ with $P$ is the classic error.
- 💡 **Marginalise the *other* variable** ➔ to get $p(x)$ you sum/integrate over $y$; summing over $x$ instead gives $p(y)$.
- 💡 **Conditioning needs $p(y)>0$** ➔ $p(x\mid y)=p(x,y)/p(y)$ is undefined when the conditioning event has zero probability.
- 💡 **Independence is a factorisation, not "unrelated intuitively"** ➔ check $p(x,y)=p(x)p(y)$ for **all** pairs; a single failing pair breaks it.

## 🧠 Active Recall
> [!FAQ]- From a joint distribution $p(x,y)$, how do you obtain a marginal and a conditional, and when are $X,Y$ independent?
> > [!SUCCESS]- Answer
> > - **Short answer:** **marginal** by the sum rule $p(x)=\sum_y p(x,y)$; **conditional** by the product rule $p(x\mid y)=p(x,y)/p(y)$; **independent** iff $p(x,y)=p(x)p(y)$ for all $x,y$ (equivalently $p(x\mid y)=p(x)$).
> > - **Why:** **Sum rule removes a variable, product rule re-weights** ➔ marginalising integrates out the unwanted variable; conditioning renormalises the joint by the probability of the conditioning event; independence is exactly the case where that renormalisation leaves $p(x)$ unchanged.

> [!FAQ]- Why is $f(x)$ for a continuous RV allowed to exceed 1, and what does $P(X=x)$ equal?
> > [!SUCCESS]- Answer
> > - **Short answer:** $f(x)$ is a **density**, not a probability — only its **integral** over an interval is a probability, and that integral is bounded by $1$. A single point has zero width, so $P(X=x)=\int_x^x f=0$.
> > - **Why:** **Probability = area under $f$** ➔ a tall, narrow density can have $f(x)>1$ while $\int f=1$ overall (e.g. a Uniform on $[0,0.5]$ has $f=2$); probabilities are areas $\int_a^b f\,dx$, recovered cumulatively by the CDF $F(x)=\int_{-\infty}^x f$.
