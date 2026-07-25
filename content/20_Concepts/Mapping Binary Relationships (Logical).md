---
unit: FIT2094
week: 5
parent: "[[Logical Modelling (ER Mapping)]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Mapping Binary Relationships (Logical)]]

**Context:** [[FIT2094_MOC]] · map 1:M, M:N, 1:1 relationships to [[Foreign Key and Referential Integrity|foreign keys]] · M:N needs a bridging relation · 1:1 minimises NULLs

> [!abstract] Quick Revision
> - **🎯 Objective:** map a binary relationship by FKs, rule set by cardinality ➔ 1:M / M:N / 1:1.
> - **📦 Core Components:** 1:M (FK on many) ➔ M:N (bridge relation) ➔ 1:1 (FK to minimise NULLs).
> - **⚡ Key Constraint:** M:N needs a bridging relation; 1:1 total → consolidate.

## 📝 Core
### 1. 1:M
- **Rule** ➔ the **one** side's PK becomes an FK on the **many** side.
- **Direction determined** ➔ the one-side PK can appear many times there.

### 2. M:N
- **Bridge relation** ➔ both parents' PKs as FKs, usually forming a composite PK.
- **Two 1:M** ➔ one per FK; plus relationship attributes.
- **Own identifier** ➔ if the bridge has its own key, the FKs need not form the PK.

### 3. 1:1
- **FK on mandatory side** ➔ minimise NULLs, enforce "must participate".
- **Total both sides** ➔ consolidate into one relation.

**Key identities:**

$$\text{1:M}\quad \text{ORDER}(\underline{\text{order\_id}}, \text{order\_date}, \text{cust\_id}^{*})$$
$$\text{M:N}\quad \text{ORDERLINE}(\underline{\text{order\_id}^{*}, \text{product\_id}^{*}}, \text{ol\_qtyordered})$$
$$\text{1:1}\quad \text{CARECENTER}(\underline{\text{center\_id}}, \dots, \text{nurse\_id}^{*})\ (\text{FK on mandatory side})$$

> [!NOTE] **When It Flips:** the two M:N FKs *usually* form the PK, but a supplied surrogate/own identifier ([[Associative Entity]]) makes them non-key FKs. Placing a 1:1 FK on the mandatory side both minimises [[NULL Value|NULLs]] and enforces the "must participate" rule.

## 📊 Exam Execution Trace

### Manual Execution Trace
Choosing FK placement:

| Step / State | Relationship | Rule |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | CUSTOMER 1:M ORDER | cust_id FK in ORDER |
| 2 | ORDER M:N PRODUCT | ORDERLINE bridge |
| 3 | NURSE 1:1 CARECENTER | nurse_id FK in CARECENTER |

## ⚠️ Common Mistakes
- 💡 **1:M FK direction is determined, not chosen** ➔ the FK must go on the many side; reversing it would need a multivalued attribute.

## 🧠 Active Recall
> [!FAQ]- Give the mapping rule for a 1:M and an M:N binary relationship.
> - **Hint:** FK-on-many vs bridge.
> > [!SUCCESS]- Answer
> > - **Short answer:** 1:M → one-side PK as FK on many side; M:N → bridging relation with both PKs as FKs.
> > - **Why:** **No relational M:N** ➔ the bridge splits it into two 1:M.

> [!FAQ]- For a 1:1 relationship, where do you place the FK, and when do you consolidate?
> - **Hint:** Mandatory side / total.
> > [!SUCCESS]- Answer
> > - **Short answer:** FK on the mandatory side (minimise NULLs); consolidate if total on both sides.
> > - **Why:** **NULL minimisation** ➔ placing the FK on the "must participate" side avoids NULLs and enforces the rule.
