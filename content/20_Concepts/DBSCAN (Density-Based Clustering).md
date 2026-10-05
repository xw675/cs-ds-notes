---
unit: FIT3003
week: 10
source: [slides]
domain: E
parent: "[[Machine Learning Styles (Supervised vs Unsupervised)]]"
tags: [DataScience/ML, DataScience/Modelling]
aliases: [DBSCAN, Density-based Clustering, Core Point, Border Point, MaxDist, MinPts]
---
# [[DBSCAN (Density-Based Clustering)]]

**Context:** [[FIT3003_MOC]] · the density-based alternative to centroid-based [[k-means Clustering]] · run on normalised fact measures in [[Data Analytics for Data Warehousing]]

> [!abstract] Quick Revision
> - **🎯 Objective:** grow each cluster as a **chain of dense neighbourhoods** ➔ $k$ is discovered, not preset; sparse objects become **outliers**.
> - **⚠️ Key Constraint:** the clustering is fixed by **MaxDist** (neighbourhood radius) and **MinPts** (objects needed to count as dense) — not by $k$ or starting seeds.

## 📝 Core
- **Idea** ➔ a cluster is a region of **tight proximity**; chain neighbourhoods from one dense object to the next.
- **MaxDist** ➔ radius of each object's neighbourhood (the circles on slide 44).
- **MinPts** ➔ minimum objects inside that radius for the neighbourhood to be dense.
- **Core point** ➔ dense neighbourhood ➔ extends the chain (blue circles, B–G).
- **Border point** ➔ reached from a core point but not dense itself ➔ joins the cluster, ends the chain (orange, A and H).
- **Outlier** ➔ reached from no core point ➔ in **no** cluster (grey, I).
- **Same 17 patients** *(slide 45)* ➔ k-means returns 3 compact ovals with every patient assigned; DBSCAN returns one long chain across the high-albumin band, two small groups, and the isolated point near $(8.4, 1.9)$ as an outlier.

*(the slides list the five elements without defining them; the core / border / outlier roles are read from the slide-44 circle colours)*

## ⚖️ Core Decision Matrix
| Method | Groups by | Predefined $k$ | Every object clustered? | Outliers | Long neighbourhood chains |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **[[k-means Clustering]]** | coverage around a centroid | required | yes | never | never |
| **DBSCAN** | a specific distance range (MaxDist) | not needed | no | may produce | may produce |

> [!NOTE] **When It Flips:** the number of groups is fixed by the business question ➔ k-means · the number is unknown, or isolated objects must be flagged rather than forced into a group ➔ DBSCAN.

## ⚠️ Common Mistakes
- 💡 **"Every object gets a cluster"** ➔ true of k-means only; DBSCAN can leave objects as outliers.
- 💡 **Skipping normalisation** ➔ MaxDist is one radius in every direction, so a wide-range measure (Glucose) swamps a narrow one (Albumin) exactly as in k-means.

## 🧠 Active Recall
> [!FAQ]- Name the five elements of DBSCAN and say which ones decide whether an object is an outlier.
> > [!SUCCESS]- Answer
> > - **Short answer:** MaxDist, MinPts, core points, border points, outliers; MaxDist and MinPts decide which objects are core, and an object reachable from no core point is an outlier.
> > - **Why:** **Density chain** ➔ only core points extend a cluster, so an object outside every core neighbourhood joins none.

> [!FAQ]- Give two outputs DBSCAN can produce that k-means never can.
> > [!SUCCESS]- Answer
> > - **Short answer:** Outliers (objects in no cluster) and long chain-shaped clusters.
> > - **Why:** **Neighbourhood vs centroid** ➔ k-means assigns every object to its nearest centroid, giving compact regions; DBSCAN links neighbourhood to neighbourhood and drops what it cannot reach.
