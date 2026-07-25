---
unit: FIT2094
domain: C
week: [8, 9]
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [Subquery, Nested SELECT, IN Subquery]
---
# [[SQL Subquery (Nested SELECT)]]

**Context:** [[FIT2094_MOC]] · a SELECT nested inside another statement · supplies a value you can't hardcode · powers filtered [[DML UPDATE and DELETE (Oracle)|UPDATE/DELETE]]
**Problem it solves:** filter (or update/delete) rows by a value that must be *looked up from another table*, not typed in.

> [!abstract] Quick Revision
> - **🎯 Trigger:** the filter value lives in another table ➔ put a SELECT in the WHERE clause; match the **operator to the subquery's output shape**.
> - **⚡ Key Constraint:** scalar ⟹ `= < >` …; single column, many rows ⟹ `IN`/`ANY`/`ALL`; many columns ⟹ row-constructor `(a,b) IN`. A multi-row subquery with `=` errors.

## 🔧 Minimal Working Example
```sql
-- raise hire cost 20% for all drones made by DJI Da-Jiang Innovations
UPDATE drone.drone
SET    drone_cost_hr = drone_cost_hr * 1.2
WHERE  dt_code IN (
    SELECT dt_code
    FROM   drone.drone_type t
    JOIN   drone.manufacturer m ON t.manuf_id = m.manuf_id
    WHERE  UPPER(manuf_name) = UPPER('DJI Da-Jiang Innovations')
);
```
**Expected output:** every drone whose type maps (via `DRONE_TYPE`→`MANUFACTURER`) to DJI is updated. One statement = **one** semicolon.

- **Subquery runs first** ➔ its result feeds the outer WHERE; the whole thing is still a single statement.
- **Join inside the subquery** ➔ bridge tables (`DRONE_TYPE` links `DRONE` cost to `MANUFACTURER` name) to reach the needed key.
- **`=` vs `IN`** ➔ `=` only if the subquery yields exactly one value; `IN` for a set (DJI makes many drone types).
- **Robustness** ➔ if `dt_code` values change later, the query still works — no hardcoded literal.

## 🔀 Variations
*(Choose the operator by what the subquery returns.)*

| Subquery output | Operators | Example use |
| :--- | :--- | :--- |
| **single value** (scalar) | `= < > <= >= !=` | flight time > overall AVG |
| **1 column, many rows** | `IN` / `NOT IN`, `ANY` / `ALL` + `< > …` | `dt_code IN (list of codes)` |
| **many columns, many rows** | `(a,b) IN (…)` | `(dt_code, price) IN (min-per-type)` |

- **Scalar compare** ➔ drones above the fleet average:
```sql
SELECT * FROM drone.drone
WHERE drone_flight_time > (SELECT AVG(drone_flight_time) FROM drone.drone)
ORDER BY drone_id;
```
- **Column membership** ➔ `WHERE dt_code IN (SELECT DISTINCT dt_code FROM drone.drone_type WHERE dt_carry_kg > 4)`.
- **Row-constructor (multi-column) IN** ➔ min price per type, matched as a `(col, col)` pair:
```sql
SELECT dt_code, drone_id, drone_pur_price FROM drone.drone
WHERE (dt_code, drone_pur_price) IN (
    SELECT dt_code, MIN(drone_pur_price) FROM drone.drone GROUP BY dt_code)
ORDER BY dt_code, drone_id;
```
- **`ANY`/`ALL`** ➔ `> ANY(...)` = greater than at least one; `> ALL(...)` = greater than every value.
- **Anti-membership** ➔ `WHERE cust_id NOT IN (SELECT DISTINCT cust_id FROM cust_train)` selects the non-participants.

## ✍️ Practice 
> [!QUESTION]- Practice 1: Delete customers who never attended any training (`CUST_TRAIN` holds attendance).
> > [!SUCCESS]- Reference solution
> > ```sql
> > DELETE FROM drone.customer
> > WHERE cust_id NOT IN (SELECT DISTINCT cust_id FROM drone.cust_train);
> > ```
> > - **Key move:** the subquery lists attendees; `NOT IN` keeps the complement to delete.

> [!QUESTION]- Practice 2: For each drone type, list the drone(s) with the **minimum** purchase price — show `dt_code`, `drone_id`, `drone_pur_price`.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT dt_code, drone_id, drone_pur_price
> > FROM   drone.drone
> > WHERE  (dt_code, drone_pur_price) IN (
> >     SELECT dt_code, MIN(drone_pur_price) FROM drone.drone GROUP BY dt_code)
> > ORDER BY dt_code, drone_id;
> > ```
> > - **Key move:** a per-group aggregate can't sit in a scalar compare — match the whole `(dt_code, price)` pair against the grouped subquery.

## ⚠️ Common Mistakes
- 💡 **`=` with a multi-row subquery errors** ➔ default to `IN` unless the subquery is provably single-row; use `ANY`/`ALL` for inequality against a list.
- 💡 **Row-constructor order must align** ➔ in `(dt_code, drone_pur_price) IN (SELECT dt_code, MIN(...))` the outer columns and the subquery columns must match in **count and order**.
- 💡 **Don't hardcode the looked-up value** ➔ typing `'DIN2'` you found by eye is rejected; retrieve it via the subquery so the query stays correct and maintainable.
