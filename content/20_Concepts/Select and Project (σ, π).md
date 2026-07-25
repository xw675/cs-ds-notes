---
unit: FIT2094
week: 3
parent: "[[Relational Algebra]]"
tags: [CS/Databases, Math/Discrete, Monash/CS_DS]
---
# [[Select and Project (σ, π)]]

**Context:** [[FIT2094_MOC]] · the two single-relation [[Relational Algebra]] operators · **SELECT** filters rows, **PROJECT** keeps columns · combine for SQL-style queries

> [!abstract] Quick Revision
> - **🎯 Objective:** σ filters rows, π keeps columns ➔ horizontal vs vertical cut.
> - **📦 Core Components:** $\sigma_{\text{cond}}(R)$ (rows) ➔ $\pi_{\text{attrs}}(R)$ (columns, dedup).
> - **⚡ Key Constraint:** PROJECT removes duplicate tuples; SQL `SELECT` list is π, `WHERE` is σ.

![[relational-algebra-select.png]]
![[relational-algebra-project.png]]

## 📝 Core
### 1. The Two Operators
- **SELECT $\sigma$** ➔ filters **tuples** by a condition (horizontal cut).
- **PROJECT $\pi$** ➔ keeps chosen **attributes**, removing duplicate tuples (vertical cut).

### 2. Combining σ then π
- **Filter then narrow** ➔ $\pi_{\text{attrs}}(\sigma_{\text{cond}}(R))$.
- **SQL parallel** ➔ `WHERE` = σ, `SELECT` column-list = π.

### 3. Mnemonic
- **σ (S)elect** ➔ cuts horizontally (rows).
- **π (P)roject** ➔ cuts vertically (columns).
- **Name clash** ➔ SQL `SELECT` ≠ relational-algebra SELECT.

**Key identities:**

$$\sigma_{\text{project\_code}=\text{'25-5A'}}(\text{PRDETAIL}) \quad(\text{rows: one})$$
$$\pi_{\text{project\_manager}}(\text{PRDETAIL}) \quad(\text{7 rows} \to \text{4 distinct})$$
$$\pi_{\text{project\_manager}}\bigl(\sigma_{\text{project\_code}=\text{'25-5A'}}(\text{PRDETAIL})\bigr) = \{\text{George F. Dorts}\}$$

## ⚖️ Core Decision Matrix
| Operator | Cuts | Duplicates |
| :--- | :--- | :--- |
| $\sigma$ (select) | rows (horizontal) | not removed |
| $\pi$ (project) | columns (vertical) | removed |
| SQL `WHERE` | = σ | — |
| SQL column list | = π | distinct if projected |

> [!NOTE] **When It Flips:** both are **unary** (single relation); combining relations needs joins/set operations. Select-then-project (filter rows, then narrow columns) is the natural, cheaper order the optimiser exploits. A σ predicate expresses FIT1058 [[Quantifiers (Existential and Universal)|logical conditions]].

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Write the algebra for "the project manager of project 25-5A" and the SQL.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
&\pi_{\text{project\_manager}}\bigl(\sigma_{\text{project\_code}=\text{'25-5A'}}(\text{PRDETAIL})\bigr) \\
&\texttt{SELECT project\_manager FROM PRDETAIL WHERE project\_code='25-5A';}
\end{aligned}
$$
**Final Extracted Output:** result *George F. Dorts*; `WHERE` = σ, column list = π.

## ⚠️ Common Mistakes
- 💡 **PROJECT deduplicates, SELECT does not** ➔ π's result is a relation (no duplicates, [[Relation Properties]]); σ only drops non-matching rows.

## 🧠 Active Recall
> [!FAQ]- Contrast SELECT ($\sigma$) and PROJECT ($\pi$), and why does PROJECT remove duplicates?
> - **Hint:** Rows vs columns.
> > [!SUCCESS]- Answer
> > - **Short answer:** σ filters rows by condition; π keeps columns; π removes duplicate tuples.
> > - **Why:** **Result is a relation** ➔ relations forbid duplicates, so projecting deduplicates.

> [!FAQ]- Write the algebra and SQL for "the project manager of project 25-5A".
> - **Hint:** σ then π.
> > [!SUCCESS]- Answer
> > - **Short answer:** $\pi_{\text{project\_manager}}(\sigma_{\text{project\_code}=\text{'25-5A'}}(\text{PRDETAIL}))$; SQL with `WHERE` + column list.
> > - **Why:** **WHERE = σ, list = π** ➔ result is *George F. Dorts*.
