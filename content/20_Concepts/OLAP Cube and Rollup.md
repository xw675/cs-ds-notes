---
unit: FIT3003
week: 9
source: [lecture, slides]
domain: C
parent: "[[OLAP (On-Line Analytical Processing)]]"
tags: [CS/Databases, DataScience/DataWarehousing, Tool/SQL]
aliases: [GROUP BY CUBE, GROUP BY ROLLUP, Cube, Rollup, Partial Cube, Partial Rollup, GROUPING function, Subtotals, Cross-tabulation]
type: pattern
---
# [[OLAP Cube and Rollup]]

**Context:** [[FIT3003_MOC]] · one query that returns detail rows **and** their subtotals and grand total · family map in [[OLAP (On-Line Analytical Processing)]]
**Problem it solves:** a cross-tab report (product $\times$ location with row, column and grand totals) without writing and `union`-ing one `group by` per total.

> [!abstract] Quick Revision
> - **🎯 Trigger:** "with subtotals", "and the grand total", "cross-tabulation" ➔ `group by cube (…)` for **every** combination, `group by rollup (…)` for the drill path from most detailed to grand total only.
> - **⚡ Key Constraint:** count the **grouping sets** before running ➔ `cube` of $n$ columns gives $2^n$ sets; `rollup` gives $n+1$, dropping columns **right-to-left**, so `rollup (A, B)` $\neq$ `rollup (B, A)`.

## 🔧 Minimal Working Example
```sql
select   ProductName, Location, sum(Total_Sales) as Total_Sales
from     SalesFact S, ProductDim P, LocationDim D
where    S.ProductID  = P.ProductID
and      S.LocationID = D.LocationID
and      S.LocationID in ('MEL', 'PER')
and      ProductName  in ('Clothing', 'Shoes')
group by cube (ProductName, Location)
order by ProductName, Location;
```
**Expected output** — $9$ rows $= 2 \times 2$ detail $+ 2 + 2 + 1$:

| ProductName | Location | Total_Sales | grouping set |
| :--- | :--- | ---: | :--- |
| Clothing | Melbourne | 1477348 | $(P, L)$ |
| Clothing | Perth | 861268 | $(P, L)$ |
| Clothing | (null) | 2338616 | $(P)$ — product subtotal |
| Shoes | Melbourne | 1311316 | $(P, L)$ |
| Shoes | Perth | 897153 | $(P, L)$ |
| Shoes | (null) | 2208469 | $(P)$ — product subtotal |
| (null) | Melbourne | 2788664 | $(L)$ — **cube only** |
| (null) | Perth | 1758421 | $(L)$ — **cube only** |
| (null) | (null) | 4547085 | $()$ — grand total |

- **`(null)` means "all"** ➔ a null in a dimension column marks that column as aggregated away in this row; ascending `order by` sorts nulls **last**, so each subtotal lands under its detail rows.
- **Swap `cube` ➔ `rollup`** ➔ the same query returns $7$ rows: the two $(L)$ rows vanish, leaving product subtotals $+$ grand total.
- **Cross-tab reading** ➔ the $(P, L)$ rows are the grid cells, $(P)$ the row totals, $(L)$ the column totals, $()$ the corner.

## 🔀 Variations
### Cube vs rollup vs partial — row-count arithmetic
*(Chapter 19 example: $2$ products $\times$ $2$ locations $\times$ $2$ TimeIDs `'201801'`, `'201901'`)*

| `group by` clause | grouping sets | rows |
| :--- | :--- | :--- |
| `cube (P, L, T)` | all $2^3 = 8$: $(P,L,T), (P,L), (P,T), (L,T), (P), (L), (T), ()$ | $8+4+4+4+2+2+2+1 = 27$ |
| `rollup (P, L, T)` | $3 + 1 = 4$: $(P,L,T), (P,L), (P), ()$ | $8+4+2+1 = 15$ |
| `P, cube (L, T)` — partial cube | $P$ glued onto each set of `cube (L, T)`: $(P,L,T), (P,L), (P,T), (P)$ | $8+4+4+2 = 18$ |
| `P, rollup (L, T)` — partial rollup | $(P,L,T), (P,L), (P)$ | $8+4+2 = 14$ |

- **Rows per set** ➔ $\prod$ of the distinct-value counts of the columns kept; the empty set $()$ is always one row.
- **Cube $\supseteq$ rollup** ➔ every rollup set is also a cube set; the slide strikes $12$ rows out of the $27$-row cube to leave exactly the $15$-row rollup.
- **Partial = no grand total** ➔ the column outside the parentheses is never rolled up, so every row keeps a real `ProductName` and no row is all-null.

### Labelling the subtotal rows — `grouping` $+$ `decode`
```sql
select decode(grouping(ProductName), 1, 'All Products',  ProductName) as Product_Name,
       decode(grouping(Location),    1, 'All Locations', Location)    as Location_Name,
       sum(Total_Sales) as Total_Sales
from   SalesFact S, ProductDim P, LocationDim D
where  S.ProductID  = P.ProductID
and    S.LocationID = D.LocationID
and    S.LocationID in ('MEL', 'PER')
and    ProductName  in ('Clothing', 'Shoes')
group by cube (ProductName, Location)
order by ProductName, Location;
```
- **`grouping(col)`** ➔ binary: $1$ when `col` is rolled up in this row, $0$ when it holds a real group value; on `cube (P, L)` the pair reads $(0,0)$ detail · $(0,1)$ product subtotal · $(1,0)$ location subtotal · $(1,1)$ grand total.
- **`decode(a, b, c, d)`** ➔ if $a = b$ then $c$ else $d$ ➔ `(null)` becomes `'All Products'` / `'All Locations'`, the rest pass through.
- **Distinct aliases** ➔ `Location_Name` keeps `order by Location` pointing at the raw column, so the subtotal rows still sort last.

> [!NOTE] 🔭 Beyond the lecture *(not in the slides)* ➔ `grouping` is what separates a subtotal's null from a **genuine** NULL value stored in a dimension column; `is null` cannot tell the two apart.

## ✍️ Practice
> [!QUESTION]- Practice 1: For the 2-product, 2-location data above, how many rows does `group by rollup (Location, ProductName)` return, and which rows does it contain that `rollup (ProductName, Location)` lacks?
> > [!SUCCESS]- Reference solution
> > $$
> > \begin{aligned}
> > \text{sets} &= (L, P),\ (L),\ () \\
> > \text{rows} &= 4 + 2 + 1 = 7
> > \end{aligned}
> > $$
> > - **Key move:** rollup drops the **rightmost** column first ➔ it now returns the per-**location** subtotals (Melbourne $2788664$, Perth $1758421$) instead of the per-product ones; same count, different rows.

> [!QUESTION]- Practice 2: 2019 total sales per location and month for MEL and PER, with a subtotal per location and a grand total, labelled `'All Months'` / `'All Locations'`. How many rows?
> > [!SUCCESS]- Reference solution
> > ```sql
> > select decode(grouping(Location), 1, 'All Locations', Location) as Location_Name,
> >        decode(grouping(Month),    1, 'All Months',    Month)    as Month_Name,
> >        sum(Total_Sales) as Total_Sales
> > from   SalesFact S, LocationDim D, TimeDim T
> > where  S.LocationID = D.LocationID
> > and    S.TimeID     = T.TimeID
> > and    S.LocationID in ('MEL', 'PER')
> > and    Year = 2019
> > group by rollup (Location, Month)
> > order by Location, Month;
> > ```
> > - **Key move:** "subtotal per location" names the drill path Location $\rightarrow$ Month $\rightarrow$ all ➔ `rollup`, Location first; rows $= 2 \times 12 + 2 + 1 = 27$. `cube` would add $12$ unwanted per-month-across-locations rows.

> [!QUESTION]- Practice 3: Give each product its own subtotal block (per location, then per product) but **no** grand total, over the 3-column example. Clause and row count?
> > [!SUCCESS]- Reference solution
> > ```sql
> > group by ProductName, rollup (Location, TimeID)
> > ```
> > - **Key move:** partial rollup ➔ sets $(P,L,T), (P,L), (P)$ ➔ $8 + 4 + 2 = 14$ rows; `ProductName` outside the parentheses is never nulled.

## ⚠️ Common Mistakes
- 💡 **Unqualified `LocationID`** ➔ the slide's `decode` example writes `and LocationID in (…)` with both `SalesFact` and `LocationDim` in `from` ➔ ORA-00918 column ambiguously defined; write `S.LocationID`.
- 💡 **Reading `(null)` as missing data** ➔ in a cube/rollup result it means "all values of this column"; label it with `decode(grouping(…))` before it reaches a report.
- 💡 **Reaching for `cube` by default** ➔ $2^n$ grows fast and fills a hierarchy report with meaningless cross-combinations; a drill path (Year $\rightarrow$ Month, Product $\rightarrow$ Location) is `rollup`.
