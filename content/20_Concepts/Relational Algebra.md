---
unit: FIT2094
domain: C
week: 3
parent: "[[Relational Model]]"
tags: [CS/Databases, Math/Discrete]
---
# [[Relational Algebra]]

**Context:** [[FIT2094_MOC]] · a **procedural**, relationally complete query language over [[Relation (Database)|relations]] · results are relations (**closure**) · what a DBMS translates SQL into

> [!abstract] Quick Revision
> - **🎯 Objective:** a procedural, relationally complete query language over relations ➔ states *how*.
> - **📦 Core Components:** unary [[Select and Project (σ, π)|σ/π]] ➔ binary [[Set Operations in Relational Algebra|set ops]] / [[Relational Algebra Joins|joins]] / product / division.
> - **⚡ Key Constraint:** **closure** — every result is a relation, so operators compose; no NULLs in pure form.

![[relational-algebra-multiple.png]]
![[relational-algebra-translation.png]]

## 📝 Core
### 1. The Language
- **Procedural** ➔ specifies *how* (an order of operations).
- **Relationally complete** ➔ expresses any query relational calculus can.
- **Operators** ➔ $\sigma,\pi$ (unary); $\cup,\cap,-,\times,\bowtie,\div$ (binary).

### 2. Closure
- **Result is a relation** ➔ queries compose (output feeds input).
- **Nested algebra** ➔ complex queries built from operators.

### 3. The DML Family
- **Relational calculus** ➔ non-procedural (yardstick for completeness).
- **SQL** ➔ declarative, transform-oriented.
- **Graphical** ➔ visual query-by-form.

## ⚙️ Core Implementation

### 🔹 SQL → algebra
> [!code]- query processor
> ```sql
> SELECT project_manager
> FROM PRDETAIL
> WHERE project_code = '25-5A';
> ```
> $$\pi_{\text{project\_manager}}\bigl(\sigma_{\text{project\_code}=\text{'25-5A'}}(\text{PRDETAIL})\bigr)$$
> 💡 **Common Mistake:** **Pure algebra has no NULLs** ➔ it assumes complete information; NULLs are an SQL addition. Algebra's explicit operation order is what enables optimisation.

## ⚖️ Core Decision Matrix
| Language | Procedural? | Role |
| :--- | :--- | :--- |
| relational calculus | no | completeness benchmark |
| relational algebra | **yes** | execution/optimisation |
| SQL | no (declarative) | user queries |
| graphical | no | visual |

> [!NOTE] **When It Flips:** algebra prescribes an operation order (good for the optimiser); calculus/SQL state only the result — the DBMS bridges them by compiling SQL to algebra. Relational join generalises FIT1058 [[Properties of Binary Relations|relational composition]] to data.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Translate `SELECT project_manager FROM PRDETAIL WHERE project_code='25-5A'` into algebra.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{WHERE} &\Rightarrow \sigma_{\text{project\_code}=\text{'25-5A'}}(\text{PRDETAIL}) \\
\text{column list} &\Rightarrow \pi_{\text{project\_manager}}(\dots)
\end{aligned}
$$
**Final Extracted Output:** $\pi_{\text{project\_manager}}(\sigma_{\text{project\_code}=\text{'25-5A'}}(\text{PRDETAIL}))$.

## 🧠 Active Recall
> [!FAQ]- What does the closure property mean, and why does it matter?
> - **Hint:** Result is a relation.
> > [!SUCCESS]- Answer
> > - **Short answer:** Every query result is itself a relation, so outputs feed back as inputs and operators compose.
> > - **Why:** **Building blocks** ➔ a complex query is nested operations; the DBMS chains operators.

> [!FAQ]- How does an SQL query relate to relational algebra inside a DBMS?
> - **Hint:** Declarative vs procedural.
> > [!SUCCESS]- Answer
> > - **Short answer:** The query processor compiles declarative SQL into procedural algebra, then optimises/executes.
> > - **Why:** **Operation order** ➔ algebra's explicit ordering enables optimisation.
