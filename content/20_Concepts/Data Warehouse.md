---
unit: FIT3003
week: 1
source: [lecture, slides]
domain: C
parent: "[[Data Engineering]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [DWH, DW, Data Warehousing]
---
# [[Data Warehouse]]

**Context:** [[FIT3003_MOC]] · the storage facility [[Data Engineering]] delivers · read multidimensionally by OLAP, physically stored as a [[Star Schema]]

> [!abstract] Quick Revision
> - **🎯 Objective:** the need for an effective **decision support system** motivated a new storage facility ➔ subject-oriented, pre-designed, precomputed, queried as a *cube* rather than as normalised transactions.
> - **⚡ Critical Bottleneck:** stating *why* [[Normalisation|ER + normalisation]] is the wrong tool — normalised operational design does not serve advanced analysis, so a new modelling technique was required.

## 📝 Core
- **Operational database** ➔ runs the business transaction-by-transaction: current, detailed, normalised, optimised for many small reads/writes ➔ [[Relational Model]].
- **Data warehouse** ➔ supports decisions: historical, integrated across sources, **pre-designed**, holding **precomputed values** at a chosen **granularity**, optimised for retrieving and summarising very large record sets.
- **Multidimensional view** ➔ the analyst sees a **cube** with multiple dimensions; the cube is *logical* — the underlying physical storage is still relational, laid out as a [[Star Schema]].
- **ETL** ➔ the whole process of extracting data from the operational databases and transforming it into the data warehouse = **E**xtraction, **T**ransformation, **L**oad.
- **OLAP** ➔ On-Line Analytical Processing; the tool that retrieves large numbers of records from very large data sets and summarises them **"on the fly"** — the cube's query interface.
- **Business Intelligence** ➔ the insight layer *on top of* OLAP: reports, charts, dashboards, interactive data navigation, and downstream data analytics.

## ⚖️ Operational Database vs Data Warehouse
| Aspect        | Operational database            | Data warehouse                             |
| :------------ | :------------------------------ | :----------------------------------------- |
| Purpose       | run the business (transactions) | decision support / analysis                |
| Data scope    | current, detailed               | historical, integrated from many sources   |
| Modelling     | ER + [[Normalisation]]          | dimensional ➔ [[Star Schema]]              |
| Values stored | raw, computed on demand         | **precomputed** at a fixed **granularity** |
| Design timing | evolves with the application    | **must be pre-designed**                   |
| Query shape   | many small reads/writes         | few queries scanning/summarising huge sets |
| Access tool   | SQL application code            | OLAP ➔ BI reports & dashboards             |


> [!NOTE] **Shared substrate:** both are relational technology — the warehouse is not a different DBMS, it is a different *schema discipline* plus precomputation.

## 🔄 The Delivery Chain
$$\text{Operational DBs} \xrightarrow{\ \text{ETL}\ } \text{Data Warehouse (cube)} \xrightarrow{\ \text{OLAP query}\ } \text{BI reports} \rightarrow \text{Data analytics}$$

- **Granularity is the irreversible choice** ➔ it fixes the finest level a fact can be reported at; anything finer than the stored grain is unrecoverable without reloading.
- **Precomputation is the payoff** ➔ summarisation done at load time is what makes "on the fly" OLAP response possible over very large data sets.

## ⚠️ Common Mistakes
- 💡 **Calling the warehouse "a big database"** ➔ the distinguishing claims are *pre-designed*, *precomputed*, *granularity-fixed*, *multidimensional* — a bigger normalised schema is still operational.
- 💡 **Treating the cube as the storage format** ➔ the cube is the analyst's view; the physical schema is relational tables in a star layout.

## 🧠 Active Recall
> [!FAQ]- ER modelling and normalisation are the standard database design tools. Why did data warehousing need a new modelling technique at all?
> > [!SUCCESS]- Answer
> > - **Direct Criterion:** existing relational techniques **did not yield a structure that served advanced data analysis requirements**.
> > - **Technical Justification:** **Purpose mismatch** ➔ [[Normalisation|normalisation]] removes redundancy to protect transactional updates ([[Database Anomalies|anomaly]] avoidance), scattering one business event across many relations; analysis instead wants a *multidimensional* view of one measured event, so a query must re-join those relations every time. **Dimensional answer** ➔ the [[Star Schema]] deliberately denormalises into one fact + qualifying dimensions so the summarisation is cheap and the cube's axes are explicit.

> [!FAQ]- Where do ETL, OLAP and BI sit relative to each other?
> > [!SUCCESS]- Answer
> > - **Direct Criterion:** ETL **fills** the warehouse, OLAP **queries** it, BI **presents** the result.
> > - **Technical Justification:** **Sequential layering** ➔ ETL is the write path from operational sources; OLAP is the read path that summarises large record sets on the fly; BI consumes OLAP output as reports, charts, dashboards and interactive navigation, feeding data analytics.
