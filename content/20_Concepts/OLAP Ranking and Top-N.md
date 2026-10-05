---
unit: FIT3003
week: 9
source: [lecture, slides]
domain: C
parent: "[[OLAP (On-Line Analytical Processing)]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [RANK, DENSE_RANK, ROW_NUMBER, PERCENT_RANK, PARTITION BY, Top-N, Top-Percent, Ranking]
type: pattern
---
# [[OLAP Ranking and Top-N]]

**Context:** [[FIT3003_MOC]] · the most common BI reporting operation after cube/rollup · family map in [[OLAP (On-Line Analytical Processing)]] · replaces W7's `rownum` top-N in [[Multi-Fact Star Schemas]] when ties matter
**Problem it solves:** rank groups by an aggregated measure — overall, within each partition, or cut to the top $N$ / top percent.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "rank", "top 3", "best month for each product", "top 10%" ➔ `rank() over (order by sum(m) desc)`; add `partition by` for "for each"; wrap in an inline view to keep only the top.
> - **⚡ Key Constraint:** the ranking column is computed **after** `where` and `group by` ➔ its alias does not exist in `where`, so Top-N is always `select * from ( … ) where Rank <= N`.

## 🔧 Minimal Working Example
```sql
select ProductName,
       sum(Total_Sales) as Total_Sales,
       rank()       over (order by sum(Total_Sales) desc) as Sales_Rank,
       dense_rank() over (order by sum(Total_Sales) desc) as Dense_Rank,
       row_number() over (order by sum(Total_Sales) desc) as Row_Number
from   SalesFact S, ProductDim P, TimeDim T
where  S.ProductID  = P.ProductID
and    S.TimeID     = T.TimeID
and    S.LocationID = 'MEL'
and    Year = 2019
group by ProductName
order by Sales_Rank;
```
**Expected output** — the `dense_rank` slide's data, where Shoes and Cosmetics tie on $645881$ *(the `rank` column is derived; the slide's `rank` example has no tie)*:

| ProductName | Total_Sales | `rank` | `dense_rank` | `row_number` |
| :--- | ---: | :---: | :---: | :---: |
| Clothing | 715423 | 1 | 1 | 1 |
| Shoes | 645881 | 2 | 2 | 2 |
| Cosmetics | 645881 | 2 | 2 | 3 |
| Kids & Baby | 477949 | **4** | **3** | 4 |
| Accessories | 355433 | 5 | 4 | 5 |

- **`rank`** ➔ ties share a rank, then the sequence **skips** ($1, 2, 2, 4$).
- **`dense_rank`** ➔ ties share a rank, **no gap** ($1, 2, 2, 3$).
- **`row_number`** ➔ never ties: $1 \dots n$ from the `order by` inside `over`; tied rows are numbered in arbitrary order.
- **`desc` inside `over` decides who is $1$** ➔ the slide runs `rank() over (order by sum(Total_Sales))` (Accessories $= 1$) and the `desc` version (Clothing $= 1$) side by side; the outer `order by` only sorts the display.

## 🔀 Variations
### Top-N — nested query
```sql
select * from
  (select ProductName, sum(Total_Sales) as Total_Sales,
          rank() over (order by sum(Total_Sales) desc) as Product_Rank
   from   SalesFact S, TimeDim T, ProductDim P
   where  S.TimeID    = T.TimeID
   and    S.ProductID = P.ProductID
   and    Year = 2019
   group by ProductName)
where Product_Rank <= 2;
```
**Expected output:** Clothing $715423$ (1), Shoes $645881$ (2).
- **Ties pick the function** ➔ on the tie data, `<= 2` returns $3$ rows under `rank` or `dense_rank` (both $645881$s kept) but exactly $2$ under `row_number`, which drops one tied product arbitrarily; W7's `rownum` idiom behaves like `row_number`.

### Top-percent — `percent_rank`
- **Value** ➔ $\text{percent\_rank} = \dfrac{\text{rank} - 1}{n - 1} \in [0, 1]$; the slide's ascending run gives Accessories $0$, Kids & Baby $0.25$, Cosmetics $0.5$, Shoes $0.75$, Clothing $1$ for $n = 5$.
- **Top $p$** ➔ order `desc` inside `over` and keep `Percent_Rank <= p` in the outer query — the same inline-view wrapper as Top-N.

### Rank within groups — `partition by`
```sql
select ProductName, TimeID, sum(Total_Sales) as Total_Sales,
       rank() over (partition by ProductName order by sum(Total_Sales) desc) as Rank_by_Product,
       rank() over (partition by TimeID      order by sum(Total_Sales) desc) as Rank_by_Time
from   SalesFact S, ProductDim P
where  S.ProductID = P.ProductID
and    TimeID in ('201901', '201902', '201903')
and    P.ProductName in ('Clothing', 'Shoes')
group by ProductName, TimeID
order by ProductName, Rank_by_Product;
```
**Expected output:**

| ProductName | TimeID | Total_Sales | Rank_by_Product | Rank_by_Time |
| :--- | :--- | ---: | :---: | :---: |
| Clothing | 201902 | 224253 | 1 | 1 |
| Clothing | 201901 | 207673 | 2 | 1 |
| Clothing | 201903 | 170238 | 3 | 2 |
| Shoes | 201902 | 182786 | 1 | 2 |
| Shoes | 201903 | 177432 | 2 | 1 |
| Shoes | 201901 | 167820 | 3 | 2 |

- **Partition $=$ a separate "sheet"** ➔ numbering restarts at $1$ in each partition: $2$ product sheets ranked $1$–$3$, $3$ month sheets ranked $1$–$2$.
- **Independent `over` clauses** ➔ two partitionings coexist in one query; each only sees its own rows.

## ✍️ Practice
> [!QUESTION]- Practice 1: The top 3 locations by 2019 total sales, ties kept.
> > [!SUCCESS]- Reference solution
> > ```sql
> > select * from
> >   (select Location, sum(Total_Sales) as Total_Sales,
> >           rank() over (order by sum(Total_Sales) desc) as Location_Rank
> >    from   SalesFact S, LocationDim L, TimeDim T
> >    where  S.LocationID = L.LocationID
> >    and    S.TimeID     = T.TimeID
> >    and    Year = 2019
> >    group by Location)
> > where Location_Rank <= 3;
> > ```
> > - **Key move:** "ties kept" rules out `row_number`/`rownum`; the filter sits **outside** the inline view.

> [!QUESTION]- Practice 2: The best month of Q1 2019 for each product (Clothing, Shoes).
> > [!SUCCESS]- Reference solution
> > ```sql
> > select * from
> >   (select ProductName, TimeID, sum(Total_Sales) as Total_Sales,
> >           rank() over (partition by ProductName order by sum(Total_Sales) desc) as Month_Rank
> >    from   SalesFact S, ProductDim P
> >    where  S.ProductID = P.ProductID
> >    and    TimeID in ('201901', '201902', '201903')
> >    and    P.ProductName in ('Clothing', 'Shoes')
> >    group by ProductName, TimeID)
> > where Month_Rank = 1;
> > ```
> > - **Key move:** "for each product" ➔ `partition by ProductName`; result: Clothing 201902 ($224253$), Shoes 201902 ($182786$).

> [!QUESTION]- Practice 3: On the tie data, which of `rank`, `dense_rank`, `row_number` makes `<= 3` return exactly 3 rows, and which returns 4?
> > [!SUCCESS]- Reference solution
> > - **`rank`** ➔ ranks $1, 2, 2, 4, 5$ ➔ $3$ rows. **`row_number`** ➔ $1, 2, 3, 4, 5$ ➔ $3$ rows.
> > - **`dense_rank`** ➔ $1, 2, 2, 3, 4$ ➔ **$4$ rows** (Kids & Baby climbs to $3$ because no gap is left).
> > - **Key move:** only `dense_rank`'s no-gap rule can push the cut past $N$ distinct groups.

## ⚠️ Common Mistakes
- 💡 **`where Product_Rank <= 2` in the same query** ➔ the alias is not computed yet (ORA-00904) and a window function is illegal in `where` ➔ always the inline-view wrapper.
- 💡 **Raw column inside `over` of a grouped query** ➔ `over (order by Total_Sales)` names the ungrouped column ➔ ORA-00979; order by the aggregate, `sum(Total_Sales)`.
- 💡 **Slide alias `Rank_by Time_ID`** ➔ the space is a syntax error; use `Rank_by_Time`.
