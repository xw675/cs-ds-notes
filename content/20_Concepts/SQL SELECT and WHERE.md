---
unit: FIT2094
domain: C
week: 8
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [SELECT, WHERE, BETWEEN, IN, LIKE, IS NULL]
---
# [[SQL SELECT and WHERE]]

**Context:** [[FIT2094_MOC]] · the read verb of [[SQL Sublanguages (DDL, DML, DCL)|SQL]] · SQL realisation of [[Select and Project (σ, π)|σ (select) and π (project)]] · every query starts here
**Problem it solves:** retrieve chosen columns from a table, keeping only rows whose predicate evaluates TRUE.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "show rows where…" ➔ SELECT cols FROM schema.table WHERE predicate.
> - **⚡ Key Constraint:** three-valued logic (TRUE/FALSE/UNKNOWN) — a NULL comparison is UNKNOWN, so only TRUE rows return; and AND binds tighter than OR.

## 🔧 Minimal Working Example
```sql
SELECT drone_id, drone_pur_date, drone_flight_time
FROM   drone.drone
WHERE  drone_pur_price > 2000;
```
**Expected output:** the three chosen columns, for only the rows priced over 2000.

- **Two mandatory clauses** ➔ SELECT (columns, or `*` for all) + FROM (table); WHERE is the optional third.
- **Schema prefix** ➔ `drone.drone` reads the table under the DRONE account (you have read access); a bare `drone` looks under *your* account (missing ⟹ error, or wrong table).
- **Predicate toolkit** ➔ comparison `= < > <= >= != <>` · range `BETWEEN 50 AND 100` (inclusive) · set `IN ('DMA2','DSPA')` / `NOT IN` · pattern `LIKE` (`%` = 0+ chars, `_` = exactly one) · null-test `IS NULL` / `IS NOT NULL`.
- **Combine** ➔ `AND`/`OR`/`NOT`; precedence = brackets → NOT → AND → OR (left-to-right within a level).

## 🔀 Variations
- **Range two ways** ➔ `BETWEEN 50 AND 100` ≡ `col >= 50 AND col <= 100`.
- **NOT over a bracket** ➔ `NOT(dt_model='DJI' OR dt_model='PARROT')` ≡ `dt_model!='DJI' AND dt_model!='PARROT'` (De Morgan).

## ✍️ Practice 
> [!QUESTION]- Practice 1: Drones whose model is DJI **or** Parrot (case-insensitive) **and** priced over 500 — show id, model, price.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT drone_id, dt_model, drone_pur_price
> > FROM   drone.drone
> > WHERE  (UPPER(dt_model) = 'DJI' OR UPPER(dt_model) = UPPER('Parrot'))
> >   AND  drone_pur_price > 500;
> > ```
> > - **Key move:** bracket the OR so it resolves before the AND price filter.

## ⚠️ Common Mistakes
- 💡 **`= NULL` never matches** ➔ NULL is UNKNOWN, not a value; test absence with `IS NULL` / `IS NOT NULL`.
- 💡 **AND before OR bites** ➔ `WHERE y=2025 OR y=2026 AND id=5` reads as `y=2025 OR (y=2026 AND id=5)`; bracket to force `(y=2025 OR y=2026) AND id=5`.
