---
unit: FIT2086
week: 7
source: [lecture]
domain: [E, D]
parent: "[[Classification and Conditional Class Probabilities]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Logistic Function, Log-Odds, Logit, Odds, Sigmoid, Linear Predictor, Bernoulli Regression, Logistic Model]
---
# [[Logistic Regression]]

**Context:** [[FIT2086_MOC]] · the **binary-target** counterpart of [[Linear Regression (FIT2086)]] — same linear predictor $\eta_i$, squashed into $(0,1)$ · it is the discriminative answer to the curse of dimensionality in [[Classification and Conditional Class Probabilities]] · fitted by [[Maximum Likelihood Estimation|ML]] on a [[Binomial Distribution|Bernoulli]] target · pruned by [[Model Selection and Information Criteria (AIC, BIC)|penalised likelihood]] · scored by [[Classification Evaluation (Confusion Matrix and Metrics)]], [[ROC and AUC]], [[Logarithmic Loss]]

> [!abstract] Quick Revision
> - **🎯 Objective:** model the **log-odds** of $Y=1$ as a linear function of the predictors ➔ $\log\frac{\mathbb{P}(Y_i=1\mid\mathbf{x}_i)}{\mathbb{P}(Y_i=0\mid\mathbf{x}_i)}=\beta_0+\sum_j\beta_jx_{i,j}\equiv\eta_i$ ➔ invert with the logistic function to get a probability.
> - **📦 Core Components:** linear predictor $\eta_i\in(-\infty,\infty)$ ➔ odds $e^{\eta_i}\in(0,\infty)$ ➔ probability $\frac{1}{1+e^{-\eta_i}}\in(0,1)$.
> - **⚡ Key Constraint:** the negative log-likelihood has **no closed-form solution** ➔ the estimates must be found **numerically**; it is convex, so there are no spurious local minima.

## 📝 How It Works
### 1. Why the Linear Model Fails on a Binary Target
- **The naive attempt** ➔ fit $\mathbb{E}[Y_i]=\eta_i=\beta_0+\sum_{j=1}^{p}\beta_jx_{i,j}$ by least squares and read $\mathbb{P}(Y_i=1\mid\mathbf{x}_i)\approx\eta_i$.
- **The fatal flaw** ➔ $\eta_i$ is **unbounded** ➔ for extreme feature values it returns $\hat p<0$ or $\hat p>1$, which are not probabilities.
- **The fix** ➔ keep the linear predictor, but pass it through a function that **bounds** it to $(0,1)$. Many such functions exist; logistic regression picks one.

### 2. The Logistic Function
- **Definition** ➔ $\mathbb{P}(Y_i=1\mid x_{i,1},\dots,x_{i,p})=\dfrac{1}{1+\exp(-\eta_i)}$.
- **Limits** ➔ smoothly $\to0$ as $\eta_i\to-\infty$ and $\to1$ as $\eta_i\to+\infty$; it passes through $\tfrac12$ at $\eta_i=0$.
- **Shape** ➔ an S-curve (sigmoid) — steepest near $\eta_i=0$, flat in both tails ⟹ the same unit change in a predictor moves the probability **most** for individuals near the decision boundary.

### 3. Odds and Log-Odds
- **Odds** ➔ $\dfrac{\mathbb{P}(Y=1)}{\mathbb{P}(Y=0)}=\dfrac{\mathbb{P}(Y=1)}{1-\mathbb{P}(Y=1)}$ — how many **times more likely** $Y=1$ is than $Y=0$.
- **Worked reading** ➔ a coin with $\mathbb{P}(\text{head})=0.75$ has odds $0.75/0.25=3$ for a head and $0.25/0.75=1/3$ for a tail — the two are **reciprocals**, not symmetric around a centre.
- **Log-odds restore symmetry** ➔ $\log 3$ and $-\log 3$ ➔ the log scale maps $(0,\infty)$ onto $(-\infty,\infty)$, which is exactly the range a linear predictor lives in.
- **Odds vs probability** ➔ odds $>1\iff\mathbb{P}(Y=1)>\tfrac12$; odds $=1\iff$ equally likely; odds $<1\iff Y=0$ more likely.

### 4. The Model and Its Derivation
- **The model** ➔ the conditional log-odds **are** the linear predictor:
$$
\log\left(\frac{\mathbb{P}(Y_i=1\mid x_{i,1},\dots,x_{i,p})}{\mathbb{P}(Y_i=0\mid x_{i,1},\dots,x_{i,p})}\right)=\beta_0+\sum_{j=1}^{p}\beta_jx_{i,j}\equiv\eta_i
$$
- **Recovering the logistic function** ➔ exponentiate, then solve for the probability:
$$
\begin{aligned}
\log\left(\frac{\mathbb{P}(Y_i=1\mid\mathbf{x}_i)}{1-\mathbb{P}(Y_i=1\mid\mathbf{x}_i)}\right) &= \eta_i \\
\frac{\mathbb{P}(Y_i=1\mid\mathbf{x}_i)}{1-\mathbb{P}(Y_i=1\mid\mathbf{x}_i)} &= \exp(\eta_i) \\
\mathbb{P}(Y_i=1\mid\mathbf{x}_i) &= \frac{\exp(\eta_i)}{1+\exp(\eta_i)}=\frac{1}{1+\exp(-\eta_i)}
\end{aligned}
$$
- **Why the two forms are the same** ➔ divide numerator and denominator by $\exp(\eta_i)$ and use $1/e^{a}=e^{-a}$ ⟹ "linear log-odds" and "logistic function" are one assumption stated two ways.

### 5. Fitting by Maximum Likelihood
- **Distributional assumption** ➔ targets are independent and $Y_i\sim \text{Be}(\theta_i(\beta_0,\boldsymbol\beta))$ with $\theta_i=\dfrac{1}{1+\exp(-\eta_i)}$ ⟹ $\mathbb{P}(Y_i=1)=\theta_i$, $\mathbb{P}(Y_i=0)=1-\theta_i$.
- **Likelihood** ➔ the Bernoulli pmf, multiplied over the sample:
$$
p(\mathbf{y}\mid\beta_0,\boldsymbol\beta)=\prod_{i=1}^{n}\theta_i^{\,y_i}(1-\theta_i)^{1-y_i}
$$
- **Negative log-likelihood** ➔ take $-\log$, then substitute the logistic form to reach the compact version in $\eta_i$:
$$
\begin{aligned}
L(\mathbf{y}\mid\beta_0,\boldsymbol\beta) &= -\sum_{i=1}^{n}\big[y_i\log\theta_i+(1-y_i)\log(1-\theta_i)\big] \\
&= \sum_{i=1}^{n}\big[-y_i\eta_i+\log(1+e^{\eta_i})\big]
\end{aligned}
$$
- **The estimates** ➔ $\hat\beta_0,\hat{\boldsymbol\beta}$ are the minimisers of $L$ ➔ the ML estimates, exactly as in [[Maximum Likelihood Estimation]].
- **No closed form** ➔ unlike least squares there is no formula ⟹ solved **numerically** (gradient descent / Newton-type optimisers).
- **Convexity is the safety net** ➔ $L$ is convex in the coefficients, so a numerical search cannot get stuck in a spurious local minimum, assuming a finite ML estimate exists.
- **Cost** ➔ grows with both $n$ and $p$, but is $O(np^2)$ per iteration rather than exponential ➔ this is the escape from the curse of dimensionality.

### 6. Interpreting the Coefficients
- **Intercept $\beta_0$** ➔ the **log-odds** of $Y=1$ when every predictor is zero ($x_{i,1}=\dots=x_{i,p}=0$) — usually an extrapolation with no real-world individual behind it.
- **Coefficient $\beta_j$** ➔ the increase in **log-odds** per one-unit increase in $x_j$, holding the others fixed ⟹ a **multiplicative** factor $e^{\beta_j}$ on the odds, **not** an additive change in probability.
- **Sign reading** ➔ $\eta_i>0\Rightarrow e^{\eta_i}>1\Rightarrow Y=1$ more likely; $\eta_i<0\Rightarrow e^{\eta_i}<1\Rightarrow Y=0$ more likely.
- **Goodness-of-fit** ➔ the minimised $L(\mathbf{y}\mid\hat\beta_0,\hat{\boldsymbol\beta})$ — **smaller is better**; compare it against the **intercept-only** model $L(\mathbf{y}\mid\hat\beta_0)$, whose difference plays the role $\text{RSS}\to\text{TSS}$ plays for $R^2$. The intercept-only model assumes $\mathbb{P}(Y=1)$ is the same for everybody.

### 7. Predicting, Deciding and Pruning
- **Predict** ➔ compute $\hat\eta=\hat\beta_0+\sum_{j=1}^{p}\hat\beta_jx'_j$ for new features, then $\mathbb{P}(Y'=1\mid\mathbf{x}')=\dfrac{1}{1+\exp(-\hat\eta)}$.
- **Decision rule** ➔ pick the class maximising that probability ⟹ equivalently predict $1$ iff $\mathbb{P}(Y=1\mid\mathbf{x}')>\tfrac12$, iff the odds exceed $1$, iff $\hat\eta>0$ — three views of one rule ➔ generalised to any threshold in [[ROC and AUC]].
- **Categorical and non-linear predictors** ➔ handled exactly as in linear regression — $K-1$ indicator columns for a $K$-category predictor when an intercept is present, plus $\log$ and polynomial terms ➔ [[Predictor Transformations (Indicators, Polynomials, Interactions)]].
- **Which predictors** ➔ test $H_0:\beta_j=0$ vs $H_A:\beta_j\neq0$ (smaller $p$-value ⟹ stronger predictor), or score models by penalised likelihood $L(\mathbf{y}\mid\hat\beta_0,\hat{\boldsymbol\beta})+k\alpha_n$ with $\alpha_n=1$ (AIC), $\alpha_n=\tfrac32$ (KIC), $\alpha_n=\tfrac12\log n$ (BIC), then search by forward/backward selection ➔ [[Model Selection and Information Criteria (AIC, BIC)]].
- **The boundary is linear** ➔ the set where $\mathbb{P}(Y=1\mid x_1,x_2)=\tfrac12$ is exactly $\eta=0$, a **line** in two features and a **$p$-dimensional hyperplane** in general ⟹ classes that are not linearly separable in the feature space cannot be separated by logistic regression without transformed predictors.

## 🔬 Model
- **Declared spaces** ➔ $\mathbf{y}\in\{0,1\}^{n}$, design matrix $X\in\mathbb{R}^{n\times p}$ (plus an intercept column), $\boldsymbol\beta\in\mathbb{R}^{p}$, $\beta_0\in\mathbb{R}$, $\theta_i\in(0,1)$.
- **Link** ➔ $\eta_i=\beta_0+\sum_{j=1}^{p}\beta_jx_{i,j}$, $\theta_i=\dfrac{1}{1+\exp(-\eta_i)}$, $Y_i\mid\mathbf{x}_i\sim\text{Be}(\theta_i)$ independently.
- **Objective (minimise)** ➔
$$
(\hat\beta_0,\hat{\boldsymbol\beta})=\arg\min_{\beta_0,\boldsymbol\beta}\sum_{i=1}^{n}\big[-y_i\eta_i+\log(1+e^{\eta_i})\big]
$$
- **Contrast with [[Linear Regression (FIT2086)]]** ➔ same $\eta_i$; the Gaussian mean model becomes a Bernoulli success probability, and the closed-form least-squares solution becomes a numerical convex optimisation ➔ the ML framing of [[Least Squares as Maximum Likelihood]] is what makes the swap legal.

## ⚖️ Core Decision Matrix
| Model for a binary target | What is linear in $\mathbf{x}$ | Fitted by | Output range | Where it breaks |
| :--- | :--- | :--- | :--- | :--- |
| **Linear probability model** | the probability itself | least squares, closed form | $(-\infty,\infty)$ ➔ **invalid** | returns $\hat p<0$ or $\hat p>1$ at extreme $\mathbf{x}$ |
| **Logistic regression** | the **log-odds** | numerical ML, convex | $(0,1)$ ➔ always valid | decision boundary forced **linear**; multi-class awkward |

> [!NOTE] **When It Flips:** over a narrow band of $\mathbf{x}$ where all fitted probabilities sit near $0.5$, the logistic curve is close to straight and the two models agree ➔ the linear probability model only fails once the data reach into the tails, which real feature ranges almost always do.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise 1 — from log-odds to odds to probability
**Problem:** a fitted model gives $\text{LogOdds}(Y)=0.5+3x$. At $x=0.2$, report the odds and the probability that $Y=1$.
$$
\begin{aligned}
\eta &= 0.5+3(0.2)=1.1 \\
\text{odds}(Y=1) &= e^{1.1}\approx3.00 \\
\mathbb{P}(Y=1) &= \frac{1}{1+e^{-1.1}}=\frac{1}{1+0.3329}\approx0.75
\end{aligned}
$$
**Final Extracted Output:** $Y=1$ is about **three times** as likely as $Y=0$; probability $\approx0.75$ ⟹ predict class $1$ (odds $>1$).

### Applied Exercise 2 — fit interpretation and prediction
**Problem:** high blood pressure is defined as $\text{HighBP}_i=I(\text{BP}_i>120)$; ML fitting on Age gives $\text{logOdds}(\text{HighBP}_i)=-33.68+0.656\,\text{Age}_i$. Interpret both coefficients and predict for a $50$-year-old.
$$
\begin{aligned}
\eta &= -33.68+0.656(50)=-33.68+32.80=-0.88 \\
\text{odds} &= e^{-0.88}\approx0.41 \\
\mathbb{P}(\text{HighBP}=1\mid\text{Age}=50) &= \frac{0.41}{1+0.41}\approx0.29
\end{aligned}
$$
**Final Extracted Output:** at $\text{Age}=0$ the log-odds are $-33.68$ (a meaningless extrapolation); **each extra year adds $0.656$ to the log-odds**, i.e. multiplies the odds by $e^{0.656}\approx1.93$. A $50$-year-old has $\approx29\%$ probability ⟹ predict $\text{HighBP}=0$. The model crosses $\tfrac12$ at $\text{Age}=33.68/0.656\approx51.3$ years.

## ⚠️ Common Mistakes
- 💡 **Reading $\beta_j$ as a change in probability** ➔ it is a change in **log-odds**; the same $\beta_j$ moves the probability a lot near $\eta=0$ and almost nothing in the tails, so no single "percentage point" answer exists.
- 💡 **Exponentiating the wrong thing** ➔ $e^{\eta}$ is the **odds**, not the probability; the probability needs the extra step $\frac{\text{odds}}{1+\text{odds}}$ or $\frac{1}{1+e^{-\eta}}$.
- 💡 **Comparing likelihood numbers across packages** ➔ some report maximised log-likelihood, some the negative, some **twice** either ➔ a "bigger is better" habit inverts the verdict.
- 💡 **Forgetting the boundary is linear** ➔ a poor fit on visibly curved class structure is a **model-form** failure, not an optimisation failure ➔ transform the predictors.

## 🧠 Active Recall
> [!FAQ]- Why model the log-odds rather than the probability directly?
> - **Hint:** Compare the range of each side of the equation.
> > [!SUCCESS]- Answer
> > - **Short answer:** The linear predictor $\eta_i$ ranges over all of $\mathbb{R}$, and so do the log-odds — but a probability only ranges over $(0,1)$, so equating $\eta_i$ to a probability produces impossible values.
> > - **Why:** **Range matching** ➔ probability $(0,1)\xrightarrow{\text{odds}}(0,\infty)\xrightarrow{\log}(-\infty,\infty)$ ➔ the log-odds is the natural scale for an unbounded linear function, and the logistic function is just this chain run backwards.

> [!FAQ]- Least squares has a formula; logistic regression does not. Why is that not a practical disaster?
> - **Hint:** What shape is the objective surface?
> > [!SUCCESS]- Answer
> > - **Short answer:** The negative log-likelihood is **convex**, so any descent method reaches the *global* minimum — there are no spurious local minima to trap it.
> > - **Why:** **Convex objective** ➔ $L=\sum_i[-y_i\eta_i+\log(1+e^{\eta_i})]$ has a single basin ⟹ the estimate is well defined even without a formula, provided a finite ML estimate exists (it fails on perfectly separable data, where coefficients run to infinity).

> [!FAQ]- A model gives $\hat\eta=0$ for an individual. State the odds, the probability, and the predicted class.
> > [!SUCCESS]- Answer
> > - **Short answer:** Odds $=e^{0}=1$, probability $=\tfrac{1}{1+e^{0}}=\tfrac12$, and the classes are **exactly tied** — the individual sits on the decision boundary.
> > - **Why:** **The three equivalent rules** ➔ $\hat\eta>0\iff\text{odds}>1\iff\hat p>\tfrac12$; at $\hat\eta=0$ all three are at their pivot, which is precisely the hyperplane $\mathbb{P}(Y=1\mid\mathbf{x})=\tfrac12$.

> [!FAQ]- How is "which predictors belong in the model" answered here, given there is no $R^2$?
> > [!SUCCESS]- Answer
> > - **Short answer:** Identically to linear regression, because logistic regression is fitted by ML and therefore **has a likelihood** — test $H_0:\beta_j=0$, or score models by $L+k\alpha_n$ and search by stepwise selection.
> > - **Why:** **Penalised likelihood transfers** ➔ the minimised NLL always falls as predictors are added (exactly as $R^2$ always rises), so a complexity charge $\alpha_n\in\{1,\tfrac32,\tfrac12\log n\}$ for AIC/KIC/BIC is what makes two models comparable ➔ [[Model Selection and Information Criteria (AIC, BIC)]].
