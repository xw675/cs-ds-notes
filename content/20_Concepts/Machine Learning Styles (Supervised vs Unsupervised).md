---
unit: [FIT1043, FIT2086]
domain: E
week: [5, 11]
parent: "[[Machine Learning]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Supervised Learning, Unsupervised Learning, Classification, Clustering, intrinsic classification, unsupervised data discovery]
---
# [[Machine Learning Styles (Supervised vs Unsupervised)]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · how [[Machine Learning]] algorithms learn · split by whether the data is **labelled** · supervised builds [[Predictive Models|predictive models]] · FIT2086 W11 unsupervised toolkit ➔ [[k-means Clustering]], [[Mixture Models (EM Algorithm)]], [[Missing Data Imputation and Recommender Systems]]

> [!abstract] Quick Revision
> - **🎯 Objective:** classify an algorithm by its data ➔ **supervised** (labelled → predict $y$ from $x$, model $p(Y\mid X_1,\dots,X_p)$) vs **unsupervised** (unlabelled → find structure, often by modelling $p(X_1,\dots,X_q)$).
> - **📦 Core Components:** supervised → classification + regression | unsupervised → clustering + association (+ FIT2086: imputation, recommender systems).
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

### 3. The Probabilistic View (FIT2086)
- **Data matrix** ➔ $n$ items × $q$ attributes, $\mathbf{Y}=(\mathbf{y}_1,\dots,\mathbf{y}_n)'$ with $\mathbf{y}_i=(y_{i,1},\dots,y_{i,q})$ a point in $q$-dimensional space; **no attribute is nominated as the target**.
- **Supervised** ➔ target $Y$ and explanatory $X_1,\dots,X_p$ ➔ find the **conditional** $p(Y\mid X_1,\dots,X_p)$ with a chosen model form (linear regression, tree, …).
- **Unsupervised** ➔ only $X_1,\dots,X_q$ ➔ discover structure in their distribution, some methods by modelling the **joint** $p(X_1,\dots,X_q)$; the fitted model's details reveal the structure.
- **Uses** ➔ taxonomy (species of animals) · filling missing entries: imputation before supervised learning, recommender systems · image processing: noise removal, compression, analysis and recognition.
- **Clustering setting** ➔ represent the data with $K>1$ groups, possibly **latent sub-populations**, with no class information ➔ aim: discover $K$ **and** characterise each cluster ➔ "**intrinsic classification**": class labels learned from the data.

## ⚖️ Core Decision Matrix
| Style | Data | Tasks | Example algorithms |
| :--- | :--- | :--- | :--- |
| **Supervised** | labelled | classification, regression | linear regression, random forest, SVM |
| **Unsupervised** | unlabelled | clustering, association, imputation | k-means, mixture models, Apriori, kNN imputation |

> [!NOTE] **When It Flips:** supervised = "learn a **mapping** to a known answer"; unsupervised = "learn the **structure** with no answer key" — classification/regression need labels, clustering/association do not.

## 🧠 Active Recall
> [!FAQ]- Grouping customers by purchasing behaviour vs predicting a house price — which style/task is each, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** Grouping customers = unsupervised **clustering** (no labels, find structure); predicting price = supervised **regression** (labelled real-valued target).
> > - **Why:** **Labelled?** ➔ a known target $y$ ⇒ supervised; no target, only structure ⇒ unsupervised.

> [!FAQ]- Which distribution does a supervised model target, and which does an unsupervised model target? (FIT2086)
> > [!SUCCESS]- Answer
> > - **Short answer:** supervised ➔ the conditional $p(Y\mid X_1,\dots,X_p)$; unsupervised ➔ structure in the joint $p(X_1,\dots,X_q)$, often by modelling it directly (e.g. a mixture model).
> > - **Why:** **Nominated target or not** ➔ with a target, only how it depends on the predictors matters; without one, every attribute is part of the structure being described.
