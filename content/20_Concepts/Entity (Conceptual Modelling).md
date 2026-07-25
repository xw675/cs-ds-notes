---
unit: FIT2094
week: 2
parent: "[[Entity Relationship Diagram (ERD)]]"
tags: [CS/Databases, SWE/Design]
---
# [[Entity (Conceptual Modelling)]]

**Context:** [[FIT2094_MOC]] · a real-world object data is collected about · drawn as a Crow's Foot box · **strong** (independent) vs **weak** (identity-dependent)

> [!abstract] Quick Revision
> - **🎯 Objective:** a real-world object data is collected about ➔ a keyed Crow's Foot box.
> - **📦 Core Components:** name / attributes / key column ➔ strong vs weak.
> - **⚡ Key Constraint:** weak entity needs a parent's key **in** its own key + an identifying relationship.

## 📝 Core
### 1. The Entity
- **Definition** ➔ a real-world object/concept data is collected about (`CUSTOMER`, `ORDER`).
- **Crow's Foot box** ➔ three partitions: **name**, **attributes**, **key label**.
- **Needs a key** ➔ uniquely identifies each instance.

### 2. Strong vs Weak
- **Strong** ➔ own unique key, exists independently (`STUDENT`/`student_id`).
- **Weak** ➔ can't be identified alone; key **includes** a strong entity's key (`DEPENDENT` re-uses `emp_no`).
- **Crow's Foot weak** ➔ composite key with parent's key + [[Identifying vs Non-Identifying Relationship|identifying relationship]] (solid line).

### 3. Multivalued Attribute
- **No symbol** ➔ Crow's Foot has none, so a multivalued attribute (`car_color`) becomes its own **weak entity**.

**Key identities:**

$$\text{PROFESSOR}(\underline{\text{prof\_id}}, \text{name}) \quad(\text{strong})$$
$$\text{CLASS}(\underline{\text{prof\_id}}, \underline{\text{class\_no}}, \text{class\_day}, \dots),\ \text{prof\_id}^*\ (\text{weak})$$

## ⚖️ Core Decision Matrix
| Property | Strong | Weak |
| :--- | :--- | :--- |
| identity | self-contained | borrows parent's key |
| key | own | composite incl. parent PK |
| relationship | any | **identifying** (solid) |
| example | EMPLOYEE | DEPENDENT |

> [!NOTE] **When It Flips:** weak ⟹ identifying relationship — the two ideas always travel together. The identity test decides: if the entity's own attributes uniquely identify it, it is strong; if it must borrow a parent's key, it is weak.

## 📊 Exam Execution Trace

### Manual Execution Trace
Deciding CLASS strong/weak:

| Step / State | Check | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | is `class_no` unique alone? | no (restarts per prof) |
| 2 | needs `prof_id`? | yes |
| 3 | verdict | CLASS weak, PROFESSOR strong |

## ⚠️ Common Mistakes
- 💡 **`class_no` restarts per professor** ➔ not unique alone, so CLASS's key needs `prof_id` too — the identity test that makes it weak; a surrogate key would resolve it but is **banned conceptually**.

## 🧠 Active Recall
> [!FAQ]- Distinguish a strong from a weak entity, and how each is shown in Crow's Foot.
> - **Hint:** Own key vs borrowed key.
> > [!SUCCESS]- Answer
> > - **Short answer:** Strong = own unique key, independent; weak = key includes a parent's key.
> > - **Why:** **No double box** ➔ Crow's Foot marks weak by composite key + identifying (solid) relationship, unlike Chen's double rectangle.

> [!FAQ]- Given $(\text{prof\_id},\text{class\_no},\dots)$ with per-professor class numbering, is CLASS strong or weak?
> - **Hint:** Uniqueness test.
> > [!SUCCESS]- Answer
> > - **Short answer:** CLASS is weak; PROFESSOR is strong.
> > - **Why:** **Composite key** ➔ `class_no` restarts per professor, so identity needs `prof_id` + `class_no`.
