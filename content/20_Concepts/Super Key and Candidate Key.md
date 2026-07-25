---
unit: FIT2094
domain: C
week: 3
parent: "[[Relation (Database)]]"
tags: [CS/Databases, Math/Discrete]
---
# [[Super Key and Candidate Key]]

**Context:** [[FIT2094_MOC]] · a **super key** uniquely identifies a tuple · a **candidate key** is a *minimal* super key · the pool the [[Primary Key]] is chosen from

> [!abstract] Quick Revision
> - **🎯 Objective:** super key uniquely identifies a tuple; candidate key is a minimal super key ➔ the PK pool.
> - **📦 Core Components:** super key (unique) ➔ candidate key (unique + minimal) ➔ primary/alternate.
> - **⚡ Key Constraint:** minimality is the discriminator — every CK is a super key, not vice versa.

## 📝 Core
### 1. The Two Keys
- **Super key** ➔ an attribute set that **uniquely identifies** each tuple.
- **Candidate key** ➔ a super key that is also **minimal (irreducible)**.

### 2. Uniqueness + Minimality
- **Super key** ➔ uniqueness only.
- **Candidate key** ➔ uniqueness **and** can't be reduced.
- **Example** ➔ $\{$StudentID, Name$\}$ is a super key, not a CK (drop Name).

### 3. Primary & Alternate
- **One CK → [[Primary Key]]** ➔ the official identifier.
- **Remaining CKs → alternate keys** ➔ (Email if StudentID is PK).

**Key identities:**

$$\text{STUDENT}(\underline{\text{StudentID}}, \text{Email}, \text{Name}, \text{DOB}),\ \text{StudentID/Email unique}$$
$$\text{super keys}: \{\text{StudentID}\}, \{\text{Email}\}, \{\text{StudentID}, \text{Email}\}, \{\text{Email}, \text{DOB}\}, \dots$$
$$\text{candidate keys (minimal)}: \{\text{StudentID}\}, \{\text{Email}\}$$

## ⚖️ Core Decision Matrix
| Set | Unique? | Minimal? | Type |
| :--- | :--- | :--- | :--- |
| $\{$StudentID$\}$ | yes | yes | candidate key |
| $\{$Email$\}$ | yes | yes | candidate key |
| $\{$StudentID, Name$\}$ | yes | no | super key only |
| $\{$Name$\}$ | no | — | not a key |

> [!NOTE] **When It Flips:** keys are maximal [[Functional Dependency|functional dependencies]] — a super key determines all attributes, a CK is a minimal determinant. Design procedure: super keys → candidate keys → [[Primary Key]]. Minimality echoes the FIT1058 [[Subset and Superset|minimal-set]] idea.

## 📊 Exam Execution Trace

### Manual Execution Trace
Classifying STUDENT sets:

| Step / State | Set | Verdict |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | $\{$StudentID$\}$ | candidate key |
| 2 | $\{$StudentID, Email$\}$ | super key (not minimal) |
| 3 | $\{$Email$\}$ | candidate key |

## ⚠️ Common Mistakes
- 💡 **The full attribute set is always a super key** ➔ tuples are unique ([[Relation Properties]]); candidate keys are only the *minimal* ones.

## 🧠 Active Recall
> [!FAQ]- Distinguish a super key from a candidate key, with the STUDENT example.
> - **Hint:** Minimality.
> > [!SUCCESS]- Answer
> > - **Short answer:** Super key = uniquely identifies; candidate key = minimal super key; STUDENT CKs are $\{$StudentID$\}$, $\{$Email$\}$.
> > - **Why:** **Redundant attribute** ➔ any other super key contains a droppable attribute.

> [!FAQ]- What is the relationship between candidate, primary, and alternate keys?
> - **Hint:** Choose one CK.
> > [!SUCCESS]- Answer
> > - **Short answer:** One candidate key becomes the primary key; the rest become alternate keys.
> > - **Why:** **Desirable-key criteria** ➔ the PK is picked by unique/stable/single/numeric.
