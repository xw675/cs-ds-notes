---
unit: FIT2094
week: 3
parent: "[[Relational Model]]"
tags: [CS/Databases, Math/SetTheory]
---
# [[Domain (Relational Model)]]

**Context:** [[FIT2094_MOC]] · the set of valid **atomic** values an attribute may hold · constrains type/format/range · enforced as [[Data Integrity|column/domain integrity]]

> [!abstract] Quick Revision
> - **🎯 Objective:** the set of valid atomic values an attribute may take ➔ fixes type, format, range.
> - **📦 Core Components:** $\text{dom}(\cdot)$ ➔ atomic values ➔ [[Data Integrity|column integrity]].
> - **⚡ Key Constraint:** values must be atomic (1NF); union-compatibility needs compatible domains.

## 📝 Core
### 1. The Domain
- **Definition** ➔ the set of valid **atomic** values an attribute can take.
- **Specifies** ➔ data **type, format, valid range**.
- **Source** ➔ every attribute of a [[Relation (Database)|relation]] draws from a domain.

### 2. Atomic Values
- **Indivisible** ➔ one value per attribute per tuple.
- **Forbids** ➔ a multivalued cell (`dependants={Ali|12,Sara|9}`) — [[Relation Properties|1NF]].

### 3. Domains & Queries
- **Column integrity** ➔ all values of an attribute from one domain.
- **Union-compatibility** ➔ [[Set Operations in Relational Algebra|set ops]] need same arity + positionally compatible domains.

**Key identities:**

$$\text{dom}(\text{custno})=\text{customer\_number},\quad \text{dom}(\text{custname})=\text{name}$$
$$\text{dom}(\text{custadd})=\text{address},\quad \text{dom}(\text{custcredlimit})=\text{credit\_limit}$$

> [!NOTE] **When It Flips:** a domain is a *logical* constraint; the DBMS maps it to a concrete column type at physical design. The FIT1058 [[Sets of Numbers|number sets]] are example numeric domains.

## 📊 Exam Execution Trace

### Manual Execution Trace
Validating attribute values:

| Step / State | Attribute | Value | In domain? |
| :--- | :--- | :--- | :--- |
| **0 (Init)** | — | — | — |
| 1 | Age | 25 | yes ($0$–$120$) |
| 2 | Age | "twenty" | no (not integer) |
| 3 | Age | 200 | no (out of range) |

## ⚠️ Common Mistakes
- 💡 **A value outside the domain is rejected** ➔ an `Age` attribute holds integers in $0$–$120$, never the text "twenty" (column/domain integrity).

## 🧠 Active Recall
> [!FAQ]- What is a domain, and how does it relate to data integrity?
> - **Hint:** Valid-value set per attribute.
> > [!SUCCESS]- Answer
> > - **Short answer:** The set of valid atomic values (type/format/range); enforces column/domain integrity.
> > - **Why:** **Same domain** ➔ `Age` accepts $0$–$120$ integers, not "twenty".

> [!FAQ]- Why must domain values be atomic, and where do compatible domains matter?
> - **Hint:** 1NF + union-compatibility.
> > [!SUCCESS]- Answer
> > - **Short answer:** Atomic = one value per cell (1NF); set operations need union-compatible relations (same arity, compatible domains).
> > - **Why:** **Forbids multivalued cells** ➔ `dependants={Ali,Sara}` breaks atomicity.
