---
unit: FIT3003
week: 7
source: [slides]
domain: C
parent: "[[Multi-Fact Star Schemas]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [Vertical Slice, Horizontal Slice, Fact Partitioning, Slicing a Fact Table]
---
# [[Slicing a Fact]]

**Context:** [[FIT3003_MOC]] · Chapter 12 — the **opposite** move to [[Multi-Fact Star Schemas]]: one fact is split, and a multi-fact schema is the by-product
**Parent Framework:** [[Multi-Fact Star Schemas]]

> [!abstract] Quick Revision
> - **🎯 Objective:** partition one fact table into two or more ➔ **vertical** slices the *measure columns*, **horizontal** slices the *fact records*.
> - **📦 Core Components:** **vertical** $\equiv$ vertical partitioning in **distributed** databases | **horizontal** $\equiv$ horizontal partitioning in **parallel** databases.
> - **⚡ Key Constraint:** the slicing attribute must already be visible somewhere in the schema — **a [[Pivoted Fact Tables|pivoted fact]] forces a vertical slice, a Type Dimension forces a horizontal one**; with neither, the fact cannot be sliced at all.

## 📝 How It Works
### 1. Vertical slice — split the measures
- **Definition** ➔ divide the fact's **attributes** across multiple fact tables; each new fact keeps the **full dimension key** and takes a subset of the measures.
- **Dimensions untouched** ➔ neither the dimension tables nor their records change; only the fact is partitioned.
- **Private Taxi** ➔ $\text{PrivateTaxiFACT}(\underline{\text{CarNo}^{*}, \text{DriverNo}^{*}, \text{WeekNo}^{*}}, \text{Total\_Kilometers}, \text{Total\_Fuel\_Used}, \text{Total\_Income})$ becomes three one-measure stars, each still hanging off $\text{CarDIM}$, $\text{DriverDIM}$, $\text{WeekDIM}$.

### 2. Horizontal slice — split the records
- **Definition** ➔ allocate **rows** to different fact tables by a range or value of an attribute; every new fact keeps the **full column list**.
- **Dimensions may shrink too** ➔ a slice on `TimeID` means each star's $\text{TimeDIM}$ need only hold that star's months; a slice on a dimension member means the dimension itself can be split.
- **Bookshop by year** ➔ pre-$2010$ facts to one star, $2010$-onward to another.
- **Bookshop by shop type** ➔ religious vs general; since $\text{BookshopDIM}$ holds **no type attribute**, the membership test must run against the **operational** database, and the key is renamed per star (`BookshopID` ➔ `ReligiousBookshopID`).

### 3. Which slice — read it off the existing schema
- **Pivoted fact $\Rightarrow$ vertical** ➔ the breakdown already lives in the *column names* (`Num_of_Bachelor_Projects`, `Num_of_Master_Projects`), so the split is by column.
- **Type dimension $\Rightarrow$ horizontal** ➔ the breakdown lives in a *key attribute value* (`LevelNo`, `PilotType`), so the split is by row.
- **Neither $\Rightarrow$ cannot slice** ➔ with only $\text{Num\_of\_Projects}$ and no level information anywhere, no partition can be derived.
- **The type dimension disappears after the slice** ➔ `LevelNo` is already implied by *which* star you are querying, so $\text{LevelTypeDIM}$ is dropped.
- **A [[Determinant Dimensions|determinant dimension]] stops being determinant** ➔ after slicing Flight Charter, each fact holds one personnel type only, so no double count is possible and $\text{PilotDIM}$ / $\text{CoPilotDIM}$ return to solid boxes.

## ⚙️ Core Implementation
### 🔹 Vertical slice — project the measures
> [!code]- three CTAS, full key repeated in each
> ```sql
> create table PrivateTaxiFact1 as
> select CarNo, DriverNo, WeekNo, Total_Kilometers from PrivateTaxiFact;
>
> create table PrivateTaxiFact2 as
> select CarNo, DriverNo, WeekNo, Total_Fuel_Used  from PrivateTaxiFact;
>
> create table PrivateTaxiFact3 as
> select CarNo, DriverNo, WeekNo, Total_Income     from PrivateTaxiFact;
> ```
> 💡 **Common Mistake:** **Dropping a key column from one slice** ➔ each slice must carry the **whole** composite key or it can never be joined back ➔ [[Multi-Fact Star Schemas]].

### 🔹 Horizontal slice — filter the records
> [!code]- by range, then by a value that lives only in the operational DB
> ```sql
> create table BookshopFact2a as
> select * from BookshopFact1 where TimeID <  201001;      -- old records
>
> create table BookshopFact2b as
> select * from BookshopFact1 where TimeID >= 201001;      -- recent records
>
> create table ReligiousBookshopFact as                     -- slice on a dimension member
> select BookshopID as ReligiousBookshopID, CategoryID, TimeID,
>        Num_of_Books, Total_Sales
> from   BookshopFact1
> where  BookshopID in ( select BookshopID
>                        from   ...                          -- operational source
>                        where  <the type is Religious Bookshop> );
>
> create table ReligiousBookshopDim as                       -- split the dimension to match
> select BookshopID as ReligiousBookshopID, Address, Suburb, Postcode, State, Country
> from   BookshopDim
> where  BookshopID in ( select BookshopID from ... where <the type is Religious Bookshop> );
> ```
> 💡 **Common Mistake:** **Looking for the slicing attribute inside the warehouse** ➔ $\text{BookshopDIM}$ has no type column, so the subquery must reach back to the operational database; that reach is exactly what a Type Dimension would have removed.

## ⚖️ Core Decision Matrix
| Aspect | Vertical slice | Horizontal slice |
| :--- | :--- | :--- |
| What is partitioned | measure **columns** | fact **records** |
| Analogy | vertical partitioning, **distributed** databases | horizontal partitioning, **parallel** databases |
| Key columns | repeated in full in every slice | unchanged |
| Column list | **narrower** in each slice | identical in every slice |
| Dimension tables | untouched | may be trimmed to the slice, or split with a renamed key |
| Triggered by | a **pivoted fact** (breakdown in the column names) | a **type dimension** (breakdown in a key value) |
| Slicing attribute afterwards | encoded in which measures a fact holds | encoded in which fact you query — the type dimension is dropped |

> [!NOTE] **When It Flips:** the same case study takes either slice depending on which combined shape was built first — Bachelor/Master pivots ➔ vertical, Bachelor/Master with $\text{LevelTypeDIM}$ ➔ horizontal ➔ [[Combining Star Schemas]].

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — Flight Charter, both routes
| Step | Starting schema | Slice applied | Resulting facts | $\text{PilotDIM}$ afterwards |
| :--- | :--- | :--- | :--- | :--- |
| 0 | $\text{FlightCharterFACT}$, dashed $\text{PilotDIM}$, $3$ measures | — | 1 | **determinant** (dashed) |
| 1 | pivoted: $6$ measures, `..._Pilot` / `..._CoPilot` | **vertical** — columns split by role | 2, each $3$ measures | normal (solid) |
| 2 | type dimension: $\text{PilotTypeDIM}$ in the key | **horizontal** — rows split on `PilotType` | 2, each $3$ measures | normal (solid), $\text{PilotTypeDIM}$ dropped |
| 3 | base schema only, no breakdown anywhere | none possible | 1 | unchanged |

- **Reading the trace** ➔ steps 1 and 2 reach the **same two star schemas** by opposite mechanics; step 3 is the precondition failure.

### Applied Exercise — pick the slice
**Problem:** $\text{ProjectFACT}(\underline{\text{AreaID}^{*}, \text{StaffNo}^{*}, \text{Year}^{*}}, \text{Num\_of\_Bachelor\_Projects}, \text{Num\_of\_Bachelor\_Students}, \text{Num\_of\_Master\_Projects}, \text{Num\_of\_Master\_Students})$. Split it into a Bachelor star and a Master star.
$$
\begin{aligned}
\text{breakdown lives in} &= \text{column names} \Rightarrow \text{vertical slice} \\
\text{Bachelor fact} &= \pi_{\text{AreaID},\ \text{StaffNo},\ \text{Year},\ \text{Num\_of\_Bachelor\_Projects},\ \text{Num\_of\_Bachelor\_Students}}(\text{ProjectFACT}) \\
\text{Master fact} &= \pi_{\text{AreaID},\ \text{StaffNo},\ \text{Year},\ \text{Num\_of\_Master\_Projects},\ \text{Num\_of\_Master\_Students}}(\text{ProjectFACT})
\end{aligned}
$$
**Final Extracted Output:** two stars, each with the same three dimensions and two measures; had the schema instead carried $\text{LevelTypeDIM}$, the identical outcome would be reached with `where LevelNo = 'B'` / `'M'` — a horizontal slice.

## ⚠️ Common Mistakes
- 💡 **Slicing when nothing records the slicing attribute** ➔ without a pivoted measure or a type dimension the information simply is not in the warehouse; the chapter's conclusion is that the slice is **not possible**.
- 💡 **Keeping the type dimension after a horizontal slice** ➔ every row in the new fact has the same type value, so the dimension is dead weight.
- 💡 **Assuming the determinant property survives** ➔ it exists to prevent a double count that the slice has already eliminated.

## 🧠 Active Recall
> [!FAQ]- You are told to slice a fact by student level. What do you inspect first, and what does each answer commit you to?
> > [!SUCCESS]- Answer
> > - **Short answer:** inspect **where the level information is recorded** — in the measure column names, or in a key attribute — because that alone decides vertical versus horizontal.
> > - **Why:** **Pivoted fact ➔ vertical** ➔ the level is already a column split, so the slice is a projection. **Type dimension ➔ horizontal** ➔ the level is a row value, so the slice is a filter and the dimension is then dropped. **Neither ➔ refuse** ➔ a fact holding only $\text{Num\_of\_Projects}$ cannot be decomposed after the fact; the breakdown had to be modelled earlier ➔ [[Combining Star Schemas]].
