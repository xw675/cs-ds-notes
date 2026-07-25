---
unit: [FIT1043, FIT2086]
domain: E
week: 8
parent: "[[Data Science]]"
tags: [DataScience/Tools, Tool/R]
aliases: [R, R vs Python, RStudio]
---
# [[R for Data Science]]

**Context:** [[FIT1043_MOC]] · the unit's **second** language for the [[Data Science Process (Standard Value Chain)|value chain]] · the statistician's counterpart to [[Python for Data Science|Python]]

> [!abstract] Quick Revision
> - **🎯 Objective:** justify R as a data-analysis language and set it up ➔ statistics-first, interpreted, open-source.
> - **⚡ Key Constraint:** R vs Python is a **fit-for-purpose** choice — R for statistics/analysis, Python for building/deploying systems.

## 📝 Core
- **What R is** ➔ a language for **analysing and visualising data**; **interpreted** (scripting — no compile step); designed **by statisticians**; open-source and very popular.
- **Style** ➔ **functional**, with more data-analysis and statistical support **built in** (Python is object-oriented and relies more on packages).
- **Setup** ➔ **RStudio Cloud** (browser) or install **R** (r-project.org) + the **RStudio IDE**; run via the R console/RStudio or `R` in a shell.

## ⚖️ Core Decision Matrix
| Aspect | R | Python |
| :--- | :--- | :--- |
| **Objective** | data analysis & statistics | deployment & production |
| **Strength** | ready statistical libraries | building models from scratch |
| **Packages** | tidyverse, ggplot2, caret, zoo | pandas, scikit-learn, TensorFlow |
| **Weakness** | slower, steep curve, dependency clashes | fewer specialised stats packages |

## ⚠️ Common Mistakes
- 💡 **Pick by task, not fashion** ➔ statistics/exploratory analysis leans R; production pipelines/general programming lean Python ([[No Free Lunch Theorem|no single best tool]]).
- 💡 **Interpreted ≠ fast** ➔ R trades raw speed for interactive, statistics-friendly scripting.

## 🧠 Active Recall
> [!FAQ]- Why choose R over Python, and what kind of language is it?
> > [!SUCCESS]- Answer
> > - **Short answer:** R is an interpreted, open-source, functional language designed by statisticians for data analysis/visualisation, with rich statistical support built in; prefer it for statistics-heavy work, Python for deployment/production.
> > - **Why:** **Statistics-first** ➔ more analysis/stats is native to R; Python leans on packages and suits general system building.
