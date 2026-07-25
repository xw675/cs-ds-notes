---
unit: FIT2094
type: MOC
tags: [2026/S1]
---
# 📘 FIT2094: Databases

> [!INFO] Map of Content
> Index for **FIT2094 Databases** — conceptual modelling in **Crow's Foot** throughout. Start with [[Database Design Life Cycle]].

## 📊 Assessment Map

- **Written Assignment (70%)** ➔ THE unit: design (ER → logical → normalised) + executable Oracle SQL; fed by Weeks 2–10 and [[Oracle SQL Toolkit (Cheatsheet)]].
- **Test (30%)** ➔ theory: relational model, relational algebra, normalisation reasoning. No exam.

## 🧰 Toolkit Cheatsheets
- 📌 [[FIT2094 Unit Cheatsheet]] — design pipeline, normalisation, SQL decision rules, transactions, NoSQL
- [[Oracle SQL Toolkit (Cheatsheet)]] -> integrates Topics 8–9: anatomy, predicates, functions, joins, subqueries + integration practice

## 📅 Knowledge Index

### Week 2 — Conceptual Modelling (ER, Crow's Foot)
- [[Database Design Life Cycle]] -> Parent Framework: [[Conceptual Model]]
- [[Conceptual Model]] -> Parent Framework: [[Database Design Life Cycle]]
- [[Entity Relationship Diagram (ERD)]] -> Parent Framework: [[Conceptual Model]]
- [[Entity (Conceptual Modelling)]] -> Parent Framework: [[Entity Relationship Diagram (ERD)]]
- [[Attribute (Conceptual Modelling)]] -> Parent Framework: [[Entity (Conceptual Modelling)]]
- [[Relationship (Conceptual Modelling)]] -> Parent Framework: [[Entity Relationship Diagram (ERD)]]
- [[Cardinality (Crow's Foot Notation)]] -> Parent Framework: [[Relationship (Conceptual Modelling)]]
- [[Identifying vs Non-Identifying Relationship]] -> Parent Framework: [[Relationship (Conceptual Modelling)]]
- [[Associative Entity]] -> Parent Framework: [[Relationship (Conceptual Modelling)]]
- [[Conceptual vs Logical Model]] -> Parent Framework: [[Conceptual Model]]

### Week 3 — The Relational Model and Relational Algebra
- [[Relational Model]] -> Parent Framework: [[Conceptual vs Logical Model]]
- [[Domain (Relational Model)]] -> Parent Framework: [[Relational Model]]
- [[Relation (Database)]] -> Parent Framework: [[Relational Model]]
- [[Relation Properties]] -> Parent Framework: [[Relation (Database)]]
- [[Functional Dependency]] -> Parent Framework: [[Relation (Database)]]
- [[Super Key and Candidate Key]] -> Parent Framework: [[Relation (Database)]]
- [[Primary Key]] -> Parent Framework: [[Super Key and Candidate Key]]
- [[Foreign Key and Referential Integrity]] -> Parent Framework: [[Primary Key]]
- [[Data Integrity]] -> Parent Framework: [[Relational Model]]
- [[NULL Value]] -> Parent Framework: [[Relational Model]]
- [[Relational Algebra]] -> Parent Framework: [[Relational Model]]
- [[Select and Project (σ, π)]] -> Parent Framework: [[Relational Algebra]]
- [[Set Operations in Relational Algebra]] -> Parent Framework: [[Relational Algebra]]
- [[Relational Algebra Joins]] -> Parent Framework: [[Relational Algebra]]

### Week 4 — Normalisation
- [[Database Anomalies]] -> Parent Framework: [[Normalisation]]
- [[Functional Dependency]] -> Parent Framework: [[Relation (Database)]] *(extended in Week 4: full/partial/transitive/total)*
- [[Normalisation]] -> Parent Framework: [[Relational Model]]
- [[Unnormalised Form (UNF)]] -> Parent Framework: [[Normalisation]]
- [[First Normal Form (1NF)]] -> Parent Framework: [[Normalisation]]
- [[Second Normal Form (2NF)]] -> Parent Framework: [[Normalisation]]
- [[Third Normal Form (3NF)]] -> Parent Framework: [[Normalisation]]
- [[Synthesis (Normalisation)]] -> Parent Framework: [[Normalisation]]

### Week 5 — Logical Modelling (ER → Relational)
- [[Logical Modelling (ER Mapping)]] -> Parent Framework: [[Conceptual vs Logical Model]]
- [[Mapping Entities and Attributes (Logical)]] -> Parent Framework: [[Logical Modelling (ER Mapping)]]
- [[Mapping Binary Relationships (Logical)]] -> Parent Framework: [[Logical Modelling (ER Mapping)]]
- [[Mapping Unary and Ternary Relationships (Logical)]] -> Parent Framework: [[Logical Modelling (ER Mapping)]]
- [[Logical Modelling Constraints]] -> Parent Framework: [[Logical Modelling (ER Mapping)]]
- [[Surrogate Key]] -> Parent Framework: [[Primary Key]]

### Week 6 — Physical Design & DDL (Oracle)
- [[Personal Data and Privacy in Database Design]] -> Parent Framework: [[Database Design Life Cycle]]
- [[SQL Sublanguages (DDL, DML, DCL)]] -> Parent Framework: [[Relational Model]]
- [[Oracle Data Types]] -> Parent Framework: [[SQL Sublanguages (DDL, DML, DCL)]]
- [[DDL Table Creation]] -> Parent Framework: [[SQL Sublanguages (DDL, DML, DCL)]]
- [[Altering and Dropping Tables]] -> Parent Framework: [[DDL Table Creation]]
- [[Column Value Constraints (Check vs Lookup)]] -> Parent Framework: [[Data Integrity]]
- [[Foreign Key and Referential Integrity]] -> Parent Framework: [[Primary Key]] *(extended in Week 6: on-delete RESTRICT/CASCADE/SET NULL)*

### Week 7 — DML & Transactions
- [[DML INSERT (Oracle)]] -> Parent Framework: [[SQL Sublanguages (DDL, DML, DCL)]]
- [[DML UPDATE and DELETE (Oracle)]] -> Parent Framework: [[SQL Sublanguages (DDL, DML, DCL)]]
- [[Database Transaction]] -> Parent Framework: [[SQL Sublanguages (DDL, DML, DCL)]]
- [[ACID Properties]] -> Parent Framework: [[Database Transaction]]
- [[Concurrency Control and Locking]] -> Parent Framework: [[Database Transaction]]
- [[Deadlock]] -> Parent Framework: [[Concurrency Control and Locking]]
- [[Database Recovery]] -> Parent Framework: [[Database Transaction]]

### Week 8 — SQL Querying (SELECT)
- [[SQL SELECT and WHERE]] -> Parent Framework: [[SQL Sublanguages (DDL, DML, DCL)]]
- [[SQL Sorting, Distinct & Alias]] -> Parent Framework: [[SQL SELECT and WHERE]]
- [[SQL Formatting Functions (NVL, TO_CHAR, TO_DATE)]] -> Parent Framework: [[SQL SELECT and WHERE]]
- [[SQL Joins (ANSI)]] -> Parent Framework: [[SQL SELECT and WHERE]]
- [[SQL Subquery (Nested SELECT)]] -> Parent Framework: [[SQL SELECT and WHERE]]

### Week 9 — SQL Intermediate (Aggregation & Subqueries)
- [[SQL Aggregate Functions and GROUP BY]] -> Parent Framework: [[SQL SELECT and WHERE]]
- [[SQL Subquery (Nested SELECT)]] -> Parent Framework: [[SQL SELECT and WHERE]] *(extended in Week 9: scalar / column / multi-column output types, ANY/ALL)*

### Week 10 — Advanced SQL
- [[SQL Conditional Expressions (CASE, DECODE)]] -> Parent Framework: [[SQL SELECT and WHERE]]
- [[SQL Subquery Approaches (Nested, Correlated, Inline)]] -> Parent Framework: [[SQL Subquery (Nested SELECT)]]
- [[Populating Tables from Queries (INSERT-SELECT, CTAS)]] -> Parent Framework: [[DDL Table Creation]]
- [[SQL Views]] -> Parent Framework: [[SQL SELECT and WHERE]]
- [[SQL Self Join and Outer Join]] -> Parent Framework: [[SQL Joins (ANSI)]]
- [[SQL Set Operators]] -> Parent Framework: [[SQL SELECT and WHERE]]
- [[SQL Formatting Functions (NVL, TO_CHAR, TO_DATE)]] -> Parent Framework: [[SQL SELECT and WHERE]] *(extended in Week 10: EXTRACT, LPAD/RPAD, LTRIM/TRIM)*
- [[Query Processing and the Optimiser]] -> Parent Framework: [[SQL SELECT and WHERE]]

### Week 11 — Big Data & NoSQL (Relational vs Non-Relational)
- [[Big Data and the Vs]] -> Parent Framework: [[Relational Model]]
- [[NoSQL Databases]] -> Parent Framework: [[Big Data and the Vs]]
- [[NoSQL Data Models]] -> Parent Framework: [[NoSQL Databases]]
- [[MongoDB Document Model]] -> Parent Framework: [[NoSQL Data Models]]
- [[MongoDB CRUD Operations]] -> Parent Framework: [[MongoDB Document Model]]

## 🧭 Suggested Reading Order
*(read left→right within each week · **bold** = the assignment-critical skill of that week)*

- **W2 — conceptual modelling:** [[Database Design Life Cycle]] → [[Conceptual Model]] → [[Entity Relationship Diagram (ERD)]] → [[Entity (Conceptual Modelling)]] → [[Attribute (Conceptual Modelling)]] → [[Relationship (Conceptual Modelling)]] → **[[Cardinality (Crow's Foot Notation)]]** → [[Identifying vs Non-Identifying Relationship]] → **[[Associative Entity]]** *(M:N resolution)* → [[Conceptual vs Logical Model]]
- **W3 — relational theory:** [[Relational Model]] → [[Domain (Relational Model)]] → [[Relation (Database)]] → [[Relation Properties]] → [[Functional Dependency]] → **[[Super Key and Candidate Key]]** → [[Primary Key]] → **[[Foreign Key and Referential Integrity]]** → [[Data Integrity]] → [[NULL Value]] → [[Relational Algebra]] → [[Select and Project (σ, π)]] → [[Set Operations in Relational Algebra]] → [[Relational Algebra Joins]]
- **W4 — normalisation:** [[Database Anomalies]] → [[Functional Dependency]] *(full/partial/transitive)* → **[[Normalisation]]** → [[Unnormalised Form (UNF)]] → [[First Normal Form (1NF)]] → [[Second Normal Form (2NF)]] → **[[Third Normal Form (3NF)]]** → [[Synthesis (Normalisation)]]
- **W5 — logical mapping:** [[Logical Modelling (ER Mapping)]] → [[Mapping Entities and Attributes (Logical)]] → **[[Mapping Binary Relationships (Logical)]]** → [[Mapping Unary and Ternary Relationships (Logical)]] → [[Logical Modelling Constraints]] → [[Surrogate Key]]
- **W6 — DDL:** [[Personal Data and Privacy in Database Design]] → [[SQL Sublanguages (DDL, DML, DCL)]] → [[Oracle Data Types]] → **[[DDL Table Creation]]** → [[Altering and Dropping Tables]] → [[Column Value Constraints (Check vs Lookup)]] → [[Foreign Key and Referential Integrity]] *(on-delete actions)*
- **W7 — DML & transactions:** **[[DML INSERT (Oracle)]]** → [[DML UPDATE and DELETE (Oracle)]] → [[Database Transaction]] → [[ACID Properties]] → [[Concurrency Control and Locking]] → [[Deadlock]] → [[Database Recovery]]
- **W8 — SELECT foundations:** **[[SQL SELECT and WHERE]]** → [[SQL Sorting, Distinct & Alias]] → [[SQL Formatting Functions (NVL, TO_CHAR, TO_DATE)]] → **[[SQL Joins (ANSI)]]** → [[SQL Subquery (Nested SELECT)]]
- **W9 — aggregation:** **[[SQL Aggregate Functions and GROUP BY]]** → [[SQL Subquery (Nested SELECT)]] *(operator by output shape)*
- **W10 — advanced SQL:** [[SQL Conditional Expressions (CASE, DECODE)]] → **[[SQL Subquery Approaches (Nested, Correlated, Inline)]]** → [[Populating Tables from Queries (INSERT-SELECT, CTAS)]] → [[SQL Views]] → **[[SQL Self Join and Outer Join]]** → [[SQL Set Operators]] → [[Query Processing and the Optimiser]]
- **W11 — NoSQL:** [[Big Data and the Vs]] → [[NoSQL Databases]] → [[NoSQL Data Models]] → **[[MongoDB Document Model]]** → [[MongoDB CRUD Operations]]

## 🎯 Learning Outcomes (key skills per week)

- **W2** ➔ 
	- place conceptual modelling in the life cycle 
	- draw Crow's Foot ERDs (strong/weak, attribute types, verb labels) 
	- show min AND max cardinality 
	- solid vs dashed lines 
	- resolve M:N with an associative entity
- **W3** ➔ 
	- relation = set ≠ table (degree vs cardinality) 
	- derive super → candidate → primary keys 
	- enforce entity/referential/column integrity 
	- write $\sigma$, $\pi$, set ops, joins in relational algebra
- **W4** ➔ 
	- name the anomaly + its redundancy cause 
	- classify FDs full/partial/transitive 
	- run UNF → 1NF → 2NF → 3NF listing the right dependencies each step 
	- synthesise multi-form 3NF schemas
- **W5** ➔ 
	- map entity→relation, relationship→FK 
	- handle composite/multivalued/weak cases 
	- apply 1:M / M:N / 1:1 / unary / ternary rules 
	- spot impossible configurations 
	- add surrogates last + UNIQUE the natural key
- **W6** ➔ 
	- minimise personal data (client decides) 
	- DDL auto-commits vs transactional DML 
	- pick CHAR/VARCHAR2/NUMBER/DATE 
	- CREATE + named ALTER constraints in valid order (split-then-ALTER for cycles) 
	- CHECK vs lookup 
	- choose on-delete actions from participation
- **W7** ➔ 
	- INSERT with TO_DATE + sequences (NEXTVAL before CURRVAL) 
	- UPDATE/DELETE with subquery-driven WHERE (never hardcode, never omit WHERE) 
	- explain ACID via log + locks 
	- lost update, 2PL, deadlock handling 
	- REDO vs UNDO by write policy
- **W8** ➔ 
	- filter with full WHERE predicate set under three-valued logic 
	- alias/sort/DISTINCT (NULLs sort largest) 
	- NVL/TO_CHAR/TO_DATE type discipline 
	- ANSI joins only (natural-join Cartesian trap) 
	- subquery instead of hardcoded lookup
- **W9** ➔ 
	- COUNT(*) vs COUNT(col) 
	- every SELECT column grouped or aggregated 
	- WHERE (rows) vs HAVING (groups) + logical clause order 
	- pick subquery operator by output shape (scalar / IN / row-constructor)
- **W10** ➔ 
	- CASE (ranges) vs DECODE (equality) 
	- nested vs correlated vs inline vs scalar subqueries + cost reasoning 
	- INSERT-SELECT and CTAS (constraints lost) 
	- self joins on recursive FKs 
	- outer joins to keep unmatched rows 
	- UNION/INTERSECT/MINUS union-compatibility
- **W11** ➔ 
	- why the Vs overwhelm an RDBMS (scale up vs out) 
	- four NoSQL models by access pattern 
	- embed vs reference in MongoDB 
	- CRUD with `$set` (no ROLLBACK!) mapped to SQL equivalents
