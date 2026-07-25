---
unit: FIT1043
week: 7
parent: "[[Ensemble Models]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Random Forest, RF]
---
# [[Random Forest]]

**Context:** [[FIT1043_MOC]] · an [[Ensemble Models|ensemble]] of [[Decision Trees and Regression Trees|decision trees]] · a single tree overfits — a forest averages that away

> [!abstract] Quick Revision
> - **🎯 Objective:** combine **many** decision trees into one predictor ➔ aggregate their outputs for a stabler prediction.
> - **⚡ Key Constraint:** the "random" is the point — each tree sees a different random slice of data/features, so their errors are **uncorrelated** and cancel on aggregation.

## 📝 Core
- **Definition** ➔ an ensemble-learning method that **constructs a number of decision trees** and combines them.
- **Diversity** ➔ each tree is grown on a random subset of the data (and features), so trees differ.
- **Aggregate** ➔ **classification** → majority **vote** across trees; **regression** → **average** of tree outputs.
- **Payoff** ➔ averaging many trees reduces the **variance/overfitting** of a single deep tree (an [[Ensemble Models|ensemble]] effect).

## ⚠️ Common Mistakes
- 💡 **One tree ≠ a forest** ➔ a lone decision tree can overfit; the forest's strength is combining **many diverse** trees.
- 💡 **Randomness is deliberate** ➔ if every tree were identical, averaging would gain nothing; random data/feature subsets create the needed diversity.

## 🧠 Active Recall
> [!FAQ]- How does a random forest improve on a single decision tree?
> > [!SUCCESS]- Answer
> > - **Short answer:** It builds many decision trees on random subsets of data/features and aggregates them (vote for classification, average for regression), reducing the variance/overfitting of any single tree.
> > - **Why:** **Uncorrelated errors cancel** ➔ diverse trees make different mistakes, so combining them yields a more stable, accurate prediction ([[Ensemble Models|ensemble averaging]]).
