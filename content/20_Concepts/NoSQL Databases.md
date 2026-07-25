---
unit: FIT2094
domain: [C, F]
week: 11
parent: "[[Big Data and the Vs]]"
tags: [CS/Databases, DataScience/BigData]
aliases: [NoSQL, Sharding, Replication]
---
# [[NoSQL Databases]]

**Context:** [[FIT2094_MOC]] · the answer to [[Big Data and the Vs|Big Data]] scale · "not only SQL", not "no SQL" · organised into [[NoSQL Data Models|four data models]]

> [!abstract] Quick Revision
> - **🎯 Objective:** non-relational, distributed, schema-less stores that scale **out** across commodity servers ➔ handle Big Data volume/velocity/variety.
> - **⚡ Key Constraint:** they drop the rigid schema, enforced FKs, JOINs and full ACID that bottleneck an RDBMS at internet scale.

## 📝 Core
- **Name** ➔ coined 2009 (Johan Oskarsson, `#NoSQL`); means **not only SQL** / not relational — many have their own or SQL-like query languages.
- **Origins** ➔ engineering need at Google (**Bigtable**, wide-column, 2006) and Amazon (**Dynamo**, key-value, 2007 ➔ DynamoDB).
- **Characteristics** ➔ non-relational (related data stored together, no engine-enforced FKs); mostly open source; distributed/cluster-friendly; schema-less (documents in one collection may differ; add fields with no migration).
- **Distribution** ➔ **sharding** (partition data across nodes) and/or **replication** (copy data to many nodes); production mixes both.

## ⚖️ Core Decision Matrix
| Approach | What | Gains | Risk |
| :--- | :--- | :--- | :--- |
| **Sharding (partition)** | split one dataset across nodes (A–M \| N–Z) | storage capacity + write throughput | a node failure loses **that** partition |
| **Replication** | copy same data to many nodes | read throughput + fault tolerance | consistency management overhead |

## ⚠️ Common Mistakes
- 💡 **"NoSQL" ≠ "no SQL"** ➔ it means *not only SQL*; several NoSQL systems expose SQL-like querying.
- 💡 **Schema-less ≠ structure-less** ➔ documents still have fields; the point is fields can vary and evolve without a migration.

## 🧠 Active Recall
> [!FAQ]- Contrast sharding and replication — which solves capacity, which solves availability?
> > [!SUCCESS]- Answer
> > - **Short answer:** Sharding partitions data across nodes (more capacity/write throughput but a lost shard is unavailable); replication copies data to many nodes (more read throughput + fault tolerance, at a consistency cost).
> > - **Why:** **Split vs copy** ➔ most systems shard for scale and replicate each shard for availability.
