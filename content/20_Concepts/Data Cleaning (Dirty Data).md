---
unit: FIT3003
week: 3
source: [lecture, lab, reading]
domain: C
parent: "[[Data Exploration (Warehouse Validation)]]"
tags: [CS/Databases, Tool/SQL, DataScience/DataWarehousing, DataScience/DataQuality]
aliases: [Dirty Data, Duplicate Records, Constraint Violation, Pre-Data Warehousing]
type: pattern
---
# [[Data Cleaning (Dirty Data)]]

**Context:** [[FIT3003_MOC]] · runs on the defects surfaced by [[Data Exploration (Warehouse Validation)]], before [[Building Dimension Tables]] · the pandas-side equivalent is [[Data Quality Problems]]
**Problem it solves:** removing source defects that would otherwise be baked into the fact's measures, where they are undetectable.

> [!abstract] Quick Revision
> - **🎯 Trigger:** every dirty-data type has the same two-query shape ➔ a `select` that **counts or lists** the offenders, then a `delete` / `distinct` that removes them. Never repair blind.
> - **⚠️ Key Constraint:** clean **before** the fact is aggregated. Once `group by` has run, the defect is fused into `Total_X` and no downstream query can recover the truth.

## 🔧 Minimal Working Example
*(the five types the unit names, each as check ➔ simplest repair)*
```sql
-- 1. DUPLICATION — a PK value appearing more than once
select   <<PK>>, count(*) from <<table>> group by <<PK>> having count(*) > 1;
create table <<new>> as select distinct * from <<old>>;

-- 2. RELATIONSHIP / CONSTRAINT VIOLATION — an orphan FK
select * from <<table1>> where <<FK>> not in (select <<PK>> from <<table2>>);
delete from <<table1>> where <<FK>> not in (select <<PK>> from <<table2>>);

-- 3. INCONSISTENT VALUES — two attributes contradicting each other
select * from contract where starttime > endtime;
delete from contract where starttime > endtime;

-- 4. INCORRECT VALUES — outside the legal domain (spelling, range, type, logic)
select * from charter where char_distance < 0;
delete from charter where char_distance < 0;

-- 5. NULL VALUES — a mandatory attribute unpopulated
select * from major where major_name is null;
delete from major where major_name is null;
```
**Expected output:** the `select` returns the offending rows (empty $=$ clean); the repair returns *n* rows deleted, which must be reconciled against the exploration counts.

## 🔀 Variations
### Route A — clean at the join with `distinct` (no source copy)
*(USELOG: `dw.student` holds $14\,288$ duplicated ids; the source is read-only.)*
```sql
create table tempfact_uselog2 as
select distinct U.log_date, U.log_time, U.student_ID, S.class_id, S.major_code
from   dw.uselog U, dw.student S
where  U.student_id = S.student_id;
-- 108261 rows, vs 170610 without distinct
```
- **`distinct` de-dupes at *record* level** ➔ it removes the fan-out from the duplicated 1 side **and** the 6 genuine duplicate rows inside `dw.uselog`, because both produce byte-identical projected rows.
- **Cheapest route when the source is another account's schema** ➔ nothing is copied and nothing is deleted.

### Route B — copy the source, then clean it
```sql
create table student_clean as select distinct * from dw.student;
```
- **Use when the defect is not removable by projection** ➔ near-duplicates differing in one column, orphan FKs, or out-of-range values all survive a `distinct` on the join.
- **CTAS copies rows only** ➔ no PK/FK comes across, so nothing enforces uniqueness afterwards ➔ [[Populating Tables from Queries (INSERT-SELECT, CTAS)]].

### Route C — document the defect, clean nothing
*(ROBCOR: two charter records share a `Char_Trip` value; the rows are genuinely different flights.)*
- **Scope test** ➔ `Char_Trip` enters neither the fact's `group by` list nor any measure, so the defect **cannot** reach the warehouse.
- **Verdict** ➔ record it in the exploration write-up and move on; deleting a valid transaction to satisfy a cosmetic constraint destroys real revenue and flying hours.
- ⚠ **Assignment 2 does not grant this exemption** ➔ the lab sheet states all data issues must be addressed there, defect-in-scope or not.

## ✏️ Practice
> [!QUESTION]- Practice 1: `tempfact_uselog` has $170\,610$ rows but `dw.uselog` has $108\,267$. Write the two queries that identify the cause, and the one statement that repairs it.
> > [!SUCCESS]- Reference solution
> > ```sql
> > -- (a) is the "1" side unique?
> > select student_id, count(*) from dw.student
> > group by student_id having count(*) > 1;        -- 14288 offenders
> >
> > -- (b) is the "m" side itself duplicated?  (composite key — no single PK)
> > select to_char(log_time,'HH24:MI'), log_date, student_id, act, count(*)
> > from   dw.uselog
> > group by log_time, log_date, student_id, act
> > having count(*) > 1;                             -- 6 offenders
> >
> > -- (c) repair
> > create table tempfact_uselog2 as
> > select distinct U.log_date, U.log_time, U.student_ID, S.class_id, S.major_code
> > from dw.uselog U, dw.student S where U.student_id = S.student_id;
> > ```
> > - **Key move:** probe **both** sides. Fixing only `dw.student` leaves the count at $108\,267$ instead of the correct $108\,261$, and the 6 phantom lab visits stay in the warehouse forever.

> [!QUESTION]- Practice 2: a `CHARTER` table references `AIRCRAFT`, which references `MODEL`. Write the checks that prove referential integrity holds across both hops.
> > [!SUCCESS]- Reference solution
> > ```sql
> > select * from dw.charter
> > where  ac_number not in (select ac_number from dw.aircraft);
> >
> > select * from dw.aircraft
> > where  mod_code not in (select mod_code from dw.model);
> > ```
> > - **Key move:** the anti-join is per **hop**, not per query — an orphan at either level silently shrinks the fact, and the inner join gives no warning.
> > - ⚠ **`not in` with a NULL in the subquery returns nothing at all** ➔ three-valued logic makes every comparison UNKNOWN; check the parent key for NULLs first ➔ [[SQL Subquery (Nested SELECT)]].

## ⚠️ Common Mistakes
- 💡 **Cleaning after the fact table is built** ➔ the aggregate has already absorbed the duplicates; the row count still looks right and the measures are permanently wrong ➔ [[Data Exploration (Warehouse Validation)]].
- 💡 **`delete` before `select`** ➔ the check query is what tells you the *scale* of the defect; deleting first destroys the evidence that the repair worked.
- 💡 **Assuming `distinct` fixes everything** ➔ it only removes rows identical across the **projected** columns; orphan FKs, out-of-range values and contradictory attribute pairs pass straight through.
- 💡 **Deleting rows for a defect the warehouse never reads** ➔ scope the defect against the fact's keys and measures first; irrelevant dirt is documented, not deleted.
