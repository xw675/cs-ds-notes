---
unit: FIT2086
week: 10
source: [lecture]
domain: [D, E]
parent: "[[Hypothesis Testing]]"
tags: [Math/Probability, DataScience/Modelling, Tool/R]
aliases: [permutation test, permutation p-value, randomisation test, test of association by resampling, exchangeability, null distribution by permutation]
---
# [[Permutation Tests]]

**Context:** [[FIT2086_MOC]] · W10 · a [[Hypothesis Testing|hypothesis test]] whose null distribution is **simulated** rather than derived · the $p$-value sibling of the [[Bootstrap]] (contrast table there) · the slope test it replaces ➔ [[Model Selection and Information Criteria (AIC, BIC)|$t_j$ for $H_0:\beta_j=0$]] · same idea powers random-forest `%IncMSE` ➔ [[Trees, Forests and kNN in R (rpart, randomForest, kknn)]]
**Parent Framework:** [[Hypothesis Testing]]

> [!abstract] Quick Revision
> - **🎯 Objective:** shuffle $y$ against fixed $x$, $m$ times ➔ refit ➔ the $\hat\beta^{(i)}$ form an empirical **null distribution of no association** ➔ $p\approx\dfrac{1+\sum_{i=1}^{m}I\big(\lvert\hat\beta^{(i)}\rvert\ge\lvert\hat\beta\rvert\big)}{m+1}$.
> - **📦 Core Components:** $H_0:\beta=0$ vs $H_A:\beta\ne0$ | permutation keeps $p(Y)$, breaks the pairing | $+1$ correction ➔ smallest $p=1/(m+1)$.
> - **⚡ Key Constraint:** permute the **targets only**, **without** replacement — that is a shuffle; drawing with replacement is the bootstrap and does not simulate $H_0$.

## 📝 How It Works
### 1. The Usual Test and Its Weak Point
- **Question** ➔ $n$ pairs $(x_i,y_i)$: is $y$ associated with $x$? In a linear model ⟹ test the slope, $H_0:\beta=0$ vs $H_A:\beta\ne0$.
- **Usual procedure** ➔ specify a population distribution ➔ compute a statistic (the least-squares $\hat\beta$) ➔ see how likely it is under the derived null distribution.
- **Weak point** ➔ the $p$-value depends crucially on the **assumed distribution** and on deriving the null **accurately** (often via the CLT).

### 2. The Algorithm
1. **For $i=1$ to $m$** ➔ randomly permute the targets ➔ compute the association statistic $\hat\theta^{(i)}$.
2. **Observed** ➔ compute the statistic on the real data.
3. **Compare** ➔ how often the permutation distribution is at least as extreme ⟹ the $p$-value of association.
- **Key idea** ➔ under no association the $y$ values are **exchangeable** with respect to the predictors ⟹ permutations show how the estimate varies under the null.
- **Two-sided** ➔ compare **absolute** values $\lvert\hat\beta^{(i)}\rvert\ge\lvert\hat\beta\rvert$, matching $H_A:\beta\ne0$.
- **$+1$ correction** ➔ the finite-simulation estimate counts the observed data as one of the arrangements ⟹ $p$ is never exactly $0$; resolution $1/(m+1)$.

### 3. Strengths and Weaknesses
- **Strengths** ➔ few assumptions about the population distribution · potentially more accurate $p$-values for **non-normal** models (logistic regression, etc.) · easy to code and apply.
- **Weaknesses** ➔ resolution set by $m$ (smallest $p=1/(m+1)$) · slow if each model fit is slow · assumes **independent** individuals.

## 🧮 Proof Blueprint
- **Theorem** ➔ randomly permuting the observed $y$ values against fixed $x$ produces datasets distributed as under $H_0$: no association.
- **Strategy** ➔ factorise the joint, impose $H_0$, then check which marginals a permutation preserves.
- **Derivation Steps:**
$$
\begin{aligned}
p(Y,X) &= p(Y\mid X)\,p(X) \quad\text{(always)} \\
H_0:\ p(Y\mid X) &= p(Y) \quad\Rightarrow\quad p(Y,X) = p(Y)\,p(X) \\
\text{permutation: } & \{y_i\}\text{ unchanged as a set}\Rightarrow p(Y)\text{ kept};\ x\text{ untouched}\Rightarrow p(X)\text{ kept};\ \text{pairing random}
\end{aligned}
$$
- **Q.E.D.** ➔ a permuted dataset is a draw from $p(Y)p(X)$ — exactly the joint under $H_0$ — so its statistics trace the null distribution with no normality assumption.

## ⚙️ Core Implementation
### 🔹 Permutation test for a regression slope
> [!code]- Code / Layout Details
> ```r
> # implements the lecture's algorithm (the slides give the procedure, not this code)
> bpfit = lm(BP ~ Age, data = bpdata); summary(bpfit)   # beta.hat = 1.4310, t-test p = 0.00157
> beta.hat = coef(bpfit)[2]
> m = 10000; beta.perm = rep(0, m)
> for (i in 1:m) {
>   y.perm = sample(bpdata$BP)                          # shuffle targets: NO replacement
>   beta.perm[i] = coef(lm(y.perm ~ bpdata$Age))[2]
> }
> p = (1 + sum(abs(beta.perm) >= abs(beta.hat))) / (m + 1)   # ≈ 0.0013
> hist(beta.perm, probability = TRUE)                   # the empirical null, centred on 0
> ```
> 💡 **Common Mistake:** **`sample(bpdata$BP, replace = TRUE)`** ➔ that is a bootstrap draw — values duplicate and vanish, so $p(Y)$ is not preserved and the null is wrong.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
BP on Age, $n=20$ (Lecture 6 data); observed $\hat\beta=1.4310$, $t$-test $p=0.00157$:

| Step | Data | $\hat\beta^{(i)}$ | $\lvert\hat\beta^{(i)}\rvert\ge1.4310$? | Running $p=\frac{1+\text{count}}{i+1}$ |
| :--- | :--- | :--- | :--- | :--- |
| $0$ | unpermuted | $1.4310$ | — | — |
| $1$ | permutation 1 | $-0.8418$ | no | $1/2$ |
| $2$ | permutation 2 | $-0.0253$ | no | $1/3$ |
| $3$ | permutation 3 | $0.3704$ | no | $1/4$ |
| $\vdots$ | $m=10{,}000$ | centred on $0$, almost all within $\pm1.43$ | rare | $\approx0.0013$ |

- **Reading** ➔ after 3 permutations $p$ cannot go below $1/4$ — resolution, not evidence; at $m=10{,}000$ the permutation $p\approx0.0013$ agrees closely with the normal-theory $t$-test's $0.00157$ ⟹ strong evidence BP is associated with Age.

### Applied Exercise
**Problem:** $m=999$ permutations of a logistic-regression coefficient; $4$ have $\lvert\hat\beta^{(i)}\rvert\ge\lvert\hat\beta\rvert$. Find $p$. What if none did?
$$
\begin{aligned}
p &= \frac{1+4}{999+1} = \frac{5}{1000} = 0.005 \\
p_{\min} &= \frac{1+0}{1000} = 0.001
\end{aligned}
$$
**Final Extracted Output:** $p=0.005$ ⟹ strong evidence against $H_0$; with no exceedances report $p\le0.001$ and raise $m$ if a smaller $p$ must be resolved.

## ⚠️ Common Mistakes
- 💡 **Shuffling $x$ and $y$ together** ➔ moving whole rows changes nothing; only **one** side is permuted to break the pairing.
- 💡 **One-sided count for a two-sided test** ➔ $H_A:\beta\ne0$ needs absolute values on **both** sides of the comparison.
- 💡 **Reporting $p=0$** ➔ with the $+1$ correction the floor is $1/(m+1)$.
- 💡 **Ignoring dependence** ➔ exchangeability needs independent individuals; clustered or time-ordered data break it.

## 🧠 Active Recall
> [!FAQ]- Why does randomly permuting the targets generate data under $H_0$ of no association?
> > [!SUCCESS]- Answer
> > - **Short answer:** under $H_0$ the joint factorises as $p(Y)p(X)$; a permutation keeps the observed $y$ values (so $p(Y)$) and the $x$ values (so $p(X)$) but pairs them at random — a draw from that product.
> > - **Why:** **Exchangeability** ➔ $p(Y\mid X)=p(Y)$ means the labels carry no information about $x$, so every reassignment is equally likely under $H_0$.

> [!FAQ]- The permutation test gives $p\approx0.0013$ and the $t$-test $0.00157$ for the same slope. Where does the difference come from, and when would it matter?
> > [!SUCCESS]- Answer
> > - **Short answer:** the $t$-test's null assumes normally distributed regression errors; the permutation null is built from the data with no such assumption (plus simulation noise from finite $m$). It matters for non-normal models, where the derived null may be inaccurate.
> > - **Why:** **Assumed vs simulated null** ➔ both answer $H_0:\beta=0$; only the route to the null distribution differs.

> [!FAQ]- Bootstrap or permutation test — which would you use to (a) give a CI for a slope, (b) give a $p$-value for "Age is unrelated to BP"?
> > [!SUCCESS]- Answer
> > - **Short answer:** (a) bootstrap — rows with replacement, percentile CI; (b) permutation — shuffle BP against Age, count extremes.
> > - **Why:** **Variability vs null** ➔ the bootstrap mimics repeated sampling from the real population; the permutation mimics sampling from a population where $H_0$ holds.
