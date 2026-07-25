---
unit: FIT2094
domain: C
week: 10
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [CASE, DECODE]
---
# [[SQL Conditional Expressions (CASE, DECODE)]]

**Context:** [[FIT2094_MOC]] · if/else inside a [[SQL SELECT and WHERE|SELECT]] list · map coded values to readable labels · alias the result column
**Problem it solves:** return a different output value per row depending on a column's value.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "show X as a label" / decode a status code ➔ CASE in the SELECT list; DECODE for pure equality.
> - **⚡ Key Constraint:** CASE returns the **first** matching WHEN; DECODE handles **equality only** — ranges need CASE.

## 🔧 Minimal Working Example
```sql
SELECT emp_no,
       emp_fname || ' ' || emp_lname AS emp_name,
       CASE UPPER(emp_type)
           WHEN 'F' THEN 'Full Time'
           WHEN 'C' THEN 'Casual'
           ELSE 'Unknown'
       END AS employment_type
FROM   drone.employee
ORDER BY emp_no;
```
**Expected output:** each employee with a human-readable `employment_type` derived from the `emp_type` code.

- **Searched CASE** ➔ `CASE WHEN cond THEN r … ELSE d END` — any predicate, incl. ranges/`<`/`>`.
- **Simple CASE** ➔ `CASE col WHEN v1 THEN r1 … END` — equality shorthand.
- **ELSE optional** ➔ unmatched rows return NULL if ELSE is omitted.
- **DECODE(val, m1, r1, m2, r2, default)** ➔ legacy equality-only sibling of simple CASE; `||` concatenates strings.

## 🔀 Variations
- **DECODE equivalent** ➔ `DECODE(emp_type,'F','Full time','C','Contract')` ≡ a simple CASE on equality.
- **Range needs searched CASE** ➔ `CASE WHEN mark >= 50 THEN 'Pass' ELSE 'Fail' END` — DECODE can't do `>=`.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Label employees `'Full time'`/`'Contract'` for type F/C using DECODE; show name (fname + space + lname) and the label.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT emp_fname || ' ' || emp_lname AS employee_fullname,
> >        DECODE(emp_type, 'F', 'Full time', 'C', 'Contract') AS employee_category
> > FROM   drone.employee;
> > ```
> > - **Key move:** DECODE lists value→result pairs; a trailing arg would be the default.

## ⚠️ Common Mistakes
- 💡 **DECODE can't do ranges** ➔ for `>`/`<`/`BETWEEN` logic use a searched CASE; DECODE only matches exact values.
- 💡 **Order matters in CASE** ➔ the first true WHEN wins, so put narrower conditions before broader ones.
