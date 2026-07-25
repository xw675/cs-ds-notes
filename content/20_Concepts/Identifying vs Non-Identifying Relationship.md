---
unit: FIT2094
week: 2
parent: "[[Relationship (Conceptual Modelling)]]"
tags: [CS/Databases, SWE/Design]
---
# [[Identifying vs Non-Identifying Relationship]]

**Context:** [[FIT2094_MOC]] · whether a parent's key becomes **part of** the child's key · **solid** vs **dashed** line · identifying relationships create [[Entity (Conceptual Modelling)|weak entities]]

> [!abstract] Quick Revision
> - **🎯 Objective:** does the parent's key become part of the child's key? ➔ solid = yes, dashed = no.
> - **📦 Core Components:** identifying (solid, weak child) vs non-identifying (dashed, own key).
> - **⚡ Key Constraint:** identifying ⟹ parent PK enters the child's composite PK; non-identifying ⟹ plain FK.

## 📝 Core
### 1. The Distinction
- **Identifying** ➔ A's key is **part of** B's key; B can't be identified without A; **solid line**.
- **Non-identifying** ➔ A's key is **not** part of B's key; B has its own key; **dashed line**.

### 2. The Line-Style Rule
- **Solid = identifying** ➔ child inherits parent's key into its own (composite) key → weak entity (`ROOM` needs `hotel_id`).
- **Dashed = non-identifying** ➔ both keep own keys (`DEPARTMENT`/`dept_no`, `EMPLOYEE`/`emp_no`).

### 3. Weak-Entity Link
- **Identifying ⟺ weak child** ➔ a weak entity is precisely one identified *via* an identifying relationship.
- **Test** ➔ "can B be identified without A's key?" No ⟹ identifying.

## ⚙️ Core Implementation

### 🔹 Identifying vs non-identifying
> [!code]- Mermaid + schema
> ```mermaid
> erDiagram
>   HOTEL ||--|{ ROOM : contains
>   DEPARTMENT ||..o{ EMPLOYEE : employs
> ```
> $$\text{ROOM}(\underline{\text{hotel\_id}}^{*}, \underline{\text{room\_no}}) \quad\text{vs}\quad \text{EMPLOYEE}(\underline{\text{emp\_no}}, \text{dept\_no}^{*})$$
> 💡 **Common Mistake:** **It's about the *key*, not mere association** ➔ every relationship is an association; only an *identifying* one puts the parent's key *inside* the child's identifier (solid line).

## ⚖️ Core Decision Matrix
| Aspect | Identifying | Non-identifying |
| :--- | :--- | :--- |
| line | solid | dashed |
| parent key in child | part of PK | FK only |
| child | weak entity | own PK |
| example | HOTEL–ROOM | DEPARTMENT–EMPLOYEE |

> [!NOTE] **When It Flips:** identifying relationships and weak entities are two views of the same dependency. Logically: identifying ⟹ parent PK becomes part of the child's **composite Primary Key**; non-identifying ⟹ parent PK is a plain **Foreign Key**. Line style is independent of the [[Cardinality (Crow's Foot Notation)|cardinality]] symbols.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Room 601 can exist in many hotels. Is HOTEL–ROOM identifying? Give the schema.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{room\_no not unique alone} &\Rightarrow \text{needs hotel\_id in key} \Rightarrow \textbf{identifying (solid)} \\
\text{ROOM}(\underline{\text{hotel\_id}}^{*}, \underline{\text{room\_no}}, \dots)
\end{aligned}
$$
**Final Extracted Output:** identifying; ROOM's composite PK includes HOTEL's `hotel_id` (weak entity).

## 🧠 Active Recall
> [!FAQ]- Define identifying vs non-identifying relationships and their Crow's Foot line styles.
> - **Hint:** Key inheritance.
> > [!SUCCESS]- Answer
> > - **Short answer:** Identifying = parent's key part of child's key (solid, weak child); non-identifying = child's own key (dashed).
> > - **Why:** **ROOM vs EMPLOYEE** ➔ ROOM needs `hotel_id`; EMPLOYEE keeps `emp_no`.

> [!FAQ]- How does the distinction translate to the relational logical model?
> - **Hint:** PK vs FK placement.
> > [!SUCCESS]- Answer
> > - **Short answer:** Identifying ⟹ parent PK becomes part of the child's composite PK; non-identifying ⟹ parent PK is only an FK.
> > - **Why:** **Line predicts placement** ➔ solid → inside PK, dashed → FK only.
