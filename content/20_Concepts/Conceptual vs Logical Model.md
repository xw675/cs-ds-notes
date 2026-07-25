---
unit: FIT2094
domain: C
week: 2
parent: "[[Conceptual Model]]"
tags: [CS/Databases, SWE/Design]
---
# [[Conceptual vs Logical Model]]

**Context:** [[FIT2094_MOC]] · maps a [[Conceptual Model]] to a relational schema · entity → relation, with **Primary** and **Foreign** keys · M:N must be resolved

> [!abstract] Quick Revision
> - **🎯 Objective:** refine a conceptual model for a chosen DB type (relational) ➔ entity → relation, relationship → FK.
> - **📦 Core Components:** entity → relation ➔ key attr → PK | relationship → FK.
> - **⚡ Key Constraint:** M:N **cannot** exist relationally — resolve into two 1:M via a bridge.

![[conceptual-logical-comparison.png]]

## 📝 Core
### 1. The Mapping
- **Entity → relation** ➔ each [[Entity (Conceptual Modelling)|entity]] becomes a table.
- **Key attr → Primary Key** ➔ marked `P`, underlined.
- **Relationship → Foreign Key** ➔ parent's PK copied into child, marked `F`/starred.

### 2. Resolving M:N
- **Cannot implement** ➔ relational DBs have no M:N construct.
- **Two 1:M** ➔ insert a bridging [[Associative Entity]] with composite PK + two FKs.

### 3. Detail Level
- **Conceptual** ➔ high-level meaning; **logical** ➔ implementation-ready, one DB type (still vendor-free).
- **Reserved words** ➔ rename clashes (`ORDER`→`ORDERS`).

**Key identities:**

$$\text{CUSTOMER}(\underline{\text{custno}}, \text{custname}, \text{custaddress}, \text{custphone})$$
$$\text{ORDERS}(\underline{\text{orderno}}, \text{orderdate}, \text{custno}^{*})$$
$$\text{ORDER\_PRODUCT}(\underline{\text{orderno}}^{*}, \underline{\text{prodno}}^{*}, \text{op\_qtyordered}, \text{op\_lineprice})$$

> [!NOTE] **When It Flips:** a relationship (an *association* conceptually) becomes a concrete **column** (the FK, the parent's PK in the child) logically. Surrogate keys, banned conceptually, may be introduced from the logical model onward. The relations produced are [[n-ary Relation|n-ary relations]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Mapping CUSTOMER places ORDER (M:N ORDER–PRODUCT):

| Step / State | Conceptual | Logical |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | CUSTOMER entity | CUSTOMER relation, PK custno |
| 2 | places | ORDERS.custno FK |
| 3 | ORDER–PRODUCT M:N | ORDER_PRODUCT bridge |

## ⚠️ Common Mistakes
- 💡 **M:N must be resolved logically even without attributes** ➔ a relational DB can't implement M:N, so ORDER–PRODUCT becomes a composite-PK bridge with two FKs.

## 🧠 Active Recall
> [!FAQ]- How are entities, keys, and relationships mapped to a relational logical model?
> - **Hint:** Relation / PK / FK.
> > [!SUCCESS]- Answer
> > - **Short answer:** Entity → relation; key attr → Primary Key; relationship → Foreign Key (parent PK in child).
> > - **Why:** **Schema** ➔ $\text{ORDERS}(\underline{\text{orderno}}, \text{orderdate}, \text{custno}^{*})$.

> [!FAQ]- Why must a many-to-many relationship be resolved logically, and how?
> - **Hint:** No relational M:N.
> > [!SUCCESS]- Answer
> > - **Short answer:** Convert to two 1:M via a bridge whose PK is the composite of both parents' keys + an FK to each.
> > - **Why:** **Kept conceptually** ➔ M:N is simpler on the conceptual model, resolved only for the relational target.
