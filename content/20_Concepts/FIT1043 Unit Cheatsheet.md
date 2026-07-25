---
unit: FIT1043
parent: "[[FIT1043_MOC]]"
tags: [DataScience/Foundations, DataScience/ML]
type: cheatsheet
aliases: [FIT1043 Exam Crib, Data Science Cheatsheet]
---
# [[FIT1043 Unit Cheatsheet]]

**Context:** [[FIT1043_MOC]] · the CONCEPT half of the unit in one re-read — lifecycle → data → models → big data → ethics. The CODE half lives in the pinned toolkits: [[Pandas Toolkit (Cheatsheet)]] · [[Sklearn Workflow (Cheatsheet)]] · [[R Toolkit (Cheatsheet)]] · [[Shell Toolkit (Cheatsheet)]] — re-read those separately pre-exam.

> [!abstract] Quick Revision
> - **🎯 Objective:** exam answers = definition + the DISCRIMINATOR ➔ which role/model/metric/engine, and the one criterion that decides.
> - **⚡ Key Constraint:** evaluation discipline — unseen test data, metric matched to error cost, correlation ≠ causation; most written marks hang on these three.

## 1️⃣ Lifecycle, Roles, Business
- **Data science** ➔ extraction of knowledge/value from data — lifecycle-wide, not "ML on big data". **Danger zone** = skills + domain but NO maths/stats ⟹ plausible analysis without rigour.
- **Value chain (ordered)** ➔ Collection → Engineering → Governance → Wrangling → Analysis → Visualisation → Operationalise; a data scientist is familiar with MOST stages, expert in few.
- **Three roles by primary output** ➔ analyst = insights · scientist = models/products ("better at stats than a software engineer, better at SE than a statistician") · engineer = infrastructure.
- **Management vs governance (the exam split)** ➔ management = INTERNAL data lifecycle; governance = EXTERNAL usage/value + legal/ethical.
- **Data sources** ➔ open data must be **machine-readable AND publicly available**; Linked Open Data adds value by connecting datasets; APIs = code-facing interfaces, consumer↔provider + key. [[Metadata]] must be machine-processable to enable discovery.
- **Business models** ➔ only FOUR are data-unique; most DS firms reuse traditional IT models (SaaS/consulting).

## 2️⃣ Data: Types, Stats, Charts
- **Type first, everything follows** ➔ numeric (discrete/continuous) vs categorical (nominal/ordinal) — this classification picks the chart AND the statistic.

| Question | Numeric | Categorical |
| :-- | :-- | :-- |
| distribution | histogram / boxplot | bar / pie / frequency table |
| centre | mean (outlier-dragged) vs median (resistant) — the gap reveals **skew** | mode |
| spread | SD (sensitive) vs **IQR (robust)** → boxplot outlier rule | — |
| association | Pearson $r$ — **linear only**; $r \approx 0$ can hide non-linear structure | crosstab / grouped bars |

- **Visualisation is preliminary** ➔ gives a "feel", limited to ~2 dimensions on a flat screen; never the analysis itself.
- **Wrangling** ➔ raw → tidy is the biggest time cost; quality fixes (impute vs remove, keep vs drop an outlier) are **judgement + justification**, not rules.

## 3️⃣ Models & Evaluation
- **Style decider** ➔ "is the data labelled?" — supervised (predict $y$ from $x$: classification = categorical, regression = real) vs unsupervised (find structure: clustering).
- **Regression** ➔ parameters minimise loss (MSE = mean squared residuals) over training pairs — not "through every point". FIT1043 fits with scipy `linregress` (5 return values), NOT sklearn.
- **Decision tree** ➔ walk feature tests; algorithm = which feature to split (purity/information gain) + when to stop. **Random forest** ➔ each tree sees a random data/feature slice ⟹ errors uncorrelated ⟹ cancel on aggregation — "random" IS the point. [[Ensemble Models]] model the variability across plausible fits.
- **k-means** ➔ iterate assign ↔ move-centroid until stable; $k$ chosen up front; **initial centroids drive volatility**.
- **Evaluation** ➔ ONLY unseen test data counts (training performance = memorisation). Confusion matrix (rows actual, cols predicted) → derive the metric from **which error is worse**: spam filter wants precision, disease screen wants recall; accuracy misleads on imbalance (95% on a 95/5 split = majority baseline).
- **Theory trio** ➔ [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]: can't minimise both — complexity trades bias for variance · **loss ≠ error**: error is a distance, the loss function decides its penalty · [[No Free Lunch Theorem]]: no universally best algorithm, match to the problem.

## 4️⃣ Big Data
- **The Vs** ➔ Volume, Velocity, Variety = data too big/fast/varied for an RDBMS; the two core failures are **ingest** fast enough and **query** fast enough.
- **Growth laws** ➔ Moore (transistors double) is primary; Koomey (efficiency) and Bell (new device classes) are its corollaries; Zimmerman (surveillance/data grows).
- **SQL vs NoSQL** ➔ decided by schema rigidity + scaling direction: structured/stable → SQL, vertical scaling; large/unstructured/fast-changing → NoSQL, horizontal.
- **Map-Reduce** ➔ data-parallel map, then reduce/merge — works ONLY when chunks are independent. **Hadoop** = cheap disk-based batch; **Spark** = in-memory ⟹ fast + real-time/streaming.
- **Shell for scale** ➔ pipe `|` is buffered, line-at-a-time ⟹ memory bounded past RAM; `>` overwrites a file, `|` feeds a program ([[Shell Toolkit (Cheatsheet)]]).

## 5️⃣ Ethics, Privacy, Compliance
- **Three protections** ➔ privacy (control of self) · confidentiality (info about you) · security (protecting the data). The sneaky threat = **implicit data** — traits INFERRED, not given (pregnancy from purchases).
- **Regulation** ➔ ethics enforced via compliance; **GDPR stricter than PDPA** — 72-hour breach notification, penalties to 4% global turnover / €20M.
- **Impact** ➔ every datafication benefit carries an ethics/privacy counter-cost — personal agents AND surveillance ride the same data.

## ⚠️ Top Cross-Unit Traps
- 💡 **Correlation ≠ causation** ➔ and Pearson $r$ is linear-only — two separate caveats, cite both.
- 💡 **Test-set discipline** ➔ split FIRST; fit scaler on train only; any statistic learned from test rows is leakage.
- 💡 **Metric by cost, not habit** ➔ never answer "accuracy" without checking class balance and error asymmetry.
- 💡 **Management vs governance** ➔ internal lifecycle vs external usage/value — the definition pair examiners recycle.
- 💡 **Hadoop ≠ Spark** ➔ disk-between-steps batch vs in-memory streaming — one line each, keep them apart.
