---
unit: FIT3003
week: 8
source: [lecture, slides]
domain: C
parent: "[[Data Warehouse]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Vertical Stacking, Horizontal Stacking, Integrated Data Warehouse, Multi-Input]
---
# [[Multi-Input Operational Databases]]

**Context:** [[FIT3003_MOC]] · the transformation process when the input is **several** operational databases and the output is one integrated star schema ➔ [[Data Engineering]], [[Building Fact Tables]], [[Combining Star Schemas]]
**Parent Framework:** [[Data Warehouse]]

> [!abstract] Quick Revision
> - **🎯 Objective:** build **one star schema per source**, then stack them ➔ **Vertical Stacking** when the per-source facts are union-compatible (same dimensions, same measures) | **Horizontal Stacking** when each source owns **different** measures.
> - **📦 Core Components:** **vertical** ➔ `union` collapses rows downward | **horizontal** ➔ zero-padded TempFacts $+$ `union` $+$ outer `sum` push every source's measures into one wider row.
> - **⚡ Key Constraint:** union demands **union-compatible** column lists, so a horizontal stack must project **every** measure column in **every** TempFact, filling the ones that source does not own with `0`.

## 📝 How It Works
### 1. Why multi-input is possible at all
- **Same theme, different schemas** ➔ the three student clubs store members, activities and financial expenditure in entirely different E/R diagrams — one even lives in an **Excel workbook** — but all answer the same two questions.
- **Integration is a warehouse property** ➔ *Integrated* is the first of the four warehouse features, and it is what licenses one fact over heterogeneous sources ➔ [[Data Warehouse]].
- **Reconcile the measure definition first** ➔ each source computes `TotalIncome` differently, so agree the definition before any SQL: $\text{Orchestra} = \sum \text{TicketSales}$; $\text{Business} = \sum (\text{Price} \times \text{Tickets} + \text{Price} \times (1 - \text{Discount}) \times \text{MemberRegistrations})$; $\text{Japanese} = \sum(\text{MemberPrice} \times \text{MemberTickets} + \text{NonMemberPrice} \times \text{NonMemberTickets})$.
- **Qualify the source tables** ➔ tables are addressed as `"ClubName.Table"`, e.g. `"OrchestraClub.Concert"`, so the same table name in two sources never collides.

### 2. Vertical Stacking — University Student Clubs
- **Shape** ➔ every source yields the *same* star: $\text{UniversityClubFACT}(\underline{\text{ClubID}^{*}, \text{Year}^{*}}, \text{TotalExpenditure}, \text{TotalIncome})$, so the facts stack **vertically** — rows down.
- **Shared dimension, built by union** ➔ derive a per-source `YearDim` with `select distinct to_char(<date>, 'YYYY')`, then `union` the three and `select distinct` again; derived attributes (`UniversityStartDate`/`EndDate`) are added afterwards with `alter table` $+$ `update`.
- **Small dimension, hand-built** ➔ $\text{ClubDIM}$ has one row per club and is written with three `insert` statements, not derived ➔ [[Building Dimension Tables]].
- **Stamp the source identity** ➔ each per-club TempFact gets `alter table … add (ClubID integer)` then `update … set ClubID = n`; without it the union loses which club a row came from.
- **Mind the level of aggregation inside a source** ➔ `Concert` is coarser than `Ticket`, so `OrchestraTempFact1` is at *ticket* grain and needs a second `group by` before the final fact ➔ [[Levels of Aggregation]].

### 3. Horizontal Stacking — Real-Estate Property
- **Shape** ➔ $\text{PropertyFACT}(\underline{\text{Postcode}^{*}, \text{MonthID}^{*}}, \text{TotalPropertiesAuction}, \text{TotalSuccessfulAuction}, \text{NumNewListing}, \text{TotalPropertiesSold}, \text{TotalSoldPrice})$ — five measures, each owned by a **different** source, so the facts stack **horizontally** — columns across.
- **Independent sources** ➔ Inspection DB (listings and inspections) · Auction DB (auctions and results) · Sold Property DB (completed sales); the same `PROPERTY` table exists in all three with **different attributes**, and only the Inspection DB carries `ListedDate`.
- **Measure ownership** ➔ Auction DB ➔ `TotalPropertiesAuction` and `TotalSuccessfulAuction` (filter `AuctionResultCode = 'SA'`) · Inspection DB ➔ `NumNewListing` (`count` grouped on `ListedDate`) · Sold DB ➔ `TotalPropertiesSold` and `TotalSoldPrice`.
- **Derived indicators are not stored** ➔ Auction Clearance Rate $= \dfrac{\text{TotalSuccessfulAuction}}{\text{TotalPropertiesAuction}}$ and mean price $= \dfrac{\text{TotalSoldPrice}}{\text{TotalPropertiesSold}}$ are computed at query time ➔ [[Fact Measure Aggregation Rules]].
- **Shared dimensions come from all sources** ➔ $\text{MonthDIM}$ unions `ListedDate`, `AuctionDate` and `SoldDate`; $\text{SuburbDIM}$ unions `Postcode, Suburb, City, State` from all three `PROPERTY` tables, with `select distinct` wrapping the union to dedupe.

## ⚙️ Core Implementation
### 🔹 Vertical — one star per source, then one `union`
> [!code]- per-source fact ➔ stamp `ClubID` ➔ stack
> ```sql
> create table OrchestraTempFact1 as            -- ticket grain: one row per ticket sold
> select T.ConcertID, to_char(CT.ConcertDate, 'YYYY') as Year,
>        CT.HostingCost, CR.Honorarium, TT.Price
> from   "OrchestraClub.Ticket" T, "OrchestraClub.TicketType" TT,
>        "OrchestraClub.Concert" CT, "OrchestraClub.Conductor" CR
> where  T.TicketTypeID = TT.TicketTypeID
> and    CT.ConcertID = T.ConcertID
> and    CT.ConductorID = CR.ConductorID;
>
> create table OrchestraTempFact2 as            -- concert grain: collapse the tickets
> select ConcertID, Year, HostingCost, Honorarium, sum(Price) as Income
> from   OrchestraTempFact1
> group by ConcertID, Year, HostingCost, Honorarium;
>
> alter table OrchestraTempFact2 add (ClubID integer);
> update OrchestraTempFact2 set ClubID = 1;
>
> create table OrchestraFact as                 -- club-year grain: the star's fact
> select ClubID, Year,
>        sum(HostingCost + Honorarium) as TotalExpenditure,
>        sum(Income) as TotalIncome
> from   OrchestraTempFact2
> group by ClubID, Year;
>
> create table MonashClubFact as                -- VERTICAL STACK
> select * from OrchestraFact
> union
> select * from BusinessCommerceFact
> union
> select * from JapaneseFact;
> ```
> 💡 **Common Mistake:** **Skipping `OrchestraTempFact2`** ➔ `HostingCost` and `Honorarium` are recorded per *concert* but `TempFact1` is per *ticket*, so summing directly multiplies the expenditure by the number of tickets sold ➔ [[Data Exploration (Warehouse Validation)]].

### 🔹 Horizontal — zero-pad every measure, union, then `sum`
> [!code]- one TempFact per measure-owning source, all with identical column lists
> ```sql
> create table PropertyTempFact1 as             -- Auction DB owns TotalPropertiesAuction
> select P.Postcode, to_char(A.AuctionDate, 'YYYYMM') as MonthID,
>        count(*) as TotalPropertiesAuction,
>        0 as TotalSuccessfulAuction, 0 as NumNewListing,
>        0 as TotalPropertiesSold,    0 as TotalSoldPrice
> from   "Auction.Auction" A, "Auction.Property" P
> where  A.AuctionNo = P.AuctionNo
> group by P.Postcode, to_char(A.AuctionDate, 'YYYYMM');
>
> create table PropertyTempFact3 as             -- Inspection DB owns NumNewListing
> select P.Postcode, to_char(P.ListedDate, 'YYYYMM') as MonthID,
>        0 as TotalPropertiesAuction, 0 as TotalSuccessfulAuction,
>        count(*) as NumNewListing,
>        0 as TotalPropertiesSold, 0 as TotalSoldPrice
> from   "Inspection.Property" P
> group by P.Postcode, to_char(P.ListedDate, 'YYYYMM');
>
> create table PropertyFact as                  -- HORIZONTAL STACK
> select Postcode, MonthID,
>        sum(TotalPropertiesAuction), sum(TotalSuccessfulAuction),
>        sum(NumNewListing), sum(TotalPropertiesSold), sum(TotalSoldPrice)
> from ( select * from PropertyTempFact1
>        union select * from PropertyTempFact2
>        union select * from PropertyTempFact3
>        union select * from PropertyTempFact4 )
> group by Postcode, MonthID;
> ```
> 💡 **Common Mistake:** **`union` without the outer `group by … sum(…)`** ➔ the union alone leaves up to four rows per $(\text{Postcode}, \text{MonthID})$, each carrying one real measure and four zeroes; the outer aggregation is what collapses them into one complete row.

### 🔹 Dimensions spanning all sources
> [!code]- `select distinct` **around** the union, not just inside it
> ```sql
> create table SuburbDim as
> select distinct * from (
>   select distinct Postcode, Suburb, City, State from "Inspection.Property"
>   union
>   select distinct Postcode, Suburb, City, State from "Auction.Property"
>   union
>   select distinct Postcode, Suburb, City, State from "SoldProperty.Property"
> );
> ```

## ⚖️ Core Decision Matrix
| Method | Trigger condition | SQL shape | Failure mode if misapplied |
| :--- | :--- | :--- | :--- |
| **Vertical Stacking** | every source produces the **same** dimensions and the **same** measures | `union` of the per-source facts; a source-identifying dimension (`ClubID`) distinguishes the rows | none needed — but omitting the source key makes the stacked rows indistinguishable |
| **Horizontal Stacking** | each source owns **different** measures over shared dimensions | every TempFact projects **all** measures, padding non-owned ones with `0`; `union` then outer `group by` $+$ `sum` | dropping the padding breaks union compatibility; dropping the outer `sum` leaves fragmented rows |

> [!NOTE] **When It Flips:** the test is whether a source contributes **new rows** or **new columns** to the integrated fact — rows ➔ vertical, columns ➔ horizontal.

## ⚠️ Common Mistakes
- 💡 **Unioning raw source tables instead of per-source facts** ➔ the sources are structurally different; integration happens **after** each has been reduced to the agreed dimensions and measures.
- 💡 **Letting each club keep its own income formula into the fact** ➔ the measures must be reconciled to one definition first, or the stacked fact adds incomparable numbers.
- 💡 **Padding with `null` instead of `0`** ➔ `sum` ignores nulls in Oracle but the union's type inference and any later arithmetic will not; the chapter pads with `0` throughout.
- 💡 **Forgetting that a source may hold an attribute the others lack** ➔ only the Inspection DB stores `ListedDate`, so `NumNewListing` can be sourced from nowhere else.

## 🧠 Active Recall
> [!FAQ]- Three source databases feed one fact. When do you `union` the facts, and when is `union` alone not enough?
> > [!SUCCESS]- Answer
> > - **Short answer:** `union` alone works for **vertical** stacking; **horizontal** stacking needs zero-padded columns plus an outer `group by … sum(…)`.
> > - **Why:** **Vertical means same columns, new rows** ➔ each club's fact already has $(\text{ClubID}, \text{Year}, \text{TotalExpenditure}, \text{TotalIncome})$, so stacking is literally row concatenation. **Horizontal means same rows, new columns** ➔ each real-estate source owns a different measure, and `union` demands union-compatible column lists, so every TempFact must project all five measures with `0` in the slots it does not own. **The zeroes then have to be merged** ➔ four partial rows for one $(\text{Postcode}, \text{MonthID})$ collapse into one complete row only under `sum`, which is why the outer aggregation is not optional.

> [!FAQ]- Why does the Orchestra club need two TempFacts when the other two clubs' processing looks flatter?
> > [!SUCCESS]- Answer
> > - **Short answer:** because `Concert` sits at a **higher level of aggregation** than `Ticket`, so the first TempFact is at ticket grain.
> > - **Why:** **Income is per ticket, cost is per concert** ➔ joining `Ticket` to `Concert` repeats `HostingCost` and `Honorarium` once per ticket sold. **The second TempFact re-grains** ➔ `group by ConcertID, Year, HostingCost, Honorarium` with `sum(Price)` collapses tickets to one row per concert, leaving each cost counted once. **Only then may the club-year fact sum** ➔ the final `group by ClubID, Year` is safe because every input row is now a distinct concert ➔ [[Levels of Aggregation]].
