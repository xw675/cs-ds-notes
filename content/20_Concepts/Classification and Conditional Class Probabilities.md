---
unit: FIT2086
week: 7
source: [lecture]
domain: [E, D]
parent: "[[Statistical Modelling and Inference]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Classification, Conditional Class Probability, Curse of Dimensionality, Generative Model, Discriminative Model, Naive Bayes, Probabilistic Classifier, Features]
---
# [[Classification and Conditional Class Probabilities]]

**Context:** [[FIT2086_MOC]] · the **categorical-target** half of supervised learning — the branch [[Linear Regression (FIT2086)]] left open · the W6 machinery ([[Maximum Likelihood Estimation|ML fitting]], [[Model Selection and Information Criteria (AIC, BIC)|penalised likelihood]]) now aimed at the [[Binomial Distribution|Bernoulli]] instead of the [[Gaussian Distribution|Gaussian]] · the practical answer ➔ [[Logistic Regression]] · scoring the result ➔ [[Classification Evaluation (Confusion Matrix and Metrics)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** define a classifier as the **conditional class probability** $\mathbb{P}(Y=y\mid X_1=x_1,\dots,X_p=x_p)$ ➔ estimate it ➔ predict the class that maximises it.
> - **📦 Core Components:** direct joint estimation ➔ exact but $2^{p+1}$ cells | naive Bayes ➔ simplifying assumption | [[Logistic Regression]] ➔ models the conditional **directly**.
> - **⚡ Key Constraint:** the **curse of dimensionality** — estimating the joint table needs $2^{p+1}$ probabilities for $p$ binary predictors, which outruns any $n$ ⟹ the direct approach is unusable past a handful of predictors.

## 📝 How It Works
### 1. A Classifier Is a Conditional Probability
- **Target** ➔ $Y$ is **categorical** (a *class*); predictors $X_1,\dots,X_p$ are called **features** in the classification literature.
- **What we want** ➔ $\mathbb{P}(Y=y\mid X_1=x_1,\dots,X_p=x_p)$ — the probability an individual is in class $y$ **given** their feature values.
- **Probabilistic vs hard classifier** ➔ a probabilistic classifier returns the whole distribution over classes; a hard classifier collapses it to one label by $\hat y=\arg\max_y \mathbb{P}(Y=y\mid \mathbf{x})$.
- **Why probabilities and not labels** ➔ they carry **confidence**: $0.501$ and $0.99$ give the same label but are not the same claim ➔ [[Logarithmic Loss]].

### 2. The Direct Approach — Joint Then Conditional
- **All-categorical case** ➔ the conditional is a ratio of a **joint** to a **marginal**:
$$
\mathbb{P}(Y=y\mid X_1=x_1,\dots,X_p=x_p)=\frac{\mathbb{P}(Y=y,X_1=x_1,\dots,X_p=x_p)}{\mathbb{P}(X_1=x_1,\dots,X_p=x_p)}
$$
- **Reading it** ➔ numerator is the **joint** probability of class-and-features; denominator is the **marginal** probability of the features alone ➔ the product/sum rules of [[Random Variables and Probability Distributions (FIT2086)]], nothing new.
- **Consequence** ➔ **the joint distribution is a complete classifier** — once you hold it, every conditional falls out by division.

### 3. Estimating the Joint from Data
- **We are never given the joint** ➔ the population table is unknown; only $n$ realisations are observed.
- **Proportion estimator** ➔ count the pair and divide by $n$:
$$
F(H=h,M=m)=\frac1n\sum_{i=1}^{n}I(h_i=h \text{ and } m_i=m)
$$
- **Why it works** ➔ the **WLLN** ([[Expectations and Covariance (FIT2086)]]) guarantees these proportions converge on the population probabilities for large enough $n$.
- **Conditional from estimates** ➔ $\hat{\mathbb{P}}(H=h\mid M=m)=\dfrac{F(H=h,M=m)}{F(H=0,M=m)+F(H=1,M=m)}$ — divide the cell by its **column** total.

### 4. Why the Direct Approach Collapses
- **The count** ➔ binary $H$ and binary $M$ ⟹ $2\times2=4$ joint probabilities; two mutations ⟹ $2\times2\times2=8$; $p$ binary predictors ⟹ $2^{p+1}$ cells.
- **Exponential growth in $p$** ➔ each cell needs its own sample of observations to estimate, so the demand on $n$ **doubles per predictor** ➔ this is the **curse of dimensionality**.
- **Practical verdict** ➔ the requirement outruns the sample size no matter how big $n$ is ⟹ the problem must be **constrained**, not estimated cell by cell.

### 5. The Two Escape Routes
- **Naive Bayes** ➔ impose a simplifying assumption on the joint (features independent given the class) ➔ handles categorical predictors and **multi-class** targets easily; popular in text mining. *(Named in the lecture, not examined — self-study.)*
- **[[Logistic Regression]]** ➔ skip the joint entirely and model the **conditional directly** as an adaptation of the linear model ➔ handles categorical **and** continuous predictors; awkward for multi-class.
- **The unit's choice** ➔ logistic regression, because it inherits the whole [[Linear Regression (FIT2086)|linear-model]] toolkit.

### 6. Generative vs Discriminative
- **Generative model** ➔ any model of the **complete joint** $p(Y,X_1,\dots,X_p)$ ➔ conditioning on $Y$ gives $p(X_1,\dots,X_p\mid Y)=\dfrac{p(Y,X_1,\dots,X_p)}{p(Y)}$, so it can **generate synthetic individuals** of a chosen class.
- **Dividing by $p(Y)$** ➔ removes the class's own prevalence, leaving what the features look like **within** that class.
- **Why they are topical** ➔ modern generative models exploit structural regularities in the data type to beat the exponential-growth problem rather than estimating raw cells.
- **Discriminative model** ➔ models only $p(Y\mid X_1,\dots,X_p)$ ➔ cheaper, cannot generate data, and is what [[Logistic Regression]] does.

## 🔬 Model
- **Declared spaces** ➔ $Y\in\{0,1,\dots,K-1\}$ (binary $\{0,1\}$ throughout this unit), features $\mathbf{x}_i\in\mathbb{R}^{p}$ or a finite categorical product space.
- **Estimation target** ➔ the conditional $\mathbb{P}(Y=y\mid \mathbf{x})$, **not** the mean — this is the only structural change from [[Linear Regression (FIT2086)]].
- **Decision rule** ➔ $\hat y=\arg\max_{y}\ \mathbb{P}(Y=y\mid \mathbf{x})$; for binary $Y$ this is "predict $1$ iff $\mathbb{P}(Y=1\mid\mathbf{x})\ge\tfrac12$" ➔ generalised by a threshold in [[ROC and AUC]].
- **Parameter count of the direct approach** ➔ $2^{p+1}$ free probabilities for $p$ binary features ⟹ non-viable; every practical method replaces this with $O(p)$ parameters.

## ⚖️ Core Decision Matrix
| Approach | What it estimates | Parameter cost | Predictor types | Where it breaks |
| :--- | :--- | :--- | :--- | :--- |
| **Direct joint table** | full joint $p(Y,\mathbf{X})$ | $2^{p+1}$ cells | categorical only | curse of dimensionality past $p\approx3$ |
| **Naive Bayes** | joint, under an independence assumption | $O(p)$ | categorical, multi-class easy | the independence assumption is usually false |
| **[[Logistic Regression]]** | conditional $p(Y\mid\mathbf{X})$ directly | $p+1$ coefficients | categorical **and** continuous | multi-class is awkward; boundary is linear |

> [!NOTE] **When It Flips:** with $p$ small, all-categorical predictors and a large $n$, the direct table is **exact** and assumption-free — it beats logistic regression, which forces a linear log-odds shape. Every added predictor doubles its cost, so the crossover arrives almost immediately.

## 📊 Exam Execution Trace & Applied Exercises

### Applied Exercise 1 — estimate a classifier from raw data
**Problem:** $n=8$ individuals with mutation status $\mathbf{m}=(1,1,0,1,1,1,0,0)$ and heart disease $\mathbf{h}=(1,0,1,1,0,0,1,0)$. Estimate the joint table, then $\hat{\mathbb{P}}(H=1\mid M=0)$ and $\hat{\mathbb{P}}(H=1\mid M=1)$.
$$
\begin{aligned}
F(H{=}0,M{=}0) &= 1/8, \quad F(H{=}1,M{=}0)=2/8 \\
F(H{=}0,M{=}1) &= 3/8, \quad F(H{=}1,M{=}1)=2/8 \\
\hat{\mathbb{P}}(H{=}1\mid M{=}0) &= \frac{2/8}{1/8+2/8}=\frac{2}{3}=0.667 \\
\hat{\mathbb{P}}(H{=}1\mid M{=}1) &= \frac{2/8}{3/8+2/8}=\frac{2}{5}=0.400
\end{aligned}
$$
**Final Extracted Output:** in this **sample** the non-mutation group looks *more* likely to have heart disease — the reverse of the population table below, because $n=8$ is far too small. *(Slide 21 prints $0.2$ for the second line; $2/5=0.4$ — arithmetic slip, the method is right.)*

### Applied Exercise 2 — the same classifier from population probabilities
**Problem:** population joint probabilities of heart disease $H$ and LDLR mutation $M$: $(H{=}0,M{=}0)=0.35$, $(H{=}1,M{=}0)=0.30$, $(H{=}0,M{=}1)=0.10$, $(H{=}1,M{=}1)=0.25$. Classify a mutation carrier and a non-carrier.
$$
\begin{aligned}
\mathbb{P}(H{=}1\mid M{=}0) &= \frac{0.30}{0.35+0.30}=0.4615 \\
\mathbb{P}(H{=}1\mid M{=}1) &= \frac{0.25}{0.10+0.25}=0.7143
\end{aligned}
$$
**Final Extracted Output:** carrier ➔ predict $H=1$ ($0.714>\tfrac12$); non-carrier ➔ predict $H=0$ ($0.462<\tfrac12$). The mutation raises risk by $\approx25$ percentage points.

## ⚠️ Common Mistakes
- 💡 **Dividing by $n$ instead of the column total** ➔ the conditional divides the joint cell by the **marginal of the conditioning variable**, not by the sample size; $2/8$ is the joint, $2/5$ is the conditional.
- 💡 **Calling the direct approach "wrong"** ➔ it is exact and assumption-free; it fails only on **cost** ($2^{p+1}$), which is a sample-size problem, not a correctness one.
- 💡 **Confusing generative with "better"** ➔ a generative model estimates strictly more than a classifier needs; for pure prediction the discriminative conditional is the cheaper and usually the stronger choice.
- 💡 **Reading a small-sample proportion as the population value** ➔ the WLLN is asymptotic; at $n=8$ the estimated table can invert the true relationship entirely.

## 🧠 Active Recall
> [!FAQ]- Why does knowing the full joint distribution mean you already have every classifier you could want?
> - **Hint:** What operation turns a joint into a conditional?
> > [!SUCCESS]- Answer
> > - **Short answer:** Because any conditional is just the joint divided by a marginal, and the marginal is itself obtained by **summing** the joint — so the joint contains all of it.
> > - **Why:** **Sum then divide** ➔ $\mathbb{P}(Y=y\mid\mathbf{x})=\dfrac{p(y,\mathbf{x})}{\sum_{y'}p(y',\mathbf{x})}$ ➔ no extra information is ever needed.

> [!FAQ]- Two binary predictors need $8$ joint probabilities. Why is that *worse* than it sounds when $p$ grows?
> - **Hint:** Count, then compare against $n$.
> > [!SUCCESS]- Answer
> > - **Short answer:** The count is $2^{p+1}$ — **exponential** in $p$ — and each cell needs its own observations, so the required $n$ doubles with every predictor added.
> > - **Why:** **Curse of dimensionality** ➔ at $p=20$ that is $2^{21}\approx2.1$ million cells; no realistic $n$ populates them, so most cells get proportion $0$ and the classifier is undefined where it matters.

> [!FAQ]- What does a generative model buy you that logistic regression cannot, and what do you pay for it?
> > [!SUCCESS]- Answer
> > - **Short answer:** It can **synthesise new individuals** from a chosen class, because it models $p(Y,\mathbf{X})$ and can therefore evaluate $p(\mathbf{X}\mid Y)$; the price is estimating the whole joint.
> > - **Why:** **Discriminative shortcut** ➔ $p(Y\mid\mathbf{X})$ is all a classifier consumes, so modelling the joint spends parameters on structure the prediction task never reads.
