---
unit: FIT3003
week: 10
source: [slides]
domain: E
parent: "[[Decision Trees and Regression Trees]]"
tags: [DataScience/ML, DataScience/Modelling, DataScience/DataWarehousing]
aliases: [Classification using Regression Trees, SSR, Sum of Squared Residuals, Regression Tree Split, Root Node Selection]
---
# [[Regression Tree Construction (SSR Splits)]]

**Context:** [[FIT3003_MOC]] · Chapter 21's "classification using regression trees" — the hand build on numerical fact measures · what a regression tree is ➔ [[Decision Trees and Regression Trees]] · FIT2086's likelihood-based growth ➔ [[Decision Tree Learning (Likelihood Splits, Pruning, CV)]]
**Parent Framework:** [[Decision Trees and Regression Trees]]

> [!abstract] Quick Revision
> - **🎯 Objective:** at each node try every attribute at every midpoint threshold ➔ keep the **(attribute, threshold) with lowest SSR** ➔ recurse left, then right ➔ each leaf predicts its partition's **mean** target.
> - **📦 Core Components:** residual $r_i - \bar r$ | SSR of the two partitions | thresholds $=$ midpoints of adjacent distinct values | termination (cohesive enough, or very few objects).
> - **⚠️ Key Constraint:** compare attributes by their **minimum** SSR; the same attribute **may be reused** lower down (Glucose splits twice).

## 📝 How It Works
### 1. The SSR Criterion
- **Residual** ➔ an object's target minus the **average target of its partition**; squared so it is always positive.
- **SSR of a split** ➔ left partition $r_1, \dots, r_n$, right partition $s_1, \dots, s_m$:
$$SSR = \sum_{i=1}^{n}(r_i-\bar r)^2 + \sum_{j=1}^{m}(s_j-\bar s)^2$$
- **Lowest SSR $=$ best split** ➔ large target differences inside a partition $=$ sub-optimal, not cohesive.
- **Candidate thresholds** ➔ midpoints of adjacent **distinct** sorted values ➔ $d$ distinct values give $d-1$ SSRs (Glucose: 16 distinct ➔ 15; Albumin: 13 ➔ 12; the two $155.0$s add no candidate).

### 2. The Build Loop
- **1. Select the root** ➔ per attribute, the min SSR over its thresholds ➔ the smallest min wins; branches $< t$ (left) and $\ge t$ (right).
- **2. Repeat** ➔ (a) left sub-tree, (b) right sub-tree — the same search over that partition's objects, **every** attribute eligible again.
- **3. Finalise** ➔ stop when a partition is **cohesive enough** or holds **very few objects**; leaf $=$ mean target of its objects.
- **Predict / test** ➔ match a test object down the tree; compare its actual target with the leaf value.
- **Grid partitioning** ➔ every split is an axis-parallel line, so the tree tiles measure space into rectangles (root $=$ the vertical line Glucose $= 133.5$).

## ⚙️ Core Implementation
### 🔹 Final tree — 17 emergency patients
> [!code]- Mermaid tree + leaf members
> ```mermaid
> graph TD
>   A["Glucose"] -->|"< 133.5"| B["Albumin"]
>   A -->|"≥ 133.5"| C["Glucose"]
>   B -->|"< 3.4"| D["0.290 · B C J P R"]
>   B -->|"≥ 3.4"| E["0.493 · E G K"]
>   C -->|"< 189"| F["Albumin"]
>   C -->|"≥ 189"| G["0.902 · F M Q"]
>   F -->|"< 4"| H["0.636 · A D I"]
>   F -->|"≥ 4"| I["0.809 · H L N"]
> ```
> 💡 **Common Mistake:** **Reading a leaf as a class** ➔ $0.636$ is the **mean** Mortality Prediction of A, D, I — a number, not a label.

## ⚖️ Core Decision Matrix
| Tree (Chapter 21 framing) | Shape | Attribute and target types | Attribute reuse in a sub-tree | Root choice |
| :--- | :--- | :--- | :--- | :--- |
| **Regression tree** | binary | numerical | allowed | lowest min SSR |
| **Decision tree** | $N$-ary, one branch per category | categorical | not allowed | slides 9–10: three different roots give three valid trees for one Walk dataset |

> [!NOTE] **When It Flips:** numerical measures and a numerical target (the fact-table case) ➔ regression tree; categorical attributes and class labels (Weather, Day ➔ Walk) ➔ decision tree. FIT2086's binary decision trees do not follow this table — it is Chapter 21's contrast.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Table 1.6 — attributes Glucose, Albumin; target Mortality Prediction.

| Step | Partition | Glucose min SSR @ $t$ | Albumin min SSR @ $t$ | Split |
| :--- | :--- | :--- | :--- | :--- |
| 1 Root | all 17 | **0.3622** @ 133.5 (E–N) | 0.7748 @ 3.2 (D–I) | Glucose $< 133.5$ |
| 2a Left | B C E G J K P R | 0.0983 @ 71.2 (R–K) | **0.0923** @ 3.4 (B–K) | Albumin $< 3.4$ ➔ leaves $0.290$, $0.493$ |
| 2b Right | A D F H I L M N Q | **0.129** @ 189 (H–F) | 0.1537 @ 2.6 | Glucose $< 189$ ➔ leaf F M Q $= 0.902$ |
| 3 Right-left | A D H I L N | 0.082 @ 150.45 (N–D) | **0.047** @ 4.0 (A–N) | Albumin $< 4$ ➔ leaves $0.636$, $0.809$ |

### Applied Exercise
**Problem:** verify step 2a's winning SSR — left partition split at Albumin $3.4$.
$$
\begin{aligned}
\text{left } (<3.4)\!: \; & R\,0.1325,\; C\,0.2171,\; B\,0.2200,\; J\,0.3838,\; P\,0.4969 \;\Rightarrow\; \bar r = 0.2901 \\
& \textstyle\sum(r_i-\bar r)^2 = 0.0248+0.0053+0.0049+0.0088+0.0428 = 0.0866 \\
\text{right } (\ge 3.4)\!: \; & K\,0.4500,\; E\,0.4751,\; G\,0.5525 \;\Rightarrow\; \bar s = 0.4925 \\
& \textstyle\sum(s_j-\bar s)^2 = 0.0018+0.0003+0.0036 = 0.0057 \\
SSR &= 0.0866 + 0.0057 = 0.0923
\end{aligned}
$$
**Final Extracted Output:** $0.0923 < 0.0983$ (Glucose's best) ➔ split on Albumin; the partition means $0.290$ and $0.493$ are the two leaf values.

## ⚠️ Common Mistakes
- 💡 **Banning the root attribute below** ➔ that is the decision-tree rule; a regression tree re-splits Glucose at $189$.
- 💡 **Trusting the slide-56 and slide-65 re-sorted tables** ➔ they alter K's and B's targets and shuffle Glucose values; only Table 1.6 reproduces every SSR and leaf (verified by recomputation).

## 🧠 Active Recall
> [!FAQ]- How is the root attribute and its threshold chosen?
> > [!SUCCESS]- Answer
> > - **Short answer:** For each attribute compute the SSR at every midpoint between adjacent distinct values, take its minimum, and pick the attribute whose minimum is lowest — Glucose at $133.5$ ($0.3622 < 0.7748$).
> > - **Why:** **Cohesion** ➔ low SSR means objects inside each partition have similar targets, so the partition mean predicts them well.

> [!FAQ]- When does the build stop, and what does a leaf predict?
> > [!SUCCESS]- Answer
> > - **Short answer:** When a partition is cohesive enough or contains very few objects; the leaf predicts the mean target of its objects.
> > - **Why:** **Mean minimises SSR** ➔ the residuals are measured from the partition average, so the average is the leaf's best single value.
