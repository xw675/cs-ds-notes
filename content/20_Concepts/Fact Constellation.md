---
unit: FIT3003
week: 8
source: [lecture, slides]
domain: C
parent: "[[Levels of Aggregation]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Galaxy Schema, Multi-Hierarchy Multi-Fact, Aggregation Paths]
---
# [[Fact Constellation]]

**Context:** [[FIT3003_MOC]] · what a warehouse becomes when dimension hierarchies are materialised as one fact per level ➔ [[Levels of Aggregation]], [[Multi-Fact Star Schemas]], [[Dimension Hierarchies]]
**Parent Framework:** [[Levels of Aggregation]]

> [!abstract] Quick Revision
> - **🎯 Objective:** granularity, **hierarchy** and **multi-fact** are the same phenomenon ➔ splitting a hierarchy into one fact per level produces a multi-fact schema whose facts differ only in level of aggregation; a **multi-fact, multi-hierarchy** schema is a **Fact Constellation**.
> - **📦 Core Components:** $h$ hierarchies of lengths $\ell_1 \dots \ell_h$ ➔ $\prod_i \ell_i$ fact tables, all sharing the non-hierarchy dimensions.
> - **⚡ Key Constraint:** the levels form a **lattice with several paths**, not a chain — numbering the facts $\text{Level-}1 \dots \text{Level-}6$ in a line is **wrong**, because facts from different hierarchies are incomparable.

## 📝 How It Works
### 1. Hierarchy ➔ multi-fact
- **Start point** ➔ $\text{SalesFACT}(\underline{\text{BranchName}^{*}, \text{ProductID}^{*}, \text{Year}^{*}}, \text{Total\_Sales})$ with a Branch ➔ City ➔ Country hierarchy hanging off $\text{BranchDIM}$ ➔ [[Snowflake Schema]].
- **Split the hierarchy** ➔ one fact per level: $\text{BranchSalesFACT}$, $\text{CitySalesFACT}$, $\text{CountrySalesFACT}$ — same measure `Total_Sales`, different granularity, all sharing $\text{ProductDIM}$ and $\text{TimeDIM}$.
- **Hierarchy direction** ➔ read it from the **most detailed** (Branch) down to the **most general** (Country); that direction *is* the level ordering — Branch $=$ Level-1, City $=$ Level-2, Country $=$ Level-3.
- **Rejoining them** ➔ keep the many-1 links between $\text{BranchDIM}, \text{CityDIM}, \text{CountryDIM}$ and let the three facts share the remaining dimensions; that single diagram is the multi-fact star.

### 2. A second hierarchy multiplies the facts
- **Time hierarchy** ➔ $\text{QuarterDIM} \to \text{YearDIM}$ gives $\text{QuarterlySalesFACT}$ and $\text{YearlySalesFACT}$ over the same $\text{BranchDIM}$ and $\text{ProductDIM}$.
- **Cross product** ➔ combining the location hierarchy $(3)$ with the time hierarchy $(2)$ yields $3 \times 2 = 6$ fact tables — Quarterly/Yearly $\times$ Branch/City/Country.
- **Name** ➔ this multi-fact, multi-hierarchy schema is a **Fact Constellation**.

### 3. Level numbering follows paths, not a list
- **Two partitions** ➔ one group of levels based on **time**, one based on **location**; a comparison is only valid *within* a partition or when **both** coordinates move the same way.
- **Incomparable pair** ➔ Quarterly Country Sales vs Yearly City Sales — coarser in location, finer in time, **not formed by one hierarchy**, so neither is more general.
- **Comparable pair** ➔ Yearly Country Sales is unambiguously more general than Quarterly Country Sales (location fixed, time coarsened).
- **Four paths, four levels** ➔ every path runs from the single most detailed schema (Branch Quarterly) to the single most general (Country Yearly), and within a path the ordering is exact.

## 🗂️ Schema
$$\text{BranchSalesFACT}(\underline{\text{BranchName}^{*}, \text{ProductID}^{*}, \text{Year}^{*}}, \text{Branch\_Total\_Sales})$$
$$\text{CitySalesFACT}(\underline{\text{CityID}^{*}, \text{ProductID}^{*}, \text{Year}^{*}}, \text{City\_Total\_Sales})$$
$$\text{CountrySalesFACT}(\underline{\text{CountryID}^{*}, \text{ProductID}^{*}, \text{Year}^{*}}, \text{Country\_Total\_Sales})$$
> [!code]- Mermaid — the $6$-fact lattice, arrows pointing at the more aggregated schema
> ```mermaid
> flowchart BT
>   BQ["Branch Quarterly — Level-1"]
>   BY["Branch Yearly — Level-2"]
>   CQ["City Quarterly — Level-2"]
>   CY["City Yearly — Level-3"]
>   NQ["Country Quarterly — Level-3"]
>   NY["Country Yearly — Level-4"]
>   BQ --> BY
>   BQ --> CQ
>   BY --> CY
>   CQ --> CY
>   CQ --> NQ
>   BY --> NQ
>   CY --> NY
>   NQ --> NY
> ```
> 💡 **Common Mistake:** **Flattening the lattice into $\text{Level-}1 \dots \text{Level-}6$** ➔ that numbering claims Quarterly Country Sales is more general than Yearly City Sales, which is false; the lattice has only **four** levels, two of them holding two schemas each.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — comparing two schemas in the constellation
| Pair | Location axis | Time axis | Verdict |
| :--- | :--- | :--- | :--- |
| Country Yearly vs Country Quarterly | equal | coarser | Country Yearly is **more general** |
| Country Yearly vs Branch Yearly | coarser | equal | Country Yearly is **more general** |
| Country Quarterly vs City Yearly | coarser | finer | **not comparable** |
| Branch Yearly vs City Quarterly | finer | coarser | **not comparable** |
| Branch Quarterly vs anything | finest | finest | strictly below everything ➔ the bottom of the lattice |

- **The rule the table encodes** ➔ $A$ is more general than $B$ iff $A$ is coarser-or-equal on **every** axis and strictly coarser on at least one.

## ⚠️ Common Mistakes
- 💡 **Treating levels as a total order** ➔ with two hierarchies the level number is a *rank in the lattice*, and two schemas can share a rank while being incomparable ➔ [[Levels of Aggregation]].
- 💡 **Duplicating the shared dimensions** ➔ $\text{ProductDIM}$ and $\text{TimeDIM}$ are created **once** and pointed at by all facts; only the hierarchy dimensions differ ➔ [[Multi-Fact Star Schemas]].
- 💡 **Building the constellation from the top** ➔ each level must be derivable by aggregating the level below, so the most detailed fact is the one that is physically loaded.

## 🧠 Active Recall
> [!FAQ]- A warehouse has a Branch ➔ City ➔ Country hierarchy and a Quarter ➔ Year hierarchy. How many fact tables, how many levels, and why are those numbers different?
> > [!SUCCESS]- Answer
> > - **Short answer:** $3 \times 2 = 6$ fact tables but only **four** levels of aggregation.
> > - **Why:** **Facts are the cross product** ➔ each combination of one location grain and one time grain is a separate materialised aggregate. **Levels are lattice ranks** ➔ a schema's rank is how many coarsening steps separate it from Branch Quarterly, so Branch Yearly and City Quarterly both sit at rank $2$. **Ranks collide because axes are independent** ➔ those two schemas coarsen *different* hierarchies, which is exactly why they cannot be ordered against each other ➔ [[Fact Constellation]].
