---
unit: FIT1043
week: 7
parent: "[[Predictive Models]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Decision Tree, Regression Tree, Recursive Partitioning, Information Gain]
---
# [[Decision Trees and Regression Trees]]

**Context:** [[FIT1043_MOC]] · a [[Predictive Models|predictive model]] you can read as rules · splits the feature space into regions · the building block of a [[Random Forest]]

> [!abstract] Quick Revision
> - **🎯 Objective:** classify or predict by walking a tree of feature tests ➔ decision tree = categorical, regression tree = real value.
> - **📦 Core Components:** recursive partitioning | leaf prediction (mode vs mean) | split criterion (purity/info gain).
> - **⚡ Key Constraint:** the algorithm's choices — **which feature to split on** (purity/information gain) and **when to stop** — determine the tree.

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

## ⚖️ Core Decision Matrix
| Tree | Predicts | Leaf value |
| :--- | :--- | :--- |
| **Decision tree** | category (yes/no, classes) | most common class in region |
| **Regression tree** | real value | average value in region |

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
