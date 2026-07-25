---
unit: FIT2094
week: 8
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [ORDER BY, DISTINCT, Alias, NULLS FIRST, NULLS LAST]
---
# [[SQL Sorting, Distinct & Alias]]

**Context:** [[FIT2094_MOC]] · shapes the *result set* of a [[SQL SELECT and WHERE|SELECT]] · computed columns, ordering, de-duplication
**Problem it solves:** compute/rename columns, order the rows deterministically, and drop duplicate rows.

> [!abstract] Quick Revision
> - **🎯 Trigger:** need computed columns, a stable sort, or duplicate-free output ➔ arithmetic + AS alias, ORDER BY, DISTINCT.
> - **⚡ Key Constraint:** without ORDER BY row order is DBMS-arbitrary; and Oracle sorts NULLs as the **largest** value by default.

## 🔧 Minimal Working Example
```sql
SELECT drone_id, drone_cost_hr/60 AS costpermin
FROM   drone.drone
ORDER BY drone_flight_time DESC, drone_id;
```
**Expected output:** a computed `costpermin` column; rows by flight time high→low, ties broken by `drone_id` ascending.

- **Arithmetic in SELECT** ➔ `+ - * /` on columns; raw heading `DRONE_COST_HR/60` is ugly ➔ rename with `AS`.
- **Alias** ➔ `AS costpermin`; use double quotes for spaces/symbols: `AS "COST/MIN"`.
- **ORDER BY** ➔ default `ASC`; `DESC` for high→low; multi-column = primary then tie-breaker.
- **DISTINCT** ➔ `SELECT DISTINCT drone_id ...` collapses repeats to one row each.
- **NULL placement** ➔ override the default with `NULLS FIRST` / `NULLS LAST`.

## 🔀 Variations
- **Sort by alias or expression** ➔ `ORDER BY "Taxed Price" DESC` ≡ `ORDER BY drone_pur_price*1.1 DESC` (alias is allowed in ORDER BY).
- **Unreturned rentals on top** ➔ `ORDER BY rent_in_dt NULLS FIRST` surfaces NULL (not-yet-returned) rows first.

## ✍️ Practice 
> [!QUESTION]- Practice 1: List each distinct rented `drone_id` from `RENTAL`, ascending.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT DISTINCT drone_id
> > FROM   drone.rental
> > ORDER BY drone_id;
> > ```
> > - **Key move:** DISTINCT removes the one-row-per-rental repeats before ordering.

## ⚠️ Common Mistakes
- 💡 **No ORDER BY = no guaranteed order** ➔ never assume insertion or PK order; add ORDER BY whenever output may be multi-row.
- 💡 **NULLs default to "largest"** ➔ in an ascending sort they land at the **bottom**; use `NULLS FIRST`/`NULLS LAST` when that is wrong for the task.
