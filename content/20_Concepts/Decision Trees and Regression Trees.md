---
unit: [FIT1043, FIT2086]
domain: E
week: [7, 9]
source: [lecture]
parent: "[[Predictive Models]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Decision Tree, Regression Tree, Recursive Partitioning, Information Gain, Split and Leaf, Leaf Model]
---
# [[Decision Trees and Regression Trees]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]] · a [[Predictive Models|predictive model]] you can read as rules · splits the feature space into regions · the building block of a [[Random Forest]] · how FIT2086 grows and sizes one ➔ [[Decision Tree Learning (Likelihood Splits, Pruning, CV)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** classify or predict by walking a tree of feature tests ➔ decision tree = categorical, regression tree = real value; each leaf holds a **fitted model** for its region.
> - **📦 Core Components:** recursive partitioning | leaf model (Bernoulli/mode vs Normal/mean) | split criterion (purity/info gain; FIT2086: NLL) | complexity $L=$ number of leaves.
> - **⚡ Key Constraint:** the algorithm's choices — **which feature to split on** and **when to stop** — determine the tree; a large enough $L$ fits the training data **perfectly** ⟹ overfits.

## 📝 How It Works
### 1. Two Kinds of Tree
- **Decision tree** ➔ predicts a **binary/multi-class categorical** outcome (play tennis: yes/no).
- **Regression tree** ➔ predicts a **continuous real** value (leaves hold numbers like 45.6).
- **Structure** ➔ start at the **root**, follow a **branch** per feature test, reach a **leaf** = the prediction.

### 2. Building & Predicting
- **Recursive partitioning** ➔ repeatedly divide the feature space into regions that **group similar instances** together.
- **Decision-tree leaf** ➔ predict the **most common** class in that region.
- **Regression-tree leaf** ➔ predict the **average** value in that region.

### 3. Split Criteria & Stopping
- **Which feature to split** ➔ chosen by a **purity / information-gain** measure (e.g. **entropy**); algorithms differ — **ID3, C4.5, CART**.
- **When to stop** ➔ further splits stop helping: minimum samples per node, maximum depth, or negligible accuracy gain.

### 4. The Statistical View (FIT2086)
- **Same job as regression** ➔ $\hat y(x_1,\dots,x_p)=f(x_1,\dots,x_p)$; only the **form** of $f$ differs — highly **non-linear**, yet still interpretable.
- **Partition** ➔ the splits carve predictor space into $L$ **disjoint regions** $R_1,\dots,R_L$; each region is a **leaf**.
- **Leaf model** ➔ each leaf holds a model fitted to **its own** data: **Bernoulli** $\hat\theta_\ell=n_1/n$ for binary targets · **Normal** (own mean **and** variance) for regression.
- **Predict** ➔ traverse from the root taking the branch your $x$ satisfies ➔ use that leaf's model.
- **Complexity** ➔ $L$ (number of leaves) ➔ more leaves ⟹ closer fit to the training data.
- **Multi-class** ➔ generalises directly — the leaf model becomes a categorical distribution.

### 5. Strengths, Weaknesses, Instability (FIT2086)
- **Strengths** ➔ highly interpretable · handles **non-linearity** · handles **interactions** (split on $x_j$ then on $x_k$ ⟹ they interact) · mixes continuous, categorical and count predictors · multiclass for free · **variable selection built in** (unused predictors never split).
- **Non-linearity, regression** ➔ truth $y=9.7x^5+0.8x^3+9.4x^2-5.7x-2$: linear fit $\hat y=1.1365-1.3941x$ misses the curve; trees with $L=3,5,20,88$ leaves give ever finer **staircases**, $L=88$ tracing it almost exactly.
- **Non-linearity, classification** ➔ tree boundary = **axis-aligned step line**; [[Logistic Regression]] boundary = one straight line.
- **Weaknesses** ➔ good tree hard to find (search is approximate) · **unstable** — a slight data change can give a drastically different tree · **inefficient** when the truth is linear (many leaves, many parameters to approximate a line).
- **Instability, same 185 patients** ➔ three trees score $172.1$, $173.7$, $173.1$ — near-equal fits, different structures ➔ no clear winner ⟹ motivates [[Random Forest|random forests]].

## ⚙️ Core Implementation
### 🔹 Decision tree — "play tennis?"
> [!code]- Mermaid tree + rule
> ```mermaid
> graph TD
>   A[outlook?] -->|sunny| B[humidity?]
>   A -->|overcast| C[yes]
>   A -->|rain| D[wind?]
>   B -->|high| E[no]
>   B -->|normal| F[yes]
>   D -->|strong| G[no]
>   D -->|weak| H[yes]
> ```
> 💡 **Common Mistake:** **Read the tree as OR-of-AND rules** ➔ good day = (Sunny **and** Normal) **or** Overcast **or** (Rain **and** Weak); everything else is a bad day.

### 🔹 Decision tree — high blood pressure (FIT2086)
> [!code]- Mermaid tree + leaf probabilities
> ```mermaid
> graph TD
>   A[Sex?] -->|Male| B["53 / 7 · p = 12%"]
>   A -->|Female| C[Age?]
>   C -->|"Age < 50"| D["3 / 78 · p = 96%"]
>   C -->|"Age ≥ 50"| E["21 / 23 · p = 52%"]
> ```
> - **Leaf label** ➔ $n_0/n_1$ (no / yes) ⟹ $\hat\theta=n_1/(n_0+n_1)$: $7/60\approx12\%$, $78/81\approx96\%$, $23/44\approx52\%$.
> - **Female, 45** ➔ Female ➔ Age $<50$ ➔ $\hat p=96\%$ · **Male, 70** ➔ Male leaf, $\hat p=12\%$ — age is never tested for males.
> 💡 **Common Mistake:** **Reading $53/7$ as the probability** ➔ it is a **count pair**; the leaf probability is $n_1/n$.

## ⚖️ Core Decision Matrix
| Tree | Predicts | Leaf value | FIT2086 leaf model |
| :--- | :--- | :--- | :--- |
| **Decision tree** | category (yes/no, classes) | most common class in region | Bernoulli / categorical, $\hat\theta_\ell=n_1/n$ |
| **Regression tree** | real value | average value in region | Normal, own $\hat\mu_\ell$ and $\hat\sigma^2_\ell$ |

> [!NOTE] **When It Flips:** both trees are built the *same way* (recursively partition the feature space); they differ only in the **leaf rule** — mode for classification, mean for regression.

## 🧠 Active Recall
> [!FAQ]- How does a decision tree differ from a regression tree in what it predicts and how a leaf decides?
> > [!SUCCESS]- Answer
> > - **Short answer:** A decision tree predicts a category (leaf = most common class in the region); a regression tree predicts a real value (leaf = average of the region).
> > - **Why:** **Same partitioning, different leaf** ➔ both recursively split the feature space; only the leaf aggregation changes.

> [!FAQ]- What two decisions define a tree-building algorithm, and name a criterion for each.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) which feature to split on — by purity/information gain (e.g. entropy; ID3/C4.5/CART); (2) when to stop — min samples, max depth, or negligible gain.
> > - **Why:** **Purity + stopping** ➔ splits that best separate classes, halted before they overfit.

> [!FAQ]- Why does a tree capture interactions and non-linearity with no extra columns, when [[Linear Regression (FIT2086)|linear regression]] needs polynomial and product terms?
> > [!SUCCESS]- Answer
> > - **Short answer:** Each leaf fits its own model to its own region, so the prediction is piecewise-constant in $x$ (non-linear), and a split on $x_k$ nested under a split on $x_j$ makes $x_k$'s effect depend on $x_j$ (interaction).
> > - **Why:** **Partition, then fit locally** ➔ $f$ is built from regions $R_1,\dots,R_L$, not from a weighted sum $\beta_0+\sum_j\beta_jx_j$; the cost is inefficiency when the truth **is** linear.

> [!FAQ]- Three trees on the same data score $172.1$, $173.7$, $173.1$. What weakness does this show, and what fixes it?
> > [!SUCCESS]- Answer
> > - **Short answer:** Instability — near-identical goodness of fit from structurally different trees, so the chosen tree depends on small data quirks; a random forest averages many trees to cancel it.
> > - **Why:** **High variance** ➔ single trees are low-bias but high-variance; averaging $q$ randomised trees keeps the low bias and cuts the variance.
