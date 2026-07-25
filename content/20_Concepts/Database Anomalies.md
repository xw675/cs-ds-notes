---
unit: FIT2094
domain: C
week: 4
parent: "[[Normalisation]]"
tags: [CS/Databases, SWE/Design]
---
# [[Database Anomalies]]

**Context:** [[FIT2094_MOC]] · insert, update, delete problems from poor table structure · caused by redundancy · removed by [[Normalisation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** data problems from poor relation structure ➔ redundancy → inconsistency.
> - **📦 Core Components:** insert ➔ update ➔ delete anomalies.
> - **⚡ Key Constraint:** root cause is one table mixing independent subjects; cured by [[Normalisation]].

## 📝 Core
### 1. The Anomalies
- **Insert** ➔ adding data forces unrelated data you may not have.
- **Update** ➔ one fact in many rows ⟹ multi-row edit, risk of inconsistency.
- **Delete** ➔ removing a tuple loses co-located data that existed nowhere else.

### 2. Root Cause
- **One table, many subjects** ➔ drugs *and* reps together.
- **Existence tied** ➔ one subject's existence depends on another's.
- **Fix** ➔ split into single-subject relations ([[Normalisation]]).

## ⚖️ Core Decision Matrix
| Anomaly | Trigger | Consequence |
| :--- | :--- | :--- |
| insert | add data needing another subject | can't add |
| update | fact repeated in rows | inconsistency |
| delete | remove last co-located row | data loss |
| cause | mixed subjects | redundancy |

> [!NOTE] **When It Flips:** update anomalies directly threaten consistency (two mobile numbers for one rep). Diagnosis guides design: which anomaly a table suffers points to the [[Functional Dependency|partial/transitive dependency]] to remove.

## 📊 Exam Execution Trace

### Manual Execution Trace
Diagnosing DRUG/SLSREP:

| Step / State | Operation | Anomaly |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | add new rep | insert |
| 2 | change rep mobile | update |
| 3 | delete rep's only drug | delete |

## ⚠️ Common Mistakes
- 💡 **Anomalies are structural, not data-entry errors** ➔ they persist regardless of care until the schema is normalised.

## 🧠 Active Recall
> [!FAQ]- Describe the insert, update, and delete anomalies with an example each.
> - **Hint:** Redundancy-driven failures.
> > [!SUCCESS]- Answer
> > - **Short answer:** Insert (can't add a rep without a drug); update (rep mobile in many rows); delete (removing last drug loses the rep).
> > - **Why:** **Redundancy** ➔ the same fact repeated makes DML go wrong.

> [!FAQ]- What is the root cause of anomalies, and how does normalisation address it?
> - **Hint:** One subject per relation.
> > [!SUCCESS]- Answer
> > - **Short answer:** A relation storing more than one subject, repeating facts; normalisation decomposes into single-subject relations.
> > - **Why:** **PK–FK links** ➔ each fact stored once, keeping only minimal redundancy.
