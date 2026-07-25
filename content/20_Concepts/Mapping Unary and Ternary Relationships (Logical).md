---
unit: FIT2094
week: 5
parent: "[[Logical Modelling (ER Mapping)]]"
tags: [CS/Databases, SWE/Design]
---
# [[Mapping Unary and Ternary Relationships (Logical)]]

**Context:** [[FIT2094_MOC]] · 1:M unary → recursive FK · M:N unary & ternary → associative relation · the non-binary mapping cases of [[Logical Modelling (ER Mapping)]]

> [!abstract] Quick Revision
> - **🎯 Objective:** map self-referencing (unary) and three-way (ternary) relationships ➔ extend the binary rules.
> - **📦 Core Components:** 1:M unary → recursive FK ➔ M:N unary / ternary → associative relation.
> - **⚡ Key Constraint:** the 1:M unary recursive FK is the **only** FK you may rename; a ternary ≠ three binaries.

## 📝 Core
### 1. 1:M Unary
- **Recursive FK** ➔ FK in the **same** relation referencing its own PK.
- **Renamed** ➔ two attributes can't share a name (`spv_id → emp_id`).
- **Only rename case** ➔ this is the one scenario a FK may be renamed.

### 2. M:N Unary
- **Associative relation** ➔ composite PK of two differently-named FKs, both to the entity's PK.
- **Relationship attribute** ➔ `quantity` depends on the pair, not the entity.

### 3. Ternary
- **One relation** ➔ composite PK from all three participants' PKs (all FKs).
- **Not three binaries** ➔ decomposing loses "which combination" meaning.
- **Discriminators** ➔ date/time added when a combination repeats.

**Key identities:**

$$\text{EMPLOYEE}(\underline{\text{emp\_id}}, \text{emp\_name}, \dots, \text{spv\_id}^{*}),\ \text{spv\_id}\to\text{emp\_id}$$
$$\text{ITEMCOMPONENT}(\underline{\text{item\_id}^{*}, \text{itemcomp\_item\_id}^{*}}, \text{itemcomp\_quantity})$$
$$\text{PATIENT\_TREATMENT}(\underline{\text{patient\_id}^{*}, \text{physician\_id}^{*}, \text{treatment\_code}^{*}, \text{pt\_date}, \text{pt\_time}}, \text{results})$$

> [!NOTE] **When It Flips:** a true ternary can't be safely split into three binaries — that loses the combination semantics; keep it as one associative relation. Recursive *identifying* relationships are forbidden ([[Logical Modelling Constraints]]).

## 📊 Exam Execution Trace

### Manual Execution Trace
Mapping non-binary cases:

| Step / State | Relationship | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | EMPLOYEE supervises EMPLOYEE | recursive spv_id FK |
| 2 | ITEM made-of ITEM | ITEMCOMPONENT |
| 3 | PATIENT–PHYSICIAN–TREATMENT | PATIENT_TREATMENT |

## ⚠️ Common Mistakes
- 💡 **Only the 1:M unary FK may be renamed** ➔ to avoid a name clash with the PK; elsewhere FK names match the referenced PK.

## 🧠 Active Recall
> [!FAQ]- How is a 1:M unary relationship mapped, and what is special about its FK?
> - **Hint:** Recursive renamed FK.
> > [!SUCCESS]- Answer
> > - **Short answer:** A self-referencing FK in the same relation, renamed (`spv_id → emp_id`).
> > - **Why:** **Only rename case** ➔ avoids a name clash with the PK.

> [!FAQ]- How do you map an M:N unary and a ternary relationship?
> - **Hint:** Associative relations.
> > [!SUCCESS]- Answer
> > - **Short answer:** M:N unary → associative relation with two differently-named FKs to the entity's PK; ternary → one relation with composite PK from all three.
> > - **Why:** **Combination semantics** ➔ a ternary can't be split into three binaries.
