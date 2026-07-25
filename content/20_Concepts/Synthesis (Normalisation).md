---
unit: FIT2094
week: 4
parent: "[[Normalisation]]"
tags: [CS/Databases, SWE/Design]
---
# [[Synthesis (Normalisation)]]

**Context:** [[FIT2094_MOC]] · combine the [[Third Normal Form (3NF)|3NF]] relations from **multiple forms** · merge relations representing the **same thing** · the final integration step

> [!abstract] Quick Revision
> - **🎯 Objective:** merge 3NF relations from multiple forms representing the same subject ➔ final integration.
> - **📦 Core Components:** normalise each form independently ➔ merge same-PK relations (union of attributes).
> - **⚡ Key Constraint:** only for multiple forms; done **last**, after every form is at 3NF.

## 📝 Core
### 1. The Step
- **Definition** ➔ after each form is at [[Third Normal Form (3NF)|3NF]], combine duplicate/overlapping relations that model the **same thing**.
- **Result** ➔ one relation holding all their attributes.

### 2. When & How
- **Multiple forms** ➔ each normalised independently (full UNF→3NF).
- **Same subject** ➔ different forms often produce relations for the same subject.
- **Merge** ➔ union of attributes → integrated, duplication-free schema.

### 3. Scope
- **Same PK ⟹ same subject** ➔ merge candidates.
- **Single form** ➔ no synthesis needed.

> [!NOTE] **When It Flips:** without synthesis, the same subject persists as two near-duplicate relations across forms — reintroducing cross-form redundancy and the [[Database Anomalies|anomalies]] normalisation removed. It reconciles bottom-up results, complementing top-down ER design.

## 📊 Exam Execution Trace

### Manual Execution Trace
Merging DRONE:

| Step / State | Source | Attributes |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | Service DRONE | +drone_decom_date |
| 2 | Rental DRONE | drone_pur_date |
| 3 | merged | union of both |

## ⚠️ Common Mistakes
- 💡 **Do it last** ➔ merging before every form is at 3NF risks combining partially-normalised structure and reintroducing partial/transitive dependencies.

## 🧠 Active Recall
> [!FAQ]- What is synthesis, when is it needed, and how do you decide which relations to merge?
> - **Hint:** Same PK + subject.
> > [!SUCCESS]- Answer
> > - **Short answer:** Merge 3NF relations from multiple forms that model the same subject (same PK), keeping the union of attributes; only needed for multiple forms.
> > - **Why:** **Overlap** ➔ two `DRONE(drone_id, …)` become one with all attributes.

> [!FAQ]- Why is synthesis performed last, and what happens without it?
> - **Hint:** After 3NF; cross-form redundancy.
> > [!SUCCESS]- Answer
> > - **Short answer:** Done after every form is at 3NF; without it the same subject persists as near-duplicate relations.
> > - **Why:** **Reintroduces anomalies** ➔ merging early risks partial/transitive dependencies.
