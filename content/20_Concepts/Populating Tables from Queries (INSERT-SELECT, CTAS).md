---
unit: FIT2094
domain: C
week: 10
parent: "[[DDL Table Creation]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [INSERT SELECT, CREATE TABLE AS, CTAS]
---
# [[Populating Tables from Queries (INSERT-SELECT, CTAS)]]

**Context:** [[FIT2094_MOC]] · bulk-load a table from a query, not row-by-row [[DML INSERT (Oracle)|VALUES]] · bridges [[SQL SELECT and WHERE|SELECT]] and [[DDL Table Creation|DDL]]
**Problem it solves:** fill (or create+fill) a table with the result of a SELECT over existing tables.

> [!abstract] Quick Revision
> - **🎯 Trigger:** need a table loaded from other tables ➔ INSERT … SELECT (table exists) or CREATE TABLE AS SELECT (build + fill in one step).
> - **⚡ Key Constraint:** **CTAS copies data, not constraints** — no PK/FK; you must add them afterwards with ALTER.

## 🔧 Minimal Working Example
```sql
-- table already exists (with its constraints); populate from a query
INSERT INTO drone_detail (
    SELECT drone_id, drone_pur_date, dt_model
    FROM   drone.drone NATURAL JOIN drone.drone_type
);
```
**Expected output:** `drone_detail` filled with one row per drone; column order matches the SELECT.

- **INSERT … SELECT** ➔ the SELECT's columns feed the target positionally; the target's constraints still apply.
- **CTAS** ➔ `CREATE TABLE drone_detail AS (SELECT drone_id AS dd_id, … FROM …)` builds the table **and** loads it in one statement; aliases become column names.
- **Constraints lost in CTAS** ➔ re-add PK/FK with `ALTER TABLE … ADD CONSTRAINT …` (per [[DDL Table Creation]]).

## 🔀 Variations
- **Build + populate (CTAS)** ➔ `CREATE TABLE drone_detail AS (SELECT drone_id AS dd_id, drone_pur_date AS dd_pur_date, dt_model AS dd_model FROM drone.drone NATURAL JOIN drone.drone_type);`.
- **Create-then-fill** ➔ `CREATE TABLE` + `ALTER … ADD PRIMARY KEY` first, then `INSERT … SELECT` to keep the intended constraints.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Create `drone_detail(dd_id, dd_pur_date, dd_model)` **with a primary key on `dd_id`**, populated from `DRONE ⋈ DRONE_TYPE`. Why can't a single CTAS do it all?
> > [!SUCCESS]- Reference solution
> > ```sql
> > CREATE TABLE drone_detail (
> >     dd_id       NUMBER(5)    NOT NULL,
> >     dd_pur_date DATE         NOT NULL,
> >     dd_model    VARCHAR2(50) NOT NULL );
> > ALTER TABLE drone_detail ADD CONSTRAINT drone_detail_pk PRIMARY KEY (dd_id);
> > INSERT INTO drone_detail (
> >     SELECT drone_id, drone_pur_date, dt_model
> >     FROM drone.drone NATURAL JOIN drone.drone_type );
> > ```
> > - **Key move:** CTAS wouldn't carry the PK, so create-with-constraint first, then INSERT … SELECT.

## ⚠️ Common Mistakes
- 💡 **CTAS drops all constraints** ➔ the new table has data but no PK/FK/UNIQUE/CHECK; add them by ALTER or the table is unprotected.
- 💡 **Column alignment is positional** ➔ INSERT … SELECT matches by position; ensure the SELECT lists columns in the target's order/type.
