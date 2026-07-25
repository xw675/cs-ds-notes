---
unit: FIT2094
week: 2
parent: "[[Relationship (Conceptual Modelling)]]"
tags: [CS/Databases, SWE/Design]
---
# [[Cardinality (Crow's Foot Notation)]]

**Context:** [[FIT2094_MOC]] · how many instances of one [[Entity (Conceptual Modelling)|entity]] associate with another · **min and max** shown at each end · the Crow's Foot symbols

> [!abstract] Quick Revision
> - **🎯 Objective:** instances of one entity associated with another ➔ 1:1, 1:M, M:N.
> - **📦 Core Components:** bar = one/mandatory | circle = zero/optional | crow's foot = many.
> - **⚡ Key Constraint:** show **both** min and max at each end; the min comes from the business rules.

![[crows-foot-cardinality-notation.png]]

## 📝 Core
### 1. Cardinality
- **Definition** ➔ how many instances of one [[Entity (Conceptual Modelling)|entity]] may/must associate with another.
- **Three types** ➔ one-to-one (1:1), one-to-many (1:M), many-to-many (M:N).
- **Both ends** ➔ show min and max on each side, from the business rules.

### 2. The Symbols
- **Bar `|`** ➔ one / mandatory.
- **Circle `O`** ➔ zero / optional.
- **Crow's foot `<`** ➔ many.
- **Read** ➔ outer symbol = max, inner symbol = min.

### 3. Min from Business Rules
- **"may"** ➔ min 0 (optional, circle).
- **"must"** ➔ min 1 (mandatory, bar).

## ⚙️ Core Implementation

### 🔹 The four end-symbols
> [!code]- Mermaid + symbols
> ```mermaid
> erDiagram
>   EMPLOYEE ||--|| COMPANY_CAR : assigned
>   CUSTOMER ||--o{ ORDER : places
>   ORDER }o--o{ PRODUCT : contains
> ```
> `||` one-and-only-one | `o|` zero-or-one | `|{` one-or-many | `o{` zero-or-many.
> 💡 **Common Mistake:** **A plain line (implying 1,1) is not acceptable** ➔ every end needs its optionality (min) and multiplicity (max); the min is dictated by the brief, not a notation choice.

## ⚖️ Core Decision Matrix
| Symbol | Min | Max | Meaning |
| :--- | :--- | :--- | :--- |
| `||` | 1 | 1 | one and only one |
| `o|` | 0 | 1 | zero or one |
| `|{` | 1 | many | one or many |
| `o{` | 0 | many | zero or many |

> [!NOTE] **When It Flips:** M:N is allowed conceptually — it stays on the [[Conceptual Model]] and is resolved into an [[Associative Entity]] / two 1:M only when attributes are needed or at the [[Conceptual vs Logical Model|logical stage]]. Line *style* (solid/dashed, [[Identifying vs Non-Identifying Relationship]]) is independent of the cardinality symbols.

## 📊 Exam Execution Trace

### Applied Exercise
**Problem:** Encode that relationship in Crow's Foot.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{"may ... zero or many"} &\Rightarrow \text{ORDER side } o\{\ (\min 0, \max\text{ many}) \\
\text{"each order must belong to one"} &\Rightarrow \text{CUSTOMER side } ||\ (\min 1, \max 1)
\end{aligned}
$$
**Final Extracted Output:** `CUSTOMER ||--o{ ORDER`.

## 🧠 Active Recall
> [!FAQ]- What do the bar, circle, and crow's foot mean, and why show min and max at both ends?
> - **Hint:** Optionality + multiplicity independent.
> > [!SUCCESS]- Answer
> > - **Short answer:** Bar = one/mandatory, circle = zero/optional, crow's foot = many; inner = min, outer = max.
> > - **Why:** **Two independent rules** ➔ "can there be none?" (min) and "can there be many?" (max) are separate business rules.

> [!FAQ]- Translate "a customer may place zero or many orders, each order must belong to exactly one customer".
> - **Hint:** may/must → min.
> > [!SUCCESS]- Answer
> > - **Short answer:** `CUSTOMER ||--o{ ORDER`.
> > - **Why:** **`o{` vs `||`** ➔ "may/zero-or-many" on the order side, "must/exactly-one" on the customer side.
