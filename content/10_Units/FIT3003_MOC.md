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
- **Assessment 2 — Individual Assignment (40%)** ➔ THE unit: design a warehouse and implement it in Oracle; fed by [[Star Schema]] and [[Oracle SQL Toolkit (Cheatsheet)]].
- **Assessment 3 — Online Quiz (10%)**
- **Exam (40%)**

**Topics covered:** data warehousing (ETL, multidimensional schemas, star/snowflake) · OLAP · data analytics.

## 🧰 Toolkit Cheatsheets
- [[Oracle SQL Toolkit (Cheatsheet)]] -> shared with FIT2094; extended for FIT3003 with DDL/DML, `INSERT ALL`, cross-account CTAS, and the **old-style join** syntax this unit uses

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

## 🎯 Learning Outcomes

- **W1** ➔ 
	- argue why ad-hoc cleaning fails and modularisation wins 
	- contrast software vs data engineering 
	- place ETL, OLAP and BI on the delivery chain 
	- separate operational DB from warehouse (precomputed, granularity, pre-designed) 
	- derive fact, grain, dimensions and attributes from analysis questions 
	- write FIT3003 old-style joins without producing a Cartesian product
