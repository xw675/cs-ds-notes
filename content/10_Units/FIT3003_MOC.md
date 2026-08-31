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
- **Assessment 2 — Individual Assignment (40%)** ➔ THE unit: design a warehouse and implement it in Oracle; fed by [[Star Schema]] and [[Oracle SQL Toolkit (Cheatsheet)]]. Four tasks, stated in Lab 3: **1** clean the input data (an ERD is *not* supplied — draw one) · **2–3** draw the star and create it in SQL · **4** answer the given queries **plus one of your own**, each touching the fact and $\geq 1$ dimension, with a justification of why management would want it.
- **Assessment 3 — Online Quiz (10%)**
- **Exam (40%)**

**Topics covered:** data warehousing (ETL, multidimensional schemas, star/snowflake) · OLAP · data analytics.

## 🧰 Toolkit Cheatsheets
- [[Oracle SQL Toolkit (Cheatsheet)]] -> shared with FIT2094; extended for FIT3003 with DDL/DML, `INSERT ALL`, cross-account CTAS, the **old-style join** syntax this unit uses, the W2 warehouse-ETL clauses, the W3 exploration/cleaning probes, and the W4 bridge/`LISTAGG`/weight-factor clauses, and the W5–W6 sequence/pivot/junk clauses (`create sequence`, `.nextval`, `(+)`, `nvl`, correlated `update`)

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
- [[DDL Table Creation]] · [[Oracle Data Types]] · [[SQL SELECT and WHERE]] · [[SQL Sorting, Distinct & Alias]] · [[SQL Aggregate Functions and GROUP BY]] · [[SQL Subquery (Nested SELECT)]] · [[DML UPDATE and DELETE (Oracle)]] · [[Database Transaction]] *(unchanged — revision only)*

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
- [[Determinant Dimensions]] -> Parent Framework: [[Star Schema]]
- [[Pivoted Fact Tables]] -> Parent Framework: [[Determinant Dimensions]]
- [[Junk Dimensions]] -> Parent Framework: [[Star Schema]]
- [[One-Attribute Dimensions]] *(W6 merge: Ch9 dimension-less keys; Ch10's full move-or-keep taxonomy)*
- [[Surrogate Key]] *(W6 merge: Ch9 sequence implementation; optional when the operational PK is already unique)*
- [[Star Schema]] *(W6 merge: dashed-box determinant notation, the dimension-less-key band)*
- [[Fact Measure Aggregation Rules]] *(W6 merge: the single case where a stored `avg` is legal)*

## 🧭 Suggested Reading Order
- **W2 — draft, validate, build:** [[Star Schema]] *(notation)* → [[Two-Column Table Methodology]] *(validate first)* → **[[Building Dimension Tables]]** *(A2 hand skill)* → **[[Building Fact Tables]]** *(A2 hand skill)* → [[Fact Measure Aggregation Rules]] *(measure choice)*
- **W3 — never trust the source:** **[[Data Exploration (Warehouse Validation)]]** *(A2 task 1)* → **[[Data Cleaning (Dirty Data)]]** *(A2 task 1)* → [[Multi-Role Facts]] *(two-role transactions)* → [[One-Attribute Dimensions]] *(refinement)*
- **W4 — when the star must bend:** [[Snowflake Schema]] *(the two families)* → [[Dimension Hierarchies]] *(optional, usually reject)* → **[[Bridge Tables]]** *(A2 hand skill)* → **[[Building Bridge Table Schemas]]** *(lab SQL)*
- **W5 — the past must stay past:** [[Slowly Changing Dimensions (SCD)]] *(six types, one ladder)*
- **W6 — when a dimension is compulsory:** **[[Determinant Dimensions]]** *(the test)* → **[[Pivoted Fact Tables]]** *(the ETL recipe)* → [[Junk Dimensions]] *(the opposite move)* → [[One-Attribute Dimensions]] *(move or keep)* → [[Surrogate Key]] *(sequence keys)*

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
	- test a dimension for determinacy from the fact's aggregate function
	- reject the inference "Type Dimension $\Rightarrow$ determinant"
	- enforce a determinant dimension by pivot or by user interface
	- build a pivoted fact with `AllDimensions` $+$ `(+)` $+$ `nvl`
	- consolidate unrelated low-cardinality dimensions into a `JunkDim`
	- key a dimension with `create sequence` and `.nextval`
