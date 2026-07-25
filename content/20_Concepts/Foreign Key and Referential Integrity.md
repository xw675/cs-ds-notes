---
unit: FIT2094
week: [3, 6]
parent: "[[Primary Key]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Foreign Key and Referential Integrity]]

**Context:** [[FIT2094_MOC]] · an FK is a [[Primary Key]] appearing in another relation · must **match a full PK or be NULL** · how relationships are implemented relationally

> [!abstract] Quick Revision
> - **🎯 Objective:** a PK appearing in another relation ➔ every FK matches a full PK or is NULL.
> - **📦 Core Components:** FK ➔ referential integrity ➔ implements relationships.
> - **⚡ Key Constraint:** must match the **full** PK (composite too) or be NULL; NULL FK = optional participation.

![[referential-integrity.png]]

## 📝 Core
### 1. The Foreign Key
- **Definition** ➔ an attribute set that exists as a **[[Primary Key]]** in the same or another relation.
- **Implements** ➔ [[Relationship (Conceptual Modelling)|relationships]] via PK–FK pairing.

### 2. Referential Integrity
- **Rule** ➔ every FK value matches a full PK in the referenced relation, **or is NULL**.
- **Composite** ➔ must match the **entire** composite PK; partial match invalid.
- **NULL FK** ➔ optional participation (no related parent).

### 3. On-Delete Actions
- **RESTRICT (default)** ➔ block deleting a parent still referenced by a child; the rule applied when no `ON DELETE` clause is given.
- **CASCADE** ➔ deleting the parent auto-deletes referencing child rows.
- **SET NULL** ➔ deleting the parent nulls the child's FK (only if the FK column allows NULL).
- **Chosen at design time** ➔ read participation from the data model — **mandatory** FK ⟹ RESTRICT (SET NULL would orphan it; CASCADE would destroy history).

## ⚙️ Core Implementation

### 🔹 EMP–DEPT
> [!code]- schema + Mermaid
> $$\text{DEPT}(\underline{\text{deptno}}, \text{dname}, \text{loc}) \qquad \text{EMP}(\underline{\text{empno}}, \text{ename}, \text{job}, \text{deptno}^{*})$$
> ```mermaid
> erDiagram
>   DEPT ||--o{ EMP : employs
> ```
> ```sql
> ALTER TABLE emp ADD CONSTRAINT dept_emp_fk
>     FOREIGN KEY (deptno) REFERENCES dept (deptno) ON DELETE SET NULL;
> ```
> 💡 **Common Mistake:** **Match the full PK or be NULL** ➔ the president has NULL `deptno` (no department, allowed); a partial match on a composite PK is invalid.

## ⚖️ Core Decision Matrix
| FK state | Valid? | Meaning |
| :--- | :--- | :--- |
| equals a full PK | ✅ | related parent exists |
| NULL | ✅ | optional participation |
| partial composite match | ❌ | violates referential integrity |
| dangling (no PK) | ❌ | rejected by RDBMS |

> [!NOTE] **When It Flips:** a conceptual [[Relationship (Conceptual Modelling)|relationship]] becomes a concrete FK column ([[Conceptual vs Logical Model]]); a NULL FK is the circle (min 0) of [[Cardinality (Crow's Foot Notation)|Crow's Foot]]. Deletes of a referenced PK are restricted or cascaded.

## 📊 Exam Execution Trace

### Manual Execution Trace
Validating EMP.deptno:

| Step / State | EMP.deptno | Valid? |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | 10 (exists in DEPT) | ✅ |
| 2 | NULL (president) | ✅ |
| 3 | 99 (no such DEPT) | ❌ |

### Applied Exercise
**Problem:** Can EMP.deptno be NULL? Can it be a department not in DEPT?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{NULL} &\Rightarrow \text{allowed (optional participation, president)} \\
\text{unmatched value} &\Rightarrow \text{rejected (referential integrity)}
\end{aligned}
$$
**Final Extracted Output:** NULL allowed; an unmatched value is rejected.

## 🧠 Active Recall
> [!FAQ]- Define a foreign key and state the referential integrity rule.
> - **Hint:** PK in another relation.
> > [!SUCCESS]- Answer
> > - **Short answer:** An FK is a PK appearing elsewhere; every FK value matches a full PK or is NULL.
> > - **Why:** **PK–FK links** ➔ `EMP.deptno` must be an existing `DEPT.deptno` or NULL.

> [!FAQ]- Why is a NULL FK permitted, and what must an FK referencing a composite PK do?
> - **Hint:** Optional participation + full match.
> > [!SUCCESS]- Answer
> > - **Short answer:** NULL FK = optional participation (min 0); a composite-PK FK must match entirely.
> > - **Why:** **Two valid states** ➔ equals a complete existing PK, or NULL.

> [!FAQ]- `CUST_TRAIN.cust_id` references `CUSTOMER`. Which on-delete rule, and why not CASCADE or SET NULL?
> - **Hint:** Mandatory participation ⟹ RESTRICT.
> > [!SUCCESS]- Answer
> > - **Short answer:** RESTRICT — a training record must always name a valid customer, so a customer referenced in `CUST_TRAIN` cannot be deleted.
> > - **Why:** **Participation reading** ➔ SET NULL would orphan the record (which customer?); CASCADE would erase historical training records; RESTRICT preserves both.
