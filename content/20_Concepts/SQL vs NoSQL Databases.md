---
unit: FIT1043
week: 10
parent: "[[Big Data and the Vs]]"
tags: [DataScience/BigData, CS/Databases]
aliases: [SQL vs NoSQL, Database Types, Polyglot Persistence]
---
# [[SQL vs NoSQL Databases]]

**Context:** [[FIT1043_MOC]] · choosing a store for a data project · the [[Relational Model|relational]] world vs the [[NoSQL Databases|NoSQL]] world · driven by the [[Big Data and the Vs|V's]]

> [!abstract] Quick Revision
> - **🎯 Objective:** pick SQL vs NoSQL by the data's shape and change rate ➔ structured+stable → SQL; large/unstructured/fast-changing → NoSQL.
> - **📦 Core Components:** SQL = relational + schema + ACID | NoSQL = non-relational + dynamic schema + horizontal scale.
> - **⚡ Key Constraint:** the deciding factors are **schema rigidity** and **scaling direction** — vertical (SQL) vs horizontal (NoSQL).

## 📝 How It Works
### 1. The Landscape
- **RDBMS** ➔ SQL-based; stores/manages/queries a [[Relational Model|relational]] database; **ACID**, transaction-oriented (like indexed spreadsheets).
- **NoSQL** ➔ typically JSON storage; [[NoSQL Data Models|document / key-value / column-family / graph]] models.
- **Graph DB** ➔ stores triples (subject–verb–object); RDF/SPARQL; common for [[Data Sources and Open Data|Linked Open Data]].

### 2. The Five Differences
- **Relational vs not** ➔ SQL relational; NoSQL non-relational.
- **Schema** ➔ SQL **predefined/fixed**; NoSQL **dynamic** (for unstructured data).
- **Scaling** ➔ SQL **vertical** (scale up); NoSQL **horizontal** (scale out).
- **Model** ➔ SQL **table-based**; NoSQL document / key-value / graph / wide-column.
- **Best for** ➔ SQL **multi-row transactions**; NoSQL **unstructured data** (documents/JSON).

### 3. Suitability & Shared Traits
- **Use SQL** ➔ data is **structured and unchanging**.
- **Use NoSQL** ➔ **large volume**, little/no structure, or **rapidly changing** data (the V's).
- **Both offer** ➔ large-scale distributed processing, robustness, general query languages, and some consistency (often **"eventual"** as nodes propagate updates).
- **Polyglot persistence** ➔ "NoSQL" = *Not only SQL*; systems may sit alongside SQL and support SQL-like queries.

## ⚖️ Core Decision Matrix
| Aspect | SQL (RDBMS) | NoSQL |
| :--- | :--- | :--- |
| **Relational?** | yes | no |
| **Schema** | predefined/fixed | dynamic |
| **Scaling** | vertical (up) | horizontal (out) |
| **Model** | tables | document / key-value / graph / wide-column |
| **Best for** | multi-row transactions | unstructured / JSON, fast change |

> [!NOTE] **When It Flips:** the split traces back to the [[Big Data and the Vs|V's]] — a fixed schema serves structured, stable data (SQL); dynamic schemas + horizontal scaling serve high-Volume/Velocity/Variety data (NoSQL).

## 🧠 Active Recall
> [!FAQ]- State the five SQL-vs-NoSQL differences and when to choose each.
> > [!SUCCESS]- Answer
> > - **Short answer:** relational vs non-relational; fixed vs dynamic schema; vertical vs horizontal scaling; table vs document/key-value/graph/wide-column; multi-row transactions vs unstructured data. Choose SQL for structured, unchanging data; NoSQL for large, unstructured, or rapidly changing data.
> > - **Why:** **Schema + scale** ➔ NoSQL trades the relational schema/ACID for schema flexibility and scale-out to handle the V's.
