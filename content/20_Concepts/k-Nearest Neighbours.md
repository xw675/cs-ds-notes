---
unit: FIT2086
week: 9
source: [lecture]
domain: E
parent: "[[Classification and Conditional Class Probabilities]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [kNN, k-NN, KNN, k Nearest Neighbours, Nearest Neighbours, Nearest Neighbour Smoothing, k-Nearest Neighbors, Kernel Weighting, Euclidean Distance]
---
# [[k-Nearest Neighbours]]

**Context:** [[FIT2086_MOC]] · the model-free alternative to [[Logistic Regression]] / [[Linear Regression (FIT2086)|linear regression]] and to [[Decision Trees and Regression Trees|trees]] · handles both classification and regression · tuned by leave-one-out [[Cross-Validation]]
**Parent Framework:** [[Classification and Conditional Class Probabilities]]

> [!abstract] Quick Revision
> - **🎯 Objective:** find the $k$ training individuals **closest** to $\mathbf{x}'$ ➔ **vote** (classification) or **average** (regression) their targets ➔ that is the prediction.
> - **📦 Core Components:** distance $d(\mathbf{x},\mathbf{x}')$ | neighbourhood size $k$ | prediction function $f$ (vote / mean / kernel-weighted mean) ➔ all chosen by LOO CV.
> - **⚠️ Key Constraint:** distances are only meaningful on **comparable scales** ➔ standardise predictors first, or the largest-unit predictor decides who is "near".

## 📝 How It Works
### 1. Idea
- **No model fitted** ➔ keep the $n$ pairs $(x_{i,1},\dots,x_{i,p};\,y_i)$; predict the target of a new individual $x'_1,\dots,x'_p$ from its most similar individuals.
- **Very weak assumption** ➔ individuals similar in predictor values are similar in targets — nothing about linearity or a distribution.

### 2. Distance
- **Euclidean (default)** ➔ $d(\mathbf{x},\mathbf{x}')=\left[\sum_{j=1}^{p}(x_j-x'_j)^2\right]^{1/2}$.
- **Not always best** ➔ categorical predictors need other measures; different distances give **different** neighbours and predictions.
- **Scaling** ➔ predictors are usually **standardised** before computing distances.

### 3. Algorithm
1. Compute $d_i=d(\mathbf{x}_i,\mathbf{x}')$ for every training individual $i$.
2. Sort from smallest to largest $d_i$; relabel targets $y^{(1)},\dots,y^{(n)}$ ($y^{(1)}$ = closest, $y^{(n)}$ = furthest).
3. Predict $\hat y'=f\big(y^{(1)},\dots,y^{(k)}\big)$ from the $k$ nearest.

### 4. Prediction Function $f$
- **Classification** ➔ **voting**: the class most frequent among the $k$ neighbours.
- **Regression** ➔ **averaging**: $\hat y'=\dfrac1k\sum_{i=1}^{k}y^{(i)}$.
- **Weighted averaging** ➔ $\hat y'=\dfrac{\sum_{i=1}^{k}g(d_{(i)})\,y^{(i)}}{\sum_{i=1}^{k}g(d_{(i)})}$ with $g$ **decreasing** in $d$ ⟹ further neighbours count less; $g$ is a **kernel function** (e.g. uniform, inverse distance, Gaussian).

### 5. Tuning by Leave-One-Out CV
- **Tunables** ➔ neighbourhood size $k$ · distance function · kernel weighting function.
- **LOO CV** ➔ for each parameter combination: predict every $y_i$ by kNN with $y_i$ **removed** from the training set ➔ accumulate the error $e_i=\text{loss}(\hat y_i,y_i)$ (0/1 for classification, squared error for regression) ➔ choose the combination with the smallest total.
- **Why LOO fits kNN** ➔ there is no model to refit, so leaving one out costs only one more distance sort.

### 6. Strengths and Weaknesses
- **Strengths** ➔ very weak assumptions · very little model-fitting or training · handles continuous and categorical predictors.
- **Weaknesses** ➔ lots to configure ($k$, "nearest", weighting, whether all predictors count equally) · can perform **poorly in high-dimensional** predictor spaces · predictor selection is not straightforward · **no interpretability**.

## ⚖️ Core Decision Matrix
| Prediction rule | Target | Formula | Neighbour influence |
| :--- | :--- | :--- | :--- |
| **Voting** | categorical | most frequent class among $y^{(1)},\dots,y^{(k)}$ | all $k$ equal |
| **Averaging** | numerical | $\frac1k\sum_{i=1}^{k}y^{(i)}$ | all $k$ equal |
| **Kernel-weighted averaging** | numerical (or class probabilities) | $\sum g(d_{(i)})y^{(i)}/\sum g(d_{(i)})$ | closer ⟹ heavier |

> [!NOTE] **When It Flips:** the $k$-th neighbour is much further than the first ➔ unweighted rules let it count as much as the closest point; switch to a decreasing kernel $g$.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Nearest labels in rank order: 1 Disease · 2 No · 3 Disease · 4 No · 5 No · 6 Disease.

| $k$ | Neighbours used | Disease votes | No-disease votes | Prediction |
| :--- | :--- | :--- | :--- | :--- |
| $1$ | rank 1 | $1$ | $0$ | Disease |
| $3$ | ranks 1–3 | $2$ | $1$ | **Disease** |
| $5$ | ranks 1–5 | $2$ | $3$ | **No disease** |
| $6$ | ranks 1–6 | $3$ | $3$ | tie — even $k$ can tie in a two-class vote |

- **Reading** ➔ the **same** individual flips class as $k$ changes ⟹ $k$ is a genuine model choice, set by LOO CV. Lecture pictures: $k=3$ neighbours all diseased ⟹ Disease; $k=4$ with 3 of 4 healthy ⟹ No disease.

### Applied Exercise
**Problem:** the $k=3$ nearest neighbours have targets $10, 14, 22$ with kernel weights $0.5, 0.3, 0.2$ (closest first). Give the plain and the weighted kNN regression predictions.
$$
\begin{aligned}
\hat y'_{\text{plain}} &= \tfrac13(10+14+22) = 15.33 \\
\hat y'_{\text{weighted}} &= \frac{0.5(10)+0.3(14)+0.2(22)}{0.5+0.3+0.2} = \frac{5+4.2+4.4}{1} = 13.6
\end{aligned}
$$
**Final Extracted Output:** $15.33$ unweighted; $13.6$ weighted — pulled towards the closest neighbour's $10$.

## ⚠️ Common Mistakes
- 💡 **Forgetting to divide by $\sum g$** ➔ the weighted mean needs the weights normalised; it only looks unnecessary when they already sum to $1$.
- 💡 **Distances on raw units** ➔ a predictor in thousands swamps one in single digits; standardise first.
- 💡 **Choosing $k$ on training error** ➔ with $y_i$ left in, $k=1$ always "predicts" $y_i$ perfectly (its nearest neighbour is itself); leave it out (LOO).

## 🧠 Active Recall
> [!FAQ]- kNN "does not produce a model". What does it store, and where does the work happen?
> > [!SUCCESS]- Answer
> > - **Short answer:** It stores the $n$ training pairs; all work happens at prediction time — distances to every training point, a sort, then a vote or average.
> > - **Why:** **No fitting step** ➔ nothing like $\hat{\boldsymbol\beta}$ is estimated, which is why LOO CV is cheap and why there is nothing to interpret.

> [!FAQ]- Why standardise predictors before kNN, and what goes wrong if you don't?
> > [!SUCCESS]- Answer
> > - **Short answer:** Euclidean distance adds squared differences across predictors, so the predictor with the largest numeric scale dominates who counts as "nearest".
> > - **Why:** **Scale, not relevance** ➔ $d(\mathbf{x},\mathbf{x}')=\big[\sum_j(x_j-x'_j)^2\big]^{1/2}$ has no per-predictor weight; standardising gives each predictor a comparable spread.

> [!FAQ]- How would you choose $k$, the distance and the kernel?
> > [!SUCCESS]- Answer
> > - **Short answer:** Leave-one-out CV over a grid of combinations — predict each $y_i$ with it removed, sum the errors, keep the smallest.
> > - **Why:** **Held-out error** ➔ each $y_i$ is predicted from data that excludes it, estimating error on future individuals.

> [!TIP]- 🔭 Beyond the lecture *(not in the slides)*
> - **$k$ as a complexity dial** ➔ small $k$ ⟹ jagged, low-bias/high-variance boundary; large $k$ ⟹ smoother, higher bias; $k=n$ predicts the overall majority / mean for everyone.
> - **Use odd $k$ for two classes** ➔ avoids vote ties.
