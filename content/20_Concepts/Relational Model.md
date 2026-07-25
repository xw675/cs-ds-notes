---
unit: FIT2094
week: 3
parent: "[[Conceptual vs Logical Model]]"
tags: [CS/Databases, Math/SetTheory]
---
# [[Relational Model]]

**Context:** [[FIT2094_MOC]] · Codd's (1970) model representing data as mathematical **relations** · the basis of modern RDBMSs · the logical model a [[Conceptual vs Logical Model|conceptual design maps to]]

> [!abstract] Quick Revision
> - **🎯 Objective:** represent data as mathematical relations (Codd 1970) ➔ access by content, not navigation.
> - **📦 Core Components:** [[Relation (Database)|relation]] ➔ [[Domain (Relational Model)|domain]] ➔ [[Relational Algebra]].
> - **⚡ Key Constraint:** a relation is an abstract **set**, not a table; classical model assumes complete info (no NULLs).

## 📝 Core
### 1. The Model
- **Definition** ➔ Codd (1970): data as mathematical **[[Relation (Database)|relations]]** (visualised as tables).
- **Superseded** ➔ hierarchical (tree) and network (multi-parent), both **navigational** (pointer-following).
- **Relational access** ➔ by **content**, not navigation.

### 2. Core Elements
- **Relation = abstract set** ➔ the table is only a visualisation; drives the [[Relation Properties]].
- **[[Domain (Relational Model)|Domain]]** ➔ valid atomic values per attribute (type/format/range).

### 3. Why It Won
- **Rigorous** ➔ built on [[Set (Mathematics)|set theory]].
- **Declarative** ➔ non-navigational access by value.
- **Closure** ➔ [[Relational Algebra]] results are relations, so queries compose.

## ⚖️ Core Decision Matrix
| Model | Access | Structure |
| :--- | :--- | :--- |
| hierarchical | navigational | tree (one parent) |
| network | navigational | graph (multi-parent) |
| **relational** | by content | set of relations |
| logical vs physical | portable | vendor storage differs |

> [!NOTE] **When It Flips:** the logical relation is independent of the physical binary storage — the separation that makes relational designs portable across vendors. A relation *is* the FIT1058 [[n-ary Relation]]; the ER design becomes relations in the [[Conceptual vs Logical Model|logical model]].

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying access:

| Step / State | Model | Access |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | hierarchical | navigate pointers |
| 2 | network | navigate multi-parent |
| 3 | relational | condition on values |

## ⚠️ Common Mistakes
- 💡 **Relation ≠ table** ➔ a relation is a *set* of tuples (no duplicates, unordered, atomic); a table is a display that may have duplicate/ordered rows.

## 🧠 Active Recall
> [!FAQ]- What does the relational model represent data with, and how does it differ from hierarchical/network models?
> - **Hint:** Content vs navigation.
> > [!SUCCESS]- Answer
> > - **Short answer:** Data as mathematical relations (Codd 1970); earlier models were navigational (pointer traversal).
> > - **Why:** **By content** ➔ relational access states conditions on attribute values.

> [!FAQ]- Why is it wrong to treat a relation and a table as the same thing?
> - **Hint:** Set vs display.
> > [!SUCCESS]- Answer
> > - **Short answer:** A relation is a *set* of tuples (no duplicates, unordered, atomic); a table is a visual display.
> > - **Why:** **Integrity rules** ➔ the relation carries the [[Relation Properties]]; a table may not.
