---
unit: FIT2094
week: 5
parent: "[[Logical Modelling (ER Mapping)]]"
tags: [CS/Databases, SWE/Design]
---
# [[Mapping Entities and Attributes (Logical)]]

**Context:** [[FIT2094_MOC]] · entity → [[Relation (Database)|relation]] · composite → component attributes · multivalued & weak entity → new relation · part of [[Logical Modelling (ER Mapping)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** map entities/attributes to relations storing only atomic values ➔ regular entity → relation.
> - **📦 Core Components:** composite → components ➔ multivalued → new relation ➔ weak entity → inherited composite PK.
> - **⚡ Key Constraint:** atomicity (1NF) drives every rule; bare multivalued split leaves redundancy.

## 📝 Core
### 1. Regular Entity
- **Entity → relation** ➔ name → relation, key → [[Primary Key]], attributes → attributes.

### 2. Composite Attribute
- **List components** ➔ only the simple parts (`customer_address` → `cust_street, cust_city, cust_state, cust_zip`).
- **Ask the client** ➔ if unsure whether to decompose (e.g. phone); `*` marks not-null.

### 3. Multivalued & Weak Entity
- **Multivalued → new relation** ➔ PK = original PK + the multivalued attribute (FK back).
- **Weak entity → composite PK** ➔ parent PK + own partial key (parent PK also FK).
- **Lookup relation** ➔ reduces redundancy (`EMPLOYEE — EMP_SKILL — SKILL`).

**Key identities:**

$$\text{EMPLOYEE}(\underline{\text{emp\_id}}, \text{emp\_name}) \qquad \text{EMP\_SKILL}(\underline{\text{emp\_id}^{*}, \text{emp\_skill}})$$
$$\text{EMP\_DEPENDENT}(\underline{\text{emp\_id}^{*}, \text{edep\_id}}, \text{edep\_firstname}, \dots)$$

## ⚖️ Core Decision Matrix
| Construct | Mapping | Reason |
| :--- | :--- | :--- |
| regular entity | → relation | direct |
| composite attr | → components | atomicity |
| multivalued attr | → new relation | atomicity (1NF) |
| weak entity | → inherited composite PK | identifying relationship |

> [!NOTE] **When It Flips:** atomicity is the driver — composite and multivalued attributes both violate the relational atomic-value rule ([[First Normal Form (1NF)]]). A weak entity's inherited parent PK lands **inside** the child's composite PK (solid-line [[Identifying vs Non-Identifying Relationship|identifying relationship]]).

## 📊 Exam Execution Trace

### Manual Execution Trace
Mapping attribute types:

| Step / State | Construct | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | composite address | 4 component attributes |
| 2 | multivalued emp_skills | EMP_SKILL relation |
| 3 | weak DEPENDENT | EMP_DEPENDENT composite PK |

## ⚠️ Common Mistakes
- 💡 **Bare multivalued split leaves redundancy** ➔ the same skill repeats across employees ([[Database Anomalies]]); add a `SKILL` lookup relation to store each description once.

## 🧠 Active Recall
> [!FAQ]- How are composite and multivalued attributes mapped, and why?
> - **Hint:** Atomicity.
> > [!SUCCESS]- Answer
> > - **Short answer:** Composite → simple components; multivalued → new relation (PK = original PK + attribute).
> > - **Why:** **1NF** ➔ relations store atomic values only.

> [!FAQ]- How is a weak entity mapped, and the residual problem with a bare multivalued mapping?
> - **Hint:** Composite PK + redundancy.
> > [!SUCCESS]- Answer
> > - **Short answer:** Weak entity → composite PK (parent PK + own partial key, parent PK also FK); bare multivalued split repeats values.
> > - **Why:** **Lookup relation** ➔ a `SKILL` table stores each description once, avoiding anomalies.
