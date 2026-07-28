---
unit: [FIT2094, FIT3003]
domain: C
week: [1, 7]
source: [lecture, applied, lab]
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [INSERT, INSERT ALL, TO_DATE, SEQUENCE, NEXTVAL, CURRVAL, DUAL]
---
# [[DML INSERT (Oracle)]]

**Context:** [[FIT2094_MOC]], [[FIT3003_MOC]] · add rows to a populated schema · the first [[SQL Sublanguages (DDL, DML, DCL)|DML]] verb · dates and numeric PKs need helpers
**Problem it solves:** add a new row, supplying a typed [[Oracle Data Types|DATE]], a generated numeric PK, and NULLs for optional columns.

> [!abstract] Quick Revision
> - **🎯 Trigger:** new row to add ➔ INSERT with a **column list** (positional pairing) + TO_DATE for dates + a SEQUENCE for numeric PKs.
> - **⚡ Key Constraint:** a date literal `'10/Dec/2022'` is a **string, not a date** — always wrap with TO_DATE; and call NEXTVAL before CURRVAL. Nothing is durable until [[Database Transaction|COMMIT]].

## 🔧 Minimal Working Example
```sql
-- named columns: order is free, missing nullable columns default to NULL
INSERT INTO drone (drone_id, drone_pur_date, drone_pur_price, drone_flight_time, drone_cost_hr, dt_code)
VALUES (200, TO_DATE('10 Dec 2022','DD Mon YYYY'), 1200.10, 0, 120, 'DIN2');
```
**Expected output:** 1 row in `drone`; the omitted `drone_decom_date` is NULL.

- **Named vs positional** ➔ with a column list, name–value pairing is positional but column *order is free*; without it you must supply **every** column in table order (write `NULL` explicitly for optional ones).
- **When the column list is mandatory** ➔ any **partial** insert must name its columns, and every `NOT NULL` column must receive a value.
- **Strings are case-sensitive** ➔ `'General Practice'` ≠ `'general practice'`; single quotes only.
- **TO_DATE** ➔ `TO_DATE('23/AUG/2022 13:00','DD/MON/YYYY HH24:MI')`; string case and picture-clause case must match (`Dec`↔`Mon`). Common masks: `DD-MON-YYYY`, `MM/DD/YYYY`, `HH:MI AM`, `MONTH DAY, YYYY`.
- **SEQUENCE for PKs** ➔ `CREATE SEQUENCE manuf_seq START WITH 100 INCREMENT BY 1;` then `manuf_seq.NEXTVAL` (advance) / `manuf_seq.CURRVAL` (reuse same value in a later insert).

## 🔀 Variations
- **No column list** ➔ `INSERT INTO drone VALUES (200, TO_DATE(...), 1200.10, 0, 120, NULL, 'DIN2');` — all columns, NULL placed positionally.
- **Reuse a generated key** ➔ parent uses `seq.NEXTVAL`, child reuses `seq.CURRVAL` for the same value within the session.
- **`INSERT ALL` — many rows, one statement** ➔ each `INTO` clause is a separate row; the trailing `SELECT * FROM DUAL` supplies the single driving row Oracle requires:
```sql
INSERT ALL
  INTO car VALUES (2, 'BMW',    '520d',      2016, 'Grey',  98800)
  INTO car VALUES (3, 'Audi',   'A5',        2016, 'Black', 68200)
  INTO car VALUES (4, 'Holden', 'Commodore', 2008, 'Grey',  12650)
SELECT * FROM DUAL;
```
- **When one-by-one still wins** ➔ `INSERT ALL` is all-or-nothing and shares one statement context, so use single inserts when a row depends on the previous one (`NEXTVAL`/`CURRVAL` chains) or when you need each row's error isolated.

## ✍️ Practice
> [!QUESTION]- Practice 1: Insert manufacturer `'Monash Drones'` with a sequence-generated PK, then a `drone_type` row reusing that same manufacturer id.
> > [!SUCCESS]- Reference solution
> > ```sql
> > INSERT INTO manufacturer VALUES (manuf_seq.NEXTVAL, 'Monash Drones');
> > INSERT INTO drone_type VALUES ('DJIT','DJI Trello',5,'DJIHY', manuf_seq.CURRVAL);
> > ```
> > - **Key move:** NEXTVAL first (creates the current value), CURRVAL reuses it — never hardcode the id.

> [!QUESTION]- Practice 2 (FIT3003 Lab 1, Q4d-style): insert a lecturer supplying only `StaffNO, Title, FName, LName, StreetAddress, Suburb, PostCode, Country, ResearchArea, WorkLoad`, where `StaffNO` and `WorkLoad` are `NOT NULL`.
> > [!SUCCESS]- Reference solution
> > ```sql
> > INSERT INTO LECTURER (StaffNO, Title, FName, LName, StreetAddress, Suburb,
> >                       PostCode, Country, ResearchArea, WorkLoad)
> > VALUES (4000, 'Mr', 'RaiHong', 'Lam', '12 Oracle Dr', 'Fitzroy',
> >         '3424', 'Australia', 'Data Mining', 1);
> > ```
> > - **Key move:** partial insert ⟹ the column list is compulsory, and both `NOT NULL` columns appear in it; every omitted column silently becomes NULL.

## ⚠️ Common Mistakes
- 💡 **Duplicate PK value** ➔ re-inserting an existing `StaffNO` raises a unique-constraint violation, not a warning; the row is rejected outright.
- 💡 **Date strings silently misparse** ➔ `'10/12/2026'` is DD/MM or MM/DD depending on locale; TO_DATE with an explicit picture clause removes the ambiguity.
- 💡 **CURRVAL before NEXTVAL errors** ➔ CURRVAL only echoes an already-generated value; NEXTVAL must run first in the session. Sequence values may have **gaps** (caching/restart) but are always unique, and are not reliable after COMMIT/ROLLBACK.
- 💡 **Curly quotes from Word** ➔ pasting lab SQL out of a `.docx` carries typographic `'` characters Oracle rejects; retype the straight quote.
