---
unit: FIT1043
week: 7
parent: "[[Machine Learning Styles (Supervised vs Unsupervised)]]"
tags: [DataScience/Modelling, ML/Clustering, Monash/CS_DS]
aliases: [Clustering, k-means, Centroid, Cluster Assignment]
---
# [[k-means Clustering]]

**Context:** [[FIT1043_MOC]] · the flagship **unsupervised** ([[Machine Learning Styles (Supervised vs Unsupervised)|no-label]]) method · groups points by similarity · partitions data into $k$ clusters

> [!abstract] Quick Revision
> - **🎯 Objective:** group unlabelled points into $k$ clusters by similarity ➔ iterate assign ↔ move-centroid until stable.
> - **📦 Core Components:** $k$ = number of clusters | centroid = **mean** of a cluster's points | two repeating steps.
> - **⚡ Key Constraint:** the **initial random centroids** matter — poor initialisation gives volatile, different results; $k$ must be chosen up front.

## 📝 How It Works
### 1. Basics
- **Clustering** ➔ grouping a set of data points into subgroups (**clusters**) based on **similarity** (unsupervised; e.g. T-shirt sizes S/M/L ⇒ $k=3$).
- **$k$** ➔ the number of clusters (chosen before running).
- **Centroid** ➔ the **mean (average) location** of all points in a cluster.

### 2. The Two Iterative Steps
- **1. Cluster assignment** ➔ assign each point to its **nearest centroid**.
- **2. Move centroid** ➔ move each centroid to the **mean** of the points now assigned to it.
- **Stop** ➔ **repeat until no change** (assignments/centroids stabilise).

### 3. Initialisation & Choosing $k$
- **Random init** ➔ pick $k$ random data points as starting centroids; **highly volatile** — poorly positioned seeds give poor/different clusterings.
- **Choosing $k$** ➔ **a priori** domain knowledge ($k=2$ two kinds of people; $k=5$ bacteria types; $k=3$ T-shirt sizes); **search** (try several $k$, evaluate quality); or run **hierarchical clustering** on a subset.

## 📊 Exam Execution Trace

### Manual Execution Trace
k-means with $k=2$:

| Step / State | Action | Result |
| :--- | :--- | :--- |
| **0 (Init)** | pick 2 random centroids | seeds placed |
| 1 | cluster assignment | each point → nearest centroid |
| 2 | move centroid | centroids → mean of their points |
| 3 | reassign + move | some points switch clusters |
| 4 | repeat | **no change** ⇒ converged |

**Final Extracted Output:** $k$ stable clusters, each summarised by its centroid (the mean of its members).

## ⚠️ Common Mistakes
- 💡 **Different seeds → different clusters** ➔ random initialisation is volatile; run multiple times or seed carefully.
- 💡 **You must pick $k$** ➔ k-means can't discover the number of clusters; use domain knowledge or search over $k$.

## 🧠 Active Recall
> [!FAQ]- State the two iterative steps of k-means and its stopping condition.
> - **Hint:** Assign then re-centre.
> > [!SUCCESS]- Answer
> > - **Short answer:** (1) Cluster assignment — assign each point to the nearest centroid; (2) Move centroid — set each centroid to the mean of its assigned points; repeat **until no change**.
> > - **Why:** **Centroid = mean** ➔ each pass lowers within-cluster distance until assignments stabilise.

> [!FAQ]- Why does the initial choice of centroids matter, and how do you choose $k$?
> - **Hint:** Volatile init + preset k.
> > [!SUCCESS]- Answer
> > - **Short answer:** Random seeds are volatile and can converge to poor clusterings; choose $k$ from domain knowledge, by searching over values, or via hierarchical clustering on a subset.
> > - **Why:** **Seed sensitivity** ➔ k-means finds a local solution, so starting points shape the outcome.
