---
unit: FIT2094
week: 3
parent: "[[Relational Model]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Data Integrity]]

**Context:** [[FIT2094_MOC]] · three rules keeping relational data consistent · entity, referential, and column/domain integrity · enforced by the RDBMS

> [!abstract] Quick Revision
> - **🎯 Objective:** rules keeping relational data consistent ➔ entity / referential / column integrity.
> - **📦 Core Components:** entity (PK) ➔ referential (FK) ➔ column/domain (attribute values).
> - **⚡ Key Constraint:** declared once in the schema, enforced automatically on every DML operation.

## 📝 Core
### 1. The Three Rules
- **Entity integrity** ➔ a [[Primary Key]] is **unique + non-NULL** for every tuple.
- **Referential integrity** ➔ every [[Foreign Key and Referential Integrity|foreign key]] matches a full PK **or is NULL**.
- **Column/domain integrity** ➔ all values of an attribute from the same [[Domain (Relational Model)|domain]].

### 2. Each Guards a Level
- **Entity** ➔ protects **tuple identity** (the PK).
- **Referential** ➔ protects **relationships** (PK–FK links).
- **Column/domain** ➔ protects **attribute values** (the domain).

## ⚙️ Core Implementation

### 🔹 The three rules as DDL
> [!code]- constraint DDL
> ```sql
> studentID   NUMBER      PRIMARY KEY,          -- entity: unique + NOT NULL
> student_id  NUMBER      REFERENCES STUDENT,   -- referential: match PK or NULL
> age         NUMBER(3)   CHECK (age BETWEEN 0 AND 120)  -- column/domain
> ```
> 💡 **Common Mistake:** **Entity integrity ⟹ usable PK** ➔ a NULL PK can't identify a tuple, a duplicate PK makes two tuples indistinguishable ([[Relation Properties]]); NULL FKs are allowed (optional participation).

## ⚖️ Core Decision Matrix
| Rule | Guards | Constraint |
| :--- | :--- | :--- |
| entity | tuple identity | PK unique + non-NULL |
| referential | relationships | FK matches PK or NULL |
| column/domain | attribute values | one domain per attribute |

> [!NOTE] **When It Flips:** constraints are part of the schema, so the DBMS rejects any insert/update/delete that would violate them — no per-operation application code. Referential integrity constrains deletes (block or cascade). NULL allowances are SQL/RDBMS features (classical algebra has none).

## 📊 Exam Execution Trace

### Manual Execution Trace
Checking each rule:

| Step / State | Rule | Example violation |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | entity | NULL/duplicate studentID |
| 2 | referential | ENROLMENT.student_id with no STUDENT |
| 3 | column | Age = "twenty" |

### Applied Exercise
**Problem:** Why does entity integrity forbid a NULL or duplicate primary key?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{NULL PK} &\Rightarrow \text{tuple unidentifiable} \\
\text{duplicate PK} &\Rightarrow \text{two tuples indistinguishable (violates uniqueness)}
\end{aligned}
$$
**Final Extracted Output:** PK must be unique + non-NULL to be a reliable handle on each tuple.

## 🧠 Active Recall
> [!FAQ]- State the three data-integrity rules and what each protects.
> - **Hint:** Identity / relationships / values.
> > [!SUCCESS]- Answer
> > - **Short answer:** Entity (PK unique+non-NULL) → identity; referential (FK matches PK or NULL) → relationships; column/domain (same domain) → values.
> > - **Why:** **RDBMS-enforced** ➔ declared in the schema, applied automatically.

> [!FAQ]- Why does entity integrity forbid a NULL or duplicate primary key?
> - **Hint:** PK is the identifier.
> > [!SUCCESS]- Answer
> > - **Short answer:** NULL PK → unidentifiable tuple; duplicate PK → indistinguishable tuples.
> > - **Why:** **Uniqueness** ➔ enforced by a unique index, making the PK a reliable handle.
