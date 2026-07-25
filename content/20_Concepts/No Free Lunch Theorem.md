---
unit: FIT1043
domain: E
week: 6
parent: "[[Machine Learning]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [No Free Lunch Theorem, NFL]
---
# [[No Free Lunch Theorem]]

**Context:** [[FIT1043_MOC]] · why there's no single best [[Machine Learning|ML]] algorithm · reinforces the [[Bias-Variance Tradeoff (Underfitting vs Overfitting)|bias–variance]] lesson · motivates trying several models

> [!abstract] Quick Revision
> - **🎯 Objective:** accept that no algorithm is universally best ➔ strong performance on one problem class is paid for elsewhere.
> - **⚡ Key Constraint:** the result holds with **finite data** — algorithm choice must be matched to the problem, not assumed.

## 📝 Core
- **Wolpert & Macready** ➔ proved that if a learning algorithm does well on one class of problems, it **necessarily** does worse on the set of all remaining problems.
- **Consequence** ➔ there is **no universally good** ML algorithm (given finite data).
- **Match algorithm to problem** ➔ e.g. Naive Bayes classification works well for text with smaller datasets; linear SVMs work well for text classification.

## ⚠️ Common Mistakes
- 💡 **No "best model" to default to** ➔ don't assume one algorithm wins everywhere; try candidates and evaluate on a [[Bias-Variance Tradeoff (Underfitting vs Overfitting)|test set]].
- 💡 **Gains are traded, not free** ➔ specialising to one problem class costs performance on others.

## 🧠 Active Recall
> [!FAQ]- State the No Free Lunch theorem and its practical implication.
> > [!SUCCESS]- Answer
> > - **Short answer:** No algorithm is best across all problems — excelling on one class means degraded performance on the rest (with finite data), so pick and evaluate algorithms per problem.
> > - **Why:** **Averaged over all problems** ➔ every method's advantages on some tasks are offset by disadvantages on others.
