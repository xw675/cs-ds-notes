---
unit: [FIT2094, FIT3003]
domain: C
parent: "[[SQL Sublanguages (DDL, DML, DCL)]]"
tags: [CS/Databases, Tool/SQL]
type: cheatsheet
aliases: [SQL Cheatsheet, SELECT Anatomy]
---
# [[Oracle SQL Toolkit (Cheatsheet)]]

**Context:** [[FIT2094_MOC]], [[FIT3003_MOC]] · the ONE pre-lab/pre-exam re-read — every clause, predicate and function the two units teach, in one place · depth lives in the linked pattern notes
**Read protocol:** scan anatomy → scan tables → attempt all three practice items from a blank editor → follow links only where you failed.

> [!abstract] Quick Revision
> - **🎯 Objective:** assemble any query from the fixed skeleton ➔ SELECT → FROM(+JOIN) → WHERE → GROUP BY → HAVING → ORDER BY.
> - **⚡ Key Constraint:** *logical execution order* ≠ writing order: **FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY** — explains why aliases work in ORDER BY but not GROUP BY/WHERE.
> - **⚠ Unit divergence:** FIT2094 **bans** implicit joins; FIT3003 lectures and labs **use** them. Everything else is shared.

## 🧩 Statement Anatomy (execution order)
```sql
SELECT   dt_code, AVG(drone_flight_time) AS avg_flight     -- 5. project + alias
FROM     drone.drone                                        -- 1. source (+ JOINs)
WHERE    to_char(drone_pur_date,'yyyy') = '2021'            -- 2. filter ROWS (pre-group)
GROUP BY dt_code                                            -- 3. form groups (no aliases here!)
HAVING   AVG(drone_flight_time) > 50                        -- 4. filter GROUPS (may use aggregates)
ORDER BY dt_code;                                           -- 6. sort (aliases OK, NULLS LAST OK)
```

## 🏗 DDL — Build & Inspect the Schema
*(➔ [[DDL Table Creation]] · [[Altering and Dropping Tables]] · [[Oracle Data Types]])*

| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| create | `CREATE TABLE car (carID NUMBER(5) NOT NULL, …, PRIMARY KEY (carID), FOREIGN KEY (carID) REFERENCES car(carID));` | FIT3003 declares PK/FK **inline**; FIT2094 requires **named constraints via ALTER** |
| types | `VARCHAR2(30)` · `CHAR(2)` · `NUMBER(4)` · `NUMBER(8,2)` · `DATE` | `CHAR` is blank-padded fixed width; `NUMBER(p,s)` = precision, scale |
| DATE defaults | format `DD-MON-YYYY`; range 1/1/4712 BC – 12/31/4712 AD | no time given ⟹ `12:00:00 A.M.`; no date given ⟹ first day of current month |
| copy a table | `CREATE TABLE car AS SELECT * FROM dtaniar.car;` | copies **rows only** — **PK/FK are NOT copied** ➔ [[Populating Tables from Queries (INSERT-SELECT, CTAS)]] |
| list my tables | `SELECT * FROM TAB;` | returns `TNAME / TABTYPE / CLUSTERID` — the data-dictionary view of your account |
| show structure | `DESCRIBE car;` / `DESC car;` | column, nullability, type — use after every ALTER to confirm |
| add column | `ALTER TABLE student ADD (Suburb VARCHAR2(40));` | new column is NULL in all existing rows |
| retype column | `ALTER TABLE car MODIFY (transmission CHAR(30));` | one verb per statement — **cannot ADD and DROP in one ALTER** |
| drop column | `ALTER TABLE car DROP COLUMN transmission;` / `DROP (CiTTy)` | data destroyed, DDL auto-commits ⟹ irreversible |
| drop table | `DROP TABLE car;` | **fails** while another table holds an FK to it — drop the child (`carsales`) first |

## ✏️ DML & Transactions
*(➔ [[DML INSERT (Oracle)]] · [[DML UPDATE and DELETE (Oracle)]] · [[Database Transaction]])*

| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| insert all cols | `INSERT INTO car VALUES (1,'Holden','Cruze',2015,'Black',25780);` | positional, **every** column in table order |
| insert some cols | `INSERT INTO car (carID, make) VALUES (16,'Audi');` | column list **mandatory** for partial inserts; all `NOT NULL` columns must appear |
| insert a date | `INSERT INTO carsales VALUES (1,4,TO_DATE('04/Feb/2015','DD/MON/YYYY'),25780,824.96);` | a bare `'04-FEB-2015'` is a *string*, not a DATE |
| insert many | `INSERT ALL INTO car VALUES (…) INTO car VALUES (…) SELECT * FROM DUAL;` | one statement, all-or-nothing; use single inserts when rows depend on each other |
| update | `UPDATE car SET colour='Grey' WHERE carID=5;` | one table at a time; several columns OK; **omitting WHERE updates every row** |
| delete | `DELETE FROM car WHERE carID=5;` | **omitting WHERE deletes every row**; deleting a referenced PK raises `ORA-02292: integrity constraint violated - child record found` |
| commit | `COMMIT;` | until then changes sit in the **local buffer only** — commit regularly and exit the client properly |
| `DUAL` | `SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI') FROM DUAL;` | Oracle's one-row dummy table for evaluating an expression with no real source |

## 🔎 Predicates (WHERE) — [[SQL SELECT and WHERE]]
| Predicate | Micro-syntax | Gotcha |
| :-- | :-- | :-- |
| comparison | `price > 2000`, `<>` | `<>` is not-equal |
| range | `price BETWEEN 3000 AND 5300` | inclusive both ends ≡ `>=3000 AND <=5300` |
| set | `emp_no IN (3, 8)` · `colour NOT IN ('Black','White')` | negate: "not 3 nor 8" = `<>3 AND <>8` — **OR is always-true trap** |
| pattern | `name LIKE 'D%'` / `'_JI%'` | `%` any run, `_` one char |
| null test | `rent_in_dt IS NULL` / `IS NOT NULL` | `= NULL` is **always UNKNOWN** — never matches |
| date range | `salesdate BETWEEN TO_DATE('01-JAN-2014','DD-MON-YYYY') AND TO_DATE('31-DEC-2015','DD-MON-YYYY')` | alternative: compare `TO_CHAR(salesdate,'YYYYMMDD') > '20140101'` as sortable strings |
| logic | `NOT` → `AND` → `OR` precedence | 3-valued logic: NULL = UNKNOWN; only TRUE rows returned — bracket everything |

## 🛠 Row Functions & Output Shaping
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `NVL` | `NVL(col, 'Still out')` | replace NULL; types must match ➔ wrap date first: `NVL(TO_CHAR(dt,'dd-Mon-yyyy'),'Still out')` |
| `TO_CHAR` | `TO_CHAR(dt,'dd-Mon-yyyy')`, `TO_CHAR(n,'$9,999')` | date/number → display string; also extracts parts: `TO_CHAR(dt,'yyyy')` |
| `TO_DATE` | `TO_DATE('01-Mar-2021','dd-Mon-yyyy')` | string → date for **comparing/inserting** — never compare raw strings |
| format masks | `DD-MON-YYYY` · `MM/DD/YYYY` · `HH:MI AM` · `MONTH DAY, YYYY` · `DD-MON-YYYY HH24:MI` | the same masks serve TO_DATE (in) and TO_CHAR (out) |
| concat | `cust_fname \|\| ' ' \|\| cust_lname` | Oracle concatenation is `\|\|` |
| case-blind | `UPPER(manuf_name) = UPPER('DJI...')` | normalise both sides — string *values* are case-sensitive, identifiers are not |
| `DISTINCT` | `SELECT DISTINCT make, year` | de-dupes at **record level**, not per attribute — `make` may still repeat |
| alias | `AS avg_flight` · `(purchasedPrice+stampDuty) AS TotalPrice` | usable in ORDER BY only (see execution order); also names computed columns |
| sort | `ORDER BY t DESC, id` · `NULLS LAST/FIRST` | mandatory whenever >1 row possible — tuples have no order |
| conditional | `CASE`/`DECODE` | ➔ [[SQL Conditional Expressions (CASE, DECODE)]] |

## 📦 Aggregates & Grouping — [[SQL Aggregate Functions and GROUP BY]]
- **Five aggregates** ➔ `COUNT / SUM / AVG / MIN / MAX`; `COUNT(*)` counts rows incl. NULLs, `COUNT(col)` non-null only, `COUNT(DISTINCT col)` distinct non-null only.
- **GROUP BY rule** ➔ every non-aggregate SELECT column MUST appear in GROUP BY; column **aliases are illegal** in GROUP BY (not yet computed) — repeat the expression: `GROUP BY to_char(ct_date_start,'yyyy')`.
- **WHERE vs HAVING** ➔ WHERE filters rows *before* grouping; HAVING filters *groups* after, and may contain aggregates: `HAVING COUNT(DISTINCT model) > 1`.
- **Aggregate over a join** ➔ join condition goes in WHERE/ON and runs first; group on the surviving columns.

## 🔗 Joins — [[SQL Joins (ANSI)]] · [[SQL Self Join and Outer Join]]
| Form | Syntax | When |
| :-- | :-- | :-- |
| `JOIN … ON` | `FROM a JOIN b ON a.id = b.id` | **the general form — default choice**, always works |
| `JOIN … USING` | `JOIN b USING (manuf_id)` | identical column names both sides |
| `NATURAL JOIN` | `a NATURAL JOIN b` | all common columns match — ⚠ no common column ⇒ **Cartesian product** |
| self join | `FROM emp e1 JOIN emp e2 ON e1.mgrno = e2.empno` | recursive FK (employee→manager); **distinct aliases required** |
| outer join | `LEFT / RIGHT / FULL OUTER JOIN … ON …` | keep unmatched rows (INNER drops them) |
| implicit / old-style | `FROM customer ct, carsales cs, car c WHERE ct.customerID = cs.customerID AND c.carID = cs.carID` | ⛔ **banned in FIT2094** (marked wrong) · ✅ **standard in FIT3003** — $n$ tables need $n-1$ conditions |

> [!WARNING] **Missing join condition = PRODUCT.** FIT3003 warns that a comma-list `FROM` with no matching WHERE condition returns the Cartesian product, exhausts your Oracle quota, and **locks your account**. Count your ANDs before running.

## 🪆 Subqueries — [[SQL Subquery (Nested SELECT)]] · [[SQL Subquery Approaches (Nested, Correlated, Inline)]]
- **Single value** ➔ compare with `=, <, >`: `WHERE price < (SELECT AVG(price) FROM …)`.
- **List of values** ➔ `IN` / `NOT IN`: `WHERE carID NOT IN (SELECT carID FROM carsales)` — the anti-join "which cars are unsold" shape.
- **ANY / ALL** ➔ `> ANY` (beats at least one ➔ nearly all rows), `> ALL` (beats every one ➔ few rows) — classic MCQ discriminator.
- **Multi-column pairs** ➔ `WHERE (dt_code, price) IN (SELECT dt_code, MAX(price) … GROUP BY dt_code)` — per-group max pattern.
- **In DML** ➔ subquery sets the target set: `UPDATE … SET cost = cost*1.2 WHERE manuf_id = (SELECT …)`; see [[Populating Tables from Queries (INSERT-SELECT, CTAS)]].

## ➕ Advanced SQL (FIT2094 Topic 10)
| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| `CASE` | `CASE WHEN cond THEN 'r' ELSE 'd' END` / `CASE col WHEN v THEN …` | if/else in SELECT; searched form allows ranges |
| `DECODE` | `DECODE(emp_type,'F','Full','C','Casual')` | equality-only legacy of CASE — ➔ [[SQL Conditional Expressions (CASE, DECODE)]] |
| set ops | `q1 UNION / UNION ALL / INTERSECT / MINUS q2` | **union-compatible** (same $\#$cols + types); one final `ORDER BY`; names from q1 — ➔ [[SQL Set Operators]] |
| subquery placement | nested (once) · **correlated** (per-row) · **inline view** (`FROM (SELECT …) alias`) · scalar-in-SELECT | ➔ [[SQL Subquery Approaches (Nested, Correlated, Inline)]] |
| populate table | `INSERT INTO t (SELECT …)` · `CREATE TABLE t AS (SELECT …)` | **CTAS copies data, NOT constraints** — re-add PK/FK after |
| view | `CREATE OR REPLACE VIEW v AS SELECT …` · `DROP VIEW v` | virtual table (stored query); **banned in FIT2094 Assignment 2** — use a subquery |
| date part / format | `EXTRACT(YEAR FROM d)` (number) · `TO_CHAR(d,'yyyy')` (string) | filter/group by a date part |
| text align | `LPAD/RPAD(s,n,'*')` · `LTRIM/TRIM(s)` | monospace-only bar charts |

## 🏭 Warehouse ETL Clauses (FIT3003 W2)
*(➔ [[Building Dimension Tables]] · [[Building Fact Tables]] · [[Fact Measure Aggregation Rules]])*

| Tool | Micro-syntax | Job / gotcha |
| :-- | :-- | :-- |
| dimension by copy | `create table AgentDim as select * from Agent;` | route 1 of 3; rows only, **no PK/FK** |
| dimension by projection | `create table CourseDim as select CourseCode, CourseName from Course;` | route 2 — drop columns no analysis question needs |
| dimension by de-dup | `create table CountryDim as select distinct Country from Student;` | mandatory `distinct` when the source is a **transaction** table |
| dimension by hand | `create table TimeDim (Quarter number(1), Description varchar2(20));` + `insert into … values (1,'Jan-Mar');` | route 3 — members are business knowledge, membership is fixed and known |
| manufactured key | `Country \|\| City as LocationID` · `set QuarterID = Year \|\| Quarter` | builds an ID the operational DB never stored |
| time key | `to_char(DownloadDate,'YYYYMM') as TimeID` · `'MM'` · `'YYYY'` · `'Month'` | `'Month'` yields the *name*; masks are the dimension's attributes |
| staging table | `create table TempFact as select … from a, b where …;` | the **joined, unaggregated** row set; grain preserved for one later `group by` |
| add derived column | `alter table TempFact add (Quarter number(1));` then `update … set Quarter = 1 where …` | the chapter's banding idiom — one `update` per band, not `CASE` |
| null-band catch-all | `update TempFact set Quarter = '4' where Quarter is null;` | last band by exclusion instead of a range test |
| fact by aggregation | `create table SalesFact as select Quarter, BranchID, sum(TotalPrice) as Total_Sales from TempFact group by Quarter, BranchID;` | `group by` list $=$ the fact's composite PK; build **from operational/temp tables, never from the dimensions** |
| two populations | `from Opening O left outer join Placement P on O.OpenNo = P.OpenNo` + `count(OpenNo)` / `count(CandNo)` | outer join keeps unmatched rows; `count(col)` skips the NULLs — `count(*)` would equalise both measures |
| latest-per-entity | `rank() over (partition by E.EmpNo order by D.GraduationDate desc) as Rank` in an inline view, then `where T.Rank = 1` | pre-processes the **operational** side; without it the join multiplies rows per entity |
| ⛔ never store | `avg(x)` as a fact measure | average of averages ≠ average — store `Total_x` **and** `Number_of_y`, recover with `sum(Total_x)/sum(Number_of_y)` |

## ✍️ Integration Practice
> [!QUESTION]- Practice 1 (FIT2094 Topic 8, Q5-style): full name (one column, space-separated) and contact number of customers who completed a training course longer than 4 hours, ordered by name.
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

> [!QUESTION]- Practice 2 (FIT2094 Topic 9, Q10-style): drones cheaper than the average price of all DJI-manufactured drones; show id, type code, price, purchase YEAR, manufacturer name; order by id.
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

> [!QUESTION]- Practice 3 (FIT3003 Lab 1, Q28-style): import a lecturer-owned table into your account, then cost the database labs per week — lab duration × the tutor's hourly rate — using FIT3003's old-style join syntax. Databases = subject codes `CSE21DB`, `CSE31DB`, `CSE41FDB`.
> > [!SUCCESS]- Reference solution
> > ```sql
> > CREATE TABLE LAB AS SELECT * FROM dtaniar.LAB;   -- rows only; PK/FK not copied
> >
> > SELECT   SUM(l.duration * t.salaryperhour) AS weekly_cost
> > FROM     lab l, tutor t
> > WHERE    l.tutorno    = t.tutorno
> > AND      l.subjectcode IN ('CSE21DB','CSE31DB','CSE41FDB');
> > ```
> > - **Key moves:** cross-account CTAS to seed the schema + exactly one join condition for two tables + `IN` for the set membership + `SUM` over a computed expression.
> > - ⚠ **Column names unverified** ➔ only `SALARYPERHOUR` is named in the lab sheet; `duration`, `tutorno`, `subjectcode` are inferred — confirm against the lab E/R diagram with `DESC LAB;` before relying on them.

## ⚠️ Common Mistakes
- 💡 **`= NULL` never matches** ➔ 3-valued logic makes it UNKNOWN; only `IS NULL` works.
- 💡 **"not A or B" trap** ➔ `emp_no <> 3 OR emp_no <> 8` is TRUE for every row; exclusion needs `AND`.
- 💡 **Alias in GROUP BY** ➔ illegal (GROUP BY runs before SELECT); repeat the full expression.
- 💡 **Forgetting `COMMIT`** ➔ your inserts exist only in the session buffer; close the client badly and the work is gone.
- 💡 **Word's curly quotes** ➔ SQL pasted from a `.docx` lab sheet carries `'` instead of `'`; Oracle rejects it — retype the quote.
- 💡 **Building a FIT3003 fact from the dimension tables** ➔ dimensions were created with `select distinct` and hold no measures; aggregate from the operational (or Temp) tables.
