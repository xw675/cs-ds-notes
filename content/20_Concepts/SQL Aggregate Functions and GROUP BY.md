---
unit: FIT2094
week: 9
parent: "[[SQL SELECT and WHERE]]"
tags: [CS/Databases, SQL/Oracle, Monash/CS_DS]
type: pattern
aliases: [Aggregate Functions, GROUP BY, HAVING, COUNT, AVG, SUM]
---
# [[SQL Aggregate Functions and GROUP BY]]

**Context:** [[FIT2094_MOC]] · collapse many rows into per-group summaries · extends a plain [[SQL SELECT and WHERE|SELECT]] · pairs with [[SQL Subquery (Nested SELECT)|subqueries]] for "compare to the aggregate" queries
**Problem it solves:** compute MIN/MAX/AVG/SUM/COUNT overall or per group, then filter the groups.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "for each …" / "average/total/count of …" ➔ aggregate function + GROUP BY the category + HAVING to filter groups.
> - **⚡ Key Constraint:** every SELECT/ORDER BY column must be **either** in GROUP BY **or** inside an aggregate — otherwise Oracle errors.

## 🔧 Minimal Working Example
```sql
SELECT   dt_code, AVG(drone_flight_time) AS avg_flight_time
FROM     drone.drone
GROUP BY dt_code
ORDER BY dt_code;
```
**Expected output:** one row per `dt_code` (5 groups), each with that type's mean flight time.

- **Aggregates** ➔ `MIN` / `MAX` / `AVG` / `SUM` / `COUNT`; each returns **one** value per group (or one overall with no GROUP BY).
- **`COUNT(*)` vs `COUNT(col)`** ➔ `COUNT(*)` counts rows incl. NULLs; `COUNT(col)` counts **non-null** values — e.g. `RENTAL`: `COUNT(*)`=25, `COUNT(rent_in_dt)`=22 (3 not yet returned).
- **Clause execution order** ➔ FROM → **WHERE** (rows) → GROUP BY → aggregate → **HAVING** (groups) → SELECT → ORDER BY.
- **WHERE vs HAVING** ➔ WHERE filters rows *before* grouping; HAVING filters groups *after* aggregation (and may reference an aggregate).

## 🔀 Variations
- **Filter rows first (WHERE)** ➔ `WHERE drone_flight_time > 50 GROUP BY dt_code` — drops rows, then groups.
- **Filter groups after (HAVING)** ➔ `GROUP BY dt_code HAVING AVG(drone_flight_time) > 50` — keeps only group means over 50.

## ✍️ Practice 
> [!QUESTION]- Practice 1: For each `dt_code`, show the average flight time, but only for types whose average exceeds 50; order by `dt_code`.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT   dt_code, AVG(drone_flight_time) AS average_drone_flight
> > FROM     drone.drone
> > GROUP BY dt_code
> > HAVING   AVG(drone_flight_time) > 50
> > ORDER BY dt_code;
> > ```
> > - **Key move:** the group-level condition goes in HAVING (uses the aggregate), not WHERE.

## ⚠️ Common Mistakes
- 💡 **Bare non-grouped column errors** ➔ selecting `drone_flight_time` (raw) alongside an aggregate without grouping it fails; put it in GROUP BY or wrap it in an aggregate. A `TO_CHAR(...)` expression must appear **verbatim** in GROUP BY too.
- 💡 **No alias in GROUP BY (Monash Oracle)** ➔ `GROUP BY year` (an alias) is rejected on the marked Oracle version; repeat the full expression `GROUP BY TO_CHAR(drone_pur_date,'yyyy')`.
- 💡 **Aggregates can't live in WHERE** ➔ a condition on an aggregate (`AVG(...) > 50`) belongs in HAVING; WHERE runs before aggregation exists.
