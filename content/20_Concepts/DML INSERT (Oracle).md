---
unit: FIT2094
week: 7
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, SQL/Oracle, Monash/CS_DS]
type: pattern
aliases: [INSERT, TO_DATE, SEQUENCE, NEXTVAL, CURRVAL]
---
# [[DML INSERT (Oracle)]]

**Context:** [[FIT2094_MOC]] · add rows to a populated schema · the first [[SQL Sublanguages (DDL, DML, DCL)|DML]] verb · dates and numeric PKs need helpers
**Problem it solves:** add a new row, supplying a typed [[Oracle Data Types|DATE]], a generated numeric PK, and NULLs for optional columns.

> [!abstract] Quick Revision
> - **🎯 Trigger:** new row to add ➔ INSERT with a **column list** (positional pairing) + TO_DATE for dates + a SEQUENCE for numeric PKs.
> - **⚡ Key Constraint:** a date literal `'10/Dec/2022'` is a **string, not a date** — always wrap with TO_DATE; and call NEXTVAL before CURRVAL.

## 🔧 Minimal Working Example
```sql
-- named columns: order is free, missing nullable columns default to NULL
INSERT INTO drone (drone_id, drone_pur_date, drone_pur_price, drone_flight_time, drone_cost_hr, dt_code)
VALUES (200, TO_DATE('10 Dec 2022','DD Mon YYYY'), 1200.10, 0, 120, 'DIN2');
```
**Expected output:** 1 row in `drone`; the omitted `drone_decom_date` is NULL.

- **Named vs positional** ➔ with a column list, name–value pairing is positional but column *order is free*; without it you must supply **every** column in table order (write `NULL` explicitly for optional ones).
- **TO_DATE** ➔ `TO_DATE('23/AUG/2022 13:00','DD/MON/YYYY HH24:MI')`; string case and picture-clause case must match (`Dec`↔`Mon`).
- **SEQUENCE for PKs** ➔ `CREATE SEQUENCE manuf_seq START WITH 100 INCREMENT BY 1;` then `manuf_seq.NEXTVAL` (advance) / `manuf_seq.CURRVAL` (reuse same value in a later insert).

## 🔀 Variations
- **No column list** ➔ `INSERT INTO drone VALUES (200, TO_DATE(...), 1200.10, 0, 120, NULL, 'DIN2');` — all columns, NULL placed positionally.
- **Reuse a generated key** ➔ parent uses `seq.NEXTVAL`, child reuses `seq.CURRVAL` for the same value within the session.

## ✍️ Practice
> [!QUESTION]- Practice 1: Insert manufacturer `'Monash Drones'` with a sequence-generated PK, then a `drone_type` row reusing that same manufacturer id.
> > [!SUCCESS]- Reference solution
> > ```sql
> > INSERT INTO manufacturer VALUES (manuf_seq.NEXTVAL, 'Monash Drones');
> > INSERT INTO drone_type VALUES ('DJIT','DJI Trello',5,'DJIHY', manuf_seq.CURRVAL);
> > ```
> > - **Key move:** NEXTVAL first (creates the current value), CURRVAL reuses it — never hardcode the id.

## ⚠️ Common Mistakes
- 💡 **Date strings silently misparse** ➔ `'10/12/2026'` is DD/MM or MM/DD depending on locale; TO_DATE with an explicit picture clause removes the ambiguity.
- 💡 **CURRVAL before NEXTVAL errors** ➔ CURRVAL only echoes an already-generated value; NEXTVAL must run first in the session. Sequence values may have **gaps** (caching/restart) but are always unique, and are not reliable after COMMIT/ROLLBACK.
