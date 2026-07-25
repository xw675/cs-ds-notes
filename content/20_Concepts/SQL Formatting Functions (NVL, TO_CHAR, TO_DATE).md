---
unit: FIT2094
week: [8, 10]
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [NVL, TO_CHAR, TO_DATE, sysdate, dual, EXTRACT, LPAD, RPAD, LTRIM, TRIM]
---
# [[SQL Formatting Functions (NVL, TO_CHAR, TO_DATE)]]

**Context:** [[FIT2094_MOC]] · clean a [[SQL SELECT and WHERE|SELECT]]'s output · substitute [[NULL Value|NULLs]], convert text↔[[Oracle Data Types|DATE]], extract date parts, pad/trim text
**Problem it solves:** replace NULLs with readable defaults, render/compare dates and numbers, extract date components, and align text output.

> [!abstract] Quick Revision
> - **🎯 Trigger:** blank cells, raw dates, or messy numbers in output ➔ NVL / TO_CHAR; comparing a DATE column ➔ TO_DATE.
> - **⚡ Key Constraint:** NVL's replacement value **must match the column's data type** — swap a DATE for text only after TO_CHAR.

## 🔧 Minimal Working Example
```sql
SELECT stuid,
       NVL(enrolmark, 0)      AS mark,     -- number column → numeric default
       NVL(enrolgrade, 'WH')  AS grade     -- string column → string default
FROM   uni.enrolment;
```
**Expected output:** null marks show `0`, null grades show `WH` — no blank cells.

- **NVL(col, alt)** ➔ replaces NULL with `alt`; `alt` must be the column's type (number↔number, string↔string).
- **TO_DATE(str, fmt)** ➔ string→date; **required** to compare a DATE column: `WHERE drone_pur_date > TO_DATE('01-Mar-2021','dd-Mon-yyyy')`.
- **TO_CHAR(date, fmt)** ➔ date→text in a fixed picture: `'dd-Mon-yyyy hh:mi:ss AM'`; avoids per-user NLS inconsistency.
- **TO_CHAR(num, fmt)** ➔ number→text: `'$9,999.99'` renders `1250.5` as `$1,250.50` (`9`=digit, `0`=forced zero, `$`/`,`/`.`).
- **Native attributes** ➔ `sysdate` (server), `current_date` (session), `systimestamp`, `user`; `dual` = the built-in one-row table.
- **EXTRACT(part FROM date)** ➔ pulls `YEAR`/`MONTH`/`DAY` as a **NUMBER** — filter/group by date part without converting to text; usable in arithmetic.
- **LPAD/RPAD(str, len, fill)** ➔ pad left/right to a fixed width (default fill = space); **LTRIM**/**TRIM** strip leading / leading+trailing spaces.

## 🔀 Variations
- **NVL type clash → wrap first** ➔ `NVL(rent_in_dt,'Still out')` errors (DATE vs string); fix: `NVL(TO_CHAR(rent_in_dt,'dd-Mon-yyyy'),'Still out')`.
- **Current time** ➔ `SELECT TO_CHAR(sysdate,'dd-Mon-yyyy hh:mi:ss AM') FROM dual;`.
- **Filter by date part** ➔ `WHERE EXTRACT(MONTH FROM ds_date_serviced) BETWEEN 1 AND 3` (Q1) — no TO_CHAR needed.
- **Text bar chart** ➔ `LPAD(LTRIM(TO_CHAR(pct,'990.99')), 15, '*')` renders `**********22.73` (LTRIM removes TO_CHAR's sign space, LPAD pads to width). Only aligns in a **monospaced** font / "Run Script".

## ✍️ Practice 
> [!QUESTION]- Practice 1: For each rental show `rent_no` and a return date as `dd-Mon-yyyy`, or `'Still out'` when not yet returned.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT rent_no,
> >        NVL(TO_CHAR(rent_in_dt,'dd-Mon-yyyy'), 'Still out') AS datein
> > FROM   drone.rental;
> > ```
> > - **Key move:** TO_CHAR converts the DATE to text *first*, so NVL's `'Still out'` matches type.

## ⚠️ Common Mistakes
- 💡 **NVL type mismatch errors** ➔ the default must share the column's type; convert dates with TO_CHAR before substituting text.
- 💡 **Never compare/display a raw DATE** ➔ this unit **requires** TO_DATE (compare) and TO_CHAR (display) for every date attribute, to kill locale ambiguity.
- 💡 **Padding only aligns in monospace** ➔ LPAD/RPAD output looks correct in "Run Script"/fixed-width fonts, not the proportional query-result grid.
