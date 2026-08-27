---
unit: FIT3003
week: 4
source: [lecture, slides, lab]
domain: C
parent: "[[Bridge Tables]]"
tags: [CS/Databases, Tool/SQL, DataScience/DataWarehousing]
type: pattern
aliases: [LISTAGG, ListAgg, Weight Factor SQL, TripDim2, TripDim3]
---
# [[Building Bridge Table Schemas]]

**Context:** [[FIT3003_MOC]] · the SQL half of [[Bridge Tables]] · same build order as [[Building Dimension Tables]] ➔ [[Building Fact Tables]], with the bridge inserted between two dimensions
**Problem it solves:** turning an operational associative table into a bridge, and computing the two optional columns ($\text{WeightFactor}$, $\text{StoreGroupList}$) that live in the parent dimension.

> [!abstract] Quick Revision
> - **🎯 Trigger:** the source has an associative table with **exactly two FKs** and the far entity cannot key the fact ➔ `create table XxxBridge as select * from <associative table>;`
> - **⚡ Key Constraint:** $\text{WeightFactor}$ and $\text{StoreGroupList}$ are computed by **grouping the parent against the associative table** — never against the bridge you just built, and never against the fact.

## 🔧 Minimal Working Example
*(Product Sales, Chapter 5 — the whole snowflake in one script; the bridge is a straight copy of $\text{StockSupplier}$)*
```sql
-- Time Dimension
create table TimeDim as
select
   distinct to_char(SalesDate, 'YYYYMM') as TimeID,
   to_char(SalesDate, 'YYYY') as Year,
   to_char(SalesDate, 'MM') as Month
from Sales;

-- Customer Location Dimension
create table CustLocDim as
select distinct Suburb, Postcode
from Customer;

-- Product Dimension
create table ProductDim as
select distinct ProductNo, ProductName
from Product;

-- Bridge Table
create table ProductSupplierBridge as
select *
from StockSupplier;

-- Supplier Dimension
create table SupplierDim as
Select SupplierID, Name as SupplierName
from Supplier;

-- Fact Table
create table ProductSalesFact as
Select
   to_char(S.SalesDate, 'YYYYMM') as TimeID,
   P.ProductNo,
   C.Suburb,
   sum(SI.QtySold*P.Price) as TotalSales
from Sales S, Product P, Customer C, SalesItem SI
where S.SalesNo = SI.SalesNo
and SI.ProductNo= P.ProductNo
and C.CustomerID = S.CustomerID
group by
   to_char(S.SalesDate, 'YYYYMM'),
   P.ProductNo,
   C.Suburb;
```
**Expected output:** $\text{ProductSalesFACT}(\underline{\text{TimeID}^{*}, \text{ProductNo}^{*}, \text{Suburb}^{*}}, \text{TotalSales})$ with **no** $\text{SupplierID}$ — supplier is reachable only via $\text{ProductDIM} \rightarrow \text{ProductSupplierBRIDGE} \rightarrow \text{SupplierDIM}$. Four tables in the fact's `from` ⟹ three join conditions.

## 🔀 Variations

### Model 1 — bridge only (Lab 4, Truck Delivery)
Build order: $\text{TruckDim1}$ (copy of $\text{Truck}$) · $\text{TripSeason1}$ (by hand, four rows: Summer, Autumn, Winter, Spring) · $\text{TripDim1}$ (projection of $\text{Trip}$) · $\text{BridgeTableDim1}$ (copy of $\text{Destination}$) · $\text{StoreDim1}$ (copy of $\text{Store}$) · a **TempFact** with the season `alter`/`update`, then $\text{TruckFact1}$ ➔ [[Building Fact Tables]] Route B.
- **The bridge is the cheapest table in the script** ➔ $\text{Destination}(\underline{\text{TripID}^{*}, \text{StoreID}^{*}})$ already *is* the bridge; copy it, drop nothing.

### Model 2 — add the weight factor to $\text{TripDim}$
```sql
Create Table TripDim2 As
select t.tripid, t.tripdate, t.totalkm, 1.0/count(*) as weightfactor
from trip t, destination d
where t.tripid = d.tripid
group by t.tripid, t.tripdate, t.totalkm;
```
**Expected output:**

| TRIPID | TRIPDATE | TOTALKM | WEIGHTFACTOR |
| :--- | :--- | :--- | :--- |
| Trip1 | 14-APR-13 | 370 | 0.2 |
| Trip2 | 14-APR-13 | 570 | 0.333333 |
| Trip3 | 14-APR-13 | 250 | 0.333333 |
| Trip4 | 15-JUL-13 | 450 | 0.25 |
| Trip5 | 15-JUL-13 | 175 | 0.5 |

- **`1.0/count(*)` not `1/count(*)`** ➔ integer division would floor every weight to $0$; the $1.0$ forces the numeric type.
- **Inner join drops empty trips** ➔ a trip with no row in $\text{Destination}$ never appears, so it silently loses its weight; check for one before trusting the row count ➔ [[Data Exploration (Warehouse Validation)]].
- **Then use it:** total cost per store $=$ $\sum(\text{cost} \times w)$ across the bridge.
```sql
Select S.StoreId, S.StoreName,
   sum(Total_delivery_Cost * Weight_Factor) as "Total Cost for Store"
from
  TruckFact2 F, TripDim2 T,
  StoreDim2 S, BridgeTableDim2 B
where F.TripId = T.TripId
and   T.TripId = B.TripId
and   B.StoreId = S.StoreId
group by S.StoreId, S.StoreName
order by S.StoreId, S.StoreName;
```

### Model 3 — add the list aggregate
```sql
Create Table TripDim3 As
Select T.TripID, T.TripDate, T.TotalKm, 1.0/count(D.StoreID) As WeightFactor,
   LISTAGG (D.StoreID, '_') Within Group (Order By D.StoreID) As StoreGroupList
From Trip T, Destination D
Where T.TripID = D.TripID
Group By T.TripID, T.TripDate, T.TotalKm;
```
**Expected output:**

| TRIPID | TRIPDATE | TOTALKM | WEIGHTFACTOR | STOREGROUPLIST |
| :--- | :--- | :--- | :--- | :--- |
| Trip1 | 14-APR-13 | 370 | 0.2 | M1_M2_M3_M4_M8 |
| Trip2 | 14-APR-13 | 570 | 0.333333 | M1_M2_M4 |
| Trip3 | 14-APR-13 | 250 | 0.333333 | M1_M5_M6 |
| Trip4 | 15-JUL-13 | 450 | 0.25 | M5_M6_M7_M8 |
| Trip5 | 15-JUL-13 | 175 | 0.5 | M3_M7 |

- **Syntax** ➔ `LISTAGG(attr1, '_') Within Group (Order By attr1) As columnname`; append `Desc` inside `Order By` to reverse the list.
- **`Within Group` is mandatory** ➔ `LISTAGG` is an ordered-set aggregate, so the sort key is declared separately from the `group by`.

### Joining with vs without $\text{StoreGroupList}$
```sql
-- With StoreGroupList: two tables, a LIKE against the concatenated list
select *
from TripDim3 T, StoreDim3 S
where T.StoreGroupList like '%'||S.StoreID||'%';

-- Without StoreGroupList: three tables, an equi-join through the bridge
select *
from TripDim3 T, BridgeTable3 B, StoreDim3 S
where T.TripID = B.TripID
and B.StoreID = S.StoreID;
```
- **Trade** ➔ the list version is visually appealing and needs **one join fewer**; it is redundant storage and the `LIKE` cannot use an index.

## ✍️ Practice
> [!QUESTION]- Practice 1: before creating $\text{TripDim2}$, display each trip's ID, date, kilometres and **number of stores**. Then convert the count to the weight.
> > [!SUCCESS]- Reference solution
> > ```sql
> > select t.tripid, t.tripdate, t.totalkm, count(*)
> > from trip t, destination d
> > where t.tripid = d.tripid
> > group by t.tripid, t.tripdate, t.totalkm;
> > -- then replace count(*) with 1.0/count(*)
> > ```
> > - **Key move:** experiment with `select` first and only wrap it in `Create Table … As` once the numbers are right — verify by counting each trip's stores by hand and dividing $1$ by that number.

> [!QUESTION]- Practice 2: the Product Sales warehouse must keep supplier names but **not** the supply history. Write the bridge.
> > [!SUCCESS]- Reference solution
> > ```sql
> > create table ProductSupplierBridge as
> > select distinct SS.ProductNo, S.Name as SupplierName
> > from StockSupplier SS, Supplier S
> > where SS.SupplierID = S.SupplierID;
> > ```
> > - **Key move:** dropping $\text{SupplyDate}$, $\text{Location}$ and $\text{QtySupplied}$ collapses the supply history, so `distinct` is now required — and with $\text{SupplierName}$ absorbed there is no $\text{SupplierDIM}$ left to build ➔ [[Bridge Tables]].

## ⚠️ Common Mistakes
- 💡 **`1/count(*)`** ➔ integer division returns $0$ for every trip with more than one store; write `1.0/count(*)`.
- 💡 **Grouping $\text{TripDim2}$ on the bridge instead of $\text{Destination}$** ➔ the bridge is a copy, so it works here, but the pattern is "aggregate from the **operational** source" ➔ [[Building Fact Tables]].
- 💡 **Omitting `Within Group` from `LISTAGG`** ➔ Oracle rejects the call; the ordering clause is part of the function, not optional decoration.
- 💡 **Forgetting the join condition in a comma-list `from`** ➔ Cartesian product, quota blown, account locked ➔ [[SQL Joins (ANSI)]].
