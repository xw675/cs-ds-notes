---
unit: [FIT2094, FIT3003]
domain: C
week: [5, 6]
parent: "[[Primary Key]]"
tags: [CS/Databases, SWE/Design]
aliases: [Artificial Key, Sequence Key]
---
# [[Surrogate Key]]

**Context:** [[FIT2094_MOC]], [[FIT3003_MOC]] · a system-generated artificial [[Primary Key]] · in FIT2094 added **only** at the logical stage with the natural key kept via a **unique constraint**; in FIT3003 it is the PK of a **dimension table**, implemented as a sequence

> [!abstract] Quick Revision
> - **🎯 Objective:** a system-generated meaningless PK replacing a natural key ➔ simplifies composite keys (FIT2094) and gives every dimension record one local identifier (FIT3003).
> - **📦 Core Components:** added only logically ➔ natural key kept via UNIQUE constraint | warehouse form ➔ `create sequence` $+$ `.nextval`.
> - **⚡ Key Constraint:** without the UNIQUE constraint, the natural-key business rule is lost — and in a warehouse, if the operational PK is **already unique across systems**, the surrogate is optional.

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

### 4. In the Data Warehouse *(FIT3003 Ch9)*
- **Scope is one dimension** ➔ a surrogate key is a **unique identification for each record in a dimension table** and its PK; it is *local* to that dimension, not global to the warehouse.
- **Implementation is a sequence** ➔ not hand-typed `update … where` statements; the same `Seq_ID` idiom keys a [[Junk Dimensions|junk dimension]].
- **The fact must be re-keyed too** ➔ the staged `TempFact` holds the natural values, so it gains the surrogate column and is filled from the dimension before the final `group by`.
- **It is optional, not mandatory** ➔ if the operational PK is already unique **across all source systems**, adding a surrogate buys nothing in the warehouse.
- **It does not rescue a thin dimension** ➔ `SexDim(SexID, Sex)` still has nothing to look up; what earns a one-column dimension its place is a **description** ➔ [[One-Attribute Dimensions]].

## ⚙️ Core Implementation

### 🔹 EMPLOYEE_TRAINING with surrogate *(FIT2094)*
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

### 🔹 `SuburbDIM` with a sequence surrogate *(FIT3003)*
> [!code]- Dimension ➔ sequence ➔ re-key the temp fact ➔ aggregate
> ```sql
> create table SuburbDim as select distinct Suburb, Postcode from Student;
> alter table SuburbDim add (SuburbID number(2));
>
> drop sequence Suburb_seq_ID;
> create sequence Suburb_seq_ID
>   start with 1 increment by 1 maxvalue 99999999 minvalue 1 nocycle;
> update SuburbDim set SuburbID = Suburb_seq_ID.nextval;   -- 1 Caulfield, 2 Chadstone, 3 Clayton
>
> create table TempFact as select Suburb, Sex from Student;
> alter table TempFact add (SuburbID Number(2));
> update TempFact TF set TF.SuburbID =                     -- correlated fill, not 3 hand updates
>   (select S.SuburbID from SuburbDim S where S.Suburb = TF.Suburb);
>
> create table Fact as
> select SuburbID, Sex, count(*) as TotalStudents
> from   TempFact group by SuburbID, Sex;
> ```
> 💡 **Common Mistake:** **Keying the dimension and forgetting the fact** ➔ `Fact` would still group on the suburb *name*, so the FK never matches `SuburbDIM.SuburbID` and the star will not join.

## ⚖️ Core Decision Matrix
| Aspect | Natural PK | Surrogate PK |
| :--- | :--- | :--- |
| meaning | business rules | none |
| size | composite | single numeric |
| child FKs | bloated | simple |
| natural key | is the PK | kept as UNIQUE (FIT2094) / kept as an attribute of the dimension (FIT3003) |
| warehouse necessity | sufficient when already globally unique | needed when source systems collide or the key is composite |

> [!NOTE] **When It Flips:** the natural key encodes the [[Normalisation]] rules, so it must be kept and enforced; the surrogate only replaces it *as the PK*, not the rule. Added at the **end** of logical design, after 3NF and ER mapping. In a warehouse the flip is different: surrogates become **optional** the moment every source system's PK is already unique across systems.

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

> [!FAQ]- FIT2094 treats a surrogate key as near-mandatory; FIT3003 calls it optional. What changed?
> > [!SUCCESS]- Answer
> > - **Short answer:** the problem changed — FIT2094 uses it to replace an unwieldy **composite** PK, FIT3003 uses it to give a dimension a **local** identifier that may already exist.
> > - **Why:** **Operational keys are designed to be unique** ➔ if every source system's PK is already unique across the systems being integrated, the dimension can just keep it and the surrogate adds a column for nothing. **The warehouse has no update anomalies to price** ➔ the FIT2094 argument (child FK bloat, index per key attribute) is about a transactional schema being written to constantly. **What survives in both** ➔ the surrogate is meaningless by design, so the descriptive value it replaced must still be **stored as an attribute**, never discarded.
