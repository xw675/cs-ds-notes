---
unit: FIT2094
domain: C
week: 10
parent: "[[SQL Subquery (Nested SELECT)]]"
tags: [CS/Databases, Tool/SQL]
type: pattern
aliases: [Nested Subquery, Correlated Subquery, Inline View, Scalar Subquery]
---
# [[SQL Subquery Approaches (Nested, Correlated, Inline)]]

**Context:** [[FIT2094_MOC]] · *where* a subquery sits and *how often* it runs · complements [[SQL Subquery (Nested SELECT)|the output-shape view]] · cost explained by [[Query Processing and the Optimiser]]
**Problem it solves:** answer a "per-group extreme" query (e.g. min price per drone type) via one of three placements.

> [!abstract] Quick Revision
> - **🎯 Trigger:** subquery needed ➔ nested (runs once, independent) · correlated (re-runs per outer row) · inline (a SELECT in FROM used as a temp table).
> - **⚡ Key Constraint:** a **correlated** subquery references the outer row, so it executes once **per outer row** — same answer, far higher cost than nested.

## 🔧 Minimal Working Example
```sql
-- NESTED: inner runs once, independent of the outer query
SELECT dt_code, drone_id, drone_pur_price
FROM   drone.drone
WHERE  (dt_code, drone_pur_price) IN (
    SELECT dt_code, MIN(drone_pur_price) FROM drone.drone GROUP BY dt_code)
ORDER BY dt_code, drone_id;
```
**Expected output:** the cheapest drone(s) per type. Nested version's Explain-Plan cost ≈ 9.

- **Nested** ➔ inner independent of outer; Oracle runs it **once**, filters outer against the result.
- **Correlated** ➔ inner references an outer column (`d2.dt_code = d1.dt_code`) ➔ re-runs **per outer row**.
- **Inline (FROM)** ➔ a subquery aliased as a temporary table, then **joined** to real tables.
- **Scalar inline (SELECT)** ➔ a subquery in the SELECT list returning **exactly one** value (e.g. a percentage of a grand total).

## 🔀 Variations
| Approach | Placement | Runs | References outer? |
| :--- | :--- | :--- | :--- |
| **Nested** | WHERE | once | no |
| **Correlated** | WHERE | per outer row | **yes** |
| **Inline view** | FROM (aliased) | once, joined | no |
| **Scalar** | SELECT list | once | no (must return 1 value) |

- **Correlated form** ➔ `WHERE drone_pur_price = (SELECT MIN(drone_pur_price) FROM drone.drone d2 WHERE d2.dt_code = d1.dt_code)`.
- **Inline view form** ➔ `FROM (SELECT dt_code, MIN(drone_pur_price) minprice FROM drone.drone GROUP BY dt_code) mintable JOIN drone.drone d ON mintable.dt_code=d.dt_code AND mintable.minprice=d.drone_pur_price`.

## ✍️ Practice 
> [!QUESTION]- Practice 1: For each drone, show `times_rented` and its share of all completed rentals as a percentage, using a scalar subquery in the SELECT list.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT drone_id, COUNT(*) AS times_rented,
> >        TO_CHAR(COUNT(*) * 100 / (SELECT COUNT(rent_in_dt) FROM drone.rental), '990.99') AS percent_overall
> > FROM   drone.rental
> > WHERE  rent_in_dt IS NOT NULL
> > GROUP BY drone_id
> > ORDER BY percent_overall DESC;
> > ```
> > - **Key move:** the scalar subquery (total completed rentals) returns one value, safe to divide by.

## ⚠️ Common Mistakes
- 💡 **Scalar subquery must return exactly one value** ➔ a multi-row result in the SELECT list errors.
- 💡 **Correlated = repeated scans** ➔ correct but costly (≈4× the nested cost here); not penalised in this unit, but prefer nested/inline when equivalent.
