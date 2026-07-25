---
unit: FIT2094
week: 5
parent: "[[Primary Key]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Surrogate Key]]

**Context:** [[FIT2094_MOC]] · a system-generated artificial [[Primary Key]] · added **only** at the logical stage · the natural key kept via a **unique constraint**

> [!abstract] Quick Revision
> - **🎯 Objective:** a system-generated meaningless PK replacing a natural key ➔ simplifies composite keys.
> - **📦 Core Components:** added only logically ➔ natural key kept via UNIQUE constraint.
> - **⚡ Key Constraint:** without the UNIQUE constraint, the natural-key business rule is lost.

## 📝 Core
### 1. The Surrogate
- **Definition** ➔ a system-generated, business-meaningless identifier used as [[Primary Key]] in place of a natural key.
- **Stage** ➔ **only** at logical design — never [[Conceptual Model|conceptual]].

### 2. Why Add One
- **Composite keys are unwieldy** ➔ an index per key attribute, more storage, slower, bloats child FKs.
- **Single numeric id** ➔ one easy-to-manage identifier.

### 3. Protect the Natural Key
- **Manual add** ➔ new PK attribute (`et_no`); don't use a modeller's auto option.
- **Former composite → attributes** ➔ enforce **UNIQUE (NOT NULL)** on the natural key.

## ⚙️ Core Implementation

### 🔹 EMPLOYEE_TRAINING with surrogate
> [!code]- Oracle DDL
> ```sql
> CREATE TABLE EMPLOYEE_TRAINING (
>     et_no              NUMBER       PRIMARY KEY,
>     emp_no             NUMBER       NOT NULL,
>     training_code      CHAR(5)      NOT NULL,
>     et_date_completed  DATE         NOT NULL,
>     CONSTRAINT et_nk UNIQUE (emp_no, training_code, et_date_completed)
> );
> ```
> 💡 **Common Mistake:** **Keep the natural key as UNIQUE** ➔ without it, the same employee could record the same training on the same date twice — violating the business rules the [[Normalisation]] captured.

## ⚖️ Core Decision Matrix
| Aspect | Natural PK | Surrogate PK |
| :--- | :--- | :--- |
| meaning | business rules | none |
| size | composite | single numeric |
| child FKs | bloated | simple |
| natural key | is the PK | kept as UNIQUE |

> [!NOTE] **When It Flips:** the natural key encodes the [[Normalisation]] rules, so it must be kept and enforced; the surrogate only replaces it *as the PK*, not the rule. Added at the **end** of logical design, after 3NF and ER mapping.

## 📊 Exam Execution Trace

### Manual Execution Trace
Adding a surrogate:

| Step / State | Action | Result |
| :--- | :--- | :--- |
| **0 (Init)** | composite natural PK | unwieldy |
| 1 | add `et_no` PK | single numeric id |
| 2 | natural key → attributes | needs protection |
| 3 | UNIQUE(natural key) | rule preserved |

### Applied Exercise
**Problem:** After adding surrogate `et_no`, how is the natural key protected and why?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{natural key} &\to \text{ordinary attributes} \\
\text{UNIQUE}(\text{emp\_no}, \text{training\_code}, \text{et\_date\_completed}) &\Rightarrow \text{no duplicate combination}
\end{aligned}
$$
**Final Extracted Output:** a UNIQUE (NOT NULL) constraint on the natural key preserves the business rule.

## 🧠 Active Recall
> [!FAQ]- What is a surrogate key, when may it be added, and why?
> - **Hint:** Simplify composite keys.
> > [!SUCCESS]- Answer
> > - **Short answer:** A system-generated meaningless PK; added only at logical design; to simplify unwieldy composite keys.
> > - **Why:** **Index per attribute** ➔ composite keys cost storage/performance and bloat FKs.

> [!FAQ]- After adding a surrogate, how is the natural key protected, and why necessary?
> - **Hint:** UNIQUE constraint.
> > [!SUCCESS]- Answer
> > - **Short answer:** A UNIQUE (NOT NULL) constraint on the former composite key.
> > - **Why:** **Carries the rule** ➔ without it, duplicate natural-key combinations violate the business rules.
