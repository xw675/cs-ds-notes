---
unit: FIT2094
week: 2
parent: "[[Database Design Life Cycle]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Conceptual Model]]

**Context:** [[FIT2094_MOC]] · a high-level, technology-independent view of the data · built with [[Entity Relationship Diagram (ERD)|ER modelling]] · must capture *exactly* the brief

> [!abstract] Quick Revision
> - **🎯 Objective:** describe *which* data matter, not how stored ➔ technology-independent, stakeholder-readable.
> - **📦 Core Components:** technology independence ➔ stakeholder readability ➔ built with [[Entity Relationship Diagram (ERD)|ER]].
> - **⚡ Key Constraint:** capture **exactly** the brief — nothing missing, nothing invented.

## 📝 Core
### 1. The Model
- **Definition** ➔ high-level, **technology-independent** view of *which* data matter.
- **Deliverable** ➔ of the conceptual-design stage of the [[Database Design Life Cycle]].
- **Built with** ➔ [[Entity Relationship Diagram (ERD)|ER modelling]].

### 2. Two Characteristics
- **Technology independence** ➔ not bound to any database/platform/implementation.
- **Stakeholder readability** ➔ a **common language** between technical and non-technical people.

### 3. The Modelling Rule
- **Both directions** ➔ everything in the brief included; nothing not in the brief added.
- **No invented structure** ➔ plausible-but-unstated relationships violate the rule.
- **Notations** ➔ Chen vs **Crow's Foot** (unit standard); methodologies UML/ER/semantic.

## ⚙️ Core Implementation

### 🔹 A minimal conceptual ER fragment
> [!code]- Mermaid erDiagram
> ```mermaid
> erDiagram
>   STUDENT ||--o{ ENROLMENT : has
>   UNIT ||--o{ ENROLMENT : in
>   STUDENT { string student_id }
>   UNIT { string unit_code }
> ```
> 💡 **Common Mistake:** **Conceptual ≠ logical** ➔ keep M:N relationships and multivalued attributes at the conceptual stage; surrogate keys are **banned** here — resolve only in [[Conceptual vs Logical Model|logical modelling]].

## ⚖️ Core Decision Matrix
| Aspect | Conceptual | Logical |
| :--- | :--- | :--- |
| technology | independent | DB type (relational) |
| keys | natural only, no surrogate | PK/FK added |
| M:N | kept | resolved to bridge table |
| audience | all stakeholders | designers |

> [!NOTE] **When It Flips:** abstraction lets stakeholders agree on *meaning* before choosing a platform. The rule "all-and-only the brief" is absolute — even a real-world-plausible relationship not in the brief must not be added.

## 📊 Exam Execution Trace

### Manual Execution Trace
Applying the modelling rule:

| Step / State | Item | In brief? | Include? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | STUDENT entity | yes | yes |
| 2 | STUDENT–UNIT enrols | yes | yes |
| 3 | STUDENT "has a car" | no | **no** |

### Applied Exercise
**Problem:** The brief lists STUDENT, UNIT, and enrolment. A designer adds a LIBRARY_CARD entity (realistic but unstated). Valid?
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{rule} &: \text{include} \iff \text{in brief} \\
\text{LIBRARY\_CARD} \notin \text{brief} &\Rightarrow \text{must NOT be added}
\end{aligned}
$$
**Final Extracted Output:** invalid — adding unstated structure violates the "all-and-only" rule.

## 🧠 Active Recall
> [!FAQ]- What are the two key characteristics of a conceptual model, and why do they matter?
> - **Hint:** Common language before platform.
> > [!SUCCESS]- Answer
> > - **Short answer:** Technology independence + stakeholder readability.
> > - **Why:** **Agree on meaning early** ➔ non-technical + technical stakeholders align before any vendor commitment, cutting late redesign.

> [!FAQ]- State the rule a valid conceptual model must satisfy, and a consequence.
> - **Hint:** Both directions.
> > [!SUCCESS]- Answer
> > - **Short answer:** All that is in the brief is included, and all that is included was in the brief.
> > - **Why:** **No invention** ➔ a plausible relationship not in the brief (or derivable from existing ones) must not be added.
