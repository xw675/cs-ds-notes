---
unit: FIT1043
domain: E
parent: "[[Machine Learning]]"
tags: [DataScience/ML, Tool/Sklearn]
type: cheatsheet
aliases: [Sklearn Cheatsheet, ML Workflow]
---
# [[Sklearn Workflow (Cheatsheet)]]

**Context:** [[FIT1043_MOC]] · Weeks 5–7 modelling in ONE skeleton · code canon in the LAB notebooks (`30_Projects/FIT1043_Labs/Week7-Classification-sklearn.ipynb`, `Week7-Clustering-KMeans.ipynb`) · applied depth in [[Scikit-learn Classification and Clustering]].
> [!WARNING] **Unit-specific:** FIT1043's **linear regression is done with scipy `linregress`, not sklearn** (Week 5 lab) — see [[Linear Regression in Python (scipy)]]. sklearn here is for **classification** and **clustering** (Week 7). The sklearn regression rows below are the standard API for reference/other units.

> [!abstract] Quick Revision
> - **🎯 Objective:** every sklearn model, same four verbs ➔ Estimator() → fit(X_train, y_train) → predict(X_test) → evaluate.
> - **⚡ Key Constraint:** shapes — $X\in\mathbb{R}^{N\times D}$ (2-D, even for one feature via `df.loc[:, ['weight']]`), $y\in\mathbb{R}^{N}$ (1-D); most beginner errors are a 1-D $X$.

## 🧩 The Universal Skeleton
```python
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
X = df.iloc[:, [0, 1]].values       # (N, D) — always 2-D (or df.loc[:, ['a','b']])
y = df.iloc[:, 2].values            # (N,)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)

sc = StandardScaler()               # scale AFTER splitting
X_train = sc.fit_transform(X_train) # fit on TRAIN only
X_test  = sc.transform(X_test)      # transform (never fit) TEST

model = SomeEstimator()             # swap this line per task ↓
model.fit(X_train, y_train)         # learn parameters from TRAIN only
y_pred = model.predict(X_test)      # apply to UNSEEN data
```
**Why split** ➔ evaluating on training data rewards memorisation — the [[Bias-Variance Tradeoff (Underfitting vs Overfitting)|overfitting]] trap; test error is the honest estimate.

## 🎛 Estimator Swap Table
| Task | Estimator line | Evaluate with | Concept note |
| :-- | :-- | :-- | :-- |
| **linear regression (FIT1043)** | `linregress(x, y)` (`scipy.stats`) → slope/intercept/r/p/std_err | $r$, plot the line | [[Linear Regression in Python (scipy)]] |
| classification (tree) | `DecisionTreeClassifier(criterion='entropy', random_state=0)` (`sklearn.tree`) | confusion matrix + metrics | [[Decision Trees and Regression Trees]] |
| classification (forest) | `RandomForestClassifier(n_estimators=20, criterion='entropy')` (`sklearn.ensemble`) | confusion matrix | [[Random Forest]] |
| clustering (no labels!) | `KMeans(n_clusters=k, init='random')` (`sklearn.cluster`) | `labels_`, `cluster_centers_`; no y in `fit(X)` | [[k-means Clustering]] |
| *(other units)* | `LinearRegression()` / `PolynomialFeatures(degree=k)` (`sklearn.linear_model`) | MSE, $R^2$ | [[Linear and Polynomial Regression]] |

## 📏 Evaluation Calls
| Task | Micro-syntax | Reads as |
| :-- | :-- | :-- |
| regression error | `mean_squared_error(y_test, y_pred)` | mean of squared residuals — the loss regression minimises |
| fit quality | `r2_score(y_test, y_pred)` or `model.score(X_test, y_test)` | proportion of variance explained |
| confusion matrix | `confusion_matrix(y_test, y_pred)` | rows=actual, cols=predicted ➔ TP/FP/FN/TN |
| accuracy | `accuracy_score(y_test, y_pred)` | correct ÷ total — misleading on imbalance |
| full report | `classification_report(y_test, y_pred)` | precision, recall, F1 per class |
| k-means labels | `model.labels_` · centroids `model.cluster_centers_` | assignment after convergence |

- **Metric choice is the exam question** ➔ spam filter wants precision, disease screen wants recall — derive from the confusion matrix, don't memorise ([[Classification Evaluation (Confusion Matrix and Metrics)]]).
- **Read coefficients** ➔ `model.coef_`, `model.intercept_` — same quantities as R's `fit$coefficients` ([[R Toolkit (Cheatsheet)]]).

## ✍️ Practice 
> [!QUESTION]- df has `hours`, `attendance` → `passed` (0/1). Build an 80/20 split, fit a decision tree, print the confusion matrix and accuracy, and state which metric you'd report if failing students are rare and missing one is costly.
> > [!SUCCESS]- Reference solution
> > ```python
> > from sklearn.model_selection import train_test_split
> > from sklearn.tree import DecisionTreeClassifier
> > from sklearn.metrics import confusion_matrix, accuracy_score
> > X, y = df[['hours', 'attendance']], df['passed']
> > X_tr, X_te, y_tr, y_te = train_test_split(X, y, test_size=0.2, random_state=42)
> > model = DecisionTreeClassifier().fit(X_tr, y_tr)
> > y_pred = model.predict(X_te)
> > print(confusion_matrix(y_te, y_pred), accuracy_score(y_te, y_pred))
> > # rare + costly misses ⇒ report RECALL on the 'fail' class, not accuracy
> > ```
> > - **Key moves:** 2-D X; fit on train only; metric justified by cost structure.

## ⚠️ Common Mistakes
- 💡 **1-D X crash** ➔ a single-bracket `df['w']` is $(N,)$; estimators need 2-D $(N,1)$ — use `df.loc[:, ['w']]` or `df.iloc[:, [0]]`.
- 💡 **Fitting on everything** ➔ split FIRST; any statistic learned from test rows (even `StandardScaler`) is leakage — `fit_transform` train, `transform` test.
- 💡 **Accuracy on imbalance** ➔ 95% accuracy on a 95/5 class split is the majority-class baseline, not skill.
- 💡 **Set `random_state`** ➔ without it, splits/forests/KMeans seeds change every run and results aren't reproducible.
