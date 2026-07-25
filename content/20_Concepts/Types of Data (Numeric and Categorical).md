---
unit: [FIT1043, FIT2086]
domain: G
week: 4
parent: "[[Data Science Process (Standard Value Chain)]]"
tags: [DataScience/Statistics, DataScience/Visualisation]
aliases: [Data Types, Nominal, Ordinal, Discrete, Continuous]
---
# [[Types of Data (Numeric and Categorical)]]

**Context:** [[FIT1043_MOC]] · the foundation that dictates which [[Data Visualisation (Chart Types)|chart]] and which [[Measures of Centrality|statistic]] are valid · four basic types

> [!abstract] Quick Revision
> - **🎯 Objective:** classify a variable as numeric (discrete/continuous) or categorical (nominal/ordinal) ➔ this choice drives every downstream method.
> - **⚡ Key Constraint:** the split is **numeric vs categorical** first, then enumerable-vs-real / ordered-vs-unordered — a wrong classification picks the wrong chart or statistic.

## 📝 Core
- **Numeric–Discrete** ➔ numeric but **enumerable** (countable) values, e.g. number of live births, age in whole years.
- **Numeric–Continuous** ➔ numeric, **not** enumerable (real numbers), e.g. weight, height, distance from CBD.
- **Categorical–Nominal** ➔ discrete values with **no inherent ordering**, e.g. country, state, gender.
- **Categorical–Ordinal** ➔ discrete values **with an ordering**, e.g. education status, disease-progression stage.

## ⚠️ Common Mistakes
- 💡 **Numbers can be categorical** ➔ a coded state (`0`/`1`) is nominal, not numeric; don't average a code.
- 💡 **Ordinal ≠ numeric** ➔ ordered categories have rank but not meaningful arithmetic (the "gap" between stages isn't fixed).

## 🧠 Active Recall
> [!FAQ]- Classify: distance from CBD, education level, gender, number of rooms.
> > [!SUCCESS]- Answer
> > - **Short answer:** distance from CBD = numeric-continuous; education level = categorical-ordinal; gender = categorical-nominal; number of rooms = numeric-discrete.
> > - **Why:** **Enumerable vs real, ordered vs not** ➔ real-valued ⇒ continuous; countable ⇒ discrete; ranked labels ⇒ ordinal; unranked labels ⇒ nominal.
