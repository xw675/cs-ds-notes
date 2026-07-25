---
unit: FIT2094
domain: C
week: 2
parent: "[[Entity Relationship Diagram (ERD)]]"
tags: [CS/Databases, SWE/Design]
---
# [[Relationship (Conceptual Modelling)]]

**Context:** [[FIT2094_MOC]] · a logical association between [[Entity (Conceptual Modelling)|entities]] · classified by **degree** (unary/binary/ternary) · labelled with a verb

> [!abstract] Quick Revision
> - **🎯 Objective:** a logical association between entities ➔ the only way entities connect on a conceptual model.
> - **📦 Core Components:** degree unary/binary/ternary ➔ verb label ➔ min/max cardinalities.
> - **⚡ Key Constraint:** ternary resolved by a composite entity; two entities may share multiple distinct relationships.

![[binary-relationship.png]]
![[unary-relationship.png]]
![[ternary-relationship.png]]

## 📝 Core
### 1. The Relationship
- **Definition** ➔ a logical association ("a customer **places** many orders").
- **Only connector** ➔ the sole way entities connect on a [[Conceptual Model]].
- **Degree** ➔ number of entities involved.

### 2. Degree
- **Unary (recursive)** ➔ entity with itself (`EMPLOYEE` manages `EMPLOYEE`).
- **Binary** ➔ two entities (most common; `CUSTOMER` places `ORDER`).
- **Ternary+** ➔ >2 entities ➔ resolved by a **composite entity** (`PRESCRIPTION`).

### 3. Multiplicity of Relationships
- **Multiple links** ➔ two entities can share more than one relationship, modelled **separately**.
- **Example** ➔ EMPLOYEE **member of** TEAM *and* **leader of** TEAM = two lines.
- **Label direction** ➔ name in the 1:M direction (`places`, `has`).

## ⚙️ Core Implementation

### 🔹 Binary relationship
> [!code]- Mermaid erDiagram
> ```mermaid
> erDiagram
>   CUSTOMER ||--o{ ORDER : places
> ```
> 💡 **Common Mistake:** **Model only the brief's relationships** ➔ a derivable/redundant association (already implied by existing relationships) must **not** be added; the brief decides, not intuition.

## ⚖️ Core Decision Matrix
| Degree | Entities | Resolution |
| :--- | :--- | :--- |
| unary | 1 (recursive) | self-referencing FK |
| binary | 2 | direct line |
| ternary+ | ≥3 | composite entity |
| M:N binary | 2 | [[Associative Entity]] (if attributes) |

> [!NOTE] **When It Flips:** M:N is **kept** on the conceptual model (simpler/desirable) and resolved into an [[Associative Entity]] only when attributes must be stored or at the [[Conceptual vs Logical Model|logical stage]]. A relationship here is the ER counterpart of a [[Binary Relation]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying by degree:

| Step / State | Relationship | Degree | Note |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | EMPLOYEE manages EMPLOYEE | unary | recursive |
| 2 | CUSTOMER places ORDER | binary | common |
| 3 | doctor–drug–patient | ternary | → PRESCRIPTION |

### Applied Exercise
**Problem:** EMPLOYEE is a *member* and a *leader* of a TEAM. Model it; may a derivable relationship be added?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{two distinct associations} &\Rightarrow \text{two separate lines (member, leader)} \\
\text{derivable relationship} &\Rightarrow \text{NOT added (brief rule)}
\end{aligned}
$$
**Final Extracted Output:** two labelled relationships; no redundant/derivable relationship added.

## 🧠 Active Recall
> [!FAQ]- Define relationship degree and give unary/binary/ternary examples.
> - **Hint:** Entity count.
> > [!SUCCESS]- Answer
> > - **Short answer:** Degree = entities involved; unary (EMPLOYEE manages EMPLOYEE), binary (CUSTOMER places ORDER), ternary (doctor–drug–patient).
> > - **Why:** **Ternary resolution** ➔ add a composite entity (`PRESCRIPTION`).

> [!FAQ]- If two entities have two real-world associations, how are they modelled, and may you add a relationship not in the brief?
> - **Hint:** Separate lines; brief-only.
> > [!SUCCESS]- Answer
> > - **Short answer:** Two separate relationships; distinct associations can't merge; no unstated relationship added.
> > - **Why:** **Exactly the brief** ➔ even a derivable/redundant relationship is excluded.
