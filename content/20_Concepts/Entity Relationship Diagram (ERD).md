---
unit: FIT2094
week: 2
parent: "[[Conceptual Model]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
aliases: [ERD]
---
# [[Entity Relationship Diagram (ERD)]]

**Context:** [[FIT2094_MOC]] · the graphical tool for [[Conceptual Model|conceptual modelling]] · Chen vs **Crow's Foot** notation · entities, attributes, relationships

> [!abstract] Quick Revision
> - **🎯 Objective:** graphical conceptual data model (Chen 1976) ➔ entities + attributes + relationships.
> - **📦 Core Components:** Chen (rectangles/ovals/diamonds) vs **Crow's Foot** (three-partition boxes + cardinality lines).
> - **⚡ Key Constraint:** Crow's Foot can't attach attributes to a relationship → forces an [[Associative Entity]].

## 📝 Core
### 1. The Diagram
- **Definition** ➔ a graphical [[Conceptual Model|conceptual model]] (Peter Chen, 1976).
- **Three blocks** ➔ [[Entity (Conceptual Modelling)|entities]], [[Attribute (Conceptual Modelling)|attributes]], [[Relationship (Conceptual Modelling)|relationships]].

### 2. Two Notations
- **Chen** ➔ entities = rectangles, attributes = ovals, relationships = diamonds (can carry attributes).
- **Crow's Foot** (unit standard) ➔ entities = three-partition boxes (name/attributes/key label); relationships = lines with [[Cardinality (Crow's Foot Notation)|cardinality]] at both ends.
- **Limitation** ➔ Crow's Foot **can't** attach attributes to a relationship.

### 3. Connection Rule
- **Only relationships** ➔ entities link only through relationships, never by sharing attributes.
- **Exception** ➔ a weak/child entity may include a parent's key *as part of its identifier* ([[Identifying vs Non-Identifying Relationship]]).

## ⚙️ Core Implementation

### 🔹 Crow's Foot ERD
> [!code]- Mermaid erDiagram
> ```mermaid
> erDiagram
>   CUSTOMER ||--o{ ORDER : places
>   ORDER ||--|{ ORDER_PRODUCT : has
>   PRODUCT ||--o{ ORDER_PRODUCT : appears_on
> ```
> 💡 **Common Mistake:** **Standards matter** ➔ singular entity names (no spaces/hyphens, underscores ok), key attributes flagged `Key`, every relationship has a verb label + **both** cardinalities, lines straight and non-crossing.

## ⚖️ Core Decision Matrix
| Aspect | Chen | Crow's Foot |
| :--- | :--- | :--- |
| entity | rectangle | three-partition box |
| attribute | oval | listed in box |
| relationship | diamond | labelled line |
| attributes on relationship | **yes** | no → [[Associative Entity]] |

> [!NOTE] **When It Flips:** Chen is expressive but bulky; Crow's Foot is compact and implementation-friendly but pushes relationship-attributes into an [[Associative Entity]]. The ERD lets stakeholders agree on structure before implementation.

## 📊 Exam Execution Trace

### Manual Execution Trace
Notation mapping:

| Step / State | Element | Chen | Crow's Foot |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | entity | rectangle | box |
| 2 | attribute | oval | in box |
| 3 | M:N w/ attributes | diamond + attrs | associative entity |

### Applied Exercise
**Problem:** An M:N ORDER–PRODUCT must store `op_qtyordered`. How does Crow's Foot handle it?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{Crow's Foot can't attach attrs to a line} &\Rightarrow \text{introduce } \text{ORDER\_PRODUCT} \\
\text{ORDER\_PRODUCT}(\underline{\text{orderno}}, \underline{\text{prodno}}, \text{op\_qtyordered})
\end{aligned}
$$
**Final Extracted Output:** an [[Associative Entity]] holds `op_qtyordered`, resolving the M:N.

## 🧠 Active Recall
> [!FAQ]- Contrast Chen and Crow's Foot notation, and a consequence of Crow's Foot's limitation.
> - **Hint:** Attributes on relationships.
> > [!SUCCESS]- Answer
> > - **Short answer:** Chen = rectangles/ovals/diamonds (attrs on relationships ok); Crow's Foot = boxes + cardinality lines (no attrs on relationships).
> > - **Why:** **Associative entity** ➔ an M:N needing attributes must become a bridge entity.

> [!FAQ]- How may two entities connect on a conceptual model, and the one exception about shared keys?
> - **Hint:** Only via relationships.
> > [!SUCCESS]- Answer
> > - **Short answer:** Only through a relationship — never by listing one entity's attributes in another.
> > - **Why:** **Weak entity** ➔ a child may include the parent's key as part of its identifier (identifying relationship).
