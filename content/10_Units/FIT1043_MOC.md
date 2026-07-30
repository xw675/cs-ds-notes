---
unit: FIT1043
type: MOC
tags:
  - 2025/S2
---
# 📘 FIT1043: Introduction to Data Science

> [!INFO] Map of Content
> Index for **FIT1043 Introduction to Data Science**. Start with [[Data Science]].

## 📊 Assessment Map

- **Written Assignment (40%)** ➔ applied wrangling/analysis — the 🧰 cheatsheets + 🧪 pattern notes are the working surface.
- **Test (10%)** + **Examination (50%)** ➔ concept-explainable material: lifecycle, models, Big Data, ethics (Weeks 1–11 LOs below).

## 🧰 Toolkit Cheatsheets
- 📌 [[FIT1043 Unit Cheatsheet]] — the CONCEPT half; pairs with the code toolkits below
- [[Pandas Toolkit (Cheatsheet)]] -> integrates Weeks 3–4: audit → clean → groupby/agg → plot
- [[Sklearn Workflow (Cheatsheet)]] -> integrates Weeks 6–7: one estimator skeleton + metrics
- [[R Toolkit (Cheatsheet)]] -> integrates Week 8: syntax → data frames → plots → lm
- [[Shell Toolkit (Cheatsheet)]] -> integrates Weeks 9–10: navigate → inspect → grep/sort/cut/awk → pipes → shell→R handoff *(tri-unit — FIT2014 adds `sed`/`tr`/regex, FIT2109 adds permissions/streams/exit status)*

## 📅 Knowledge Index

### Week 1 — Data Science & the Data Science Process
- [[Data Science]] -> Parent Framework: [[Data Science Process (Standard Value Chain)]]
- [[Machine Learning]] -> Parent Framework: [[Data Science]]
- [[Data Science Process (Standard Value Chain)]] -> Parent Framework: [[Data Science]]
- [[Data Science vs Related Disciplines]] -> Parent Framework: [[Data Science]]

### Week 2 — Roles & Skills, Impact, Business Models, Python
- [[Data Scientist Roles and Skills]] -> Parent Framework: [[Data Science vs Related Disciplines]]
- [[Impact of Data Science]] -> Parent Framework: [[Data Science]]
- [[Data Business Models]] -> Parent Framework: [[Data Science]]
- [[Python for Data Science]] -> Parent Framework: [[Data Science]]

### Week 3 — Data Sources & Data Wrangling
- [[Data Sources and Open Data]] -> Parent Framework: [[Data Science Process (Standard Value Chain)]]
- [[APIs for Data Collection]] -> Parent Framework: [[Data Sources and Open Data]]
- [[Data Wrangling]] -> Parent Framework: [[Data Science Process (Standard Value Chain)]]
- [[Data Quality Problems]] -> Parent Framework: [[Data Wrangling]]
- [[Data Auditing in Pandas]] -> Parent Framework: [[Data Wrangling]]

### Week 4 — Visualisation, Descriptive Statistics & Aggregation
- [[Types of Data (Numeric and Categorical)]] -> Parent Framework: [[Data Science Process (Standard Value Chain)]]
- [[Data Visualisation (Chart Types)]] -> Parent Framework: [[Types of Data (Numeric and Categorical)]]
- [[Measures of Centrality]] -> Parent Framework: [[Types of Data (Numeric and Categorical)]]
- [[Measures of Spread and Boxplots]] -> Parent Framework: [[Measures of Centrality]]
- [[Association Between Variables]] -> Parent Framework: [[Measures of Centrality]]
- [[Groupby-Aggregate Pipeline (Pandas)]] -> Parent Framework: [[Python for Data Science]]
- [[Plotting with Matplotlib (Pandas)]] -> Parent Framework: [[Data Visualisation (Chart Types)]]

### Week 5 — Models & Machine Learning
- [[Predictive Models]] -> Parent Framework: [[Data Science Process (Standard Value Chain)]]
- [[Machine Learning Styles (Supervised vs Unsupervised)]] -> Parent Framework: [[Machine Learning]]
- [[Learning Theory and Loss Functions]] -> Parent Framework: [[Machine Learning]]
- [[Linear and Polynomial Regression]] -> Parent Framework: [[Machine Learning Styles (Supervised vs Unsupervised)]]
- [[Machine Learning]] -> Parent Framework: [[Data Science]] *(extended in Week 5: development workflow, Wikipedia/Emerj definitions)*

### Week 6 — Regression Analysis (Fitting, Bias–Variance, Ensembles)
- [[Linear and Polynomial Regression]] -> Parent Framework: [[Machine Learning Styles (Supervised vs Unsupervised)]] *(extended in Week 6: terminology, MSE, when-to-use)*
- [[Bias-Variance Tradeoff (Underfitting vs Overfitting)]] -> Parent Framework: [[Linear and Polynomial Regression]]
- [[No Free Lunch Theorem]] -> Parent Framework: [[Machine Learning]]
- [[Ensemble Models]] -> Parent Framework: [[Machine Learning]]

### Week 7 — Classification & Clustering
- [[Classification Evaluation (Confusion Matrix and Metrics)]] -> Parent Framework: [[Predictive Models]]
- [[Decision Trees and Regression Trees]] -> Parent Framework: [[Predictive Models]]
- [[Random Forest]] -> Parent Framework: [[Ensemble Models]]
- [[k-means Clustering]] -> Parent Framework: [[Machine Learning Styles (Supervised vs Unsupervised)]]

### Week 8 — Introduction to R
- [[R for Data Science]] -> Parent Framework: [[Data Science]]
- [[R Basics (Syntax, Types, Control Flow)]] -> Parent Framework: [[R for Data Science]]
- [[R Vectors]] -> Parent Framework: [[R Basics (Syntax, Types, Control Flow)]]
- [[R Data Frames and IO]] -> Parent Framework: [[R Vectors]]
- [[R Visualisation (base graphics)]] -> Parent Framework: [[R for Data Science]]
- [[R Modelling (lm and Decision Trees)]] -> Parent Framework: [[R for Data Science]]

### Week 9 — Characterising & Big Data + Unix Shell
- [[Big Data and the Vs]] -> Parent Framework: [[Relational Model]] *(shared with FIT2094; extended with Laney's V-taxonomy)*
- [[Metadata]] -> Parent Framework: [[Data Sources and Open Data]]
- [[Growth Laws (Moore, Koomey, Bell, Zimmerman)]] -> Parent Framework: [[Big Data and the Vs]]
- [[Unix Shell (Bash)]] -> Parent Framework: [[Data Wrangling]]

### Week 10 — Databases & Big Data Processing
- [[SQL vs NoSQL Databases]] -> Parent Framework: [[Big Data and the Vs]]
- [[Distributed Processing and Map-Reduce]] -> Parent Framework: [[Big Data and the Vs]]
- [[Hadoop and Spark]] -> Parent Framework: [[Distributed Processing and Map-Reduce]]

### Week 11 — Data Management & Data Governance
- [[Data Management and Data Governance]] -> Parent Framework: [[Data Science Process (Standard Value Chain)]]
- [[Privacy, Confidentiality, and Security]] -> Parent Framework: [[Data Management and Data Governance]]
- [[Data Compliance and Regulations (PDPA, GDPR)]] -> Parent Framework: [[Data Management and Data Governance]]

### 🧪 Applied / Lab Pattern Notes (code)
*(Lab notebooks & solutions live in `30_Projects/FIT1043_Labs/`; these notes store the reusable patterns.)*
- [[Python Basics (Syntax, Types, Control Flow)]] -> Parent Framework: [[Python for Data Science]] *(Week 1)*
- [[Pandas DataFrame Basics]] -> Parent Framework: [[Python for Data Science]] *(Weeks 2 & 4)*
- [[Groupby-Aggregate Pipeline (Pandas)]] -> Parent Framework: [[Python for Data Science]] *(Week 3; multi-index flatten)*
- [[Plotting with Matplotlib (Pandas)]] -> Parent Framework: [[Data Visualisation (Chart Types)]] *(Week 4)*
- [[Linear Regression in Python (scipy)]] -> Parent Framework: [[Linear and Polynomial Regression]] *(Week 5)*
- [[Scikit-learn Classification and Clustering]] -> Parent Framework: [[Predictive Models]] *(Week 7; trees/forest/k-means)*
- [[Data Auditing in Pandas]] -> Parent Framework: [[Data Wrangling]] *(Week 3/4)*
- [[Unix Shell (Bash)]] -> Parent Framework: [[Data Wrangling]] *(Weeks 9 & 10; awk/grep/cut/pipes)*
- [[R Modelling (lm and Decision Trees)]] / [[R Visualisation (base graphics)]] *(Week 8 R lab)*

## 🧭 Suggested Reading Order
*(read left→right within each week · **bold** = assessment-critical; code weeks pair with the pinned 🧰 toolkits)*

- **W1 — what data science is:** [[Data Science]] *(Conway Venn + danger zone)* → [[Machine Learning]] → **[[Data Science Process (Standard Value Chain)]]** → [[Data Science vs Related Disciplines]]
- **W2 — roles, impact, business:** [[Data Scientist Roles and Skills]] → [[Impact of Data Science]] → [[Data Business Models]] → [[Python for Data Science]]
- **W3 — data acquisition & quality:** [[Data Sources and Open Data]] → [[APIs for Data Collection]] → [[Data Wrangling]] → **[[Data Quality Problems]]** *(detect → justify → fix)* → [[Data Auditing in Pandas]]
- **W4 — description & visualisation:** **[[Types of Data (Numeric and Categorical)]]** *(the classification everything follows)* → [[Data Visualisation (Chart Types)]] → [[Measures of Centrality]] → [[Measures of Spread and Boxplots]] → [[Association Between Variables]] → [[Groupby-Aggregate Pipeline (Pandas)]] → [[Plotting with Matplotlib (Pandas)]]
- **W5 — models & learning:** [[Predictive Models]] → [[Machine Learning]] *(workflow)* → **[[Machine Learning Styles (Supervised vs Unsupervised)]]** → [[Learning Theory and Loss Functions]] → **[[Linear and Polynomial Regression]]**
- **W6 — model quality:** **[[Bias-Variance Tradeoff (Underfitting vs Overfitting)]]** → [[No Free Lunch Theorem]] → [[Ensemble Models]]
- **W7 — classification & clustering:** **[[Classification Evaluation (Confusion Matrix and Metrics)]]** → [[Decision Trees and Regression Trees]] → [[Random Forest]] → [[k-means Clustering]]
- **W8 — R:** [[R for Data Science]] → [[R Basics (Syntax, Types, Control Flow)]] → [[R Vectors]] → **[[R Data Frames and IO]]** → [[R Visualisation (base graphics)]] → [[R Modelling (lm and Decision Trees)]]
- **W9 — big data & shell:** **[[Big Data and the Vs]]** → [[Metadata]] → [[Growth Laws (Moore, Koomey, Bell, Zimmerman)]] → [[Unix Shell (Bash)]]
- **W10 — big-data tools:** [[SQL vs NoSQL Databases]] → **[[Distributed Processing and Map-Reduce]]** → [[Hadoop and Spark]]
- **W11 — governance & ethics:** [[Data Management and Data Governance]] → [[Privacy, Confidentiality, and Security]] → **[[Data Compliance and Regulations (PDPA, GDPR)]]**

## 🎯 Learning Outcomes (key skills per week)

- **W1** ➔ 
	- define DS + Conway's Venn (danger zone) 
	- when ML earns its keep 
	- recite the value chain 
	- separate DS from engineering/analysis/management
- **W2** ➔ 
	- three roles by primary output 
	- impact vs privacy trade-offs 
	- four data-specific business models 
	- justify Python + Anaconda
- **W3** ➔ 
	- open data = machine-readable + public, LOD triples 
	- consume APIs (consumer/provider, keys) 
	- detect each quality problem + justify the fix (IQR/3σ outliers) 
	- audit with `shape`/`info`/`describe`/`value_counts`
- **W4** ➔ 
	- classify variable types FIRST 
	- match chart to type 
	- mean vs median (skew), SD vs IQR (robustness) 
	- Pearson $r$ = linear only, correlation ≠ causation 
	- groupby split-apply-combine + plot
- **W5** ➔ 
	- classifier vs regression 
	- supervised vs unsupervised by "is it labelled?" 
	- loss turns error into quality 
	- fit $\hat y = a_0 + a_1 x$ by minimising MSE (scipy `linregress`)
- **W6** ➔ 
	- diagnose under/overfitting via train/test gap 
	- bias trades against variance 
	- No Free Lunch ⟹ match algorithm to problem 
	- ensembles express prediction variability
- **W7** ➔ 
	- build + read a confusion matrix 
	- choose the metric by error cost 
	- decision trees = recursive partitioning (entropy splits) random forest = uncorrelated errors cancel 
	- k-means assign↔move loop + init sensitivity
- **W8** ➔ 
	- `<-` assignment + R types 
	- vector/data-frame indexing (`df[i, ]` comma!) 
	- audit/extract/sort/merge/aggregate 
	- `barplot`/`hist`/`boxplot`/`plot` · `lm(y ~ x)` + `ctree`
- **W9** ➔ 
	- Laney's Vs (bigness/problems/aspirations) 
	- machine-processable metadata 
	- four growth laws (Koomey/Bell ⊂ Moore) 
	- shell pipelines scale past RAM (`grep`/`sort`/`awk`/pipes)
- **W10** ➔ 
	- SQL vs NoSQL: schema rigidity + scaling direction 
	- Map-Reduce needs data-parallel work 
	- Hadoop disk-batch vs Spark in-memory/real-time
- **W11** ➔ 
	- management (internal lifecycle) vs governance (external value) 
	- privacy/confidentiality/security + implicit-data threat 
	- PDPA vs stricter GDPR (72 h, 4%/€20M)
