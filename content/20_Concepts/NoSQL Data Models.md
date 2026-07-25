---
unit: FIT2094
domain: [C, F]
week: 11
parent: "[[NoSQL Databases]]"
tags: [CS/Databases, DataScience/BigData]
aliases: [Key-Value Store, Document Store, Column Family, Graph Database]
---
# [[NoSQL Data Models]]

**Context:** [[FIT2094_MOC]] · the four ways [[NoSQL Databases|NoSQL]] structures data · choice driven by data shape + access pattern · [[MongoDB Document Model|MongoDB]] is a document store
**Parent Framework:** [[NoSQL Databases]]

> [!abstract] Quick Revision
> - **🎯 Objective:** pick a model by access pattern ➔ key-value, document, column-family (aggregation-oriented) or graph (traversal-oriented).
> - **📦 Core Components:** key-value ➔ opaque blob by key | document ➔ queryable JSON | column-family ➔ wide/time-series | graph ➔ nodes+edges.
> - **⚡ Key Constraint:** aggregation models fetch a whole record fast but can't cheaply follow relationships — that's the graph model's job.

## 📝 Core
### 1. Key-value store
- **Structure** ➔ unique key → opaque value (string/number/blob/JSON); direct key→location lookup, extremely fast.
- **Limit** ➔ value is **opaque**: can't query "balance = 0" without reading/parsing every value. *Redis, DynamoDB, Oracle NoSQL.*

### 2. Document store
- **Structure** ➔ semi-structured JSON/BSON per record; DB **understands** fields ➔ can query inside a document; documents in a collection may differ. *MongoDB.*

### 3. Column-family (wide-column)
- **Structure** ➔ row key → column families (a map of maps); variable columns per row; families stored together on disk.
- **Strength** ➔ query many rows but few columns; time-series. *Cassandra (eBay, Netflix).*

### 4. Graph database
- **Structure** ➔ [[Graph|nodes + edges]] with properties/labels/direction; built on graph theory.
- **Strength** ➔ **traversal** ("friends-of-friends who like jazz") — cheap where relational needs many JOINs. *Neo4j, HyperGraphDB.*

## ⚖️ Core Decision Matrix
| Model | Data shape | Best access | Query inside value? |
| :--- | :--- | :--- | :--- |
| **Key-value** | opaque blob by key | point lookup by key | ❌ opaque |
| **Document** | varying JSON docs | whole-record + field queries | ✅ |
| **Column-family** | wide rows, families | many rows × few columns; time-series | ✅ by column |
| **Graph** | nodes + edges | relationship traversal | ✅ via edges |

> [!NOTE] **When It Flips:** the first three are **aggregation-oriented** (group one entity's data together, retrieve as a unit); the graph model is **traversal-oriented** (follow relationships across entities) — the opposite optimisation.

## 🧠 Active Recall
> [!FAQ]- Why can't a key-value store answer "find all customers with balance 0", but a document store can?
> - **Hint:** Opaque value vs understood structure.
> > [!SUCCESS]- Answer
> > - **Short answer:** A key-value store treats the value as an opaque blob keyed by id, so filtering on a field means reading/parsing every value; a document store understands the document's fields and can query them directly.
> > - **Why:** **Structure awareness** ➔ documents expose queryable fields; key-value exposes only the key.

> [!FAQ]- When is a graph database the right model over a relational design?
> - **Hint:** Traversal vs JOIN cost.
> > [!SUCCESS]- Answer
> > - **Short answer:** When queries follow chains of relationships (social networks, recommendations, fraud) — traversal is native and fast, whereas relational needs many expensive JOINs.
> > - **Why:** **Edges as first-class** ➔ navigation is following stored edges, not recomputing joins.
