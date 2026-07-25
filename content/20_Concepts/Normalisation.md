---
unit: FIT2094
week: 4
parent: "[[Relational Model]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Normalisation]]

**Context:** [[FIT2094_MOC]] · a systematic process refining relations via keys and [[Functional Dependency|FDs]] · UNF → 1NF → 2NF → 3NF · removes [[Database Anomalies|anomalies]]

> [!abstract] Quick Revision
> - **🎯 Objective:** refine relations by keys + FDs to remove [[Database Anomalies|anomalies]] ➔ bottom-up design.
> - **📦 Core Components:** UNF → 1NF (repeating groups) → 2NF (partial) → 3NF (transitive).
> - **⚡ Key Constraint:** each removal spins off a new relation with a PK/FK pair; minimal (not zero) redundancy.

## 📝 Core
### 1. The Process
- **Definition** ➔ progressive refinement analysing [[Primary Key|keys]] + [[Functional Dependency|FDs]].
- **Bottom-up** ➔ builds a schema from forms; also validates top-down ER designs.
- **Scope** ➔ this unit stops at **3NF**.

### 2. The Progression
- **UNF → 1NF** ➔ identify PK, remove repeating groups.
- **1NF → 2NF** ➔ remove **partial** dependencies.
- **2NF → 3NF** ➔ remove **transitive** dependencies.
- **Each removal** ➔ creates a new relation; moved key stays as an FK.

### 3. Goals
- **Valid relations** ➔ entity + referential integrity, no M:N, atomic cells.
- **Single subject per table** ➔ each fact stored once (minimal redundancy).
- **Anomaly-free** ➔ no insert/update/delete anomalies.

## ⚙️ Core Implementation

### 🔹 Resulting 3NF relations (PART)
> [!code]- Mermaid + schema
> ```mermaid
> erDiagram
>   CATEGORY ||--o{ PART : classifies
>   PART ||--o{ RESTOCK : restocked_by
>   VENDOR ||--o{ RESTOCK : supplies
> ```
> $$\text{PART}(\underline{\text{part\_no}}, \text{part\_name}, \text{cat\_code}^{*}, \dots)\quad \text{RESTOCK}(\underline{\text{part\_no}^{*}, \text{vendor\_no}^{*}, \text{restock\_date}}, \dots)$$
> 💡 **Common Mistake:** **Minimal, not zero, redundancy** ➔ PK/FK columns repeat by design; the goal is each *fact* stored once, not every value unique.

## ⚖️ Core Decision Matrix
| Step | Removes | Creates |
| :--- | :--- | :--- |
| UNF→1NF | repeating groups | new relation + PK |
| 1NF→2NF | partial dependencies | new relation |
| 2NF→3NF | transitive dependencies | new relation |
| result | anomalies | single-subject relations |

> [!NOTE] **When It Flips:** normalise each supplied form independently UNF→3NF, then [[Synthesis (Normalisation)|synthesise]] (merge overlapping 3NF relations). It both *builds* a schema from forms and *validates* one from an ER model — the two design directions meet at 3NF.

## 📊 Exam Execution Trace

### Manual Execution Trace
Progression:

| Step / State | Form | Removes |
| :--- | :--- | :--- |
| **0 (Init)** | UNF | — |
| 1 | 1NF | repeating groups |
| 2 | 2NF | partial dependencies |
| 3 | 3NF | transitive dependencies |

### Applied Exercise
**Problem:** State what each normalisation step removes.
**Derivation Proof / Hand-Calculation Walkthrough:**
$$
\begin{aligned}
\text{UNF}\to\text{1NF} &: \text{PK} + \text{remove repeating groups} \\
\text{1NF}\to\text{2NF} &: \text{remove partial}; \quad \text{2NF}\to\text{3NF}: \text{remove transitive}
\end{aligned}
$$
**Final Extracted Output:** each step spins off a new relation, moved key left as an FK.

## 🧠 Active Recall
> [!FAQ]- State the normalisation progression and what is removed at each step.
> - **Hint:** Repeating / partial / transitive.
> > [!SUCCESS]- Answer
> > - **Short answer:** UNF→1NF (PK + repeating groups); 1NF→2NF (partial); 2NF→3NF (transitive).
> > - **Why:** **New relation each step** ➔ moved key stays as an FK.

> [!FAQ]- What are the goals of normalisation, and what does "minimal redundancy" mean?
> - **Hint:** Single subject; fact stored once.
> > [!SUCCESS]- Answer
> > - **Short answer:** Valid relations (integrity, no M:N, atomic), single-subject tables, anomaly-free.
> > - **Why:** **FK columns repeat** ➔ each *fact* once; unavoidable PK/FK duplication remains.
