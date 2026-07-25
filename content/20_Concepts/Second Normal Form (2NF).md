---
unit: FIT2094
week: 4
parent: "[[Normalisation]]"
tags: [CS/Databases, SWE/Design]
aliases: [2NF]
---
# [[Second Normal Form (2NF)]]

**Context:** [[FIT2094_MOC]] · 1NF with **no partial dependencies** · non-key attributes fully depend on **any candidate key** · transitive dependencies listed here

> [!abstract] Quick Revision
> - **🎯 Objective:** 1NF with no partial dependencies ➔ every non-key fully depends on any candidate key.
> - **📦 Core Components:** remove partial deps ➔ new relation + FK ➔ list transitive deps.
> - **⚡ Key Constraint:** general (candidate-key) definition; single-attribute key ⟹ already 2NF.

## 📝 Core
### 1. The 2NF Condition
- **Definition** ➔ 1NF **and** every non-key attribute fully depends on **any [[Super Key and Candidate Key|candidate key]]**.
- **No partial dependencies** ➔ (general definition — candidate keys, not just the PK).

### 2. 1NF → 2NF Steps
- **Remove partial dependency** ➔ into a new relation (determinant → PK + its dependents).
- **Leave FK** ➔ the determinant stays in the original relation as a [[Foreign Key and Referential Integrity|foreign key]].

### 3. List Transitive Dependencies
- **Definition** ➔ non-key determines another non-key.
- **Example** ➔ $\text{cat\_code}\to\text{cat\_name}$ in PART.
- **Removed at** ➔ [[Third Normal Form (3NF)|3NF]].

> [!NOTE] **When It Flips:** partial dependencies are judged against **any** candidate key (general definition), not only the chosen PK. The ENROLMENT example produced two new relations (STUDENT, UNIT) from two partial dependencies.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Take RESTOCK to 2NF given $\text{vendor\_no}\to\text{vendor\_name}$.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{partial dep} &\Rightarrow \text{VENDOR}(\underline{\text{vendor\_no}}, \text{vendor\_name}) \\
\text{RESTOCK.vendor\_no} &\Rightarrow \text{FK to VENDOR}
\end{aligned}
$$
**Final Extracted Output:** VENDOR spun off; vendor_no remains as FK — RESTOCK now 2NF.

## ⚠️ Common Mistakes
- 💡 **Single-attribute keys are automatically 2NF** ➔ no "part" to depend on; PART (key part_no) had no partial dependency and is unchanged.

## 🧠 Active Recall
> [!FAQ]- Give the 2NF condition (general definition) and the 1NF→2NF steps.
> - **Hint:** Full dependence on a candidate key.
> > [!SUCCESS]- Answer
> > - **Short answer:** 1NF + every non-key fully depends on any candidate key (no partial deps); move each partial dep to a new relation, leave an FK.
> > - **Why:** **Candidate keys** ➔ the general definition, not just the PK.

> [!FAQ]- Why does a single-attribute-key relation automatically satisfy 2NF, and what do you list at 2NF?
> - **Hint:** No "part" of a single key.
> > [!SUCCESS]- Answer
> > - **Short answer:** With one key attribute there's no part to depend on ⟹ no partial dependency; list all transitive dependencies.
> > - **Why:** **3NF removes them** ➔ e.g. $\text{cat\_code}\to\text{cat\_name}$.
