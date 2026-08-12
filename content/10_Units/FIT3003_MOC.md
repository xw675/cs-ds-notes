---
unit: FIT3003
type: MOC
tags: [2026/S2]
---
# 📘 FIT3003: Business Intelligence and Data Warehousing

> [!INFO] Map of Content
> Index for **FIT3003 BI and Data Warehousing** — dimensional modelling on Oracle. Prerequisite skills are the FIT2094 E/R model and SQL, revised in Week 1. Start with [[Data Engineering]].

## 📊 Assessment Map

- **Assessment 1 — Online Quiz (10%)**
- **Assessment 2 — Individual Assignment (40%)** ➔ THE unit: design a warehouse and implement it in Oracle; fed by [[Star Schema]] and [[Oracle SQL Toolkit (Cheatsheet)]]. Four tasks, stated in Lab 3: **1** clean the input data (an ERD is *not* supplied — draw one) · **2–3** draw the star and create it in SQL · **4** answer the given queries **plus one of your own**, each touching the fact and $\geq 1$ dimension, with a justification of why management would want it.
- **Assessment 3 — Online Quiz (10%)**
- **Exam (40%)**

**Topics covered:** data warehousing (ETL, multidimensional schemas, star/snowflake) · OLAP · data analytics.

## 🧰 Toolkit Cheatsheets
- [[Oracle SQL Toolkit (Cheatsheet)]] -> shared with FIT2094; extended for FIT3003 with DDL/DML, `INSERT ALL`, cross-account CTAS, the **old-style join** syntax this unit uses, the W2 warehouse-ETL clauses, and the W3 exploration/cleaning probes

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

## 🧭 Suggested Reading Order
- **W2 — draft, validate, build:** [[Star Schema]] *(notation)* → [[Two-Column Table Methodology]] *(validate first)* → **[[Building Dimension Tables]]** *(A2 hand skill)* → **[[Building Fact Tables]]** *(A2 hand skill)* → [[Fact Measure Aggregation Rules]] *(measure choice)*
- **W3 — never trust the source:** **[[Data Exploration (Warehouse Validation)]]** *(A2 task 1)* → **[[Data Cleaning (Dirty Data)]]** *(A2 task 1)* → [[Multi-Role Facts]] *(two-role transactions)* → [[One-Attribute Dimensions]] *(refinement)*

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
