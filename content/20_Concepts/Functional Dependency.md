---
unit: FIT2094
domain: C
week: [3, 4]
parent: "[[Relation (Database)]]"
tags: [CS/Databases, Math/Discrete]
---
# [[Functional Dependency]]

**Context:** [[FIT2094_MOC]] · $A \to B$: each $A$ value fixes exactly one $B$ value · the determinant–dependent relationship · classified into full/partial/transitive for [[Normalisation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** $A\to B$: each $A$ value fixes exactly one $B$ value ➔ the determinant–dependent relationship.
> - **📦 Core Components:** directional ➔ composite determinant ➔ full/partial/transitive/total.
> - **⚡ Key Constraint:** partial/transitive FDs signal redundancy that [[Normalisation]] removes.

## 📝 Core
### 1. The Dependency
- **Definition** ➔ $A\to B$ iff each $A$ value has **exactly one** $B$ value; $A$ is the **determinant**.
- **Directional** ➔ $\text{orderno}\to\text{orderdate}$ but not the reverse.
- **Composite** ➔ $(\text{orderno},\text{prodno})\to\text{qtyordered}$ (needs both).

### 2. FDs Define Keys
- **Super key** ➔ determines **every** attribute.
- **Candidate key** ➔ a *minimal* such determinant.
- **FIT1058 link** ➔ an FD is a [[Function (Mathematics)|function]] on attribute values.

### 3. Four Kinds (drive [[Normalisation]])
- **Full** ➔ depends on **all** of a composite key (2NF requires).
- **Partial** ➔ depends on **part** of the key (2NF removes).
- **Transitive** ➔ non-key → non-key (3NF removes).
- **Total (mutual)** ➔ $A\to B$ and $B\to A$ (both candidate keys).

## ⚖️ Core Decision Matrix
| Dependency | Determinant | Removed at |
| :--- | :--- | :--- |
| full | whole composite key | (2NF requires) |
| partial | part of key | [[Second Normal Form (2NF)\|2NF]] |
| transitive | non-key | [[Third Normal Form (3NF)\|3NF]] |
| total (mutual) | both candidate keys | — |

> [!NOTE] **When It Flips:** keys are special FDs — a [[Super Key and Candidate Key|super key]] determines the whole tuple. "Bad" FDs (non-key determined by part of a key, or by another non-key) signal the redundancy [[Normalisation]] removes.

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying ASSIGNMENT FDs, key $(\text{proj\_num},\text{emp\_num})$:

| Step / State | FD | Kind |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $(\text{proj\_num},\text{emp\_num})\to\text{hours}$ | full |
| 2 | $\text{proj\_num}\to\text{proj\_name}$ | partial |
| 3 | $\text{job\_class}\to\text{chg\_hour}$ | transitive |

## ⚠️ Common Mistakes
- 💡 **FDs hold for ALL valid data, not one instance** ➔ $A\to B$ is a business rule over every allowed row, not a coincidence in current data.

## 🧠 Active Recall
> [!FAQ]- Define a functional dependency and explain why it is directional.
> - **Hint:** Single-valued mapping.
> > [!SUCCESS]- Answer
> > - **Short answer:** $A\to B$ iff each $A$ value has exactly one $B$ value; $\text{orderno}\to\text{orderdate}$ but not reverse.
> > - **Why:** **Composite** ➔ $(\text{orderno},\text{prodno})\to\text{qtyordered}$ needs both.

> [!FAQ]- Distinguish full, partial, and transitive dependency.
> - **Hint:** Whole key / part / non-key.
> > [!SUCCESS]- Answer
> > - **Short answer:** Full = whole composite key; partial = part of key; transitive = non-key → non-key.
> > - **Why:** **2NF/3NF** ➔ 2NF removes partial, 3NF removes transitive dependencies.
