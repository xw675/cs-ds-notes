---
unit: FIT2094
domain: C
week: 3
parent: "[[Relation (Database)]]"
tags: [CS/Databases, Math/SetTheory]
---
# [[Relation Properties]]

**Context:** [[FIT2094_MOC]] · the set-derived rules every [[Relation (Database)|relation]] obeys · no duplicates, unordered, atomic · what separates a relation from a table

> [!abstract] Quick Revision
> - **🎯 Objective:** a relation body is a set of tuples ➔ four properties follow.
> - **📦 Core Components:** no duplicate tuples ➔ tuples unordered ➔ attributes unordered ➔ atomic values.
> - **⚡ Key Constraint:** atomic values = First Normal Form; access is always **by content**, never by position.

## 📝 Core
### 1. The Four Properties
- **No duplicate tuples** ➔ a set has no repeats.
- **Tuples unordered** ➔ no "first"/"third" tuple; access by content.
- **Attributes unordered** ➔ access by name, not column position.
- **Atomic values** ➔ one indivisible value per attribute per tuple.

### 2. Atomicity = 1NF
- **Breaks atomicity** ➔ `dependants = {Ali|12, Sara|9}` in one cell (repeating values).
- **1NF fix** ➔ move to a separate relation, not one attribute.

### 3. Relation vs Table
- **Table** ➔ may have duplicate/ordered rows, composite cells.
- **Relation** ➔ forbids duplicates, unordered, atomic — logical structure with integrity.

## ⚖️ Core Decision Matrix
| Property | From | Consequence |
| :--- | :--- | :--- |
| no duplicates | set | a [[Super Key and Candidate Key\|super key]] always exists |
| tuples unordered | set | access by content |
| attributes unordered | set | access by name |
| atomic values | 1NF rule | dependencies/joins well-defined |

> [!NOTE] **When It Flips:** unordered tuples force declarative [[Relational Algebra]]/SQL querying by value; tuple uniqueness guarantees the full attribute set is a super key. SQL tables relax some rules (permit duplicate rows unless constrained).

## 📊 Exam Execution Trace

### Manual Execution Trace
Checking a candidate relation:

| Step / State | Check | Verdict |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | duplicate tuple? | forbidden |
| 2 | access by row number? | invalid |
| 3 | `dependants={Ali,Sara}` | breaks 1NF |

## ⚠️ Common Mistakes
- 💡 **Never name a tuple by position** ➔ tuples are unordered, so access is always by attribute value; a multivalued cell violates atomicity (1NF).

## 🧠 Active Recall
> [!FAQ]- State the four properties of a relation and why each follows from it being a set.
> - **Hint:** Set ⟹ properties.
> > [!SUCCESS]- Answer
> > - **Short answer:** No duplicate tuples, tuples unordered, attributes unordered, atomic values.
> > - **Why:** **First three from set** ➔ atomicity is the extra 1NF rule.

> [!FAQ]- How does a relation differ from a tabular representation, and the link to 1NF?
> - **Hint:** Display vs structure.
> > [!SUCCESS]- Answer
> > - **Short answer:** Tables allow duplicate/ordered rows and composite cells; relations forbid all three.
> > - **Why:** **1NF** ➔ atomic-value rule moves multivalued data to a separate relation.
