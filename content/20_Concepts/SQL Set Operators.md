---
unit: FIT2094
week: 10
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, SQL/Oracle, Monash/CS_DS]
type: pattern
aliases: [UNION, UNION ALL, INTERSECT, MINUS, Set Operators]
---
# [[SQL Set Operators]]

**Context:** [[FIT2094_MOC]] · combine whole result sets vertically · the SQL form of [[Set Operations in Relational Algebra|∪ ∩ − set algebra]] · needs union-compatible queries
**Problem it solves:** merge, intersect, or subtract the row sets of two SELECTs into one result.

> [!abstract] Quick Revision
> - **🎯 Trigger:** combine rows of two queries ➔ UNION / UNION ALL (∪), INTERSECT (∩), MINUS (−).
> - **⚡ Key Constraint:** both queries must be **union-compatible** — same column count, compatible types; output names come from the **first** query.

![[relational-algebra-set-operation.png]]

## 🔧 Minimal Working Example
```sql
SELECT drone_id FROM drone.drone      -- set 1: all drones
MINUS
SELECT drone_id FROM drone.rental     -- set 2: drones ever rented
ORDER BY drone_id;                    -- result: drones NEVER rented
```
**Expected output:** `drone_id`s in set 1 but not set 2 — the never-rented drones.

- **UNION ALL** ➔ all rows from both, **keeps** duplicates.
- **UNION** ➔ all rows from both, **duplicates removed**.
- **INTERSECT** ➔ rows appearing in **both** queries.
- **MINUS** ➔ rows in the first query **not** in the second.
- **Union-compatible** ➔ equal column count + compatible types; a single trailing `ORDER BY` applies to the whole result.

## 🔀 Variations
| Operator | Returns | Duplicates |
| :--- | :--- | :--- |
| **UNION ALL** | everything from both | kept |
| **UNION** | everything from both | removed |
| **INTERSECT** | rows in both | n/a |
| **MINUS** | in first, not second | n/a |

- **UNION with labels** ➔ combine `WHERE emp_type='F'` (label `'Full Time'`) with `WHERE emp_type='C'` (label `'Casual'`), then `ORDER BY emp_no`.
- **INTERSECT** ➔ `SELECT emp_lname FROM drone.employee INTERSECT SELECT cust_lname FROM drone.customer` — surnames in both.

## ✍️ Practice 
> [!QUESTION]- Practice 1: List surnames that appear in **both** `EMPLOYEE` (`emp_lname`) and `CUSTOMER` (`cust_lname`), ordered.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT emp_lname  FROM drone.employee
> > INTERSECT
> > SELECT cust_lname FROM drone.customer
> > ORDER BY emp_lname;
> > ```
> > - **Key move:** INTERSECT keeps the overlap; both sides are single, type-compatible columns.

## ⚠️ Common Mistakes
- 💡 **Not union-compatible = error** ➔ mismatched column counts or incompatible types are rejected; align the SELECT lists.
- 💡 **One ORDER BY, at the very end** ➔ ordering belongs to the combined result, using the first query's column names.
