---
unit: FIT3003
week: 7
source: [lecture, slides]
domain: C
parent: "[[Star Schema]]"
tags: [CS/Databases, DataScience/DataWarehousing]
aliases: [Multi-Fact, Multiple Fact Tables, Different Subject Multi-Fact, Different Granularity Multi-Fact]
---
# [[Multi-Fact Star Schemas]]

**Context:** [[FIT3003_MOC]] · one schema, several fact tables — the answer when one fact cannot legally hold every measure ➔ [[Star Schema]], [[Building Fact Tables]], [[Combining Star Schemas]]
**Parent Framework:** [[Star Schema]]

> [!abstract] Quick Revision
> - **🎯 Objective:** a warehouse is **Subject-Oriented** ➔ one star schema focuses on **one subject only**; a second fact table is created for exactly two reasons — a **different subject** or a **different granularity**.
> - **📦 Core Components:** **different subject** ➔ Book Sales vs Review — the applicable dimension sets differ | **different granularity** ➔ Car Service — Service grain vs Part grain.
> - **⚡ Key Constraint:** the **dimensions identify the subject, not the unit of measure** — kilometres, litres and dollars measured against the same three dimensions are ONE fact with three measures, never three facts.

## 📝 How It Works
### 1. When a second fact is justified
- **Four warehouse features** ➔ Integrated · **Subject-Oriented** · Time-Variant · Non-Volatile; the second one is what forces the rule.
- **Two causes only** ➔ (i) **different subject**, (ii) **different granularity**; a measure being in different units is not a cause.
- **Dimensions are shared, not duplicated** ➔ both facts hang off the same $\text{DIM}$ tables wherever they apply; only the *set* of applicable dimensions differs.

### 2. The subject test — the measure $\times$ dimension applicability grid (Book Sales)
- **Method** ➔ cross every candidate fact measure with every candidate dimension and ask whether the pairing answers a **sensible business question**; a measure that fails a dimension cannot sit in that dimension's fact.
- **Where `Num_of_Reviews` fails** ➔ Store (a star rating belongs to the book, not the shop that sold it) and Time (the recorded date is the **purchase** date, not the review date — read off the E/R diagram, not assumed).
- **The split** ➔ $\text{BookSalesFACT}(\underline{\text{StoreID}^{*}, \text{CategoryID}^{*}, \text{TimeID}^{*}, \text{StarID}^{*}}, \text{Num\_of\_Books}, \text{Total\_Sales})$ and $\text{ReviewFACT}(\underline{\text{CategoryID}^{*}, \text{StarID}^{*}}, \text{Num\_of\_Reviews})$, sharing $\text{CategoryDIM}$ and $\text{StarRatingDIM}$.
- **One rating per book** ➔ a book receives many reviews, so `StarID` in the *sales* fact is the book's **rounded average** rating banded into the star dimension, not an individual review.

### 3. Different granularity — Car Service
- **Star-1, Service grain** ➔ $\text{CarServiceFACT}_1(\underline{\text{TimeID}^{*}, \text{BrandName}^{*}, \text{ServiceNo}^{*}, \text{MechanicID}^{*}}, \text{Total\_Service\_Cost}, \text{Number\_of\_Services})$; $\text{PartDIM}$ reaches it only through a [[Bridge Tables|ServiceBridge]].
- **Star-2, Part grain** ➔ $\text{CarServiceFACT}_2(\underline{\text{TimeID}^{*}, \text{BrandName}^{*}, \text{PartNo}^{*}, \text{MechanicID}^{*}}, \text{Number\_of\_Services})$ — finer detail, the bridge disappears, `PartNo` enters the key.
- **`PartDIM` must be a [[Determinant Dimensions|determinant dimension]]** ➔ one part serves many services, so a query that omits `PartNo` double-counts `Number_of_Services`; the star draws it **dashed**.
- **`Total_Service_Cost` cannot follow** ➔ cost is recorded per *service*, and the E/R diagram gives no per-part cost, so the finer fact carries the count measure only.

## ⚙️ Core Implementation
### 🔹 Book Sales — the four dimensions
> [!code]- copy · project-and-derive · hand-build
> ```sql
> create table CategoryDim as select * from Category;
> create table StoreDim    as select * from Store;
>
> create table TimeDim as
> select distinct to_char(SalesDate, 'YYYYMM') as TimeID,
>        to_char(SalesDate, 'MM') as Month,
>        to_char(SalesDate, 'YYYY') as Year
> from   Sales;
>
> create table StarRatingDim (StarID number(1), StarDescription varchar2(15));
> insert into StarRatingDim values (0, 'Unknown');   -- 1 Poor / 2 Not Good / 3 Average
> insert into StarRatingDim values (5, 'Excellent'); -- 4 Good
> ```
> 💡 **Common Mistake:** **Deriving `StarRatingDim` from `Review`** ➔ it is hand-built precisely so that books with **no review** still have a member ($0 =$ `Unknown`) to point at ➔ [[Building Dimension Tables]].

### 🔹 The small fact is the easy one
> [!code]- `ReviewFACT` — a plain `count` over the join
> ```sql
> create table ReviewFact as
> select B.CategoryID, R.Stars as StarID, count(*) as Num_of_Reviews
> from   Book B, Review R
> where  B.ISBN = R.ISBN
> group by B.CategoryID, R.Stars;
> ```

### 🔹 The large fact needs one star rating per book first
> [!code]- outer join ➔ `nvl` ➔ `round(avg(...))` ➔ aggregate
> ```sql
> create table TempBookWithStar as              -- keep books that have NO review
> select B.ISBN, B.CategoryID, nvl(R.Stars, 0) as Stars
> from   Book B, Review R
> where  B.ISBN = R.ISBN(+);                    -- ANSI: Book B left outer join Review R on ...
>
> create table TempBookWithAvgStar as           -- collapse many reviews to ONE rating
> select ISBN, CategoryID, round(avg(Stars)) as Avg_Stars
> from   TempBookWithStar
> group by ISBN, CategoryID;
>
> create table BookSalesFact as                 -- now the book joins the sales lines once
> select T.CategoryID, to_char(S.SalesDate, 'YYYYMM') as TimeID,
>        S.StoreID, T.Avg_Stars as StarID,
>        sum(D.Quantity) as Num_of_Books, sum(D.TotalPrice) as Total_Sales
> from   TempBookWithAvgStar T, Sales S, SalesDetails D
> where  T.ISBN = D.ISBN and S.SalesID = D.SalesID
> group by T.CategoryID, to_char(S.SalesDate, 'YYYYMM'), S.StoreID, T.Avg_Stars;
> ```
> 💡 **Common Mistake:** **Joining `Book` straight to `Review` inside the sales fact** ➔ a book with $4$ reviews appears $4$ times, so `Num_of_Books` is inflated $4\times$; the two temp tables exist to force **one row per book** before the sales join ➔ [[Data Exploration (Warehouse Validation)]].
> 💡 **Common Mistake:** **Inner-joining `Book` and `Review`** ➔ silently deletes every unreviewed book from the sales figures; `(+)` $+$ `nvl(R.Stars, 0)` is what preserves them.

### 🔹 Removing a dimension by pivoting the small fact
> [!code]- `ReviewFACT2` — zero columns from the dimension, then a correlated `update`
> ```sql
> create table ReviewFact2 as                   -- grid = one row per category, zeroed
> select CategoryID, 0 as Num_of_0Star_Reviews, 0 as Num_of_1Star_Reviews,
>        0 as Num_of_2Star_Reviews, 0 as Num_of_3Star_Reviews,
>        0 as Num_of_4Star_Reviews, 0 as Num_of_5Star_Reviews
> from   CategoryDim;
>
> update ReviewFact2 F2 set
>   Num_of_1Star_Reviews = nvl((select Num_of_Reviews from ReviewFact F1
>     where F2.CategoryID = F1.CategoryID and F1.StarID = 1), 0),
>   Num_of_5Star_Reviews = nvl((select Num_of_Reviews from ReviewFact F1
>     where F2.CategoryID = F1.CategoryID and F1.StarID = 5), 0);
> ```
> 💡 **Common Mistake:** **Dropping the `nvl`** ➔ a category with no $3$-star review returns NULL from the subquery and overwrites the initialised $0$ with NULL ➔ [[Pivoted Fact Tables]].

## ⚖️ Core Decision Matrix
| Situation | Dimension sets | Correct shape | Why |
| :--- | :--- | :--- | :--- |
| Book Sales vs Reviews | $\{S,T,C,R\}$ vs $\{C,R\}$ | **two facts** | a measure is meaningless against a dimension it does not apply to |
| Private Taxi: km, fuel, income | $\{Car, Driver, Week\}$ for all three | **one fact, three measures** | identical dimension sets $\Rightarrow$ one subject; units of measure are irrelevant |
| Car Service: service vs part | $\{T,B,\text{Service},M\}$ vs $\{T,B,\text{Part},M\}$ | **two facts** | different granularity; the finer fact needs a determinant `PartDIM` |
| Same dimensions, same measures, different periods | identical | **one fact via `union`** | union-compatible ➔ [[Combining Star Schemas]] |

> [!NOTE] **When It Flips:** three separate facts collapse into one the moment their dimension lists are found to be identical — the Private Taxi three-fact draft is *unreasonable*, not merely inefficient.

## 📊 Exam Execution Trace & Applied Exercises

### Manual Execution Trace — the Book Sales applicability grid
| Dimension | `Total_Sales` | `Num_of_Books` | `Num_of_Reviews` | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| $\text{StoreDIM}$ | ✅ sales per store | ✅ books sold per store | ❌ ratings attach to books, not shops | sales fact only |
| $\text{TimeDIM}$ | ✅ sales per month | ✅ books per month | ❌ the stored date is the purchase date | sales fact only |
| $\text{CategoryDIM}$ | ✅ | ✅ | ✅ reviews per category | **both facts** |
| $\text{StarRatingDIM}$ | ✅ sales of $5$-star books | ✅ | ✅ $5$-star reviews per category | **both facts** |

- **Reading the grid** ➔ the rows with a ❌ are what split the schema; the two all-✅ dimensions are the **shared** ones and are physically created once.

### Applied Exercise — is this one subject or three?
**Problem:** the Private Taxi warehouse has $\text{CarDIM}$, $\text{DriverDIM}$, $\text{WeekDIM}$ and the measures Total Kilometres, Total Fuel Used, Total Income. A draft proposes one fact per measure. Decide, then write the merge.
$$
\begin{aligned}
\text{dims}(F_1) = \text{dims}(F_2) = \text{dims}(F_3) &= \{\text{CarNo}, \text{DriverNo}, \text{WeekNo}\} \\
\Rightarrow \text{subject}(F_1) = \text{subject}(F_2) &= \text{subject}(F_3) \\
\Rightarrow \text{merge by joining on the full key} &: 3 \text{ facts} \Rightarrow 3-1 = 2 \text{ conditions per key column}
\end{aligned}
$$
```sql
create table PrivateTaxiFact as
select F1.CarNo, F1.WeekNo, F1.DriverNo,
       F1.Total_Kilometers, F2.Total_Fuel_Used, F3.Total_Income
from   PrivateTaxiFact1 F1, PrivateTaxiFact2 F2, PrivateTaxiFact3 F3
where  F1.CarNo = F2.CarNo and F1.CarNo = F3.CarNo
and    F1.WeekNo = F2.WeekNo and F1.WeekNo = F3.WeekNo
and    F1.DriverNo = F2.DriverNo and F1.DriverNo = F3.DriverNo;
```
**Final Extracted Output:** one fact, three measures — $\text{PrivateTaxiFACT}(\underline{\text{CarNo}^{*}, \text{DriverNo}^{*}, \text{WeekNo}^{*}}, \text{Total\_Kilometers}, \text{Total\_Fuel\_Used}, \text{Total\_Income})$; splitting it again later is a [[Slicing a Fact|vertical slice]], not a modelling decision.

## ⚠️ Common Mistakes
- 💡 **Using the unit of measure as the subject test** ➔ "distance, volume and money are three subjects" is the trap the Private Taxi case is built to catch; only the **dimension set** identifies the subject.
- 💡 **Reading applicability off intuition instead of the E/R diagram** ➔ "reviews per month" sounds sensible and is wrong, because the operational schema stores no review date.
- 💡 **Carrying every measure down to the finer fact** ➔ `Total_Service_Cost` at Part grain has no defensible value; a measure only descends if the source can attribute it at that grain.

## 🧠 Active Recall
> [!FAQ]- Two candidate facts share every dimension but measure different things. Combine or keep separate — and what settles it?
> > [!SUCCESS]- Answer
> > - **Short answer:** combine — identical dimension sets mean identical subject, so it is **one fact with multiple measures**.
> > - **Why:** **Subject-orientation is defined by the analysis axes** ➔ the dimensions are the questions the business asks; measures answering the same questions belong together. **The unit of measure is a decoy** ➔ km, litres and dollars differ in scale, not in subject. **The merge is mechanical** ➔ join the facts on the full composite key, $k$ facts needing $k-1$ conditions per key column.

> [!FAQ]- Why does the Part-grain car-service fact need a determinant dimension when the Service-grain fact does not?
> > [!SUCCESS]- Answer
> > - **Short answer:** because one part is used by many services, so `Number_of_Services` is only correct while `PartNo` is pinned in the query.
> > - **Why:** **Finer grain re-uses the coarser measure** ➔ the same service is recorded once per part it consumed, so summing over parts counts it repeatedly. **The double count is silent** ➔ a query grouping only on Brand and Month runs cleanly and returns an inflated integer. **Hence the dashed box** ➔ `PartDIM` must appear in the `where` or the `group by` of every retrieval ➔ [[Determinant Dimensions]].
