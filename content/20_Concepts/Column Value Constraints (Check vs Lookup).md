---
unit: FIT2094
domain: C
week: 6
parent: "[[Data Integrity]]"
tags: [CS/Databases, Tool/SQL, SWE/Design]
aliases: [Check Constraint, Lookup Table]
---
# [[Column Value Constraints (Check vs Lookup)]]

**Context:** [[FIT2094_MOC]] · enforcing [[Data Integrity|column/domain integrity]] · two decisions per attribute — nullability and valid-value set · design choice with [[Personal Data and Privacy in Database Design|privacy]] implications

> [!abstract] Quick Revision
> - **🎯 Objective:** restrict a column to its valid values ➔ inline CHECK for small fixed sets, a lookup table for growing/inclusive sets.
> - **⚡ Key Constraint:** `CHECK` is simple but **hard to extend** (schema change to add a value); a lookup table trades a join for open extensibility.

## 📝 Core
- **Nullability first** ➔ optional attribute ➔ allow NULL (omit constraint); mandatory ➔ `... NOT NULL`; decided by **business need**, not the designer alone.
- **CHECK constraint** ➔ inline value whitelist, e.g. `CHECK (cust_gender IN ('M','F','U'))`; best when the set is **small and stable**.
- **Lookup table** ➔ valid values live as **rows** in a separate table referenced by FK; add a value = insert a row (no DDL).
- **Balance the list** ➔ lookup can sprawl; include only commonly used values.

## ⚖️ Core Decision Matrix
| Strategy | Use when | Pro | Con |
| :--- | :--- | :--- | :--- |
| **CHECK constraint** | few, unlikely-to-change values | simple; enforces consistency | rigid — new value needs `ALTER` (schema change) |
| **Lookup table** | diverse / evolving / inclusive values | extend by `INSERT`; supports inclusive design | extra join; list can grow unmanaged |

## ⚠️ Common Mistakes
- 💡 **`CHECK` hard-codes exclusion** ➔ a gender `CHECK ('M','F','U')` cannot represent non-binary/undisclosed without an `ALTER`; a lookup table avoids re-engineering for inclusive design.
- 💡 **Nullability is a requirement, not a default** ➔ confirm with the client whether an attribute is optional before choosing NULL vs `NOT NULL`.

## 🧠 Active Recall
> [!FAQ]- Gender must currently be M/F/U but the client expects to add inclusive options later — CHECK or lookup, and why?
> > [!SUCCESS]- Answer
> > - **Short answer:** Prefer a **lookup table** — new values are inserted rows, no schema change; `CHECK` would force an `ALTER` each time.
> > - **Why:** **Extensibility** ➔ `CHECK` bakes the value set into DDL; a lookup externalises it to data, supporting inclusive design.
