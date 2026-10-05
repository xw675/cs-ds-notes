---
unit: [FIT1043, FIT2086]
domain: E
week: [6, 8]
parent: "[[Linear and Polynomial Regression]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Underfitting, Overfitting, Bias, Variance, Bias-Variance Tradeoff, Train Test Split, Generalisation, Bias-Variance Decomposition, Irreducible Error, Prediction Error]
---
# [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · how model **complexity** governs fit quality · why a [[Linear and Polynomial Regression|polynomial]]'s degree and a [[Linear Regression (FIT2086)|regression]]'s predictor set are the same decision · measured on a [[Predictive Models|held-out test set]] or scored by [[Model Selection and Information Criteria (AIC, BIC)|an information criterion]] · lab: `30_Projects/FIT1043_Labs/Week6-BiasVariance-Solution.pdf`

> [!abstract] Quick Revision
> - **🎯 Objective:** balance model complexity ➔ too simple **underfits** (high bias), too complex **overfits** (high variance).
> - **📦 Core Components:** bias = distance from the true function | variance = how much predictions swing across datasets.
> - **⚡ Key Constraint:** you can't minimise both at once — reducing bias (more complexity) raises variance; the sweet spot is the **tradeoff**, and **in-sample fit cannot find it**.

## 📝 How It Works
### 1. Underfitting vs Overfitting
- **Underfitting** ➔ the model is **too simple** to capture the underlying structure (a straight line for a curve); poor fit due to **high bias**.
- **Overfitting** ➔ the model is **too complex** for the data (many parameters, little data) ➔ it fits the **noise** and makes wild predictions (a 25th-degree polynomial contorts wildly).
- **Complexity** ➔ more parameters ⇒ a more flexible curve; with little data this flexibility becomes overfitting.

### 2. Bias and Variance
- **Model family & hyperparameter** ➔ a **family** is a class of models set by a **hyperparameter** (here the polynomial **order**); giving the coefficients instantiates one member.
- **Bias** ➔ how close a family member can fit the **true** function; **simple/low-order ⇒ large bias ⇒ underfitting**.
- **Variance** ➔ the **mean squared error between the fitted curves and the best-possible fit** (same algorithm on "infinite" data) — how much fits swing across **different datasets**; **complex/high-order ⇒ small bias but large variance ⇒ overfitting**.
- **Key nuance** ➔ variance measures difference *between fits*, **not** difference from the truth; a high-order fit tracks truth well but occasionally "goes wild", giving large variance overall.

### 3. Train / Test Split
- **Split** ➔ divide data into **non-overlapping** training and test sets.
- **Rule** ➔ build the model on **training**; evaluate on **test**; **never** evaluate on the training set (it hides overfitting).

### 4. Complexity as a *Predictor-Set* Choice (FIT2086 W6)
- **Same tradeoff, regression vocabulary** ➔ **underfitting = omitting important predictors** ➔ systematic error, **bias** in predicting the target; **overfitting = including spurious predictors** ➔ the model learns noise and random variation.
- **Generalisation** ➔ the named goal: performance on **new, unseen data from the population**, not on the sample fitted.
- **Degree selection is predictor selection** ➔ fitting $x,x^2,\dots,x^{20}$ makes "how many terms?" identical to "which predictors?" — on the lecture's 50-sample dataset $(x,x^2)$ **underfits**, $(x,\dots,x^{20})$ **overfits**, and $(x,\dots,x^{5})$ is "just right" (the true relationship is fifth-order — W8).
- **How the sweet spot is actually found** ➔ not by eye and not by in-sample fit ➔ a **penalised score** ([[Model Selection and Information Criteria (AIC, BIC)]]) or held-out evaluation ([[Plug-in Prediction and Held-Out Evaluation]]).
- **Which criterion leans which way** ➔ **AIC** is more likely to **overfit** (keeps spurious predictors), **BIC** more likely to **underfit** (drops real ones) — the bias–variance dial, expressed as a penalty size.

### 5. The Formal Decomposition (FIT2086 W8)
- **Population model** ➔ $\mathbb{E}[Y\mid x_1,\dots,x_p]=f(x_1,\dots,x_p)$; for regression $Y=f(\mathbf{x})+\varepsilon$, $\mathbb{E}[\varepsilon]=0$, $\mathbb{V}(\varepsilon)=\sigma^2$.
- **Fit depends on the sample** ➔ training sample $\mathcal{D}=\{(x_i,y_i)\}_{i=1}^n$ gives $\hat f_{\mathcal{D}}(x)$; a new $\mathcal{D}$ from the same population gives a different fit ➔ this **repeated-sampling** variation defines bias and variance.
- **Bias at $x_0$** ➔ $\text{bias}(x_0)=\mathbb{E}_{\mathcal{D}}\big[\hat f_{\mathcal{D}}(x_0)\big]-f(x_0)$ — average fitted value minus true value ➔ **systematic** error: are the fits centred on the truth?
- **Variance at $x_0$** ➔ $\text{variance}(x_0)=\mathbb{V}_{\mathcal{D}}\big(\hat f_{\mathcal{D}}(x_0)\big)$ ➔ how much the fitted value moves across training samples.
- **Estimation error** ➔
$$
\mathbb{E}_{\mathcal{D}}\Big[\big(\hat f_{\mathcal{D}}(x_0)-f(x_0)\big)^2\Big]=\text{bias}(x_0)^2+\text{variance}(x_0)
$$
averaged over a grid of $x$ ⟹ $\text{MSE}_f=\text{bias}^2+\text{variance}$.
- **Prediction error** ➔ a new observation $Y'=f(x)+\varepsilon'$ adds noise the model can never remove:
$$
\mathbb{E}_{\mathcal{D},\varepsilon'}\Big[\big(Y'-\hat f_{\mathcal{D}}(x)\big)^2\Big]=\text{bias}(x)^2+\text{variance}(x)+\sigma^2
$$
➔ $\sigma^2$ is the **irreducible error**: model selection trades bias against variance but cannot touch it.
- **Sample size** ➔ variance generally **falls** as $n$ grows; **approximation bias** from a too-simple model does **not** disappear with more data.
- **Mapping** ➔ underfitting ⟹ high bias, low variance (MSE driven by bias); overfitting ⟹ low bias, high variance (extra flexibility chases the noise; e.g. fitted $x^6,x^7$ coefficients are non-zero even though the true ones are $0$).
- **Subtleties** ➔ including every associated predictor may not remove bias if the relationship needs a **transformation** · you can **underfit and overfit at once** (omit an important predictor, include an unnecessary one) · omitting a **weak** predictor can improve prediction when estimating its coefficient adds more variance than the bias it removes · combine statistical tools with real-world knowledge.

### 6. Simulation Evidence (FIT2086 W8)
- **Setup** ➔ truth $f(x)=9.7x^5+0.8x^3+9.4x^2-5.7x-2$; each training sample: $n=50$, $x_i\sim U(-1,1)$, $y_i=f(x_i)+\varepsilon_i$, $\varepsilon_i\sim N(0,1)$; $10{,}000$ samples; each fit evaluated on a $5000$-point grid in $(-1,1)$ ➔ average fitted value, variance, squared bias per $x$, then averaged over the grid (plus 2.5/97.5 percentile bands).

| Fitted order | $\text{MSE}_f$ | $\text{bias}^2$ | variance | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| 2 | $3.33$ | $3.27$ | $0.058$ | **underfit** — poor average fit, tight band |
| 7 | $0.1470$ | $\approx0$ | $0.1470$ | good average fit, wider band |
| 20 | $0.4860$ | $\approx0$ | $0.4860$ | **overfit** — widest band, worst near the boundaries |

## ⚖️ Core Decision Matrix
| Complexity | Bias | Variance | Fit | Regression reading |
| :--- | :--- | :--- | :--- | :--- |
| **too low** (e.g. linear on a curve) | high | low | **underfit** | important predictors omitted |
| **balanced** | moderate | moderate | good | the criterion-selected subset |
| **too high** (e.g. 25th-degree) | low | high | **overfit** | spurious predictors included |

> [!NOTE] **When It Flips:** the truth's shape decides the winner — for a near-straight truth a linear model beats a 3rd-order (lower variance, similar bias); for a curved truth linear underfits (high MSE) and higher-order polynomials win. There is no single best complexity ([[No Free Lunch Theorem]]).

## ⚠️ Common Mistakes
- 💡 **Evaluating on training data hides overfitting** ➔ an overfit model scores great on train, poorly on test; always judge on the held-out test set or a penalised score.
- 💡 **Overfitting wastes a close fit** ➔ if the data has known noise, chasing every point fits the noise, not the signal.
- 💡 **Expecting more data to cure underfitting** ➔ extra $n$ shrinks variance only; a quadratic can never represent a fifth-order truth.
- 💡 **Promising to remove all error** ➔ $\sigma^2$ is irreducible; only $\text{bias}^2+\text{variance}$ responds to model choice.
- 💡 **Reading "more predictors improved $R^2$" as progress** ➔ that improvement is guaranteed and says nothing about generalisation.

## 🧠 Active Recall
> [!FAQ]- Define bias and variance, and link each to underfitting or overfitting.
> - **Hint:** Accuracy vs stability.
> > [!SUCCESS]- Answer
> > - **Short answer:** Bias = distance of predictions from the true function (high bias ⇒ underfitting, inaccurate); variance = spread of predictions across datasets (high variance ⇒ overfitting, unstable).
> > - **Why:** **Complexity dial** ➔ raising complexity lowers bias but raises variance; the tradeoff picks the balance that minimises test error.

> [!FAQ]- Why must you evaluate on a separate test set, not the training set?
> - **Hint:** Generalisation.
> > [!SUCCESS]- Answer
> > - **Short answer:** A model can memorise the training data (overfit) and score well on it while failing on new data; the held-out test set measures genuine generalisation.
> > - **Why:** **Non-overlapping split** ➔ test points were never seen in fitting, so test error reflects real predictive quality.

> [!FAQ]- Express the bias–variance tradeoff purely in terms of which predictors a regression includes.
> > [!SUCCESS]- Answer
> > - **Short answer:** Dropping a genuine predictor underfits and injects **bias**; adding a spurious one overfits and injects **variance** by letting the model chase noise.
> > - **Why:** **The penalty is the dial** ➔ AIC's mild charge errs toward including too many, BIC's $\tfrac{k}{2}\log n$ charge errs toward too few ➔ [[Model Selection and Information Criteria (AIC, BIC)]].

> [!FAQ]- At a fixed $x'$, refitted models give $\hat f(x')$ values that are tightly clustered but whose average is far from $f(x')$. Is the error mainly bias or variance?
> > [!SUCCESS]- Answer
> > - **Short answer:** Primarily **bias** — the tight cluster means small variance, the offset average means large systematic error.
> > - **Why:** **Decomposition** ➔ $\text{bias}(x')=\mathbb{E}_{\mathcal{D}}[\hat f_{\mathcal{D}}(x')]-f(x')$ is large while $\mathbb{V}_{\mathcal{D}}(\hat f_{\mathcal{D}}(x'))$ is small ➔ the signature of underfitting.
