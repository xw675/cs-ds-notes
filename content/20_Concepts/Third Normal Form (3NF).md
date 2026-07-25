---
unit: FIT2094
domain: C
week: 4
parent: "[[Normalisation]]"
tags: [CS/Databases, SWE/Design]
aliases: [3NF]
---
# [[Third Normal Form (3NF)]]

**Context:** [[FIT2094_MOC]] · 2NF with **no transitive dependencies** · no non-key attribute determines another non-key · the unit's final [[Normalisation|normal form]]

> [!abstract] Quick Revision
> - **🎯 Objective:** 2NF with no transitive dependencies ➔ no non-key determines another non-key.
> - **📦 Core Components:** remove transitive deps ➔ new relation + FK ➔ list all full dependencies.
> - **⚡ Key Constraint:** the unit's final normal form; each relation now a single subject.

## 📝 Core
### 1. The 3NF Condition
- **Definition** ➔ [[Second Normal Form (2NF)|2NF]] **and** no transitive dependencies.
- **No non-key → non-key** ➔ the highest normal form in this unit.

### 2. 2NF → 3NF Steps
- **Remove transitive dependency** ➔ into a new relation (non-key determinant → PK + dependents).
- **Leave FK** ➔ the determinant stays as a [[Foreign Key and Referential Integrity|foreign key]].

### 3. Final Check
- **List all full dependencies** ➔ confirm no partial/transitive slipped through.
- **Single subject** ➔ each relation now models one subject.

## ⚙️ Core Implementation

### 🔹 PART → 3NF ($\text{cat\_code}\to\text{cat\_name}$)
> [!code]- final schema + Mermaid
> ```mermaid
> erDiagram
>   CATEGORY ||--o{ PART : classifies
>   PART ||--o{ RESTOCK : restocked_by
>   VENDOR ||--o{ RESTOCK : supplies
> ```
> $$\text{PART}(\underline{\text{part\_no}}, \text{part\_name}, \text{cat\_code}^{*}, \dots)\quad \text{CATEGORY}(\underline{\text{cat\_code}}, \text{cat\_name})$$
> 💡 **Common Mistake:** **List all full dependencies at 3NF** ➔ reviewing them is the correctness checkpoint that no partial/transitive dependency remains; 3NF stops here (BCNF/4NF out of scope).

> [!NOTE] **When It Flips:** the PART final set (PART, RESTOCK, VENDOR, CATEGORY) has **4 PKs and 3 FKs** (`PART.cat_code`→CATEGORY, `RESTOCK.part_no`→PART, `RESTOCK.vendor_no`→VENDOR). Each relation now represents a single subject.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** How many PKs and FKs in the final PART 3NF set?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
4 \text{ relations} &\Rightarrow 4 \text{ PKs} \\
\text{FKs} &: \text{PART.cat\_code}, \text{RESTOCK.part\_no}, \text{RESTOCK.vendor\_no} = 3
\end{aligned}
$$
**Final Extracted Output:** 4 PKs, 3 FKs.

## 🧠 Active Recall
> [!FAQ]- Give the 3NF condition and the 2NF→3NF steps.
> - **Hint:** No non-key → non-key.
> > [!SUCCESS]- Answer
> > - **Short answer:** 2NF + no transitive dependencies; move each to a new relation (determinant → PK), leave an FK.
> > - **Why:** **CATEGORY** ➔ $\text{cat\_code}\to\text{cat\_name}$ spins off CATEGORY, cat_code stays as FK.

> [!FAQ]- For the final PART 3NF set, how many PKs and FKs?
> - **Hint:** Count relations + FKs.
> > [!SUCCESS]- Answer
> > - **Short answer:** 4 PKs, 3 FKs (PART.cat_code, RESTOCK.part_no, RESTOCK.vendor_no).
> > - **Why:** **Full-dependency list** ➔ the 3NF checkpoint confirming no partial/transitive dependency remains.
