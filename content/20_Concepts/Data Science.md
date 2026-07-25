---
unit: FIT1043
week: 1
parent: "[[Data Science Process (Standard Value Chain)]]"
tags: [DataScience/Foundations]
aliases: [Data Science, Drew Conway Venn Diagram]
---
# [[Data Science]]

**Context:** [[FIT1043_MOC]] · extracting knowledge/value from data across its lifecycle · realised through the [[Data Science Process (Standard Value Chain)|standard value chain]] · sits beside [[Machine Learning]] and [[Data Science vs Related Disciplines|related fields]]

> [!abstract] Quick Revision
> - **🎯 Objective:** define data science as the extraction of knowledge/value from data ➔ the broad, lifecycle-wide view, not just "ML on big data".
> - **📦 Core Components:** hacking skills ∩ maths & stats ∩ substantive expertise ➔ the Conway Venn intersection.
> - **⚡ Key Constraint:** the **danger zone** — skills + domain but **no** maths/stats ➔ plausible-looking analysis with no rigour.

## 📝 Core
### 1. Defining It (the spectrum)
- **Circular (avoid)** ➔ "what a data scientist does" ➔ practically useless; never answer this way.
- **Better** ➔ "the technology of handling and extracting value from data".
- **Narrow** ➔ "machine learning on big data" ➔ useful but too limited.
- **Broad (unit view)** ➔ inter-disciplinary use of scientific methods/algorithms to extract knowledge from **structured and unstructured** data across the whole lifecycle.
- **Hal Varian** ➔ take data and *understand → process → extract value → visualise → communicate* it — a hugely important skill.

### 2. Drew Conway's Venn Diagram
- **Three circles** ➔ **hacking skills**, **maths & statistics**, **substantive (domain) expertise**.
- **Centre** ➔ all three overlap = **data science**.
- **Applied** ➔ Microsoft traffic forecasting, iOS predictive text, Google Translate, Amazon recommender, health/saturated-fat studies.

## ⚖️ Core Decision Matrix
| Overlap | Region | Note |
| :--- | :--- | :--- |
| hacking ∩ maths/stats | **Machine Learning** | many CS grads start here (ML engineer) |
| maths/stats ∩ domain expertise | **Traditional research** | deep domain, little technology |
| hacking ∩ domain expertise | **Danger zone** | analysis *looks* valid but lacks rigour |
| all three | **Data science** | the target combination |

> [!NOTE] **When It Flips:** the danger zone is dangerous precisely *because* it omits maths/stats — results appear legitimate with no understanding of how they were produced; data science needs **all three** skill sets together.

## 🧠 Active Recall
> [!FAQ]- Why is "data science is what a data scientist does" a bad definition, and what is a better one?
> - **Hint:** Circular vs substantive.
> > [!SUCCESS]- Answer
> > - **Short answer:** It's circular (defines the term by itself); a better definition is the extraction of knowledge/value from structured and unstructured data across the lifecycle.
> > - **Why:** **Broad over narrow** ➔ "ML on big data" is useful but too narrow; the lifecycle view captures collection through communication.

> [!FAQ]- In Conway's diagram, what sits at hacking ∩ domain expertise, and why is it a warning?
> - **Hint:** Missing maths/stats.
> > [!SUCCESS]- Answer
> > - **Short answer:** The **danger zone** — you can extract/structure data and know the field, but without maths/stats the analysis may be plausible yet unsound.
> > - **Why:** **No statistical grounding** ➔ no way to judge how results were derived or whether they hold.
