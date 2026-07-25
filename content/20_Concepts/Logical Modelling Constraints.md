---
unit: FIT2094
week: 5
parent: "[[Logical Modelling (ER Mapping)]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
---
# [[Logical Modelling Constraints]]

**Context:** [[FIT2094_MOC]] · structures that **cannot** exist in a logical model · recursive/1:1-total identifying relationships and relationship loops · circular-dependency traps

> [!abstract] Quick Revision
> - **🎯 Objective:** configurations that cannot exist in a valid logical model ➔ circular identification dependencies.
> - **📦 Core Components:** recursive identifying ➔ 1:1 total identifying ➔ relationship loops.
> - **⚡ Key Constraint:** identifying = key inheritance, so any cycle makes a PK depend on itself — fatal.

## 📝 Core
### 1. The Forbidden Configurations
- **Recursive identifying** ➔ a self-referencing unary identifying relationship.
- **1:1 total identifying** ➔ mutual total identifying dependency.
- **Relationship loops** ➔ cycles of identifying relationships.

### 2. Why They Fail
- **Recursive** ➔ a relation's PK would depend on **itself**.
- **1:1 total** ➔ each key/existence depends **entirely** on the other.
- **Loop** ➔ each PK depends on the next ⟹ transitively on itself.

### 3. The Fix
- **Non-identifying** ➔ make the offending relationship an FK **not** in the PK.
- **1:1 total** ➔ usually consolidate into one relation.

## ⚖️ Core Decision Matrix
| Configuration | Problem | Fix |
| :--- | :--- | :--- |
| recursive identifying | PK depends on itself | non-identifying recursive FK |
| 1:1 total identifying | mutual dependency | consolidate / non-identifying |
| identifying loop | circular dependency | break with non-identifying |
| PK self-dependence | unresolvable | — |

> [!NOTE] **When It Flips:** because an identifying relationship makes one PK depend on another, any cycle of identifying relationships is unresolvable; making at least one non-identifying (FK not in PK) preserves the link while breaking the circle. This is why FK/identifier placement must be reasoned about.

## 📊 Exam Execution Trace

### Manual Execution Trace
Tracing a loop:

| Step / State | Edge | Identifying? | Dependency |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | EMPLOYEE→HOBBY | yes | PK depends on EMPLOYEE |
| 2 | HOBBY→RELATION_C | yes | chained |
| 3 | RELATION_C→EMPLOYEE | yes | cycle → self-dependence |

## ⚠️ Common Mistakes
- 💡 **Identifying = key inheritance** ➔ a cycle of identifying relationships makes every PK depend transitively on itself; change one to non-identifying to break it.

## 🧠 Active Recall
> [!FAQ]- Why can a recursive identifying and a 1:1 total identifying relationship not exist?
> - **Hint:** Self / mutual dependence.
> > [!SUCCESS]- Answer
> > - **Short answer:** Recursive identifying → PK depends on itself; 1:1 total identifying → each key depends entirely on the other.
> > - **Why:** **Must be non-identifying** ➔ or (1:1 total) consolidated into one relation.

> [!FAQ]- What is a relationship "loop" and how do you resolve it?
> - **Hint:** Cycle of key inheritance.
> > [!SUCCESS]- Answer
> > - **Short answer:** A cycle of relationships; with identifying ones, each PK depends on the next → transitively on itself.
> > - **Why:** **Break the chain** ➔ make at least one relationship non-identifying.
