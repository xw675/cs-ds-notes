---
unit: [FIT1043, FIT2086]
domain: E
week: [7, 9, 10]
source: [lecture, applied]
parent: "[[Ensemble Models]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Random Forest, RF, Variable Importance, Ensemble Learning, out-of-bag error, OOB, permutation importance]
---
# [[Random Forest]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · an [[Ensemble Models|ensemble]] of [[Decision Trees and Regression Trees|decision trees]] · a single tree overfits and is unstable — a forest averages that away · each tree grown by a randomised version of [[Decision Tree Learning (Likelihood Splits, Pruning, CV)|forward search]]

> [!abstract] Quick Revision
> - **🎯 Objective:** combine $q$ randomised decision trees into one predictor ➔ aggregate their outputs ➔ keep a tree's **low bias**, cut its **high variance**.
> - **⚡ Key Constraint:** the "random" is the point — each tree sees a different random slice of data/features, so their errors are **uncorrelated** and cancel on aggregation; the price is **interpretability**.

## 📝 Core
- **Definition** ➔ an ensemble-learning method that builds a collection of $q$ decision trees and combines them.
- **Grow each tree (FIT2086)** ➔ random forward search: fit to a **random (bootstrap) sample** of the training data · at each split step the candidate variables are a **random subset** of the predictors · pick the split by a cost function (e.g. likelihood) · usually grown **without pruning**.
- **Aggregate** ➔ FIT1043: classification = majority **vote**, regression = **average** · FIT2086: regression = average the predicted **means**, classification = average the predicted **probabilities** ⟹ $\hat y=\frac1q\sum_{t=1}^{q}\hat y_t$.
- **Why it works** ➔ individual trees: **low bias, high variance** (unstable) ➔ combining many keeps the low bias and **reduces variance**; randomness also escapes the **greedy** search's single bad early split.
- **Variable importance** ➔ how much a variable **contributes to prediction across the trees** ➔ the forest's only window into "which predictors matter". `%IncMSE` = rise in out-of-bag MSE when that predictor is randomly **permuted** (the [[Permutation Tests|permutation]] idea aimed at a predictor) · `IncNodePurity` = purity gained by its splits.
- **Bagging ancestor (W10)** ➔ [[Bootstrap#5. Bagging|bagging]] = bootstrap samples ➔ one tree each ➔ average; a forest is bagged trees **plus** a random subset of candidate variables at every split.
- **Out-of-bag (OOB) error** ➔ each training row is predicted only by trees whose bootstrap sample **excluded** it ⟹ a free held-out estimate (Studio 9 diabetes: OOB MSE $3222$, $\sqrt{3222}\approx56.8$ vs test RMSE $54.6$); `% Var explained` is the OOB analogue of $100R^2$.
- **`ntree`** ➔ more trees cut the random variability of the fitted forest until predictions stabilise ($500\to5000$ trees: test RMSE $54.62\to54.19$); cost grows with the number of trees ➔ R usage in [[Trees, Forests and kNN in R (rpart, randomForest, kknn)]].
- **Strengths** ➔ very stable (resists data perturbations and poor greedy choices) · better predictive accuracy in general · multiclass and count targets · non-linear like trees · built-in variable selection.
- **Weaknesses** ➔ **poor interpretability** (variable importance is about all you get) · complex to learn — many variants and parameters to tweak.

## ⚖️ Core Decision Matrix
| Model | Bias | Variance / stability | Interpretability | Reach for it when |
| :--- | :--- | :--- | :--- | :--- |
| **Single tree** | low | high — a small data change can rebuild the tree | high: readable rules | the model must be explained |
| **Random forest** | low | low — averaging cancels tree-to-tree noise | poor: importance scores only | prediction accuracy is what matters |

> [!NOTE] **When It Flips:** the question moves from "**why** is this predicted?" (tree) to "**how accurately**?" (forest).

## ⚠️ Common Mistakes
- 💡 **One tree ≠ a forest** ➔ a lone decision tree can overfit; the forest's strength is combining **many diverse** trees.
- 💡 **Randomness is deliberate** ➔ if every tree were identical, averaging would gain nothing; random data/feature subsets create the needed diversity.
- 💡 **Claiming the forest cuts bias** ➔ averaging reduces **variance**; the bias stays that of a deep tree (already low).

## 🧠 Active Recall
> [!FAQ]- How does a random forest improve on a single decision tree?
> > [!SUCCESS]- Answer
> > - **Short answer:** It builds many decision trees on random subsets of data/features and aggregates them (vote for classification, average for regression), reducing the variance/overfitting of any single tree.
> > - **Why:** **Uncorrelated errors cancel** ➔ diverse trees make different mistakes, so combining them yields a more stable, accurate prediction ([[Ensemble Models|ensemble averaging]]).

> [!FAQ]- Four trees predict $12,16,14,18$ (regression) and class-1 probabilities $0.70,0.60,0.80,0.50$. What does the forest predict?
> > [!SUCCESS]- Answer
> > - **Short answer:** $\hat y=(12+16+14+18)/4=15$; $\hat p=(0.70+0.60+0.80+0.50)/4=0.65$ ⟹ class 1 at a $\tfrac12$ threshold.
> > - **Why:** **Average, don't vote** ➔ FIT2086 averages predicted means and predicted probabilities over the $q$ trees.

> [!FAQ]- Why can a random forest be more stable than one tree yet less interpretable?
> > [!SUCCESS]- Answer
> > - **Short answer:** Stability comes from averaging hundreds of differently-randomised trees; that same averaging leaves no single set of rules to read — only variable-importance scores.
> > - **Why:** **Variance ↓, readability ↓** ➔ individual trees have low bias but high variance; combining them keeps the bias, cuts the variance, and dissolves the tree structure.
