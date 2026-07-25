---
unit: FIT1043
week: 5
parent: "[[Machine Learning]]"
tags: [DataScience/Modelling, ML/Concepts, Monash/CS_DS]
aliases: [Supervised Learning, Unsupervised Learning, Classification, Clustering]
---
# [[Machine Learning Styles (Supervised vs Unsupervised)]]

**Context:** [[FIT1043_MOC]] · how [[Machine Learning]] algorithms learn · split by whether the data is **labelled** · supervised builds [[Predictive Models|predictive models]]

> [!abstract] Quick Revision
> - **🎯 Objective:** classify an algorithm by its data ➔ **supervised** (labelled → predict $y$ from $x$) vs **unsupervised** (unlabelled → find structure).
> - **📦 Core Components:** supervised → classification + regression | unsupervised → clustering + association.
> - **⚡ Key Constraint:** the deciding question is simply **"is the data labelled?"** — that alone picks the style and the task family.

## 📝 How It Works
### 1. Supervised
- **Setup** ➔ **all data labelled**; learn to predict output $y$ from input $x$ by approximating the mapping $f: x \to y$ well enough to predict $y$ for new $x$.
- **Tasks** ➔ **classification** (output a category, e.g. Red/Blue fish) · **regression** (output a real value, e.g. dollars/weight).
- **Algorithms** ➔ linear regression (regression); random forest (both); SVM (classification).

### 2. Unsupervised
- **Setup** ➔ **all data unlabelled**; learn the **inherent structure / distribution** of the input to learn more about it.
- **Tasks** ➔ **clustering** (discover natural groupings, e.g. customers by purchasing behaviour) · **association** (rules describing large parts of the data, e.g. buy X ⇒ also buy Y).
- **Algorithms** ➔ k-means (clustering); Apriori (association-rule learning).

## ⚖️ Core Decision Matrix
| Style | Data | Tasks | Example algorithms |
| :--- | :--- | :--- | :--- |
| **Supervised** | labelled | classification, regression | linear regression, random forest, SVM |
| **Unsupervised** | unlabelled | clustering, association | k-means, Apriori |

> [!NOTE] **When It Flips:** supervised = "learn a **mapping** to a known answer"; unsupervised = "learn the **structure** with no answer key" — classification/regression need labels, clustering/association do not.

## 🧠 Active Recall
> [!FAQ]- Grouping customers by purchasing behaviour vs predicting a house price — which style/task is each, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** Grouping customers = unsupervised **clustering** (no labels, find structure); predicting price = supervised **regression** (labelled real-valued target).
> > - **Why:** **Labelled?** ➔ a known target $y$ ⇒ supervised; no target, only structure ⇒ unsupervised.
