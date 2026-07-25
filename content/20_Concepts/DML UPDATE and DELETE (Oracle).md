---
unit: FIT2094
week: 7
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, SQL/Oracle, Monash/CS_DS]
type: pattern
aliases: [UPDATE, DELETE, Subquery, Nested SELECT]
---
# [[DML UPDATE and DELETE (Oracle)]]

**Context:** [[FIT2094_MOC]] · change or remove existing rows · both hinge on the WHERE clause · the unit's **no-hardcode** rule lives here
**Problem it solves:** modify/remove exactly the target rows, deriving any filter value from the database via a subquery rather than a hand-looked-up literal.

> [!abstract] Quick Revision
> - **🎯 Trigger:** edit/remove rows conditional on data in **another** table ➔ UPDATE/DELETE with a **subquery in WHERE**, never a hardcoded code.
> - **⚡ Key Constraint:** omitting WHERE hits **every row**; and a literal like `'DIN2'` typed by hand is a mark-losing manual lookup.

## 🔧 Minimal Working Example
```sql
-- raise cost 10% for DJI Inspire 2 drones bought after 31-Mar-2021
UPDATE drone
SET drone_cost_hr = drone_cost_hr * 1.1
WHERE dt_code = (SELECT dt_code
                 FROM drone_type
                 WHERE UPPER(dt_model) = UPPER('DJI Inspire 2'))
  AND drone_pur_date > TO_DATE('31-Mar-2021','DD-Mon-YYYY');
```
**Expected output:** only matching drones updated; the `dt_code` (`'DIN2'`) is fetched live, not typed. One statement = **one** semicolon.

- **UPDATE shape** ➔ `SET col = value|(subquery) [, ...] [WHERE ...]`; multiple columns comma-separated.
- **Subquery in WHERE** ➔ a nested SELECT supplies the filter value ➔ query survives future data changes (e.g. if `dt_code` changes).
- **Case-insensitive match** ➔ wrap both sides in UPPER()/LOWER() since `'DJI' ≠ 'dji'`.
- **DELETE shape** ➔ `DELETE FROM t [WHERE ...]`; anti-membership via `NOT IN (SELECT ...)`.

## 🔀 Variations
- **Correlated-style filter (DELETE)** ➔ remove customers who never trained:
```sql
DELETE FROM customer
WHERE cust_id NOT IN (SELECT DISTINCT cust_id FROM cust_train);
```
- **Blanket update (intentional)** ➔ `UPDATE drone SET drone_cost_hr = drone_cost_hr * 1.1;` raises *all* — only when that is the requirement.

## ✍️ Practice
> [!QUESTION]- Practice 1: Correct course `DJIHY` — set `train_desc = 'DJI Hobby Drone Training'` and `train_hrs = 5`, matching the code case-insensitively.
> > [!SUCCESS]- Reference solution
> > ```sql
> > UPDATE training
> > SET train_desc = 'DJI Hobby Drone Training', train_hrs = 5
> > WHERE UPPER(train_code) = 'DJIHY';
> > ```
> > - **Key move:** WHERE pins one course; UPPER() neutralises stored-case differences.

## ⚠️ Common Mistakes
- 💡 **Missing WHERE = whole-table change** ➔ a WHERE-less UPDATE/DELETE silently rewrites/removes every row.
- 💡 **Hardcoded lookup is not allowed** ➔ `WHERE dt_code = 'DIN2'` (hand-looked-up) is rejected; retrieve it with a subquery so the statement stays correct and maintainable.
