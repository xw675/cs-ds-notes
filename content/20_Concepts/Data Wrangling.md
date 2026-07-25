---
unit: FIT1043
week: 3
parent: "[[Data Science Process (Standard Value Chain)]]"
tags: [DataScience/Wrangling, Monash/CS_DS]
aliases: [Data Wrangling, Data Munging, Tidy Data]
---
# [[Data Wrangling]]

**Context:** [[FIT1043_MOC]] · the **Wrangling** stage of the [[Data Science Process (Standard Value Chain)|value chain]] · turns raw data usable · precedes analysis · fixes [[Data Quality Problems]] found by [[Data Auditing in Pandas|auditing]]

> [!abstract] Quick Revision
> - **🎯 Objective:** transform raw data into analysable **tidy** data ➔ valid, actionable results.
> - **⚡ Key Constraint:** raw data is messy (varied shapes/formats, entry mistakes) — wrangling is the necessary bridge, often the biggest time cost.

## 📝 Core
- **Definition** ➔ manipulating/transforming **raw** data into data that can be analysed for valid, actionable insight.
- **Pipeline** ➔ $\text{raw data} \Rightarrow \text{wrangling} \Rightarrow \text{tidy data} \Rightarrow \text{analysis} \Rightarrow \text{knowledge}$.
- **Data product** ➔ **Data + Wrangling + Analysis = Data Product**.
- **Steps** ➔ pre-processing, preparation, cleansing, transformation (among others).
- **Why needed** ➔ data comes in all shapes/sizes; different files format differently; data-entry mistakes happen.

## ⚠️ Common Mistakes
- 💡 **Ideal data ≠ real data** ➔ never assume clean input; audit first ([[Data Auditing in Pandas]]), then wrangle.
- 💡 **Wrangling ≠ analysis** ➔ it *prepares* data; the discovery/modelling happens afterwards in the Analysis stage.

## 🧠 Active Recall
> [!FAQ]- State the wrangling pipeline and what "Data Product" means.
> > [!SUCCESS]- Answer
> > - **Short answer:** raw data → wrangling → tidy data → analysis → knowledge; a **Data Product** = Data + Wrangling + Analysis.
> > - **Why:** **Bridge to analysis** ➔ wrangling (pre-processing/cleansing/transformation) makes messy raw data valid and usable before any modelling.
