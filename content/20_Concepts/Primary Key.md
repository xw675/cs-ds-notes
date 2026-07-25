---
unit: FIT2094
week: 3
parent: "[[Super Key and Candidate Key]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Primary Key]]

**Context:** [[FIT2094_MOC]] · the chosen [[Super Key and Candidate Key|candidate key]] identifying a [[Relation (Database)|relation]] · selected by desirable-key criteria · **natural** vs **surrogate**

> [!abstract] Quick Revision
> - **🎯 Objective:** the one candidate key chosen as the relation's identifier ➔ underlined in schema notation.
> - **📦 Core Components:** desirable-key criteria ➔ natural vs surrogate PK.
> - **⚡ Key Constraint:** carry the natural key through the whole design; add a surrogate only at the last step.

![[primary-key-rules.png]]

## 📝 Core
### 1. The Primary Key
- **Definition** ➔ the one [[Super Key and Candidate Key|candidate key]] chosen as identifier; the rest become **alternate keys**.
- **Notation** ➔ underlined, e.g. $\text{STAFF}(\underline{\text{staff\_id}}, \dots)$.

### 2. Desirable Characteristics
- **Unique + non-NULL** ➔ [[Data Integrity|entity integrity]].
- **Non-intelligent + stable** ➔ no embedded meaning, no change over time.
- **Preferably single-attribute + numeric** ➔ simple FKs, auto-increment.
- **Security-compliant** ➔ never a sensitive value (no TFN/SSN).

### 3. Natural vs Surrogate
- **Natural** ➔ from the scenario (super→candidate→PK), captures business rules.
- **Surrogate** ➔ artificial meaningless id (`enrolment_id`), added by the designer.

**Key identities:**

$$\text{natural: } \text{ENROLMENT}(\underline{\text{unitcode}, \text{student\_id}, \text{enrol\_sem}, \text{enrol\_year}}, \dots)$$
$$\text{surrogate: } \text{ENROLMENT}(\underline{\text{enrolment\_id}}, \text{unitcode}, \text{student\_id}, \text{enrol\_sem}, \text{enrol\_year}, \dots)$$

## ⚖️ Core Decision Matrix
| Criterion | Good PK | Bad PK (name) |
| :--- | :--- | :--- |
| unique | yes | no (shared names) |
| non-intelligent | yes | no (meaningful) |
| stable | yes | no (changes on marriage) |
| single/numeric | yes | no |

> [!NOTE] **When It Flips:** composite natural keys are valid but bloat FKs in children — the motivation for a single numeric surrogate. The PK functionally determines all attributes ([[Functional Dependency]]); it must reflect future data, not just current rows.

## 📊 Exam Execution Trace

### Manual Execution Trace
Testing name as PK:

| Step / State | Criterion | Name passes? |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | unique | no |
| 2 | stable | no (marriage) |
| 3 | non-intelligent | no |

## ⚠️ Common Mistakes
- 💡 **Carry the natural key through the design** ➔ it encodes the business rules; a surrogate is added only at the final step (and is banned at the [[Conceptual Model|conceptual stage]]).

## 🧠 Active Recall
> [!FAQ]- List the desirable characteristics of a primary key and why a name is poor.
> - **Hint:** Unique/stable/non-intelligent.
> > [!SUCCESS]- Answer
> > - **Short answer:** Unique, non-NULL, non-intelligent, stable, preferably single/numeric, security-compliant; a name fails uniqueness, stability, non-intelligence.
> > - **Why:** **PK change cascades** ➔ altering a PK changes identity and forces FK updates.

> [!FAQ]- Contrast a natural and a surrogate primary key, and when each is introduced.
> - **Hint:** Rules vs convenience.
> > [!SUCCESS]- Answer
> > - **Short answer:** Natural = from scenario (captures rules); surrogate = artificial id; natural carried through, surrogate added at the last step.
> > - **Why:** **Banned conceptually** ➔ surrogate replaces an unwieldy composite only at logical/physical design.
