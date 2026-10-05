---
unit: FIT3003
week: 9
source: [lecture, slides]
domain: [C, G]
parent: "[[Data Warehouse]]"
tags: [CS/Databases, DataScience/DataWarehousing, DataScience/Visualisation]
aliases: [OLAP, OLAP Queries, Drill Down, BI Reporting, Business Intelligence Reporting]
---
# [[OLAP (On-Line Analytical Processing)]]

**Context:** [[FIT3003_MOC]] · the read path of the [[Data Warehouse]] — Chapter 19's query families and the BI report each one feeds ➔ [[OLAP Cube and Rollup]], [[OLAP Ranking and Top-N]], [[OLAP Cumulative and Moving Aggregates]], [[Power BI]]
**Parent Framework:** [[Data Warehouse]]

> [!abstract] Quick Revision
> - **🎯 Objective:** OLAP = data processing by **complex queries built on `group by` + aggregate operators** ➔ pick the query family from the report's shape (cross-tab, ranking, running total, drill-down).
> - **⚡ Key Constraint:** **OLAP retrieves, BI presents** ➔ the query's only job is to pull the right numbers out of the warehouse; formatting, percentages and charts belong to the BI reporting tool.

## 📝 Core
- **The chain** ➔ Operational DB $\rightarrow$ Data Warehouse $\rightarrow$ OLAP $\rightarrow$ Business Intelligence; OLAP exists because the warehouse must summarise very large record sets "on the fly".
- **Chapter 19 schema** ➔ every example runs on $\text{SalesFact}(\text{TimeID}^*, \text{LocationID}^*, \text{ProductID}^*, \text{Total\_Sales})$ with `TimeDim(TimeID, Month, Year)`, `LocationDim(LocationID, Location)`, `ProductDim(ProductID, ProductName)`; `TimeID` is the string `'YYYYMM'`.
- **Drill down** ➔ add one more dimension attribute to both `select` and `group by`: `group by S.TimeID` $\rightarrow$ `group by S.TimeID, ProductName` splits each month's bar into per-product stacks; remove it to roll back up.
- **Ratio report** ➔ the SQL is a plain `sum(Total_Sales) … group by Location`; the share of total (Sydney $31.34\%$) is computed by the BI chart, never queried or stored.
- **Window functions run after `group by`** ➔ ranking and cumulative clauses sit in the `select` list and take an aggregate as input ➔ hence `rank() over (order by sum(Total_Sales))` and the nested `sum(sum(Total_Sales)) over (…)`; they are illegal in the same query's `where`.

## ⚖️ Core Decision Matrix
| Report asks for | Clause | Result shape | Chapter's BI visual |
| :--- | :--- | :--- | :--- |
| a total per category | `sum(…) group by` | one row per group | bar, or pie for a ratio |
| totals **plus** subtotals and grand total | `group by cube / rollup` ➔ [[OLAP Cube and Rollup]] | detail rows $+$ `(null)`-marked subtotal rows | cross-tab table |
| top / bottom performers | `rank() over`, Top-N inline view ➔ [[OLAP Ranking and Top-N]] | rank column beside each group | sorted bar |
| trend so far / smoothed trend | `rows unbounded preceding` · `rows n preceding` ➔ [[OLAP Cumulative and Moving Aggregates]] | running column beside each period | bars per month $+$ line |
| the detail inside one total | drill down: extra `group by` attribute | one row per (period, product) | stacked bar |

> [!NOTE] **When It Flips:** a plain `group by` answers one level of detail; the moment the report needs **two levels in one table** (detail and its total) switch to `cube`/`rollup`, and the moment it needs a value **relative to other rows** (position, running sum) switch to a window function.

## ⚠️ Common Mistakes
- 💡 **Drilling down in `select` only** ➔ adding `ProductName` beside `sum(…)` without adding it to `group by` raises ORA-00979.
- 💡 **Formatting inside the OLAP query** ➔ `to_char(…, '999,999,999')` turns the measure into a string; fine for display, useless as input to a chart or a further aggregate.

## 🧠 Active Recall
> [!FAQ]- A manager wants each location's share of 2019 sales as a pie. What does the OLAP query return, and where does the percentage come from?
> > [!SUCCESS]- Answer
> > - **Short answer:** four rows of `Location, sum(Total_Sales)`; the BI tool divides each by the total.
> > - **Why:** **OLAP retrieves, BI presents** ➔ `select Location, sum(Total_Sales) … where Year = 2019 group by Location`; the pie's $\frac{2828318}{9024489} = 31.34\%$ is chart arithmetic.

> [!FAQ]- How are drill down and `rollup` opposite moves on the same `group by`?
> > [!SUCCESS]- Answer
> > - **Short answer:** drill down **adds** a grouping attribute (finer rows); `rollup` **removes** attributes right-to-left inside one query (coarser subtotal rows).
> > - **Why:** **Granularity of the result** ➔ each attribute in `group by` multiplies the rows by its distinct-value count; drill down raises that product, `rollup(A, B)` appends the $(A)$ and $()$ groupings beneath $(A, B)$.
