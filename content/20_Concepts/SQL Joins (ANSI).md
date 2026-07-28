---
unit: [FIT2094, FIT3003]
domain: C
week: [1, 8]
source: [lecture, applied, lab]
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [JOIN, JOIN ON, JOIN USING, NATURAL JOIN, implicit join, old-style join]
---
# [[SQL Joins (ANSI)]]

**Context:** [[FIT2094_MOC]], [[FIT3003_MOC]] · combine rows across tables on a [[Foreign Key and Referential Integrity|PK–FK]] match · SQL form of the [[Relational Algebra Joins|relational-algebra join]] · **ANSI syntax required in FIT2094; FIT3003 lectures and labs use the old-style form**
**Problem it solves:** retrieve columns from two related tables, matching each child row to its parent.

> [!abstract] Quick Revision
> - **🎯 Trigger:** data spans two tables ➔ JOIN ... ON (explicit condition); shortcut to USING/NATURAL only when key names match.
> - **⚡ Key Constraint:** a NATURAL JOIN on tables with **no** common column silently becomes a **Cartesian product**, not a join — as does an old-style join with a missing WHERE condition.

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
| **old-style / implicit** | join condition in `WHERE` | kept (qualify) | one condition per table pair |

### 🔹 Old-style (implicit) join — FIT3003 house syntax
> [!code]- Three-table join: comma-list FROM + join conditions in WHERE
> ```sql
> SELECT ct.cname, ct.cphone, cs.salesdate, cs.purchasedPrice, cs.stampDuty,
>        c.make, c.model
> FROM   customer ct, carsales cs, car c
> WHERE  ct.customerID = cs.customerID
> AND    c.carID       = cs.carID;
> ```
> - **Table alias, no `AS`** ➔ `customer ct`; prefixing every attribute is *recommended* whenever more than one table is involved, to avoid ambiguity.
> - **Condition count** ➔ joining $n$ tables needs $n-1$ join conditions in the WHERE, ANDed with any search conditions.
> 💡 **Common Mistake:** **Missing join condition = PRODUCT, not a join** ➔ FIT3003 warns this exhausts your Oracle quota and **locks your account**; count your ANDs before you run.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Join `MANUFACTURER` and `DRONE_TYPE` on `manuf_id` with a **single** `manuf_id` column in the output, assuming the column name matches in both.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT *
> > FROM   drone.manufacturer
> > JOIN   drone.drone_type USING (manuf_id);
> > ```
> > - **Key move:** USING collapses the shared `manuf_id` to one column (ON would leave two).

> [!QUESTION]- Practice 2 (FIT3003 Lab 1, Q27-style): number of sold cars for each colour, using old-style syntax.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT   colour, COUNT(DISTINCT customerId)
> > FROM     car c, carsales cs
> > WHERE    c.carid = cs.carid
> > GROUP BY colour;
> > ```
> > - **Key move:** the join condition lives in WHERE and runs *before* grouping; the grouping column repeats verbatim in GROUP BY.

## ⚠️ Common Mistakes
- 💡 **Unit-specific syntax rule** ➔ implicit joins are **banned in FIT2094** (marked wrong in all assessments) but **taught and used in FIT3003** — match the syntax to the unit assessing you.
- 💡 **NATURAL JOIN with no shared column = Cartesian product** ➔ every row paired with every row; prefer explicit `JOIN … ON` when unsure.
- 💡 **INNER drops unmatched rows** ➔ to keep a table's rows with no match (or join a table to itself), see [[SQL Self Join and Outer Join]].
