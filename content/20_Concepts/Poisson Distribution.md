---
unit: [FIT1058, FIT2086]
domain: D
week: [2, 3, 10]
source: [lecture, applied]
parent: "[[Random Variable]]"
tags: [Math/Probability, Math/Discrete]
aliases: [Pois(lambda), rate parameter, Poisson thinning, dpois, ppois, Poisson process]
---
# [[Poisson Distribution]]

**Context:** [[FIT1058_MOC]], [[FIT2086_MOC]] · counts independent events in an interval · pmf $e^{-\mu}\mu^k/k!$ · large-$n$ small-$np$ approximation to the [[Binomial Distribution|binomial]] · the $\mathbb{Z}^{+}$ member of the [[Parametric Probability Distributions|parametric zoo]]

> [!abstract] Quick Revision
> - **🎯 Objective:** count of rare independent events in an interval ➔ $\mathrm{Pr}(X=k)=e^{-\mu}\mu^k/k!$ ($\mu\equiv\lambda$, the **rate**).
> - **📦 Core Components:** one parameter $\mu$ ➔ $E=\mathrm{Var}=\mu$ ➔ unbounded support ➔ closed under addition and interval-splitting.
> - **⚡ Key Constraint:** approximates $\mathrm{Bin}(n,p)$ for large $n$, small $np$ ($\mu=np$); the four modelling conditions must actually hold.

## 📝 Core
### 1. The Distribution
- **Definition** ➔ $\mathrm{Pr}(X=k)=\frac{e^{-\mu}\mu^k}{k!}$, $k\in\mathbb N_0$, $\mu>0$; FIT2086 writes $X\sim Pois(\lambda)$ with $\lambda$ called the **rate**.
- **One parameter** ➔ $E(X)=\mu$, $\mathrm{Var}(X)=\mu$, $\sigma=\sqrt\mu$ ➔ the family where the **variance grows with the mean**.

### 2. When It Arises
- **Count of independent occurrences** ➔ calls per hour, visits, radioactive emissions — sample space $\mathbb{Z}^{+}=\{0,1,2,\dots\}$.
- **Interval-scaled** ➔ $\mu$ scales with interval length.
- **Unbounded** ➔ any nonnegative integer (unlike the binomial's cap at $n$).
- **Four appropriateness conditions** *(FIT2086)* ➔ (i) one event's occurrence does **not** affect the probability of a second — events are **independent**; (ii) the **rate is constant** across intervals, never higher in some than others; (iii) **two events cannot occur at the same instant**; (iv) the probability of an event in a small interval is **proportional to that interval's length**. Violating (i) or (ii) is what makes real count data spread wider than $V=\lambda$ allows.

### 3. Binomial Approximation
- **Condition** ➔ large $n$, small $np$ ⟹ $\mathrm{Bin}(n,p)\approx\mathrm{Poisson}(np)$.
- **Benefit** ➔ trades a two-parameter formula for one.

### 4. Additivity and Thinning *(FIT2086)*
- **Sums stay Poisson** ➔ $X_1\sim Poi(\lambda_1)$, $X_2\sim Poi(\lambda_2)$ ⟹ $X_1+X_2\sim Poi(\lambda_1+\lambda_2)$ — **rates add**.
- **Decomposition** ➔ any $X\sim Poi(\lambda)$ splits as $X=\sum_{i=1}^{n}X_i$ with $X_i\sim Poi(\lambda_i)$ and $\sum_i\lambda_i=\lambda$.
- **Interval rescaling (thinning)** ➔ if $X_T\sim Poi(\lambda)$ counts events in a period $T$, then over $T/k$:
$$X_{T/k}\sim Poi(\lambda/k)$$
➔ **the rate is per unit time** ➔ always rescale $\lambda$ to the interval the question asks about *before* evaluating any probability.

**Key identities:**

$$\sum_{k=0}^{\infty}\frac{e^{-\mu}\mu^k}{k!}=e^{-\mu}\sum_{k=0}^{\infty}\frac{\mu^k}{k!}=e^{-\mu}e^{\mu}=1$$

## ⚖️ Core Decision Matrix
| Aspect | Poisson | vs Binomial |
| :--- | :--- | :--- |
| parameter | $\mu$ | $n,p$ |
| $E$, $\mathrm{Var}$ | both $\mu$ | $np$, $np(1-p)$ |
| support | unbounded | $\{0,\dots,n\}$ |
| relation | $\approx\mathrm{Bin}$ large $n$ | $\mu=np$ |
| closure under $+$ | rates add: $Poi(\lambda_1+\lambda_2)$ | trials add (same $\theta$): $Bin(\theta,n_1+n_2)$ |

> [!NOTE] **When It Flips:** Poisson suits "could be any count" of rare independent events; it is the unbounded limit of the binomial. The $e^x$-series normalisation mirrors the geometric-series argument for other pmfs. $V=E$ is the family fingerprint — sample variance far above the sample mean falsifies the constant-rate assumption.

## 📊 Exam Execution Trace

### Applied Exercise 1
**Problem:** Poisson $\mu=2$ — find $\mathrm{Pr}(X=0)$, $\mathrm{Pr}(X=1)$, $E$, $\mathrm{Var}$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\mathrm{Pr}(X=0) &= e^{-2}\approx0.135,\qquad \mathrm{Pr}(X=1) = 2e^{-2}\approx0.271 \\
E(X) &= \mu = 2,\qquad \mathrm{Var}(X) = \mu = 2
\end{aligned}
$$
**Final Extracted Output:** $\approx0.135$, $\approx0.271$; mean and variance both 2.

### Applied Exercise 2 — rescaling the interval *(FIT2086)*
**Problem:** calls arrive at $X_T\sim Poi(12)$ per **hour**. Find $P(\text{no call in a given }15\text{ minutes})$.
$$
\begin{aligned}
k &= 4 \;\;(\text{an hour splits into four }15\text{-minute periods}) \Rightarrow X_{T/4}\sim Poi(12/4)=Poi(3)\\
P(X_{T/4}=0) &= \frac{3^{0}e^{-3}}{0!} = e^{-3} \approx 0.0498
\end{aligned}
$$**Final Extracted Output:** $\approx0.05$. **Key move:** rescale $\lambda$ to the requested interval **first**; using $\lambda=12$ would answer a different question entirely.

### Applied Exercise 3 — hospital heart attacks, week ➔ day *(Studio 2)*
**Problem:** a hospital sees on average $6$ heart-attack patients **per week**, rate independent of the day. Find (i) $P(\le2$ in a week$)$; (ii) $P(\text{exactly }1$ on a given day$)$; (iii) $P(\ge1$ on a given day$)$.
$$
\begin{aligned}
\text{(i)}\quad &P(X\le2\mid\lambda=6)=\texttt{ppois(2, 6)}\approx0.0620\\
\text{(ii)}\quad &X=\textstyle\sum_{i=1}^{7}X_i\sim Poi\!\left(\sum_{i=1}^{7}\lambda_i\right)\text{ with all }\lambda_i\text{ equal}\;\Rightarrow\;\lambda_i=\tfrac67\\
&P(X_i=1\mid\lambda=\tfrac67)=\frac{(6/7)^{1}e^{-6/7}}{1!}\approx0.3637\qquad\texttt{dpois(1, 6/7)}\\
\text{(iii)}\quad &P(X_i\ge1)=1-P(X_i=0)=1-\frac{(6/7)^{0}e^{-6/7}}{0!}=1-e^{-6/7}\approx0.5756
\end{aligned}
$$**Final Extracted Output:** $0.0620$; $0.3637$; $0.5756$. **Key move:** the identical-days assumption is what forces $\lambda_1=\cdots=\lambda_7$, so additivity **run backwards** gives $\lambda_i=\lambda/7$. And "**at least one**" always collapses to $1-e^{-\lambda}$ because $P(X=0)=e^{-\lambda}$ — no summation needed.

## ⚙️ In R
> [!code]- The `pois` suffix (details ➔ [[R Simulation and Random Sampling]])
> ```r
> dpois(0, lambda = 3)                  # P(X = 0)  = 0.0498
> ppois(2, lambda = 3)                  # P(X <= 2) = 0.4232
> ppois(2, lambda = 3, lower.tail = FALSE)  # P(X >= 3)
> qpois(0.95, lambda = 3)               # quantile
> rpois(10, lambda = 3)                 # 10 random counts
>
> # Studio 2 — the pmf by hand vs the built-in (identical results)
> 4^1 * exp(-4) / factorial(1)          # 0.07326  =  dpois(1, 4)
> 4^0*exp(-4)/factorial(0) + 4^1*exp(-4)/factorial(1)   # P(X < 2) = 0.09158
> dpois(0, 4) + dpois(1, 4)             # same, and equals ppois(1, 4)
> 1 - ppois(5, 4)                       # P(X > 5) = 0.2149
> ```
> 💡 **Common Mistake:** `lambda` must already match the interval in the question ➔ do the $\lambda/k$ thinning by hand before the call. Also `exp()` and `factorial()` reproduce the pmf exactly — useful for checking that you translated $P(X<2)$ into $P(X\le1)$ and not $P(X\le2)$.

## ⚠️ Common Mistakes
- 💡 **$\mu$ is mean AND variance** ➔ the single parameter does double duty; the binomial→Poisson swap needs large $n$ with small $np$.
- 💡 **Forgetting to rescale the rate** ➔ $\lambda$ is defined *per interval*; a question about a half/quarter period needs $Poi(\lambda/k)$.
- 💡 **Applying Poisson to clustered events** ➔ if one event makes another more likely (contagion, queues, bursts) the independence and constant-rate conditions fail, and the $V=\lambda$ prediction breaks.
- 💡 **Strict vs weak inequality on a discrete support** ➔ $P(X<2)=P(X\le1)=$ `ppois(1, λ)`, **not** `ppois(2, λ)`; unlike the continuous case the boundary value carries real mass.
- 💡 **Poisson for a binary or continuous variable** ➔ "land vs water" is binary (binomial) and "average weight" is continuous (normal); Poisson needs an unbounded **count**. Selection drill ➔ [[Parametric Probability Distributions]].

## 🧠 Active Recall
> [!FAQ]- State the Poisson pmf, show it sums to 1, and give mean and variance.
> - **Hint:** $e^x$ series.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\mathrm{Pr}(X=k)=e^{-\mu}\mu^k/k!$; $\sum=e^{-\mu}e^{\mu}=1$; $E=\mathrm{Var}=\mu$.
> > - **Why:** **Power series** ➔ $\sum_k\mu^k/k!=e^{\mu}$.

> [!FAQ]- When does the Poisson distribution arise, and how does it relate to the binomial?
> - **Hint:** Rare independent counts.
> > [!SUCCESS]- Answer
> > - **Short answer:** Counts of independent occurrences in a fixed interval; $\mathrm{Bin}(n,p)\approx\mathrm{Poisson}(np)$ for large $n$, small $np$.
> > - **Why:** **Unbounded limit** ➔ one parameter replaces two.

> [!FAQ]- Which four conditions must hold for a Poisson model, and what happens to the rate if the interval is shortened by a factor $k$?
> - **Hint:** Independence, constancy, no ties, proportionality.
> > [!SUCCESS]- Answer
> > - **Short answer:** events **independent**; **constant rate** across intervals; **no two events at the same instant**; probability in a small interval **proportional to its length**. Shortening the interval to $T/k$ gives $X_{T/k}\sim Poi(\lambda/k)$.
> > - **Why:** **The rate is per unit time** ➔ proportionality (condition iv) plus additivity means the $k$ sub-intervals of $T$ each carry rate $\lambda/k$ and sum back to $Poi(\lambda)$; breaking independence or constancy leaves the data spread wider than $V=\lambda$ permits, falsifying the model.
