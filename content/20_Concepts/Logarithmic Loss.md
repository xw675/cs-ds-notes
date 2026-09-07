---
unit: FIT2086
week: 7
source: [lecture]
domain: [E, D]
parent: "[[Classification Evaluation (Confusion Matrix and Metrics)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Log-Loss, Log Loss, Logarithmic Loss, Negative Log-Probability, Predictive Accuracy, Calibration]
---
# [[Logarithmic Loss]]

**Context:** [[FIT2086_MOC]] · the only W7 measure that scores the **probabilities** rather than the labels · it is the [[Maximum Likelihood Estimation|negative log-likelihood]] of *future* data, so it is the classification twin of the held-out NLL in [[Plug-in Prediction and Held-Out Evaluation]] · the calibration counterpart to the ranking measure [[ROC and AUC]] · applied to the output of [[Logistic Regression]]

> [!abstract] Quick Revision
> - **🎯 Objective:** score each test point by the **negative log-probability its model gave the true class** ➔ sum over the test set ➔ **smaller is better**.
> - **⚡ Key Constraint:** accuracy and AUC only see *which class won*; log-loss is the only one of the three that penalises being **confidently wrong**.

## 📝 Core
- **Per-sample score** ➔ take $-\log$ of the probability the model assigned to the class that actually occurred:
$$
L(y'_i)=\begin{cases}-\log\mathbb{P}(Y'_i=1\mid x'_{i,1},\dots,x'_{i,p}) & \text{for } y'_i=1\\[2pt] -\log\mathbb{P}(Y'_i=0\mid x'_{i,1},\dots,x'_{i,p}) & \text{for } y'_i=0\end{cases}
$$
- **Total over the test set** ➔ $L(\mathbf{y}')=\sum_{i=1}^{n'}L(y'_i)$ ➔ this is exactly the **negative log-likelihood of the new, future data** under the fitted model.
- **Direction** ➔ **smaller score = better predictions**; a probability of $1$ on the truth costs $0$, and a probability approaching $0$ on the truth costs $\to\infty$.
- **What it measures** ➔ **probabilistic predictive accuracy**, i.e. how well the model predicts the *probability* of class membership, not merely how often it guesses the top class right.
- **Why that matters** ➔ it tells you how much **confidence** to place in a predicted class ➔ $\mathbb{P}(Y=1\mid\mathbf{x})=0.501$ and $0.99$ both predict class $1$, but only the second is a confident claim, and log-loss is the measure that separates them.
- **Same object as the fitting objective** ➔ the training NLL minimised in [[Logistic Regression]] and this test-set score are the **same formula** on different data ⟹ fit and evaluation share one currency.

## ⚠️ Common Mistakes
- 💡 **Scoring the predicted class instead of the truth** ➔ log-loss always takes the probability the model gave the class that **actually occurred**, even when that class lost the argmax.
- 💡 **Treating "bigger is better"** ➔ it is a **loss**; the sign convention is the same trap as the NLL in model selection ([[Model Selection and Information Criteria (AIC, BIC)]]).
- 💡 **Comparing log-loss across different test sets** ➔ it is a **sum**, so it grows with $n'$; only compare models scored on the **same** test data (or divide by $n'$ first).

## 🧠 Active Recall
> [!FAQ]- Two classifiers both predict $Y=1$ for an individual whose true class is $1$, with $\mathbb{P}(Y=1\mid\mathbf{x})=0.501$ and $0.99$. How do accuracy and log-loss rank them?
> - **Hint:** One of the two measures cannot tell them apart.
> > [!SUCCESS]- Answer
> > - **Short answer:** Accuracy scores them **identically** — both got the label right. Log-loss charges $-\log0.501\approx0.69$ versus $-\log0.99\approx0.01$, so the confident model wins by a wide margin.
> > - **Why:** **Accuracy is a step function of the label** ➔ it discards the probability entirely; log-loss is continuous in $\hat p$, so it rewards being **right and sure** and punishes being **wrong and sure**.

> [!FAQ]- Why is log-loss described as the negative log-likelihood of the new data?
> > [!SUCCESS]- Answer
> > - **Short answer:** Because $\sum_i-\log\mathbb{P}(Y'_i=y'_i\mid\mathbf{x}'_i)$ is precisely $-\log$ of the product of the model's probabilities for the observed test outcomes — the [[Binomial Distribution|Bernoulli]] likelihood evaluated on **held-out** data.
> > - **Why:** **Same formula, different data** ➔ the training version is minimised to *fit* the model, and the test version is computed to *judge* it ⟹ the second is an honest estimate of the first, since the test points were never used to choose $\hat\beta_0,\hat{\boldsymbol\beta}$.
