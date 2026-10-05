---
unit: FIT3003
type: MOC
tags: [2026/S2]
---
# 📘 FIT3003: Business Intelligence and Data Warehousing

> [!INFO] Map of Content
> Index for **FIT3003 BI and Data Warehousing** — dimensional modelling on Oracle. Prerequisite skills are the FIT2094 E/R model and SQL, revised in Week 1. Start with [[Data Engineering]].

## 📊 Assessment Map

- **Assessment 1 — Online Quiz (10%)** ➔ Introduction to Data Warehousing and Star Schemas; **due Monday of Week 6** (the W4 slide dates this 1 September 2026)
- **Assessment 2 — Individual Assignment (40%)** ➔ THE unit: design a warehouse and implement it in Oracle; **opens Wed 7 October 2026, due Wed 14 October 2026, 11:55 PM** (W8 webinar); fed by [[Star Schema]] and [[Oracle SQL Toolkit (Cheatsheet)]]. Four tasks, stated in Lab 3: **1** clean the input data (an ERD is *not* supplied — draw one) · **2–3** draw the star and create it in SQL · **4** answer the given queries **plus one of your own**, each touching the fact and $\geq 1$ dimension, with a justification of why management would want it.
- **Assessment 3 — Online Quiz (10%)**
- **Exam (40%)**

**Topics covered:** data warehousing (ETL, multidimensional schemas, star/snowflake) · OLAP · data analytics.

## 🧰 Toolkit Cheatsheets
- [[Oracle SQL Toolkit (Cheatsheet)]] -> shared with FIT2094; extended for FIT3003 with DDL/DML, `INSERT ALL`, cross-account CTAS, the **old-style join** syntax this unit uses, the W2 warehouse-ETL clauses, the W3 exploration/cleaning probes, and the W4 bridge/`LISTAGG`/weight-factor clauses, and the W5–W6 sequence/pivot/junk clauses (`create sequence`, `.nextval`, `(+)`, `nvl`, correlated `update`), plus the Lab 6 join-sourced dimension and pivot grid-trim clauses, and the W7 combine/slice clauses (`union`-merge, multi-fact join, the one-dimension pivot, vertical and horizontal slice CTAS, top-N `rownum`, shared-dimension querying), and the W8 multi-input/granularity clauses (cross-source `"Club.Table"` addressing, union-of-unions dimensions, `||` date derivation, source-key stamping, vertical vs horizontal stacking, TempFact re-graining), and the W9 OLAP clauses (`cube` / `rollup` / partial forms, `grouping` $+$ `decode` labels, `rank` / `dense_rank` / `row_number` / `percent_rank`, `partition by`, rank-based Top-N, `rows unbounded preceding` / `rows n preceding`)

## 📅 Knowledge Index

### Week 1 — Data Engineering, Data Warehousing & SQL Revision
- [[Data Engineering]] -> Parent Framework: [[Data Science]]
- [[Data Warehouse]] -> Parent Framework: [[Data Engineering]]
- [[Star Schema]] -> Parent Framework: [[Data Warehouse]]

**SQL revision** — Week 1 re-teaches FIT2094 SQL; the FIT3003 deltas were merged into the existing notes:
- [[SQL Joins (ANSI)]] *(W1: old-style comma+WHERE join — used in FIT3003, banned in FIT2094)*
- [[DML INSERT (Oracle)]] *(W1: `INSERT ALL … SELECT * FROM DUAL`, partial-insert column-list rule)*
- [[Altering and Dropping Tables]] *(W1: column-level ADD/MODIFY/DROP, CHAR vs VARCHAR2)*
- [[Populating Tables from Queries (INSERT-SELECT, CTAS)]] *(W1: cross-account `CREATE TABLE … AS SELECT * FROM dtaniar.x`)*
- [[DDL Table Creation]] · [[Oracle Data Types]] · [[SQL SELECT and WHERE]] · [[SQL Sorting, Distinct & Alias]] · [[SQL Aggregate Functions and GROUP BY]] · [[SQL Subquery (Nested SELECT)]] · [[DML UPDATE and DELETE (Oracle)]] · [[Database Transaction]]

### Week 2 — Simple Star Schemas (Ch2) & More Complex Facts and Dimensions (Ch3)
- [[Star Schema]] -> Parent Framework: [[Data Warehouse]] *(W2 merge: notation, transformation process, the Chapter 2 College answer)*
- [[Two-Column Table Methodology]] -> Parent Framework: [[Star Schema]]
- [[Building Dimension Tables]] -> Parent Framework: [[Star Schema]]
- [[Building Fact Tables]] -> Parent Framework: [[Star Schema]]
- [[Fact Measure Aggregation Rules]] -> Parent Framework: [[Star Schema]]

### Week 3 — Data Cleaning (USELOG & ROBCOR case studies)
- [[Data Exploration (Warehouse Validation)]] -> Parent Framework: [[Data Engineering]]
- [[Data Cleaning (Dirty Data)]] -> Parent Framework: [[Data Exploration (Warehouse Validation)]]
- [[Multi-Role Facts]] -> Parent Framework: [[Star Schema]] *(ROBCOR pilot / co-pilot)*
- [[One-Attribute Dimensions]] -> Parent Framework: [[Star Schema]] *(feedback session)*
- [[Two-Column Table Methodology]] *(W3 merge: the `Number_of_Reviews` failure case, the grounding check)*
- [[Building Dimension Tables]] *(W3 merge: why dimensions exist at query time; the shared-description trap)*

### Week 4 — Hierarchies (Ch4), Bridge Tables (Ch5) & Snowflake Schemas
- [[Snowflake Schema]] -> Parent Framework: [[Star Schema]]
- [[Dimension Hierarchies]] -> Parent Framework: [[Snowflake Schema]]
- [[Bridge Tables]] -> Parent Framework: [[Snowflake Schema]]
- [[Building Bridge Table Schemas]] -> Parent Framework: [[Bridge Tables]]
- [[Star Schema]] *(W4 merge: the one-hop rule and its snowflake exception)*
- [[Data Warehouse]] *(W4 merge: the five reasons warehousing is needed — Feedback Session 3)*

### Week 5 — Temporal Data Warehousing (Ch6)
- [[Slowly Changing Dimensions (SCD)]] -> Parent Framework: [[Star Schema]] *(captured from the W6 webinar recap deck — confirm against the W5 slides)*

### Week 6 — Determinant Dimensions (Ch7) & self-study Chapters 8–10
- [[Determinant Dimensions]] -> Parent Framework: [[Star Schema]] *(Lab 6 merge: the $5\times$ over-count trap)*
- [[Pivoted Fact Tables]] -> Parent Framework: [[Determinant Dimensions]] *(Lab 6 merge: PTE case — dimension sourcing, the zero-row trim, both report sets)*
- [[Junk Dimensions]] -> Parent Framework: [[Star Schema]]
- [[One-Attribute Dimensions]] *(W6 merge: Ch9 dimension-less keys; Ch10's full move-or-keep taxonomy)*
- [[Surrogate Key]] *(W6 merge: Ch9 sequence implementation; optional when the operational PK is already unique)*
- [[Star Schema]] *(W6 merge: dashed-box determinant notation, the dimension-less-key band)*
- [[Fact Measure Aggregation Rules]] *(W6 merge: the single case where a stored `avg` is legal)*

### Week 7 — Multi-Fact Star Schemas (Ch11) & Slicing a Fact (Ch12)
- [[Multi-Fact Star Schemas]] -> Parent Framework: [[Star Schema]] *(Lab 7 merge: the Book Sales build on the `dtaniar` tables and the five report queries, incl. the `rownum` top-N)*
- [[Combining Star Schemas]] -> Parent Framework: [[Multi-Fact Star Schemas]]
- [[Slicing a Fact]] -> Parent Framework: [[Multi-Fact Star Schemas]]
- [[Determinant Dimensions]] *(W7 merge: the pilot/co-pilot double count, Part-grain determinacy, the Type Dimension shape, determinacy lost after slicing)*
- [[Pivoted Fact Tables]] *(W7 merge: the one-dimension pivot idiom — zeroed columns $+$ correlated `update`)*

### Week 8 — Granularity and Levels of Aggregation (Ch14) & Multi-Input Operational Databases (Ch13)
*(the webinar itself was a Ch11 recap $+$ the A2 announcement; the new content is the two chapter decks)*
*(Lab 8a — Clothing Company and Toll Way — is a pure drawing drill with no SQL; merged as the two applied exercises in [[Levels of Aggregation]])*
- [[Levels of Aggregation]] -> Parent Framework: [[Data Warehouse]]
- [[Identifying a Level-0 Star Schema]] -> Parent Framework: [[Levels of Aggregation]]
- [[Fact Constellation]] -> Parent Framework: [[Levels of Aggregation]]
- [[Multi-Input Operational Databases]] -> Parent Framework: [[Data Warehouse]]
- [[Star Schema]] *(W8 merge: the fact as an $n$-ary relationship standing for the E/R transaction; the granularity ladder)*
- [[Multi-Fact Star Schemas]] *(W8 merge: dimension hierarchies as the systematic source of granularity multi-facts)*
- [[Levels of Aggregation]] *(Lab 8a merge: count the aggregated dimensions, lower one for Level-1 and all for Level-0; the Oracle `date` loophole)*

### Week 9 — OLAP (Ch19) & Power BI
*(the webinar opened with a W8 [[Levels of Aggregation]] recap — nothing new there; the content is the Chapter 19 deck and the Power BI deck)*
- [[OLAP (On-Line Analytical Processing)]] -> Parent Framework: [[Data Warehouse]]
- [[OLAP Cube and Rollup]] -> Parent Framework: [[OLAP (On-Line Analytical Processing)]]
- [[OLAP Ranking and Top-N]] -> Parent Framework: [[OLAP (On-Line Analytical Processing)]]
- [[OLAP Cumulative and Moving Aggregates]] -> Parent Framework: [[OLAP (On-Line Analytical Processing)]]
- [[Power BI]] -> Parent Framework: [[OLAP (On-Line Analytical Processing)]]
- [[SQL Aggregate Functions and GROUP BY]] *(W9 merge: `count(distinct …)` — Ch19 §1 is otherwise FIT2094 revision)*

## 🧭 Suggested Reading Order
- **W2 — draft, validate, build:** [[Star Schema]] *(notation)* → [[Two-Column Table Methodology]] *(validate first)* → **[[Building Dimension Tables]]** *(A2 hand skill)* → **[[Building Fact Tables]]** *(A2 hand skill)* → [[Fact Measure Aggregation Rules]] *(measure choice)*
- **W3 — never trust the source:** **[[Data Exploration (Warehouse Validation)]]** *(A2 task 1)* → **[[Data Cleaning (Dirty Data)]]** *(A2 task 1)* → [[Multi-Role Facts]] *(two-role transactions)* → [[One-Attribute Dimensions]] *(refinement)*
- **W4 — when the star must bend:** [[Snowflake Schema]] *(the two families)* → [[Dimension Hierarchies]] *(optional, usually reject)* → **[[Bridge Tables]]** *(A2 hand skill)* → **[[Building Bridge Table Schemas]]** *(lab SQL)*
- **W5 — the past must stay past:** [[Slowly Changing Dimensions (SCD)]] *(six types, one ladder)*
- **W6 — when a dimension is compulsory:** **[[Determinant Dimensions]]** *(the test)* → **[[Pivoted Fact Tables]]** *(the ETL recipe)* → [[Junk Dimensions]] *(the opposite move)* → [[One-Attribute Dimensions]] *(move or keep)* → [[Surrogate Key]] *(sequence keys)*
- **W7 — one star, many facts:** **[[Multi-Fact Star Schemas]]** *(the two causes)* → **[[Combining Star Schemas]]** *(the pools test)* → [[Slicing a Fact]] *(vertical vs horizontal)*
- **W8 — how far has it been rolled up:** **[[Levels of Aggregation]]** *(the ladder $+$ the two lowering moves)* → **[[Identifying a Level-0 Star Schema]]** *(the declared exam trap)* → [[Fact Constellation]] *(hierarchy $\times$ multi-fact)* → **[[Multi-Input Operational Databases]]** *(A2-shaped ETL)* · *drill Lab 8a's two cases before the exam*
- **W9 — read the warehouse:** [[OLAP (On-Line Analytical Processing)]] *(which family)* → **[[OLAP Cube and Rollup]]** *(row-count arithmetic)* → **[[OLAP Ranking and Top-N]]** *(tie behaviour)* → **[[OLAP Cumulative and Moving Aggregates]]** *(window trace)* → [[Power BI]] *(Data → Model → Report)*

## 🎯 Learning Outcomes

- **W1** ➔ 
	- argue why ad-hoc cleaning fails and modularisation wins 
	- contrast software vs data engineering 
	- place ETL, OLAP and BI on the delivery chain 
	- separate operational DB from warehouse (precomputed, granularity, pre-designed) 
	- derive fact, grain, dimensions and attributes from analysis questions 
	- write FIT3003 old-style joins without producing a Cartesian product
- **W2** ➔ 
	- draw a star in unit notation — `XxxDIM`/`XxxFACT`, dimension ID as FK+PK in the fact
	- validate a drafted star with the two-column table method
	- create dimensions directly, or stage a derived attribute in a temp dimension
	- aggregate a fact from operational tables, a `TempFact`, or a pre-processed source
	- use `left outer join` + `count(attribute)` for two unequal populations
	- reject `avg` as a stored measure; store total $+$ count instead
- **W3** ➔ 
	- predict a 1–$m$ join's row count and reconcile it against the TempFact
	- probe duplicates with `group by <key> having count(*) > 1` on **both** join sides
	- detect the five dirty-data types and write the check-then-repair pair
	- clean with `select distinct` at the join, or a cleaned source copy
	- split a two-role transaction into one star schema per role
	- rule out `union`-merging a fact whose measures belong to the trip, not the person
- **W4** ➔ 
	- split a dimension into a many-1 hierarchy chain
	- choose among separate, combined, hierarchy and linked dimensions
	- reject a hierarchy that keys the fact at the coarse level
	- detect the source m–m that forces a bridge table
	- build a bridge by copying the operational associative table
	- compute $\text{WeightFactor}$ and `LISTAGG` in the parent dimension
- **W5** ➔ 
	- report a measure at the attribute value true when the fact happened
	- separate SCD types by where the history lives
	- reject types 0 and 1 for any historical report
	- key a Type 4 history table on $(\text{ID}, \text{StartDate}, \text{EndDate})$
	- read a Type 2 dimension via `CurrentFlag` or a date range
- **W6** ➔ 
	- test a dimension for determinacy from the fact's aggregate function, not its "Type" label
	- pin the determinant attribute in every fact query, or the measure over-counts
	- enforce a determinant dimension by pivot or by user interface
	- build a pivoted fact with `AllDimensions` $+$ `(+)` $+$ `nvl`
	- consolidate unrelated low-cardinality dimensions into a `JunkDim`
	- key a dimension with `create sequence` and `.nextval`
- **W7** ➔ 
	- justify a second fact by subject or granularity, via the measure $\times$ dimension grid
	- reject a multi-fact drafted from differing units of measure
	- route each report to the fact that owns its measure; top-N with `rownum` over an ordered inline view
	- collapse many child rows to one with `round(avg(...))` before joining a fact
	- classify a combine question by pool count and transaction record
	- pick vertical vs horizontal slice from pivoted fact vs type dimension
- **W8** ➔ 
	- place a star schema on the granularity ladder, or declare two schemas incomparable
	- draw the Level-1 and Level-0 stars for a given Level-2 star, justifying each dimension swap
	- lower a level by **adding** a dimension or **replacing** one with a higher-granularity dimension
	- drop a `count` fact measure that is all $1$s at Level-0, and refuse to drop a `sum` one
	- locate the transaction entity in the E/R diagram and test a draft for Level-0
	- count the fact tables ($\prod_i \ell_i$) and the lattice levels of a multi-hierarchy fact constellation
	- stack per-source facts **vertically** with `union`, or **horizontally** with zero-padded measures $+$ an outer `sum`
- **W9** ➔ 
	- match a report's shape to its OLAP family: `group by`, `cube`/`rollup`, ranking, cumulative/moving, drill down
	- predict a `cube` ($2^n$ sets) or `rollup` ($n+1$ sets) row count, including the partial forms
	- label subtotal rows with `decode(grouping(col), 1, 'All …', col)`
	- choose `rank` / `dense_rank` / `row_number` by how ties must behave
	- write Top-N and top-percent as a filter outside an inline view
	- rank within groups with `partition by`
	- write a running total with `sum(sum(m)) over (… rows unbounded preceding)` and a $k$-period moving average with `rows k-1 preceding`
	- trace both window columns by hand, first rows included
	- build a Power BI report: Data → Model (dimension `1` → fact `*`) → Report, with the right default aggregation and filter scope
