---
unit: FIT2094
week: 4
parent: "[[Normalisation]]"
tags: [CS/Databases, SWE/Design, Monash/CS_DS]
aliases: [UNF]
---
# [[Unnormalised Form (UNF)]]

**Context:** [[FIT2094_MOC]] · the starting point of [[Normalisation]] · a form mapped directly to a relation · **repeating groups in brackets**, no PK

> [!abstract] Quick Revision
> - **🎯 Objective:** map a client form directly to a relation before [[Normalisation]] ➔ raw starting point.
> - **📦 Core Components:** subject name ➔ all attributes ➔ repeating group in brackets.
> - **⚡ Key Constraint:** no PK yet; a UNF is **not** a valid relation; don't flatten.

## 📝 Core
### 1. The UNF
- **Definition** ➔ the relation mapped **directly** from a form, before normalisation.
- **Single named** ➔ name by subject, not pluralised.
- **No PK yet** ➔ and repeating groups in **brackets**.

### 2. Building It
- **Name by subject** ➔ what the form represents.
- **List all attributes** ➔ faithfully.
- **Bracket the repeating group** ➔ attributes multivalued for one subject instance.

### 3. Rules
- **Not a valid relation** ➔ has a repeating group / non-atomic structure.
- **No PK, no flattening** ➔ don't indicate a PK; don't expand into tabular rows.
- **No repeating group** ➔ maps to a single relation through to 3NF.

> [!NOTE] **When It Flips:** an accurate UNF ensures the business rules survive into the normalised schema; errors here propagate. Multivalued attributes are the repeating groups ([[Attribute (Conceptual Modelling)]]); the bracketed group is what 1NF splits out.

## 📊 Exam Execution Trace

### Manual Execution Trace
Building the UNF:

| Step / State | Action | Result |
| :--- | :--- | :--- |
| **0 (Init)** | — | — |
| 1 | name by subject | PART |
| 2 | list attributes | part_no, …, part_sell |
| 3 | bracket repeating | (vendor_no, …, restock_payment) |

## ⚠️ Common Mistakes
- 💡 **No PK, no flattening at UNF** ➔ don't indicate a primary key and don't expand the repeating data into rows; brackets capture the repeating group [[First Normal Form (1NF)|1NF]] will remove.

## 🧠 Active Recall
> [!FAQ]- How do you represent a form as a UNF, and what must you not do?
> - **Hint:** Subject + bracketed repeating group.
> > [!SUCCESS]- Answer
> > - **Short answer:** Name by subject, list all attributes, bracket the repeating group; don't indicate a PK or flatten into rows.
> > - **Why:** **As presented** ➔ transcribe faithfully; design decisions come later.

> [!FAQ]- Why is a UNF not a valid relation, and what if a form has no repeating group?
> - **Hint:** Non-atomic + no key.
> > [!SUCCESS]- Answer
> > - **Short answer:** It has a repeating group and no PK, breaking the relation properties; a form with none maps to one relation.
> > - **Why:** **1NF adds only a PK** ➔ no new relation when there is no repeating group.
