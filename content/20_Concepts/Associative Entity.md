---
unit: FIT2094
domain: C
week: 2
parent: "[[Relationship (Conceptual Modelling)]]"
tags: [CS/Databases, SWE/Design]
---
# [[Associative Entity]]

**Context:** [[FIT2094_MOC]] · resolves a **many-to-many** [[Relationship (Conceptual Modelling)|relationship]] · a bridging entity with a **composite key** · the only way Crow's Foot stores relationship attributes

> [!abstract] Quick Revision
> - **🎯 Objective:** bridge two entities in an M:N ➔ split into two 1:M, carrying the association's attributes.
> - **📦 Core Components:** composite key (both parents' keys) ➔ two identifying relationships.
> - **⚡ Key Constraint:** the only way Crow's Foot stores relationship attributes.

![[associative-entity.png]]

## 📝 Core
### 1. The Bridge
- **Definition** ➔ an entity between two entities in an M:N [[Relationship (Conceptual Modelling)|relationship]], turning it into two 1:M.
- **Key** ➔ **composite** of the two parents' keys.
- **Holds** ➔ any attributes belonging to the M:N association.

### 2. Why It Exists
- **Crow's Foot limit** ➔ can't attach attributes to a relationship line.
- **Break the M:N** ➔ insert a middle entity (`ORDER_PRODUCT`).
- **Weak entity** ➔ joins both parents by two [[Identifying vs Non-Identifying Relationship|identifying]] relationships.

### 3. When to Add
- **Conceptual** ➔ keep M:N; add a bridge **only when attributes** to record.
- **Logical** ➔ **every** M:N resolved (relational DBs can't implement M:N).

## ⚙️ Core Implementation

### 🔹 ORDER–PRODUCT bridge
> [!code]- Mermaid + schema
> ```mermaid
> erDiagram
>   ORDER ||--|{ ORDER_PRODUCT : has
>   PRODUCT ||--o{ ORDER_PRODUCT : appears_on
> ```
> $$\text{ORDER\_PRODUCT}(\underline{\text{orderno}}^{*}, \underline{\text{prodno}}^{*}, \text{op\_qtyordered}, \text{op\_lineprice})$$
> 💡 **Common Mistake:** **Composite key needs both parents** ➔ to find one line's `op_qtyordered` you need *both* orderno and prodno (e.g. order 61384, product M128).

## ⚖️ Core Decision Matrix
| Stage | M:N handling | Trigger |
| :--- | :--- | :--- |
| conceptual | kept as M:N | simpler/desirable |
| conceptual + attrs | add bridge | attributes to store |
| logical (relational) | always resolve | no relational M:N |
| key | composite PK + 2 FKs | both parents |

> [!NOTE] **When It Flips:** the bridging entity inherits **both** parents' keys, so it joins them by two identifying relationships and is itself a weak entity. A bridge table is an [[n-ary Relation]] over the parents' keys.

## 📊 Exam Execution Trace

### Manual Execution Trace
STUDENT enrols UNIT (with enrolment attributes):

| Step / State | Element | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | STUDENT M:N UNIT | needs bridge |
| 2 | attributes | enrol_year, mark, grade |
| 3 | bridge | ENROLMENT (composite key) |

### Applied Exercise
**Problem:** Resolve STUDENT M:N UNIT carrying `enrol_mark`, `enrol_grade`.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{M:N + attributes} &\Rightarrow \text{ENROLMENT bridge} \\
\text{ENROLMENT}(\underline{\text{student\_id}}^{*}, \underline{\text{unit\_code}}^{*}, \text{enrol\_mark}, \text{enrol\_grade})
\end{aligned}
$$
**Final Extracted Output:** two 1:M (STUDENT makes ENROLMENT, UNIT has ENROLMENT); composite key holds the attributes.

## 🧠 Active Recall
> [!FAQ]- What problem does an associative entity solve, and how is its key formed?
> - **Hint:** Attributes on an M:N.
> > [!SUCCESS]- Answer
> > - **Short answer:** Crow's Foot can't put attributes on a line, so a bridge splits the M:N into two 1:M; its key is the composite of both parents' keys.
> > - **Why:** **Both keys needed** ➔ e.g. $(\text{orderno},\text{prodno})$ to retrieve a line.

> [!FAQ]- When should an associative entity be introduced — conceptually vs logically?
> - **Hint:** Attributes vs relational limit.
> > [!SUCCESS]- Answer
> > - **Short answer:** Conceptually only when attributes exist; logically always (relational DBs can't do M:N).
> > - **Why:** **Composite PK + two FKs** ➔ the bridge becomes a relation on both parents.
