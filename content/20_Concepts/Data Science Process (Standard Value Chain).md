---
unit: FIT1043
week: 1
parent: "[[Data Science]]"
tags: [DataScience/Foundations, DataScience/Lifecycle]
aliases: [Data Science Process, Standard Value Chain, Data Science Lifecycle]
---
# [[Data Science Process (Standard Value Chain)]]

**Context:** [[FIT1043_MOC]] · how a [[Data Science]] project actually runs · the unit's model of the lifecycle · many tasks, not all labelled "data science"

> [!abstract] Quick Revision
> - **🎯 Objective:** run a project as an ordered pipeline ➔ Collection → Engineering → Governance → Wrangling → Analysis → Visualisation → Operationalize.
> - **📦 Core Components:** Wrangling ➔ clean/pre-process | Analysis ➔ learning/discovery | Operationalize ➔ turn results into value.
> - **⚡ Key Constraint:** a data scientist is familiar with **most** stages but need not be expert in all; some stages come from other fields (engineering, business).

## 📝 Core
### 1. The Standard Value Chain (unit model)
| # | Stage | What it covers |
| :--- | :--- | :--- |
| 1 | **Collection** | getting the data |
| 2 | **Engineering** | storage + computation across the full lifecycle |
| 3 | **Governance** | overall management of data across the lifecycle |
| 4 | **Wrangling** | data pre-processing and cleaning |
| 5 | **Analysis** | discovery — learning, statistics, visualisation |
| 6 | **Visualisation** | arguing the results are significant and useful |
| 7 | **Operationalize** | putting results to work to gain value |

### 2. Illustrating the Process (10 tasks)
- **Front end** ➔ pitching ideas → collecting data → integration (many sources) → interpretation (a schema).
- **Back end** ➔ governance (caring for data + subjects; standards/formats) → engineering (back-end works).
- **Core loop** ➔ wrangling (inspect/clean) → modelling (conceptual/mathematical/functional; ML/stats) → visualisation → operationalize.
- **Roles** ➔ different data scientists carry different mixes of skills and domain knowledge (see [[Data Science vs Related Disciplines]]).

## ⚠️ Common Mistakes
- 💡 **Wrangling ≠ Analysis** ➔ wrangling is cleaning/pre-processing to make data usable; analysis is the discovery/modelling that extracts insight — do not conflate them.
- 💡 **Not every stage is "data science"** ➔ collection/engineering/governance draw on computer engineering, business, and data management; a data scientist need not master all.

## 🧠 Active Recall
> [!FAQ]- List the standard value chain in order and state what separates Wrangling from Analysis.
> > [!SUCCESS]- Answer
> > - **Short answer:** Collection → Engineering → Governance → Wrangling → Analysis → Visualisation → Operationalize. Wrangling cleans/pre-processes the data; Analysis does the discovery (learning, statistics, visualisation).
> > - **Why:** **Prepare vs discover** ➔ you cannot analyse reliably until the data is wrangled; Operationalize then converts insight into value.
