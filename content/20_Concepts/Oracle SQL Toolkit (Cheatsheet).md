---
unit: FIT2094
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, Tool/SQL]
type: cheatsheet
aliases: [SQL Cheatsheet, SELECT Anatomy]
---
# [[Oracle SQL Toolkit (Cheatsheet)]]

**Context:** [[FIT2094_MOC]] · the ONE pre-lab/pre-exam re-read — every clause, predicate and function from Topics 8–10 in one place · depth lives in the linked pattern notes
**Read protocol:** scan anatomy → scan tables → attempt both practice from a blank editor → follow links only where you failed.

> [!abstract] Quick Revision
> - **🎯 Objective:** assemble any query from the fixed skeleton ➔ SELECT → FROM(+JOIN) → WHERE → GROUP BY → HAVING → ORDER BY.
> - **⚡ Key Constraint:** *logical execution order* ≠ writing order: **FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY** — explains why aliases work in ORDER BY but not GROUP BY/WHERE.

## 🧩 Statement Anatomy
```sql
SELECT   dt_code, AVG(drone_flight_time) AS avg_flight     -- 5. project + alias
FROM     drone.drone                                        -- 1. source (+ JOINs)
WHERE    to_char(drone_pur_date,'yyyy') = '2021'            -- 2. filter ROWS (pre-group)
GROUP BY dt_code                                            -- 3. form groups (no aliases here!)
HAVING   AVG(drone_flight_time) > 50                        -- 4. filter GROUPS (may use aggregates)
ORDER BY dt_code;                                           -- 6. sort (aliases OK, NULLS LAST OK)
```

## 🔎 Predicates (WHERE) — [[SQL SELECT and WHERE]]
| Predicate | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| comparison | `price > 2000`, `<>` | `<>` is not-equal |
| range | `price BETWEEN 3000 AND 5300` | inclusive both ends ≡ `>=3000 AND <=5300` |
| set | `emp_no IN (3, 8)` | negate: "not 3 nor 8" = `<>3 AND <>8` — **OR is always-true trap** |
| pattern | `name LIKE 'D%'` / `'_JI%'` | `%` any run, `_` one char |
| null test | `rent_in_dt IS NULL` | `= NULL` is **always UNKNOWN** — never matches |
| logic | `NOT` → `AND` → `OR` precedence | 3-valued logic: NULL = UNKNOWN; only TRUE rows returned — bracket everything |

## 🛠 Row Functions & Output Shaping
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `NVL` | `NVL(col, 'Still out')` | replace NULL; types must match ➔ wrap date first: `NVL(TO_CHAR(dt,'dd-Mon-yyyy'),'Still out')` |
| `TO_CHAR` | `TO_CHAR(dt,'dd-Mon-yyyy')`, `TO_CHAR(n,'$9,999')` | date/number → display string; also extracts parts: `TO_CHAR(dt,'yyyy')` |
| `TO_DATE` | `TO_DATE('01-Mar-2021','dd-Mon-yyyy')` | string → date for **comparing/inserting** — never compare raw strings |
| concat | `cust_fname \|\| ' ' \|\| cust_lname` | Oracle concatenation is `\|\|` |
| case-blind | `UPPER(manuf_name) = UPPER('DJI...')` | normalise both sides |
| `DISTINCT` | `SELECT DISTINCT drone_id` | de-dupe whole result rows — use with care |
| alias | `AS avg_flight` | usable in ORDER BY only (see execution order) |
| sort | `ORDER BY t DESC, id` · `NULLS LAST/FIRST` | mandatory whenever >1 row possible — tuples have no order |
| conditional | `CASE`/`DECODE` | ➔ [[SQL Conditional Expressions (CASE, DECODE)]] |

## 📦 Aggregates & Grouping — [[SQL Aggregate Functions and GROUP BY]]
- **Five aggregates** ➔ `COUNT / SUM / AVG / MIN / MAX`; `COUNT(*)` counts rows incl. NULLs, `COUNT(col)` non-null only.
- **GROUP BY rule** ➔ every non-aggregate SELECT column MUST appear in GROUP BY; column **aliases are illegal** in GROUP BY (not yet computed) — repeat the expression: `GROUP BY to_char(ct_date_start,'yyyy')`.
- **WHERE vs HAVING** ➔ WHERE filters rows *before* grouping; HAVING filters *groups* after, and may contain aggregates.

## 🔗 Joins — [[SQL Joins (ANSI)]] · [[SQL Self Join and Outer Join]]
| Form | Syntax | When |
| :-- | :-- | :-- |
| `JOIN … ON` | `FROM a JOIN b ON a.id = b.id` | **the general form — default choice**, always works |
| `JOIN … USING` | `JOIN b USING (manuf_id)` | identical column names both sides |
| `NATURAL JOIN` | `a NATURAL JOIN b` | all common columns match — ⚠ no common column ⇒ **Cartesian product** |
| self join | `FROM emp e1 JOIN emp e2 ON e1.mgrno = e2.empno` | recursive FK (employee→manager); **distinct aliases required** |
| outer join | `LEFT / RIGHT / FULL OUTER JOIN … ON …` | keep unmatched rows (INNER drops them) |
| ⛔ implicit | join condition in WHERE | **banned in FIT2094 — marked wrong in all assessments** |

## 🪆 Subqueries — [[SQL Subquery (Nested SELECT)]] · [[SQL Subquery Approaches (Nested, Correlated, Inline)]]
- **Single value** ➔ compare with `=, <, >`: `WHERE price < (SELECT AVG(price) FROM …)`.
- **List of values** ➔ `IN` (equality against list); `> ANY` (beats at least one ➔ nearly all rows), `> ALL` (beats every one ➔ few rows) — classic MCQ discriminator.
- **Multi-column pairs** ➔ `WHERE (dt_code, price) IN (SELECT dt_code, MAX(price) … GROUP BY dt_code)` — per-group max pattern.
- **In DML** ➔ subquery sets the target set: `UPDATE … SET cost = cost*1.2 WHERE manuf_id = (SELECT …)`; see [[Populating Tables from Queries (INSERT-SELECT, CTAS)]].

## ➕ Advanced SQL (Topic 10)
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `CASE` | `CASE WHEN cond THEN 'r' ELSE 'd' END` / `CASE col WHEN v THEN …` | if/else in SELECT; searched form allows ranges |
| `DECODE` | `DECODE(emp_type,'F','Full','C','Casual')` | equality-only legacy of CASE — ➔ [[SQL Conditional Expressions (CASE, DECODE)]] |
| set ops | `q1 UNION / UNION ALL / INTERSECT / MINUS q2` | **union-compatible** (same #cols + types); one final `ORDER BY`; names from q1 — ➔ [[SQL Set Operators]] |
| subquery placement | nested (once) · **correlated** (per-row) · **inline view** (`FROM (SELECT …) alias`) · scalar-in-SELECT | ➔ [[SQL Subquery Approaches (Nested, Correlated, Inline)]] |
| populate table | `INSERT INTO t (SELECT …)` · `CREATE TABLE t AS (SELECT …)` | **CTAS copies data, NOT constraints** — re-add PK/FK after |
| view | `CREATE OR REPLACE VIEW v AS SELECT …` · `DROP VIEW v` | virtual table (stored query); **banned in Assignment 2** — use a subquery |
| date part / format | `EXTRACT(YEAR FROM d)` (number) · `TO_CHAR(d,'yyyy')` (string) | filter/group by a date part |
| text align | `LPAD/RPAD(s,n,'*')` · `LTRIM/TRIM(s)` | monospace-only bar charts |

## ✍️ Integration Practice
> [!QUESTION]- Practice 1 (Topic 8, Q5-style): full name (one column, space-separated) and contact number of customers who completed a training course longer than 4 hours, ordered by name.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT   c.cust_fname || ' ' || c.cust_lname AS fullname, c.cust_phone
> > FROM     drone.customer c
> >          JOIN drone.cust_train ct ON c.cust_id = ct.cust_id
> >          JOIN drone.training  t  ON ct.train_code = t.train_code
> > WHERE    t.train_duration > 4
> > ORDER BY fullname;
> > ```
> > - **Key moves:** `\|\|` concat + two ANSI ONs + alias reused in ORDER BY (legal — runs after SELECT).

> [!QUESTION]- Practice 2 (Topic 9, Q10-style): drones cheaper than the average price of all DJI-manufactured drones; show id, type code, price, purchase YEAR, manufacturer name; order by id.
> > [!SUCCESS]- Reference solution
> > ```sql
> > SELECT   drone_id, dt_code, drone_pur_price,
> >          to_char(drone_pur_date,'yyyy') AS yearpurchased, manuf_name
> > FROM     drone.drone NATURAL JOIN drone.drone_type NATURAL JOIN drone.manufacturer
> > WHERE    drone_pur_price < (SELECT AVG(drone_pur_price)
> >                             FROM   drone.drone NATURAL JOIN drone.drone_type
> >                                    NATURAL JOIN drone.manufacturer
> >                             WHERE  UPPER(manuf_name) = UPPER('DJI Da-Jiang Innovations'))
> > ORDER BY drone_id;
> > ```
> > - **Key moves:** scalar subquery with its own join chain + `TO_CHAR` year extraction + `UPPER` case-blind match.

## ⚠️ Common Mistakes
- 💡 **`= NULL` never matches** ➔ 3-valued logic makes it UNKNOWN; only `IS NULL` works.
- 💡 **"not A or B" trap** ➔ `emp_no <> 3 OR emp_no <> 8` is TRUE for every row; exclusion needs `AND`.
- 💡 **Alias in GROUP BY** ➔ illegal (GROUP BY runs before SELECT); repeat the full expression.
