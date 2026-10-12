---
unit: [FIT1043, FIT2086, FIT3003]
domain: E
week: [7, 10, 11]
parent: "[[Machine Learning Styles (Supervised vs Unsupervised)]]"
tags: [DataScience/Modelling, DataScience/ML]
aliases: [Clustering, k-means, K-means, Centroid, Cluster Assignment, Centroid-based Clustering, Voronoi Diagram, WCSS, within-cluster sum of squares, k-means++, hard clustering]
---
# [[k-means Clustering]]

**Context:** [[FIT1043_MOC]], [[FIT2086_MOC]], [[FIT3003_MOC]] · the flagship **unsupervised** ([[Machine Learning Styles (Supervised vs Unsupervised)|no-label]]) method · groups points by similarity · partitions data into $k$ clusters · density-based rival ➔ [[DBSCAN (Density-Based Clustering)]] · probabilistic, soft-assignment generalisation ➔ [[Mixture Models (EM Algorithm)]] (k-means vs mixture matrix lives there)

> [!abstract] Quick Revision
> - **🎯 Objective:** group unlabelled points into $k$ clusters by similarity ➔ iterate assign ↔ move-centroid until stable ➔ this minimises the **within-cluster sum of squares** $D=\sum_i\min_k d_k(i)^2$.
> - **📦 Core Components:** $k$ = number of clusters | centroid = **mean** of a cluster's points | two repeating steps.
> - **⚡ Key Constraint:** the **initial random centroids** matter — poor initialisation gives volatile, different results and only a **local** minimum of $D$; $k$ must be chosen up front.

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

### 4. Clustering Fact Measures (FIT3003)
- **Partition** ➔ objects are **mutually exclusively** assigned to the predefined clusters; each object goes to its **nearest** centroid.
- **Distance** ➔ Euclidean over $h$ measures: $\text{dist}(x_i, x_j) = \sqrt{\sum_{k=1}^{h}(x_{ik}-x_{jk})^2}$.
- **1-D boundaries** ➔ sorted values split at the **midpoints** $\frac{m_a+m_b}{2}$ of adjacent centroids — no per-point distances needed.
- **Non-uniform units** ➔ Glucose spans $64$–$218$, Albumin $2$–$5$: stretching either axis changes the clusters and the wider measure dominates the distance ➔ **normalise** each measure to a common scale ($0$–$10$) first.
- **2-D boundaries** ➔ a **Voronoi diagram** — each region holds the points nearest one centroid; recompute centroids from members, redraw, repeat.
- **Termination** ➔ stop when **no member moves** between clusters (a centroid can shift while its members stay put: $200 \to 205.33$).

### 5. The Objective & Convergence (FIT2086)
- **Data** ➔ $n$ items, each a point $\mathbf{y}_i$ in $q$-dimensional space; $d_k(i)$ = distance from $\mathbf{y}_i$ to centroid $\boldsymbol\mu_k$.
- **Objective** ➔ $D(\boldsymbol\mu_1,\dots,\boldsymbol\mu_K)=\sum_{i=1}^{n}\min_k\big\{d_k(i)^2\big\}$ ➔ squared distance of every point to its **nearest** centroid = total within-cluster sum of squares (WCSS).
- **Algorithm in this notation** ➔ initialise $\boldsymbol\mu_1,\dots,\boldsymbol\mu_K$ randomly ➔ loop: compute every $d_k(i)$ · assign to the closest centroid · re-estimate each $\boldsymbol\mu_k$ from its points ➔ until convergence.
- **Converges quickly to a stable solution** ➔ but possibly a **local** minimum, not the lowest possible WCSS; sensitive to starting points.
- **k-means++** ➔ choose each new starting centre at random with probability **proportional to its squared distance from the nearest centre already chosen** ⟹ seeds spread out ⟹ convergence improves dramatically.

### 6. Other Distances & Limitations (FIT2086)
- **Alternative similarity measures** ➔ weighted Euclidean · "cityblock" ($\sum_j\lvert y_{i,j}-y_{i',j}\rvert$) · Hamming (pure binary data) · many more.
- **Limitations** ➔ **hard** classification of items to clusters · mixed continuous/discrete attributes are difficult · **no explicit statistical interpretation** · no principled way to choose $K$ from the data alone ⟹ [[Mixture Models (EM Algorithm)|mixture modelling]] is the flexible alternative.

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

### Applied Exercise (FIT3003 — 1-D Glucose, $k=3$)
**Problem:** $D = \{162, 93, 68, 154, 121, 198, 99, 180, 169, 64, 72, 154, 218, 145, 70, 91, 200\}$, initial $m_1 = 162$, $m_2 = 169$, $m_3 = 200$.

| Step | $m_1, m_2, m_3$ | Boundaries | Cluster 1 | Cluster 2 | Cluster 3 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | $162, 169, 200$ | $165.5$, $184.5$ | 64 68 70 72 91 93 99 121 145 154 154 162 ($n=12$, $\Sigma=1293$) | 169 180 ($\Sigma=349$) | 198 200 218 ($\Sigma=616$) |
| 2 | $107.75, 174.5, 205.33$ | $141.13$, $189.92$ | 64 … 121 ($n=8$, $\Sigma=678$) | 145 154 154 162 169 180 ($\Sigma=964$) | unchanged |
| 3 | $84.75, 160.67, 205.33$ | $122.71$, $183$ | unchanged | unchanged | unchanged ➔ **stop** |

**Final Extracted Output:** $\{64 \dots 121\}$, $\{145 \dots 180\}$, $\{198, 200, 218\}$ with centroids $84.75$, $160.67$, $205.33$.

### Applied Exercise (FIT2086 — 2-D height/weight, $K=2$)
**Problem:** $A(185,72)$, $B(170,56)$, $C(168,60)$, $D(179,68)$, $E(182,72)$ (cm, kg); seeds $\boldsymbol\mu_1=A$, $\boldsymbol\mu_2=B$.

| Point | $d_1$ to $(185,72)$ | $d_2$ to $(170,56)$ | Iter 1 | $d_1$ to $(182,70.67)$ | $d_2$ to $(169,58)$ | Iter 2 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| $A$ | $0$ | $21.93$ | 1 | $3.28$ | $21.26$ | 1 |
| $B$ | $21.93$ | $0$ | 2 | $18.95$ | $2.24$ | 2 |
| $C$ | $20.81$ | $4.47$ | 2 | $17.60$ | $2.24$ | 2 |
| $D$ | $7.21$ | $15.00$ | 1 | $4.01$ | $14.14$ | 1 |
| $E$ | $3.00$ | $20.00$ | 1 | $1.33$ | $19.10$ | 1 |

- **Re-centre after iter 1** ➔ $\boldsymbol\mu_1=\big(\tfrac{185+179+182}{3},\tfrac{72+68+72}{3}\big)=(182,70.67)$ · $\boldsymbol\mu_2=(169,58)$.
- **WCSS** ➔ $81$ at the seeds ➔ $38.67$ after one update; iter 2 reassigns nobody ⟹ means unchanged ⟹ **stop**.

**Final Extracted Output:** Cluster 1 $=\{A,D,E\}$ at $(182,70.67)$, Cluster 2 $=\{B,C\}$ at $(169,58)$.

## ⚠️ Common Mistakes
- 💡 **Different seeds → different clusters** ➔ random initialisation is volatile and converges to a **local** minimum of WCSS; rerun from several seeds or use **k-means++**.
- 💡 **Clustering raw, unnormalised measures** ➔ the wide-range measure decides every assignment; normalise first (FIT3003 Glucose vs Albumin).
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

> [!FAQ]- Centroids $\boldsymbol\mu_1=(0,0)$, $\boldsymbol\mu_2=(3,4)$. Which cluster gets $\mathbf{y}=(1,1)$? (FIT2086 lecture Q1)
> > [!SUCCESS]- Answer
> > - **Short answer:** cluster 1 — squared distances $\lVert\mathbf{y}-\boldsymbol\mu_1\rVert^2=2$ vs $\lVert\mathbf{y}-\boldsymbol\mu_2\rVert^2=4+9=13$.
> > - **Why:** **Hard assignment** ➔ the point goes wholly to the nearer centroid; a mixture model would instead report a probability for each class.

> [!FAQ]- What does k-means minimise, and why can "converged" still be a bad answer?
> > [!SUCCESS]- Answer
> > - **Short answer:** the within-cluster sum of squares $D=\sum_i\min_k d_k(i)^2$; the algorithm stops at a stable solution, which may be a **local** minimum determined by the seeds.
> > - **Why:** **Non-convex objective** ➔ different seeds lead to different stable partitions; k-means++ spreads the seeds (probability $\propto$ squared distance to the nearest chosen centre) to reach better minima.
