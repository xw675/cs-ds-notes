---
unit: FIT2086
week: 11
source: [lecture]
domain: E
parent: "[[Machine Learning Styles (Supervised vs Unsupervised)]]"
tags: [DataScience/Modelling, DataScience/ML, DataScience/DataQuality]
aliases: [missing data, missing-data imputation, imputation, kNN imputation, collaborative filtering, recommender system, recommender systems, matrix completion, Netflix challenge, univariate imputation]
---
# [[Missing Data Imputation and Recommender Systems]]

**Context:** [[FIT2086_MOC]] · W11 · unsupervised learning used to **fill holes** in a data matrix · reuses [[k-Nearest Neighbours]] with no target column · multivariate route via the [[Multivariate Normal Distribution]] and [[Mixture Models (EM Algorithm)]] · FIT1043's wrangling view of the same problem ➔ [[Data Quality Problems]]
**Parent Framework:** [[Machine Learning Styles (Supervised vs Unsupervised)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a matrix $\mathbf{Y}$ (rows = individuals, columns = attributes) with unmeasured entries ➔ estimate each missing entry from **relationships between observed attributes** ➔ a complete matrix for supervised learning, or predicted ratings to recommend from.
> - **📦 Core Components:** univariate ➔ column mean/median/mode | multivariate normal ➔ correlations, one cluster | mixture ➔ several clusters | kNN / collaborative filtering ➔ copy from the most similar rows.
> - **⚡ Key Constraint:** in kNN imputation the distance uses **only columns both rows observed** — a row sharing no observed column with the target cannot be compared at all.

## 📝 How It Works
### 1. Two Applications
- **Imputation for supervised learning** ➔ many methods need complete predictor values; filling the gaps lets the whole matrix be used (Pima: $12\%$ of exposure cells missing, insulin $48.7\%$).
- **Recommender systems** ➔ rows = people, columns = products, entries = ratings or purchases; nearly every cell is missing ➔ estimate the missing ratings and recommend the highest (Netflix challenge).

### 2. Univariate Imputation
- **Rule** ➔ fit a model per column ➔ replace its missing entries with a statistic: mean/median (numeric), mode (categorical).
- **Trade-off** ➔ very fast, but **ignores relationships between variables** — a tall person's missing weight gets the population average.

### 3. Multivariate Normal Imputation
- **Rule** ➔ model the columns jointly with correlations $\boldsymbol\Sigma$ ➔ estimate a missing entry from the correlated observed entries in its row.
- **Limit** ➔ assumes the data form **one single cluster**; [[Mixture Models (EM Algorithm)|mixture modelling]] extends it to several.

### 4. kNN Imputation (Collaborative Filtering)
- **Distance on co-observed columns** ➔ $d(i,i')=\Big[\sum_{j\,\in\,\text{obs}(i)\cap\text{obs}(i')}(y_{i,j}-y_{i',j})^2\Big]^{1/2}$ — missing values are ignored.
- **Per column** ➔ for $j=1,\dots,p$, predict each missing $y_{i,j}$ from the $k$ nearest rows that **did** observe column $j$, using all other columns as explanatory variables ➔ the kNN vote/average of [[k-Nearest Neighbours]].
- **Tuning** ➔ choose $k$ by [[Cross-Validation]].
- **Assumption** ➔ individuals similar on observed attributes are similar on the missing one — very weak, no distribution.

## ⚖️ Core Decision Matrix
| Method | Uses relationships? | Assumption | Cost | Reach for it when |
| :--- | :--- | :--- | :--- | :--- |
| **Univariate** (mean/median/mode) | no | none beyond the column | very fast | few gaps, or a quick baseline |
| **Multivariate normal** | yes, linear correlations | one Gaussian cluster | estimate $\boldsymbol\mu,\boldsymbol\Sigma$ | numeric columns, roughly elliptical data |
| **Mixture model** | yes, per cluster | data form several clusters | EM + choose $K$ | distinct sub-populations (Pima) |
| **kNN** | yes, by similarity | similar rows ⟹ similar values | distances at prediction time | ratings matrices, mixed or non-linear structure |

> [!NOTE] **When It Flips:** once the columns are correlated, univariate imputation throws information away; once the data split into clusters, one multivariate normal averages across them — move down the table as structure grows.

## 📊 Exam Execution Trace & Applied Exercises
### Manual Execution Trace
Lecture Netflix example, $k=1$ — fill User 3's *Love Actually* (`–` = unrated).

| User | Terminator | Love Actually | Aliens | Predator | Bridesmaids |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | $2$ | $4$ | $2$ | $1$ | $5$ |
| 2 | $4$ | $1$ | $5$ | $4$ | $1$ |
| 3 | $4$ | **?** | $4$ | – | – |
| 4 | – | $4$ | – | – | – |

| Step | Candidate | Co-observed with User 3 | Distance | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| 1 | User 1 | Terminator, Aliens | $\sqrt{(4-2)^2+(4-2)^2}=\sqrt8=2.83$ | — |
| 2 | User 2 | Terminator, Aliens | $\sqrt{(4-4)^2+(4-5)^2}=1$ | **nearest** |
| 3 | User 4 | none | undefined | cannot compare |
| 4 | copy | User 2's *Love Actually* | — | **? ➔ $1$** |

### Applied Exercise
**Problem:** same table, $k=1$. Impute User 4's *Terminator*.
$$
\begin{aligned}
\text{co-observed with User 4} &: \text{Love Actually only (User 3 hasn't rated it ➔ excluded)} \\
d(4,1) &= \sqrt{(4-4)^2} = 0,\qquad d(4,2)=\sqrt{(4-1)^2}=3 \\
\text{nearest} &= \text{User 1} \ \Rightarrow\ \text{Terminator} = 2
\end{aligned}
$$
**Final Extracted Output:** User 4's Terminator $\mapsto2$ — a single shared rating decides everything, which is why $k$ is tuned and more overlap gives better imputations.

## ⚠️ Common Mistakes
- 💡 **Counting a missing cell as $0$ in the distance** ➔ treats "unrated" as "rated zero"; drop the column from the comparison instead.
- 💡 **Using a neighbour that also lacks the target column** ➔ it has nothing to copy; only rows that observed column $j$ are candidates.
- 💡 **Mean imputation on correlated data** ➔ shrinks variance and breaks the relationships a later regression needs.

## 🧠 Active Recall
> [!FAQ]- Why is filling a ratings matrix "unsupervised" when kNN was a supervised method in W9?
> > [!SUCCESS]- Answer
> > - **Short answer:** no column is nominated as the target — each column takes a turn as the thing being predicted from all the others, so the method models structure in the joint data rather than one $p(Y\mid X)$.
> > - **Why:** **Column-by-column kNN** ➔ the same neighbour logic, applied to whichever entry is missing; that rotation is collaborative filtering.

> [!FAQ]- When would multivariate-normal imputation do worse than kNN imputation?
> > [!SUCCESS]- Answer
> > - **Short answer:** when the data are not one elliptical cluster — several sub-populations or non-linear structure; the single $\boldsymbol\Sigma$ averages across clusters, while kNN copies from genuinely similar rows.
> > - **Why:** **One-cluster assumption** ➔ the MVN estimate is a linear prediction from correlations; a mixture model or kNN relaxes it.
