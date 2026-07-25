---
unit: FIT1043
domain: E
week: 6
parent: "[[Linear and Polynomial Regression]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Underfitting, Overfitting, Bias, Variance, Bias-Variance Tradeoff, Train Test Split]
---
# [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]

**Context:** [[FIT1043_MOC]] · how model **complexity** governs fit quality · why a [[Linear and Polynomial Regression|polynomial]]'s degree matters · measured on a [[Predictive Models|held-out test set]] · lab: `30_Projects/FIT1043_Labs/Week6-BiasVariance-Solution.pdf`

> [!abstract] Quick Revision
> - **🎯 Objective:** balance model complexity ➔ too simple **underfits** (high bias), too complex **overfits** (high variance).
> - **📦 Core Components:** bias = distance from the true function | variance = how much predictions swing across datasets.
> - **⚡ Key Constraint:** you can't minimise both at once — reducing bias (more complexity) raises variance; the sweet spot is the **tradeoff**.

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

## ⚖️ Core Decision Matrix
| Complexity | Bias | Variance | Fit |
| :--- | :--- | :--- | :--- |
| **too low** (e.g. linear on a curve) | high | low | **underfit** |
| **balanced** | moderate | moderate | good |
| **too high** (e.g. 25th-degree) | low | high | **overfit** |

> [!NOTE] **When It Flips:** the truth's shape decides the winner — for a near-straight truth a linear model beats a 3rd-order (lower variance, similar bias); for a curved truth linear underfits (high MSE) and higher-order polynomials win. There is no single best complexity ([[No Free Lunch Theorem]]).

## ⚠️ Common Mistakes
- 💡 **Evaluating on training data hides overfitting** ➔ an overfit model scores great on train, poorly on test; always judge on the held-out test set.
- 💡 **Overfitting wastes a close fit** ➔ if the data has known noise, chasing every point fits the noise, not the signal.

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
