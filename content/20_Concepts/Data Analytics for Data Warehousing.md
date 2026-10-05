---
unit: FIT3003
week: 10
source: [slides]
domain: [E, C]
parent: "[[Data Warehouse]]"
tags: [DataScience/DataWarehousing, DataScience/ML]
aliases: [Data Analytics for DW, Chapter 21, Traditional Data Mining, Descriptive Mining, Predictive Mining, Data Mining]
---
# [[Data Analytics for Data Warehousing]]

**Context:** [[FIT3003_MOC]] · the step after [[OLAP (On-Line Analytical Processing)|OLAP]] ➔ model the **numerical fact measures** of a [[Star Schema]] rather than summarise them · three techniques: regression ([[Linear and Polynomial Regression]], [[Linear Regression in SQL]]), clustering ([[k-means Clustering]], [[DBSCAN (Density-Based Clustering)]]), classification ([[Regression Tree Construction (SSR Splits)]])

> [!abstract] Quick Revision
> - **🎯 Objective:** traditional data mining assumes **categorical** items and labels; a fact table holds **numerical** measures ➔ adapt: regression, clustering, regression-tree classification.
> - **⚠️ Key Constraint:** name **which fact-table columns** each technique consumes — regression pairs a **timestamp dimension** (or a second measure) with one measure; clustering and classification use **only the measure columns**.

## 📝 Core
- **Traditional data mining** ➔ discovers patterns, correlations and knowledge in input data — association rules, sequential patterns, classification, clustering — each **requiring a specific data structure**.
- **Descriptive vs predictive** ➔ descriptive summarises the data's properties and correlations (association rules) · predictive builds a model from available data to predict new data (decision-tree classification).
- **Association rules misfit a star** ➔ (1) need **unnormalised** data — an item basket per transaction · (2) **no numerical fact measure** · (3) **one dimension** — the item.
- **Rule confidence** *(slide basket)* ➔ $\text{Bread} \to \text{Cereal} = 75\%$: 3 of the 4 bread baskets hold cereal · $\text{Cereal} \to \text{Bread} = 100\%$: all 3 cereal baskets hold bread ➔ a rule is **directional**.
- **Decision trees misfit a star** ➔ (1) need **categorical** attributes, fact measures are numerical · (2) the **target class is categorical**, the warehouse target is a number.
- **Warehouse analytics** ➔ analysis of the star's numerical fact measures; dimensions supply only the context (timestamp, grouping).

## ⚖️ Core Decision Matrix
| Technique | Fact-table columns used | Target | Output | Depth |
| :--- | :--- | :--- | :--- | :--- |
| **Regression — time series** | timestamp dimension as $x$ $+$ one measure as $y$ | the measure itself | trend line/curve; forecast | [[Linear and Polynomial Regression]] · [[Linear Regression in SQL]] |
| **Regression — non-time-series** | two measures (Glucose ➔ Albumin) | the second measure | trend line; near-line new data $=$ high accuracy | [[Linear and Polynomial Regression]] |
| **Centroid clustering** | measures only, normalised | none — unsupervised | $k$ disjoint clusters, every object assigned | [[k-means Clustering]] |
| **Density clustering** | measures only, normalised | none — unsupervised | clusters $+$ **outliers**, $k$ not preset | [[DBSCAN (Density-Based Clustering)]] |
| **Regression-tree classification** | measures as attributes | a numerical measure, from a training set | binary tree; leaf $=$ mean target | [[Regression Tree Construction (SSR Splits)]] |

> [!NOTE] **When It Flips:** a **timestamp** on the $x$-axis ➔ time-series regression · a known **numerical target** ➔ regression tree · **no target** ➔ clustering, DBSCAN when $k$ is unknown or outliers matter.

## ⚠️ Common Mistakes
- 💡 **Proposing association rules for a fact table** ➔ the fact holds measures, not item baskets; cite the three issues instead.
- 💡 **"Classification" means decision tree** ➔ not in Chapter 21: attributes **and** target are numerical, so it classifies with a **regression tree**.

## 🧠 Active Recall
> [!FAQ]- Why can't a classic decision tree run directly on a warehouse fact table, and what replaces it?
> > [!SUCCESS]- Answer
> > - **Short answer:** It needs categorical attributes and a categorical target class, but fact measures and the warehouse target are numerical — a regression tree replaces it.
> > - **Why:** **Numeric splits** ➔ a regression tree cuts a measure at the threshold with lowest SSR and predicts each partition's mean.

> [!FAQ]- Which fact-table columns feed time-series regression, and which feed clustering?
> > [!SUCCESS]- Answer
> > - **Short answer:** Time-series regression takes the timestamp dimension as $x$ and one measure as $y$; clustering and classification take the measure columns only.
> > - **Why:** **Figures 1.5 vs 1.6** ➔ regression needs an ordering axis; clustering measures distance between rows in measure space.
