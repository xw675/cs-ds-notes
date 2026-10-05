---
unit: FIT3003
week: 9
source: [lecture, slides]
domain: C
parent: "[[OLAP (On-Line Analytical Processing)]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [Cumulative Aggregate, Moving Aggregate, Running Total, Moving Average, ROWS UNBOUNDED PRECEDING, ROWS n PRECEDING]
type: pattern
---
# [[OLAP Cumulative and Moving Aggregates]]

**Context:** [[FIT3003_MOC]] · a value computed from the current row **and the rows before it** in the query result · family map in [[OLAP (On-Line Analytical Processing)]]
**Problem it solves:** year-to-date running totals and $n$-month moving averages beside each period's own total, in one query.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "cumulative", "year to date", "running total" ➔ `sum(sum(m)) over (order by … rows unbounded preceding)`; "moving / rolling average over $k$ periods" ➔ `avg(sum(m)) over (order by … rows k-1 preceding)`.
> - **⚡ Key Constraint:** the window counts **rows of the query result**, not months ➔ `rows 2 preceding` is a 3-month average only when the `over` is ordered by time and no month is missing; the first rows average over fewer values.

## 🔧 Minimal Working Example
```sql
select S.TimeID,
       sum(Total_Sales) as Total_Sales,
       sum(sum(Total_Sales)) over (order by S.TimeID rows unbounded preceding) as Cumulative,
       avg(sum(Total_Sales)) over (order by S.TimeID rows 2 preceding)         as Avg_3_Months
from   SalesFact S, TimeDim T
where  S.TimeID = T.TimeID
and    Year = 2019
and    LocationID in ('MEL')
group by S.TimeID
order by S.TimeID;
```
- **Nested aggregate** ➔ inner `sum(Total_Sales)` is the per-month `group by` total; the outer `sum(…) over` / `avg(…) over` runs across those monthly rows afterwards.
- **`rows unbounded preceding`** ➔ window $=$ first row of the result $\dots$ current row.
- **`rows n preceding`** ➔ window $=$ the $n$ rows behind the current one $+$ the current row, i.e. $n+1$ rows.

**Expected output** — MEL 2019 *(two slide typos corrected: April is $237913$, the value the slide's own cumulative implies, not the printed $237193$; September's cumulative is $2155927$, not $2115927$)*:

| TimeID | Total_Sales | Cumulative | Avg_3_Months | window averaged |
| :--- | ---: | ---: | ---: | :--- |
| 201901 | 243,080 | 243,080 | 243,080 | Jan only |
| 201902 | 259,353 | 502,433 | 251,217 | Jan–Feb ($2$ rows) |
| 201903 | 246,368 | 748,801 | 249,600 | Jan–Mar |
| 201904 | 237,913 | 986,714 | 247,878 | Feb–Apr |
| 201905 | 234,513 | 1,221,227 | 239,598 | Mar–May |
| 201906 | 235,630 | 1,456,857 | 236,019 | Apr–Jun |
| 201907 | 251,330 | 1,708,187 | 240,491 | May–Jul |
| 201908 | 239,575 | 1,947,762 | 242,178 | Jun–Aug |
| 201909 | 208,165 | 2,155,927 | 233,023 | Jul–Sep |
| 201910 | 228,710 | 2,384,637 | 225,483 | Aug–Oct |
| 201911 | 207,694 | 2,592,331 | 214,856 | Sep–Nov |
| 201912 | 235,987 | 2,828,318 | 224,130 | Oct–Dec |

$$
\begin{aligned}
\text{Cumulative}_{\text{Mar}} &= 243080 + 259353 + 246368 = 748801 \\
\text{Avg}_{\text{Apr}} &= \tfrac{259353 + 246368 + 237913}{3} = 247878
\end{aligned}
$$

## 🔀 Variations
### Restart per group — `partition by`
```sql
select LocationID, S.TimeID,
       to_char(sum(Total_Sales), '999,999,999') as Total_Sales,
       to_char(sum(sum(Total_Sales)) over
                 (partition by LocationID
                  order by LocationID, S.TimeID
                  rows unbounded preceding), '999,999,999') as Cumulative
from   SalesFact S, TimeDim T
where  S.TimeID = T.TimeID
and    Year = 2019
and    LocationID in ('MEL', 'PER')
group by LocationID, S.TimeID
order by LocationID, S.TimeID;
```
- **Reset** ➔ without `partition by`, PER's January would continue from MEL's $2828318$; with it, row 13 restarts at PER's own $150456$ and ends at $1802706$.
- **`to_char(…, '999,999,999')`** ➔ display-only comma formatting; the column becomes a string.

## ✍️ Practice
> [!QUESTION]- Practice 1: Year-to-date 2019 sales for each product in MEL, restarting for every product.
> > [!SUCCESS]- Reference solution
> > ```sql
> > select ProductName, S.TimeID,
> >        sum(Total_Sales) as Total_Sales,
> >        sum(sum(Total_Sales)) over (partition by ProductName
> >                                    order by S.TimeID
> >                                    rows unbounded preceding) as YTD_Sales
> > from   SalesFact S, ProductDim P, TimeDim T
> > where  S.ProductID = P.ProductID
> > and    S.TimeID    = T.TimeID
> > and    Year = 2019
> > and    S.LocationID = 'MEL'
> > group by ProductName, S.TimeID
> > order by ProductName, S.TimeID;
> > ```
> > - **Key move:** "for every product" ➔ `partition by ProductName`; `order by S.TimeID` inside `over` makes it year-**to-date**.

> [!QUESTION]- Practice 2: Change the MWE to a 6-month moving average. What does December average over, and what does March?
> > [!SUCCESS]- Reference solution
> > ```sql
> > avg(sum(Total_Sales)) over (order by S.TimeID rows 5 preceding) as Avg_6_Months
> > ```
> > - **Key move:** $k$ periods ➔ `rows k-1 preceding`; December averages Jul–Dec, March only Jan–Mar ($3$ rows), because the window cannot reach before the first row.

> [!QUESTION]- Practice 3: MEL has no sales row for 201906. What does `Avg_3_Months` on 201907 average over?
> > [!SUCCESS]- Reference solution
> > - **Answer:** April, May and July ➔ the three result rows ending at July, spanning **four** calendar months.
> > - **Key move:** `rows n preceding` counts result records, not time — a gap silently stretches the window.

## ⚠️ Common Mistakes
- 💡 **Slide 47's `group by Location, TimeID`** ➔ `Location` is not in the `from` list (ORA-00904) and `TimeID` exists in both `SalesFact` and `TimeDim` (ORA-00918); group on `LocationID, S.TimeID`, exactly what is selected.
- 💡 **`sum(Total_Sales) over (…)` without the inner `sum`** ➔ in a grouped query the raw `Total_Sales` is not a group expression (ORA-00979); the window must wrap the aggregate.
- 💡 **Relying on `over`'s order for display** ➔ the `order by` inside `over` fixes the window, not the output; add an outer `order by` or the running column can print out of sequence.
