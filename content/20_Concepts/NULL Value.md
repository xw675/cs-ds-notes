---
unit: FIT2094
week: 3
parent: "[[Relational Model]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[NULL Value]]

**Context:** [[FIT2094_MOC]] · a marker that a value is absent, **not** a value itself · an SQL feature, **not** classical relational algebra · four distinct reasons

> [!abstract] Quick Revision
> - **🎯 Objective:** a marker that a value is absent/not applicable ➔ not a value itself.
> - **📦 Core Components:** four reasons ➔ not applicable / unknown / does not exist / undefined.
> - **⚡ Key Constraint:** NULL ≠ 0 ≠ empty string; an SQL feature, **outside** classical [[Relational Algebra]].

## 📝 Core
### 1. The Marker
- **Definition** ➔ a value **does not exist / is not applicable** for a tuple — **not** a value.
- **SQL only** ➔ classical [[Relational Algebra]] has no NULLs (assumes complete info).

### 2. Four Reasons
- **Not applicable** ➔ attribute doesn't apply (non-sales employee's `commission`; `0` would be wrong).
- **Unknown** ➔ value exists but not yet known (new employee's `salary`).
- **Does not exist** ➔ genuinely absent (no tax file number yet).
- **Undefined** ➔ explicitly undefined (average payment before any payment).

### 3. Not Zero / Not Empty
- **NULL ≠ 0** ➔ 0 is a value; NULL is absence.
- **NULL ≠ ''** ➔ empty string is a value too.

## ⚙️ Core Implementation

### 🔹 The four reasons (worked)
> [!code]- EMP example
> ```sql
> -- EMP(empno, deptno, salary, commission)
> -- warehouse employee: commission IS NULL   (not applicable, NOT 0)
> -- new employee Joe:    salary IS NULL       (unknown)
> ```
> 💡 **Common Mistake:** **NULL ≠ 0** ➔ a non-sales employee has *no* commission (NULL), not commission `= 0`; entity integrity bans NULL PKs but referential integrity allows NULL FKs.

> [!NOTE] **When It Flips:** [[Data Integrity|entity integrity]] forbids a NULL **primary key**; [[Foreign Key and Referential Integrity|referential integrity]] permits a NULL **foreign key** (optional participation). Comparisons/aggregates over NULLs need three-valued logic — an extension of FIT1058 [[Proposition and Truth Value|two-valued logic]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying NULLs:

| Step / State | Case | Reason |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | warehouse `commission` | not applicable |
| 2 | new employee `salary` | unknown |
| 3 | no `tfn` | does not exist |

### Applied Exercise
**Problem:** A non-sales employee has no commission. Is `commission = 0` correct?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
0 \text{ is a value} &\Rightarrow \text{implies commission earned, amount zero} \\
\text{no commission at all} &\Rightarrow \text{commission IS NULL (not applicable)}
\end{aligned}
$$
**Final Extracted Output:** incorrect — use NULL, not 0; the attribute does not apply.

## 🧠 Active Recall
> [!FAQ]- Is NULL a value? Give the four reasons a NULL can arise.
> - **Hint:** Absence marker.
> > [!SUCCESS]- Answer
> > - **Short answer:** No — a marker of absence (SQL, not classical algebra); reasons: not applicable, unknown, does not exist, undefined.
> > - **Why:** **NULL ≠ 0/''** ➔ 0 and empty string are actual values.

> [!FAQ]- How do the integrity rules treat NULLs for primary vs foreign keys?
> - **Hint:** PK ban, FK allow.
> > [!SUCCESS]- Answer
> > - **Short answer:** Entity integrity forbids a NULL PK; referential integrity allows a NULL FK (optional participation).
> > - **Why:** **Identifier vs relationship** ➔ never NULL as an identifier, allowed to signal an absent relationship.
