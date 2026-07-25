---
unit: FIT2094
week: 8
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [JOIN, JOIN ON, JOIN USING, NATURAL JOIN]
---
# [[SQL Joins (ANSI)]]

**Context:** [[FIT2094_MOC]] · combine rows across tables on a [[Foreign Key and Referential Integrity|PK–FK]] match · SQL form of the [[Relational Algebra Joins|relational-algebra join]] · **ANSI syntax required**
**Problem it solves:** retrieve columns from two related tables, matching each child row to its parent.

> [!abstract] Quick Revision
> - **🎯 Trigger:** data spans two tables ➔ JOIN ... ON (explicit condition); shortcut to USING/NATURAL only when key names match.
> - **⚡ Key Constraint:** a NATURAL JOIN on tables with **no** common column silently becomes a **Cartesian product**, not a join.

![[natural-join-a.png]]
![[natural-join-b.png]]

## 🔧 Minimal Working Example
```sql
SELECT *
FROM   drone.manufacturer
JOIN   drone.drone_type
ON     manufacturer.manuf_id = drone_type.manuf_id;
```
**Expected output:** manufacturers matched to their drone types; the result has **two** `manuf_id` columns (one per table).

- **JOIN … ON** ➔ most flexible/reliable; state the equi-join condition explicitly; works even when key columns are **named differently**; keeps both columns (duplicate).
- **Prefix duplicates** ➔ with duplicate names you must qualify: `manufacturer.manuf_id`.
- **JOIN … USING (col)** ➔ when both tables share the column name; **removes** the duplicate column.
- **NATURAL JOIN** ➔ no condition; auto-joins on **all** same-named columns and drops duplicates.

## 🔀 Variations
| Form | Condition | Duplicate col? | Requires |
| :--- | :--- | :--- | :--- |
| **JOIN … ON** | explicit `ON a=b` | kept (qualify) | nothing (any names) |
| **JOIN … USING** | `USING (col)` | removed | same column name |
| **NATURAL JOIN** | implicit (all common names) | removed | same column name(s) |

## ✍️ Practice 
> [!QUESTION]- Practice 1: Join `MANUFACTURER` and `DRONE_TYPE` on `manuf_id` with a **single** `manuf_id` column in the output, assuming the column name matches in both.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT *
> > FROM   drone.manufacturer
> > JOIN   drone.drone_type USING (manuf_id);
> > ```
> > - **Key move:** USING collapses the shared `manuf_id` to one column (ON would leave two).

## ⚠️ Common Mistakes
- 💡 **Never use implicit joins** ➔ `FROM t1, t2 WHERE t1.id=t2.id` is banned in this unit; always ANSI `JOIN`.
- 💡 **NATURAL JOIN with no shared column = Cartesian product** ➔ every row paired with every row; prefer explicit `JOIN … ON` when unsure.
- 💡 **INNER drops unmatched rows** ➔ to keep a table's rows with no match (or join a table to itself), see [[SQL Self Join and Outer Join]].
